Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC3DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D356620657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UaUakFx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387853AbfAPQiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:38:22 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44124 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfAPQiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:38:21 -0500
Received: by mail-io1-f65.google.com with SMTP id r200so5347212iod.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aw7SMHMnPqACN0JYoK3M/SLleLaf04fF+v2hJTrtoHE=;
        b=UaUakFx5gqaSbrpdOLa6udXUharOrxOY7UHu9QEPWvH95hWdIRRHb/EHIbPadequ7P
         ZhdHCX/LdSV4uAGVzUAmApUzMAOektE/GNe4rrkDj0ay1N/7J35f1tmSuPfzIi6OEm/x
         Qn/NCKwc7yKR3yNkDdbpYFGCTxDAdVpa6n5Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aw7SMHMnPqACN0JYoK3M/SLleLaf04fF+v2hJTrtoHE=;
        b=qyOcdXOdx4me19d27VHyWE5s0KHHoUg3IFjGGzO/bBa4zKmebbN8VCP/ZsiemuHJnT
         YhxbM/wLY1z6qaRhJurSXvriGOkD3I6oBA8RcOFzulBN8l+DRaB8DzEXk7YhdJjag8y4
         pUmVfDUnmCtazi9HwPs6Bx31trOJlrlHodNhD9YBkOF2Cw+PIdW29PQIF/paEv1jcnnZ
         GIO+B+nKyhL7IbtWHO+EWIse29gxoM13Uz6HKVWqD633eckI1qrpt8Im4ixiaDUBf9x1
         uSxH3KQ4LB7xMmtZdnQssW87fBtizUee2ZptYA5saiF1ASfTny0jK2GLQkMPYiXOt01h
         kr7g==
X-Gm-Message-State: AJcUukeDlDg4KpzGU7Ck7L5BdLbRIrL5XiOzAfp/0RupD4ionSzGQweI
        edwfBLWZ6jEoKAEYGgd/HlzU5M3xjFhUdVnpfBpJ0Q==
X-Google-Smtp-Source: ALg8bN6nxikNx/HgyJPJg+kCnA6CU64ScHRba41/4N82PYAbrr2hwxzvItAOIVbe20g87mMGl+fAngIIU8AdnSpvulE=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr5333331iom.11.1547656700507;
 Wed, 16 Jan 2019 08:38:20 -0800 (PST)
MIME-Version: 1.0
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-3-mathieu.poirier@linaro.org> <20190116153948.GC871@kroah.com>
 <CANLsYkzfbJae6Nk7cHhnR09ZPSATa3g8sceGC=O3DfXYC2ruQQ@mail.gmail.com> <20190116163314.GB5446@kroah.com>
In-Reply-To: <20190116163314.GB5446@kroah.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 16 Jan 2019 09:38:09 -0700
Message-ID: <CANLsYkw_=_OC-95HRMxTZfpAe4UzAuidPJcZmL_T-LbkOwWCkQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] coresight: perf: Add "sinks" group to PMU directory
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ast@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 at 09:33, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 16, 2019 at 09:14:33AM -0700, Mathieu Poirier wrote:
> > On Wed, 16 Jan 2019 at 08:39, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jan 15, 2019 at 04:07:37PM -0700, Mathieu Poirier wrote:
> > > > Add a "sinks" directory entry so that users can see all the sinks
> > > > available in the system in a single place.  Individual sink are added
> > > > as they are registered with the coresight bus.
> > > >
> > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > ---
> > > >  .../hwtracing/coresight/coresight-etm-perf.c  | 43 +++++++++++++++++++
> > > >  .../hwtracing/coresight/coresight-etm-perf.h  |  1 +
> > > >  drivers/hwtracing/coresight/coresight.c       | 17 ++++++++
> > > >  3 files changed, 61 insertions(+)
> > > >
> > > > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > > index f21eb28b6782..292bd409a68c 100644
> > > > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > > @@ -14,6 +14,7 @@
> > > >  #include <linux/perf_event.h>
> > > >  #include <linux/percpu-defs.h>
> > > >  #include <linux/slab.h>
> > > > +#include <linux/stringhash.h>
> > > >  #include <linux/types.h>
> > > >  #include <linux/workqueue.h>
> > > >
> > > > @@ -43,8 +44,18 @@ static const struct attribute_group etm_pmu_format_group = {
> > > >       .attrs  = etm_config_formats_attr,
> > > >  };
> > > >
> > > > +static struct attribute *etm_config_sinks_attr[] = {
> > > > +     NULL,
> > > > +};
> > > > +
> > > > +static const struct attribute_group etm_pmu_sinks_group = {
> > > > +     .name   = "sinks",
> > > > +     .attrs  = etm_config_sinks_attr,
> > > > +};
> > > > +
> > > >  static const struct attribute_group *etm_pmu_attr_groups[] = {
> > > >       &etm_pmu_format_group,
> > > > +     &etm_pmu_sinks_group,
> > > >       NULL,
> > > >  };
> > > >
> > > > @@ -479,6 +490,38 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
> > > >       return 0;
> > > >  }
> > > >
> > > > +static ssize_t etm_perf_sink_name_show(struct device *dev,
> > > > +                                    struct device_attribute *dattr,
> > > > +                                    char *buf)
> > > > +{
> > > > +     /* See function coresight_sink_by_id() to know where this is used */
> > > > +     u32 hash = hashlen_hash(hashlen_string(NULL, dattr->attr.name));
> > > > +
> > > > +     return scnprintf(buf, PAGE_SIZE, "%x\n", hash);
> > > > +}
> > > > +
> > > > +int etm_perf_symlink_sink(struct coresight_device *csdev)
> > > > +{
> > > > +     struct device *pmu_dev = etm_pmu.dev;
> > > > +     struct device *pdev = csdev->dev.parent;
> > > > +     struct device_attribute *dev_attr;
> > > > +
> > > > +     if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> > > > +         csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> > > > +             return -EINVAL;
> > > > +
> > > > +     if (!etm_perf_up)
> > > > +             return -EPROBE_DEFER;
> > > > +
> > > > +     dev_attr = kzalloc(sizeof(*dev_attr), GFP_KERNEL);
> > > > +     dev_attr->attr.name = kstrdup(dev_name(pdev), GFP_KERNEL);
> > > > +     dev_attr->attr.mode = 0444;
> > > > +     dev_attr->show = etm_perf_sink_name_show;
> > > > +
> > > > +     return sysfs_add_file_to_group(&pmu_dev->kobj,
> > > > +                                    &dev_attr->attr, "sinks");
> > >
> > > What is so odd about this call that you needed me to review this?
> >
> > As far as I can tell nobody is feeding a dynamic struct attribute to
> > the function and I wasn't sure if it was because they were told not to
> > or simply because it wasn't needed, hence asking for a second opinion.
>
> Ah.  Well, again, this is a good question to answer:
>
> > > And what happens if this call fails, do you leak memory?

That's something I will fix in the next revision.

>
> And also, what happens when you unload the device, who frees the
> attribute's memory?

If configured, coresight devices aren't removable.

Thanks for the review,
Mathieu

>
> thanks,
>
> greg k-h

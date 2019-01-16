Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F9FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E15720675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XUI5mNrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfAPQOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:14:46 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34904 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbfAPQOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:14:45 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so3455622itp.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KEi5tILKPLZ/2R3NAZK8W85biZ8ITep+crOK/DgNkq4=;
        b=XUI5mNrHEYJjIRjf0UtvI42TLm3d3yWkDLxiO0AB35yNFFeADBZE7l/mvF4owHBPTd
         v7TYgNOrNVMBpzq1amGnP6N2906rhRMbyoRzw8TubDk2Kh4MOP7k9vw2uzOhk/Zx+31X
         5LNIX8amy+Txdp+Q9Et87ZgaG7KngWG/KSj1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEi5tILKPLZ/2R3NAZK8W85biZ8ITep+crOK/DgNkq4=;
        b=Vqy9ok880Uu0UWfCnX/fgraRWOz4mRsUE+9pNLYWAY65iv+oBXAVuQ3MWnp9T1AvTt
         3bMJSz4nCRDumyz6BrBWkha+PgRx91GF2HAWxKs/l6wrdpL8MFW6/IBbI7/9xbHnowZC
         I+TzF/gaWugkV+K2+C4Zvz/qAwVpoUqb7FkK89eAxWcqN2QECch7A1Ompdt/iC2m7S3n
         q36KUu/qpnhbm27ggn9MgFhJyOIVl+omjYtt50K9V2I3nE710552pbnYBzuMeNCNEnx7
         ACny/VJMMZAoqC1J6HuPK7KRtXgTa4FfGCaVVrYRmdOAHHH2SQlzm/LPyKqGcM+cqRjt
         Re9A==
X-Gm-Message-State: AJcUukerdjGpqQMHntdJHo5apTGIia//j6a+M3s1kCyQIJYxRRs53pAx
        57YfMYBmeOc8O2Ij4NnGCkB7zgWnBFzUsbjIZ+gUhQ==
X-Google-Smtp-Source: ALg8bN6nkaEOFt0VS2q1o5mQBPcPAAcTfIGHTXqgZ57Vn9ebDdfKVBQA0a/469fsdK+RVUJHEBXMPsHv567BgYhUZoo=
X-Received: by 2002:a24:db02:: with SMTP id c2mr6297220itg.137.1547655283699;
 Wed, 16 Jan 2019 08:14:43 -0800 (PST)
MIME-Version: 1.0
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-3-mathieu.poirier@linaro.org> <20190116153948.GC871@kroah.com>
In-Reply-To: <20190116153948.GC871@kroah.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 16 Jan 2019 09:14:33 -0700
Message-ID: <CANLsYkzfbJae6Nk7cHhnR09ZPSATa3g8sceGC=O3DfXYC2ruQQ@mail.gmail.com>
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

On Wed, 16 Jan 2019 at 08:39, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 15, 2019 at 04:07:37PM -0700, Mathieu Poirier wrote:
> > Add a "sinks" directory entry so that users can see all the sinks
> > available in the system in a single place.  Individual sink are added
> > as they are registered with the coresight bus.
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  .../hwtracing/coresight/coresight-etm-perf.c  | 43 +++++++++++++++++++
> >  .../hwtracing/coresight/coresight-etm-perf.h  |  1 +
> >  drivers/hwtracing/coresight/coresight.c       | 17 ++++++++
> >  3 files changed, 61 insertions(+)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index f21eb28b6782..292bd409a68c 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/perf_event.h>
> >  #include <linux/percpu-defs.h>
> >  #include <linux/slab.h>
> > +#include <linux/stringhash.h>
> >  #include <linux/types.h>
> >  #include <linux/workqueue.h>
> >
> > @@ -43,8 +44,18 @@ static const struct attribute_group etm_pmu_format_group = {
> >       .attrs  = etm_config_formats_attr,
> >  };
> >
> > +static struct attribute *etm_config_sinks_attr[] = {
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group etm_pmu_sinks_group = {
> > +     .name   = "sinks",
> > +     .attrs  = etm_config_sinks_attr,
> > +};
> > +
> >  static const struct attribute_group *etm_pmu_attr_groups[] = {
> >       &etm_pmu_format_group,
> > +     &etm_pmu_sinks_group,
> >       NULL,
> >  };
> >
> > @@ -479,6 +490,38 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
> >       return 0;
> >  }
> >
> > +static ssize_t etm_perf_sink_name_show(struct device *dev,
> > +                                    struct device_attribute *dattr,
> > +                                    char *buf)
> > +{
> > +     /* See function coresight_sink_by_id() to know where this is used */
> > +     u32 hash = hashlen_hash(hashlen_string(NULL, dattr->attr.name));
> > +
> > +     return scnprintf(buf, PAGE_SIZE, "%x\n", hash);
> > +}
> > +
> > +int etm_perf_symlink_sink(struct coresight_device *csdev)
> > +{
> > +     struct device *pmu_dev = etm_pmu.dev;
> > +     struct device *pdev = csdev->dev.parent;
> > +     struct device_attribute *dev_attr;
> > +
> > +     if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> > +         csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> > +             return -EINVAL;
> > +
> > +     if (!etm_perf_up)
> > +             return -EPROBE_DEFER;
> > +
> > +     dev_attr = kzalloc(sizeof(*dev_attr), GFP_KERNEL);
> > +     dev_attr->attr.name = kstrdup(dev_name(pdev), GFP_KERNEL);
> > +     dev_attr->attr.mode = 0444;
> > +     dev_attr->show = etm_perf_sink_name_show;
> > +
> > +     return sysfs_add_file_to_group(&pmu_dev->kobj,
> > +                                    &dev_attr->attr, "sinks");
>
> What is so odd about this call that you needed me to review this?

As far as I can tell nobody is feeding a dynamic struct attribute to
the function and I wasn't sure if it was because they were told not to
or simply because it wasn't needed, hence asking for a second opinion.

>
> And what happens if this call fails, do you leak memory?
>
> thanks,
>
> greg k-h

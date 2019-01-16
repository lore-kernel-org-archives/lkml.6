Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60EAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994EB20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Myq5jeuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfAPRa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:30:29 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38223 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfAPRa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:30:28 -0500
Received: by mail-it1-f196.google.com with SMTP id h65so3812651ith.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ljv1GR361GBRKYIkB7jsE2in05byxJjM9Of4H3Lyf7A=;
        b=Myq5jeuQiJRYN2ReKgBqC+F4WGXNyGRFDymPLmULSfQs2QRfD5K5Ahb63Z4mhTyh17
         MpMjhQcqZG6hctg9oIL/rLUg29Xp1ba+aUzYzHmQv1/+g7orOEOrG19xW6nYHMEgpPEm
         J9EtBEv+x9wwEmBh8HQLRPHDaOeuSgyXrNhJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ljv1GR361GBRKYIkB7jsE2in05byxJjM9Of4H3Lyf7A=;
        b=KJ1wApqhU5+7XnPnsXgoxByzw25J0MY1jfI5HnqZZ5TzsgCB539HFovYtAjt2w05uh
         /r9NH1edsKbrnQp7vBhhiunDODfgFWJAReo5x2Z4pBoeJvDzugLESFWLmWoBhNrf4hCz
         wx6RMz3oH+JJe1VDnvHgbd3FW2WAplR4up9v3oWWFEJ0X7/0Seafu9PhT7ErtXOLisjW
         /9vuxjZ0ghIcVLnNgtpNZLXLYfbZRsNhXL6IBNp49QFzpyC720SvjDYiD7z8Gim15WKv
         dTkQP0V5JdUisi3r9pY5XwEppanDSs8ETEl2pLX00nSQayMN8G0Ks3Ni4M6WJE5QuV6C
         1UpQ==
X-Gm-Message-State: AJcUukck/dORv4+cZd0lDsymSoQjkmHNPBs3Oc61fFLeqSp+smkhIgJa
        wilQrJWaxjMXawqtNE4hbgk+EidZ88srU8aZEdIMdQ==
X-Google-Smtp-Source: ALg8bN5ovBywmS2CY3P6+MGnjtlKbf7GdYn/0jnI7YCqLKMeYq51k91Eh0XXDHFIbC9usy4KjWsgWtsp6K1xpI+fWbM=
X-Received: by 2002:a02:1b1d:: with SMTP id l29mr5818176jad.98.1547659826972;
 Wed, 16 Jan 2019 09:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-3-mathieu.poirier@linaro.org> <20190116153948.GC871@kroah.com>
 <CANLsYkzfbJae6Nk7cHhnR09ZPSATa3g8sceGC=O3DfXYC2ruQQ@mail.gmail.com>
 <20190116163314.GB5446@kroah.com> <CANLsYkw_=_OC-95HRMxTZfpAe4UzAuidPJcZmL_T-LbkOwWCkQ@mail.gmail.com>
 <20190116171259.GB10164@kroah.com>
In-Reply-To: <20190116171259.GB10164@kroah.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 16 Jan 2019 10:30:16 -0700
Message-ID: <CANLsYkyFJx9gSfkMNmxT=bdas=sKFpZ0Cad42gm6nHoyq8FfnA@mail.gmail.com>
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

On Wed, 16 Jan 2019 at 10:13, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 16, 2019 at 09:38:09AM -0700, Mathieu Poirier wrote:
> > On Wed, 16 Jan 2019 at 09:33, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Jan 16, 2019 at 09:14:33AM -0700, Mathieu Poirier wrote:
> > > > On Wed, 16 Jan 2019 at 08:39, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Tue, Jan 15, 2019 at 04:07:37PM -0700, Mathieu Poirier wrote:
> > > > > > Add a "sinks" directory entry so that users can see all the sinks
> > > > > > available in the system in a single place.  Individual sink are added
> > > > > > as they are registered with the coresight bus.
> > > > > >
> > > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > > ---
> > > > > >  .../hwtracing/coresight/coresight-etm-perf.c  | 43 +++++++++++++++++++
> > > > > >  .../hwtracing/coresight/coresight-etm-perf.h  |  1 +
> > > > > >  drivers/hwtracing/coresight/coresight.c       | 17 ++++++++
> > > > > >  3 files changed, 61 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > > > > index f21eb28b6782..292bd409a68c 100644
> > > > > > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > > > > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > > > > @@ -14,6 +14,7 @@
> > > > > >  #include <linux/perf_event.h>
> > > > > >  #include <linux/percpu-defs.h>
> > > > > >  #include <linux/slab.h>
> > > > > > +#include <linux/stringhash.h>
> > > > > >  #include <linux/types.h>
> > > > > >  #include <linux/workqueue.h>
> > > > > >
> > > > > > @@ -43,8 +44,18 @@ static const struct attribute_group etm_pmu_format_group = {
> > > > > >       .attrs  = etm_config_formats_attr,
> > > > > >  };
> > > > > >
> > > > > > +static struct attribute *etm_config_sinks_attr[] = {
> > > > > > +     NULL,
> > > > > > +};
> > > > > > +
> > > > > > +static const struct attribute_group etm_pmu_sinks_group = {
> > > > > > +     .name   = "sinks",
> > > > > > +     .attrs  = etm_config_sinks_attr,
> > > > > > +};
> > > > > > +
> > > > > >  static const struct attribute_group *etm_pmu_attr_groups[] = {
> > > > > >       &etm_pmu_format_group,
> > > > > > +     &etm_pmu_sinks_group,
> > > > > >       NULL,
> > > > > >  };
> > > > > >
> > > > > > @@ -479,6 +490,38 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
> > > > > >       return 0;
> > > > > >  }
> > > > > >
> > > > > > +static ssize_t etm_perf_sink_name_show(struct device *dev,
> > > > > > +                                    struct device_attribute *dattr,
> > > > > > +                                    char *buf)
> > > > > > +{
> > > > > > +     /* See function coresight_sink_by_id() to know where this is used */
> > > > > > +     u32 hash = hashlen_hash(hashlen_string(NULL, dattr->attr.name));
> > > > > > +
> > > > > > +     return scnprintf(buf, PAGE_SIZE, "%x\n", hash);
> > > > > > +}
> > > > > > +
> > > > > > +int etm_perf_symlink_sink(struct coresight_device *csdev)
> > > > > > +{
> > > > > > +     struct device *pmu_dev = etm_pmu.dev;
> > > > > > +     struct device *pdev = csdev->dev.parent;
> > > > > > +     struct device_attribute *dev_attr;
> > > > > > +
> > > > > > +     if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> > > > > > +         csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> > > > > > +             return -EINVAL;
> > > > > > +
> > > > > > +     if (!etm_perf_up)
> > > > > > +             return -EPROBE_DEFER;
> > > > > > +
> > > > > > +     dev_attr = kzalloc(sizeof(*dev_attr), GFP_KERNEL);
> > > > > > +     dev_attr->attr.name = kstrdup(dev_name(pdev), GFP_KERNEL);
> > > > > > +     dev_attr->attr.mode = 0444;
> > > > > > +     dev_attr->show = etm_perf_sink_name_show;
> > > > > > +
> > > > > > +     return sysfs_add_file_to_group(&pmu_dev->kobj,
> > > > > > +                                    &dev_attr->attr, "sinks");
> > > > >
> > > > > What is so odd about this call that you needed me to review this?
> > > >
> > > > As far as I can tell nobody is feeding a dynamic struct attribute to
> > > > the function and I wasn't sure if it was because they were told not to
> > > > or simply because it wasn't needed, hence asking for a second opinion.
> > >
> > > Ah.  Well, again, this is a good question to answer:
> > >
> > > > > And what happens if this call fails, do you leak memory?
> >
> > That's something I will fix in the next revision.
> >
> > >
> > > And also, what happens when you unload the device, who frees the
> > > attribute's memory?
> >
> > If configured, coresight devices aren't removable.
>
> But is the driver able to be unloaded?  Unbound from the device manually
> through sysfs?  There's lots of ways devices are "removed" that don't
> involved physical removal :)

All drivers are built-in and thus preventing them from being unloaded.
They also have their ".suppress_bin_attrs" field set to take care of
unbinding through sysfs.

>
> thanks,
>
> greg k-h

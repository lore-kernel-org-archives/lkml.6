Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA029C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F79E21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jf8ILxd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfA3XuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:50:13 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36191 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfA3XuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:50:13 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so1221108itj.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 15:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eeCGb6riKdWLVIY3FURYkrJACPpyX06f4aiSqee50zQ=;
        b=Jf8ILxd8hoAS2ldZ37koBtmnb7Rc1S8AMSep4Atzb44gE7dx0c8HP1y7FjKu3IF+bA
         YBvx8pu3DVRkUASitJfi/OnVLazT/qi3vnCqjD5SIlVh55OiNIpolnY1p12YmTGX7m8z
         6abWzDUQy4ildJoxsgOXaCx6RTw6TS02oqUEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eeCGb6riKdWLVIY3FURYkrJACPpyX06f4aiSqee50zQ=;
        b=DKrzf+ip3/StRIkD2QJRpkOsENg5kAjQmbhlX95sqpNd9BEE73oBM6+NhC4RGajPmK
         dPgwkefoHqfiusYllgqJIvLb6wJbgdUe58nk6Hj2LpKA9iMfEujSyioxsMt23oHEZGpR
         Xq68erhYOr2gpJyM3N9Pj2GsBqqEozUU4RXVFgE1FUwsxhyf6JYBnriM3Mv7R/LGf1VA
         FYvJPi8P4YxccmPk4hRPL75vV7pM/i6XCRDfW6pqw+j34Y0ilPxb0ggtL+h5vKsJ0C9z
         B+Z1iWavPDGQMSlm+PZTGZWb06eyiigbpeMdiv0b3UW6DECrUC8roqtUcFH4P9eBXmzA
         NDyA==
X-Gm-Message-State: AJcUukemLsvwzhnJZOV0Tyx833iFB9hpWxoJBsSRq14RTR3h/3bffCgO
        meeW6XRwmMFKKfa9Pl6Q+07jxXMgPiRlC+GjIC+xtQ==
X-Google-Smtp-Source: ALg8bN4GTt3lix21NVO+SQUsxcyivQoLK0d38KwdGtfJW8ff5+Gxw5v4BSPp77qDQUgTP5lyZPeaOF700yxk+0BQuf0=
X-Received: by 2002:a24:db02:: with SMTP id c2mr18037253itg.137.1548892211768;
 Wed, 30 Jan 2019 15:50:11 -0800 (PST)
MIME-Version: 1.0
References: <20190122181144.26645-1-mathieu.poirier@linaro.org>
 <20190122181144.26645-3-mathieu.poirier@linaro.org> <aed8011b-5487-a30a-559f-e0daf2867f67@arm.com>
In-Reply-To: <aed8011b-5487-a30a-559f-e0daf2867f67@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 30 Jan 2019 16:50:00 -0700
Message-ID: <CANLsYkyG=r-8bXFDzQg9Agw3j2W4bwAB2oOyoYB+qbZ2TaAXLw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] coresight: perf: Add "sinks" group to PMU directory
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ast@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 at 10:42, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Mathieu,
>
>
> On 01/22/2019 06:11 PM, Mathieu Poirier wrote:
> > Add a "sinks" directory entry so that users can see all the sinks
> > available in the system in a single place.  Individual sink are added
> > as they are registered with the coresight bus.
>
> A couple of minor comments.
>
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   .../hwtracing/coresight/coresight-etm-perf.c  | 76 +++++++++++++++++++
> >   .../hwtracing/coresight/coresight-etm-perf.h  |  6 +-
> >   drivers/hwtracing/coresight/coresight.c       | 18 +++++
> >   include/linux/coresight.h                     |  7 +-
> >   4 files changed, 104 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index f21eb28b6782..c68a0036532c 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -14,6 +14,7 @@
> >   #include <linux/perf_event.h>
> >   #include <linux/percpu-defs.h>
> >   #include <linux/slab.h>
> > +#include <linux/stringhash.h>
> >   #include <linux/types.h>
> >   #include <linux/workqueue.h>
> >
> > @@ -43,8 +44,18 @@ static const struct attribute_group etm_pmu_format_group = {
> >       .attrs  = etm_config_formats_attr,
> >   };
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
> >   static const struct attribute_group *etm_pmu_attr_groups[] = {
> >       &etm_pmu_format_group,
> > +     &etm_pmu_sinks_group,
> >       NULL,
> >   };
>
> I was thinking if this could be the "events" directory for ETM pmu. We
> don't have any other event codes. Even if we get in the future, we could
> expose them here. But from a quick try it looks like the event names
> cannot start with a number (e.g, 2007000.etr wouldn't parse as an event
> name). So we could leave this as above and switch when we get generic
> naming scheme.
>
> >
> > @@ -479,6 +490,71 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
> >       return 0;
> >   }
> >
> > +static ssize_t etm_perf_sink_name_show(struct device *dev,
> > +                                    struct device_attribute *dattr,
> > +                                    char *buf)
> > +{
> > +     /* See function coresight_get_sink_by_id() to know where this is used */
> > +     u32 hash = hashlen_hash(hashlen_string(NULL, dattr->attr.name));
> > +
> > +     return scnprintf(buf, PAGE_SIZE, "%x\n", hash);
> > +}
>
> You may need "0x%x" to avoid confusions interpreting the data.

Yes

>
> > +
> > +int etm_perf_add_symlink_sink(struct coresight_device *csdev)
> > +{
> > +     int ret;
> > +     struct device *pmu_dev = etm_pmu.dev;
> > +     struct device *pdev = csdev->dev.parent;
> > +     struct device_attribute *dattr;
>
> If we make this a struct dev_ext_attribute(), you get a space to
> store the "id" in the "var" field. This can be used for

Much easier - thanks for pointing this out.

>
> 1) name_show() above
>
> we could do :
>         struct dev_ext_attribute *eattr = container_of(attr,
>                                         struct dev_ext_attribute, attr);
>
>         return scnprintf(bu, PAGE_SIZE, "0x%x\n", (u32)eattr->var);a

Casting with a u32 will make the compiler complain because of the size
difference between the types but using a cast type with the same size
will do just fine.

>
> 2) Matching the ID of a sink device in lookup by simply doing :
>         (u32)csdev->dattr.var == (u32)(void *)data
>
> and can avoid computing the hash all the time.

Same comment as above but with the right cast it will work.

>
> > +
> > +     if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> > +         csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> > +             return -EINVAL;
> > +
> > +     if (csdev->dattr != NULL)
> > +             return -EINVAL;
> > +
> > +     if (!etm_perf_up)
> > +             return -EPROBE_DEFER;
> > +
> > +     dattr = kzalloc(sizeof(*dattr), GFP_KERNEL);
>
> nit: Could we use devm_kzalloc(pdev, ...) ?
>
> > +     dattr->attr.name = kstrdup(dev_name(pdev), GFP_KERNEL);.
>
>
> similarly here : devm_kstrdup()

Yes

>
> > +     dattr->attr.mode = 0444;
> > +     dattr->show = etm_perf_sink_name_show;
> > +     csdev->dattr = dattr;
> > +
> > +     ret = sysfs_add_file_to_group(&pmu_dev->kobj,
> > +                                   &dattr->attr, "sinks");
> > +
> > +     if (!ret)
> > +             return 0;
> > +
> > +     csdev->dattr = NULL;
> > +     kfree(dattr->attr.name);
> > +     kfree(dattr);
>
> And we could get rid of these ^
>
> > +
> > +     return ret;
> > +}
> > +
> > +void etm_perf_del_symlink_sink(struct coresight_device *csdev)
> > +{
> > +     struct device *pmu_dev = etm_pmu.dev;
> > +     struct device_attribute *dattr = csdev->dattr;
> > +
> > +     if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> > +         csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> > +             return;
> > +
> > +     if (!dattr)
> > +             return;
> > +
> > +     sysfs_remove_file_from_group(&pmu_dev->kobj,
> > +                                  &dattr->attr, "sinks");
> > +     csdev->dattr = NULL;
> > +     kfree(dattr->attr.name);
> > +     kfree(dattr);ext
>
> And these ^^
>
> > +}
>
>
> > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > index 46c67a764877..a42fac83eac9 100644
> > --- a/include/linux/coresight.h
> > +++ b/include/linux/coresight.h
> > @@ -154,8 +154,9 @@ struct coresight_connection {
> >    * @orphan: true if the component has connections that haven't been linked.
> >    * @enable: 'true' if component is currently part of an active path.
> >    * @activated:      'true' only if a _sink_ has been activated.  A sink can be
> > -             activated but not yet enabled.  Enabling for a _sink_
> > -             happens when a source has been selected for that it.
> > + *           activated but not yet enabled.  Enabling for a _sink_
> > + *           appens when a source has been selected for that it.
> > + * @dattr:   Device attribute for sink representation under PMU directory.
> >    */
> >   struct coresight_device {
> >       struct coresight_connection *conns;
> > @@ -168,7 +169,9 @@ struct coresight_device {
> >       atomic_t *refcnt;
> >       bool orphan;
> >       bool enable;    /* true only if configured as part of a path */
> > +     /* sink specific fields */
> >       bool activated; /* true only if a sink is part of a path */
> > +     struct device_attribute *dattr;
>
> See my comment above about switching to struct dev_ext_attribute *.
>
> Suzuki

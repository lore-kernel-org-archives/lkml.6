Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B054C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE6320834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE6320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeJENxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 09:53:16 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40774 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbeJENxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 09:53:16 -0400
Received: by mail-oi1-f194.google.com with SMTP id j68-v6so9573870oib.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 23:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDnToU5XwTdAfvQ13Mj4kyLLFuyvuD8B/YOA2r43mK8=;
        b=NBaz+kINFtxLPZOzhCgOqEShaWNmQPDko4jhYHV2P+DzTcByZSPNkpzswwp/M4+Gs9
         mw56+/FBk2OTw1qfDwRVK20t0FTYS9Z8tpGX52TAih8Oujzwnf22MR1/Qp52Yq7DYotR
         9LdWRkMfal52Mq/BCAwxP9an+D6cT+GftCcdBNWf+Js0O4ffl4f6KCWfrNIG5G31eJRP
         NeNEm4POEc+tfNt0IzLPs2mHQu+gJQajiFBaCqKzjYxlYUuDl5PS9Djf7AFFhWaJ4kCo
         YtQu7bzQeGtNu+93L8qAbCyPoqGvCENWiaWFrV8y/RidBkv+C1MDr7Kk+fKoc0AIjVsG
         uqyw==
X-Gm-Message-State: ABuFfojrY2nqLz6I8asonDMxwsNk61f4+451t/tzPJXTbFwfmI78d5ss
        o+ETR6hjv0ONQFucv1va7a+UJfm8mFaAj3Fqzro=
X-Google-Smtp-Source: ACcGV6216szBdy5jVxFWthIZvNGGLYUb0liRRbLk5zwrlmu20sF2/+3msMsUcBQ8GIXA1cvvTYPjjYgJ96+I7vS1J5A=
X-Received: by 2002:aca:c244:: with SMTP id s65-v6mr2833539oif.161.1538722557653;
 Thu, 04 Oct 2018 23:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181004143750.30880-1-jani.nikula@intel.com> <20181004143750.30880-2-jani.nikula@intel.com>
In-Reply-To: <20181004143750.30880-2-jani.nikula@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Oct 2018 08:55:46 +0200
Message-ID: <CAJZ5v0hj-F_A5C3SkeAF=1vZwejryLY3j2XzrDpxUPcDStc0aA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/i915/sysfs: make attrs arrays const
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 4:38 PM Jani Nikula <jani.nikula@intel.com> wrote:
>
> They don't need to be modified.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/gpu/drm/i915/i915_sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_sysfs.c b/drivers/gpu/drm/i915/i915_sysfs.c
> index e5e6f6bb2b05..b9aa8515254e 100644
> --- a/drivers/gpu/drm/i915/i915_sysfs.c
> +++ b/drivers/gpu/drm/i915/i915_sysfs.c
> @@ -483,7 +483,7 @@ static ssize_t gt_rp_mhz_show(struct device *kdev, struct device_attribute *attr
>         return snprintf(buf, PAGE_SIZE, "%d\n", val);
>  }
>
> -static const struct attribute *gen6_attrs[] = {
> +static const struct attribute * const gen6_attrs[] = {
>         &dev_attr_gt_act_freq_mhz.attr,
>         &dev_attr_gt_cur_freq_mhz.attr,
>         &dev_attr_gt_boost_freq_mhz.attr,
> @@ -495,7 +495,7 @@ static const struct attribute *gen6_attrs[] = {
>         NULL,
>  };
>
> -static const struct attribute *vlv_attrs[] = {
> +static const struct attribute * const vlv_attrs[] = {
>         &dev_attr_gt_act_freq_mhz.attr,
>         &dev_attr_gt_cur_freq_mhz.attr,
>         &dev_attr_gt_boost_freq_mhz.attr,
> --
> 2.11.0
>

Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31B5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1522146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtMj4gai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1522146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbeKVBTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:19:31 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:56296 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbeKVBTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:19:31 -0500
Received: by mail-it1-f196.google.com with SMTP id o19so9116514itg.5;
        Wed, 21 Nov 2018 06:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2HZP9/TTHedApZ4ruW6Afj2zQiJZkCmmPiZmzq3Gk+Y=;
        b=BtMj4gaiIAOTIugpz+RhskEkDYuhfmto9EpqQrd9waC+0MhZXiQ0MAq4cREnfz1frF
         e+p9Sxmp0Da91ajDXFA55ArYf9b4QFzat8ViULGkPl18o15FpCkcYnqWoC6VIhLWXh1u
         gzS0XWNgIsdVs1z/cgKphzbOGqzeky5d78zHHBSY0Rl+Gxzfto1w9PKXty9ys3B7n6n+
         5Iyh7wJl+34G5OEM/HKjyIiMmU2oQm+jaEkeWZnnB/i/hvq/xiSu2cgWDcT+PxrolVkn
         Mi7OdkY+qvDh1Pg9FhcMe0tFF4Vjhkr9s0YFbY1zHMkVfOYdkp630JAfkqfCcbFYI8o6
         JSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2HZP9/TTHedApZ4ruW6Afj2zQiJZkCmmPiZmzq3Gk+Y=;
        b=EkInrqKsFy9mHEPF7omVW+ugpEr9cCrx0EWXVFjKUNrbKgJ5B0aqGFeiE6BooLBe2L
         b5b3Ot10/6RrseadE/I97IwVoqwNAyLwKIQrF7mSQY2jGVU7x+ENtFmNNVsrIHVVWSvj
         PsfrdlZWIXs3ZU7710uSoRFoKSjXXsDh7TDCWeUdowyi11dCF+hjmyL77c+DfQG+CKGR
         DBzXXC0iwuBNEeI/T8+yc2QtnMx1P+wBIhHd3OnhfZwm7nmeZXns2vWbeCq3GQPJfy3H
         NERwUYovcq5rMRqzTV0tIyHx78z/Gc4kEb4gxaK/hwQUIWgEmECKJQGerYk1Ab58ztAl
         fmZA==
X-Gm-Message-State: AA+aEWYWgwcV9G9n4c+SZuvOwJO8O3lnNc/SfqTigqjjaHMkNt42kaii
        z1OYV43iVYXXsvJ5IYTODONc4nbxkvocD0xaiGKCm9p/NwU=
X-Google-Smtp-Source: AFSGD/XQVk07xMJ3KF+zr6k1HclzYRQ7gxKQqFEyEmjoS9FTAQnOtyzCbwIjSBW3w6ZyDEM9JPhLhIO30iWAfxMSn/Y=
X-Received: by 2002:a02:6c90:: with SMTP id w138mr5714861jab.60.1542811488304;
 Wed, 21 Nov 2018 06:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20181121124912.22074-1-tiny.windzz@gmail.com> <f38e8b29-d1db-f915-6699-aec9013bfe7e@nvidia.com>
 <0299646d-3f54-09fc-fea1-ddc9fbe5c8cc@nvidia.com>
In-Reply-To: <0299646d-3f54-09fc-fea1-ddc9fbe5c8cc@nvidia.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 21 Nov 2018 22:44:26 +0800
Message-ID: <CAEExFWsUhrjwwb1O3xgL-T-2Jd8Bt0HMWeTovHRZ_=TLX15Ssw@mail.gmail.com>
Subject: Re: [PATCH] soc/tegra: add of_node_put()
To:     jonathanh@nvidia.com
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 10:41 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 21/11/2018 13:31, Jon Hunter wrote:
> >
> > On 21/11/2018 12:49, Yangtao Li wrote:
> >> of_find_node_by_path() acquires a reference to the node
> >> returned by it and that reference needs to be dropped by its caller.
> >> bl_idle_init() doesn't do that, so fix it.
>
> The bl_idle_init() looks like a typo here.
Hi Jon:

Thanks. :-)

Yous,
    Yangtao
>
> >>
> >> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> >> ---
> >>  drivers/soc/tegra/common.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> >> index cd8f41351add..2e30604c9658 100644
> >> --- a/drivers/soc/tegra/common.c
> >> +++ b/drivers/soc/tegra/common.c
> >> @@ -23,10 +23,13 @@ static const struct of_device_id tegra_machine_match[] = {
> >>  bool soc_is_tegra(void)
> >>  {
> >>      struct device_node *root;
> >> +    bool rc;
> >>
> >>      root = of_find_node_by_path("/");
> >>      if (!root)
> >>              return false;
> >>
> >> -    return of_match_node(tegra_machine_match, root) != NULL;
> >> +    rc = of_match_node(tegra_machine_match, root) != NULL;
> >> +    of_node_put(root);
> >> +    return rc;
> >>  }
> >
> > Thanks for the fix, however, I think it would be even simpler just to
> > call of_machine_is_compatible() here instead.
>
> Right so I was wrong above about using of_machine_is_compatible, so with
> the typo above fixed ...
>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
>
> Cheers
> Jon
>
> --
> nvpublic

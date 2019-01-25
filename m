Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D3BC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B2B2184A
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abHSG7uN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfAYUvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:51:46 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:47001 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfAYUvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 15:51:46 -0500
Received: by mail-yb1-f196.google.com with SMTP id y7so4351797ybg.13;
        Fri, 25 Jan 2019 12:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xarLsaMOePht4Npx/t6WFQidEhH1kDifuH0w1OIQ5Cw=;
        b=abHSG7uN+fJ9Nvp39NbAPHUMxYiOYdLxOxc7ezT51IrsjUanM+Dr5d3C4SOLi1NH9L
         ygzw30E2evgIcxzdNJi8l8WO6O0wTfeS3uGBsTW40yThQpmhg4uje+1TFmPq0/uLyyuu
         h9vI3/c8pyhyNL9YBHRU7f/PCaQiEp+SksesbN0Rcq0A3GTOATuaEaY+g0d6Vdr1Jk0S
         CXjKeyoCtA1mm0AoltA4orMvTQfovGYrN+qvaeYXE0x7C8eoqJ3Tk5NZjNC+jZenQ7ga
         n1PfkBqTyU5o/z/6ulI7dOWI6DuSFFj/j1SmzghxA9qq9669suQsVc602s4H6tQa9Azh
         ienw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xarLsaMOePht4Npx/t6WFQidEhH1kDifuH0w1OIQ5Cw=;
        b=ZBXajwF4xfKF7Em79MPB5yLi5lkbgn2MNfi0NRplQwpDHxAXzI9BB64Y9pybhqKAnL
         XRmZxSZ3pQHFf7aUY2UZoejg78VW6E/l8UcU3zwwujVqsmYedOS4odqVFdlNF2h8+OXg
         s/M3VwqR2+7gbtAWvQQLGXkWtZj86W4TBnKaEGKvQYANmSHs8QKU7DOP457vzPCb0aEd
         Q7fShohxOr9xCUVMjfysxs6Vgi7CsF3Gl+Q2PPvQfJIELEzhPOuclBpHXfbNdNw9UFLI
         GmmtYshxsMXU69R+m//grUn/+0clcJ+7ONFXywXc2g0n806L1Wp0OkjFw5FXkFYHkssP
         IvnA==
X-Gm-Message-State: AJcUukeSd0T8E2YBOVm8C0SObItZwkz8mKpdwED0MFjCBLgj0R0U1SSn
        1zMI7nJUMkPta3isLJmP3pXbd6TjCI2u0akjZ5E=
X-Google-Smtp-Source: ALg8bN7VIEE97sRbTu5L1alWive7Ar3oPVcqSkhQmCJ/tFBm4xA5lnHtcGFCy6e9xUp9MGBfiMf/Gl7koD6MrVucGMk=
X-Received: by 2002:a25:3504:: with SMTP id c4mr12119781yba.252.1548449505104;
 Fri, 25 Jan 2019 12:51:45 -0800 (PST)
MIME-Version: 1.0
References: <1548236958-17565-1-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1548236958-17565-1-git-send-email-clabbe@baylibre.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 25 Jan 2019 12:51:30 -0800
Message-ID: <CAMo8Bf+1ePb+AfN1c-5sREYHr93bg4dbtTRtKHKrdbvQSPr2zg@mail.gmail.com>
Subject: Re: [PATCH] xtensa: rename BUILTIN_DTB to BUILTIN_DTB_SOURCE
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Chris Zankel <chris@zankel.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 1:49 AM Corentin Labbe <clabbe@baylibre.com> wrote:
>
> When building some xtensa config, I hit the following warning:
> drivers/staging/mt7621-dts/Kconfig:4:warning: 'BUILTIN_DTB' has wrong type. 'select' only accept arguments of bool and tristate type
>
> It is due to some arch use BUILTIN_DTB as a flag for the need to builtin
> dtb but xtensa use it as a string for which dtb to bulltin.
> But for this (which dtb to build), it is better to use
> BUILTIN_DTB_SOURCE like other arch do.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  arch/xtensa/Kconfig                         | 2 +-
>  arch/xtensa/boot/dts/Makefile               | 6 +++---
>  arch/xtensa/configs/audio_kc705_defconfig   | 2 +-
>  arch/xtensa/configs/cadence_csp_defconfig   | 2 +-
>  arch/xtensa/configs/generic_kc705_defconfig | 2 +-
>  arch/xtensa/configs/nommu_kc705_defconfig   | 2 +-
>  arch/xtensa/configs/smp_lx200_defconfig     | 2 +-
>  7 files changed, 9 insertions(+), 9 deletions(-)

Thanks, applied to my xtensa tree after reformatting commit message a bit.

-- 
Thanks.
-- Max

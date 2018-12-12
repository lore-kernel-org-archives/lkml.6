Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5BBC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 04:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4474920839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 04:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e4RwzNRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4474920839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbeLLEfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 23:35:00 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44702 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLEe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 23:34:59 -0500
Received: by mail-io1-f68.google.com with SMTP id r200so13737465iod.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 20:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7wDVsfie8KHIfi87JTBavAu3u0Y+bAU06PD5VhCAvKY=;
        b=e4RwzNRAw/JCicKg3V25fDHPlgbv2w/VM5isQQfTfQzX+7TQ4XVDFtXKs3a7qgwuhe
         1PwAYn+53ba3b9tE+o7FZ7ZfmdcKnZBYM65gGeayWRR5gMKnM86Lqke+L4BbxRwy3o7M
         SLoUHOLMcdyf1rlpsEaWB20YTp3QbIyV+qXsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7wDVsfie8KHIfi87JTBavAu3u0Y+bAU06PD5VhCAvKY=;
        b=UfWnljeGK6dfigHssGz7edYsn02xvHI1BxUTqYIVEOI/CCHJWn8yPzL1cciknJKIbW
         yZXu4837XTWXdtA0zsIfbo65vZyjYPln6/hBOq6NPzCtrwX74ZsFQxSyRLx/5zAFwOf8
         2QEaKfR06kCQ7aB5F62lpNt080xpX9C4irEuk7+w1wlERuc1psiMfluOKTk/Sf6JO48A
         XQIgXF4LvN9BonNbBrkXZTFv3p5twKK780YpVXEphffiGFufHXljTu5fDCktRmo4dMT0
         YYWDJ7WX3dQVFFc/OdBzL+F0e2gv8t7lIWsWKlpE1b+QPkQxB34wOvJI5d+9+3XP5ofh
         XtBg==
X-Gm-Message-State: AA+aEWYzaCq9byQ+Saa5JSiCrEJkX9LNSgqXKqRP65BCSrHBH21g5Nw3
        FeAwwN0semuW383tDp1eAieIM2F1X/sCMCm+62VDbQ==
X-Google-Smtp-Source: AFSGD/XGjCCHwMaXGsxkkQb/puvWLRBSAreHLCrKnqok9A4b9AHpzhLkd6TyNQjloLo9ujfuqeNXY87iT3eUbQJAP/E=
X-Received: by 2002:a6b:6919:: with SMTP id e25mr1143214ioc.119.1544589299128;
 Tue, 11 Dec 2018 20:34:59 -0800 (PST)
MIME-Version: 1.0
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <1544073508-13720-4-git-send-email-firoz.khan@linaro.org> <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
 <CALxhOng7EzAd2zHKAOj3ipEd6y=DpS2JGo34s4V_cWVgmLjPwg@mail.gmail.com> <20181211185947.gnaachztyh3ils7o@pburton-laptop>
In-Reply-To: <20181211185947.gnaachztyh3ils7o@pburton-laptop>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Wed, 12 Dec 2018 10:04:47 +0530
Message-ID: <CALxhOngErLD7+CEhgSPwQUnGg7YEFTcH-v6dhR0j55SvEg1FoA@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] mips: rename macros and files from '64' to 'n64'
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, 12 Dec 2018 at 00:29, Paul Burton <paul.burton@mips.com> wrote:
> > Will this below change will help?
> >
> >  #define _MIPS_SIM_ABI32              1
> >  #define _MIPS_SIM_NABI32            2
> >  #define _MIPS_SIM_ABI64              3
> > +#define _MIPS_SIM_ABIN64           _MIPS_SIM_ABI64
>
> Hmm, I think I'd prefer that we just keep using _MIPS_SIM_ABI64.

Sure, I think '64' to 'n64' conversion must be remove it from this patch
series.I can send v5 without '64' to 'n64' conversion.

If we rename '64' to 'n64' in half of the place and this _MIPS_SIM_ABI64
if we half to keep it in same looks not good (according to me).

(FYI, This macro name - _MIPS_SIM_ABIN64 must be _MIPS_SIM_NABI64
and defintion will be:
+#define _MIPS_SIM_NABI64           _MIPS_SIM_ABI64)

So If you confirm I can send v5 without '64' to 'n64' conversion (not just above
one, completely from this patch series). Or uou can take a call just
keep this macro -
_MIPS_SIM_ABI64 as it is and change it rest of the place.

Thanks
Firoz

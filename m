Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DC2C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D2E248DC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRXAuetc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D2E248DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753728AbeGCA7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 20:59:30 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34768 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752770AbeGCA72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 20:59:28 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so513472ois.1;
        Mon, 02 Jul 2018 17:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Afm2RmqJjKD0mk51jdWuAW5l2IFPC95Mdi5I1AWNcJI=;
        b=RRXAuetcDQi3c7e1uqxon8PSwbWKkFu3X5kYqIMgcANdlokqg545AZZRI4S11qA2hD
         Sr8CL/QoNYm5JPgAJXJCYEpM4R84o6n25G7OQ0C/13oigAp6Na60wTtI/j5+DLNCvn2w
         yIcHg8RURtufcsPkVLv5V83ND1IFvROKZD1KR+8hfiOCxyLbHrTZWy9/CpuseVZfrbr8
         jl0QwownPRAsisdz67dOmFG7r3MJ6wkFXVH24gv7HwUpso96R076wCw6r94fun7c8yaa
         Ho68EJDrjkHK7KW4PsGk4uIxUgNM7DgUYBv67p6Wa1Ro+nLq4wtWMe0LiyheJKiZBWNA
         7nIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Afm2RmqJjKD0mk51jdWuAW5l2IFPC95Mdi5I1AWNcJI=;
        b=IX7ibfMi9C8JRGKNmNSbbO56oALU/RWYpxyC6gGzZRxqX/6F7wOvpfgGtejR1ZbvvR
         lsyBDnl24kJFnI8Arlr9s+rxKoHNQ4VLtQTUaJzrlQkT9D0m2pnt2wsOBDOXzOQmJtOG
         TTi/PUtgjUcP2bnJkYUk0fNlB0QpDurcLnmBRjgLI1YACDW3cYfUncKlL/DhxaupxgEW
         Nsxff8nT8bPXlAytQ6tpMhMEBWJNPv6VdJu4hJnlqlPh+E8jA186450Ak4f/QMDy+HD3
         thCziS/Jgz5FEB8wwGzX0pag6AA0vOQp48RAIjxSe6/vQhAhsssYqDrnoV3/AKAKjJmJ
         e+dw==
X-Gm-Message-State: APt69E01W7ZaYoXirXx4WanoNdozsagBUM0583Ff8cnYAd6J+e/DqNw0
        5g8+60uYAdmZPi0zv2GK+kDDps7FjujLyxyyC+o=
X-Google-Smtp-Source: AAOMgpfEjo7dVspvqj7wb3WOfMHKI65JIfG7zpBFMpYwa/tX7cCyK2pC8LrrSUgIyQ1cFDw9t0AyHkBGWxDB+LNTXM4=
X-Received: by 2002:aca:400b:: with SMTP id n11-v6mr19590262oia.44.1530579567803;
 Mon, 02 Jul 2018 17:59:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 17:59:27 -0700 (PDT)
In-Reply-To: <CACRpkdZOCJXHxcYv0CU76J0r2OpxdtDuOiJ9cenrvJCHVsBeAA@mail.gmail.com>
References: <1530494867-15015-1-git-send-email-Anson.Huang@nxp.com> <CACRpkdZOCJXHxcYv0CU76J0r2OpxdtDuOiJ9cenrvJCHVsBeAA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 2 Jul 2018 21:59:27 -0300
Message-ID: <CAOMZO5DxX7Mx35sjQtaBi=ew9w82Ve0VRyXnekMgL1N_ShwUTg@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: core: cd_label must be last entry of mmc_gpio struct
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Adrian Hunter <adrian.hunter@intel.com>, evgreen@chromium.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, Jul 2, 2018 at 8:42 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> What about this:
>
> From facb3799f479bfd4dad99c25c9c5d4c77b14c9b0 Mon Sep 17 00:00:00 2001
> From: Linus Walleij <linus.walleij@linaro.org>
> Date: Mon, 2 Jul 2018 13:35:01 +0200
> Subject: [PATCH] mmc: slot-gpio: Allocate GPIO labels dynamically
>
> The use of string pointers in the MMC slot GPIO context is
> pretty dubious, allocating some 2*len extra bytes for each
> label of the ro and wp pins.
>
> Tidy this up using kasprintf() with dynamic allocation of
> labels for these strings.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Your proposed solution also worked fine, thanks.

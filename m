Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1697C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B459A20869
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DBr0xYoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B459A20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387631AbeHPFDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 01:03:17 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39946 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeHPFDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 01:03:17 -0400
Received: by mail-it0-f67.google.com with SMTP id h23-v6so4648238ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 19:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lm4k7HRph/H/AfLwL/EEmNEmuuCZIzR8uu61nYM/4R0=;
        b=DBr0xYoKO5aNIQp4PDG7QNrhwJKBiBcTTCtD00bsXT8zbg/At3wd6PNyCw3hcRKg7T
         IIBVk+ADCMMyH1KYbl6OTizCmUvmKDdpl6IEt/Rraag8SL3n2OECNRKeDzST0c6f4SR0
         Te8/qaz1mDoer6YwwYqzAxa84mDY7hTed5YN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lm4k7HRph/H/AfLwL/EEmNEmuuCZIzR8uu61nYM/4R0=;
        b=a1WGCP5Mj5GmzmeecIEfSt0My597mfaB+qjtufqvphj1GJS3PNPljVx7XXIPqOGhU4
         MFbXtSvcCfZ4vjzCc0BWBMzErktH4nc/z0PpiJkjK3dHeaVqDFfgAM0OwEtLEQ9i+iBZ
         LZ8EjTTC0XOfn7fV65OWVDYNurea9L5wE3VebP15dmME1QDiHisgLu13UNGn7vM0IfED
         a76YxHB4t5nKGpaMhA8szMBwbgZsHo5E/AAeohzI54N4FvedxYL025BxiPUNFYTcG2in
         aQIj8OgRshc86MDX+7vdsoJd4hppM4DrZ2DMunqBjM6npwOIcEFCkJjgI/Wzie3aHgAp
         oIMQ==
X-Gm-Message-State: AOUpUlHu4NHy3NLPqtxKSZkBVNh5ozkYcxxiewC6m/whur1ezVmZdwfA
        A0dtSOKjHrS5CrAe5GAdKdS8tBRDstuCxxsCvekzgMHq
X-Google-Smtp-Source: AA+uWPxq1Qn12jL8453DoO/8ASTjleNa5X0AE5FTSzxJPJxTLPRCsgQ5Ois3uyGUL9/uVU01Z59TyC+h82METneUlgY=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr19702986itb.16.1534385295486;
 Wed, 15 Aug 2018 19:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <s5h36vhazyp.wl-tiwai@suse.de> <CA+55aFx_ZgBBGoFCqQDCBTs6jq7t4SmVpzc1zzvd-B2E65mJEw@mail.gmail.com>
 <CA+55aFy5GGpyxQCZoWxOooGu+i5psz7OogvzGpWmuEJ1g7OYgA@mail.gmail.com>
 <CA+55aFxZDYTFKM4-e89_2SKHjHh_8RCZe7whKa2kCWRFk4mAdg@mail.gmail.com> <fb8d7d867726b934650ed20ceb4fe0d2a6a4f0f9.camel@perches.com>
In-Reply-To: <fb8d7d867726b934650ed20ceb4fe0d2a6a4f0f9.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 19:08:04 -0700
Message-ID: <CA+55aFz-+mez2aTqV=Ya9eHC1p+RVrhC_PHZA5ab2x2U+A8GYw@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 4.19-rc1
To:     Joe Perches <joe@perches.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 7:05 PM Joe Perches <joe@perches.com> wrote:
>
> Why does the commit change snd_hda_gen_add_micmute_led
> to return 0; instead of return 1;
>
> That bit looks wrong.

Well, it changes the comment too, and is clearly intentional.

I guess the logic was to have the usual "0 for success, negative for
error" logic.

Which is good - but dammit, when you change the return value, you
should definitely check and update all the callers.

Because yes, updating the call in alc_fixup_dell_wmi() fixes the
problem for me.

Grr. I wasted a fair amount of time on this.

             Linus

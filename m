Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDA7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9325521582
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZeMxeLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9325521582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbeKNJuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:50:19 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45275 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeKNJuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 04:50:19 -0500
Received: by mail-yb1-f196.google.com with SMTP id 131-v6so6148912ybe.12;
        Tue, 13 Nov 2018 15:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mWBIlREpefaU+p3fd66oX4IGdvRaIv8GtcJtWXZFoPs=;
        b=SZeMxeLrnn+pCwRRv6zGicVeJQBu5Bde4eXtqKjcuCq20tyE7eoEOs0vV45diGGhMG
         ghl/Vpwk3gMMPZP+d6/jlL30+x9WS3SkvyQdSmYCdr04nMdIeGm9ERbSiaz8W/v51oH7
         KeAYeB9dxFoEAWQzM1uZyXkseMS0VHfASchdT331kBNCR7xFC3C5AbeHAP7UeA6Y8I1u
         /OKuaXXzleCV8jKx7Y1MVeF3lVSgkRmmML1sFzmkjOi3Cwp1WZLzXNWdbI3eBlZbCzmY
         rd+eOeN7viElqr0QbOkFOOBHSiGNmhaZ+HjvhX12tIJek1CWr2Jyj/HSuVKbpXZ2o/FU
         nXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mWBIlREpefaU+p3fd66oX4IGdvRaIv8GtcJtWXZFoPs=;
        b=gQIMsk+9qRWJ9Yd8bh0FS+IPAbPuwfEXsbUc6sCD0BSCrXtYnv0RUZWE2CIIvrCdxn
         ZDIBM5Fuck7T8hlPaQp9HfVBr++MiACrJuRHCSNQ1Il3ofxsUWK+PeRSihdPT4wcSZO3
         UtxVEO0kwYEBztX6WRqhWnE5y4bxB2ii8wOTrNZ9Qy9vkoHGWuRUiPBBfnWpFRrvGdN3
         lPUlKjKGrKHzKMY1Ws2nRKR+kn5/2P4Dl73wX1PGD23+G0BNMFoD14Bjg38p97dGB6k/
         KMEtzU9Pjc5HgD84hoBqM7kOoENqrsLstXzElV2FaZBOyuTM18d4yHPBGeBAX/ZiYinK
         BgPg==
X-Gm-Message-State: AGRZ1gIMgjxMo3gm0M9HXH9R5q6oy92gfBafLGapYVMdzInCowa/AI22
        A2Q6ZGe7e6PCPA8hgxJj1RkLH0Lb13KoNaN79No=
X-Google-Smtp-Source: AJdET5fXmyxRinSTttRshGAzuXje6bbYjs3XfG9MDgIIPko2A5TodIBOtAKp75wqmZ9zL1tpecgp1b6ZQ1gW/mJnu/w=
X-Received: by 2002:a25:5f4d:: with SMTP id h13-v6mr7264917ybm.252.1542152980921;
 Tue, 13 Nov 2018 15:49:40 -0800 (PST)
MIME-Version: 1.0
References: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org> <1542104370-22831-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542104370-22831-2-git-send-email-firoz.khan@linaro.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 13 Nov 2018 15:49:29 -0800
Message-ID: <CAMo8BfJGWgJrsg858nwO_845HQOSMNm4AxEqjEjVsSMZMG1Gzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] xtensa: add __NR_syscalls along with __NR_syscall_count
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

I have one more question:

On Tue, Nov 13, 2018 at 2:20 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> The 2nd option will be the recommended one. For that, I
> added the __NR_syscalls macro in uapi/asm/unistd.h along
> with __NR_syscall_count asm/unistd.h. The macro __NR_sys-
> calls also added for making the name convention same across
> all architecture. While __NR_syscalls isn't strictly part
> of the uapi, having it as part of the generated header to
> simplifies the implementation. We also need to enclose
> this macro with #ifdef __KERNEL__ to avoid side effects.

Looking at the include/uapi/asm-generic/unistd.h I see that
__NR_syscalls is not guarded by the #ifdef __KERNEL__,
why should it be guarded for xtensa?

If we remove __NR_syscall_count from the uapi header I'd
suggest dropping it completely and switching its two current
users to __NR_syscalls.

-- 
Thanks.
-- Max

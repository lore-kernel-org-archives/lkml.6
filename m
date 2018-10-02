Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D463AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66422089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66422089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbeJBUhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:37:41 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41113 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbeJBUhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:37:41 -0400
Received: by mail-qt1-f194.google.com with SMTP id m15-v6so1955638qtp.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 06:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+adXAmUh4JPmASSosCvBILHf//BLoylclOhihW3CiI=;
        b=O7dTeke1ZcvyJnkmDfOKbF6ySYquKphqyQz2vNghfOODt9Zp/7rLZZLPCS4iIM09Nv
         K4Ht5CKqSKzJheS9wfTG5oAUgMopyAiclrxgIbfovXrnsu+o3KaL03I/fL2Tj5QR+pdt
         ug0irIZ42iIP9Z7rHvBim1zDCQtr+l+Bg6jOL3YXb+ETPVMp1/47x+Hq0Th2tfRNHi1S
         N9GMHYyvmmFxI7Di3n0ObzJyImSSuCWzktnuXMIFWOLsA4thxkZptme5w4YnQPs824u/
         kiXextrYSRi+Ro2pJh85cSodO17Rx1j+mz+9eATSWgmWNAJ5OpJqke16NMT4DclquIZd
         0IPA==
X-Gm-Message-State: ABuFfohK40eWMA7RJNvkh3RLsZnwH/qECpQNGP4K8AxedtNMf/gUCqQb
        2YABCBtoAB6zlt4mWUyEGb2CI/Un0lBZsPJvhFw=
X-Google-Smtp-Source: ACcGV60YusyoybOHEeD6mAt9AJXQyfCn87LiOOu2i4GbBy6LsteCobb4YnG0+o78s3g/iEOOEMqZCKNWOmX06dMTUQc=
X-Received: by 2002:aed:210e:: with SMTP id 14-v6mr6200225qtc.9.1538488451361;
 Tue, 02 Oct 2018 06:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAKv+Gu8NXyfNAzk4Fe=J0QHEEV-txbRAoEcQmjG-6PgCyW5SZg@mail.gmail.com>
 <20181002132026.14931-1-Jason@zx2c4.com> <CAKv+Gu_mwu+TFrbRPqDZ8i5csSqS26a534yzJ_wAQL_Y+W6F7w@mail.gmail.com>
In-Reply-To: <CAKv+Gu_mwu+TFrbRPqDZ8i5csSqS26a534yzJ_wAQL_Y+W6F7w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 2 Oct 2018 15:53:55 +0200
Message-ID: <CAK8P3a06uOvGcju7MppqqhsR5dwPKUBawrDbGYNXURqxGsZOKw@mail.gmail.com>
Subject: Re: [PATCH] ARM: makefile: use ARMv3M mode for RiscPC
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 3:28 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On 2 October 2018 at 15:20, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > The purpose of CONFIG_CPU_32v3 is to avoid ldrh/strh on the RiscPC,
> > which is pretty much an ARMv4 device, except its bus will choke on the
> > half-words. The way to make the C compiler not output ldrh/strh is with
> > -march=armv3, which doesn't support them in the ISA. However, this
> > prevents certain cryptography code from working that uses instructions
> > like umull. Fortunately there's also -march=armv3m that does support
> > those, making it possible to continue assembling optimized cryptography
> > routines for our beloved RiscPC.
> >
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Please add this to Russell's patch tracker for inclusion at
http://www.arm.linux.org.uk/developer/patches/

      Arnd

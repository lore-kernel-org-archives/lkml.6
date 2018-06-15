Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 16D07C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65B6208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rx5ZRmj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65B6208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755790AbeFOGNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 02:13:37 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:32897 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754603AbeFOGNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 02:13:35 -0400
Received: by mail-vk0-f67.google.com with SMTP id 200-v6so5085304vkc.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 23:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zcO3wnz67lF08tO8XpBac94HathTVkPGazRP40q0J4M=;
        b=rx5ZRmj9IkAPd8jxLirr5RjE49yJbyFqzORq3F2BSN/1OwRlOrQVWLuvJp0cgU+pru
         Ll2zGjBCngD86362/WQ2SdqtflnB0y8VrmB8E1kt7cOePewFgasTxws+rXH5DGXgCHYh
         9f4sb/CIdF6Vyi1qtBL5i6v/zAtZXyOY3nbOxIedtJsCj2LavcyNMLbyNZO0XOljt6Rv
         ICAddmEDIV9T6z27rxrTigZd/c/azbrC1dJWdB9zXXn6E2LGp3J7VP/ktMZQE4kwh07S
         Emly9Zf29OAnOapk2BoGKhN39TN3ROdnxSNOM0H+o7tJ9MrkZcRIA+8I32rY2A/Huovs
         Swiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zcO3wnz67lF08tO8XpBac94HathTVkPGazRP40q0J4M=;
        b=Ukjzkja6RwfwVuBP6wCCf0qnOsYINlO76t9D3EFefut1XfpZOnhDwLQRNbTw/2YoK4
         msCy/WTBoM0+H2MEvalGVCamTxdzriXnBCV/nNpMaVHEG1fZgFHz/FA7+A7U1GY69rbH
         0+ybgkzzGNW/zzHyD6lLEX81PnWAtO+0QBlMDvH1x29InlzJCiJ6yYYM8Jn23pjlicqD
         LBcA7tLWFQQelbmFRDUJTDfqve9btlReqrHHeV6NDk34q/e6fxUcApbHeUvUwMqQS/oS
         F1aUaxR+o8cNEKbdz43Z0QifGGq7dFKPHHZZNs2QZM0373266o5MyFY2OAzTdbTexqdd
         7ySw==
X-Gm-Message-State: APt69E34KELFVHP3JqUFWeXUFZs4equvf+FbDqOKlpYgYI7qVe174BTx
        GmHXsvXLe6QlmwwNlTfSBYvs4ukEH5JcvPvcuDc=
X-Google-Smtp-Source: ADUXVKKVb2l8ewt5CYdJs1Kt9/upg75vIpvn5x7ZLoW3jovtWxZLjTYKqi4obcNdB+8Xl0hKqxjBHSrU2ccBg2iHEOQ=
X-Received: by 2002:a1f:aa4b:: with SMTP id t72-v6mr170640vke.80.1529043215121;
 Thu, 14 Jun 2018 23:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180614142852.22226-1-jhogan@kernel.org>
In-Reply-To: <20180614142852.22226-1-jhogan@kernel.org>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Fri, 15 Jun 2018 14:12:58 +0800
Message-ID: <CAEbi=3d_muKnGnmfu8OJZqO=2EUTSf-YjLPChupDVXxcacJejQ@mail.gmail.com>
Subject: Re: [PATCH v2] nds32: Fix build error caused by configuration flag rename
To:     jhogan@kernel.org
Cc:     Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, matt.redfearn@mips.com,
        palmer@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Hogan <jhogan@kernel.org> =E6=96=BC 2018=E5=B9=B46=E6=9C=8814=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8810:29=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Guenter Roeck <linux@roeck-us.net>
>
> Fix build error on nds32 due to the merge of commit e3d5980568f ("lib:
> Rename compiler intrinsic selects to GENERIC_LIB_*") during the 4.18
> merge window which renames Kconfig symbols. This had raced with commit
> aeaa7af744fa ("nds32: lib: To use generic lib instead of libgcc to
> prevent the symbol undefined issue.") merged late in the 4.17 cycle,
> which added selects to nds32 using the original Kconfig symbol names.
>
> When they came together in merge commit 763f96944c95 ("Merge tag
> 'mips_4.18' of
> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux") this resulted
> in the following build errors:
>
> nds32le-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_ini=
t':
> timekeeping.c:(.init.text+0x140): undefined reference to `__ashldi3'
> nds32le-linux-ld: timekeeping.c:(.init.text+0x144): undefined reference t=
o `__ashldi3'
> nds32le-linux-ld: timekeeping.c:(.init.text+0x17e): undefined reference t=
o `__lshrdi3'
> nds32le-linux-ld: timekeeping.c:(.init.text+0x182): undefined reference t=
o `__lshrdi3'
> nds32le-linux-ld: drivers/clocksource/mmio.o: in function `clocksource_mm=
io_init':
> mmio.c:(.init.text+0x54): undefined reference to `__lshrdi3'
> nds32le-linux-ld: mmio.c:(.init.text+0x58): undefined reference to `__lsh=
rdi3'
>
> Rename all 6 selects in nds32 and adjust the ordering accordingly to be
> alphabetical.
>
> Fixes: 763f96944c95 ("Merge tag 'mips_4.18' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/mips/linux")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> [jhogan@kernel.org: Rename all 6 symbols, sort, update commit message]
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Vincent Chen <deanbo422@gmail.com>
> Cc: Matt Redfearn <matt.redfearn@mips.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> ---
> Changes in v2:
>  - Rename all 6 symbols, not just the 3 that caused build failures.
>  - Sort selects.
>  - Update commit message.

Thank you James and Guenter.
Should I pick it in my tree? It will be ok to put in your tree. :)

Acked-by: Greentime Hu <greentime@andestech.com>

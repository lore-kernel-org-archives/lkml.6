Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42820C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0995B20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3JAnTyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0995B20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeJaVn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:43:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43795 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbeJaVn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:43:26 -0400
Received: by mail-qt1-f194.google.com with SMTP id q41-v6so17417635qtq.10;
        Wed, 31 Oct 2018 05:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1FWHEK0w1nBh9NvZuTBldplpXmEvCYsj2q4pRDo/KSQ=;
        b=C3JAnTyMM4ryzNIXk5R9y9rmKtIBsUWaZOEWE8Q4iFs7lphIqg+BFoUKWp4lcBjTfj
         i3Ruc1gmRC7xOXRsdnlCaLQRpwllUZnIAsnhsTpzXKOuen3savvtLpUMogfzR1Th0FsF
         MLs/FpTLSihZV/f0jselcWOTmtHqkr94+uU9HxNHZb3MfR6py0lzKBbnbJBnY9s10UMi
         JshCuJfo2+2n8+Wwbarb1ELRQjxDxRVNtJlL1vDY3397581dnr3OuZuBG6RmqjgUq9GN
         9wIUPGlvmyfl//VMtenpNzhnZ/Z7e0XIgsoviEaOllg4vjF1nErtfS3ufdHQy93bmC1t
         aHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1FWHEK0w1nBh9NvZuTBldplpXmEvCYsj2q4pRDo/KSQ=;
        b=Y/7Usf3chM4Yrh74KoT2PHA3Oe0RvgF02+q3z9jnGCLhmUko3ia4rHUmPX7maYgCyj
         s5G8p05iBH5ZLc92Bak1HL1GlGH/TwvG6yc1FmLfkJDqNK1TtqXb1aEMc3kjfT1VGUV0
         6QLIZa1UgOd3bDyNsPCtiVSJ9wMKmNuK+3K3kVEoGF4HwKTL2wcewP79zXb4HGhPPTca
         WplwT7vNiOAF58Ne3nCOTRUDJlZg+2FLULdGDxOqX8oZNSNwzdImAeU39/7aVRsLTg8z
         sTJTsV4dnz62Ry+mWBAy3oYY2j2ltzAqK7Lpx1Ntz+f5GsX9nqD411t/+axCQJQaYbor
         ePwg==
X-Gm-Message-State: AGRZ1gIHaoiKx+o+x/gFzQOY4bb18GO8+zi/35aqPZdLALYf4IaPDlV8
        FaX4MQQRLT6YBtWRfKY3gKVt54gEdFDpL2adsno=
X-Google-Smtp-Source: AJdET5ebGcxw+4ZKW6SvJJJE+2v9fq21UZeYgpRTvZAzGsF9eyXK2udD0iFsZ4ovDWyiU68/ILOQxkv/nY18Cg1R4jc=
X-Received: by 2002:ac8:1909:: with SMTP id t9mr2352915qtj.327.1540989933484;
 Wed, 31 Oct 2018 05:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <1540993041-25611-1-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1540993041-25611-1-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 31 Oct 2018 14:45:21 +0200
Message-ID: <CAHp75Ve4JhTbEFTYKWCx2DS80NKPXZJ8GDiamEFLq3vPCgVvzw@mail.gmail.com>
Subject: Re: [PATCH V4 1/5] pvpanic: move pvpanic to misc as common driver
To:     peng.hao2@zte.com.cn
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        hutao@cn.fujitsu.com,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 7:27 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> move pvpanic.c from drivers/platform/x86 to drivers/misc.
> following patches will use pvpanic device in arm64.

> --- a/drivers/platform/Kconfig
> +++ b/drivers/platform/Kconfig
> @@ -1,3 +1,6 @@
> +if ARM64
> +source "drivers/platform/arm/Kconfig"
> +endif
>  if X86
>  source "drivers/platform/x86/Kconfig"
>  endif
> diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
> index 4b2ce58..232231c 100644
> --- a/drivers/platform/Makefile
> +++ b/drivers/platform/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for linux/drivers/platform
>  #
>
> +obj-$(CONFIG_ARM64)               +=3D arm/
>  obj-$(CONFIG_X86)              +=3D x86/
>  obj-$(CONFIG_MELLANOX_PLATFORM)        +=3D mellanox/
>  obj-$(CONFIG_MIPS)             +=3D mips/

I'm not sure:
a) how it's related to the rest in this patch (should be split I suppose);
b) how come arm64->arm replacement =E2=80=94 are platform drivers independe=
nt
from the (ARM) architecture?

--=20
With Best Regards,
Andy Shevchenko

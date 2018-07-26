Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C40C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3EA20894
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UMEk6Ttf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3EA20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbeGZIYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:24:47 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35271 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbeGZIYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:24:46 -0400
Received: by mail-yw0-f196.google.com with SMTP id t18-v6so238598ywg.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 00:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QnUsbFjwywv40AGaNsaI+HjIW5szJuzhEPrhH3PAbP4=;
        b=UMEk6Ttf8yQnUj2wEambtMuepoSxzK7sC5QU1GPTXy1vK8zSki5s2N2ZpV4rtiQgP1
         h4f6/82L1Lb1z9pblLtxgyl16m9bNOIEV7mhbqeu7LsQYnQvjLAHHwFKcsUh3UhyPvbE
         KKlqdhHEEoVatkL4EjFOuojGgZj4T7PJVW7AA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QnUsbFjwywv40AGaNsaI+HjIW5szJuzhEPrhH3PAbP4=;
        b=Cbmt1ktMrkmzZpPELhqg8QkxOK/rFk0EaIbmEQ1HJg3L4zRtjriiLEajAkT4lua5Xs
         FqMPRj8Vd5c184nqVbYiUkrQQajS0o2pgXL/VAVTvd9EsIIrNflazkpwtVkLlDDLrKpL
         lwVVW4fuDQ2/HMXT8T9f7VFYzZzqPp1s54ZcVnfRNzT1hAB6ZEgXE0wej583LH4qoF0g
         SbcUkI2pFegtMIYbf1DBmYXuAPHp67T60RPsj8W1wreYumMujnDZJWWogTOWYckrrtXD
         HnGo3aiR2XudQ9GNnEZ3GhYtctUO+exFYMn8LCp/fKlK1DcZQtKrjA16DaUGz6BoEs97
         L1Ag==
X-Gm-Message-State: AOUpUlHWcQf+UmgmyBcYZZ/+JXpPYlBKWdixq5t23tQED9mRH02IIGR5
        OA0qFRRSzcQivoBCe7LTeE8/Eq04N/86drVd+6zTioEroXQ=
X-Google-Smtp-Source: AAOMgpcXMAhmcOeOcwsDmjRqqGgw9uTaoX3aHtXmFrk+Pgwo8XBVti04JjazuHTv30lpb3oVRLrFI1ZNFoAas9i0igo=
X-Received: by 2002:a81:ae66:: with SMTP id g38-v6mr338148ywk.74.1532588960134;
 Thu, 26 Jul 2018 00:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180626153125.515-1-anders.roxell@linaro.org>
In-Reply-To: <20180626153125.515-1-anders.roxell@linaro.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 26 Jul 2018 09:09:09 +0200
Message-ID: <CADYN=9JpBipFM81gW9jH_oc2bX=L0es=KoTAnCL70jUYtsKMoA@mail.gmail.com>
Subject: Re: [PATCH] sh: configs: remove no longer needed config option
To:     Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org
Cc:     linux-sh@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018 at 17:31, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Since commit eedf265aa003 ("devpts: Make each mount of devpts an
> independent filesystem.") CONFIG_DEVPTS_MULTIPLE_INSTANCES isn't needed
> in the defconfig anymore.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  arch/sh/configs/sh7785lcr_32bit_defconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/sh/configs/sh7785lcr_32bit_defconfig b/arch/sh/configs/sh7785lcr_32bit_defconfig
> index 2ddf5ca7094e..7aa78ced9ffa 100644
> --- a/arch/sh/configs/sh7785lcr_32bit_defconfig
> +++ b/arch/sh/configs/sh7785lcr_32bit_defconfig
> @@ -72,7 +72,6 @@ CONFIG_VT_HW_CONSOLE_BINDING=y
>  CONFIG_SERIAL_SH_SCI=y
>  CONFIG_SERIAL_SH_SCI_NR_UARTS=6
>  CONFIG_SERIAL_SH_SCI_CONSOLE=y
> -CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
>  # CONFIG_LEGACY_PTYS is not set
>  # CONFIG_HW_RANDOM is not set
>  CONFIG_I2C=y
> --
> 2.18.0
>

Ping.

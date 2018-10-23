Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870DFC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D3A20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLNlFclk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D3A20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbeJWRJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:09:42 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41502 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeJWRJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:09:42 -0400
Received: by mail-yw1-f67.google.com with SMTP id 135-v6so213703ywo.8;
        Tue, 23 Oct 2018 01:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Wf+GG9Y8Agzyq+OhYy/VlBuUZZZEpSfZ3rBExc31ceQ=;
        b=tLNlFclk47LBoiNdUjUbUnr6C2V28nggJboIncowO0tHPqo8qkVHz9gS+xj+h/vFLM
         mBMdnjmaT/GBfii3bPHkAIbK66fNIHcNvTuRTIue2zBYOmauKV6Kbd+wzCwNmAOnrtEB
         IaizrzQCgODmLExzLIy1ivTOLGuRGhHsI9LI+2pO7SY9iNM03tGpeALYMR+miA2ns5kP
         iyI2+JnkHWpDCV2WqlxHdbf3k80pqsU7DqFsHjjzstOHp16QaeLU+0vknTNC+UO4dATZ
         r1hjP/NelGUdWdpXfthihVk4aDuHN3e6wyn4b7BJrRK7RS5rVq1PyW3EqimyqFJXRMMP
         BoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Wf+GG9Y8Agzyq+OhYy/VlBuUZZZEpSfZ3rBExc31ceQ=;
        b=EctcJ5h+Tkoy4EZ9aAKgc7UtdZUJTzDaUhCw/WyZukb2V6d/BbnqsO4YjvRZjASjgO
         gGwX8n9JvRTEsCSJbYlovtAr6b2nQh7ODrdB0LUkpBXMPJONBPppt+fIhUohAPfnP+V5
         grWN1ygcFQwoDBGb/dGR2Qj8MqBv0xQrU2pvJsTbuMNrN0PkaEtFOmKcO1Sa0YxlQ72B
         JjW+yZrKFF3MMVFr4PwswiJgDfc+mzM+/maSs8G9Q3aMq0fwGvQ+CmG7PVQLX5Tug+5M
         6drF8ZQXOYxaBoX0GTAWRUbL/M6P19a8RV+5F71RgGs2m5s/DlfHf7BwXAVjk4XuNwtd
         Aepg==
X-Gm-Message-State: ABuFfogBCZuvT341zdeWPiMULNjlSKZgct80HIC/eNre/8rVo7taAJIz
        cqqth7ew2Ti5VUA4eUsCXpg6XGcg1U0VhJ5RbyY=
X-Google-Smtp-Source: ACcGV610sdMldcfEZXo8LRiupsvoCipXgtm0c8L7ucZlqPcf/wvfkDFNUhiCEa617pxdSmxfJIvtSUb+9gLL4U2Lbsw=
X-Received: by 2002:a81:7bc1:: with SMTP id w184-v6mr4331485ywc.345.1540284436596;
 Tue, 23 Oct 2018 01:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20181009112021.756-1-peron.clem@gmail.com>
In-Reply-To: <20181009112021.756-1-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 23 Oct 2018 10:47:05 +0200
Message-ID: <CAJiuCceqyPY+dYr+1xdSyUh5x1Fr=M_p1nsMF9h52v5CXt1uYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: socfpga: Clean unused functions
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinh / Russell,

Could you have a look at these patchs please ?

Thanks,
Clement

On Tue, 9 Oct 2018 at 13:20, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>=
 wrote:
>
> These functions are unused externally, removed them and declare
> the one used locally as static.
>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>  arch/arm/mach-socfpga/core.h    | 2 --
>  arch/arm/mach-socfpga/socfpga.c | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
> index 65e1817d8afe..92cae0a9213f 100644
> --- a/arch/arm/mach-socfpga/core.h
> +++ b/arch/arm/mach-socfpga/core.h
> @@ -34,8 +34,6 @@
>
>  #define RSTMGR_MPUMODRST_CPU1          0x2     /* CPU1 Reset */
>
> -extern void socfpga_init_clocks(void);
> -extern void socfpga_sysmgr_init(void);
>  void socfpga_init_l2_ecc(void);
>  void socfpga_init_ocram_ecc(void);
>  void socfpga_init_arria10_l2_ecc(void);
> diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socf=
pga.c
> index dde14f7bf2c3..5fb6f79059a8 100644
> --- a/arch/arm/mach-socfpga/socfpga.c
> +++ b/arch/arm/mach-socfpga/socfpga.c
> @@ -32,7 +32,7 @@ void __iomem *rst_manager_base_addr;
>  void __iomem *sdr_ctl_base_addr;
>  unsigned long socfpga_cpu1start_addr;
>
> -void __init socfpga_sysmgr_init(void)
> +static void __init socfpga_sysmgr_init(void)
>  {
>         struct device_node *np;
>
> --
> 2.17.1
>

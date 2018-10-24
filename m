Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02002ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 21:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F3E2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 21:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F3E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeJYGJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 02:09:34 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37225 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbeJYGJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 02:09:34 -0400
Received: by mail-oi1-f195.google.com with SMTP id e17-v6so5364778oib.4;
        Wed, 24 Oct 2018 14:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SEqOUWzeYMJpqTHsCRJGXGDeUUUUuGFzoEAGmrKeWoM=;
        b=mm1aPvXM2UGOEw/cSqhmy2DQ2iWGaWCHjq22ThBmZ8/5OJodVB6g0pzHsJdWlZE4D+
         y0DhpqGjNRtpuTX+ROHarfADNz4meEd12byr+OR1WYz8m39Ubfgj8JzjPKJBQURuhwa8
         tc5A4whO/cTgg0vNZSLXs7wk3oBF+mWlPr2kKBYGgLvbPbcGD54DY0lS9FM1eDsg7Ntr
         /XNBjkAhj9lGbZTb5i1D896gcklUY/uBmMI5AyXFEnapeJrnWV//A70dWecXDnB/zVmS
         TSaegHZF8P0fULCoXQJyx7TgIAaeL9LSBZScb4h5WpmeWWr7e7g9Yfx6+ANeKYOsT4nk
         AWpg==
X-Gm-Message-State: AGRZ1gK4J/MNu5NgK/UGTt7uHu4Yy7kwghkBeTWftGOD+KeM+4PgTrhn
        2y9SUVYC/VoRfrE4MxBEGQTqHNgGV5U=
X-Google-Smtp-Source: AJdET5c0hqwljjv63/3mrPDTeAqJAbYB3yJKACBB35QrzXXxQu779gXOYbB534EkohahFDPL7ojsng==
X-Received: by 2002:aca:e7d4:: with SMTP id e203-v6mr2450399oih.187.1540417188968;
        Wed, 24 Oct 2018 14:39:48 -0700 (PDT)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id r7-v6sm1817664oih.24.2018.10.24.14.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 14:39:47 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id s69-v6so5358719oie.10;
        Wed, 24 Oct 2018 14:39:46 -0700 (PDT)
X-Received: by 2002:aca:3195:: with SMTP id x143-v6mr2279303oix.213.1540417186346;
 Wed, 24 Oct 2018 14:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <1539536883-1928-1-git-send-email-vabhav.sharma@nxp.com> <1539536883-1928-3-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1539536883-1928-3-git-send-email-vabhav.sharma@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 24 Oct 2018 16:39:35 -0500
X-Gmail-Original-Message-ID: <CADRPPNTwpQRu9fxt8PTVb6VoNJEFFrMHpCrRa5T7YEddSVnq-w@mail.gmail.com>
Message-ID: <CADRPPNTwpQRu9fxt8PTVb6VoNJEFFrMHpCrRa5T7YEddSVnq-w@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] soc/fsl/guts: Add definition for LX2160A
To:     Vabhav Sharma <vabhav.sharma@nxp.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Scott Wood <oss@buserror.net>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        yamada.masahiro@socionext.com, Shawn Guo <shawnguo@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, V.Sethi@nxp.com,
        udit.kumar@nxp.com, pankaj.bansal@nxp.com,
        Yinbo Zhu <yinbo.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 12:14 AM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
>
> Adding compatible string "lx2160a-dcfg" to
> initialize guts driver for lx2160 and SoC die
> attribute definition for LX2160A
>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
>  drivers/soc/fsl/guts.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> index 302e0c8..bcab1ee 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -100,6 +100,11 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
>           .svr          = 0x87000000,
>           .mask         = 0xfff70000,
>         },
> +       /* Die: LX2160A, SoC: LX2160A/LX2120A/LX2080A */
> +       { .die          = "LX2160A",
> +         .svr          = 0x87360000,
> +         .mask         = 0xff3f0000,
> +       },
>         { },
>  };
>
> @@ -222,6 +227,7 @@ static const struct of_device_id fsl_guts_of_match[] = {
>         { .compatible = "fsl,ls1088a-dcfg", },
>         { .compatible = "fsl,ls1012a-dcfg", },
>         { .compatible = "fsl,ls1046a-dcfg", },
> +       { .compatible = "fsl,lx2160a-dcfg", },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
> --
> 2.7.4
>

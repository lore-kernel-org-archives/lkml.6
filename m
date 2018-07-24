Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F6DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35ECA20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="qRN1zx+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35ECA20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbeGXQus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:50:48 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36260 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388324AbeGXQus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:50:48 -0400
Received: by mail-yb0-f196.google.com with SMTP id s1-v6so1796449ybk.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JxDeA1T2WfTALCjdAXt/OH1rZ15lG3QvhGyAXKMLvy0=;
        b=qRN1zx+Wd4TyW6s3rRg00OXo7YD8lT8suNHJ4G7DiLFdwZ5oa3giYhLb/vEn7gvSTS
         AQMw8sH3pjZEMRDsSeCjQcSez+3NU9i+t5U6+9bsXgJdEDmJ+CeyPnfGRsowXIXiW5tC
         2dtcco/nSPXWvlvIRDBGNhg2HWeGOCjX2VBEmAOATF6NGAf/Lu1kCPidyc6agXJ12An+
         CYcoe8gCDdE9P59ugHFsydk3Dtoy9giUc4mDRM59VhX2lCose/8QMk8VMEjgkyNiFbfY
         2d1XT0xeu4dvay+2UtTa7zh9MorD29b7lMvWY28cg9U+hP8or5K0TuVAoarVJaWIIM/c
         z7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JxDeA1T2WfTALCjdAXt/OH1rZ15lG3QvhGyAXKMLvy0=;
        b=BiQVxVIuMJs6ZB+xCjurgwQtf+NXF8e/ktGQ5xOzzKn3QxuAHeHSaEiMI4cmjZCDXa
         7bmkJYVnGQNF6/JTH/kQ2deTiSm9p8bpx4UECWCj1Ele9Q9uiBriLzw/ij947EPqCNmO
         j1pEmhh6/YSuk2PaT038BxVRuqWSinEYSz7pQx94DuI1+icGTRQ2i/TpjMQXhjR3D7WQ
         Q3+/XGAiRqn5QCshV7hQHbXspjc++ub8RyAsCAp+OZ4u6l+aqAP2S361WWXzyKWuI5Bv
         hcuGEEf66xDLFTjfWP193QD3RXJm+sxF/mOPMdvx+Y37km10R9nvQfRTSuB8vGu0yNZA
         Y46w==
X-Gm-Message-State: AOUpUlFmg4IYnDI1h/UzhfUNdoIVW3MF3U0eL2yZBC2yvV2GugWh+Sc5
        E2o6ifL3waeyXmfvg2dx9m4wvQ==
X-Google-Smtp-Source: AAOMgpdim1PiJbgeJMjMoLZjyb5z+oPTkOxTxpgHEAoWlqwb1GHLmmVu40zukLrcSc1NcBIdoCXjIw==
X-Received: by 2002:a25:b5c9:: with SMTP id d9-v6mr9957491ybg.418.1532447023850;
        Tue, 24 Jul 2018 08:43:43 -0700 (PDT)
Received: from kudzu.us (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id p189-v6sm1457503ywd.40.2018.07.24.08.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 08:43:43 -0700 (PDT)
Date:   Tue, 24 Jul 2018 11:43:41 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rasesh Mody <rasesh.mody@cavium.com>,
        Sudarsana Kalluru <sudarsana.kalluru@cavium.com>,
        Dept-GELinuxNICDev@cavium.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sort Kconfig menu items alphabetically
Message-ID: <20180724154340.GA5871@kudzu.us>
References: <153237967407.172440.6754268418710104431.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153237967407.172440.6754268418710104431.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 04:01:14PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 6c541b4595a2 ("net: ethernet: Sort Kconfig sourcing alphabetically")
> sorted Kconfig sourcing based on directory names, but in a couple cases,
> the menu item text is quite different from the directory name and is not
> sorted correctly:
> 
>   drivers/net/ethernet/neterion/Kconfig    => "Exar devices"

Stupid question, does it make more sense to clarify the names in the
Kconfig to more naturally follow what people are expecting?  In the
case of Neterion, it was standalone for several years, then aquired by
Exar and shutdown in 11 months without ever making any Exar branded
adatpers.  Users, if they still exist, would probably think of it as
Neterion and not Exar (as there have been no follow-on adapters and I
don't believe any plans to ever do so).

So, this might be better as a rename of the Kconfig to something like
"Neterion (Exar) devices".  Of course, there is a fair amount of Exar
names in the Kconfig.  If you agree, I can do a clean-up of this to
match the expectations.

Thoughts?

Thanks,
Jon

>   drivers/net/ethernet/brocade/Kconfig     => "QLogic BR-series devices"
> 
> Move these entries so the Kconfig menu items are sorted.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/net/ethernet/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
> index af766fd61151..b21febba458e 100644
> --- a/drivers/net/ethernet/Kconfig
> +++ b/drivers/net/ethernet/Kconfig
> @@ -34,7 +34,6 @@ source "drivers/net/ethernet/arc/Kconfig"
>  source "drivers/net/ethernet/atheros/Kconfig"
>  source "drivers/net/ethernet/aurora/Kconfig"
>  source "drivers/net/ethernet/broadcom/Kconfig"
> -source "drivers/net/ethernet/brocade/Kconfig"
>  source "drivers/net/ethernet/cadence/Kconfig"
>  source "drivers/net/ethernet/calxeda/Kconfig"
>  source "drivers/net/ethernet/cavium/Kconfig"
> @@ -71,6 +70,7 @@ config DNET
>  source "drivers/net/ethernet/dec/Kconfig"
>  source "drivers/net/ethernet/dlink/Kconfig"
>  source "drivers/net/ethernet/emulex/Kconfig"
> +source "drivers/net/ethernet/neterion/Kconfig"
>  source "drivers/net/ethernet/ezchip/Kconfig"
>  source "drivers/net/ethernet/faraday/Kconfig"
>  source "drivers/net/ethernet/freescale/Kconfig"
> @@ -81,7 +81,6 @@ source "drivers/net/ethernet/huawei/Kconfig"
>  source "drivers/net/ethernet/i825xx/Kconfig"
>  source "drivers/net/ethernet/ibm/Kconfig"
>  source "drivers/net/ethernet/intel/Kconfig"
> -source "drivers/net/ethernet/neterion/Kconfig"
>  source "drivers/net/ethernet/xscale/Kconfig"
>  
>  config JME
> @@ -160,6 +159,7 @@ config ETHOC
>  source "drivers/net/ethernet/packetengines/Kconfig"
>  source "drivers/net/ethernet/pasemi/Kconfig"
>  source "drivers/net/ethernet/qlogic/Kconfig"
> +source "drivers/net/ethernet/brocade/Kconfig"
>  source "drivers/net/ethernet/qualcomm/Kconfig"
>  source "drivers/net/ethernet/rdc/Kconfig"
>  source "drivers/net/ethernet/realtek/Kconfig"
> 

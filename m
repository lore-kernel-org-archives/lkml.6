Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909F3C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E012084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="vSYeKoME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E012084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbeLLWRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:17:17 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43112 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbeLLWRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:17:15 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so14765824lff.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 14:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NTgwZDxEtYzfr3woGH/MPYE4jafl6MSilZUjalYjpO0=;
        b=vSYeKoMEiZ5Ho/BKG8dUIHWcMj+06Rp7G9eWaSVW584nmt+ILieZ3p2vgJJSM1tjC/
         tKZmQ9/E2hiIeb2sE2bA+KscaxTRGbYChIT8Gd4rtc89ur5IRbfRc2mgXrgh6MVBXdH+
         e5uqsY+CzkZStir9opg0grcQ+cmk0/72BWnw/zdcTqDosex/Lc7fTqmbMQw2GjscOeUM
         TEbx08Stjt6qvDJzVhbv5mA5/zBVcbh1UdzgcuX1ZqD4ZzskVox3d4lqXOrNSA784ueS
         plXh/N7yAcSX3BXETY09/86YuJtEKNQV1sHng+58ZK1DsTP2+R6HKLUry2cnMq7DZEa+
         bPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NTgwZDxEtYzfr3woGH/MPYE4jafl6MSilZUjalYjpO0=;
        b=KYh+3f4YSSEkYdLPn2zcX2GdEKzED4fb1jNhtnwm8ahSjHLSVZ2IAZRPe7rHxua2BE
         H6GRXLz55hWYfApjdENgbc4DzXg8/IgUpkw3z6R1rE+xNMrvyUWfhiSo13XOJqhxL9MI
         9pA+tmJDnd0yBtxsJoSf9CHT0dr88i8RmyP+yR8DEGzLaa29++8HltE4gKEuAgTAoLsM
         qO2v7XZQo7zsVBtmlSKlpiAJQLyXubBr3wSR57HF2DCCXbUbzEwdPG0rVkMuVcw2srLZ
         wcK22jWD+OB6KFlPfzG/Jlxk9t7Eum5zPjT8+MtT+nx3ftRrz8CBKnHu9GNEzB+QEkVi
         BdNg==
X-Gm-Message-State: AA+aEWb9ZXjKRjsNLwVvAONnxkXOE037WiQrrx/Q/hydzsinskwQPXI0
        zD9H8oTdTxdM6wgHzBB04iq/Tw==
X-Google-Smtp-Source: AFSGD/UxnUle9CfHwQWfcL4R/PwBYjLzMEa7WQvPO3XMb01N16KDd36bLXnunRMCyPRKKaU76/oN6w==
X-Received: by 2002:a19:1a14:: with SMTP id a20mr12019667lfa.1.1544653033306;
        Wed, 12 Dec 2018 14:17:13 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id 11-v6sm5142ljv.1.2018.12.12.14.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 14:17:12 -0800 (PST)
Date:   Wed, 12 Dec 2018 14:05:30 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ARM: omap2: avoid section mismatch warning
Message-ID: <20181212220530.m2o3njrvjcja5pfu@localhost>
References: <20181210215856.2238253-1-arnd@arndb.de>
 <20181210220926.GF6707@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210220926.GF6707@atomide.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 02:09:26PM -0800, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [181210 21:59]:
> > WARNING: vmlinux.o(.text+0x27530): Section mismatch in reference from the function am43xx_suspend_init() to the function .init.text:am43xx_map_scu()
> > The function am43xx_suspend_init() references
> > the function __init am43xx_map_scu().
> > This is often because am43xx_suspend_init lacks a __init
> > annotation or the annotation of am43xx_map_scu is wrong.
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Applied, thanks!


-Olof

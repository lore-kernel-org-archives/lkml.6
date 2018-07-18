Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092E2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B405C2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rJ49WoL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B405C2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbeGRSoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:44:39 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41884 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbeGRSoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:44:38 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6II4tPT048764;
        Wed, 18 Jul 2018 13:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531937095;
        bh=saqWIfAdvmG1M4asxlZRQAcZID4qE9KQcVjceA0jWzY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=rJ49WoL3AjDX9g87TGilHqszme9cGhe0GF10BRApFcBBBIvXuuKKTslJXVC8FLj7M
         +eDPQe8kj9BDfti/uzFMAIqi/bVLGMIXJr5IVbd5yOHHgEluIMVrN7u74ftgPVrrsv
         T4zDGlXs+YeUBSBzw2HlheZ2l75k59OdDgVUHgBQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6II4tAt003790;
        Wed, 18 Jul 2018 13:04:55 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 18
 Jul 2018 13:04:55 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 18 Jul 2018 13:04:55 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6II4tel015151;
        Wed, 18 Jul 2018 13:04:55 -0500
Date:   Wed, 18 Jul 2018 13:04:55 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, <tony@atomide.com>
CC:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>, <arm@kernel.org>
Subject: Re: [PATCH V2 0/5] arm64: Initial support Texas Instrument's AM654
 Platform
Message-ID: <20180718180455.gaej4fgf47zytdxk@kahuna>
References: <20180626162615.19194-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180626162615.19194-1-nm@ti.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:26-20180626, Nishanth Menon wrote:
> Hi,
> 
> This is an minor update from V1 posted earlier:
> 	https://marc.info/?l=linux-kernel&m=152943745424138&w=2
> 
> The following series enables support for newest addition in TI's SoC
> portfolio - AM654 SoC.
> 
> The series is based off v4.18-rc1, also available here:
> https://github.com/nmenon/linux-2.6-playground/tree/upstream/v4.18-rc1/k3-1-am6-base
> 
> Key changes since RFC are indicated in respective patches:
> * Pickedup Tony's Reviewed by
> * Modified cbass nodes to indicate interconnect (patch #3 in the series)

Hi Tony,

Apologies on the off-request. Looks like Tero might be on vacation
and might not be able to send the Pull request to arm-soc folks on time.

Requesting you to pick them up on our behalf for v4.19 if it that is
fine with you. We do have Rob's ack on the bindings themselves, and
the patches also have been reviewed as well.

Patchwork links:
https://patchwork.kernel.org/patch/10527309/
https://patchwork.kernel.org/patch/10489509/
https://patchwork.kernel.org/patch/10489547/
https://patchwork.kernel.org/patch/10489543/
https://patchwork.kernel.org/patch/10489513/

-- 
Regards,
Nishanth Menon

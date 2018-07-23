Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBADEECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F8420856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kjHFbsA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F8420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbeGWOel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:34:41 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58132 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387831AbeGWOel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:34:41 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6NDX4Li109495;
        Mon, 23 Jul 2018 08:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532352784;
        bh=oolXlqDN+hou4bEIfOYxQ++jK2TNMtDP/+MVNK5r1Q0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=kjHFbsA7xr4ZlRAAAtS29X0f7Mgkiia7Wa52ko1HJHBfOTojQh960sV7P6MNQtpFr
         Yq6qEitxJ0WfET/wzK7DImoIOtu7/hUtgCeQzsmHFpZcUdqu7ezFqRPm0tjc0jSiwQ
         Ye5xl8snPeeLFszqcF5a2d79BWBDC8EQsvka/ld0=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6NDX4tN015560;
        Mon, 23 Jul 2018 08:33:04 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 23
 Jul 2018 08:33:03 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 23 Jul 2018 08:33:04 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6NDX3gD022099;
        Mon, 23 Jul 2018 08:33:03 -0500
Date:   Mon, 23 Jul 2018 08:33:03 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <geert@linux-m68k.org>
Subject: Re: [PATCH V2 0/2] firmware: ti_sci: Add host-id as an optional
 parameter
Message-ID: <20180723133303.ijekyffgnmesrhhv@kahuna>
References: <20180716171328.11674-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180716171328.11674-1-nm@ti.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:13-20180716, Nishanth Menon wrote:
> Please find attached series to enable host-id as an optional dt property.
> 
> This is a minor update to V1 -> Mostly to pick up Greet's feedback and Rob's Ack.
> 
> V1: https://patchwork.ozlabs.org/cover/931822/
> 
> The series is based on v4.18-rc1 and is available here:
> https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-1-am6-tisci
> 
> Consolidated all patches (including all series) are available here:
> https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-am6-integ
> 
> Full Boot log (integrated of all series for AM654) is available here:
>    https://pastebin.ubuntu.com/p/bBFmnzYtCd/
> 
> Nishanth Menon (2):
>   Documentation: dt: keystone: ti-sci: Add optional host-id parameter
>   firmware: ti_sci: Provide host-id as an optional dt parameter
> 
>  .../devicetree/bindings/arm/keystone/ti,sci.txt    |  4 ++++
>  drivers/firmware/ti_sci.c                          | 24 ++++++++++++++++++----
>  2 files changed, 24 insertions(+), 4 deletions(-)

Santosh,

Apologies, I see you have already send your PR for v4.19. Was
just wondering if this is something we can consider for rc
cycle OR if you'd consider a followup PR for the same.

-- 
Regards,
Nishanth Menon

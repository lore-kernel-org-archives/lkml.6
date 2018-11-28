Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E7CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE032081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JiltVMym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE032081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeK2H74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:59:56 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53780 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeK2H7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 02:59:55 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wASKumKt034635;
        Wed, 28 Nov 2018 14:56:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543438608;
        bh=5OgzVfDYjeNi7XwtRtXq71jIymXHdnMJeRBr6xPkODg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JiltVMymJl4XdDS/OeUsRDyNnhR5v6yvXi40wA34BOcZGgHTW/NgpEPQlUVDDl5D+
         aD7BEm8gCGJJm248B+7CVlnz0JghkndRKn00bjMaGrfyGbvfqTpvtl42ZDCWTD4CC1
         MbIOyPWWr+KjZ8V7npUgtxWCiMNQ79rjFUxefoYs=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wASKumRA014860
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Nov 2018 14:56:48 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 28
 Nov 2018 14:56:48 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 28 Nov 2018 14:56:48 -0600
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wASKumYB002182;
        Wed, 28 Nov 2018 14:56:48 -0600
Subject: Re: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx packet
 size
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20181125234315.28313-1-grygorii.strashko@ti.com>
 <20181126022711.GD32164@lunn.ch>
 <7a194258-2888-2268-42d1-27ac513a5c8a@ti.com> <20181128044913.GB6730@lunn.ch>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <6047b35d-d3c2-14f7-b42d-754b581a3c55@ti.com>
Date:   Wed, 28 Nov 2018 14:56:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128044913.GB6730@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/18 10:49 PM, Andrew Lunn wrote:
>> [1] https://e2e.ti.com/support/arm/sitara_arm/f/791/t/701669
> 
> Reading this, the interesting part is:
> 
> 	My guess would be that the driver would have to track the
> 	configuration of the switch hardware to correctly pad the
> 	frame.
> 
> Have you tried that?

This is dynamic configuration related to ALE VLAN entries and
I do not see the way to support its auto-detection with current driver,
unfortunately.

-- 
regards,
-grygorii

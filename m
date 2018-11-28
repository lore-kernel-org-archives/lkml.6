Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4244C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8567620645
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8567620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeK2JrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:47:02 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41760 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbeK2JrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:47:01 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wASMhemX124563;
        Wed, 28 Nov 2018 16:43:40 -0600
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wASMheBW095878
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Nov 2018 16:43:40 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 28
 Nov 2018 16:43:40 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 28 Nov 2018 16:43:40 -0600
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wASMheSe008979;
        Wed, 28 Nov 2018 16:43:40 -0600
Subject: Re: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx packet
 size
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20181125234315.28313-1-grygorii.strashko@ti.com>
 <20181126022711.GD32164@lunn.ch>
 <7a194258-2888-2268-42d1-27ac513a5c8a@ti.com> <20181128044913.GB6730@lunn.ch>
 <6047b35d-d3c2-14f7-b42d-754b581a3c55@ti.com> <20181128220211.GA5037@lunn.ch>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <0b70091e-3747-ee8f-15d6-4532e210278e@ti.com>
Date:   Wed, 28 Nov 2018 16:43:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128220211.GA5037@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 11/28/18 4:02 PM, Andrew Lunn wrote:
>> This is dynamic configuration related to ALE VLAN entries and
>> I do not see the way to support its auto-detection with current driver,
>> unfortunately.
> 
> I think you can subscribe to switchdev events which will tell you.

Thanks a lot for your review and comments.

Unfortunately, we still do not have switchdev in place, but i need to resolve
existing issue somehow. This patch is small, local to CPSW fix which can be
backported to stable. So, if possible, and no strong objection, could we proceed with it?

-- 
regards,
-grygorii

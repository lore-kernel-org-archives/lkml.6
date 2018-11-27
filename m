Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCF3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE4D20851
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iHAvcci0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE4D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbeK1F2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:28:19 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36096 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725758AbeK1F2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:28:18 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wARIT6ZA025235;
        Tue, 27 Nov 2018 12:29:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543343346;
        bh=YKpyO6SimyLQviWcyNd4OWhdXIVXmAzGjWGQ82BXiBQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=iHAvcci0FJKnIK/ApV5FnSPAjRWfviiIUfJG7F9/7LnWxmgLdnKudDSrBEfkXUsnC
         y/rA+5psSeqXUokC+OSPPFMcQAz+t5zmVcqTV0srTI6ygMEdnUQRjKkI1irOe4o6N7
         51pFSyiH4qfwQQ25qVQEAZ7Y3CV3ulYbT9VB7y7k=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wARIT6Ne056884
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 12:29:06 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 27
 Nov 2018 12:29:05 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 27 Nov 2018 12:29:05 -0600
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wARIT5cE008537;
        Tue, 27 Nov 2018 12:29:05 -0600
Subject: Re: [PATCH linux-next 09/10] dt-bindings: net: ti: deprecate
 cpsw-phy-sel bindings
To:     Rob Herring <robh@kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Andrew Lunn <andrew@lunn.ch>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20181126001531.12974-1-grygorii.strashko@ti.com>
 <20181126001531.12974-10-grygorii.strashko@ti.com>
 <20181126195838.GA19167@bogus>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <06fde096-15cb-e2c9-f1e4-dad43a4e0fca@ti.com>
Date:   Tue, 27 Nov 2018 12:29:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126195838.GA19167@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/18 1:58 PM, Rob Herring wrote:
> On Sun, Nov 25, 2018 at 06:15:30PM -0600, Grygorii Strashko wrote:
>> The cpsw-phy-sel driver was replaced with new PHY driver phy-gmii-sel, so
>> deprecate cpsw-phy-sel bindings.
>>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   Documentation/devicetree/bindings/net/cpsw-phy-sel.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Please add acks/reviewed-bys when posting new versions.
> 

Sry, missed your ask for this patch.

-- 
regards,
-grygorii

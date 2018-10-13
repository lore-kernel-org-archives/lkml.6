Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E5DC6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 00:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8886920895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 00:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GZbrO6Q2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8886920895
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbeJMIQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 04:16:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44848 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeJMIQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 04:16:32 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9D0fXTo042158;
        Fri, 12 Oct 2018 19:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539391293;
        bh=42QId3MRZo7j+3GEExtSv4wUr4+otAAS76xbO4Edv7U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GZbrO6Q2Nrg9p3J9k9gMVxWMvm0uJYH6kh2brTsC9HCnouXZ96y4ejHte4lJW9DV0
         Ovimw/XJxm1At5XpyTU/DyT5/Zcz/hB11q234tBzvmnHTENsiVNsN4oQpWb9v3L+/O
         mnU0gsSBSRIlx3LNMlQLd5amvrlt+lRPjPLlSbJM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9D0fXmd029495;
        Fri, 12 Oct 2018 19:41:33 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 12
 Oct 2018 19:41:33 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 12 Oct 2018 19:41:33 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9D0fWMs029411;
        Fri, 12 Oct 2018 19:41:32 -0500
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: use for mcast entries
 only host port
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, <davem@davemloft.net>
CC:     <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181012160629.7245-1-ivan.khoronzhuk@linaro.org>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <79601c11-8160-fe8e-f824-8b19d539bb76@ti.com>
Date:   Fri, 12 Oct 2018 19:41:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012160629.7245-1-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2018 11:06 AM, Ivan Khoronzhuk wrote:
> In dual-emac mode the cpsw driver sends directed packets, that means
> that packets go to the directed port, but an ALE lookup is performed
> to determine untagged egress only. It means that on tx side no need
> to add port bit for ALE mcast entry mask, and basically ALE entry
> for port identification is needed only on rx side.
> 
> So, add only host port in dual_emac mode as used directed
> transmission, and no need in one more port. For single port boards
> and switch mode all ports used, as usual, so no changes for them.
> Also it simplifies farther changes.
> 
> In other words, mcast entries for dual-emac should behave exactly
> like unicast. It also can help avoid leaking packets between ports
> with same vlan on h/w level if ports could became members of same vid.
> 
> So now, for instance, if mcast address 33:33:00:00:00:01 is added then
> entries in ALE table:
> 
> vid = 1, addr = 33:33:00:00:00:01, port_mask = 0x1
> vid = 2, addr = 33:33:00:00:00:01, port_mask = 0x1
> 
> Instead of:
> vid = 1, addr = 33:33:00:00:00:01, port_mask = 0x3
> vid = 2, addr = 33:33:00:00:00:01, port_mask = 0x5
> 
> With the same considerations, set only host port for unregistered
> mcast for dual-emac mode in case of IFF_ALLMULTI is set, exactly like
> it's done in cpsw_ale_set_allmulti().
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
> 
> Based on net-next/master



Thank you.
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii

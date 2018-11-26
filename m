Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D1EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5F020862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CEgU+lA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5F020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeK0FwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:52:23 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56092 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeK0FwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:52:23 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQIvKtn054556;
        Mon, 26 Nov 2018 12:57:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543258640;
        bh=lfBYC765d5Vig5Oa/Hy01Uen04ks4G26M7lH8r7rJEI=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=CEgU+lA9usHEN1AmNDUFzGIlkXe8ULPoX8eSRmFr/RD/fpXRzO35YC4+oUpddHbvA
         Y7PLOuKrjGUTo2LrNZGnDWlLCu+FcR0yEdeBLbndRbSC3feUXdHRNcg8F9AWXDotcS
         Shefvvx45aaFGRmHYkvF5RfrWbcluJt6dXM5GYbs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQIvKwi088517
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 12:57:20 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 26
 Nov 2018 12:57:20 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 26 Nov 2018 12:57:20 -0600
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQIvK6O010015;
        Mon, 26 Nov 2018 12:57:20 -0600
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: drop vid0 configuration
 in dual_mac modey
To:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20181125234626.28474-1-grygorii.strashko@ti.com>
 <20181126162644.GA23230@khorivan>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <7f2c5e66-3b42-f921-c52d-236f5adc44bf@ti.com>
Date:   Mon, 26 Nov 2018 12:57:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126162644.GA23230@khorivan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/18 10:26 AM, Ivan Khoronzhuk wrote:
> On Sun, Nov 25, 2018 at 05:46:26PM -0600, Grygorii Strashko wrote:
>> In dual_mac mode CPSW driver uses vid1 and vid2 by default to implement
>> dual mac mode wich are used to configure pvids for each external ports.
>> But, historicaly, it also adds vid0 to ALE table and sets "untag" bits for both
>> ext. ports. As result, it's imposible to use priority tagged packets in
>> dual mac mode.
>>
>> Hence, drop vid0 configuration in dual mac mode as it's not required for dual
>> mac mode functionality and, this way, make it possible to use priority
>> tagged packet in dual mac mode.
> So, now it's enabled to be added via regular ndo.
> I have similar change in mind, but was going to send it after
> mcast/ucast, and - enabling same vlans patch...
> 
> 2 things stopped me to add this:
> 
> 1) Moving it to be enabled via regular call is Ok, but in dual mac mode
> it causes overlaps, at least while vid deletion. So decided to wait till
> same vlans series is applied.

TI driver documentation mentions this restriction
"While adding VLAN id to the eth interfaces, 
same VLAN id should not be added in both interfaces which will lead to VLAN
forwarding and act as switch"

> 
> 2) Wanted implement somehow similar handling for single port boards
> in one patch, not only for dual mac mode. This part was not clear and
> not verified completely...
> 
> So, if it's needed now, maybe better at this moment only remove
> untag field? and remove vlan0 later, once other vlan changes applied.
> 
> Say:
> 
> cpsw_ale_add_vlan(cpsw->ale, cpsw->data.default_vlan,
>            ALE_ALL_PORTS, 0, ALE_ALL_PORTS, 0);
> 
> instead of:
> cpsw_ale_add_vlan(cpsw->ale, cpsw->data.default_vlan,
>            ALE_ALL_PORTS, ALE_ALL_PORTS, 0, 0);
> 

This patch affects only dual_mac mode and in this mode adding vid0 by default is
definitely make no sense in any case. 

[1] http://processors.wiki.ti.com/index.php/Linux_Core_CPSW_User%27s_Guide#Dual_Standalone_EMAC_mode

>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>> drivers/net/ethernet/ti/cpsw.c | 7 ++-----
>> 1 file changed, 2 insertions(+), 5 deletions(-)
-- 
regards,
-grygorii

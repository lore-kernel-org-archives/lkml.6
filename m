Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA08C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E802082F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b8zoVDfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E802082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbeK1M1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:27:12 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38528 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeK1M1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 07:27:12 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAS1RFFt096815;
        Tue, 27 Nov 2018 19:27:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543368435;
        bh=iL3WCl4ASjsA/ygQPkMwqi3EuwwGA75WXKbsT0nDFVM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=b8zoVDfmaLbMpv2jUDZ8LoUXv6CGfWbGnp2ZrPown+RzDwXA9hledJhCD53Im2Yoc
         sp1d0dYfyfAI6zVEVIDRZpw9qIwbwgFdkEj97mYjgPkdrhEy1ErAL/ufZv/GeEI2kv
         ORkUvg39t4ZyG7N2Ef7Gn7o9fNlRLV5GJbx3LUcI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAS1RFog065811
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 19:27:15 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 27
 Nov 2018 19:27:15 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 27 Nov 2018 19:27:15 -0600
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAS1RFSE011241;
        Tue, 27 Nov 2018 19:27:15 -0600
Subject: Re: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx packet
 size
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20181125234315.28313-1-grygorii.strashko@ti.com>
 <20181126022711.GD32164@lunn.ch>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <7a194258-2888-2268-42d1-27ac513a5c8a@ti.com>
Date:   Tue, 27 Nov 2018 19:27:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126022711.GD32164@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 11/25/18 8:27 PM, Andrew Lunn wrote:
> On Sun, Nov 25, 2018 at 05:43:15PM -0600, Grygorii Strashko wrote:
>> For proper VLAN packets forwarding CPSW driver uses min tx packet size of
>> 64bytes (VLAN_ETH_ZLEN, excluding ETH_FCS) which was corrected by
>> commit 9421c9015047 ("net: ethernet: ti: cpsw: fix min eth packet size").
>>
>> Unfortunately, this breaks some industrial automation protocols, as
>> reported by TI customers [1], which can work only with min TX packet size
>> from 60 byte (ecluding FCS).
> 
> Hi Grygorii
> 
> excluding...
> 
>> Hence, introduce module boot parameter "tx_packet_min" to allow configure
>> min TX packet size at boot time.
> 
> Module parameters are generally not liked.

not sure how to proceed otherwise. There is always one instance of CPSW per SoC,
so Module parameter is safe here at least.

> 
> What actually happens here with this lower limit? Does the hardware
> send runt packets? Does the protocol actually require runt packets?

I do not have more details in addition to what's described in [1]:
"While for instance the ARP protocol does not seem to have a problem with additional
padding in the payload, some industrial automation protocols seem to be strict in this regard."
"We're basically running a bridge for different industrial protocols like ProfiNet"

As per my understanding there some industrial HW and SW which has very
strict limitation to min packet size and just can't handle other min packet
sizes.

> 
> I'm just wondering if the module parameter can be avoided by setting
> this as the default. 

It was a default value 60 bytes (64 bytes with FCS), but I changed it to 64 byte (68 byte with FCS) 
as per above mentioned commit for proper VLAN tagged packets forwarding support
(which seems legal as per 802.1q - G.2.1 Treatment of PAD fields in IEEE 802.3 frames).

Use case:
 - Port 0 (int) - vlan capable host.
 - Port 1 (ext) - vlan capable network
 - port 2 (ext)- non vlan capable network. pvid is set.
   all egress traffic untagged. CPSW HW can't align packet properly
   when vlan tag is removed, so need to use 68 byte min packet size.

Hence, both use cases need to be supported - this patch posted.
without it TI customers will continue do revert manually when required
which definitely not a good option.

>But we need to ensure ARP packets, which are
> smaller than the minimum MTU are correctly padded.


[1] https://e2e.ti.com/support/arm/sitara_arm/f/791/t/701669

-- 
regards,
-grygorii

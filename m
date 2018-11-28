Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1819AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C9C2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EDkJ2sQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C9C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeK2ISr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:18:47 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59214 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbeK2ISr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:18:47 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wASLFkRc031073;
        Wed, 28 Nov 2018 15:15:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543439746;
        bh=7i6aatIfgeNa/gI6IuiZ9G2Mc748APniNWYTfhLfIY0=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=EDkJ2sQIHMj4UQnQlgqIUA9l+X2c/46kiv8Cl8X6K/fLsJDNM1A82q9SHAHR5qy+4
         I5JNJBUfK0UCuApTWoZ4JwLMNr0cSupD6eSo3oRvITQuLqfxFTSjhWMOUZ7qyJwiWI
         gxQUJdnau6RFXsM8mZXknQUz4LkGbNvXefmwAavg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wASLFkpo051693
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Nov 2018 15:15:46 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 28
 Nov 2018 15:15:46 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 28 Nov 2018 15:15:46 -0600
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wASLFk72011511;
        Wed, 28 Nov 2018 15:15:46 -0600
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: drop vid0 configuration
 in dual_mac modey
To:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20181125234626.28474-1-grygorii.strashko@ti.com>
 <20181126162644.GA23230@khorivan>
 <7f2c5e66-3b42-f921-c52d-236f5adc44bf@ti.com>
 <20181126200757.GB23230@khorivan>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <fcc8efa1-1f19-baa3-872d-5c76a1b7dce0@ti.com>
Date:   Wed, 28 Nov 2018 15:15:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126200757.GB23230@khorivan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/18 2:07 PM, Ivan Khoronzhuk wrote:
> On Mon, Nov 26, 2018 at 12:57:20PM -0600, Grygorii Strashko wrote:
>>
>>
>> On 11/26/18 10:26 AM, Ivan Khoronzhuk wrote:
>>> On Sun, Nov 25, 2018 at 05:46:26PM -0600, Grygorii Strashko wrote:
>>>> In dual_mac mode CPSW driver uses vid1 and vid2 by default to implement
>>>> dual mac mode wich are used to configure pvids for each external ports.
>>>> But, historicaly, it also adds vid0 to ALE table and sets "untag" bits for both
>>>> ext. ports. As result, it's imposible to use priority tagged packets in
>>>> dual mac mode.
>>>>
>>>> Hence, drop vid0 configuration in dual mac mode as it's not required for dual
>>>> mac mode functionality and, this way, make it possible to use priority
>>>> tagged packet in dual mac mode.
>>> So, now it's enabled to be added via regular ndo.
>>> I have similar change in mind, but was going to send it after
>>> mcast/ucast, and - enabling same vlans patch...
>>>
>>> 2 things stopped me to add this:
>>>
>>> 1) Moving it to be enabled via regular call is Ok, but in dual mac mode
>>> it causes overlaps, at least while vid deletion. So decided to wait till
>>> same vlans series is applied.
>>
>> TI driver documentation mentions this restriction
>> "While adding VLAN id to the eth interfaces,
>> same VLAN id should not be added in both interfaces which will lead to VLAN
>> forwarding and act as switch"
> It's not accurate now.
> This sw bug "acting like a switch" was fixed indirectly in LKML ).
> And at least for upstream version, not TISDK, desc should be updated,
> but better do this when it fixed completely and merged with TISDK.
> 
> I know about this "written" restriction
> (for tiSDK, and it's not TRM after all ...),
> it can be avoided and it's partly avoided now ...

I'd like to clarify point about supporting same VLANs in dual_mac mode,
to avoid future misunderstanding, overall: it's *not* supported as
adding same VLAN to both netdevices will cause unknown unicast packets
leaking between interfaces and it can't be avoided - hw limitation.

Regarding vid0 - current default configuration of CPSW considers
vid0/priority tagged packets as - untagged and assigns pvid to any
such ingress packet inside switch. Hence, P0 (Linux host) egress port
never modifies packet contents - this behavior is not visible to Linux.
(EN_VID0_MODE=0, P1_PASS_PRI_TAGGED=0)

> 
> Also, for notice, while you add any of the vlans to any of
> the ports, vlan0 is added to both of them.....restricted it or not.
> Thanks to last changes in the driver it's not "acting like a switch"
> The patch in question enables this in ndo, not me.
> 
> #ip link add link eth0 name eth0.400 type vlan id 400
> [  326.538989] 8021q: 802.1Q VLAN Support v1.8
> [  326.543217] 8021q: adding VLAN 0 to HW filter on device eth0
> [  326.554645] 8021q: adding VLAN 0 to HW filter on device eth1
> [  326.572236] net eth0: Adding vlanid 400 to vlan filter
> 
> I just propose to extend it later, when it's correct to do.
> But if no harm (basically no harm, only if someone decides
> to add vlan0 to both ports and then delete on one of them)
> , at least you should take this into account.
> 



-- 
regards,
-grygorii

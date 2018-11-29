Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B4CC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2822420989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hmttjq+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2822420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeK3KaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:30:23 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49484 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbeK3KaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:30:23 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wATNNAHc027778;
        Thu, 29 Nov 2018 17:23:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543533790;
        bh=rP+5KcJ8T5fnemazgY3zi5vwSffoK6xRHbhtJBSp7xA=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=hmttjq+vud8iPUeS06aYqalfpeMQScLmvcLmJhAaot7KdiAsF13pOcxwWCrlRGLxS
         GqPK/LjXsjjMTnTtRygpsTFiefIhKL8VyT63eKIAxMmTWest5AZJmGJ0qidtb8GcLU
         iw4afGzQjo1QOmuhPVkf1eg3wXRzWtPcofRg+enY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wATNNAjv021761
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Nov 2018 17:23:10 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 29
 Nov 2018 17:23:09 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 29 Nov 2018 17:23:09 -0600
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wATNN9SQ028888;
        Thu, 29 Nov 2018 17:23:09 -0600
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: drop vid0 configuration
 in dual_mac modey
To:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20181125234626.28474-1-grygorii.strashko@ti.com>
 <20181126162644.GA23230@khorivan>
 <7f2c5e66-3b42-f921-c52d-236f5adc44bf@ti.com>
 <20181126200757.GB23230@khorivan>
 <fcc8efa1-1f19-baa3-872d-5c76a1b7dce0@ti.com>
 <20181129152646.GC23230@khorivan>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <473759d1-09c4-ebc0-8b31-cc5c8bb85faa@ti.com>
Date:   Thu, 29 Nov 2018 17:23:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129152646.GC23230@khorivan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/18 9:26 AM, Ivan Khoronzhuk wrote:
> On Wed, Nov 28, 2018 at 03:15:46PM -0600, Grygorii Strashko wrote:
>>
>>
>> On 11/26/18 2:07 PM, Ivan Khoronzhuk wrote:
>>> On Mon, Nov 26, 2018 at 12:57:20PM -0600, Grygorii Strashko wrote:
>>>>
>>>>
>>>> On 11/26/18 10:26 AM, Ivan Khoronzhuk wrote:
>>>>> On Sun, Nov 25, 2018 at 05:46:26PM -0600, Grygorii Strashko wrote:
>>>>>> In dual_mac mode CPSW driver uses vid1 and vid2 by default to implement
>>>>>> dual mac mode wich are used to configure pvids for each external ports.
>>>>>> But, historicaly, it also adds vid0 to ALE table and sets "untag" bits for both
>>>>>> ext. ports. As result, it's imposible to use priority tagged packets in
>>>>>> dual mac mode.
>>>>>>
>>>>>> Hence, drop vid0 configuration in dual mac mode as it's not required for dual
>>>>>> mac mode functionality and, this way, make it possible to use priority
>>>>>> tagged packet in dual mac mode.
>>>>> So, now it's enabled to be added via regular ndo.
>>>>> I have similar change in mind, but was going to send it after
>>>>> mcast/ucast, and - enabling same vlans patch...
>>>>>
>>>>> 2 things stopped me to add this:
>>>>>
>>>>> 1) Moving it to be enabled via regular call is Ok, but in dual mac mode
>>>>> it causes overlaps, at least while vid deletion. So decided to wait till
>>>>> same vlans series is applied.
>>>>
>>>> TI driver documentation mentions this restriction
>>>> "While adding VLAN id to the eth interfaces,
>>>> same VLAN id should not be added in both interfaces which will lead to VLAN
>>>> forwarding and act as switch"
>>> It's not accurate now.
>>> This sw bug "acting like a switch" was fixed indirectly in LKML ).
>>> And at least for upstream version, not TISDK, desc should be updated,
>>> but better do this when it fixed completely and merged with TISDK.
>>>
>>> I know about this "written" restriction
>>> (for tiSDK, and it's not TRM after all ...),
>>> it can be avoided and it's partly avoided now ...
>>
>> I'd like to clarify point about supporting same VLANs in dual_mac mode,
>> to avoid future misunderstanding, overall: it's *not* supported as
>> adding same VLAN to both netdevices will cause unknown unicast packets
>> leaking between interfaces and it can't be avoided - hw limitation.
> 
> Simple test shows no issues with ucast leaking.
> But for current buggy ucast vlan implementation it's not possible to verify,
> not sure but probably leaking in your case cuased by hidden toggling of
> interface to promisc while added ucast to vlans or other reason or so.
> Anyway I just decided to check specifically ucasts
> (macst as you know are not normal now).
> 
> For verification you need to apply ucast fix (including vlans) first:
> https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/log/?h=vlan_addr_flt_fix
> 
> This is generic fix (not sure it will be approved, need try RFC) but implement
> the same as local fix for vlan ucasts:
> https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/log/?h=ucast_vlan_fix
> 
> Any of those are correct. I've used generic one.
> Applied the following scheme:
> 
>                      +--------------------------+
>                      | host 74:DA:EA:47:7D:9C   |
>                      +--------------------------+
> 
>                         +---------------------+
>              |       am572 evm     |
>                         |    eth0      eth1   |
>                         +----------+----------+
>                         | eth0.400 | eth1.400 |
>                         +----------+----------+
>                             ^          |
>                             |          |  +-----------+
> +-----------------+        |          |  |     PC    |
> | BBB eth0.400    |--------+          +->| Wireshark |
> +-----------------+                      +-----------+
> 
> 
> 1) Configure vlans on am572x evm
> ip link add link eth0 name eth0.400 type vlan id 400
> ip link add link eth1 name eth1.400 type vlan id 400
> 
> 2) On BBB side:
> # ip link add link eth0 name eth0.400 type vlan id 400
> Send ucast vlan traffic to the am572 evm, vlan ucast address is unreq on am572.
> # ./plget -i eth0.400 -t ptpl2 -m tx-lat -n 160 -s 10 -a 74:DA:EA:47:7D:66
> # ./plget -i eth0.400 -t ptpl2 -m tx-lat -n 160 -s 10 -a 18:03:73:66:87:42
> 
> 3) Observe silence on PC wireshark.
> 
> Thus, no see issues with this.
> 
> PS: I'm sure in plget tool, you can use your own.

I'm using packeth to generate udp packets (vlan) src=PC dst=unknown
if there is record in ALE table which looks like:
type: vlan , vid = 100, untag_force = 0x0, reg_mcast = 0x7, unreg_mcast = 0x0, member_list = 0x7
then above udp packet will be forwarded to BBB.



-- 
regards,
-grygorii

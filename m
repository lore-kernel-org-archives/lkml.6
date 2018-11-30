Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21088C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF59F2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DdWcoSqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF59F2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeLAAvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:51:55 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40321 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeLAAvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:51:55 -0500
Received: by mail-lf1-f66.google.com with SMTP id v5so4127160lfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 05:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=d4PHDB8sODolE3zRjnN2bvfGLVRwKc5RGdgZe6Uiw0s=;
        b=DdWcoSqqVjU4l1rZmOJmGAMN/ijDrApKWQnkwBCux4iuhh9xU0lQ9YI8V4adbMpF4Q
         zdAxGMTJhvxzty0tMV6xMphJeqXJUSOE96eWh6xVvu6pbhLYa/JFnLbenfkOnrdPCpV/
         PcuMYlFQRu8ZKFpNL/BsQ/AoONgB/Q2YpvLqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=d4PHDB8sODolE3zRjnN2bvfGLVRwKc5RGdgZe6Uiw0s=;
        b=i6eABtZS0Z6sfec51ywqcBJ6peHCwUQgBveLUT5gI08XZzwswvCKdqu6Su58sHYifV
         BFm+wSFPuRk8iNObVeSx2mvqgOMJN1pV+5FW57//g3+aUuksb2H7w4Uf9Et0+vb0UhAo
         A/IdrY86x6qtAnSEQcOw888L0u7lseeK9K1/s2/WtdN9MLQN/ULEem1Y0JzyVDhm2GE7
         zLUv5AQvaXKNw88k0X0rBmdTaTnl/YPf+nKM/BP/cZFvAwXTlfZRRSYTrlwVxHiXEs7V
         nQveEIITvO5ykRX3//0V+agFIxKnKYhZPAzjfSIBwBX3HOXtzIjILcKmW98m+eaXqjRJ
         r2YA==
X-Gm-Message-State: AA+aEWY2cqsudZnBlyAD+G8H8HVRPzhZkck6MYIDtTI2a0WL9erwxYeu
        HgUJcQlGWOSYQQCTD+M9BCl/qQ==
X-Google-Smtp-Source: AFSGD/WkityAtEsFlBU3faJqQlKa9ASnsgmr+GdVNPHkwdyU1F5TER+2a82RmDFivkWO1Wesfmr8QA==
X-Received: by 2002:a19:4e59:: with SMTP id c86mr3864405lfb.132.1543585352345;
        Fri, 30 Nov 2018 05:42:32 -0800 (PST)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id j12-v6sm802047ljh.66.2018.11.30.05.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 05:42:31 -0800 (PST)
Date:   Fri, 30 Nov 2018 15:42:29 +0200
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: drop vid0
 configuration in dual_mac modey
Message-ID: <20181130134228.GD23230@khorivan>
Mail-Followup-To: Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
References: <20181125234626.28474-1-grygorii.strashko@ti.com>
 <20181126162644.GA23230@khorivan>
 <7f2c5e66-3b42-f921-c52d-236f5adc44bf@ti.com>
 <20181126200757.GB23230@khorivan>
 <fcc8efa1-1f19-baa3-872d-5c76a1b7dce0@ti.com>
 <20181129152646.GC23230@khorivan>
 <473759d1-09c4-ebc0-8b31-cc5c8bb85faa@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <473759d1-09c4-ebc0-8b31-cc5c8bb85faa@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 05:23:09PM -0600, Grygorii Strashko wrote:
>
>
>On 11/29/18 9:26 AM, Ivan Khoronzhuk wrote:
>> On Wed, Nov 28, 2018 at 03:15:46PM -0600, Grygorii Strashko wrote:
>>>
>>>
>>> On 11/26/18 2:07 PM, Ivan Khoronzhuk wrote:
>>>> On Mon, Nov 26, 2018 at 12:57:20PM -0600, Grygorii Strashko wrote:
>>>>>
>>>>>
>>>>> On 11/26/18 10:26 AM, Ivan Khoronzhuk wrote:
>>>>>> On Sun, Nov 25, 2018 at 05:46:26PM -0600, Grygorii Strashko wrote:
>>>>>>> In dual_mac mode CPSW driver uses vid1 and vid2 by default to implement
>>>>>>> dual mac mode wich are used to configure pvids for each external ports.
>>>>>>> But, historicaly, it also adds vid0 to ALE table and sets "untag" bits for both
>>>>>>> ext. ports. As result, it's imposible to use priority tagged packets in
>>>>>>> dual mac mode.
>>>>>>>
>>>>>>> Hence, drop vid0 configuration in dual mac mode as it's not required for dual
>>>>>>> mac mode functionality and, this way, make it possible to use priority
>>>>>>> tagged packet in dual mac mode.
>>>>>> So, now it's enabled to be added via regular ndo.
>>>>>> I have similar change in mind, but was going to send it after
>>>>>> mcast/ucast, and - enabling same vlans patch...
>>>>>>
>>>>>> 2 things stopped me to add this:
>>>>>>
>>>>>> 1) Moving it to be enabled via regular call is Ok, but in dual mac mode
>>>>>> it causes overlaps, at least while vid deletion. So decided to wait till
>>>>>> same vlans series is applied.
>>>>>
>>>>> TI driver documentation mentions this restriction
>>>>> "While adding VLAN id to the eth interfaces,
>>>>> same VLAN id should not be added in both interfaces which will lead to VLAN
>>>>> forwarding and act as switch"
>>>> It's not accurate now.
>>>> This sw bug "acting like a switch" was fixed indirectly in LKML ).
>>>> And at least for upstream version, not TISDK, desc should be updated,
>>>> but better do this when it fixed completely and merged with TISDK.
>>>>
>>>> I know about this "written" restriction
>>>> (for tiSDK, and it's not TRM after all ...),
>>>> it can be avoided and it's partly avoided now ...
>>>
>>> I'd like to clarify point about supporting same VLANs in dual_mac mode,
>>> to avoid future misunderstanding, overall: it's *not* supported as
>>> adding same VLAN to both netdevices will cause unknown unicast packets
>>> leaking between interfaces and it can't be avoided - hw limitation.
>>
>> Simple test shows no issues with ucast leaking.
>> But for current buggy ucast vlan implementation it's not possible to verify,
>> not sure but probably leaking in your case cuased by hidden toggling of
>> interface to promisc while added ucast to vlans or other reason or so.
>> Anyway I just decided to check specifically ucasts
>> (macst as you know are not normal now).
>>
>> For verification you need to apply ucast fix (including vlans) first:
>> https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/log/?h=vlan_addr_flt_fix
>>
>> This is generic fix (not sure it will be approved, need try RFC) but implement
>> the same as local fix for vlan ucasts:
>> https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/log/?h=ucast_vlan_fix
>>
>> Any of those are correct. I've used generic one.
>> Applied the following scheme:
>>
>>                      +--------------------------+
>>                      | host 74:DA:EA:47:7D:9C   |
>>                      +--------------------------+
>>
>>                         +---------------------+
>>              |       am572 evm     |
>>                         |    eth0      eth1   |
>>                         +----------+----------+
>>                         | eth0.400 | eth1.400 |
>>                         +----------+----------+
>>                             ^          |
>>                             |          |  +-----------+
>> +-----------------+        |          |  |     PC    |
>> | BBB eth0.400    |--------+          +->| Wireshark |
>> +-----------------+                      +-----------+
>>
>>
>> 1) Configure vlans on am572x evm
>> ip link add link eth0 name eth0.400 type vlan id 400
>> ip link add link eth1 name eth1.400 type vlan id 400
>>
>> 2) On BBB side:
>> # ip link add link eth0 name eth0.400 type vlan id 400
>> Send ucast vlan traffic to the am572 evm, vlan ucast address is unreq on am572.
>> # ./plget -i eth0.400 -t ptpl2 -m tx-lat -n 160 -s 10 -a 74:DA:EA:47:7D:66
>> # ./plget -i eth0.400 -t ptpl2 -m tx-lat -n 160 -s 10 -a 18:03:73:66:87:42
>>
>> 3) Observe silence on PC wireshark.
>>
>> Thus, no see issues with this.
>>
>> PS: I'm sure in plget tool, you can use your own.
>
>I'm using packeth to generate udp packets (vlan) src=PC dst=unknown
>if there is record in ALE table which looks like:
>type: vlan , vid = 100, untag_force = 0x0, reg_mcast = 0x7, unreg_mcast = 0x0, member_list = 0x7
>then above udp packet will be forwarded to BBB.
Agree, seems no normal way to avoid ucast leak.

>
>
>
>-- 
>regards,
>-grygorii

-- 
Regards,
Ivan Khoronzhuk

Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C78C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2552720863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="coYYrFFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2552720863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeLABEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:04:46 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46950 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeLABEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:04:46 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so5037891ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 05:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5/C1a4u1mY4bbjhai9XzRxkzR68AsDJhM3CX2sE3MSg=;
        b=coYYrFFMLvNbUhkc0EhGrrqZCm8yBtOQBpw98EVRhCWDSLF9bUwcs2CeLxRH/TYxcq
         x5Vll0k7vk2rZGBdd+hcyO4I1SVuUaZS70tJi8haeSo/V+KjO2Qi5io+ZJbeRO3fjRi8
         rGNi4rVdLJlEaXN8DUNuzn6RKqJW/DvMEHtWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5/C1a4u1mY4bbjhai9XzRxkzR68AsDJhM3CX2sE3MSg=;
        b=ecK1dvixIxDg8++XFaR6LwvxpTSnM8Ydh8wnqT1LjuKLkeZoZu9X5quAHUMHzksNFN
         g0mXsUAnnfkSZjUV/YIT9SlffSG9p0iJaGJ/pJuR6Szw2DQe8/DSyKpU3/tpjJcDVVuc
         T3eSu1LhnAfeMVb1Jf/ee4iN2fMdMhJwydcM2eKPMGaTIgchJplwBTh4OjqiZ8IP3r3o
         U5e0f34q5eH2HKPJO4LjftGL6Su+yB4PayTy3o1p2c6pF4fMp+AXG25pyt350T7xRvSH
         P5VWAOFkjQxy5VokaL9S5UFjB+R4Sh0wjIUmKJvTGLgOqUNu61Xfunbw2eulZZUa9Bx+
         Xoxw==
X-Gm-Message-State: AA+aEWbeTnyPaFwPaZnYLjl6ZQVxQa2nRk1NvVZcAVgvvwIS49Iz02Rr
        v5toy3xF5Ord7ipFKlrFXWLSYAvUrwyENg==
X-Google-Smtp-Source: AFSGD/WDkI8AcJz0xnncAlk72AbB+ZoGuRS36GlmUfgaKHyuE7FcymEWIZauRPfZlrHk6wBBTg4VVA==
X-Received: by 2002:a2e:5054:: with SMTP id v20-v6mr3915494ljd.45.1543586120315;
        Fri, 30 Nov 2018 05:55:20 -0800 (PST)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id a20-v6sm800851ljf.28.2018.11.30.05.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 05:55:19 -0800 (PST)
Date:   Fri, 30 Nov 2018 15:55:17 +0200
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: drop vid0
 configuration in dual_mac modey
Message-ID: <20181130135516.GE23230@khorivan>
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
 <20181130134228.GD23230@khorivan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181130134228.GD23230@khorivan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 03:42:29PM +0200, Ivan Khoronzhuk wrote:
>On Thu, Nov 29, 2018 at 05:23:09PM -0600, Grygorii Strashko wrote:
>>
>>
>>On 11/29/18 9:26 AM, Ivan Khoronzhuk wrote:
>>>On Wed, Nov 28, 2018 at 03:15:46PM -0600, Grygorii Strashko wrote:
>>>>
>>>>
>>>>On 11/26/18 2:07 PM, Ivan Khoronzhuk wrote:
>>>>>On Mon, Nov 26, 2018 at 12:57:20PM -0600, Grygorii Strashko wrote:
>>>>>>
>>>>>>
>>>>>>On 11/26/18 10:26 AM, Ivan Khoronzhuk wrote:
>>>>>>>On Sun, Nov 25, 2018 at 05:46:26PM -0600, Grygorii Strashko wrote:
>>>>>>>>In dual_mac mode CPSW driver uses vid1 and vid2 by default to implement
>>>>>>>>dual mac mode wich are used to configure pvids for each external ports.
>>>>>>>>But, historicaly, it also adds vid0 to ALE table and sets "untag" bits for both
>>>>>>>>ext. ports. As result, it's imposible to use priority tagged packets in
>>>>>>>>dual mac mode.
>>>>>>>>
>>>>>>>>Hence, drop vid0 configuration in dual mac mode as it's not required for dual
>>>>>>>>mac mode functionality and, this way, make it possible to use priority
>>>>>>>>tagged packet in dual mac mode.
>>>>>>>So, now it's enabled to be added via regular ndo.
>>>>>>>I have similar change in mind, but was going to send it after
>>>>>>>mcast/ucast, and - enabling same vlans patch...
>>>>>>>
>>>>>>>2 things stopped me to add this:
>>>>>>>
>>>>>>>1) Moving it to be enabled via regular call is Ok, but in dual mac mode
>>>>>>>it causes overlaps, at least while vid deletion. So decided to wait till
>>>>>>>same vlans series is applied.
>>>>>>
>>>>>>TI driver documentation mentions this restriction
>>>>>>"While adding VLAN id to the eth interfaces,
>>>>>>same VLAN id should not be added in both interfaces which will lead to VLAN
>>>>>>forwarding and act as switch"
>>>>>It's not accurate now.
>>>>>This sw bug "acting like a switch" was fixed indirectly in LKML ).
>>>>>And at least for upstream version, not TISDK, desc should be updated,
>>>>>but better do this when it fixed completely and merged with TISDK.
>>>>>
>>>>>I know about this "written" restriction
>>>>>(for tiSDK, and it's not TRM after all ...),
>>>>>it can be avoided and it's partly avoided now ...
>>>>
>>>>I'd like to clarify point about supporting same VLANs in dual_mac mode,
>>>>to avoid future misunderstanding, overall: it's *not* supported as
>>>>adding same VLAN to both netdevices will cause unknown unicast packets
>>>>leaking between interfaces and it can't be avoided - hw limitation.
>>>
>>>Simple test shows no issues with ucast leaking.
>>>But for current buggy ucast vlan implementation it's not possible to verify,
>>>not sure but probably leaking in your case cuased by hidden toggling of
>>>interface to promisc while added ucast to vlans or other reason or so.
>>>Anyway I just decided to check specifically ucasts
>>>(macst as you know are not normal now).
>>>
>>>For verification you need to apply ucast fix (including vlans) first:
>>>https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/log/?h=vlan_addr_flt_fix
>>>
>>>This is generic fix (not sure it will be approved, need try RFC) but implement
>>>the same as local fix for vlan ucasts:
>>>https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/log/?h=ucast_vlan_fix
>>>
>>>Any of those are correct. I've used generic one.
>>>Applied the following scheme:
>>>
>>>                     +--------------------------+
>>>                     | host 74:DA:EA:47:7D:9C   |
>>>                     +--------------------------+
>>>
>>>                        +---------------------+
>>>             |       am572 evm     |
>>>                        |    eth0      eth1   |
>>>                        +----------+----------+
>>>                        | eth0.400 | eth1.400 |
>>>                        +----------+----------+
>>>                            ^          |
>>>                            |          |  +-----------+
>>>+-----------------+        |          |  |     PC    |
>>>| BBB eth0.400    |--------+          +->| Wireshark |
>>>+-----------------+                      +-----------+
>>>
>>>
>>>1) Configure vlans on am572x evm
>>>ip link add link eth0 name eth0.400 type vlan id 400
>>>ip link add link eth1 name eth1.400 type vlan id 400
>>>
>>>2) On BBB side:
>>># ip link add link eth0 name eth0.400 type vlan id 400
>>>Send ucast vlan traffic to the am572 evm, vlan ucast address is unreq on am572.
>>># ./plget -i eth0.400 -t ptpl2 -m tx-lat -n 160 -s 10 -a 74:DA:EA:47:7D:66
>>># ./plget -i eth0.400 -t ptpl2 -m tx-lat -n 160 -s 10 -a 18:03:73:66:87:42
>>>
>>>3) Observe silence on PC wireshark.
>>>
>>>Thus, no see issues with this.
>>>
>>>PS: I'm sure in plget tool, you can use your own.
>>
>>I'm using packeth to generate udp packets (vlan) src=PC dst=unknown
>>if there is record in ALE table which looks like:
>>type: vlan , vid = 100, untag_force = 0x0, reg_mcast = 0x7, unreg_mcast = 0x0, member_list = 0x7
>>then above udp packet will be forwarded to BBB.
>Agree, seems no normal way to avoid ucast leak.

One of the ways could be removing end ports as memembers, leaving only port0:

type: vlan , vid = 100, untag_force = 0x0, reg_mcast = 0x7, unreg_mcast = 0x0, member_list = 0x1

and allow tagged packets to be received by ports beeing non memebers of a vlan:

       cpsw_ale_control_set(cpsw->ale, slave_port,
			    ALE_PORT_DROP_UNKNOWN_VLAN, 0);

So that only unknown vlans are dropped...

>
>>
>>
>>
>>-- 
>>regards,
>>-grygorii
>
>-- 
>Regards,
>Ivan Khoronzhuk

-- 
Regards,
Ivan Khoronzhuk

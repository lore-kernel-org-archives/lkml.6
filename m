Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF85C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15E3215FA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFxOJ9Go"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15E3215FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbeHNVSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 17:18:45 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:41828 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbeHNVSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 17:18:44 -0400
Received: by mail-qt0-f177.google.com with SMTP id e19-v6so22176467qtp.8;
        Tue, 14 Aug 2018 11:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nX22DCe/tmWUT+XDOTFbpsgKr9JAH3yms2DjWUABrmo=;
        b=VFxOJ9GoCIFJ+AYrt3+m94ERAPxrPcFo3O3T0AAeWyCgU0ksJ6ba59xMS+9YTlJ+Ep
         m5h/J9/DgRpqiIZaYaCfsfFCazZoZ/QUAYeleJLBMTJeyojcwvdxefmhogBPJ/bLUFSI
         LSVSYWm8KnZOUwu3UAsqEYz29HcVT9jIiMNiro9qbnYL4t/dPcJbonQz0FtEURtjin2R
         2HpiGTQ1snQMcvjUumBw3F6MMuYXRk74gufGgzzU9NytdlsEGcDd+zEpRDm+NmPEtS0z
         7zNLwuhDWgo7DBNcjhIjVq8muvc1TUG+VKzda1IZgJuqBxqmGMdxYrYnVS8WpCAz28Q0
         2UVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nX22DCe/tmWUT+XDOTFbpsgKr9JAH3yms2DjWUABrmo=;
        b=aoviy+iWwbjXfHDQ/TubFOlDXcXoC0+oJ6WHW0HeEOQmJxVyB688G4p22UOKtt9fhM
         W40VpMKYpiYwdnTO8uFcxvfe5uFVqR0fwi2VVQtZQZaEeFoqSjR4LzV6DN2WYKSoPzSX
         MctZOztFRD4SgR62t35ESTk38qDQNsEgJsTbsAnhD4oz5Zsjh7/3Rl1m8EUjR7gecsEH
         lptsMrqIOz41giXgJ2dwEfHhJ7UXbIGBW/i958kC/W8F5qxM7Wj/yovviqhgJBMJOleX
         8Grr+7o5kYfpF+P/CqmTJtguSiZjieDsMr8ruY2m2PKPObApQ0wG+P8ixo1UfXhATmYw
         OXGw==
X-Gm-Message-State: AOUpUlGcS8FipxNpUdFdAgOyk9Bt7HIgUzMRpBFWxjQ6t3OdUAUtf2ko
        n3zzXCTkePsSlPn8wvTdNmbGeUxa
X-Google-Smtp-Source: AA+uWPw0plOxL3MlVP+iSxAjEzhcm01WhWPTuPp4Z0K7qxRrrX7YTQmesqjMIdRjnIKa8BArEXZDVQ==
X-Received: by 2002:a0c:8a6f:: with SMTP id 44-v6mr19438345qvu.120.1534271417805;
        Tue, 14 Aug 2018 11:30:17 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id x7-v6sm14103871qtc.66.2018.08.14.11.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 11:30:16 -0700 (PDT)
Subject: Re: [PATCH RFT] net: dsa: Allow configuring CPU port VLANs
To:     Petr Machata <petrm@mellanox.com>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org, jiri@mellanox.com,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
References: <20180624153339.13572-1-f.fainelli@gmail.com>
 <wih4lhrgrfd.fsf@dev-r-vrt-156.mtr.labs.mlnx> <20180625091713.GA13442@apalos>
 <9ce291a4-b40d-81d8-1c1a-c4311e5cc113@gmail.com>
 <wihva8csth9.fsf@dev-r-vrt-156.mtr.labs.mlnx>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <73136eef-01d7-ef33-629a-2a003cd769da@gmail.com>
Date:   Tue, 14 Aug 2018 11:30:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <wihva8csth9.fsf@dev-r-vrt-156.mtr.labs.mlnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 11:17 AM, Petr Machata wrote:
> Florian Fainelli <f.fainelli@gmail.com> writes:
> 
>> On 06/25/2018 02:17 AM, Ilias Apalodimas wrote:
>>> On Mon, Jun 25, 2018 at 12:13:10PM +0300, Petr Machata wrote:
>>>> Florian Fainelli <f.fainelli@gmail.com> writes:
>>>>
>>>>>  	if (netif_is_bridge_master(vlan->obj.orig_dev))
>>>>> -		return -EOPNOTSUPP;
>>>>> +		info.port = dp->cpu_dp->index;
>>>>
>>>> The condition above will trigger also when a VLAN is added on a member
>>>> port, and there's no other port with that VLAN. In that case the VLAN
>>>> comes without the BRIDGE_VLAN_INFO_BRENTRY flag. In mlxsw we have this
>>>> to get the bridge VLANs:
>>>>
>>>> 	if (netif_is_bridge_master(orig_dev)) {
>>>> 		[...]
>>>> 		if ((vlan->flags & BRIDGE_VLAN_INFO_BRENTRY) &&
>>>> 		[...]
>>>>
>>>> This doesn't appear to be done in DSA unless I'm missing something.
>>> Petr's right. This will trigger for VLANs added on 'not cpu ports' if the VLAN
>>> is not already a member. 
>>>
>>> This command has BRIDGE_VLAN_INFO_BRENTRY set:
>>> bridge vlan add dev br0 vid 100 pvid untagged self 
>>> I had the same issue on my CPSW RFC and solved it
>>> exactly the same was as Petr suggested.
>>
>> Humm, there must be something obvious I am missing, but the following
>> don't exactly result in what I would expect after adding a check for
>> vlan->flags & BRIDGE_VLAN_INFO_BRENTRY:
>>
>> brctl addbr br0
>> echo 1 > /sys/class/net/br0/bridge/vlan_filtering
>> brctl addif br0 lan1
> 
> From what I see, the CPU port is configured with VLAN 1 as soon as the
> bridge is created:
> 
> # brctl addbr br
> # bridge v sh dev br
> port    vlan ids
> br       1 PVID Egress Untagged
> 
> I expect there are events for this (but I didn't check), but the driver
> won't see them, because it doesn't have any ports attached to the bridge
> yet.

Correct, there are no ports attached yet.

> 
>> #1 results in lan1 being programmed with VID 1, PVID, untagged, but not
>> the CPU port. I would have sort of expected that the bridge layer would
>> also push the configuration to br0/CPU port since this is the default VLAN:
>>
>> bridge vlan show dev br0
>> port	vlan ids
>> br0	1 PVID Egress Untagged
> 
> OK, apparently we are talking past each other. When you say "CPU port",
> is "br0" not what you have in mind? Because I see 1 configured at br0 in
> your listings.

Yes, when I write "CPU/management" port, I mean br0 here, or at least,
when we see an event targeting br0, we re-generate it to target the
CPU/management port of the switch here.

VLAN 1 is definitively added to the br0 interface as a BR_ENTRY but we
also need to program the CPU port of the switch to be in this VLAN entry.

> 
>> bridge vlan add vid 2 dev lan1
>>
>> #2 same thing, results in only lan1 being programmed with VID 2, tagged
>> but that is expected because we are creating the VLAN only for the
>> user-facing port.
>>
>> bridge vlan add vid 3 dev br0 self
>>
>> #3 results in the CPU port being programmed with VID 3, tagged, again,
>> this is expected because we are only programming the bridge master/CPU
>> port here.
>>
>> Does #1 also happen for cpsw and mlxsw or do you actually get events
>> about the bridge's default VLAN configuration? Or does the switch driver
>> actually need to obtain that at the time the port is enslaved somehow?
> 
> I don't think we care about the CPU port in mlxsw. If the packet matches
> one of the local MACs, it gets trapped anyway, so all this stuff is then
> handled in slow path.

OK, that makes sense, you really don't have a notion of a CPU/management
port like we do in DSA switches.

On those switches, the Ethernet MAC is connected to the management port
of the switch, and so, at the time you enslave the first user-facing
port, we must configure both the CPU/management port of the switch as
well as the user-facing port to be within the desired VLAN IDs (and
attributes) in order for packets to ingress (when vlan_filtering is
enabled).

I suppose the way forward is to either query the bridge layer for the
default_pvid at the time of enslavement of the ports, or, "replay" the
event that led to the creation of the default br0 VLAN entry? First
option means we can make this specific to DSA (and similar
configurations) whereas the other means we might have to update all
switchdev drivers and possibly ignore that "replay" event.

Does that make sense?
-- 
Florian

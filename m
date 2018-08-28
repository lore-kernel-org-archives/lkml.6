Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6135FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAD720880
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuSIU4si"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CAD720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeH1Uup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:50:45 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32776 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH1Uup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:50:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id i134-v6so2380626wmf.0;
        Tue, 28 Aug 2018 09:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DNkNL1Tf/iY7oXGJFr32r4GuFNlWAA/VkOoCQ3by9R0=;
        b=UuSIU4siw49HplEOxgV52FXQBox9yYIY0bGewjj5dgANpPWL9fbzJ1svz/SFG8yRNd
         0vb6pM6YgZHgxLEmCHmqM14DfUNlYwTQ+9LFAeDDPAbpCj1UI5+xjNDPM461KJZ1z3r9
         Srv0P2f14IRWc0Ys0NO4ZbKUpNNSN8o7PTM2X+j164YMVB5NAfIQw828nOeP4hApKSNx
         CYrXw/E1WeoPuIAe3ES0RRK4xq0iQf7sGrJ+DOSmHEhJ/sXdnfdAdYO4ufdt7cTrCHBW
         nlgz+LpOibTTXoIckaZ5pmJfSd4GkDSqVpegK75ISJbWxNvNtg4NaCAGdiy9lJf3/G5U
         xBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DNkNL1Tf/iY7oXGJFr32r4GuFNlWAA/VkOoCQ3by9R0=;
        b=OcLHnoDjRyV5SgOZbN/Q0IWttTz883lmrjX58nzXmaTzwJ4DtlCO7tKE7K0mjKCdPV
         lD30gQ7BWVpKDbFbmoKcWGwehZPuJupDOGiTO9fx1cdcDRvPpOgUIPAZ9NBWNjG+Pk8f
         9A5L4Uwathx/9gIEJbMSVttE1c1PSQ0dgmo7WXhNulo+iP/vpgt9/eTAsoIuEg95V3KS
         G5V5EH2yXoR6p7REJJqHuArr9hCUCxwaQ6ZbQTX9wfmYhJjcMnsQUwNEAKrm7cT6CXPu
         hwXZlr78hO3YPopM32XMTruBwKa+3SLNsWQo2I3pgJcmTsoY5ighUDp0eDCjT/Vt+shv
         bhRQ==
X-Gm-Message-State: APzg51BhtNdyD34UFgwoBAG/N8GdZpBO17lYc5AXb1ZmOkDZb5m7K3wO
        OmSgS8eoD0+DbTKpzQ7rgHFxVP5B
X-Google-Smtp-Source: ANB0VdYvCYcnWRHSN0Bx0nAwCS9WLWt1FZPP/ycyNicWYgoNae0fgPR75FRhGS/crF2WOHHQmbwtpg==
X-Received: by 2002:a1c:9692:: with SMTP id y140-v6mr1883512wmd.82.1535475490223;
        Tue, 28 Aug 2018 09:58:10 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id w18-v6sm3633697wrc.38.2018.08.28.09.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 09:58:09 -0700 (PDT)
Subject: Re: [PATCH RFT] net: dsa: Allow configuring CPU port VLANs
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org,
        jiri@mellanox.com, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
References: <20180624153339.13572-1-f.fainelli@gmail.com>
 <wih4lhrgrfd.fsf@dev-r-vrt-156.mtr.labs.mlnx> <20180625091713.GA13442@apalos>
 <9ce291a4-b40d-81d8-1c1a-c4311e5cc113@gmail.com>
 <20180828083257.GA10872@apalos>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <da1a9896-94aa-589c-3fd2-023b1586bb15@gmail.com>
Date:   Tue, 28 Aug 2018 09:58:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828083257.GA10872@apalos>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 01:32 AM, Ilias Apalodimas wrote:
> On Fri, Aug 10, 2018 at 04:58:10PM -0700, Florian Fainelli wrote:
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
>>
>> #1 results in lan1 being programmed with VID 1, PVID, untagged, but not
>> the CPU port. I would have sort of expected that the bridge layer would
>> also push the configuration to br0/CPU port since this is the default VLAN:
>>
>> bridge vlan show dev br0
>> port	vlan ids
>> br0	1 PVID Egress Untagged
>>
>> But it does not.
>>
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
> As long as ports are attached you get the events (one event per attached port
> iirc)
> if the event is checked against BRIDGE_VLAN_INFO_BRENTRY, the only way to add a
> VLAN to the cpu port is via 'bridge vlan add vid 3 dev br0 self'

Do we have a guarantee that upon port enslavement, whatever default_pvid
is configured on the bridge master device also happens to be the port's
default_pvid settings as well?
-- 
Florian

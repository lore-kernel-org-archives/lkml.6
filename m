Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4282CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C0C21902
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSrXZGi4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404421AbfBMQRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:17:22 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39468 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404404AbfBMQRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:17:22 -0500
Received: by mail-lj1-f196.google.com with SMTP id g80so2517665ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 08:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WVnEQY7LS4Nsx8+VXOYwYXUc4h4ezweR5+RLyLjE98s=;
        b=WSrXZGi4hMdUCufXDOu3UeqUjdSxseASt1ReLZEWovIXZR0RIyGKHctgfv5ZCFsA2M
         vSHeiXULTp/Qp8a1m1HW2WWY2GCy9cgVpybJ/b6o/aZ777JoEcuvXopJ8SRX+4gznd1k
         R/6FKT1suPUPgVBAz68IUrOXQlafw0PAlEJ7J/ZYZQCZn72acuYOFtzztwK1aXAAW2ja
         YyhgDLHf2hrGAOKmie82U1KmvQJwh+k53pxb9cTWPFQgD87Fpd8fhs7iChjcQwTD46kR
         czXzjjJyR5R/2w2QlrvbfGbJKp4dvnYYGZTgwa4KOPcs6xjblON5IVL4LugJP/P38H6p
         vK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WVnEQY7LS4Nsx8+VXOYwYXUc4h4ezweR5+RLyLjE98s=;
        b=QQuwccna/e1Xh6lYO2hlq29fbqZWhxPQb8J/wMbwVcbjIsA5Y7xWH7hbq+jQldD0ds
         OIAVFHviE4R+8aOYYUlVvZWcvwy5hDIjEk4y0p13Oc0FjEgRB3WoLnX07dqQZupS+2Iz
         klHjUZOm9+x4527IRYdgd8Yj4qYBK9iHMg9YcTJ8ucqEHINz9868SpaTJhfPVWGZHjzV
         +Nqo4AWX0XyxNzznB+e3t2iHO8xYsU71mjyrt5o/lgQCaJbAKS7SPLvvP5CHHJue/nl/
         94gIARLv4m82hX9wnu1r+KSFeWrOXMEfUy8azb6IP2xh3ceJPi9whA/fzcskXPBnUorG
         Eaqg==
X-Gm-Message-State: AHQUAuYzoJ7vrVgqmfRmJ+YKMXbn+XY/elSAIw8uuv5xerWEdfydBvKZ
        //KA7TAPK6j+qG50qx4If9JKkg==
X-Google-Smtp-Source: AHgI3IZapW1B2qA0se6TirB5RhzIncPbPvc1v/I2g/SuufxLp6Pbso6e8oPy7lTgVFFC05nfj16vUA==
X-Received: by 2002:a2e:8e9a:: with SMTP id z26-v6mr706823ljk.158.1550074639206;
        Wed, 13 Feb 2019 08:17:19 -0800 (PST)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id s27-v6sm3508797ljd.64.2019.02.13.08.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 08:17:18 -0800 (PST)
Date:   Wed, 13 Feb 2019 18:17:16 +0200
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com, andrew@lunn.ch
Subject: Re: [RFC PATCH net-next 2/5] net: 8021q: vlan_dev: add vid tag for
 uc and mc address lists
Message-ID: <20190213161715.GA32249@khorivan>
Mail-Followup-To: Florian Fainelli <f.fainelli@gmail.com>,
        davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@mellanox.com, andrew@lunn.ch
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
 <20181203184023.3430-3-ivan.khoronzhuk@linaro.org>
 <b2a7baa7-b334-0f6f-c119-a2f30ac68c7b@gmail.com>
 <20181203235119.GF23230@khorivan>
 <35479973-2d2d-d673-f7ab-54d6369ce3d1@gmail.com>
 <20181204185720.GI23230@khorivan>
 <756cbb25-3062-91e8-0613-66bb887f937e@gmail.com>
 <20181204234236.GA3507@khorivan>
 <4cf42ef9-7136-15ff-1244-1d946acd07ae@gmail.com>
 <20190122131239.GC3125@khorivan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190122131239.GC3125@khorivan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 03:12:41PM +0200, Ivan Khoronzhuk wrote:
>On Mon, Jan 21, 2019 at 03:37:41PM -0800, Florian Fainelli wrote:
>>On 12/4/18 3:42 PM, Ivan Khoronzhuk wrote:
>>>On Tue, Dec 04, 2018 at 11:49:27AM -0800, Florian Fainelli wrote:
>
>[...]
>
>>
>>Ivan, based on the recent submission I copied you on [1], it sounds like
>>we want to move ahead with your proposal to extend netdev_hw_addr with a
>>vid member.
>>
>>On second thought, your approach is good and if we enclose the vid
>>member within an #if IS_ENABLED(CONFIG_VLAN)8021Q) we should be good for
>>most foreseeable use cases, if not, we can always introduce a variable
>>size/defined context in the future.
>>
>>Can you resubmit this patch series as non-RFC in the next few days so I
>>can also repost mine [1] and take advantage of these changes for
>>multicast over VLAN when VLAN filtering is globally enabled on the device.
>>
>>[1]: https://www.spinics.net/lists/netdev/msg544722.html
>>
>>Thanks!
>
>Yes, sure. I can start to do that in several days.
>Just a little busy right now.
>
>Just before doing this, maybe some comments could be added as it has more
>attention now. Meanwhile I can send alternative variant but based on
>real dev splitting addresses between vlans. In this approach it leaves address
>space w/o vid extension but requires more changes to vlan core. Drawback here
>that to change one address alg traverses all related vlan addresses, it can be
>cpu/time wasteful, if it's done regularly, but saves memory....
>
>Basically it's implemented locally in cpsw and requires more changes to move
>it as some vlan core auxiliary functions to be reused. But it can work only
>with vlans directly on top of real dev, which is fixable.
>
>Core function here:
>__hw_addr_ref_sync_dev
>it is called only for address the link of which was increased/decreased, thus
>update made only on one address, comparing it for every vlan dev.
>
>It was added with this patch:
>[1] net: core: dev_addr_lists: add auxiliary func to handle reference 
>address update e7946760de5852f32
>
>And used by this patch:
>[2] net: ethernet: ti: cpsw: fix vlan mcast 15180eca569bfe1d4d
>
>So, idea is to move [2] to be vlan core auxiliary function to be reused
>by NIC drivers.
>
>But potentially it can bring a little more changes I assume:
>
>1) add priv_flag |= IFF_IV_FLT (independent vlan filtering). It allows to reuse
>this flag for farther changes, probably for per vlan allmulti or so.
>
>2) real dev has to have complete list for vlans, not only their vids, but also
>all vlandevs in device chain above it. So changes in add_vid can be required.
>Vlan core can assign vlan dev pointer to real device only after it's completely
>initialized. And for propagation reasons it requires every device in
>infrastructure to be aware. That seems doable, but depends not only on me.
>
>3) Move code from [2] to be auxiliary vlan core API for setting mc and uc.
>From this patch only one function is cpsw specific: cpsw_set_mc(). The rest can
>be applicable on every NIC supporting IFF_IV_FLT.
>
>4) Move code from link below to do the same but for uc addresses:
>https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/commit/?h=ucast_vlan_fix&id=ebc88a7d8758759322d9ff88f25f8bac51ce7219
>here only one func cpsw specific: cpsw_set_uc()
>the rest can be generic.
>
>As third alternative, we can think about how to reduce memory for addresses by
>reusing them or else, but this is as continuation of addr+vid approach, and API
>probably would be the same.
>
>Then all this can be compared for proper decision.


Hi Florian,

After several more investigations and tries probably better left this
idea as is.

Here actually several explanations for this:
1) If even assume that we can get access to vlan devices in the above ndev
tree (we can) that doesn't guarantee that receive vlan filters are set
replicating this structure. For example bond device can have one active slave
but both of them in the tree having vid set, in this case addresses are
syched only with active slave, no filters should be applied to not active slave.
this can be achieved only each address has vid context.

2) According to 1) rx filters device structure can be created while mc_sync()
in each rx_mode(), and then used as orthogonal info. I've tried and it looks
not cool and consumes anyway memory and even if it's less it's still not very
scalable. (+ no normal signal "in complex structure case" when address should
be undated to avoid redundant cpu cycles). Not sure it can have practical
results and be universal enouph.

3) Assuming that every device in the tree (bond, team or else) is legal to
modify its own address space, the real end device cannot be sure the vlan device
address spaces reflects vid addresses that device tree want's from him.
According to this each address in address space must hold its own context at
every device and this context is comparable with address size.

>-- Regards,
>Ivan Khoronzhuk

-- 
Regards,
Ivan Khoronzhuk

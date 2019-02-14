Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E857C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB4821900
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7f6uoA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438658AbfBNNDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:03:31 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41265 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732064AbfBNNDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:03:30 -0500
Received: by mail-lf1-f67.google.com with SMTP id e27so4467649lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 05:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SOdlzwnQtcIWP7BedVn9pYyrjQHqVqmpnSDUAwjA04Q=;
        b=o7f6uoA1CSnPOhviVZuZeMrhkvilPgI+wl8ujsU+Lrnl5BAuvYwE1FkIA3tcL23/Z7
         h3BhhjVK5R92/NTuKbljB5XOL+uF1SfVgiLy3lnfKyZlKf1h3URge2OmJ/zFYuVOGYbn
         63u7koHT71DbYFLce/cleF0CNdq9b8YKXQlP26rxZGBsie9pNMEqgKrCC/v2IE+GYFFz
         1CHidlmP5CCwD8Bc5Il4Z0v6mKaraCeLAjsuLxTdDTI9umSNz62UFq/cWCMHCiqnLrNM
         KKJ7AxazNkhXzXDugK8RnsOibbkxlFree+tnZ9LuCm3hymNTUeJFjYvHr0pps0ZDZ33h
         kDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=SOdlzwnQtcIWP7BedVn9pYyrjQHqVqmpnSDUAwjA04Q=;
        b=TbkSpL4EhL5xHwss8sqBcydP9I4VJCqbWwp1SjJacUWHBWXN8ojOlMcON99toB+6H6
         UFlt+4uSHncsyt8l7HZ95hxzuPm/o4SYZbewV3L8jpKCOh3meVg2YxDlK2VDS6yMcTft
         jwrcefSDekYq0pdEOnwWK0ZoZc3zyW1d2aWeulk30dMSwxqAkKckCuVyYYpoGRVWTaad
         CjUHm7+BQX2ZBC8taiFDXaL2O+/HIoBZZRx2xosmKVu8YGwcHtoNv4dEzMyty7YsIEKi
         1PvYPL/CZ+1TaDpumca2e4vmCIP8ShDb3+0cDXOrzuxkUPDTTgvqzGaGQeBSbQ3nyVZ4
         VySQ==
X-Gm-Message-State: AHQUAuZdbbfZPytmSWMWF0hAygmPNE/7iXUWWuB/vU6/lHaS6TYVKz+y
        37D8g8Li3Zw7a6TZIITOdteUXefrtao=
X-Google-Smtp-Source: AHgI3IYVbiCgmQFhNBFcW5crgB1LWlwIPy1wjWljGvnoVsit/E3PW6N29SaeumHjLs5jI7yWcPU/IA==
X-Received: by 2002:a19:920a:: with SMTP id u10mr672764lfd.122.1550149407489;
        Thu, 14 Feb 2019 05:03:27 -0800 (PST)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id b18sm126017lfj.97.2019.02.14.05.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 05:03:26 -0800 (PST)
Date:   Thu, 14 Feb 2019 15:03:24 +0200
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@mellanox.com, andrew@lunn.ch
Subject: Re: [RFC PATCH net-next 2/5] net: 8021q: vlan_dev: add vid tag for
 uc and mc address lists
Message-ID: <20190214130322.GB32249@khorivan>
Mail-Followup-To: Florian Fainelli <f.fainelli@gmail.com>,
        davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@mellanox.com, andrew@lunn.ch
References: <b2a7baa7-b334-0f6f-c119-a2f30ac68c7b@gmail.com>
 <20181203235119.GF23230@khorivan>
 <35479973-2d2d-d673-f7ab-54d6369ce3d1@gmail.com>
 <20181204185720.GI23230@khorivan>
 <756cbb25-3062-91e8-0613-66bb887f937e@gmail.com>
 <20181204234236.GA3507@khorivan>
 <4cf42ef9-7136-15ff-1244-1d946acd07ae@gmail.com>
 <20190122131239.GC3125@khorivan>
 <20190213161715.GA32249@khorivan>
 <BF485558-C29E-4F25-84B5-4C6C80BDF337@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <BF485558-C29E-4F25-84B5-4C6C80BDF337@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 08:49:39PM -0800, Florian Fainelli wrote:
>
>
>On February 13, 2019 8:17:16 AM PST, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:
>>On Tue, Jan 22, 2019 at 03:12:41PM +0200, Ivan Khoronzhuk wrote:
>>>On Mon, Jan 21, 2019 at 03:37:41PM -0800, Florian Fainelli wrote:
>>>>On 12/4/18 3:42 PM, Ivan Khoronzhuk wrote:
>>>>>On Tue, Dec 04, 2018 at 11:49:27AM -0800, Florian Fainelli wrote:
>>>
>>>[...]
>>>
>>>>
>>>>Ivan, based on the recent submission I copied you on [1], it sounds
>>like
>>>>we want to move ahead with your proposal to extend netdev_hw_addr
>>with a
>>>>vid member.
>>>>
>>>>On second thought, your approach is good and if we enclose the vid
>>>>member within an #if IS_ENABLED(CONFIG_VLAN)8021Q) we should be good
>>for
>>>>most foreseeable use cases, if not, we can always introduce a
>>variable
>>>>size/defined context in the future.
>>>>
>>>>Can you resubmit this patch series as non-RFC in the next few days so
>>I
>>>>can also repost mine [1] and take advantage of these changes for
>>>>multicast over VLAN when VLAN filtering is globally enabled on the
>>device.
>>>>
>>>>[1]: https://www.spinics.net/lists/netdev/msg544722.html
>>>>
>>>>Thanks!
>>>
>>>Yes, sure. I can start to do that in several days.
>>>Just a little busy right now.
>>>
>>>Just before doing this, maybe some comments could be added as it has
>>more
>>>attention now. Meanwhile I can send alternative variant but based on
>>>real dev splitting addresses between vlans. In this approach it leaves
>>address
>>>space w/o vid extension but requires more changes to vlan core.
>>Drawback here
>>>that to change one address alg traverses all related vlan addresses,
>>it can be
>>>cpu/time wasteful, if it's done regularly, but saves memory....
>>>
>>>Basically it's implemented locally in cpsw and requires more changes
>>to move
>>>it as some vlan core auxiliary functions to be reused. But it can work
>>only
>>>with vlans directly on top of real dev, which is fixable.
>>>
>>>Core function here:
>>>__hw_addr_ref_sync_dev
>>>it is called only for address the link of which was
>>increased/decreased, thus
>>>update made only on one address, comparing it for every vlan dev.
>>>
>>>It was added with this patch:
>>>[1] net: core: dev_addr_lists: add auxiliary func to handle reference
>>>address update e7946760de5852f32
>>>
>>>And used by this patch:
>>>[2] net: ethernet: ti: cpsw: fix vlan mcast 15180eca569bfe1d4d
>>>
>>>So, idea is to move [2] to be vlan core auxiliary function to be
>>reused
>>>by NIC drivers.
>>>
>>>But potentially it can bring a little more changes I assume:
>>>
>>>1) add priv_flag |= IFF_IV_FLT (independent vlan filtering). It allows
>>to reuse
>>>this flag for farther changes, probably for per vlan allmulti or so.
>>>
>>>2) real dev has to have complete list for vlans, not only their vids,
>>but also
>>>all vlandevs in device chain above it. So changes in add_vid can be
>>required.
>>>Vlan core can assign vlan dev pointer to real device only after it's
>>completely
>>>initialized. And for propagation reasons it requires every device in
>>>infrastructure to be aware. That seems doable, but depends not only on
>>me.
>>>
>>>3) Move code from [2] to be auxiliary vlan core API for setting mc and
>>uc.
>>>From this patch only one function is cpsw specific: cpsw_set_mc(). The
>>rest can
>>>be applicable on every NIC supporting IFF_IV_FLT.
>>>
>>>4) Move code from link below to do the same but for uc addresses:
>>>https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/commit/?h=ucast_vlan_fix&id=ebc88a7d8758759322d9ff88f25f8bac51ce7219
>>>here only one func cpsw specific: cpsw_set_uc()
>>>the rest can be generic.
>>>
>>>As third alternative, we can think about how to reduce memory for
>>addresses by
>>>reusing them or else, but this is as continuation of addr+vid
>>approach, and API
>>>probably would be the same.
>>>
>>>Then all this can be compared for proper decision.
>>
>>
>>Hi Florian,
>>
>>After several more investigations and tries probably better left this
>>idea as is.
>
>Thank you for keeping the thread alive, does that mean you are going to resubmit this patch series as-is (rebased) or are you saying that you are abandoning the idea and leaving the situation the way it is in cpsw?

I will resubmit this one. But:

I have to try one more approach before this.
The idea is to create simple rx flt device tree while mc/us sync.
Then use it at real device to dispatch addresses.

It increases hw_addr struct a little and code base,
But:
- no need to keep linearly all vlan addresses in one address space.
- replicates RX filtering struct of net devices,
  (but not logical tree of netdevs)
- keeps devs info per address.
- no need to change addr lenth and modify existent API
- access at any net dev to above rx flt device structure per address
- potentially can be use not only for vlan devs identification but for
  other rx path offloads.

Idea is simple but not completely verified it yet,
need a little bit more time to prove/clean ...or drop it.

>
>>
>>Here actually several explanations for this:
>>1) If even assume that we can get access to vlan devices in the above
>>ndev
>>tree (we can) that doesn't guarantee that receive vlan filters are set
>>replicating this structure. For example bond device can have one active
>>slave
>>but both of them in the tree having vid set, in this case addresses are
>>syched only with active slave, no filters should be applied to not
>>active slave.
>>this can be achieved only each address has vid context.
>>
>>2) According to 1) rx filters device structure can be created while
>>mc_sync()
>>in each rx_mode(), and then used as orthogonal info. I've tried and it
>>looks
>>not cool and consumes anyway memory and even if it's less it's still
>>not very
>>scalable. (+ no normal signal "in complex structure case" when address
>>should
>>be undated to avoid redundant cpu cycles). Not sure it can have
>>practical
>>results and be universal enouph.
>>
>>3) Assuming that every device in the tree (bond, team or else) is legal
>>to
>>modify its own address space, the real end device cannot be sure the
>>vlan device
>>address spaces reflects vid addresses that device tree want's from him.
>>According to this each address in address space must hold its own
>>context at
>>every device and this context is comparable with address size.
>>
>>>-- Regards,
>>>Ivan Khoronzhuk
>
>-- 
>Florian

-- 
Regards,
Ivan Khoronzhuk

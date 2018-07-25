Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B6CC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B0120882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EihZuKyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B0120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbeGYPSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:18:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35798 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbeGYPSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:18:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id q7-v6so1795795pff.2;
        Wed, 25 Jul 2018 07:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JBUV7RovKcrSLAj0p5RoCntaMNJIFMF8GArqBly2DFo=;
        b=EihZuKyhGnecw4ioRWlirRYb0pZfl4SYGp/1P5asbnfQiWPX9HMyyOrArnAKOQAaL5
         03xXeMuYUh+giWo/P8WLCBuQSyfaxSKSfCOKVGf+IRBZj0SMAxUTtzjZqZPXoOOzQ3s+
         rTsbWqsGwP0qlRiR86u2RnpgOG/i1TwJwxp3upSZa++BEyv9lqfMZesCDqdfgUG1VUSz
         HNbexUzQYkjaUsGIQn4+HBH9/xo2CQ5e07YOMnUfoMdiBhEtBOLbsWYnwmL0w1+VwdTf
         T6ynn8a7aw6Q03kGAPLLyE/hnouDLCsdjRv4oM+FNNelNM97WJLaRzU6s5jguBULyVXp
         C0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JBUV7RovKcrSLAj0p5RoCntaMNJIFMF8GArqBly2DFo=;
        b=V24TvbIl6PZwHnsf4pTfeNAMf+yljMRjFWKprFBKVlzkuRAzx+sv7+ORvD/7kO6JtN
         etSzNGQqvjuKWMtrQ3xwSeGfVSoOU0x6lT7NwZdh6nnSUc7FGnmCz1ydttH3swIdS6Tk
         gnVoYN1TMH2sPluyP5BTi5UFHMOU7luqHZfoB0A24h2I7V482Rm5I4TQbPlCPKZyy18o
         HOeSZ0ScomYPzsixfu1bDXqPaAJKkBd7zu+jcla1KytYdf4NDDit7oCtKk8sykAXG3zN
         bRykMzkmJyljJr6jApY2B+AT5w4BGSLYwpFrriyHFXqZA6kD8c57fWgykucDLeGxw90O
         nBCA==
X-Gm-Message-State: AOUpUlGSEoCjPzBm9TPgE503XHX5+BWkZqFPaFy6kt1AgVDUABJizPnS
        clvYLlotEkpw54DAvbqCAB67oaqv
X-Google-Smtp-Source: AAOMgpe/F7FAedokG9KSwH+pK5PEVvy+reUUd4udHJZuzzoBUVrQpEjnXVO6m8JVmaM6sXI1a1Gy8g==
X-Received: by 2002:a63:1f20:: with SMTP id f32-v6mr19948896pgf.84.1532527574188;
        Wed, 25 Jul 2018 07:06:14 -0700 (PDT)
Received: from dsa-mb.local ([2601:282:800:fd80:e4d8:8895:822a:720a])
        by smtp.googlemail.com with ESMTPSA id y27-v6sm34759843pff.181.2018.07.25.07.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 07:06:12 -0700 (PDT)
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to
 per-namespace
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        nikita.leshchenko@oracle.com,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Alexander Aring <alex.aring@gmail.com>,
        linux-wpan@vger.kernel.org,
        NetFilter <netfilter-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1a3f59a9-0ba5-c83f-16a6-f9550a84f693@gmail.com>
 <CAM_iQpWabZorkMNswyfHyS4KT=f_bgMtK8K35=84uah6Kfqxew@mail.gmail.com>
 <1a27e301-3275-b349-a2f8-afdfdc02f04f@gmail.com>
 <20180718.125938.2271502580775162784.davem@davemloft.net>
 <28c30574-391c-b4bd-c337-51d3040d901a@gmail.com>
 <CAM_iQpW4-JkZY7jXx0Q1b907hQ85UOL1eXv2YHwSukb5L=apUg@mail.gmail.com>
 <5021d874-8e99-6eba-f24b-4257c62d4457@gmail.com>
 <CAM_iQpUc-H2kZCBevePs6g-8qKyJkUhdd1ZDSQgYsCG0ChfC2w@mail.gmail.com>
 <87muufze8w.fsf@xmission.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <4b03b5f6-87ce-9ff2-7c14-598beebd8fb8@gmail.com>
Date:   Wed, 25 Jul 2018 08:06:10 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87muufze8w.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/18 6:33 AM, Eric W. Biederman wrote:
> Cong Wang <xiyou.wangcong@gmail.com> writes:
> 
>> On Tue, Jul 24, 2018 at 8:14 AM David Ahern <dsahern@gmail.com> wrote:
>>>
>>> On 7/19/18 11:12 AM, Cong Wang wrote:
>>>> On Thu, Jul 19, 2018 at 9:16 AM David Ahern <dsahern@gmail.com> wrote:
>>>>>
>>>>> Chatting with Nikolay about this and he brought up a good corollary - ip
>>>>> fragmentation. It really is a similar problem in that memory is consumed
>>>>> as a result of packets received from an external entity. The ipfrag
>>>>> sysctls are per namespace with a limit that non-init_net namespaces can
>>>>> not set high_thresh > the current value of init_net. Potential memory
>>>>> consumed by fragments scales with the number of namespaces which is the
>>>>> primary concern with making neighbor tables per namespace.
>>>>
>>>> Nothing new, already discussed:
>>>> https://marc.info/?l=linux-netdev&m=140391416215988&w=2
>>>>
>>>> :)
>>>>
>>>
>>> Neighbor tables, bridge fdbs, vxlan fdbs and ip fragments all consume
>>> local memory resources due to received packets. bridge and vxlan fdb's
>>> are fairly straightforward analogs to neighbor entries; they are per
>>> device with no limits on the number of entries. Fragments have memory
>>> limits per namespace. So neighbor tables are the only ones with this
>>> strict limitation and concern on memory consumption.
>>>
>>> I get the impression there is no longer a strong resistance against
>>> moving the tables to per namespace, but deciding what is the right
>>> approach to handle backwards compatibility. Correct? Changing the
>>> accounting is inevitably going to be noticeable to some use case(s), but
>>> with sysctl settings it is a simple runtime update once the user knows
>>> to make the change.
>>
>> This question definitely should go to Eric Biederman who was against
>> my proposal.
>>
>> Let's add Eric into CC.
> 
> Given that the entries are per device and the devices are per-namespace,
> semantically neighbours are already kept in a per-namespace manner.  So
> this is all about making the code not honoring global resource limits.
> Making the code not honor gc_thresh3.
> 
> Skimming through the code today the default for gc_thresh3 is 1024.
> Which means that we limit the neighbour tables to 1024 entries per
> protocol type.
> 
> There are some pretty compelling reasons especially with ipv4 to keep
> the subnet size down.  Arp storms are a real thing.
> 
> I don't know off the top of my head what the reasons for limiting the
> neighbour table sizes.  I would be much more comfortable with a patchset
> like this if we did some research and figured out the reasons why
> we have a global limit.  Then changed the code to remove those limits.
> 
> When the limits are gone.  When the code can support large subnets
> without tuning.  We we don't have to worry about someone scanning an all
> addresses in an ipv6 subnet and causing a DOS on working machines.
> I think it is completely appropriate to look to see if something per
> network namespace needs to happen.
> 
> So please let's address the limits, not the fact that some specific
> corner case ran into them.
> 
> If we are going to neuter gc_thresh3 let's go as far as removing it
> entirely.  If we are going to make the neighbour table per something
> let's make it per network device.  If we can afford the multiple hash
> tables then a hash table per device is better.   Perhaps we want to move
> to rhash tables while we look at this, instead of an old hand grown
> version of resizable hash table.

Given the uses cases with increasing number of devices (> 10,000),
per-device tables will have more problems than per namespace - in
reference to your concern in the last paragraph below.

> 
> Unless I misread something all your patchset did is reshuffle code and
> data structures so that gc_thresh3 does not apply accross namespaces.
> That does not feel like it really fixes anything.  That just lies to
> people.

This patch set fixes the lie that network namespaces provide complete
isolation when in fact one namespace can evict neighbor entries from
another. An arp storm you are concerned about in one namespace impacts
all containers.

It starts by removing the proliferation of open coded references to
arp_tbl and nd_tbl, moving them behind the existing neigh_find_table.
From there (patches 14-16) it makes the tables per-namespace and hence
makes the gc_thresh parameters which are per-table now
per-table-per-namespace.

So it removes the global thresholds because the global ones are just
wrong given the meaning of a network namespace and provides the more
appropriate per-namespace limits.

> 
> Further unless I misread something you are increasing the number of
> timers to 3 per namespace.  If I create create a thousand network
> namespaces that feels like it will hurt system performance overall.

It seems to me the timers are per neighbor entry not table. The per
table ones are for proxies.

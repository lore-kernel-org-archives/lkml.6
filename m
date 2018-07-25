Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86763C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF18205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF18205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbeGYNpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:45:21 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33223 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbeGYNpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:45:21 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fiIzG-0001Ra-4m; Wed, 25 Jul 2018 06:33:50 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fiIzE-0008LB-Pt; Wed, 25 Jul 2018 06:33:49 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     David Ahern <dsahern@gmail.com>,
        David Miller <davem@davemloft.net>,
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
Date:   Wed, 25 Jul 2018 07:33:35 -0500
In-Reply-To: <CAM_iQpUc-H2kZCBevePs6g-8qKyJkUhdd1ZDSQgYsCG0ChfC2w@mail.gmail.com>
        (Cong Wang's message of "Tue, 24 Jul 2018 15:09:25 -0700")
Message-ID: <87muufze8w.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fiIzE-0008LB-Pt;;;mid=<87muufze8w.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX187sLzmGWta+48ibDD+bkVYfPVl42k1m9g=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to per-namespace
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cong Wang <xiyou.wangcong@gmail.com> writes:

> On Tue, Jul 24, 2018 at 8:14 AM David Ahern <dsahern@gmail.com> wrote:
>>
>> On 7/19/18 11:12 AM, Cong Wang wrote:
>> > On Thu, Jul 19, 2018 at 9:16 AM David Ahern <dsahern@gmail.com> wrote:
>> >>
>> >> Chatting with Nikolay about this and he brought up a good corollary - ip
>> >> fragmentation. It really is a similar problem in that memory is consumed
>> >> as a result of packets received from an external entity. The ipfrag
>> >> sysctls are per namespace with a limit that non-init_net namespaces can
>> >> not set high_thresh > the current value of init_net. Potential memory
>> >> consumed by fragments scales with the number of namespaces which is the
>> >> primary concern with making neighbor tables per namespace.
>> >
>> > Nothing new, already discussed:
>> > https://marc.info/?l=linux-netdev&m=140391416215988&w=2
>> >
>> > :)
>> >
>>
>> Neighbor tables, bridge fdbs, vxlan fdbs and ip fragments all consume
>> local memory resources due to received packets. bridge and vxlan fdb's
>> are fairly straightforward analogs to neighbor entries; they are per
>> device with no limits on the number of entries. Fragments have memory
>> limits per namespace. So neighbor tables are the only ones with this
>> strict limitation and concern on memory consumption.
>>
>> I get the impression there is no longer a strong resistance against
>> moving the tables to per namespace, but deciding what is the right
>> approach to handle backwards compatibility. Correct? Changing the
>> accounting is inevitably going to be noticeable to some use case(s), but
>> with sysctl settings it is a simple runtime update once the user knows
>> to make the change.
>
> This question definitely should go to Eric Biederman who was against
> my proposal.
>
> Let's add Eric into CC.

Given that the entries are per device and the devices are per-namespace,
semantically neighbours are already kept in a per-namespace manner.  So
this is all about making the code not honoring global resource limits.
Making the code not honor gc_thresh3.

Skimming through the code today the default for gc_thresh3 is 1024.
Which means that we limit the neighbour tables to 1024 entries per
protocol type.

There are some pretty compelling reasons especially with ipv4 to keep
the subnet size down.  Arp storms are a real thing.

I don't know off the top of my head what the reasons for limiting the
neighbour table sizes.  I would be much more comfortable with a patchset
like this if we did some research and figured out the reasons why
we have a global limit.  Then changed the code to remove those limits.

When the limits are gone.  When the code can support large subnets
without tuning.  We we don't have to worry about someone scanning an all
addresses in an ipv6 subnet and causing a DOS on working machines.
I think it is completely appropriate to look to see if something per
network namespace needs to happen.

So please let's address the limits, not the fact that some specific
corner case ran into them.

If we are going to neuter gc_thresh3 let's go as far as removing it
entirely.  If we are going to make the neighbour table per something
let's make it per network device.  If we can afford the multiple hash
tables then a hash table per device is better.   Perhaps we want to move
to rhash tables while we look at this, instead of an old hand grown
version of resizable hash table.

Unless I misread something all your patchset did is reshuffle code and
data structures so that gc_thresh3 does not apply accross namespaces.
That does not feel like it really fixes anything.  That just lies to
people.

Further unless I misread something you are increasing the number of
timers to 3 per namespace.  If I create create a thousand network
namespaces that feels like it will hurt system performance overall.

Eric



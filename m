Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FF7C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB70205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB70205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388909AbeG0Rtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:49:55 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:43930 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730784AbeG0Rty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:49:54 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fj5aE-0006NY-C7; Fri, 27 Jul 2018 10:27:14 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fj5aD-0004nO-Gk; Fri, 27 Jul 2018 10:27:13 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     David Ahern <dsahern@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        "nikita.leshchenko\@oracle.com" <nikita.leshchenko@oracle.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "Saeed Mahameed" <saeedm@mellanox.com>,
        Alexander Aring <alex.aring@gmail.com>,
        "linux-wpan\@vger.kernel.org" <linux-wpan@vger.kernel.org>,
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
        <4b03b5f6-87ce-9ff2-7c14-598beebd8fb8@gmail.com>
        <87zhyfw70m.fsf@xmission.com>
        <be5c3f5be49e4e22bf1160a1d6d3a1b0@AcuMS.aculab.com>
Date:   Fri, 27 Jul 2018 11:27:06 -0500
In-Reply-To: <be5c3f5be49e4e22bf1160a1d6d3a1b0@AcuMS.aculab.com> (David
        Laight's message of "Thu, 26 Jul 2018 11:12:34 +0000")
Message-ID: <87k1pg1w6d.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fj5aD-0004nO-Gk;;;mid=<87k1pg1w6d.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18DuLPkLR4vYzZ4SYltuwqk4K9E1oVzPcw=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to per-namespace
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> writes:

> From: Eric W. Biederman
>> Sent: 25 July 2018 18:38
> ...
>> >> Further unless I misread something you are increasing the number of
>> >> timers to 3 per namespace.  If I create create a thousand network
>> >> namespaces that feels like it will hurt system performance overall.
>> >
>> > It seems to me the timers are per neighbor entry not table. The per
>> > table ones are for proxies.
>> 
>> It seems I misread that bit when I was refreshing my memory on what
>> everything is doing.  If we can already have 1024 timers that makes
>> timers not a concern.
>
> Surely it is enough to just have a timestamp in each entry.
> Deletion of expired items need not be done until insert (which
> has the table suitable locked) bumps into an expired item.

Part of the state machine the timer is used for is sending retransmits
before we get out first response, so the state machine is not just
about expiry and may not be simple enough to do without a timer.

I honestly don't remember the tradeoffs between the various kinds of
timers.  If we already can have up to 1000 timers without problems I suspect
they are cheap enough optimizing for fewer times simply doesn't matter.
Certainly we are not in regression territory if we don't.

As for bumping into expired items on insert it would be a bad hash table
if we were bumping into any other entries frequently on insert.

Eric

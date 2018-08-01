Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E63BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7B520894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlUweRnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7B520894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387616AbeHAMUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:20:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37064 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387568AbeHAMUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:20:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id a26-v6so7640971pfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 03:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EJ9gZt5ymPHJQTGM6KoCLKfxnXjQCunOLq9zbJJjjus=;
        b=mlUweRnXTB3YnTHEfnsctWnyBERxg6Yo8kRLfA8MEC+OWYKM2HF07qGdpmRCGT780j
         LB+2qrMC3KSP4lcFot9PwP7596Qes8BQwaW88VeXzF6s46TFVlJoEJYQJYgmH6w5yQLv
         aW2AEva0asLeh9SxOrepLPicQuK+8sPgQfJNH5AoPVqwta9e1Iaf1WKWLkwTC+nb1Lwc
         Nzre7CnGUhRb3pv6u0RFaKzLePtgQXRlIoD/ePWO9MrIKeJYyTB9iU4l8nNkNfaq4Fna
         vSLwB/oJolFnAsVoEYBxJBS5yyTgRVbMtm7q7On5lvK/VXqiMihr7MIHFkAj9p3BIo5m
         oPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EJ9gZt5ymPHJQTGM6KoCLKfxnXjQCunOLq9zbJJjjus=;
        b=OGT4JgXFCkAOOsuplbQohxHvvkud4cTnqVV5Tx4wNEyhQg2g1Ncz8oEkNep1vAYWBR
         FSrMA4zOU0rezIe6gjwTXBPdv3fR4bwV0r5zbgSr5udP9JTnVK1gerg/lbH1Z6HJ90mZ
         x0zhugjKIBcfIOVkDlTfmC8T/tC9Jm7i+8TZkYfNyvwUl7hkAgAqhfvu45sXPdTEBeM6
         y18REuBC8N6ps/oKT4WZ5RyIwfEk4KjjAJNWvmNTekiCp8K7w8VG9yYmDvuD6AbQA58u
         ZIn20n15Emm2xS8ySjvyzc9yHBbAPRtVrDzUHONux5x9TQzD0gzMForMrMe9OpwhntMH
         6cIA==
X-Gm-Message-State: AOUpUlFKzUKbSI/+9UTWjerkRJWeKcRL4pLySgO5nOJ6xF833JQN7dY2
        YhPRVt0VZFhpmESwHS/24fS2sWPeRsx93JxzuAbT1g==
X-Google-Smtp-Source: AAOMgpdTaB4dkBfPbNaEcHCdJ0gL/xrcK9pZKjtMlvv0jK3me5XjFCPI5EERdtdtBNsoSjBFs6Od3rMXAPqdKUQkk4E=
X-Received: by 2002:a62:b604:: with SMTP id j4-v6mr17233441pff.199.1533119714664;
 Wed, 01 Aug 2018 03:35:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 1 Aug 2018 03:34:54
 -0700 (PDT)
In-Reply-To: <c03fd1ca-0169-4492-7d6f-2df7a91bff5e@gmail.com>
References: <e3b48104-3efb-1896-0d46-792419f49a75@virtuozzo.com>
 <01000164f169bc6b-c73a8353-d7d9-47ec-a782-90aadcb86bfb-000000@email.amazonses.com>
 <CA+55aFzHR1+YbDee6Cduo6YXHO9LKmLN1wP=MVzbP41nxUb5=g@mail.gmail.com>
 <CA+55aFzYLgyNp1jsqsvUOjwZdO_1Piqj=iB=rzDShjScdNtkbg@mail.gmail.com>
 <30ee6c72-dc90-275a-8e23-54221f393cb0@virtuozzo.com> <c03fd1ca-0169-4492-7d6f-2df7a91bff5e@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 1 Aug 2018 12:34:54 +0200
Message-ID: <CACT4Y+bLbDunoz+0qB=atbQXJ9Gu3N6+UXPwNnqMbq5RyZu1mQ@mail.gmail.com>
Subject: Re: SLAB_TYPESAFE_BY_RCU without constructors (was Re: [PATCH v4
 13/17] khwasan: add hooks implementation)
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org,
        Network Development <netdev@vger.kernel.org>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>, dccp@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dave Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 12:23 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On 08/01/2018 02:03 AM, Andrey Ryabinin wrote:
>
>> I can't think of any advantage in not having the constructor.
>
> I can't see any advantage adding another indirect call,
> in RETPOLINE world.

Can you please elaborate what's the problem here?
If slab ctor call have RETPOLINE, then using ctors more does not
introduce any security problems and they are not _that_ slow.
If slab ctors are not protected, then we have problem that needs to be
fixed already.
What am I missing?

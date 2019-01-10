Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51924C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C92A2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlUsTWpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfAJAQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:16:33 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33899 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfAJAQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:16:33 -0500
Received: by mail-lf1-f68.google.com with SMTP id p6so7039935lfc.1;
        Wed, 09 Jan 2019 16:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tX/uOXZXaLfYk2EMsN1c8tOykFCY1NPHqE/mUp9QK2o=;
        b=rlUsTWpwEdHkVf7m65sm0Bd0GhQjULKIzIr5oGjNMe40P0VEyGbMybrNQWf9QpXpLk
         hNKjN0L628wxUbKz+KCMU9Pgts9zr6ICynPRNIlR/n8pHOFoCCG8LpQg5Bc+1WzjI5n9
         u1JAnOqopXfwcZszTReGKbjIViUzNhmJbjNmvPawcJhX+pZ+pF2LNwuXGKTrDDRYdhdD
         Pj+2pTsQLyXM0VCQAZwVBDryeP2mN6T4/G/gx3QwQQVu6OW0/bM2A4VDj09vTDct92Mw
         /EXz9jOw9cP/alNfoGUhAm+2YmMe6ja74zDM4LPAhcgs698kyyLwvqdTFggQqyAx42ml
         BSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tX/uOXZXaLfYk2EMsN1c8tOykFCY1NPHqE/mUp9QK2o=;
        b=CUdCNoSC6/skLnUdwyn1MxQa7+MygcaeqqpivpeCm1Yj2WaWvKlDs3oZKimfahUGVS
         T3xuVgFzeTPjzY6NI6t9mxRR99rARMR70EX5FRJA1eaQ7FaGuDnFEVJXx68UZg/Zq6kk
         j+lEFjB+XhR7TSReSDuikG4Q8gwg09AUvkE5GOCzWkHY56JtirM89cBMqQBnPWzDRwWD
         VrOrvgA5CDSoFmMjF+qkHDlRO5KnE7XjNsJXVKfcxi3F6QZyNrJfRE2XZ7oahzRyccQa
         DiGsx+b/gk8yJgzkb4yit9tURoiLSCvX+voCVAHbySdLkgwhYDuKk9aEjRXtGThdU2uS
         wI8Q==
X-Gm-Message-State: AJcUukfrsLONGzJUgSrEG5kCsmwciqzDL00JvebCJ72Rf4S4yWZwvORb
        JbPPFPWbF7j2qSCxMdYV3rkcGnx/3ACz7z+nhws=
X-Google-Smtp-Source: ALg8bN78yZ9fg59V9fl7GwWG9an2CiXfrkph/eWr/1gyYIsK7azYq7Ie2ejqzrT7bQsM7gC/Fkgmml0PWIIBVmizUHI=
X-Received: by 2002:a19:a60c:: with SMTP id p12mr4914048lfe.63.1547079390268;
 Wed, 09 Jan 2019 16:16:30 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZsiifWTKq=Mw30f-UVyrzywnYYX7GvyqG+O+ndSYBML9A@mail.gmail.com>
 <CAA85sZsj5PxZeiXSVK92QXi93fc+Ch2x2KHqzzPcT2OffaKsEQ@mail.gmail.com>
 <CAA85sZsyEnkmwO2grp3H5pXErrNV=prOjEfPy=odoQ8iSHox4Q@mail.gmail.com>
 <20190108145112.65fc554f@hermes.lan> <CAA85sZt=mrqprwkKLGbv2UMy6vQb0XSc58YrWvqxzK4yhdbpGQ@mail.gmail.com>
 <02fbd1e8-8ad1-3a47-c3e1-86adbb73185d@gmail.com> <CAA85sZvVHCYFRXp5cYzSDNpesNMtCZOB+Gnb+N+SmraD6eke1A@mail.gmail.com>
In-Reply-To: <CAA85sZvVHCYFRXp5cYzSDNpesNMtCZOB+Gnb+N+SmraD6eke1A@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Thu, 10 Jan 2019 01:16:19 +0100
Message-ID: <CAA85sZsF53oFBVzrbuj6wrM43QutKy52S-77PqNZdTChJKOyWQ@mail.gmail.com>
Subject: Re: [BUG] v4.20 - bridge not getting DHCP responses? (works in 4.19.13)
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        jeffrey.t.kirsher@intel.com,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        nikolay@cumulusnetworks.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 12:17 AM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> On Wed, Jan 9, 2019, 00:09 Florian Fainelli <f.fainelli@gmail.com wrote:

 [--8<---]

>> > when looking at "git log v4.19...v4.20
>> > drivers/net/ethernet/intel/ixgbe/" nothing else really stands out...
>> > The machine is also running NAT for my home network and all of that
>> > works just fine...
>> >
>> > I started with tcpdump, prooving that packets reached all the way
>> > outside but replies never made it, reboorting
>> > with 4.19.13 resulted in replies appearing in the tcpdump.
>> >
>> > I don't quite know where to look - and what can i do to test - i tried
>> > disabling all offloading (due to the UDP
>> > offloading changes) but nothing helped...
>> >
>> > Ideas? Patches? ;)
>>
>> Running a bisection would certainly help find the offending commit if
>> that is something that you can do?
>
> I was hoping for a likely suspect but this was on my "Todo" for Friday night anyway... (And I already started testing with some patches reversed)

So after lengthy git bisect sections, both from the latest stable i
was using (not the best of ideas)
and from 4.19.

The latest stable yielded 72b0094f918294e6cb8cf5c3b4520d928fbb1a57 -
which is incorrect...

However, the proper bisect gave me this:
fb420d5d91c1274d5966917725e71f27ed092a85 is the first bad commit
commit fb420d5d91c1274d5966917725e71f27ed092a85
Author: Eric Dumazet <edumazet@google.com>
Date:   Fri Sep 28 10:28:44 2018 -0700

    tcp/fq: move back to CLOCK_MONOTONIC

    In the recent TCP/EDT patch series, I switched TCP and sch_fq
    clocks from MONOTONIC to TAI, in order to meet the choice done
    earlier for sch_etf packet scheduler.

    But sure enough, this broke some setups were the TAI clock
    jumps forward (by almost 50 year...), as reported
    by Leonard Crestez.

    If we want to converge later, we'll probably need to add
    an skb field to differentiate the clock bases, or a socket option.

    In the meantime, an UDP application will need to use CLOCK_MONOTONIC
    base for its SCM_TXTIME timestamps if using fq packet scheduler.

    Fixes: 72b0094f9182 ("tcp: switch tcp_clock_ns() to CLOCK_TAI base")
    Fixes: 142537e41923 ("net_sched: sch_fq: switch to CLOCK_TAI")
    Fixes: fd2bca2aa789 ("tcp: switch internal pacing timer to CLOCK_TAI")
    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
    Tested-by: Leonard Crestez <leonard.crestez@nxp.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

:040000 040000 06615f5ed4486fd0af77a8fb59775a9f2346aebc
7f883c7753cb3d5d881e0edbef2989f4e6db6a1f M include
:040000 040000 767c5e93fe5cfd609f90834d93978511c284ea01
cc47bd361516622c0b21602e188181fdfc6b2995 M net
----

Which could actually be the culprit - I'm having problems *with* UDP
traffic (DHCP) and I am using fq

Lets hope it's so, since this was kinda boring:
ls /lib/modules |grep 4.19.0 |wc -l
27

Testing 4.20.1 and then 4.20.1 with the suspected patch reverted, will
report shortly!

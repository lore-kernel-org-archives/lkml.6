Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96478C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4E921534
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b="dHl1G3i7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4E921534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dd-wrt.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeHOX0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:26:54 -0400
Received: from webmail.newmedia-net.de ([185.84.6.166]:49247 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeHOX0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=0EYQ9xV88y4vNhp3dU2+dVaNnMJbfZmi9JmsYVfVEmk=;
        b=dHl1G3i79Ydo7+xqWt5q6njHP0yIo/ndR6l4+fWNV6PVwjuB13qpjIBCujiePrruVv3F+gt6CQbdyNMDJpvdLqQ5Jqrw64b2Wifp6OcNj+0XQGNVZ7eZlKWIZpcX1FlOVV3tcO9fr7vctj5gyf/c2PW4qQl6pjNltGKdqunOTAU=;
Subject: Re: [PATCH 4.9 000/107] 4.9.120-stable review
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Sven Joachim <svenjoac@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
References: <20180814171520.883143803@linuxfoundation.org>
 <6272e062-6cfc-0669-bebf-ebb039da051a@dd-wrt.com>
 <87k1orms9i.fsf@turtle.gmx.de>
 <55df6754-ce8c-520a-13f9-c610ac498173@dd-wrt.com>
 <20180815185553.GA18219@roeck-us.net>
 <69700876-f31a-ea0a-bdea-2e82b7a5d308@dd-wrt.com>
 <20180815192630.GA20575@roeck-us.net>
 <CA+55aFzHYYai0ZR3eapEqQzt9KVcg8+bGDSmTmc6CzhpmFVfdw@mail.gmail.com>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <c05b614d-0d4d-6e6b-1014-d5d16875e096@dd-wrt.com>
Date:   Wed, 15 Aug 2018 22:33:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFzHYYai0ZR3eapEqQzt9KVcg8+bGDSmTmc6CzhpmFVfdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [79.251.189.74] (helo=[10.88.193.131])
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1fq2Te-0005RH-1v; Wed, 15 Aug 2018 22:33:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 15.08.2018 um 21:42 schrieb Linus Torvalds:
> On Wed, Aug 15, 2018 at 12:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> Also seen in mainline. Meaning my non-SMP test builds are broken. Hmm.
> Grr. I think it's due mainly due to commit 447ae3166702 ("x86: Don't
> include linux/irq.h from asm/hardirq.h"), which exposes a number of
> files that had some dodgy include file dependenencies, and just
> randomly happened to get it right because of that odd include that
> caused problems.
correct.
>
> That commit itself is definitely the right thing to do, but yes, we
> clearly had a lot of cases of things getting core header files
> included purely by luck.
>
> And because this was all done under embargo, we didn't get the kind of
> test robot coverage we usually get.
>
> Part of it can also be due to subtle merge issues - even if the
> original branch got good coverage, later changes sometimes ended up
> adding things like that.
>
> For example, my merge of the L1TF code found that in the meantime,
> arch/x86/kernel/kvmclock.c had added a call to kzalloc(), which used
> to work just fine, but with the header cleanup it turned out that
> kvmclock.c had never included <linux/slab.h>, so now it didn't build
> right.
>
> And that was just the one I noticed because of my limited build tests.
>
> And yes, every single developer has CONFIG_SMP in their config, but
> perhaps equally importantly, I suspect CONFIG_SMP ends up getting more
> header files included almost by mistake, so it can _continue_ to hide
> these kinds of incomplete header file includes that just happen to
> work.
>
>> Anyway, care to send a proper patch ? I am sure Linus will be more
>> than happy to apply it.
> I think "happy" is too strong a word for my state of mind with all
> this, but yes, I'll apply it, and you'll get the glory of fixing some
> configuration that clearly didn't get properly tested.
>
> In the meantime, maybe I should just do a "make allmodconfig" and then
> disable SMP and see if that shows anything for me.

if it would be helpfull i can do this quick here using the latest 
vanilla tree

Sebastian

>
>                Linus
>

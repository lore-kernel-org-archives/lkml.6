Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617BAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5CE20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfAONK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:10:56 -0500
Received: from www.cavac.at ([149.154.155.235]:37571 "EHLO www.cavac.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbfAONK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:10:56 -0500
X-Greylist: delayed 542 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2019 08:10:54 EST
Received: from localhost (localhost [127.0.0.1])
        by www.cavac.at (Postfix) with ESMTP id 19F8F11A47E1;
        Tue, 15 Jan 2019 14:01:50 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at cavac.at
Received: from www.cavac.at ([149.154.155.235])
        by localhost (cables.cavac.at [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b_ZuyDabSLEJ; Tue, 15 Jan 2019 14:01:49 +0100 (CET)
Received: from [10.176.199.190] (unknown [213.150.232.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by www.cavac.at (Postfix) with ESMTPSA id 1B3B611A06AC;
        Tue, 15 Jan 2019 14:01:49 +0100 (CET)
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Hutter, Tony" <hutter2@llnl.gov>,
        Marc Dionne <marc.c.dionne@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
References: <git-mailbomb-linux-master-12209993e98c5fa1855c467f22a24e3d5b8be205@kernel.org>
 <CAB9dFdsZb-sZixeOzrt8F50h1pnUK2W2Cxx8+xjhgd0=6xs7iw@mail.gmail.com>
 <20190109111951.5zvnj7ls6jv56p2u@linutronix.de>
 <20190109165235.GA8151@kroah.com>
 <20190109170935.e6b6rwzpk6dlruu4@linutronix.de>
 <20190110131132.GC20217@kroah.com>
 <ba74ed88-06d0-5063-799f-c9c6ddbc7da0@llnl.gov>
 <20190110180752.f4cnunadzzkev24m@linutronix.de>
 <20190110182413.GA6932@kroah.com>
From:   Rene Schickbauer <cavac@cavac.at>
Message-ID: <46a97264-9586-ef67-73a0-9af1c4d34f25@cavac.at>
Date:   Tue, 15 Jan 2019 14:01:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190110182413.GA6932@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10.01.19 19:24, Greg Kroah-Hartman wrote:

Dear Greg!

> My tolerance for ZFS is pretty non-existant.  Sun explicitly did not
> want their code to work on Linux, so why would we do extra work to get
> their code to work properly?

I'm not a kernel developer. I'm an application developer and system 
administrator. I'm also an Open Source advocate who regularly holds 
talks at Austrias biggest Linux conference in Graz.

Usually i'm not too interested in the internals of Linux kernel 
development, but this issue affects me on many levels.

ZFS brings me a lot of features, convenience and, most important of all, 
stability and reliability that i'm missing in other Linux filesystems.

ZFS on Linux is open source, made by people who invest their time and 
money into creating and maintaining a great filesystem. How can you say 
they are wrong in doing so?

To be frank, your argument, which boils down to "GPL is the only correct 
open source license", makes me ashamed to have been advocating people 
switching to Linux. This is exactly the kind of argument that made me 
switch away from closed source operating systems like Windows, only then 
it was Steve Ballmer using it against open source.

I understand that different open source licenses have different 
mindsets. But that doesn't make those other licenses any less valid. 
They still give us developers the freedom to learn, the freedom to build 
great systems, the freedom to change the world for the better. Not every 
project is able, or willing, to adopt the GPL. (I, for one, release my 
software under Perls Artistic license, because the GPL is too 
restrictive for my purpose).

So, please try to understand that non-GPL open source is still a useful 
resource for many of us out there. Maybe it helps to remember that Linux 
might never have existed if Linus Torvalds had never had the ability to 
experiment with the Minix source code and got inspired by it to write 
something more capable.

As for ZFS and me, ZFS is rather important to my work. If push comes to 
shove, i'm more inclined to switching to FreeBSD than to switch to 
another filesystem at this point in time. But i'm really hoping that 
this issue will get resolved by allowing to continue using non-GPL open 
source in Linux.

Sincerely,
Rene Schickbauer

Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC27AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B3C2081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B3C2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbeKKABz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 19:01:55 -0500
Received: from mout.gmx.net ([212.227.15.19]:38945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbeKKABz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 19:01:55 -0500
Received: from [74.104.183.64] ([74.104.183.64]) by
 msvc-mesg-gmx023.server.lan (via HTTP); Sat, 10 Nov 2018 15:11:13 +0100
MIME-Version: 1.0
Message-ID: <trinity-0da197a3-0f6e-41a3-8ab7-a3519e158a88-1541859073829@msvc-mesg-gmx023>
From:   "Qian Cai" <cai@gmx.us>
To:     "Waiman Long" <longman@redhat.com>
Cc:     "Arnd Bergmann" <arnd@arndb.de>,
        "Yang Shi" <yang.shi@linux.alibaba.com>,
        "Zhong Jiang" <zhongjiang@huawei.com>,
        "open list" <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: ODEBUG: Out of memory. ODEBUG disabled
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 10 Nov 2018 15:11:13 +0100
In-Reply-To: <c7b58543-ffd2-44bb-1005-e9733782bad5@redhat.com>
References: <trinity-be6414fb-25ba-4881-acc6-abe3b375d0d0-1541814329304@msvc-mesg-gmx021>
 <c7b58543-ffd2-44bb-1005-e9733782bad5@redhat.com>
X-Provags-ID: V03:K1:b/qJ1nFwjnA5Y3YFoQgg3r46s6jC7bCY0chRX0haIg9TABB/JEekaciXvqlakDbcz3jJA
 xjdu8Gv4IyDVerhdeC85Qrx/0/D5rALlHBvVFiN+Pa/pdiABfis0v1jXYC8PmcavslQsKKirsa6w
 XRCJogo7YlsXOSzRecugK7j3EuP63Bx3JWND/IFnKopyk6udbgIwmaMHGNTQNpd9nmbea/HDB6hu
 cv6F9iOQRFZE/h9z/3uCxZZXsF02BV9dv5O/+snHQbsUUqSylex9MU5A3GSHm4tRXgp+A4ddF1rH
 /oSmRm5n3gqbaiTbi6ebGsK
X-UI-Out-Filterresults: notjunk:1;V01:K0:l1+OvDjG3H4=:Ltl/bRiPxKvVLtC7j33dDT
 6Dbmhs1XkLljPIfVpl9IlOYJpGGG8/PgfCI+YAlRyZzc8Qb98GHX7T3eX8dBUFV6VKBqHCfpt
 uo8KA2/O3WxrffTuc9sIfpZnu8Fv9Lx9X4+vb367QhqchGQpH6i4iBbKVeb1PRJ3OwAWHZ/hr
 4xMnuxk24tbg71UkNicQ+jaVHYgZSjUAFCPBCl1Gw5mA3t+sihMi7yCEC5GnLdoxy6dHJqQ1t
 dWGD7E//jypvZo3GS67bRm+ko3W7nKg+r6DALWP9hHByTb3grHPQvyf9NPmz9wUJZQjOnrXIF
 D/juDxv8WY3sBUwFC/bOT6x9RBAqY3VpdLVAHrsIUOW/HaGaQoK1iUGW2QoLdUqJmoOEyXf7H
 tsL3ttcm83nQOoHbAwrr8APPEW9YM/riEkk7qkG7Xd6/vf8SuGuF/DPPL+kCPxUOp66AN4jWU
 85pSHDq7eYFIL0yjtimkQFVPjc9MxbL70nRgqvur43v2giUHZkykwh+adWGhGNgVRfsPkG51Y
 Uajm67eZbry9iXus+/Q77T5SWfihnPJI7CqCV3zvaVXfFdbJc/zIqO0l9phSZXLU+liz3vlme
 mz3jLj59ybMmHGDz6ZUFE3+XHR2CD53SHO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/18 at 8:59 AM, Waiman Long wrote:

> On 11/09/2018 08:45 PM, Qian Cai wrote:
> >> Sent: Friday, November 09, 2018 at 5:08 PM
> >> From: "Waiman Long" <longman@redhat.com>
> >> To: "Qian Cai" <cai@gmx.us>, "Yang Shi" <yang.shi@linux.alibaba.com>
> >> Cc: "open list" <linux-kernel@vger.kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Arnd Bergmann" <arnd@arndb.de>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, "Zhong Jiang" <zhongjiang@huawei.com>
> >> Subject: Re: ODEBUG: Out of memory. ODEBUG disabled
> >>
> >> On 11/09/2018 04:51 PM, Qian Cai wrote:
> >>>> On Nov 9, 2018, at 4:42 PM, Yang Shi <yang.shi@linux.alibaba.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 11/9/18 1:36 PM, Qian Cai wrote:
> >>>>> It is a bit annoying on this aarch64 server with 64 CPUs that is
> >>>>> booting the latest mainline (3541833fd1f2) causes object debugging
> >>>>> always running out of memory.
> >>>> May you please paste the detail failure log?
> >>> I assume you mean dmesg.
> >>>
> >>> Here is the dmesg for 64 CPUs,
> >>> https://paste.ubuntu.com/p/BnhvXXhn7k/
> >>>>> I have to boot the kernel with only 16 CPUs instead (nr_cpus=16)
> >>>>> to make it work. Is it expected that object debugging is not going
> >>>>> to work with large machines?
> >>>> I don't think so. I'm supposed it works well with large CPU number on x86.
> >>> Here is the one with nr_cpus workaround,
> >>> https://paste.ubuntu.com/p/qMpd2CCPSV/
> >> The debugobjects code have a set of 1024 statically allocated debug
> >> objects that can be used in early boot before the slab memory allocator
> >> is initialized. Apparently, the system may have used up all the
> >> statically allocated objects. Try double ODEBUG_POOL_SIZE to see if it
> >> helps.
> > Great, you are right. Doubling the size makes it work. Does it make sense
> > to have a kconfig option instead?
> 
> First, I think you need to figure out what your system needed to use up
> so many debug objects in early boot. If there is a legitimate reason for
> this behavior, we can talk about having a kconfig option to increase that.
Anybody else not getting ODEBUG OOM with more than 64-CPU? As mentioned, restricting to 16-CPU works fine. How can I figure out why the system uses so much debug objects?

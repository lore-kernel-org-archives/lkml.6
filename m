Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E6BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879AC20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879AC20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbeKTBly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:41:54 -0500
Received: from mout.gmx.net ([212.227.17.22]:60647 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729680AbeKTBly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:41:54 -0500
Received: from dhcp-41-57.bos.redhat.com ([66.187.233.206]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0LZiQy-1fjxyz3sC4-00lVov; Mon, 19 Nov 2018 16:17:42 +0100
Message-ID: <1542640658.12945.41.camel@gmx.us>
Subject: Re: [PATCH] debugobjects: add a new Kconfig for POOL_SIZE
From:   Qian Cai <cai@gmx.us>
To:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux kernel <linux-kernel@vger.kernel.org>, arnd@arndb.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
Date:   Mon, 19 Nov 2018 10:17:38 -0500
In-Reply-To: <44517d7f-c34f-1424-d0db-601e590c626d@redhat.com>
References: <20181118082255.1275-1-cai@gmx.us>
         <alpine.DEB.2.21.1811181919170.9459@nanos.tec.linutronix.de>
         <5939F7F3-E332-4112-861E-C6C0DF86717E@gmx.us>
         <alpine.DEB.2.21.1811190904450.9459@nanos.tec.linutronix.de>
         <trinity-0de3e85e-8526-4004-b346-3b64dd89bc78-1542634057117@msvc-mesg-gmx021>
         <44517d7f-c34f-1424-d0db-601e590c626d@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sul65BZdqZ/akbWUU/353/EKgMPqsIrbEwmyM7t3tAFYlzV18Qc
 X+kwAkyfMPyPadAGHwVQrugv8pTuBCbREdF1hmDxA6R8dqf1CMffZ7T8PBobE+aL4CHbw+7
 P0bYuSTYN8wKWLod+EpgcfCsje8ctzhN4UrV2MEIA8gBtfy0fJVPFks4up9scTix4E9s4JZ
 0zKTAdvcJj72qycQn0PIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aVcoSwanceg=:dQvKMELqi28MB6UlwFYawN
 1JvtDkdxm3sBfxqaBbrkExg202jwrfQvZ8wngR+DeY1xSZc9G7zHn5Bz64FxsEgeIQgbzzXei
 2LN+S5QM/4tCoUsW0BBWh8cfuQ5sKlhxkdsoHDw6+tJ0EqCFBI7jRvRMMta5HyWkVAb1hsr0E
 uuKZMJAgVVhzIPL/hlqpEj3c0qJFGtaAZPa9MjjY8VUuguMstm/VxKoqtONiVOeAnFbrQGz0O
 9I8QcRDExlxYHDZnTRetd9fphC5l99kQMN1k3II0Lf4sjOAOaPvtbg6OWsgxMuQzscwy2GC8w
 2k5UxrLOpFJkn7Ax06GzhEh/e8LXGU+IbEYrOOkxOWOHQUBttE6pGBEv3Uv4ZA2AIwZyU2BvO
 F7O21XFc4MuvjT/ODfz1begDwqy97srPe8iwJNBgtP1fix/VY5e5JhgTE+tq18wCeaQSJ/mu6
 9sgncRkbMET2rB+SaCouq340qxGrl9hUSCSCVAWogm+x6ONd/Zg+PqmAVfVsYiIfgDz/KT/JQ
 r6TAxyAXGwieP0OwmnQENgPMeda9SOlOxkQaOyFhHKDTXVCuGjneIUXgzLRX5voS/d6+2gZle
 pCrhk8XM0wFNFyMCi9pSA8+OxkSfDlKe0dfZFIZXJ2htf4P8pFK4QDZ/MgFHOrjK7BUlXPsbJ
 uxOkOwNjgMjHGoRXeQnSUjI5qRQtkPSjNRNCz9pcXn4LQQS/aeOEVtYTszox2NjlXZfdUCDdm
 MRwQpme2uAnleXvqhUYq77idsvC4pDl9SkzcssctPk8JK9zIIq7bBAIXJF0okcnm7Ucplpha7
 K+RVgSZJ9ZZhwKqgIF99RmwUU8QK14Reem2Q84AkJ6spsWNJpGplr5b5db2QfmZRjMR7rYU0M
 pHDcC9lqYDzgTTCHxWH53SPGEEBPSfqrnw3mDXalfA+auytXbtpDY0nl6OYV4e
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-19 at 09:51 -0500, Waiman Long wrote:
> On 11/19/2018 08:27 AM, Qian Cai wrote:
> > On 11/19/18 at 3:09 AM, Thomas Gleixner wrote:
> > 
> > > Qian,
> > > 
> > > On Sun, 18 Nov 2018, Qian Cai wrote:
> > > > > On Nov 18, 2018, at 1:21 PM, Thomas Gleixner <tglx@linutronix.de>
> > > > > wrote:
> > > > > On Sun, 18 Nov 2018, Qian Cai wrote:
> > > > > > As the results, systems have 60+ CPUs with both timer and workqueue
> > > > > > objects enabled could trigger "ODEBUG: Out of memory. ODEBUG
> > > > > > disabled".
> > > > > > 
> > > > > > Hence, add a new Kconfig option so users could adjust
> > > > > > ODEBUG_POOL_SIZE
> > > > > > accordingly if either timer or workqueue objects are selected.
> > > > > 
> > > > > why do we need a config option, when the required number can be
> > > > > deduced
> > > > > already from the active CONFIG_DEBUG_OBJECTS_* and NR_CPUS?
> > > > > 
> > > > 
> > > > It because I am worry about the coupling between the implementation
> > > > details of
> > > > timers and workqueue objects, and the computation in the code you
> > > > mentioned
> > > > here. For example, people could change workqueue.c to have different
> > > > number
> > > > of worekqueues initialized during the early boot in the future which is
> > > > going to
> > > > affect the required pool size, and I am not sure if people are going to
> > > > adjust the
> > > > code in debugobjects.c here as well when they made changes like that.
> > > > 
> > > > Also, the computation could become so complex depends on lots of config
> > > > options like perf, hrtimer, and combinations that I have not tested so
> > > > far which is
> > > > difficult to exhausted all the possibilities.
> > > > 
> > > > Hence, I feel like the Kconfig option is more flexible and less error-
> > > > prone.
> > > 
> > > Quite the contrary. Config options are a pain and truly error-prone if you
> > > want to compile general purpose kernels as distributions do.
> > > 
> > 
> > Ah, I never thought distributions people would
> > enable those debugging options.
> 
> Distros like RHEL usually ship two kernels - one for production and one
> for debug. The debug kernel does have debugobjects enabled.
> 
Right, I can remember that now . However, if I understand correctly, since the
early static pool size needs to be determined during the compilation time, it
depends on the No. CPUs are from the machines that built the distro kernels.
Then, when users use those distro kernels, they are not going to have correct
the pool size according to the No. CPUs on their test machines.

Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFC5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44E12086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44E12086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbeKTCuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:50:10 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:39017 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729865AbeKTCuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:50:10 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gOmN8-0002OH-0Y; Mon, 19 Nov 2018 17:26:02 +0100
Date:   Mon, 19 Nov 2018 17:25:56 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Waiman Long <longman@redhat.com>
cc:     Qian Cai <cai@gmx.us>, linux kernel <linux-kernel@vger.kernel.org>,
        arnd@arndb.de, Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH] debugobjects: add a new Kconfig for POOL_SIZE
In-Reply-To: <0c6a79c8-dde2-dee9-efb0-5cf3d1b3949e@redhat.com>
Message-ID: <alpine.DEB.2.21.1811191722270.1669@nanos.tec.linutronix.de>
References: <20181118082255.1275-1-cai@gmx.us> <alpine.DEB.2.21.1811181919170.9459@nanos.tec.linutronix.de> <5939F7F3-E332-4112-861E-C6C0DF86717E@gmx.us> <alpine.DEB.2.21.1811190904450.9459@nanos.tec.linutronix.de> <trinity-0de3e85e-8526-4004-b346-3b64dd89bc78-1542634057117@msvc-mesg-gmx021>
 <44517d7f-c34f-1424-d0db-601e590c626d@redhat.com> <1542640658.12945.41.camel@gmx.us> <0c6a79c8-dde2-dee9-efb0-5cf3d1b3949e@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-679641881-1542644762=:1669"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-679641881-1542644762=:1669
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 19 Nov 2018, Waiman Long wrote:
> On 11/19/2018 10:17 AM, Qian Cai wrote:
> > Right, I can remember that now . However, if I understand correctly, since the
> > early static pool size needs to be determined during the compilation time, it
> > depends on the No. CPUs are from the machines that built the distro kernels.
> > Then, when users use those distro kernels, they are not going to have correct
> > the pool size according to the No. CPUs on their test machines.
> 
> I see your point. Perhaps you can make ODEBUG_POOL_SIZE scales with
> CONFIG_NR_CPUS like
> 
> #define ODEBUG_POOL_SIZE    (1024 + CONFIG_NR_CPUS * 2)
> 
> CONFIG_NR_CPUS is usually set to a lot higher than the actual number of
> CPUs in a typical system. So you don't want to set the multiplier too high.

The number of CPUs on the build machine is totally irrelevant and not
influencing the build at all. The sizing solely depends on CONFIG_NR_CPUS.

And even if the initial pool is a bit oversized, it's init data and freed,
so no real harm done.

Thanks,

	tglx
--8323329-679641881-1542644762=:1669--

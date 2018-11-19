Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A96EC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBF7206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBF7206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbeKTDCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:02:05 -0500
Received: from mout.gmx.net ([212.227.17.21]:50405 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732327AbeKTDCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:02:04 -0500
Received: from dhcp-41-57.bos.redhat.com ([66.187.233.206]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MNIO5-1gMsfT05Or-0070Ly; Mon, 19 Nov 2018 17:32:42 +0100
Message-ID: <1542645158.12945.43.camel@gmx.us>
Subject: Re: [PATCH] debugobjects: add a new Kconfig for POOL_SIZE
From:   Qian Cai <cai@gmx.us>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>
Cc:     linux kernel <linux-kernel@vger.kernel.org>, arnd@arndb.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
Date:   Mon, 19 Nov 2018 11:32:38 -0500
In-Reply-To: <alpine.DEB.2.21.1811191722270.1669@nanos.tec.linutronix.de>
References: <20181118082255.1275-1-cai@gmx.us>
         <alpine.DEB.2.21.1811181919170.9459@nanos.tec.linutronix.de>
         <5939F7F3-E332-4112-861E-C6C0DF86717E@gmx.us>
         <alpine.DEB.2.21.1811190904450.9459@nanos.tec.linutronix.de>
         <trinity-0de3e85e-8526-4004-b346-3b64dd89bc78-1542634057117@msvc-mesg-gmx021>
         <44517d7f-c34f-1424-d0db-601e590c626d@redhat.com>
         <1542640658.12945.41.camel@gmx.us>
         <0c6a79c8-dde2-dee9-efb0-5cf3d1b3949e@redhat.com>
         <alpine.DEB.2.21.1811191722270.1669@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zDKMMjRC2KzIihqnr3SpuOv//cZ2eMkzPhSFcLfs4XWfq/JM3XO
 odL1cCbvJHSJEc3AqNKXm/VQBX0/HwtMo+DQ4Xr/SVH6m3A+BX1wM3DcqID88xbejHI7MOZ
 L8lEOe1bVeBmiLW5wT0CLov4WCjqKIcIg3XeffJmA36KO1ogQzXrRSd0uMVX7vpVNlbZ114
 Fzw2tiB7HBZMw0bTlmzgQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KqPx+/jtAqw=:HEui1Wl/qeu4lx1ynBFr0T
 Fh8uA2CRAOUxRbn05ycPoOm0DUciwGP5JlwLZrBldxddg6wutt+IG1J14jP9VXffp3qU4SicR
 XqRqpb1rVRD6jEin/rAJtG76ks+auSyJBx1gKmMiiDjB6BEHprq8fWLmmWD6FMCv+fi0kH8Ra
 PyVFRDhsme6HWg/4yqLkHOov1cbRbA4h2n5LKMUi8NwTy2QMuSShkAf89TF2bpMVyiDyH+f5Z
 FCX9D3ZLXbCQ5sc23Pg7lnOrdDz9MIA0hxNcgbTFS6cFVWtZD0q+PSWSLb867l0HaxDZ0p28y
 9uU6aOI0UEJE+ae56f7jsMaFfwNHReeBp8o46AsfZDsq6Gg5CzJv/bwEDJmFQlVUuJ1XL8eTH
 MAItxI9bIm2aOvglL6dVRK3Z+Ska8NGQ4MdQ98urNFWlBEU3wz/kWglVYw3n5DGFb79+zFGMv
 K9lsoCXKxEFeZgfeiWqTk0Cm1HbBTPa6GI4KCYipvHYQ3fp/Wb4xtzLPcZpftX6apQe5MC2t5
 R99Lq5eOATRX8nQupCvQRjIdNbeN1gQXKdGGOIX9mNy+1PurL6HBrFDShqwCy8pY6ZVlESkhB
 DNSha3vMctrbSKxSdGNRIw2cqJkKTqneCg1Lu+lWgJhCHV6rbBoeDJJmdUtEvVQkASNNl/AkJ
 bre0mjGVVCkM/ThtCLC6uvHL1z/OVagdNtzpUGGTc4VmCu25m2fxtSUQQptyd/3lFJHydvU0b
 lknxgKHqGytQwUXK2iy1OwXgafFlcVicAmmFSPY9CflVYEObpRbhxG5AtlN3qoHDg58K5STE7
 QBokAtxFZp+rwMMLaGWECCUOcFUarWDcX0EI+2VXifvUdJL6opscQKtzkF4eO42vntqrL1XFU
 U6tCswnECJPo3Iqwc9QbTtSsOcykw5AopJRRbXBoysgjtVlFlLMXDQ3k3a53Pf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-19 at 17:25 +0100, Thomas Gleixner wrote:
> On Mon, 19 Nov 2018, Waiman Long wrote:
> > On 11/19/2018 10:17 AM, Qian Cai wrote:
> > > Right, I can remember that now . However, if I understand correctly, since
> > > the
> > > early static pool size needs to be determined during the compilation time,
> > > it
> > > depends on the No. CPUs are from the machines that built the distro
> > > kernels.
> > > Then, when users use those distro kernels, they are not going to have
> > > correct
> > > the pool size according to the No. CPUs on their test machines.
> > 
> > I see your point. Perhaps you can make ODEBUG_POOL_SIZE scales with
> > CONFIG_NR_CPUS like
> > 
> > #define ODEBUG_POOL_SIZE    (1024 + CONFIG_NR_CPUS * 2)
> > 
> > CONFIG_NR_CPUS is usually set to a lot higher than the actual number of
> > CPUs in a typical system. So you don't want to set the multiplier too high.
> 
> The number of CPUs on the build machine is totally irrelevant and not
> influencing the build at all. The sizing solely depends on CONFIG_NR_CPUS.
> 
> And even if the initial pool is a bit oversized, it's init data and freed,
> so no real harm done.
> 
Ah, I thought you meant the NR_CPUS macro. It is CONFIG_NR_CPUS, and we are
on the same page.

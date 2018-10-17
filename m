Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA52C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A8B214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A8B214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codemonkey.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeJQLe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 07:34:27 -0400
Received: from scorn.kernelslacker.org ([45.56.101.199]:41370 "EHLO
        scorn.kernelslacker.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeJQLe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 07:34:26 -0400
Received: from [2601:196:4600:5b90:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.89)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1gCchT-00074N-VV; Tue, 16 Oct 2018 23:40:48 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id 9B65256010A; Tue, 16 Oct 2018 23:40:47 -0400 (EDT)
Date:   Tue, 16 Oct 2018 23:40:47 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Meelis Roos <mroos@linux.ee>, LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Subject: Re: netconsole warning in 4.19.0-rc7
Message-ID: <20181017034047.nrhstc3b4wzevnri@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Cong Wang <xiyou.wangcong@gmail.com>, Meelis Roos <mroos@linux.ee>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
References: <e0611057-1b5b-9990-b9fa-060a9b5eba40@linux.ee>
 <CAM_iQpU0+LVwgMea32KQWf8z6Bp1VTmWOGnWNwNSmV0PZzf_ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpU0+LVwgMea32KQWf8z6Bp1VTmWOGnWNwNSmV0PZzf_ew@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 10:34:49PM -0700, Cong Wang wrote:
 > (Cc'ing Dave)
 > 
 > On Wed, Oct 10, 2018 at 5:14 AM Meelis Roos <mroos@linux.ee> wrote:
 > >
 > > Thies 4.19-rc7 on a bunch of test machines and got this warning from one.
 > > It is reproducible and I have not noticed it before.
 > >
 > [...]
 > > [    9.914805] WARNING: CPU: 0 PID: 0 at kernel/softirq.c:168 __local_bh_enable_ip+0x2e/0x44
 > > [    9.914806] Modules linked in:
 > > [    9.914808] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc7 #210
 > > [    9.914810] Hardware name: MicroLink                       /D850MV                         , BIOS MV85010A.86A.0067.P24.0304081124 04/08/2003
 > > [    9.914811] EIP: __local_bh_enable_ip+0x2e/0x44
 > > [    9.914813] Code: cc 02 5f c8 a9 00 00 0f 00 75 1f 83 ea 01 f7 da 01 15 cc 02 5f c8 a1 cc 02 5f c8 a9 00 ff 1f 00 74 0c ff 0d cc 02 5f c8 5d c3 <0f> 0b eb dd 66 a1 80 cd 5e c8 66 85 c0 74 e9 e8 87 ff ff ff eb e2
 > > [    9.914814] EAX: 80010200 EBX: f602b000 ECX: 36346270 EDX: 00000200
 > > [    9.914815] ESI: f620ecc0 EDI: f620ebac EBP: f600de40 ESP: f600de40
 > > [    9.914816] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010006
 > > [    9.914817] CR0: 80050033 CR2: b7f5f000 CR3: 36389000 CR4: 000006d0
 > > [    9.914818] Call Trace:
 > > [    9.914819]  <IRQ>
 > > [    9.914820]  netpoll_send_skb_on_dev+0xa5/0x1b0
 > 
 > This is exactly what I mentioned in my review here:
 > https://marc.info/?l=linux-netdev&m=153816136624679&w=2
 > 
 > "But irq is disabled here, so not sure if rcu_read_lock_bh()
 > could cause trouble... "

Not sure why this didn't show up for me when I was developing that
patch, but I can now reproduce this.  The patch below fixes it for
me, but I'm not sure if there are still any side-effects.
There's also a missed unlock in the error path.

If this looks legit, I'll submit it formally..

Tested on both bonded and unbonded interfaces.

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index de1d1ba92f2d..fafb9e2c4e7b 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -312,12 +312,13 @@ void netpoll_send_skb_on_dev(struct netpoll *np, struct sk_buff *skb,
 	/* It is up to the caller to keep npinfo alive. */
 	struct netpoll_info *npinfo;
 
-	rcu_read_lock_bh();
+	rcu_read_lock();
 	lockdep_assert_irqs_disabled();
 
 	npinfo = rcu_dereference_bh(np->dev->npinfo);
 	if (!npinfo || !netif_running(dev) || !netif_device_present(dev)) {
 		dev_kfree_skb_irq(skb);
+		rcu_read_unlock();
 		return;
 	}
 
@@ -357,7 +358,7 @@ void netpoll_send_skb_on_dev(struct netpoll *np, struct sk_buff *skb,
 		skb_queue_tail(&npinfo->txq, skb);
 		schedule_delayed_work(&npinfo->tx_work,0);
 	}
-	rcu_read_unlock_bh();
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(netpoll_send_skb_on_dev);
 

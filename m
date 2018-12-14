Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6B8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479B6206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="QqkuztJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbeLNSar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:30:47 -0500
Received: from ma1-aaemail-dr-lapp03.apple.com ([17.171.2.72]:43894 "EHLO
        ma1-aaemail-dr-lapp03.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729341AbeLNSaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:30:46 -0500
X-Greylist: delayed 9491 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Dec 2018 13:30:45 EST
Received: from pps.filterd (ma1-aaemail-dr-lapp03.apple.com [127.0.0.1])
        by ma1-aaemail-dr-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id wBEFkfkG020004;
        Fri, 14 Dec 2018 07:52:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : sender : date : from : to : cc
 : subject : message-id : references : in-reply-to; s=20180706;
 bh=Y8FF0AqsADmzHN3tUbUD/5liozAynnbJWpiTPUipNuo=;
 b=QqkuztJAooJ2s2NMK8MTuXgV+4Pca+BR60hajtvqc9CEPLH79pr5ytW8nC6SnXK5v4Rj
 Ne603/6SpGcNeZXgaOpQoRrgthxrxE1dwdiMVtNVYTpG83Z9G9ozB3kR5cdC5xP2d72w
 UTLiIyyoixF6xF2f7SdpnmHjFqxjcit4WkQ0Ehl1sU3jI2VYPvFEjWIXW/zoXx5p/HAo
 H05XJBo5nsoXIKEioCygB8gYT20C9e78yJL76Q/GT411UOOaCWfA/3qulMHrcu4GTLG6
 vGTYtGNufWcaJ/rWJ4rcVLuMmkbNEl7Ji2Li4tbavK1pW4GYmyI0a363YXQmdAbkp8Du Og== 
Received: from ma1-mtap-s03.corp.apple.com (ma1-mtap-s03.corp.apple.com [17.40.76.7])
        by ma1-aaemail-dr-lapp03.apple.com with ESMTP id 2pa3b4xghh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 14 Dec 2018 07:52:27 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-type: text/plain; CHARSET=US-ASCII
Received: from nwk-mmpp-sz10.apple.com
 (nwk-mmpp-sz10.apple.com [17.128.115.122]) by ma1-mtap-s03.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PJQ0078ZHFFQ980@ma1-mtap-s03.corp.apple.com>; Fri,
 14 Dec 2018 07:52:27 -0800 (PST)
Received: from process_viserion-daemon.nwk-mmpp-sz10.apple.com by
 nwk-mmpp-sz10.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PJQ00H00GWRZ600@nwk-mmpp-sz10.apple.com>; Fri,
 14 Dec 2018 07:52:27 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 3292cb8df71769077a8e6c728895331c
X-Va-E-CD: 4323c9cb7650976afee1876783f7d85e
X-Va-R-CD: d885efb23def6dc3d7fbf3a036d898ad
X-Va-CD: 0
X-Va-ID: 564623da-b79c-4b90-8acc-c48569a9b278
X-V-A:  
X-V-T-CD: e3ce1f560f53d3ee7d03c9da4c45394f
X-V-E-CD: 4323c9cb7650976afee1876783f7d85e
X-V-R-CD: d885efb23def6dc3d7fbf3a036d898ad
X-V-CD: 0
X-V-ID: fd7be8f1-d2da-4fe7-97a6-098fde22d970
Received: from process_milters-daemon.nwk-mmpp-sz10.apple.com by
 nwk-mmpp-sz10.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PJQ00J00H32SS00@nwk-mmpp-sz10.apple.com>; Fri,
 14 Dec 2018 07:52:26 -0800 (PST)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2018-12-14_08:,, signatures=0
Received: from localhost ([17.234.103.59]) by nwk-mmpp-sz10.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPSA id <0PJQ006ZXHFE8340@nwk-mmpp-sz10.apple.com>; Fri,
 14 Dec 2018 07:52:26 -0800 (PST)
Date:   Fri, 14 Dec 2018 07:52:26 -0800
From:   Christoph Paasch <cpaasch@apple.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Tyler Hicks <tyhicks@canonical.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4.14 09/89] net: Prevent invalid access to skb->prev in
 __qdisc_drop_all
Message-id: <20181214155226.GJ41383@MacBook-Pro-19.local>
References: <20181214115729.658859279@linuxfoundation.org>
 <20181214115730.135586551@linuxfoundation.org>
In-reply-to: <20181214115730.135586551@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

On 14/12/18 - 12:59:22, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Christoph Paasch <cpaasch@apple.com>
> 
> [ Upstream commit 9410d386d0a829ace9558336263086c2fbbe8aed ]
> 
> __qdisc_drop_all() accesses skb->prev to get to the tail of the
> segment-list.
> 
> With commit 68d2f84a1368 ("net: gro: properly remove skb from list")
> the skb-list handling has been changed to set skb->next to NULL and set
> the list-poison on skb->prev.
> 
> With that change, __qdisc_drop_all() will panic when it tries to
> dereference skb->prev.
> 
> Since commit 992cba7e276d ("net: Add and use skb_list_del_init().")
> __list_del_entry is used, leaving skb->prev unchanged (thus,
> pointing to the list-head if it's the first skb of the list).
> This will make __qdisc_drop_all modify the next-pointer of the list-head
> and result in a panic later on:
> 
> [   34.501053] general protection fault: 0000 [#1] SMP KASAN PTI
> [   34.501968] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.20.0-rc2.mptcp #108
> [   34.502887] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.5.1 01/01/2011
> [   34.504074] RIP: 0010:dev_gro_receive+0x343/0x1f90
> [   34.504751] Code: e0 48 c1 e8 03 42 80 3c 30 00 0f 85 4a 1c 00 00 4d 8b 24 24 4c 39 65 d0 0f 84 0a 04 00 00 49 8d 7c 24 38 48 89 f8 48 c1 e8 03 <42> 0f b6 04 30 84 c0 74 08 3c 04
> [   34.507060] RSP: 0018:ffff8883af507930 EFLAGS: 00010202
> [   34.507761] RAX: 0000000000000007 RBX: ffff8883970b2c80 RCX: 1ffff11072e165a6
> [   34.508640] RDX: 1ffff11075867008 RSI: ffff8883ac338040 RDI: 0000000000000038
> [   34.509493] RBP: ffff8883af5079d0 R08: ffff8883970b2d40 R09: 0000000000000062
> [   34.510346] R10: 0000000000000034 R11: 0000000000000000 R12: 0000000000000000
> [   34.511215] R13: 0000000000000000 R14: dffffc0000000000 R15: ffff8883ac338008
> [   34.512082] FS:  0000000000000000(0000) GS:ffff8883af500000(0000) knlGS:0000000000000000
> [   34.513036] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   34.513741] CR2: 000055ccc3e9d020 CR3: 00000003abf32000 CR4: 00000000000006e0
> [   34.514593] Call Trace:
> [   34.514893]  <IRQ>
> [   34.515157]  napi_gro_receive+0x93/0x150
> [   34.515632]  receive_buf+0x893/0x3700
> [   34.516094]  ? __netif_receive_skb+0x1f/0x1a0
> [   34.516629]  ? virtnet_probe+0x1b40/0x1b40
> [   34.517153]  ? __stable_node_chain+0x4d0/0x850
> [   34.517684]  ? kfree+0x9a/0x180
> [   34.518067]  ? __kasan_slab_free+0x171/0x190
> [   34.518582]  ? detach_buf+0x1df/0x650
> [   34.519061]  ? lapic_next_event+0x5a/0x90
> [   34.519539]  ? virtqueue_get_buf_ctx+0x280/0x7f0
> [   34.520093]  virtnet_poll+0x2df/0xd60
> [   34.520533]  ? receive_buf+0x3700/0x3700
> [   34.521027]  ? qdisc_watchdog_schedule_ns+0xd5/0x140
> [   34.521631]  ? htb_dequeue+0x1817/0x25f0
> [   34.522107]  ? sch_direct_xmit+0x142/0xf30
> [   34.522595]  ? virtqueue_napi_schedule+0x26/0x30
> [   34.523155]  net_rx_action+0x2f6/0xc50
> [   34.523601]  ? napi_complete_done+0x2f0/0x2f0
> [   34.524126]  ? kasan_check_read+0x11/0x20
> [   34.524608]  ? _raw_spin_lock+0x7d/0xd0
> [   34.525070]  ? _raw_spin_lock_bh+0xd0/0xd0
> [   34.525563]  ? kvm_guest_apic_eoi_write+0x6b/0x80
> [   34.526130]  ? apic_ack_irq+0x9e/0xe0
> [   34.526567]  __do_softirq+0x188/0x4b5
> [   34.527015]  irq_exit+0x151/0x180
> [   34.527417]  do_IRQ+0xdb/0x150
> [   34.527783]  common_interrupt+0xf/0xf
> [   34.528223]  </IRQ>
> 
> This patch makes sure that skb->prev is set to NULL when entering
> netem_enqueue.
> 
> Cc: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
> Cc: Tyler Hicks <tyhicks@canonical.com>
> Cc: Eric Dumazet <eric.dumazet@gmail.com>
> Fixes: 68d2f84a1368 ("net: gro: properly remove skb from list")
> Suggested-by: Eric Dumazet <eric.dumazet@gmail.com>
> Signed-off-by: Christoph Paasch <cpaasch@apple.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I don't think this patch needs to be backported. I haven't hit this panic on
v4.14.x (although, I only have been using v4.14.79 for now - not yet the
latest one). And the commits that seem to have introduced the issue haven't
been backported either AFAICS. That being said, I don't think a backport
would cause any side-effects.

Or have you seen reports of this panic in the stable branches?

(same for the other stable branches v4.4,... - cfr., the other mails
regarding this patch here)


Cheers,
Christoph




> ---
>  net/sched/sch_netem.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -436,6 +436,9 @@ static int netem_enqueue(struct sk_buff
>  	int count = 1;
>  	int rc = NET_XMIT_SUCCESS;
>  
> +	/* Do not fool qdisc_drop_all() */
> +	skb->prev = NULL;
> +
>  	/* Random duplication */
>  	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor))
>  		++count;
> 
> 

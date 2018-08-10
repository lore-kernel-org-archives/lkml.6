Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDA4C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFE12240D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFE12240D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeHJNXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 09:23:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:57210 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727270AbeHJNXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 09:23:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 43E13AE16;
        Fri, 10 Aug 2018 10:54:19 +0000 (UTC)
Subject: Re: [PATCH net-next] xen-netfront: fix warn message as irq device
 name has '/'
To:     Xiao Liang <xiliang@redhat.com>, netdev@vger.kernel.org,
        xen-devel@lists.xenproject.org, davem@davemloft.net,
        boris.ostrovsky@oracle.com
Cc:     linux-kernel@vger.kernel.org
References: <20180809060355.6525-1-xiliang@redhat.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <979c86e8-41dc-604e-5367-d09b4f1f57e9@suse.com>
Date:   Fri, 10 Aug 2018 12:54:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180809060355.6525-1-xiliang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/18 08:03, Xiao Liang wrote:
> There is a call trace generated after commit 2d408c0d4574b01b9ed45e02516888bf925e11a9(
> xen-netfront: fix queue name setting). There is no 'device/vif/xx-q0-tx' file found
> under /proc/irq/xx/.
> 
> This patch only picks up device type and id as its name.
> 
> With the patch, now /proc/interrupts looks like and the warning message gone:
>  70:         21          0          0          0   xen-dyn    -event     vif0-q0-tx
>  71:         15          0          0          0   xen-dyn    -event     vif0-q0-rx
>  72:         14          0          0          0   xen-dyn    -event     vif0-q1-tx
>  73:         33          0          0          0   xen-dyn    -event     vif0-q1-rx
>  74:         12          0          0          0   xen-dyn    -event     vif0-q2-tx
>  75:         24          0          0          0   xen-dyn    -event     vif0-q2-rx
>  76:         19          0          0          0   xen-dyn    -event     vif0-q3-tx
>  77:         21          0          0          0   xen-dyn    -event     vif0-q3-rx
> 
> Below is call trace information without this patch:
> 
> name 'device/vif/0-q0-tx'
> WARNING: CPU: 2 PID: 37 at fs/proc/generic.c:174 __xlate_proc_name+0x85/0xa0
> RIP: 0010:__xlate_proc_name+0x85/0xa0
> RSP: 0018:ffffb85c40473c18 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000000006
> RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff984c7f516930
> RBP: ffffb85c40473cb8 R08: 000000000000002c R09: 0000000000000229
> R10: 0000000000000000 R11: 0000000000000001 R12: ffffb85c40473c98
> R13: ffffb85c40473cb8 R14: ffffb85c40473c50 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff984c7f500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f69b6899038 CR3: 000000001c20a006 CR4: 00000000001606e0
> Call Trace:
> __proc_create+0x45/0x230
> ? snprintf+0x49/0x60
> proc_mkdir_data+0x35/0x90
> register_handler_proc+0xef/0x110
> ? proc_register+0xfc/0x110
> ? proc_create_data+0x70/0xb0
> __setup_irq+0x39b/0x660
> ? request_threaded_irq+0xad/0x160
> request_threaded_irq+0xf5/0x160
> ? xennet_tx_buf_gc+0x1d0/0x1d0 [xen_netfront]
> bind_evtchn_to_irqhandler+0x3d/0x70
> ? xenbus_alloc_evtchn+0x41/0xa0
> netback_changed+0xa46/0xcda [xen_netfront]
> ? find_watch+0x40/0x40
> xenwatch_thread+0xc5/0x160
> ? finish_wait+0x80/0x80
> kthread+0x112/0x130
> ? kthread_create_worker_on_cpu+0x70/0x70
> ret_from_fork+0x35/0x40
> Code: 81 5c 00 48 85 c0 75 cc 5b 49 89 2e 31 c0 5d 4d 89 3c 24 41 5c 41 5d 41 5e 41 5f c3 4c 89 ee 48 c7 c7 40 4f 0e b4 e8 65 ea d8 ff <0f> 0b b8 fe ff ff ff 5b 5d 41 5c 41 5d 41 5e 41 5f c3 66 0f 1f
> ---[ end trace 650e5561b0caab3a ]---
> 
> Signed-off-by: Xiao Liang <xiliang@redhat.com>
> ---
>  drivers/net/xen-netfront.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
> index 799cba4624a5..6f40df4a452e 100644
> --- a/drivers/net/xen-netfront.c
> +++ b/drivers/net/xen-netfront.c
> @@ -1604,14 +1604,16 @@ static int xennet_init_queue(struct netfront_queue *queue)
>  {
>  	unsigned short i;
>  	int err = 0;
> +	int devid = 0;
>  
>  	spin_lock_init(&queue->tx_lock);
>  	spin_lock_init(&queue->rx_lock);
>  
>  	timer_setup(&queue->rx_refill_timer, rx_refill_timeout, 0);
>  
> -	snprintf(queue->name, sizeof(queue->name), "%s-q%u",
> -		 queue->info->xbdev->nodename, queue->id);
> +	kstrtoint(strrchr(queue->info->xbdev->nodename,'/')+1, 10, &devid);

Please add blanks before '/' and around the +.

With that you can add my:

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

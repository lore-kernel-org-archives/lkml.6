Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968381AbeE2WTQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:19:16 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:47203 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967747AbeE2WTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:19:11 -0400
Date: Tue, 29 May 2018 15:19:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kevin Easton <kevin@guarana.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [net] vhost: Use kzalloc() to allocate vhost_msg_node
Message-ID: <20180529221908.GA22742@roeck-us.net>
References: <20180427154502.GA22544@la.guarana.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427154502.GA22544@la.guarana.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 11:45:02AM -0400, Kevin Easton wrote:
> The struct vhost_msg within struct vhost_msg_node is copied to userspace,
> so it should be allocated with kzalloc() to ensure all structure padding
> is zeroed.
> 
> Signed-off-by: Kevin Easton <kevin@guarana.org>
> Reported-by: syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com

Is this patch going anywhere ?

The patch fixes CVE-2018-1118. It would be useful to understand if and when
this problem is going to be fixed.

Thanks,
Guenter

> ---
>  drivers/vhost/vhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index f3bd8e9..1b84dcff 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2339,7 +2339,7 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
>  /* Create a new message. */
>  struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
>  {
> -	struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
> +	struct vhost_msg_node *node = kzalloc(sizeof *node, GFP_KERNEL);
>  	if (!node)
>  		return NULL;
>  	node->vq = vq;

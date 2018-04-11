Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753549AbeDKNYI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:24:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753091AbeDKNYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:24:06 -0400
Date: Wed, 11 Apr 2018 16:24:02 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>, jasowang@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] vhost: fix vhost_vq_access_ok() log check
Message-ID: <20180411162345-mutt-send-email-mst@kernel.org>
References: <20180411023541.15776-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411023541.15776-1-stefanha@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 10:35:39AM +0800, Stefan Hajnoczi wrote:
> v3:
>  * Rebased onto net/master and resolved conflict [DaveM]
> 
> v2:
>  * Rewrote the conditional to make the vq access check clearer [Linus]
>  * Added Patch 2 to make the return type consistent and harder to misuse [Linus]
> 
> The first patch fixes the vhost virtqueue access check which was recently
> broken.  The second patch replaces the int return type with bool to prevent
> future bugs.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

We need the 1st one on stable I think.


> Stefan Hajnoczi (2):
>   vhost: fix vhost_vq_access_ok() log check
>   vhost: return bool from *_access_ok() functions
> 
>  drivers/vhost/vhost.h |  4 +--
>  drivers/vhost/vhost.c | 70 ++++++++++++++++++++++++++-------------------------
>  2 files changed, 38 insertions(+), 36 deletions(-)
> 
> -- 
> 2.14.3

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753406AbeDSO4H (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:56:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751876AbeDSO4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:56:06 -0400
Date: Thu, 19 Apr 2018 17:56:04 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>, Thomas Huth <thuth@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net 2/3] virtio_net: fix adding vids on big-endian
Message-ID: <20180419175456-mutt-send-email-mst@kernel.org>
References: <1524115776-334953-1-git-send-email-mst@redhat.com>
 <1524115776-334953-3-git-send-email-mst@redhat.com>
 <20180419152641.092865f3.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419152641.092865f3.cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 03:26:41PM +0200, Cornelia Huck wrote:
> On Thu, 19 Apr 2018 08:30:49 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Programming vids (adding or removing them) still passes
> > guest-endian values in the DMA buffer. That's wrong
> > if guest is big-endian and when virtio 1 is enabled.
> > 
> > Note: this is on top of a previous patch:
> > 	virtio_net: split out ctrl buffer
> > 
> > Fixes: 9465a7a6f ("virtio_net: enable v1.0 support")
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Ouch. Have you seen any bug reports for that?

No, but then vlans within VMs aren't used too often
(as opposed to attaching vlans by the HV).

-- 
MST

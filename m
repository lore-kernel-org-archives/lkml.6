Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753928AbeEUWI1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 18:08:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753046AbeEUWIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 18:08:24 -0400
Date: Tue, 22 May 2018 01:08:23 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Miller <davem@davemloft.net>
Cc: jasowang@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hannes@stressinduktion.org,
        edumazet@google.com
Subject: Re: [PATCH net] tuntap: raise EPOLLOUT on device up
Message-ID: <20180522010700-mutt-send-email-mst@kernel.org>
References: <1526648443-24128-1-git-send-email-jasowang@redhat.com>
 <20180521.114742.427929977852677864.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521.114742.427929977852677864.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 11:47:42AM -0400, David Miller wrote:
> From: Jason Wang <jasowang@redhat.com>
> Date: Fri, 18 May 2018 21:00:43 +0800
> 
> > We return -EIO on device down but can not raise EPOLLOUT after it was
> > up. This may confuse user like vhost which expects tuntap to raise
> > EPOLLOUT to re-enable its TX routine after tuntap is down. This could
> > be easily reproduced by transmitting packets from VM while down and up
> > the tap device. Fixing this by set SOCKWQ_ASYNC_NOSPACE on -EIO.
> > 
> > Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Fixes: 1bd4978a88ac2 ("tun: honor IFF_UP in tun_get_user()")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> I'm no so sure what to do with this patch.
> 
> Like Michael says, this flag bit is only checks upon transmit which
> may or may not happen after this point.  It doesn't seem to be
> guaranteed.

Jason, can't we detect a link up transition and respond accordingly?
What do you think?

-- 
MST

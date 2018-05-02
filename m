Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbeEBOkT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:40:19 -0400
Received: from la.guarana.org ([173.254.219.205]:47710 "EHLO la.guarana.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751175AbeEBOkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:40:17 -0400
Date: Wed, 2 May 2018 10:40:15 -0400
From: Kevin Easton <kevin@guarana.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH] vhost: make msg padding explicit
Message-ID: <20180502144015.GA18389@la.guarana.org>
References: <20180501.140551.1944561534446599966.davem@davemloft.net>
 <20180502062809.GA14485@la.guarana.org>
 <20180502162932-mutt-send-email-mst@kernel.org>
 <20180502.100446.106883595468297057.davem@davemloft.net>
 <20180502171909-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502171909-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 05:19:27PM +0300, Michael S. Tsirkin wrote:
> On Wed, May 02, 2018 at 10:04:46AM -0400, David Miller wrote:
> > From: "Michael S. Tsirkin" <mst@redhat.com>
> > Date: Wed, 2 May 2018 16:36:37 +0300
> > 
> > > Ouch.  True - and in particular the 32 bit ABI on 64 bit kernels doesn't
> > > work at all. Hmm. It's relatively new and maybe there aren't any 32 bit
> > > users yet. Thoughts?
> > 
> > If it's been in a released kernel version, we really aren't at liberty
> > to play "maybe nobody uses this" UAPI changing games.
> > 
> > Please send me a revert.
> 
> Sent. Looking at compat mess now.

Just naming the padding field isn't sufficient anyway, there also needs to
be code in vhost_new_msg() to initialise it using the name.

    - Kevin

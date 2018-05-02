Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeEBG2P (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 02:28:15 -0400
Received: from la.guarana.org ([173.254.219.205]:50544 "EHLO la.guarana.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751069AbeEBG2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 02:28:12 -0400
Date: Wed, 2 May 2018 02:28:09 -0400
From: Kevin Easton <kevin@guarana.org>
To: David Miller <davem@davemloft.net>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, jasowang@redhat.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] vhost: make msg padding explicit
Message-ID: <20180502062809.GA14485@la.guarana.org>
References: <1524844881-178524-1-git-send-email-mst@redhat.com>
 <20180501.112822.1871426720257639849.davem@davemloft.net>
 <20180501201841-mutt-send-email-mst@kernel.org>
 <20180501.140551.1944561534446599966.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501.140551.1944561534446599966.davem@davemloft.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 02:05:51PM -0400, David Miller wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Date: Tue, 1 May 2018 20:19:19 +0300
> 
> > On Tue, May 01, 2018 at 11:28:22AM -0400, David Miller wrote:
> >> From: "Michael S. Tsirkin" <mst@redhat.com>
> >> Date: Fri, 27 Apr 2018 19:02:05 +0300
> >> 
> >> > There's a 32 bit hole just after type. It's best to
> >> > give it a name, this way compiler is forced to initialize
> >> > it with rest of the structure.
> >> > 
> >> > Reported-by: Kevin Easton <kevin@guarana.org>
> >> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> 
> >> Michael, will you be sending this directly to Linus or would you like
> >> me to apply it to net or net-next?
> >> 
> >> Thanks.
> > 
> > I'd prefer you to apply it for net and cc stable if possible.
> 
> Ok, applied, and added to my -stable submission queue.

Hold on, this patch changes the layout for i386 (where there is
no padding at all).  And it's part of UAPI.

    - Kevin

> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbeCVVsN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 17:48:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751739AbeCVVsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 17:48:11 -0400
Date: Thu, 22 Mar 2018 15:48:10 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Cc: Shunyong Yang <shunyong.yang@hxt-semitech.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH] vfio-mdev/samples: change RDI interrupt condition
Message-ID: <20180322154810.169b10af@w520.home>
In-Reply-To: <c14684a6-9388-e38a-c99a-a393c5bcf2a4@nvidia.com>
References: <1520492887-8021-1-git-send-email-shunyong.yang@hxt-semitech.com>
        <c14684a6-9388-e38a-c99a-a393c5bcf2a4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2018 11:36:05 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Thanks for fixing it.
> Patch looks good to me.
> +Alex to pull this patch.
> 
> Reviewed by: Kirti Wankhede <kwankhede@nvidia.com>

Applied to vfio next branch for v4.17 with Kirti's Rb.  Thanks,

Alex

> On 3/8/2018 12:38 PM, Shunyong Yang wrote:
> > When FIFO mode is enabled, the receive data available interrupt
> > (UART_IIR_RDI in code) should be triggered when the number of data
> > in FIFO is equal or larger than interrupt trigger level.
> > 
> > This patch changes the trigger level check to ensure multiple bytes
> > received from upper layer can trigger RDI interrupt correctly.
> > 
> > Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> > Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> > ---
> >  samples/vfio-mdev/mtty.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
> > index 09f255bdf3ac..7abb79d8313d 100644
> > --- a/samples/vfio-mdev/mtty.c
> > +++ b/samples/vfio-mdev/mtty.c
> > @@ -534,7 +534,7 @@ static void handle_bar_read(unsigned int index, struct mdev_state *mdev_state,
> >  
> >  		/* Interrupt priority 2: Fifo trigger level reached */
> >  		if ((ier & UART_IER_RDI) &&
> > -		    (mdev_state->s[index].rxtx.count ==
> > +		    (mdev_state->s[index].rxtx.count >=
> >  		      mdev_state->s[index].intr_trigger_level))
> >  			*buf |= UART_IIR_RDI;
> >  
> >   

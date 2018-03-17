Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1569667-1521296937-2-17276198350234075773
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521296936; b=ZW+MyJEbGM5FYNaI2qTNxFqkXBXB+08G32GqbtkrCdqfCQu
    +Bgrb5M3OfrHwPxzNkWEUu6kRp3OzR0CDaimlmiRpJvcTv0qT82+agXqyleT4fce
    Zk4ISLR7QBPSTk/fGhKFVL7XM1uNwn9bXMuL7+qIyk8NI2EIPXel+N/sI5e16op4
    A5jSJGUSP+UW7nYftq5K+fL6lM9NFUp/JVgtXpsfE7l64MAe2+W9kbAqJshqbPH+
    bi8SBL+TkGgGTtV8PGUVbM9IvJzQqNTl+IyzFDP3xSQSGGzoSQoYs2florwf3Zst
    QuhRIhNUlBT9snfZjF7LZqVzTYJGt6IODDDbshg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521296936; bh=XzZDGK2n3/UTXWp1QktE9FO1hB
    8cL3KjZVLMkS625/Y=; b=UDfE5HsrTLCqGOgW890FMr1754tUIVxrVBTx+jS3IF
    VPN/QE5AQa+Q2ZU7FXHLbulOwKyclfsrqNBRGaaJTOhW/NMy2vde6FaPaRtyMyN+
    g3CA2c1EVP2O3qyR4CcaENSxveAzja15FMIC+hDq+EupTwCH+8Uae819J0zowyd5
    ecL0lzVvcdfWeNXxn2SvKG2E87e7t6A+reHJviLZfPmBhsMI4GpfpiAWuhWVLLgQ
    Dsvg0l19A4a18HmonVRmUJJTkqifA2WnJ3Vi5XIuxmsNg6YW1h0qiVEhif5m1l0e
    vULpCjWybKvWFM5LpqF9eg8OMnumaHm9Avv1wzozmWzw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeCQO2z (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Mar 2018 10:28:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:48788 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752398AbeCQO2y (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 17 Mar 2018 10:28:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,321,1517904000";
   d="scan'208";a="26100353"
Date: Sat, 17 Mar 2018 20:02:57 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Eric Anholt <eric@anholt.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.14 064/109] dmaengine: bcm2835-dma: Use
 vchan_terminate_vdesc() instead of desc_free
Message-ID: <20180317143253.GI15443@localhost>
References: <20180316152329.844663293@linuxfoundation.org>
 <20180316152333.462064800@linuxfoundation.org>
 <20180316184640.rxw6kwvqghsmdgcc@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316184640.rxw6kwvqghsmdgcc@xps>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 01:46:40PM -0500, Dan Rue wrote:
> On Fri, Mar 16, 2018 at 04:23:33PM +0100, Greg Kroah-Hartman wrote:
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > 
> > 
> > [ Upstream commit de92436ac40ffe9933230aa503e24dbb5ede9201 ]
> > 
> > To avoid race with vchan_complete, use the race free way to terminate
> > running transfer.
> > 
> > Implement the device_synchronize callback to make sure that the terminated
> > descriptor is freed.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Acked-by: Eric Anholt <eric@anholt.net>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This patch is causing a build error on arm and arm64 per i.e.
> https://kernelci.org/build/id/5aac017e59b5141cb1b3a4d5/
> 
> Builds are also failing for arm/arm64 on 4.15 and this patch seems to be a
> problem there as well, but I have not verified it yet.

I think we are missing commit 1c7f072d94e8. Pls cherrypick that as well

commit 1c7f072d94e8b697fd9b70cdb268622a18faf522
Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date:   Tue Nov 14 16:32:04 2017 +0200

    dmaengine: virt-dma: Support for race free transfer termination

This adds vchan_terminate_vdesc API..


> 
> #
> # make -j10 -k -s ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=build-arm64 defconfig
> #
> #
> # make -j10 -k -s ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=build-arm64
> #
> arch/arm64/Makefile:48: Detected assembler with broken .inst; disassembly will be unreliable
> ../drivers/dma/bcm2835-dma.c: In function 'bcm2835_dma_terminate_all':
> ../drivers/dma/bcm2835-dma.c:815:3: error: implicit declaration of function 'vchan_terminate_vdesc' [-Werror=implicit-function-declaration]
>    vchan_terminate_vdesc(&c->desc->vd);
>    ^
> cc1: some warnings being treated as errors
> ../scripts/Makefile.build:334: recipe for target 'drivers/dma/bcm2835-dma.o' failed
> make[3]: *** [drivers/dma/bcm2835-dma.o] Error 1
> make[3]: Target '__build' not remade because of errors.
> ../scripts/Makefile.build:587: recipe for target 'drivers/dma' failed
> make[2]: *** [drivers/dma] Error 2
> make[2]: Target '__build' not remade because of errors.
> /home/buildslave/workspace/kernel-single-defconfig-builder/defconfig/defconfig/label/builder/Makefile:1031: recipe for target 'drivers' failed
> make[1]: *** [drivers] Error 2
> make[1]: Target '_all' not remade because of errors.
> Makefile:146: recipe for target 'sub-make' failed
> make: *** [sub-make] Error 2
> make: Target '_all' not remade because of errors.
> 
> > ---
> >  drivers/dma/bcm2835-dma.c |   10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > --- a/drivers/dma/bcm2835-dma.c
> > +++ b/drivers/dma/bcm2835-dma.c
> > @@ -812,7 +812,7 @@ static int bcm2835_dma_terminate_all(str
> >  	 * c->desc is NULL and exit.)
> >  	 */
> >  	if (c->desc) {
> > -		bcm2835_dma_desc_free(&c->desc->vd);
> > +		vchan_terminate_vdesc(&c->desc->vd);
> >  		c->desc = NULL;
> >  		bcm2835_dma_abort(c->chan_base);
> >  
> > @@ -836,6 +836,13 @@ static int bcm2835_dma_terminate_all(str
> >  	return 0;
> >  }
> >  
> > +static void bcm2835_dma_synchronize(struct dma_chan *chan)
> > +{
> > +	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
> > +
> > +	vchan_synchronize(&c->vc);
> > +}
> > +
> >  static int bcm2835_dma_chan_init(struct bcm2835_dmadev *d, int chan_id,
> >  				 int irq, unsigned int irq_flags)
> >  {
> > @@ -942,6 +949,7 @@ static int bcm2835_dma_probe(struct plat
> >  	od->ddev.device_prep_dma_memcpy = bcm2835_dma_prep_dma_memcpy;
> >  	od->ddev.device_config = bcm2835_dma_slave_config;
> >  	od->ddev.device_terminate_all = bcm2835_dma_terminate_all;
> > +	od->ddev.device_synchronize = bcm2835_dma_synchronize;
> >  	od->ddev.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> >  	od->ddev.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> >  	od->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) |
> > 
> > 

-- 
~Vinod

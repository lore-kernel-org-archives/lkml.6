Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521484075-2-6637310377587942909
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521484074; b=fwKCjd3j035incSU6vY6olZ1UZpdLtJ2rLZbEwo8I8qQ0vt
    jFtDm+xxgLCz0Lo2DwJMr/07JfcFRo9TmvL1PWurdPzGsV6JM+rdCMcJ9XewdMjD
    8M34/rwji4FQAboMVOZhgwtfsCAr2QTXpdCbZSHVbTN9Id46fc47HFTR5vv54Zg2
    RX2rEfYB9oVtptEp2AkdKfGVLIWBblE0EdmBbWLHEmmD9/rrLPGrlWgFInsel+g1
    X0Er1Fs33xLtpWI93b5hsjG3+HjOfSjC8Molz+MQvNvtvGO4hM3isc3gR3OSay1m
    ZtdqvL5Nj90P2p4PxRyH1f9LWHSa/g3yf9tTA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484074; bh=oT09+khX+Y5ol73evRAXJ+5UxC
    er1cTd+KDpbyNJUYU=; b=dGc3injfODrCT/e7psvYXpRTLmS3mUf0LVR8lL7Wgu
    HcFH0ud7udEoairmMoE5wXDhaWJ59bmul1ZKiYCqeulaMqlKCxIJ69IG/kGtdkpv
    FvSr0WZvsWgf+JH67PKjJCD3oHPfwrcsD7X8fzVSTUf4ato7Hg64eVrFMPUrmTPs
    UB/S/fUnhlGQN4HEIErCE7WldveshipW0cHfhNP2UbuHMJTckIeZCU57oF+y3711
    tzoQ1KnaA4OPIgequA5rtUEvDzhv9RsBsg69JFZqDV5vg/kLzjGO3BsgjCjErtcn
    1ndqcUQq94F7c7i7usc6grt+X/hAAlwvaWcUdEgft86g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefgeelleenucevlhhushhtvghrufhiiigvpeekje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefgeelleenucevlhhushhtvghrufhiiigvpeekje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964936AbeCSS1v (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:27:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51370 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031719AbeCSS1t (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:27:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Eric Anholt <eric@anholt.net>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 185/241] dmaengine: bcm2835-dma: Use vchan_terminate_vdesc() instead of desc_free
Date: Mon, 19 Mar 2018 19:07:30 +0100
Message-Id: <20180319180758.806946963@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Ujfalusi <peter.ujfalusi@ti.com>


[ Upstream commit de92436ac40ffe9933230aa503e24dbb5ede9201 ]

To avoid race with vchan_complete, use the race free way to terminate
running transfer.

Implement the device_synchronize callback to make sure that the terminated
descriptor is freed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/bcm2835-dma.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -812,7 +812,7 @@ static int bcm2835_dma_terminate_all(str
 	 * c->desc is NULL and exit.)
 	 */
 	if (c->desc) {
-		bcm2835_dma_desc_free(&c->desc->vd);
+		vchan_terminate_vdesc(&c->desc->vd);
 		c->desc = NULL;
 		bcm2835_dma_abort(c->chan_base);
 
@@ -836,6 +836,13 @@ static int bcm2835_dma_terminate_all(str
 	return 0;
 }
 
+static void bcm2835_dma_synchronize(struct dma_chan *chan)
+{
+	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
+
+	vchan_synchronize(&c->vc);
+}
+
 static int bcm2835_dma_chan_init(struct bcm2835_dmadev *d, int chan_id,
 				 int irq, unsigned int irq_flags)
 {
@@ -942,6 +949,7 @@ static int bcm2835_dma_probe(struct plat
 	od->ddev.device_prep_dma_memcpy = bcm2835_dma_prep_dma_memcpy;
 	od->ddev.device_config = bcm2835_dma_slave_config;
 	od->ddev.device_terminate_all = bcm2835_dma_terminate_all;
+	od->ddev.device_synchronize = bcm2835_dma_synchronize;
 	od->ddev.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	od->ddev.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	od->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) |

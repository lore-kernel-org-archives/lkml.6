Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3397032-1523481901-2-16433175288237244131
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523481901; b=i7bHhH2SVlJAHCaqCC9h9dmZhnQ/7+ZWz1rR6vFigB5lxZZsts
    Xy0lXp3Ns/UTJ/GTEPX2iXee7sm1uBLEgDwyr6KhuLC+WuNObQQHrBrvC7XUhN4S
    B06xOADFgW1rZGLuX1OOtINSAuoFQ9hYuE1LC+jUYVsq1Rz7gZw3mNZyhExTC0cr
    iYADgUHkW2FdEN430jXX0bgF03touUJtZZ599cM64hrR1EzQhn0uHV6lNFdkt9+t
    CaxL5bto4ANKF5XPjG0it/Ic/o0soCcxgXrISw+2ECBEP/Og8wq0uQ9t0+VY6/Qa
    D1x9WjRWZkc1NvPYU7vYx6j4Rf/W5Fk4gOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481901; bh=ClhH69JOz3HMrnNLzNv7Pu5iC51PWK
    O7/2vZVusEBJo=; b=edy5UmBGDYRog70GOQ0GmK3/p8gu7yFAdHptteoQv+XTk8
    81Z+/hD5/KGZFdBccKndVkufAVbWby6UV9t0kxi2XLgAysthuLEdJHVK4yY380nm
    M00uMm7uukAsjgyZ8nAF0FLzliWJ2arq20ZWgYKBC4fq77C+0YfwUO/Wx/AWwJXq
    1+RgJXV0avVXieGkjSS8/cdd3F2p4GO2NxiQm7vMfiYydnEOe8fDhA7WnYohphad
    SDTZ3fai4cKyKJ9hthmfXcaejtH6rK7GrI2p9sHSEo3YTLwf62lSlsxToCBOAOLy
    yrBz4XN8oIfWYqV+QegGsBfeQjXLone2EyOqU2pQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEDZknhmf+sjvT0vQfVJg6SDcf32/3+jByIUqezc6xzSvmPryVjJIp9ADWywN3r6ajQLbEDNoXzY0bW8nbxLUowTlQCeUQb801aca+pb0ovTnfCZR9ml
    NPPTj2sv0fN3/IhPOCKvcixqk1guyvGYhSGvUMa2HXaczr/ZKw+MTzM1puJekUhvtQMqWm0A3V+12TJrNs/omKDJyj7IjNTyz0dg99J6I9w5SVzCWbq52pLC
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Q-fNiiVtAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=u__7uJSp3HEpzIBEySsA:9 a=QEXdDO2ut3YA:10 a=Fp8MccfUoT0GBdDC_Lng:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754138AbeDKSih (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:38:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55434 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754050AbeDKSif (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:38:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anup Patel <anup.patel@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 023/121] async_tx: Fix DMA_PREP_FENCE usage in do_async_gen_syndrome()
Date: Wed, 11 Apr 2018 20:35:26 +0200
Message-Id: <20180411183457.549745035@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anup Patel <anup.patel@broadcom.com>


[ Upstream commit baae03a0e2497f49704628fd0aaf993cf98e1b99 ]

The DMA_PREP_FENCE is to be used when preparing Tx descriptor if output
of Tx descriptor is to be used by next/dependent Tx descriptor.

The DMA_PREP_FENSE will not be set correctly in do_async_gen_syndrome()
when calling dma->device_prep_dma_pq() under following conditions:
1. ASYNC_TX_FENCE not set in submit->flags
2. DMA_PREP_FENCE not set in dma_flags
3. src_cnt (= (disks - 2)) is greater than dma_maxpq(dma, dma_flags)

This patch fixes DMA_PREP_FENCE usage in do_async_gen_syndrome() taking
inspiration from do_async_xor() implementation.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/async_tx/async_pq.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/crypto/async_tx/async_pq.c
+++ b/crypto/async_tx/async_pq.c
@@ -62,9 +62,6 @@ do_async_gen_syndrome(struct dma_chan *c
 	dma_addr_t dma_dest[2];
 	int src_off = 0;
 
-	if (submit->flags & ASYNC_TX_FENCE)
-		dma_flags |= DMA_PREP_FENCE;
-
 	while (src_cnt > 0) {
 		submit->flags = flags_orig;
 		pq_src_cnt = min(src_cnt, dma_maxpq(dma, dma_flags));
@@ -83,6 +80,8 @@ do_async_gen_syndrome(struct dma_chan *c
 			if (cb_fn_orig)
 				dma_flags |= DMA_PREP_INTERRUPT;
 		}
+		if (submit->flags & ASYNC_TX_FENCE)
+			dma_flags |= DMA_PREP_FENCE;
 
 		/* Drivers force forward progress in case they can not provide
 		 * a descriptor

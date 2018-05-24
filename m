Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527162613-2-5751838212600988166
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162613; b=nNLiHt1j4+IlLZe5HVgv51dQJ19XYQINSw8r7oMYiVguIFqA17
    ooKpICdrhD61xDNUz5V7X4I7wIxXPV1Z00GL1B2yQF5u2lXrImDeJUeujfmVCq4A
    YgNuddcRlNYrHG8Y6HIww5m5/Wu0ZxDrz5tUcCxSLtI7TLoujMa5/5nOo6l4tYIk
    YBGrfVrL9iKHySR4g4UPhpFWNADOxIt/mKHlnBkVKHZQj51BkF6iYTafdtFub6Xq
    bUpKOh3CQ+BIx05gdK6X5XMNQl8Nq06yCZeb//xfFmw0s8GlB+fruH76VmZbBeQX
    qIutRFQ6bZyC7VhtHy+ByOVV3Ua5LSf8/INg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162613; bh=+Mk+C4AUJiK2MaVKIK+UygqPtITZHj
    +jIhozwzF9y6U=; b=NImqyRhJaIQgHtjoAkSUKPg7JhQuKdAKlK38oggowzULVt
    a2/vmluL8+p0AwL0ZNhjHi/owiHSsMWwE7yW75VKyA+4dPjdvBWrF+qYkD8+m/NB
    oVdNkt6zax3QUsodsvIMmgqpDTR95VzF39cokbKmiP0XXxd7vrlZsJ97Sw+lTL39
    lRQ9uIYctyPsecEo9m5CN93yp9ejcYwtGFBpklMO/OIVa3lbv0t36k3ZeSaWXnnf
    GQQsm+bU2zo+iuyfnjMVncnRes7+owQYjnEAN9Z7UQPYZOGfjtvkXIdK16MbWLKR
    zHUo/HKsriE+8MnyAKdMk0BwoKGv1uf7CDZXL2HA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=BuM041bi x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=BuM041bi x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIqm2xVbs1GyXDBrUhbV6fPszkm5jJ/N2bzfrzqgoZecElUSVjqQWlKZHnNOkeQfoyUwFR7E0jFIKjb7ifjAxgC7uW1jeaP0RYUlITTuV5yDCn32Czdo
    qwIP463G0mcBTCakHB6sFkQCcTls+5aMnVkiiOaOIlg1duZdQzYcNDHM85qdIfACg+ztC1ukPwFszxg8+kd9OdFWUtipFYjlUvBMxSv3x/bOSGlRJwkMnLz1
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=Ikd4Dj_1AAAA:8 a=yC-0_ovQAAAA:8 a=ag1SF4gXAAAA:8
    a=3-fnDJUvfadLGk-dozgA:9 a=QEXdDO2ut3YA:10 a=QsnFDINu91a9xkgZirup:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967008AbeEXLt6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:49:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966990AbeEXJrB (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:47:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Jianming Qiao <jianming.qiao@bp.renesas.com>
Subject: [PATCH 4.4 87/92] dmaengine: ensure dmaengine helpers check valid callback
Date: Thu, 24 May 2018 11:39:04 +0200
Message-Id: <20180524093207.591927770@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinod Koul <vinod.koul@intel.com>

commit 757d12e5849be549076901b0d33c60d5f360269c upstream.

dmaengine has various device callbacks and exposes helper
functions to invoke these. These helpers should check if channel,
device and callback is valid or not before invoking them.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Jianming Qiao <jianming.qiao@bp.renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/dmaengine.h |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -767,6 +767,9 @@ static inline struct dma_async_tx_descri
 	sg_dma_address(&sg) = buf;
 	sg_dma_len(&sg) = len;
 
+	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
+		return NULL;
+
 	return chan->device->device_prep_slave_sg(chan, &sg, 1,
 						  dir, flags, NULL);
 }
@@ -775,6 +778,9 @@ static inline struct dma_async_tx_descri
 	struct dma_chan *chan, struct scatterlist *sgl,	unsigned int sg_len,
 	enum dma_transfer_direction dir, unsigned long flags)
 {
+	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
+		return NULL;
+
 	return chan->device->device_prep_slave_sg(chan, sgl, sg_len,
 						  dir, flags, NULL);
 }
@@ -786,6 +792,9 @@ static inline struct dma_async_tx_descri
 	enum dma_transfer_direction dir, unsigned long flags,
 	struct rio_dma_ext *rio_ext)
 {
+	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
+		return NULL;
+
 	return chan->device->device_prep_slave_sg(chan, sgl, sg_len,
 						  dir, flags, rio_ext);
 }
@@ -796,6 +805,9 @@ static inline struct dma_async_tx_descri
 		size_t period_len, enum dma_transfer_direction dir,
 		unsigned long flags)
 {
+	if (!chan || !chan->device || !chan->device->device_prep_dma_cyclic)
+		return NULL;
+
 	return chan->device->device_prep_dma_cyclic(chan, buf_addr, buf_len,
 						period_len, dir, flags);
 }
@@ -804,6 +816,9 @@ static inline struct dma_async_tx_descri
 		struct dma_chan *chan, struct dma_interleaved_template *xt,
 		unsigned long flags)
 {
+	if (!chan || !chan->device || !chan->device->device_prep_interleaved_dma)
+		return NULL;
+
 	return chan->device->device_prep_interleaved_dma(chan, xt, flags);
 }
 
@@ -811,7 +826,7 @@ static inline struct dma_async_tx_descri
 		struct dma_chan *chan, dma_addr_t dest, int value, size_t len,
 		unsigned long flags)
 {
-	if (!chan || !chan->device)
+	if (!chan || !chan->device || !chan->device->device_prep_dma_memset)
 		return NULL;
 
 	return chan->device->device_prep_dma_memset(chan, dest, value,
@@ -824,6 +839,9 @@ static inline struct dma_async_tx_descri
 		struct scatterlist *src_sg, unsigned int src_nents,
 		unsigned long flags)
 {
+	if (!chan || !chan->device || !chan->device->device_prep_dma_sg)
+		return NULL;
+
 	return chan->device->device_prep_dma_sg(chan, dst_sg, dst_nents,
 			src_sg, src_nents, flags);
 }

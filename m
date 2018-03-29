Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1445413-1522346584-2-18028122187754801183
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522346584; b=VkGcXjaxIVgCIq/LgUQyqUDtbncTaczNzUswQ7b3GBEXKwaK8m
    my1Jy0vtSMDqxmrSWO5Ldj21SECm1AQ9K+eNGeHhzVw+yW5RG9iqZVO27zy6jlow
    CfNdWY8nw91FCgQp+cTRygY79cLSYXy4+DBYORzhGN0yTlm49PrGWZlL4gpNC8XE
    wiAf31PE5j0xxFJWDa+wr1P6gplU3SLVzmY5X2WayL4nBrqci0wMDqBAAB/hBuFc
    Je/e8iZgtKAdanH+NL4dR8ZYcA6DY7wnBe0f+fybqrWLeI/ayAwwlYJoRTCsFbtO
    xClZ+S6acEHMJhEnRYDI3tdpqoqfFfNwFEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1522346584; bh=8zF0B/rgfhmlmjdqZB1C6hC5dsocFf
    QCi2JKBPuoKew=; b=L5iAdxwIKueuW/Sx/RFOZYlelPxo312r0ZMgQU0mHyKZPY
    8302WwbQgPVIUh9n256bqNcU7/pu6FYRjWPH/nNqw5U6IlZfPidOnXsQGRHrX+qg
    P/8HijEyHA3NJrOp2yiGsbp6xp0Eg7/QW/H3bNpjhbbwApvqTTk2ujc9w8AJpfv8
    RJ+FqDTwwprHbN+GExCn5iF05tWUUXLET6K/igkVBwVSlXoN0NR4Bmphs8GmjRwn
    tzuVIzQ4MXvC3eXAFSjGMUIweeki+spKI3wBBSmpqqbxQ/ooCxCD3sKPHD+YJdH9
    z0XdZj2n3D1uCapcOIynmc4jCyqHLVjloLUPAauA==
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
X-CM-Envelope: MS4wfMxE4tj9WYk3SS4M//yj3RguUvg83OcL8oKvA8ZO2dWBU7x33f/gcVVwWGRpeOwo3VeP5v23VVrQ/vDNBPAMOrbXCoK3VlJ/zFtQL8w7zorl2HR4mn2b
    bpxKLTchfS3CVgPOVpkim6TIjwg47xHVhOniHyv/kOvAoaGp3HtF0/RFYuIjv/hSolh1+Q5dXqKXBeLBlpNX/9kYw4k88taqt+54MnNVwIYQGLRuIe5E6JLR
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=8AirrxEcAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=10cdx-2ws12E5IauM7oA:9
    a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752802AbeC2SDB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 14:03:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58388 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752147AbeC2SC7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 14:02:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Camelia Groza <camelia.groza@nxp.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 34/47] dpaa_eth: remove duplicate increment of the tx_errors counter
Date: Thu, 29 Mar 2018 20:00:15 +0200
Message-Id: <20180329175732.013029995@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Camelia Groza <camelia.groza@nxp.com>


[ Upstream commit 82d141cd19d088ee41feafde4a6f86eeb40d93c5 ]

The tx_errors counter is incremented by the dpaa_xmit caller.

Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2008,7 +2008,6 @@ static inline int dpaa_xmit(struct dpaa_
 	}
 
 	if (unlikely(err < 0)) {
-		percpu_stats->tx_errors++;
 		percpu_stats->tx_fifo_errors++;
 		return err;
 	}

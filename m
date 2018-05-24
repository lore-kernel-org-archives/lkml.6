Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1691122-1527155000-2-10747665177850343559
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527154999; b=LXXw7A8ge5VYLP1AAXzLWuRCZ7UpRuHqMZbZgjl6dVT0sIsWc+
    KuHgtBgNi7/HOLj53IGslQqktY7UdiAYS1iA2AW6FwTGSEJsQz1RSfunTkQfp3IA
    cidPwM1ojhuFw9rhMAuEwYluENick+NWG+l9A1O4NLQcczZKhqAL2oXucbLpoAnd
    Yt5B1QKAIPLhOWWiTq/FO5SFTlgmGR12dxDQvrbf4RFl2xpQdt5aza5FaDl7IYAG
    a0ifejdARQQ3ZxEVbJawMpARLEs1QfD3xVUcx/4ucKye+MBruBB7OYhayDbwnNWi
    mA4VcubmDfrp0x42VgiM3LYIVTdSo9AgFJIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527154999; bh=LPbuK20ES1PWwBWVpm+ZczrsjYs2C+
    SdddvZ4xGG03Q=; b=XrVJS7GuLqIPCwHeDkzI1LU7ViJgqfiFTlPBJ+V9ZLQVjK
    viOaDFQZDopLvfQ/trZFmTGhn/2uSG3SGQsKN4I8FRnUi84dSmBMnoIggH35WGP/
    +tKJ7qfYYIovqsbvIcNWu5JCeGw7qEprHloKXwj9zhGdefsxaHMArPhzk5LVRNxx
    emUVYKXYOVj7fBlXJ28f2ENSVpcJR0Xf6mH5AOZyL2VEaYwmL1J4MEVY3qzTsrnF
    QLQ75aCgIf6rgd9nBfhvHnPaZK57HMDSgZUNxjdATO4AIcNZedTydH4/CVUVfEd0
    MKs8q78BqHPQid9CyspEabkiGjWvdjXWtco8lp0w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=wUBXoNVA x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=wUBXoNVA x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfMFSDnXkWDAgRmsj1ejXExV8V3rwgtEgC4ZV6iXZ4gTeC/QNREEKH3Xx+VxCmTF46RZ4iqJ/hikdkPrZ7WXo3gSQajX7dQ+5luzJx93UBJ5MxBuI9UOG
    cpDrOx4no+YlNELgT+rcbm2HBXZwFPLsf3kh+Vq/ELr1ClnpxBPQp/3xt+4hiNn+kpC76rxVW46PUsZnD9icRQiPIYNNkAU6dcBBNXT+bZnhYMEWZS057yHw
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=Udi51pQLigb7wLLcoy4A:9
    a=leO6L6J5QhcLqcjX:21 a=DiLKg6yONuWM8hCT:21 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966180AbeEXJnR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:43:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966432AbeEXJnH (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:43:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Taglang <rob@taglang.io>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 06/92] net: ethernet: sun: niu set correct packet size in skb
Date: Thu, 24 May 2018 11:37:43 +0200
Message-Id: <20180524093159.859034674@linuxfoundation.org>
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

From: Rob Taglang <rob@taglang.io>

[ Upstream commit 14224923c3600bae2ac4dcae3bf0c3d4dc2812be ]

Currently, skb->len and skb->data_len are set to the page size, not
the packet size. This causes the frame check sequence to not be
located at the "end" of the packet resulting in ethernet frame check
errors. The driver does work currently, but stricter kernel facing
networking solutions like OpenVSwitch will drop these packets as
invalid.

These changes set the packet size correctly so that these errors no
longer occur. The length does not include the frame check sequence, so
that subtraction was removed.

Tested on Oracle/SUN Multithreaded 10-Gigabit Ethernet Network
Controller [108e:abcd] and validated in wireshark.

Signed-off-by: Rob Taglang <rob@taglang.io>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/sun/niu.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -3442,7 +3442,7 @@ static int niu_process_rx_pkt(struct nap
 
 		len = (val & RCR_ENTRY_L2_LEN) >>
 			RCR_ENTRY_L2_LEN_SHIFT;
-		len -= ETH_FCS_LEN;
+		append_size = len + ETH_HLEN + ETH_FCS_LEN;
 
 		addr = (val & RCR_ENTRY_PKT_BUF_ADDR) <<
 			RCR_ENTRY_PKT_BUF_ADDR_SHIFT;
@@ -3452,7 +3452,6 @@ static int niu_process_rx_pkt(struct nap
 					 RCR_ENTRY_PKTBUFSZ_SHIFT];
 
 		off = addr & ~PAGE_MASK;
-		append_size = rcr_size;
 		if (num_rcr == 1) {
 			int ptype;
 
@@ -3465,7 +3464,7 @@ static int niu_process_rx_pkt(struct nap
 			else
 				skb_checksum_none_assert(skb);
 		} else if (!(val & RCR_ENTRY_MULTI))
-			append_size = len - skb->len;
+			append_size = append_size - skb->len;
 
 		niu_rx_skb_append(skb, page, off, append_size, rcr_size);
 		if ((page->index + rp->rbr_block_size) - rcr_size == addr) {

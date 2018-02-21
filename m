Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1546708-1519219076-2-13710574716425575472
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519219076; b=rM/FWA5b2XHk7SdX/lgm1J5+YV0uPRMlDTm1EM5Kh1utLTV
    DMEWTHNNxHYF7o4KlyoA/ogFLRq5SfULDZa6l2iK8ziHvJ2TuzZgO2nGjyJFKRzA
    FlfSkhdgpKW/n/u8WawXOrmCpd+2OqrNjEj3O6p6ZvEUD2hoZxopVmsPXODqH5yz
    GrsTQxtBtd4u3rtZKwduK0ctYsGaDxafwgua8x+OHNeDtSnKUmbbawJqa9uyeZkw
    7Poo41UNsNl2M6yO+rSIa8wdMl9XN76K9qL9nI6R70koOSQkdtR5ZyHn4FwDfRMf
    WJZcZHgvFQ0vstbFZQLs9Sk5hC/3aHaCTE60q2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519219076; bh=17hQyQHffGH/v67S2ErXcnIjuR
    ozSDqH781gj8MkrjE=; b=CJejqpviSUe1zSsH7zqsSIbeKNOJlc/CU5sdQc6HgQ
    4fQOkKw6WSyHeQGh1ebChI7BQYZ9O5qBnhlciO78n+pdqXEuJJ3wz80nOfkf234V
    Mutze2zwhCWFJMdqmEWkccOg8+FRz4qqsrnhtKdTT3tfWHBwtCItl2V5JRr+VA1j
    R64Qk1/ByYFHDmuCCp5dS4e3gurb8LNRJIWDwFqS2I1U33s+pwUX3yYULy0sHzBZ
    39kg5n2FZ+fM8ETGA0Y9k6yLKMnHPD+yFiOGpsW4CwYRiotAlVb1xPtNepJsU2Y0
    HQPCEyzNwpIqtYyGQoieUg3gUzyYnn6jPDCCJMl+kNcQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbeBUNRb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:17:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45864 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965664AbeBUNMx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:12:53 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 4.15 158/163] arm: dts: mt7623: Update ethsys binding
Date: Wed, 21 Feb 2018 13:49:47 +0100
Message-Id: <20180221124538.668015839@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
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

From: Matthias Brugger <matthias.bgg@gmail.com>

commit 76a09ce214addb8ddc0f6d50dc1106a5f829e713 upstream.

The ethsys binding misses the reset-cells, this patch
adds this property.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/mt7623.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -758,6 +758,7 @@
 			     "syscon";
 		reg = <0 0x1b000000 0 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	eth: ethernet@1b100000 {

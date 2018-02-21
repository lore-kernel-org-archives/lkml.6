Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1568560-1519219051-2-9781835934263700698
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
    t=1519219050; b=ZqT4sMhBdcx2r4/wdmKLVBvLTYodfwFQasRE+HB6nGH4Wap
    3TzGwO/R6y+4qPqyszm+VsiBozui+BE+IHxv9IKwZuaumX5m2IiOfUmuHQlFugkK
    LFc7Dh93Xo8UAThbob4rVEEQdf2ovkHFsr+4V9kJV01Qkh8gDLkcCjMsrEhMGw79
    qyoWC1vp0AugtxBxbPC+E6W9IBRXTfHV/cNdJA5td53o3DpGhPKPKwAuVZob0JV2
    JPlXDlovuiWrvhVg1xKcfD0pTYDsgP6zHHxNuYS/Y97HS5Z2Zh/yDhHwViuDk5vP
    vwpcJWjvGs34iqFfGx1Go5xc5pvfOkIs3LLOPdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519219050; bh=M4A12Rb90eMYpGqBhr+5PGV3S+
    nGM7ljSxieIB+TMPk=; b=MTzVmHWVBR6d8uaojUF2da72+W9ER9W7J3qIl9A0Kg
    /wAbDyTqqSoYIBIERNm7LRH2WQRL6QFoLGoHxRFotL6A6VtHPIJvWIKg38albbFv
    YNA27XQ+WskXOd6TTfPHyqq4Ij+8k+8YiAIh68YQOChQqPcnNKhDVU7I9z41mhxB
    GFJgu3PcIP4qCX3Bx/83bC0wH7+aeHVUooePsdWegFZkD3WlBe+HKh16tUPlYFWr
    RVFNcEtphw4spcw6AODxNSS+7ipRHL4uYc4Jo0bhN4Q2aCy8zaJ6Nz9+kDVJOOKa
    GSPhc1j3UUn1ClhG3oTo2t7vplqi0CaxM2LDbRENajrg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeBUNRG (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:17:06 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45892 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965683AbeBUNM7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:12:59 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 4.15 159/163] arm: dts: mt2701: Add reset-cells
Date: Wed, 21 Feb 2018 13:49:48 +0100
Message-Id: <20180221124538.710036157@linuxfoundation.org>
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

commit ae72e95b5e4ded145bfc6926ad9457b74e3af41a upstream.

The hifsys and ethsys needs the definition of the reset-cells
property. Fix this.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/mt2701.dtsi |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -604,6 +604,7 @@
 		compatible = "mediatek,mt2701-hifsys", "syscon";
 		reg = <0 0x1a000000 0 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	usb0: usb@1a1c0000 {
@@ -688,6 +689,7 @@
 		compatible = "mediatek,mt2701-ethsys", "syscon";
 		reg = <0 0x1b000000 0 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	eth: ethernet@1b100000 {

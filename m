Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1344077-1526937825-2-1124245682580032216
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_20 -0.001, HEADER_FROM_DIFFERENT_DOMAINS 0.248,
  MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937824; b=JxzJ5wLCB9ZfDNDcl+0tr5eanEpS7dXo6Msy9Fs1pzAysjxeKQ
    ACmClpMRlBCuAjBKOKrf14ibBhDkqqVzvQtN/y/6cyNE315VMg55aJYQC+NYJPDS
    ujOwtfv99jW4Aw2qDR2PPRZMxXVhfJKj3drQfi+83k2827K4YlRh0YrHIqFJXYjq
    UUKiEe6w6z0NKGmMuk3bGPQuDUKuLcEg1/CBGZurThW5pOiWhmSG28RG6veiiLGX
    MuJ9fd9P2klGKmMFyn6x5lcGJxjbyXnrkVXikj6N2WbHgROpnOkAAQQzSSzHAejw
    tlrjAQvzJaA1o0l2n1RQZx2D4AoUDo6mLicA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937824; bh=nPwG9UH4JWPowqpoaidfuHvy16+oEE
    r8Yo8uLTUtqY4=; b=P50DLda0MbgStbBAgXj++pHo2OpL12FQfPwBb7rWs8O4kE
    XWkRO5zdf0uZkrn56Ug7wo39Is+Nn2iWx1x3P822Xz3bclbMnfNDK6PGajRiMwwy
    votrYYaccVZCR1aD5c9ieLxcgPRZSvZ8Q1MZPY92TzRCoiHx7h5YiG1E6UWq22pt
    GWlZtqMZIR5Yiz4Oh5kP1BGJnq+6V0g7AKy+wCOWWtOnrPU3wnoWO7PL2bGRCVWC
    ll4c5iIZPAl6wBhMVV0iAR+dfkqhmmAdXL5vgbDGz95kK4EbWrJ2ViCFOsz2UN9y
    qMpY63wYaDb2oG4VDCV6OLNI54TL5d1nO4apknAA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=BZ1fYALj x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=BZ1fYALj x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfIAQKwuiLUAvcnqZjrjQWBcsmZltVH1ZIMElUuU8JJPxySJp3uTx6jvb32dCb+F5orFRnlUsXIz1OUZqGW9rySrat7szIFVMaeQ7NFFhoU/zTCy8B8TS
    1fgPvNNeZp/00mma/c+0019tKDF///8GJwy0CY78YqUSSPaYOD3yBYdcP6VI86dZ3Os68Ygqivtfdv7Ew83QRHK8XDiSLwSRrOWovGpdgg4Yjf12bx65uiOy
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=IF0-rSWMbCXAOXLn8n0A:9
    a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932171AbeEUVXm (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:23:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754343AbeEUVXi (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:23:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 4.16 029/110] ARM64: dts: marvell: armada-cp110: Add clocks for the xmdio node
Date: Mon, 21 May 2018 23:11:26 +0200
Message-Id: <20180521210506.372096213@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

commit a057344806d035cb9ac991619fa07854e807562d upstream.

The Marvell XSMI controller needs 3 clocks to operate correctly :
 - The MG clock (clk 5)
 - The MG Core clock (clk 6)
 - The GOP clock (clk 18)

 This commit adds them, to avoid system hangs when using these
 interfaces.

[gregory.clement: use the real first commit to fix and add the cc:stable
flag]
Fixes: f66b2aff46ea ("arm64: dts: marvell: add xmdio nodes for 7k/8k")
Cc: <stable@vger.kernel.org>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -143,6 +143,8 @@
 			#size-cells = <0>;
 			compatible = "marvell,xmdio";
 			reg = <0x12a600 0x10>;
+			clocks = <&CP110_LABEL(clk) 1 5>,
+				 <&CP110_LABEL(clk) 1 6>, <&CP110_LABEL(clk) 1 18>;
 			status = "disabled";
 		};
 

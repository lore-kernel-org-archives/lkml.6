Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330799-1519989179-2-16153072644305487287
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519989179; b=C4a2JGXh3YD6PmMShxNL1l8PjxKSCbZ2xJ0EhVUPlLuw6aQ
    Gr4x8JLFBEKdNaZ8JP7rRwi8qO3O02nryT/iU2oyxnH9jEcp7ySHirRXf5VifWGh
    OUCIN4fiPG6io41tfsaqtnPb9BpoQuPuHiX51+XbkVGaBW2ORgIYZVJ6bNP5r7gb
    1ObeBNNkBe+w+9/8hcoeLLZYh4hRCt44HtiOgw5/U0tfEcjMijJmEcAR6K2qBgY/
    EgA9F2vpKZjrCLB+bU1Op7jr0b+hgDCmmYPseFGqcv7bzM+DHv/xx5GgTL9BxZ20
    tElIacfWSc/eHopfFqf5ElcVaWhvx27MULE29Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519989179; bh=3rnxWmk+BM7jCblEQnBXcVBmXP
    +6P2JOZQyiRkcReDg=; b=T89wT6sGEX4ckioe/sjZUVIBu5YhjCeHZe7KS+B1Ny
    fvxYKHab1I2QQJsM4XwzfTkJ2HqDEHY1ziojImZeY6qsAt5bHgYvmlEucVKwURoj
    IiH0EGulJXlrbZWMCUU6Mo8XvUK6UoXd+UiJDccDgM8SdBXtCoSOVupAlA7+l84d
    ejTH+SBveLBVy22b1zf6oi5PkdRhUq8vm/qC2CIDtKz9NWCCiEMQSaoClJimeps0
    ysHfpZ5qNWavQ0Xpxylh7eSQVA3rQNW3rML3yRcUMc4ePBDgh8yp37aytoe/iAOf
    4AE8iS62C5lF7VLxP6HETKgHXiIqyit4JMXjo/qSUKgA==
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
        id S1423082AbeCBIyR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:54:17 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50362 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423465AbeCBIyL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:54:11 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 11/34] ARM: dts: ls1021a: fix incorrect clock references
Date: Fri,  2 Mar 2018 09:51:07 +0100
Message-Id: <20180302084436.683575045@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>


[ Upstream commit 506e8a912661c97b41adc8a286b875d01323ec45 ]

dtc warns about two 'clocks' properties that have an extraneous '1'
at the end:

arch/arm/boot/dts/ls1021a-qds.dtb: Warning (clocks_property): arch/arm/boot/dts/ls1021a-twr.dtb: Warning (clocks_property): Property 'clocks', cell 1 is not a phandle reference in /soc/i2c@2180000/mux@77/i2c@4/sgtl5000@2a
arch/arm/boot/dts/ls1021a-qds.dtb: Warning (clocks_property): Missing property '#clock-cells' in node /soc/interrupt-controller@1400000 or bad phandle (referred from /soc/i2c@2180000/mux@77/i2c@4/sgtl5000@2a:clocks[1])
Property 'clocks', cell 1 is not a phandle reference in /soc/i2c@2190000/sgtl5000@a
arch/arm/boot/dts/ls1021a-twr.dtb: Warning (clocks_property): Missing property '#clock-cells' in node /soc/interrupt-controller@1400000 or bad phandle (referred from /soc/i2c@2190000/sgtl5000@a:clocks[1])

The clocks that get referenced here are fixed-rate, so they do not
take any argument, and dtc interprets the next cell as a phandle, which
is invalid.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/ls1021a-qds.dts |    2 +-
 arch/arm/boot/dts/ls1021a-twr.dts |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -215,7 +215,7 @@
 				reg = <0x2a>;
 				VDDA-supply = <&reg_3p3v>;
 				VDDIO-supply = <&reg_3p3v>;
-				clocks = <&sys_mclk 1>;
+				clocks = <&sys_mclk>;
 			};
 		};
 	};
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -167,7 +167,7 @@
 		reg = <0x0a>;
 		VDDA-supply = <&reg_3p3v>;
 		VDDIO-supply = <&reg_3p3v>;
-		clocks = <&sys_mclk 1>;
+		clocks = <&sys_mclk>;
 	};
 };
 

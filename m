Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3190956-1523476381-2-5896888366207283542
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
    1523476381; b=TKOgAg72PUVWqgdxCVO6HWdBvwEWA0+vwHNXSIU7m+wu+FORRI
    f/hPq9FP38+aknoNKrr4hwV00YsXfXv5uuoNj5N3TcaY0KPeZ42GLlURMhdRCMW0
    hGJTdy//Nwb658Dg9QWTCbGDzDrQy6S9OJFDYpF+btrc6INzsQM4+R6Y8Pua5Fkf
    YcvON6Ozk9V9bACkjkZHSDdVgQGKNGXdxl4joqnSshIAVsWtQEZlPiiREAWObfch
    KXm669lKxwOg6JyXqvv7dD8WljUFJLhU5y9cWqnaF+h/9clcehTol+KO04i1762M
    Q7a8fnZ5JcjqSQlsRjrppDvJki5ZdU3C1rvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523476381; bh=bu0+Uo96ArHQMY0SsZwhKfvplbthPG
    n6qqaTe1NUyaw=; b=hnELcn/OP+Jek6HQS0aHPKfgO+J9TqLKYsNXylCMmXkwn1
    NcomUKeFL/OAr3nNIXpifUvPHmowzvcaEBuwI9Vl828O+gMdhU9b2HgO794eP3cR
    tUGj0DI/T+T/BUr5dr6gf48UZVoJogkaeacds4UFil+nem/UIvmqAvnzqzSkXgFv
    a6SO3dDftWT9KNEZ50Dv2XZvN0x/ddnkksNZaLqAqcbIwmjK5a9+o2uAXt04/gY6
    d67d96AhmR8BK/iW99FXUo1xUoOBHJkftnosq4Nhyb94PI2kuTTQIjX0eNszR0pd
    +87Bsczn4Ou0HVRylAv15NIGlAPNe4fnsMVe+Wfw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfF2eEIS1riHBlJ8XnSdzESD5mr83lAEs0nh281o/iOJkTi1jYZ2+lxNPnaF4wGwc2Ze68dq1GHOk3QMrAnEbXOjdZTZT2zntBR6cL0HgDlYx6Xwg7v27
    XziuiX8TCBDkgBBmbm44hJFaptwgJ8sr3e08UsnTckJE2P9rcvC3IthB72Bc0ztpKcrFLLwk3uKWM8D4D7ITwDY8aMIWv61kxn7X0moXizahZKZB1szfXEq2
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=WBZvL9eSjnWsstDp_dIA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756319AbeDKTw6 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:52:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36488 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756465AbeDKS56 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:57:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 121/310] ARM: dts: ls1021a: add "fsl,ls1021a-esdhc" compatible string to esdhc node
Date: Wed, 11 Apr 2018 20:34:20 +0200
Message-Id: <20180411183627.360763293@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>


[ Upstream commit d5c7b4d5ac2237a6da7ced3adfe6b8bf769f8cc6 ]

Commit a22950c888e3 (mmc: sdhci-of-esdhc: add quirk
SDHCI_QUIRK_BROKEN_TIMEOUT_VAL for ls1021a) added logic to the driver to
enable the broken timeout val quirk for ls1021a, but did not add the
corresponding compatible string to the device tree, so it didn't really
have any effect. Fix that.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/ls1021a.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -146,7 +146,7 @@
 		};
 
 		esdhc: esdhc@1560000 {
-			compatible = "fsl,esdhc";
+			compatible = "fsl,ls1021a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x1560000 0x0 0x10000>;
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <0>;

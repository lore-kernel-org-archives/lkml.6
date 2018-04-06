Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523022230-2-16470518020299484582
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523022229; b=LIOJVWUympSMNHb2ZeZtvGEEDMqK0RSSnAU5m23nBNdIyFwDXG
    aI0AflS7oXyvyquFxnn1xA7MK4yJ4JRumsLI604/UywCXegNfDlM1Xx2duC39tUx
    llVpeNCReEonUtDma65gGB/G16qIPP4PdLlprbhyZEBBOVEr40WT+MKJW7k6ktVK
    dA2CoFHC18CMF7YM2qGD83q9/WEKWLvmef1Czs+YD+Df85LEOVUAiJ3EEgFK+wn7
    B7htQyzcWtyQpsY/qnk3oauqWk7WfBj/DYBCmIPlfNFg4zCIZvf4ZKEzT8Dq7PIQ
    F5KvjY1p3Ce7TrPT8bQw22JPdAPRferux/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523022229; bh=LdmHLnCk/grNjfqlNbXwcpQPAviXom
    xvSeUAD5yN7iI=; b=lGC9hZej3ErhMW1C1zFIMOpIRYuWyw2qCJBHS6ubeh+zlO
    vZ7UdOMnRaTzQ7yv73iQXA1hneectoPOxcmYAWtRTgKoKE4p0geiF9Jw6H/juLcS
    Plmxq90VTtDYoAEaewcqH6KoPc7Kx7DbiOLKkJcNF6nS5f0XrgJKgSGGPG7Fq/MX
    AvVv9Axh/2ddrNaPV02xQgf3T0p3rAFVPvFY9+MdKKvbrHwv4ViU9Gx2sNP7YDU1
    uF1m35JzYDh9yRwywuwQjfL8eIxhVxLi14OMWcg32GUPLEe66NxAMgpZuJfM4t+F
    pZD3UesAGXS7CqpYnhXf4MZqlmuGQOaXjqpp/1lw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfNiA2xWaMvzQnsqy8g/e+J/9wTpw/+/aRONyEYiOphM7OqkeP+3S5in7NTCf7mujK8y31rBtNdbLJ8xu/FdGnRJrZaixG+Zgi8S7L5GQLsHz7W5QMhYv
    iOMQ3h/fB6Tkym9ts/JyYZGlWZ/rlyjdOAbFyYZbcWbFtBBxr65dXJm107KjlY99ztstF/Sx/Y3gwqwlM23HGr9AJUWf9W+x8dM/XifaGnFEJTUgWgET7EkD
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=1EsaE_6oAAAA:8 a=sozttTNsAAAA:8 a=2KMo9-giAAAA:8
    a=yMhMjlubAAAA:8 a=1QTaXj7xj-_7a8urSFoA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=3ZumFrijQQ-2J9H5h8ct:22 a=aeg5Gbbo78KNqacMgKqU:22
    a=UeCTMeHK7YUBiLmz_SX7:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752461AbeDFNnq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:43:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37430 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756807AbeDFNnp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:43:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        "Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 70/72] Revert "ARM: dts: omap3-n900: Fix the audio CODECs reset pin"
Date: Fri,  6 Apr 2018 15:24:45 +0200
Message-Id: <20180406084354.071508073@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit c91a501768717f449acd1c2cff1a8531e486c441 which was
commit 7be4b5dc7ffa9499ac6ef33a5ffa9ff43f9b7057 upstream.

It requires a driver that was not merged until 4.16, so remove it from
this stable tree as it is pointless.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/omap3-n900.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -558,7 +558,7 @@
 	tlv320aic3x: tlv320aic3x@18 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x18>;
-		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
+		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
 		ai3x-gpio-func = <
 			0 /* AIC3X_GPIO1_FUNC_DISABLED */
 			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
@@ -575,7 +575,7 @@
 	tlv320aic3x_aux: tlv320aic3x@19 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x19>;
-		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
+		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
 
 		AVDD-supply = <&vmmc2>;
 		DRVDD-supply = <&vmmc2>;

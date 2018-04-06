Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1404550-1523021534-2-18382436893058497981
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
    1523021534; b=v+o2nf0LgKJZt1Jpf9Bj8yPBBQldugy7t3GKUA+cWNu20YgK7b
    qUNK3U3OPqCvLRUVuTfbeb1rFlrj+5xQVy+ooRZc2gtWo5Suwq1Ud9esKQjTcgh5
    /MnUI/lexwURk0O/BmAcd6x4tLhNgQecN7XzKequBbhpy0Jc/vslHueexEowkbq9
    RaHYw2TNiGcut6znyUGUGGMheLHu9e5VVSJs44JC0SheThLP6zgt7ITYQ3pI883T
    upgjw5tg+4QqCzK7ItT8wnYgAKfddhDup/FixNtX53m/r/zQker43nZ8zH+eB1JX
    MrKU0do1oGl1/t2xbX9VwDYxVvfVT0BEeCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021534; bh=+rKH+Y6iuG5pATZwUi8FoNXsTr9LNO
    yNTENesaUchpo=; b=XnAqyepN2nakJEENcrjF4asxGl4YUoIMt7TFHusvNhFpc+
    CarQXeDWNu0s3ba+shEYQs6wkKvyJIvU/83yGGET8sjoisD6vaDuCP/qE4IEto0r
    dTLu/JICd29CiY86HDUZ4BnQikHqKvdyyHOqFOIZx7Buik2R0LLzlMVjnvDnxVNw
    lq64r/u0edR7qENj5XPLQOKl1Y42E1kq6hDpZvKxwtoDHe2ItZLJQ73+nh++jwvN
    LlRTv7l15j3vBuyI2sePCAoyogtJg6mRmNe1eQFiaYNHYOm7Kr8N6q4O6yZxzD3B
    vqA/Rqn7yjxB6eRtuar5pQrDx24Bthj+qU5rI2gA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfC2wEItjlihGHtJ/RC7bfDSVqG752mpA16/TXBUirEkC9eXne6dqb4qV726dzNQh4PBKDSeVYq7TEvqIV9oBghtAcaak0dBRUd+urJgWQMiQhf6s0ZOG
    GGc5gAlgcUQEUZhSTPLNYUQm8OQG3bNUmFo6BSo/rlYTmf4F1RqZzC4lbWTwGt8NGOdYJZG0RjieoaOBYW37dD4FXk4qbGT/ZFko500k/GMtZHdbKwMvHiQI
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=1EsaE_6oAAAA:8 a=sozttTNsAAAA:8 a=2KMo9-giAAAA:8
    a=yMhMjlubAAAA:8 a=1QTaXj7xj-_7a8urSFoA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=3ZumFrijQQ-2J9H5h8ct:22 a=aeg5Gbbo78KNqacMgKqU:22
    a=UeCTMeHK7YUBiLmz_SX7:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755291AbeDFNcK (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:32:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57402 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754788AbeDFNcH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:32:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        "Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 67/72] Revert "ARM: dts: omap3-n900: Fix the audio CODECs reset pin"
Date: Fri,  6 Apr 2018 15:24:08 +0200
Message-Id: <20180406084311.184235673@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit ffa0a8252863189f0bc92d46c34588df3699f8f8 which was
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
@@ -488,7 +488,7 @@
 	tlv320aic3x: tlv320aic3x@18 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x18>;
-		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
+		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
 		ai3x-gpio-func = <
 			0 /* AIC3X_GPIO1_FUNC_DISABLED */
 			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
@@ -505,7 +505,7 @@
 	tlv320aic3x_aux: tlv320aic3x@19 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x19>;
-		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
+		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
 
 		AVDD-supply = <&vmmc2>;
 		DRVDD-supply = <&vmmc2>;

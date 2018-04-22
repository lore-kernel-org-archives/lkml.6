Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406289-2-13815083780139472357
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406288; b=IwEDBMTCjWjkn2dYBVh087rMIOyY/t0q64mecYgl2NpiXFEKIq
    1dh48CsDzQwfzkdoa7jymytl/IZSFxh4oOdgA2x6eCemb0xoyYHEg2ugwx4IvJCN
    LoOgMmXquuHIpTQsrwjKWzUcv3YNBmEHE46O8Zk234L91la8lVEmCBglCSM18zbU
    Jnsl7giHhS237os/O27rYNuWBOtribnAxfYXDY2wn6TlZ25IrxW3BlqlxWRbSGap
    59ZLXqtYGhTWnQ5970dYOcwKXLeH6KZpQOc6864szPZ0t1yT50Pm+8hg0XKNvwrD
    ob6CBpcIScZ9y0A1/J4ANzpSrYQmmcEy1+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406288; bh=+j1RL9kkn0Zlki4oYxLvLx7obU0OAu
    6dq0+IpLON5Sg=; b=afDn3zV2BFcJfPaBv+wM/i2Sijr6wrtmZUespUlYgouzne
    R46FczUpRSl6BSOoSghMdzwMjjs859KDV7xfteLqOEL6gTs+r8zUJL0ekrbrLpIR
    iA0GiV98rX4KPsdht8qKLLfEgG6YUAPQdsAL4Sj/2JohcsjCMVVH/3mZkvrqeVCX
    oMqsFPArvFbu6PT+vSVLR7mAab7UUWSGdgnj1dzn4DQ9uBypgBJFw2GBgLy+XIG3
    MZTJV2EQyOYmqc1xbdIa55C0NHpzbnMKy3//SQ8AcBby2N8fhUvytxS6eFB5O8NM
    Zr5MR9HFIn34a+m3QxYTYhWFTsGmw1jcR028QHVA==
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
X-CM-Envelope: MS4wfFJA5rSqNQmZlUBDOTg/zRiUbVkUxVHMJDVXoEfQ6cK9c18KQhf6/aguqu3AgJh291DeNFM4Cz3QUtKdpP/G2kedEe7Bjz0nFOJU493pR6Vo15wNIh2Z
    lmXXmtkt4HXRd+g5rKN7J/9VZ/zw8AE9rC9kZqEa+asIrYnyKiYyMssSf08tgxIYnoCI/lUYbXJjxKM/hLStWmM4QstMeVby5xWpZq4kD7HlocVcvXRakKsh
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=ag1SF4gXAAAA:8
    a=G3l66WGjWsogww2oMR0A:9 a=QEXdDO2ut3YA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
    a=AjGcO6oz07-iQ99wixmX:22 a=d3PnA9EDa4IxuAV0gXij:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755522AbeDVOLY (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:11:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54296 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756466AbeDVOLV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:11:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Santiago Esteban <Santiago.Esteban@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.9 14/95] ARM: dts: at91: sama5d4: fix pinctrl compatible string
Date: Sun, 22 Apr 2018 15:52:43 +0200
Message-Id: <20180422135211.014154254@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
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

From: Santiago Esteban <Santiago.Esteban@microchip.com>

commit 9a06757dcc8509c162ac00488c8c82fc98e04227 upstream.

The compatible string is incorrect. Add atmel,sama5d3-pinctrl since
it's the appropriate compatible string. Remove the
atmel,at91rm9200-pinctrl compatible string, this fallback is
useless, there are too many changes.

Signed-off-by: Santiago Esteban <Santiago.Esteban@microchip.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: stable@vger.kernel.org #v3.18
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/sama5d4.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1362,7 +1362,7 @@
 			pinctrl@fc06a000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "atmel,at91sam9x5-pinctrl", "atmel,at91rm9200-pinctrl", "simple-bus";
+				compatible = "atmel,sama5d3-pinctrl", "atmel,at91sam9x5-pinctrl", "simple-bus";
 				ranges = <0xfc068000 0xfc068000 0x100
 					  0xfc06a000 0xfc06a000 0x4000>;
 				/* WARNING: revisit as pin spec has changed */

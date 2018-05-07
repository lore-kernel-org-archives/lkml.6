Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1216624-1525706666-2-7822951174889307117
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='io',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525706665; b=IbciIVM2pLokwTv8FhS1/dR5h2YJZdodLjIgeYNeApAkWPbLYx
    2wSXMjN1ldxlvluV51+yUjYl7Ep8IrP55I+liDpHpSZU9MQ+JGpwp/q2Fngj4OnA
    qpwdJfEcSC6AGtU+zvTlZWQNY25wLQxR0cxv42QZEJvIuTCesXgwRe7WoCiakQgQ
    msspDNpUgtAz/pbHvGM8PPceqsrBwonqM6M+mpiWlSZeZtxag4gMJQ+gNAGxxHFG
    Gbe3LFyzcrxptGgKsWKKrHXNLn7yqwZc9OMcLFR1gQwKfrdRZZVcz/zmeD/JlOAC
    eQ7uNN2LQ8IurbP7UUPxsmG0lj2MTo1WWfrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525706665; bh=
    WnIrPkXY8pwiNTSITcvcB7PRj+jnpoxzw4v35Ki5poU=; b=kIz6GmM0e3M30Oj5
    RceYRuw8UlD3btYfYWuGeKIWgK+3HGMcv1hIuVqB+I4Hfcx3rjgaTclzT7f8EX7Y
    P6awrrZBk7fkKyBvc+bdP59Mi4/em1PksUXAFaQ3dKtMOxqpM8ZRu5hak9z4ucVY
    F1deqcqC+hXjZoSpnbz+wOCcrVVMQkbBPnwpw+aDJYW6CCBfNy3URtlL+MDvu0GY
    nykJJtwa1h5CkA69SohYM27rYIR6Kag+Xr3f4DcTKlB/h+aG/gJ2j/0HvJ3NJUHs
    C5h4hREcqYqBrYR+S+kO5Wvk2iB6h3mz8MxELDXf44K9TOg47BO+uoyq66VCdkvc
    XB1c1w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=aosc.io;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=aosc.io header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=aosc.io;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=aosc.io header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDg2FF6LgkzxeQ4kmeIzuNrzGnHNS2/2/XVtfX6tYu/Fzocxhl0VlC9F8GSG5sC8R1xe8lcq5SarhTm04YAZtR7O59Jxh+p1Zsaxh87jv2tKyhzfggMh
    JzF3UxvgZHhG1J2BpimrteEUMdsuirVn7b6aHWSkXzjBCNYiy7zIfnhi1FWOMfLj+GhU8Z6kNvZkq5YciBOy5aTsna3Nv5tTgchyYDRqRBzIfnxmHTMC6kmf
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=CNVg8Iy4Hc8mcmBTk-wA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752471AbeEGPYV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 11:24:21 -0400
Received: from hermes.aosc.io ([199.195.250.187]:48516 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751912AbeEGPYT (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 7 May 2018 11:24:19 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Felipe Balbi <balbi@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 3/5] usb: dwc3: of-simple: Add compatible for Allwinner H6 platform
Date: Mon,  7 May 2018 23:18:15 +0800
Message-Id: <20180507151817.55663-4-icenowy@aosc.io>
In-Reply-To: <20180507151817.55663-1-icenowy@aosc.io>
References: <20180507151817.55663-1-icenowy@aosc.io>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add compatible string to use this generic glue layer to support
Allwinner H6 platform's dwc3 controller.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index cb2ee96fd3e8..a92a8e4c6b92 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -215,6 +215,7 @@ static const struct of_device_id of_dwc3_simple_match[] = {
 	{ .compatible = "sprd,sc9860-dwc3" },
 	{ .compatible = "amlogic,meson-axg-dwc3" },
 	{ .compatible = "amlogic,meson-gxl-dwc3" },
+	{ .compatible = "allwinner,sun50i-h6-dwc3" },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_dwc3_simple_match);
-- 
2.17.0


Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477513-2-2571184638578846226
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
    1523477512; b=q/DavO42c0dhaz5RO/lg9K2qbvcmMNA2tcV16qBYx1xVO0dFte
    fV2CMH1k+9fK4X4i2LkWpHts58YvLohA1Q0sH4G0iC8zkalkzDatAmVtBnWhL5ad
    Acs9rY2ThR4AdBp5cKLUIghqKGXkvkNliblMyxVAjpwUj4MritzQKmyXIDHf9Ssn
    4hHWdQOAGVlCzg+TKYP95JNf8gS7FGJZy5x+h5SkrKBCrdKUr/jWxRyRu27jCzeZ
    l5TpEb/TBqQqV0s/8tZ8nJRL2vo28JeOtS2QSdq04ZqAZ98KFoiZnBKK0F5kmIiN
    cDlZzfV5r8D47K8qa2Bi6A7wf2jJhPFCfNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477512; bh=moiVUP2sKkqEYlsvfRO/RT0UPxouIa
    O5MRlc4Vt6H9A=; b=f8aoSzFcKV7qpIm49b8v0Rh1WLS56NPmtqRhDO0bKD2Pa7
    N06SOsegziLJLr6/lKo3VUigg+ua9SS0/7LWNMVDGRGSDmgPAmZTzD7edy7Wqf+X
    hs35u6Vs8i8ERLz/y6R+IwuLwnSjZ1Hih8CP0X2q1NZ67xoLIoLoiOFzXJ4aR/1J
    AaBWGnDR4W6+g63fcHLkznKanVZqzMK3rynPWZpmB0suUGGhdb3Y5mR8h2ImEYFN
    dY3oP+YpUFK2z9xUOR0iwtp/JWRZLaOGhtdOWuXJVg11nwm+CTyZFvtXisrGfEHl
    HbuzBTXVVyw/I5wH6ZTwZC+ywqc6R6YcFot44HIQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfPIo8VXEy0nWQ6urc0UaOjA/ETtmQxxqyXdkKPxXztNGvjQbt2svRQcpdnwBs+WfHJCAwPENjFnFMu+dzPKNVS7VrY1V1HnW0jkMjZujODQ+JB4SGexq
    mXZ/vxkVcfhtYRIJ9h1F+9W9FzTfTb8+0RQJ79dY/eWPm0RFUwHfUf/0TOtZ76uqi3JRqxBvBiofqq7I6NqZSdat1Zfr9IExuaMzMptthzZ4nR4QTQiyAfeI
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=LkhwIsrRiEQ4CS9YBrUA:9 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754795AbeDKULe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:11:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34456 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933460AbeDKSyW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:54:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 044/310] ARM: dts: imx53-qsrb: Pulldown PMIC IRQ pin
Date: Wed, 11 Apr 2018 20:33:03 +0200
Message-Id: <20180411183624.157370043@linuxfoundation.org>
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

From: Fabio Estevam <fabio.estevam@nxp.com>


[ Upstream commit 2fe4bff3516924a37e083e3211364abe59db1161 ]

Currently the following errors are seen:

[   14.015056] mc13xxx 0-0008: Failed to read IRQ status: -6
[   27.321093] mc13xxx 0-0008: Failed to read IRQ status: -6
[   27.411681] mc13xxx 0-0008: Failed to read IRQ status: -6
[   27.456281] mc13xxx 0-0008: Failed to read IRQ status: -6
[   30.527106] mc13xxx 0-0008: Failed to read IRQ status: -6
[   36.596900] mc13xxx 0-0008: Failed to read IRQ status: -6

Also when reading the interrupts via 'cat /proc/interrupts' the
PMIC GPIO interrupt counter does not stop increasing.

The reason for the storm of interrupts is that the PUS field of
register IOMUXC_SW_PAD_CTL_PAD_CSI0_DAT5 is currently configured as:
10 : 100k pullup

and the PMIC interrupt is being registered as IRQ_TYPE_LEVEL_HIGH type,
which is the correct type as per the MC34708 datasheet.

Use the default power on value for the IOMUX, which sets PUS field as:
00: 360k pull down

This prevents the spurious PMIC interrupts from happening.

Commit e1ffceb078c6 ("ARM: imx53: qsrb: fix PMIC interrupt level")
correctly described the irq type as IRQ_TYPE_LEVEL_HIGH, but
missed to update the IOMUX of the PMIC GPIO as pull down.

Fixes: e1ffceb078c6 ("ARM: imx53: qsrb: fix PMIC interrupt level")
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/imx53-qsrb.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/imx53-qsrb.dts
+++ b/arch/arm/boot/dts/imx53-qsrb.dts
@@ -23,7 +23,7 @@
 	imx53-qsrb {
 		pinctrl_pmic: pmicgrp {
 			fsl,pins = <
-				MX53_PAD_CSI0_DAT5__GPIO5_23	0x1e4 /* IRQ */
+				MX53_PAD_CSI0_DAT5__GPIO5_23	0x1c4 /* IRQ */
 			>;
 		};
 	};

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-23226-1522169078-2-1313921018238587348
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
    t=1522169077; b=u2y0bn8BMsKpVq7dsIanRxZCflbkSqS6HTpbKrTuggUKAhx
    wJ1tJ5orEHZm4vq0Z6oXWIwyj3wSoBRFpWq5rlL3sUZBeKTnwvXAWDj/lTQ1aNFK
    mAvH7dZ7IQfww1MV8fMmHu2T6iOcESZrUsIlj7QbDmec+KAD3ESeKPf/74oTGr2w
    dvmVP0uFObpvLfOFcdamXMrfQd178mQSIcLMzCXfVO7WFz6Ao7jF6iAcs9/VtK+I
    wItDvqgRME4YM8frpsKKPI2h5rIOBoEuEJmO8PQQADZBW3yoqi6slqPULk/0ZZ0P
    eRwttNlfNFLVJfbqluQFFdgrzQ2ppnUg0IretUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522169077; bh=5YL5NPZG5jK8ejElntm4yZW2Yp
    imnax/dfJuu4Nj0ro=; b=f7T1lUbs4/T+IqJxGmnMce8X69xGFQaGMVhbPpy3eL
    AkjY2q3QPVF3tWUHQmwtk5SVRcpJIiupUt0M3/3MQ1hZRN6hE9K6w6X4USb7BvbM
    5J/cy9UIweNLxnF1NRhAQEO+LcXFyw8WrDz/udTfLsgmi3t+OZv5DppLwQ3UkWoz
    j0i/Wsl2EX2/ypdFD20CQalddW05UbKPGf513AqBHaWXs+AnOqo2sce74nQkXpyP
    6ihlStVFpXQWOQfXiehSnZu4OW1rOr6mB1Y82281xxVEgYyKC4T7pwiHwob0l4CB
    vbtdemQqJr+U/DFhFVckgMXbnLl1IwVry9agam9INb3w==
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
X-CM-Envelope: MS4wfB2IOrXEt5zBcHeEck0bcNAB+hvQek/bANatfKeFlYOjEBYNMHI8F+l4voeaE+JxnIxlxUMlNWcbb9tFWQx9NC2cpw2YNrXyTbfgJDTCev8hGzE0xlk8
    841Xtm/4USqyjZ84uXeLIwWtuG/N3uqBo/LfB0sxTX/hWSN0TVz+k1N24DF2MoyvIeU3NJRodxM0MO4JklYWfbMU9rQxGM3z/EGy0eUyuFT929ezZ0M+JeM2
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=8S9q_luQAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=IgS8zTJaMza7Z8jP0TkA:9
    a=QEXdDO2ut3YA:10 a=cvfBolwEH3e1gB6IFv0f:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbeC0Qnc (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:43:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49544 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeC0Qn3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:43:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Heiko Schocher <hs@denx.de>, Markus Marb <markus@marb.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.15 078/105] can: ifi: Check core revision upon probe
Date: Tue, 27 Mar 2018 18:27:58 +0200
Message-Id: <20180327162802.708932607@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
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

From: Marek Vasut <marex@denx.de>

commit 591d65d5b15496af8d05e252bc1da611c66c0b79 upstream.

Older versions of the core are not compatible with the driver due
to various intrusive fixes of the core. Read out the VER register,
check the core revision bitfield and verify if the core in use is
new enough (rev 2.1 or newer) to work correctly with this driver.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Heiko Schocher <hs@denx.de>
Cc: Markus Marb <markus@marb.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/ifi_canfd/ifi_canfd.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -144,6 +144,8 @@
 #define IFI_CANFD_SYSCLOCK			0x50
 
 #define IFI_CANFD_VER				0x54
+#define IFI_CANFD_VER_REV_MASK			0xff
+#define IFI_CANFD_VER_REV_MIN_SUPPORTED		0x15
 
 #define IFI_CANFD_IP_ID				0x58
 #define IFI_CANFD_IP_ID_VALUE			0xD073CAFD
@@ -943,7 +945,7 @@ static int ifi_canfd_plat_probe(struct p
 	struct resource *res;
 	void __iomem *addr;
 	int irq, ret;
-	u32 id;
+	u32 id, rev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	addr = devm_ioremap_resource(dev, res);
@@ -957,6 +959,13 @@ static int ifi_canfd_plat_probe(struct p
 		return -EINVAL;
 	}
 
+	rev = readl(addr + IFI_CANFD_VER) & IFI_CANFD_VER_REV_MASK;
+	if (rev < IFI_CANFD_VER_REV_MIN_SUPPORTED) {
+		dev_err(dev, "This block is too old (rev %i), minimum supported is rev %i\n",
+			rev, IFI_CANFD_VER_REV_MIN_SUPPORTED);
+		return -EINVAL;
+	}
+
 	ndev = alloc_candev(sizeof(*priv), 1);
 	if (!ndev)
 		return -ENOMEM;

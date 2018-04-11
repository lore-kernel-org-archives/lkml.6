Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3397032-1523481854-2-8440465674894474899
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
    1523481854; b=vieQ75VtDnUebanSCufhgChQEPbsy7Lt1vX4sJiegQxXSKNvR7
    pdtz/GjAgbufUl5WPtxnUzoeoD4l+dpFop/7KGwT03dZI2UnvldW+3LYXlo1X/V2
    B850J4oDLEsATadDsNxzpiXJ6Tye4uZMJvHd9bcl2RHylZOlz9j7DKuLcVub1s7e
    9XX8xUDgUcVNtN6gnRiugjkfCbs/eSDvUrzmGqJjwTcoJARRHYrxT+uyRQ8lPnB1
    sZOw81xQJlCeeBX/WGN+f2X43K2Md35BE8d0ZlIxW8mU6LhLSE08v8e0s7GKZgY0
    WAs/OnD2h79NEXLaGF3JRClHHT8hOQqt2Cjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481854; bh=1tw+PmdWoAigzJuQLkgs6a/RG0XK75
    8tmV4SBEndmt4=; b=XV8WJGhc6NFWPceohf3RWfFGTLQS3kn8EXUIvUM57ffs6O
    DSXPV6FocHLrps2VNcQmbXx4Tk8bR5WelBIEE8jhu+HilkOCi/dpKVABWCAGxDrz
    P9UqHhgN8zeXBf7Md0xstRR6VDDE2ianLMYFTw+WU/qWN8IFF6rVrQE75sIe6LdP
    Alo5GYgAgcmNm1qz8Ue/BiiB3E6gwZjhdXUJHBYAeMSEDwX3h5nFK6sZ42IxCmd1
    Ne4Yd3pneZwv608UfnUf69mXBzBcORyH9hfL1GDlGn8e0+4fwdWVblK7J3HclkR4
    iP8UFoz1oRrjIc18awdkBGnKcLBK+MJrPBHsiM5Q==
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
X-CM-Envelope: MS4wfMqJQVF/hLqi8JXmPFdeHmH+XlC1NJkERfH7mYSLODpsWZwCMWz/wnjeRrf43Y1/g33sft1zMa7R/9oYkd0Ix/fZu4FlXzG0JlLo08AA7K9u0iLNKfmn
    UKhX5ADe9sNV9kC02JPejnZuCHCqfsx3jhHyBldi6yk0J6JqpA4EakJl9VqJnHnMy52lgCWHLzoo2EewpP6swIzGLA55meTP/ztvLhm7AjabzaG8XSpJCfDW
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=uP1ucDPQAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=lgeqxb1-TE-wKjQGDkEA:9 a=QEXdDO2ut3YA:10
    a=9a9ggB8z3XFZH39hjkD6:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754490AbeDKVX6 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 17:23:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55486 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754182AbeDKSio (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:38:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 026/121] ata: libahci: properly propagate return value of platform_get_irq()
Date: Wed, 11 Apr 2018 20:35:29 +0200
Message-Id: <20180411183457.698449369@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>


[ Upstream commit c034640a32f8456018d9c8c83799ead683046b95 ]

When platform_get_irq() fails, it returns an error code, which
libahci_platform and replaces it by -EINVAL. This commit fixes that by
propagating the error code. It fixes the situation where
platform_get_irq() returns -EPROBE_DEFER because the interrupt
controller is not available yet, and generally looks like the right
thing to do.

We pay attention to not show the "no irq" message when we are in an
EPROBE_DEFER situation, because the driver probing will be retried
later on, once the interrupt controller becomes available to provide
the interrupt.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libahci_platform.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -419,8 +419,9 @@ int ahci_platform_init_host(struct platf
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(dev, "no irq\n");
-		return -EINVAL;
+		if (irq != -EPROBE_DEFER)
+			dev_err(dev, "no irq\n");
+		return irq;
 	}
 
 	/* prepare host */

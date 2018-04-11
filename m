Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477148-3-10691485680579033227
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
    1523477148; b=nXgmeoIb8V9pX6OjqJj+tlR0Y5+/P+HWOui9ZZwKJds/oPwaix
    rKgiDi9rmCZQ2/9Rej2LoDzgbBS646jd6FBQwqu+9PehThHGB2EP7SrNlL1lE3g3
    7o/uICWD3Y++7ZFypDKoDDv1yWgvF6QnYSZhiC1NIOOC+wXqvQ9AMKp5C3SZKKcM
    VRo/1XYaZhagpvGcQtYwdCrBp8/75PT3m5Si8QjgVxvu5K9x8v5z/14FI0xNodsO
    QZhnoTZ/qNQDXont0MKe8Wbr/8C812OtB8oVKLcX1RfbVasP9N3Cvq9kIUXqp7cD
    f05p21FGPoqufieTQxVjdjiIZIQN7YL+I17w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477148; bh=svchRXMm1gmi50J7g648eRD6f2w6bl
    bOi5aYPvH1uB0=; b=QooylTtZqlFL/O/EkBFfyGNZ1PUmdCwWrsgfZD+vaSxlhW
    IWQm58lhF5TaS507+WcSnqaKpRGsXsQpJ6eDkALngPKZzkMHNxfoQbLIbx/2Wxiu
    aUPCYTvpEa5pMEnLwKsVJI1kjJpyiUji+rYm1wtwiVmeeMosPxnyguYJLUeZxqkZ
    6YSvIYEmlyah/CWmDPNDjnekOeIu1yQ4j85xB32vCJ42tKQEpfDk4eOkFyFgLb1t
    Ed5sNzcBzHiXVwOvz0tfeK1MENa013OEEPaKM0if36YwI9O7eUPWAP2z4//NQDMC
    XE5/LZxCZmBvLdfh4ejqy07jkreO7dxC1COv+DwQ==
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
X-CM-Envelope: MS4wfNkZGwMRL4fMKyb/xmDuhnNudOucLY+9XsAxQ3gnDzAbK4D82nqvfbdEOhotRB6QLjNuxOJsft5+F+YfYnZWWl6PMOHijCmlzdeko6qZqO6qUdfJ71id
    IA7xu4/ft03N1TrXqoZ39b38cYa4ldVXOlHqAok/unVlVrW2crQLcI/LDO6vHHvzuD0pv7Vy/BtnoatIqOMnDDa+7+AkBb0F9gJHjAlYa2MThlKtn3sQA43C
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=i0EeH86SAAAA:8 a=KKAkSRfTAAAA:8 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=y2BmO4VDSVHQWuCiJ2sA:9
    a=hMakGYo-eCAK3RdJ:21 a=S9mhtIvQuhSIVXTS:21 a=QEXdDO2ut3YA:10
    a=cvBusfyB2V15izCimMoJ:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932962AbeDKSze (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:55:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35470 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933731AbeDKSzc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:55:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, MaJun <majun258@huawei.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linuxarm@huawei.com,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 036/310] irqchip/mbigen: Fix the clear register offset calculation
Date: Wed, 11 Apr 2018 20:32:55 +0200
Message-Id: <20180411183623.829713131@linuxfoundation.org>
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

From: MaJun <majun258@huawei.com>


[ Upstream commit 9459a04b6a5a09967eec94a1b66f0a74312819d9 ]

The register array offset for clearing an interrupt is calculated by:

    offset = (hwirq - RESERVED_IRQ_PER_MBIGEN_CHIP) / 32;

This is wrong because the clear register array includes the reserved
interrupts. So the clear operation ends up in the wrong register.

This went unnoticed so far, because the hardware clears the real bit
through a timeout mechanism when the hardware is configured in debug
mode. That debug mode was enabled on early generations of the hardware, so
the problem was papered over.

On newer hardware with updated firmware the debug mode was disabled, so the
bits did not get cleared which causes the system to malfunction.

Remove the subtraction of RESERVED_IRQ_PER_MBIGEN_CHIP, so the correct
register is accessed.

[ tglx: Rewrote changelog ]

Fixes: a6c2f87b8820 ("irqchip/mbigen: Implement the mbigen irq chip operation functions")
Signed-off-by: MaJun <majun258@huawei.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linuxarm@huawei.com
Cc: Wei Yongjun <weiyongjun1@huawei.com>
Link: http://lkml.kernel.org/r/1494561328-39514-4-git-send-email-guohanjun@huawei.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-mbigen.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -105,10 +105,7 @@ static inline void get_mbigen_type_reg(i
 static inline void get_mbigen_clear_reg(irq_hw_number_t hwirq,
 					u32 *mask, u32 *addr)
 {
-	unsigned int ofst;
-
-	hwirq -= RESERVED_IRQ_PER_MBIGEN_CHIP;
-	ofst = hwirq / 32 * 4;
+	unsigned int ofst = (hwirq / 32) * 4;
 
 	*mask = 1 << (hwirq % 32);
 	*addr = ofst + REG_MBIGEN_CLEAR_OFFSET;

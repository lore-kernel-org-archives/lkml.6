Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-540135-1526897614-2-8670555788261140375
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, RCVD_IN_SORBS_WEB 1.5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526897614; b=bp/MULLdF9clon0L0xJcirJy3iR/g6yPzyEvnjwOs4M1IqV/Rf
    xbokZXLJquUjTbS4BZUg4oN3YHY+CYOnGrPx5dA0z3R2H7gSeQX/KzXK+cLr0mzU
    LfxvcomxA5wHuhHL7V7tc2WQylKNExTZcDfGjc68gNId4Sy3xGMjYGxzUiyBrkAB
    T2zveHt3jur2ryIGPkG9BxjQHPotIdLQUF4YQl1+lz+/YIibXQexoTkcaMQx3EDt
    N5TsMlMAJLIyCDLLMsC/hCwHBE7/HNwys17ue93JHdrHJNJ06B6/LCuAnSkgTe97
    OL+ncJSsgObS17WgnOXz7SMJ7MvhugRuYNBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526897614; bh=b11d/4ejPRAyo6yvzGS7Yo5v++1Y5l
    K7mt0KzRx9Q5Q=; b=KmReeWKrMPQoQOWcvszU34VLBkWiqjowWOPsVSUVrhL5xx
    Cu53sU7lUUU5nxBvCYTtOJjWeKw2ozxx4eqIHvsjOqo7PKMuLoxKKGFsOWHdlRRX
    sbW+WWD2Lm4doCkg6jdBJMIA2sKDeDFL2jouTTAj+LgyvBOLVjuocA55hztQS4dJ
    PVvP0aBH8ZK/3UErxeeeqYHvuH5vumeEmMh8pEIi4VPq+j1TUVZEGp+3JpQ+iZd0
    DSk1LemUpDRARkr23HF+zYaZ32ew90Ut1p7ZcXIacgLTO4yIZbXhBrCte7gn+bqA
    Z5Cfb26t1R1KJksxOU0SjgfkTbiR0Ey0hUb3KSxg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=rock-chips.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=rock-chips.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO9xLjGwO8iIrBe/vKhaz0mXG9SA3XfkABcHgO9OQBmBclhrj+ZkB0vqCg4J9qKk/PXyUvtFD9z1GuuwZeKC8HwLCl4CCJHnWH3iA/5x7j+KLRgd5xSe
    ez+ACoBRUyT01zdNvse+QT7VhY5HLJd/h40ypN5xVt2KwVD0m2Vu8gcKDacRB0D9mO7wwX5zrypM8uKjxjRGA+LuqVuVYjTA+iurqmaT58I+deJAMBOdN6Hd
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=4_-BN3WEXhEA:10 a=VUJBJC2UJ8kA:10
    a=s8YR1HE3AAAA:8 a=VwQbUJbxAAAA:8 a=qWF6PjqbNgdoSuVphE0A:9 a=x8gzFH9gYPwA:10
    a=jGH_LyMDp9YhSvY-UuyI:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbeEUKNT (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 06:13:19 -0400
Received: from regular1.263xmail.com ([211.150.99.141]:52730 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbeEUKNQ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 21 May 2018 06:13:16 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: william.wu@rock-chips.com
X-FST-TO: hminas@synopsys.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: william.wu@rock-chips.com
X-UNIQUE-TAG: <da4afb1238ce17ee863d96a4502f78af>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: William Wu <william.wu@rock-chips.com>
To: hminas@synopsys.com, felipe.balbi@linux.intel.com,
        gregkh@linuxfoundation.org
Cc: sergei.shtylyov@cogentembedded.com, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-rockchip@lists.infradead.org, frank.wang@rock-chips.com,
        huangtao@rock-chips.com, dianders@google.com,
        daniel.meng@rock-chips.com, John.Youn@synopsys.com,
        william.wu@rock-chips.com, fml@rock-chips.com
Subject: [PATCH] usb: dwc2: fix the incorrect bitmaps for the ports of multi_tt hub
Date: Mon, 21 May 2018 18:12:00 +0800
Message-Id: <1526897520-9340-1-git-send-email-william.wu@rock-chips.com>
X-Mailer: git-send-email 2.0.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The dwc2_get_ls_map() use ttport to reference into the
bitmap if we're on a multi_tt hub. But the bitmaps index
from 0 to (hub->maxchild - 1), while the ttport index from
1 to hub->maxchild. This will cause invalid memory access
when the number of ttport is hub->maxchild.

Without this patch, I can easily meet a Kernel panic issue
if connect a low-speed USB mouse with the max port of FE2.1
multi-tt hub (1a40:0201) on rk3288 platform.

Signed-off-by: William Wu <william.wu@rock-chips.com>
---
 drivers/usb/dwc2/hcd_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
index d7c3d6c..9c55d1a 100644
--- a/drivers/usb/dwc2/hcd_queue.c
+++ b/drivers/usb/dwc2/hcd_queue.c
@@ -383,7 +383,7 @@ static unsigned long *dwc2_get_ls_map(struct dwc2_hsotg *hsotg,
 	/* Get the map and adjust if this is a multi_tt hub */
 	map = qh->dwc_tt->periodic_bitmaps;
 	if (qh->dwc_tt->usb_tt->multi)
-		map += DWC2_ELEMENTS_PER_LS_BITMAP * qh->ttport;
+		map += DWC2_ELEMENTS_PER_LS_BITMAP * (qh->ttport - 1);
 
 	return map;
 }
-- 
2.0.0



Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330670-1519987115-2-16439890276458807894
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519987114; b=VgOpHO4mztSZK3Jl1kQ6vATD/sh7WzfRK7q/Imio14JpETC
    B015g51YYa0FTEDIdTfN2yntpVOqvj3jwEWpFWJl2dcoH8MgFTymjk0Z7nef0txg
    Ok00kjQBbyfv/3BIdqTe42ziu7U2hxnkIEiRnZKVUcVPWDpEpmG7K84yyRCeV5xg
    6u+fZLwY9VXeGdlKNIDxIUf4eTDUt8BjYy8TXPT68HxcD/BmvlWcXi5OAVkTVTme
    G9F/wUCEj9sVREwcKq8URhdwr0xOqJsuKV3nLLIgdEozNuz0pTaLJHdK8CTnPyYy
    zrqoWzyCXOy0HmQSelcHURGsZIv3Bow+V7gwSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519987114;
    bh=xicnau1AorPdLQuLyIRPOUcRgVbq11AN/PLxGK1c5To=; b=nYPOBWoSU6Fa
    kNSn9KoXdFyYcXkuDs1Ro0HzIRGyJ9WqIyYsL/33JyEFC9CxWuWFeNX6sAsoixMY
    aNIM2Cz8Ov2iJauAi36exqgzmAIYNn1n+Uyo32LU6rjuKpSv8+nEmKbZCUxDEYPc
    OfyOsozruqis2i+PWbqMHq/I3bulsZEAN+w6IX6g+wVepiH83lnCuMjZjAi5/liP
    ianE0ZIjL+FNefOHBd6mrcnP/ZipWBAPAbeZHih6rD2q2t4zmqGQaniEcM3CNWVF
    0LuFchHbGDlEGu1/2oJCSWGZxPlVY1h/ppTiVM0a2VuU5h+Uz4dI5VdEqkxGYiRT
    g3zPo85Ohw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946235AbeCBKhT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 05:37:19 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1946347AbeCBKgj (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 05:36:39 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pci@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 2/2] PCI: Add function 1 DMA alias quirk for Highpoint RocketRAID 644L
Date: Fri,  2 Mar 2018 11:36:33 +0100
Message-Id: <20180302103633.10592-3-hdegoede@redhat.com>
In-Reply-To: <20180302103633.10592-1-hdegoede@redhat.com>
References: <20180302103633.10592-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Highpoint RocketRAID 644L uses a Marvel 88SE9235 controller, as with
other Marvel controllers this needs a function 1 DMA alias quirk.

Note the RocketRAID 642L uses the same Marvel 88SE9235 controller and
already is listed with a function 1 DMA alias quirk.

Cc: stable@vger.kernel.org
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1534106
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8b14bd326d4a..46d47bd6ca1f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3908,6 +3908,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9230,
 			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
 			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0645,
+			 quirk_dma_func1_alias);
 /* https://bugs.gentoo.org/show_bug.cgi?id=497630 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_JMICRON,
 			 PCI_DEVICE_ID_JMICRON_JMB388_ESD,
-- 
2.14.3

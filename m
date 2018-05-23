Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3988127-1527065662-2-1554961758141886506
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES enroda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527065661; b=ZpjnhH3J94xPrq8f7zLmyWjWRzpmCQChzOZGDPaXaqMuXAYCCo
    A2ZzNzbf0RSUCoGsXPtw0ipWXro+SPJgLwv4d2235fUrl8rHTygPjCBJUrohtXkJ
    1e6xmtg2VTUr5m4fmRIoLF8WbkuwEdQzNBueQ4nHXbswOlJOsAQz/yGT5otwuS6L
    Zh/nqAfLU2vBhaD1fq+sr+hd9WMtNjWT/YF1CGGGhWDkcNOHTzrz+OhmesDP7loq
    XqIK2ajPnZJ8u4o9sy6r3XkeJC0XhWfVbrJJFvwFSFaZ66X55g1dhs+zXbKpdL+5
    caze3RAzI2oN7Lmvc50XORVzBANTlRkj8IAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527065661; bh=EEVwrPBXAFXgJAlJ+UwB4BZV+yru3W
    NRoyaU90KJcbw=; b=aU7r/y/qOm1tsHMy+b6k5yKv4jSAInY3YRVagBxUJx7OhF
    WalmaiMcV2kqXyVT/66vcCk3xw+XQgOaGq46Yephm5XlSheJOrcOLfOSrQAURj6i
    NRw4C/QY0Jd+9Ic5xLN3Jmdx4y/0WBC9gltG10jJkZG4DcdM/lBdAmeR2zP1YCiv
    F7CaNCXCMbRFRmZoJwTX8iDTL6nTFJIHXv+Fh2s60EGazxcS86eVgbwW1ko/mGUn
    aruItKU54zwZOkfTPZ3PY6hdajav0BTBA+1wbAJb5y/4OSgKSoJbmzVm0+DorzHK
    UW9dGqF72heP5FpsFSAlh9IELcPDNX71kmpJiUEQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mediatek.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mediatek.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI9neRxi0c+ILJkzHQHwiVeMi7yROPL7pA0/LjFiELOj0MippcsjDKtpIxgEPw9Zwweh08xuCiSHmQbvKYQZMsu9rR8AvgzxvcoBs0bfxziqSiXg4KDV
    IFIq7tLtsV+1QrX0do7sRpOTALz2cTmplKeSzqNNVtujB3vr+NSU1GEW3tORxmMVv1FTMTgR+EzSIOo6VLT5SP2lNeYbsBXIsTXSJyE01AQvrOUL68RCbMVN
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=Ndx7yIVex8M7RJDNeXoA:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754580AbeEWIyH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 04:54:07 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:18908 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754493AbeEWIxc (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 23 May 2018 04:53:32 -0400
X-UUID: 113bf5d384d5430999316a89700230b9-20180523
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [next, PATCH 5/6] usb: mtu3: reset gadget when VBUS_FALL interrupt arises
Date: Wed, 23 May 2018 16:53:19 +0800
Message-ID: <4def1d8ab49ab7733693c037c979ea89895856df.1527065109.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
References: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When VBUS_FALL interrupt arises, it means U3 device is disconnected
with host, so need reset status of gadget

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 279f9cd..eecfd06 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -668,8 +668,10 @@ static irqreturn_t mtu3_u3_ltssm_isr(struct mtu3 *mtu)
 	if (ltssm & (HOT_RST_INTR | WARM_RST_INTR))
 		mtu3_gadget_reset(mtu);
 
-	if (ltssm & VBUS_FALL_INTR)
+	if (ltssm & VBUS_FALL_INTR) {
 		mtu3_ss_func_set(mtu, false);
+		mtu3_gadget_reset(mtu);
+	}
 
 	if (ltssm & VBUS_RISE_INTR)
 		mtu3_ss_func_set(mtu, true);
-- 
1.9.1


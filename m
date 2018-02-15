Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518710366-2-16523391510524685108
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710365; b=RVN+D/5B2+/Z652KCnw4eosGaC1rYXR9LqCsiLGYl6IHf4K
    hC6FJWdMuAfcLElD0Jr+ZxaIQwDBdopFJ4XB7ggNsSQ1tmzH1gJI+yREgxw75U0F
    0cu+eTxz5f73jQgfU4vKKxy7G0R1kA4bFda1kJojD+fYWHa6IifjqVUyrqrH8dE1
    hYdv0tejE9zCY74CZ5aO7LqQ5niRLielPnhKlri3Ompq+gNbDj7swrTTKG38tS/D
    889m/rp+LY0wmjR7h1/KTPp1cuzyD8mWQK4cpVZgDyRTP5KDy+swVLsglfBimd/U
    0KjfqUw6J1mthR5uM5UMaHotw2nPfekQi6V7t4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710365; bh=IHhIIeqSwYo8RftaynS+VT57dM
    TTrOUotn0DbQNerjg=; b=XfHBdYdlqjQMpEnTEaAE3UJEIJcAx2oxwVTuM/1VoM
    U2H0OdkokeQFNAhG7//89EnYpUpUJp/oyDD0ulT2J6hvQzGScpC/5wE7Bk+AfzsV
    lUWUR2oEPahte1DTLJv4YPrfbq+ic4zWQE6SvgwmYV0r/QlnrXqYPvchlr6kYo3+
    Qewwfc+3Yr1tYKkjB7xO/Atr0fKbfnDcZKSyYgPngNieYsuPw6EgFiFkVwI/XO38
    9pF1vCtqh3dl/lLejdSHT/g/yg3MxPhFUxnvePr/exKG4lN4DUwV84g6cuE5gRap
    LtHjVzq+exu9mnDCKNOFLUknbKg5qayiXrUGimuinrTw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425400AbeBOP6n (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:58:43 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:24415 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1424805AbeBOPrB (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Feb 2018 10:47:01 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: John Youn <johnyoun@synopsys.com>, Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 2/2] usb: dwc2: fix STM32F7 USB OTG HS compatible
Date: Thu, 15 Feb 2018 16:46:41 +0100
Message-ID: <1518709601-17232-4-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518709601-17232-1-git-send-email-amelie.delaunay@st.com>
References: <1518709601-17232-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_06:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch fixes compatible for STM32F7 USB OTG HS and consistently rename
dw2_set_params function.
The v2 former patch [1] had been acked by Paul Young, but v1 was merged.

[1] https://patchwork.kernel.org/patch/9925573/

Fixes: d8fae8b93682 ("usb: dwc2: add support for STM32F7xx USB OTG HS")
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/usb/dwc2/params.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 03fd20f..c4a4749 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -137,7 +137,7 @@ static void dwc2_set_stm32f4x9_fsotg_params(struct dwc2_hsotg *hsotg)
 	p->activate_stm_fs_transceiver = true;
 }
 
-static void dwc2_set_stm32f7xx_hsotg_params(struct dwc2_hsotg *hsotg)
+static void dwc2_set_stm32f7_hsotg_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
 
@@ -164,8 +164,8 @@ const struct of_device_id dwc2_of_match_table[] = {
 	{ .compatible = "st,stm32f4x9-fsotg",
 	  .data = dwc2_set_stm32f4x9_fsotg_params },
 	{ .compatible = "st,stm32f4x9-hsotg" },
-	{ .compatible = "st,stm32f7xx-hsotg",
-	  .data = dwc2_set_stm32f7xx_hsotg_params },
+	{ .compatible = "st,stm32f7-hsotg",
+	  .data = dwc2_set_stm32f7_hsotg_params },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dwc2_of_match_table);
-- 
2.7.4


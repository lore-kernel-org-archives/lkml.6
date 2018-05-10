Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521860-1525931274-2-11828901551896841520
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES enfr, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525931273; b=SpldlFZzaElhGH7nadSy4k596JVbcooVj3OEITdobkO2Uf4JtV
    XSHO0hZ7TY9mQhSNH68HUdCDsVHfvzHGJYgi5eMjOKt0c7/wHU20aqUaobgi8i2A
    oi0J/FXjc8jzvKCgUZ9skq0SzXPFHNtg/KIBtDsI0AhQXBuUZG7PE6VLS7Z/RLY2
    HONnAZRSJChuV8W5+yvIzfKEq039PIUcMWqWlSLO7e8a2s0Q2zxH8RWbDu4NNuyy
    IyhkhEWsGIjiyuwrGJIIsR8BKJHLhy1dfIdnqaY+85tH6Jy7Y5qpv4sCbfES5MC/
    aH+bJAVXtJJ2caQrBSMPKojcIoGQhCI9BFtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525931273; bh=8L0875GvVZnPcLgXwxpC7AluX5QAmn
    P1fkEE/bACXlg=; b=NI+aLZ0DSpXwdCSpKLBHnaCt9IDmO2gmdPagwrBk+Ea/LJ
    EvB40/qsoWnYTxZnGHQC2lKFwFuX3OH8rsAr1WtIdd/GW3hJOfBS6CuLrpUhFdnk
    spPzURENJ2F7U1ML38D/Mk4wVij8+VAAUSHJfjHAHQ1jChxqwmFUn/XxmZD4x4OW
    tNNA2n56uZjT+7KkaTF9bsvWPURQw19Iw07kYGML2GL0vGmREMPEwGuDJgRX7wf8
    /8AECpk4sx3VQTR79wLCDrdqfFGbLE7womqm5bsi3s5OXmALEsP95vYUJDJUrlId
    ceNTHThWzXgnEooIgINoA4PQDQGH0PnftbCtd3qA==
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
X-CM-Envelope: MS4wfN+5SN2vQk9xWAJqgSxGeg2r9Sqso6zGBERYvmK0p8FwfiNS2jLyJSHC9pCjwCD3EjbY1SejtZqLGQYSrzU3ZqFdLOS9pNwO9JVAuwfVApAakxw+8mrP
    FR6fHMbyXfWYlWhNwz6CONpn0nRqsUt0K03RcHXvBDnpb6CMIUgZrT39Kc/2sfQmRlvMBaSSk211VB1Q25BtQq89W8GTlZFkUba918RJmr78t6vJlC2SzkRv
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=uu9A0wdrPvRg0bbQsk8A:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756681AbeEJFrd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 01:47:33 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:62365 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756648AbeEJFra (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 10 May 2018 01:47:30 -0400
X-UUID: 6f13d852b40e461594cfe32bdd6610bc-20180510
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 6/7] usb: mtu3: re-enable controller to accept LPM request after LPM resume
Date: Thu, 10 May 2018 13:47:11 +0800
Message-ID: <5ebd9e0bfbf3dcb7312b931849d2bd639c170673.1525930818.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <6b82c11302a81368bd6936424d081ede3340b431.1525930818.git.chunfeng.yun@mediatek.com>
References: <6b82c11302a81368bd6936424d081ede3340b431.1525930818.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

After the controller receives a LPM request, it will reject the LPM
request, and need software to re-enable it after LPM resume if the
controller doesn't remote wakeup from L1 automatically

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2:
    add this patch
---
 drivers/usb/mtu3/mtu3_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index b1b99a8..65ff53a 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -176,7 +176,7 @@ static void mtu3_intr_enable(struct mtu3 *mtu)
 	mtu3_writel(mbase, U3D_LV1IESR, value);
 
 	/* Enable U2 common USB interrupts */
-	value = SUSPEND_INTR | RESUME_INTR | RESET_INTR;
+	value = SUSPEND_INTR | RESUME_INTR | RESET_INTR | LPM_RESUME_INTR;
 	mtu3_writel(mbase, U3D_COMMON_USB_INTR_ENABLE, value);
 
 	if (mtu->is_u3_ip) {
@@ -692,6 +692,12 @@ static irqreturn_t mtu3_u2_common_isr(struct mtu3 *mtu)
 	if (u2comm & RESET_INTR)
 		mtu3_gadget_reset(mtu);
 
+	if (u2comm & LPM_RESUME_INTR) {
+		if (!(mtu3_readl(mbase, U3D_POWER_MANAGEMENT) & LPM_HRWE))
+			mtu3_setbits(mbase, U3D_USB20_MISC_CONTROL,
+				     LPM_U3_ACK_EN);
+	}
+
 	return IRQ_HANDLED;
 }
 
-- 
1.9.1


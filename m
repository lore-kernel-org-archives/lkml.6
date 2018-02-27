Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1199706-1519728891-2-14959974712273931197
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519728890; b=wIUjGFSIzxiMhZ27B1Xw5c9Z//fUQJUAKakC1DMve/QN0+Q
    t963WG+fuPHHjHTU/xiPTwh/Bn7JPRFzEdfxtlVvFvCLEFr1RSgU80+9KKkbJNKE
    CcU++oJ69oeKn9J3zLwvS0AfkuDaAtrGSM4tjYln2dLMoV8Jr+Qpy+BJEoPBLMNW
    jKHtY2Xw0p0KHg9tv5Jtvk3W9IpM9fRKW/igBmtpuJV5fMPwSN3OAjFrbprV+UFg
    sCoXEn9xIw/BjRTyKUT9ZWkckarrS65iFWE0NsoxbMsjpDGKsxtcvffmyC9VnLzY
    skHDPYNztKzx/xLwPH9F4oSNFJI/o6Qbe+5iiWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519728890; bh=5Pbq01ywFxrVoKvgfOQJLLrUpb46WofKxS28r6YxrnY=; b=O
    ErG5sjuVGbktZqzUshPqAw0uMToYK8FosOu8mP0XkMnmsQngIvjJczOm5HLAiZ53
    VbAuABAY2qdstiZHnPL/xtwBHOH1p9SOLuEMzwl4X0xExWNpR+WKBwT6vZ3DOzts
    9KYhG/jIwQD2oEwq9mqLf4K61TJdI+i3+M55Ln3pFL10BCEcH/yDaLZtmzRNzNia
    PJpDEd9C620jNIAMJaJWVNQGOuZO4QttiU/gNAdDMLUnz3t2Cj5N3D7E1kyMDWbD
    FlunKhxti042I15J3LvVB4e0ktMq4bkxSxObe1NEnst94txTbyMIaSiiheOa75RY
    yqeiqyzJcUKC6+DprDfyw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=PEQwB2Il x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=PEQwB2Il x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeB0Kyr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 05:54:47 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:41668 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752526AbeB0Kyq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 05:54:46 -0500
From: Roger Quadros <rogerq@ti.com>
To: <balbi@kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>,
        "# v4 . 12+" <stable@vger.kernel.org>
Subject: [PATCH] usb: dwc3: prevent setting PRTCAP to OTG from debugfs
Date: Tue, 27 Feb 2018 12:54:37 +0200
Message-ID: <1519728877-9366-1-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We don't support PRTCAP == OTG yet, so prevent user from
setting it via debugfs.

Fixes: 41ce1456e1db ("usb: dwc3: core: make dwc3_set_mode() work properly")
Cc: <stable@vger.kernel.org> # v4.12+
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index e94bf91..df4569d 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -119,6 +119,9 @@ static void __dwc3_set_mode(struct work_struct *work)
 	if (dwc->dr_mode != USB_DR_MODE_OTG)
 		return;
 
+	if (dwc->desired_dr_role == DWC3_GCTL_PRTCAP_OTG)
+		return;
+
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_HOST:
 		dwc3_host_exit(dwc);
-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

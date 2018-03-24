Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-577984-1521925775-2-4771513120346571052
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521925774; b=wC3tVZs5rp2YzBfkrtDY/aRK9vUMlYTeTLiZMIPI1YAgQjg
    BUOX+9lpo6cOGpjF/KIsg+sekeo+UGG6L24Ubh073MZsnoNAKHpIdpbxw3ry5UqS
    LLTRP3/A9LQTGCF2I/GO2Ojw3/6gSnB/I+nCTOBSLFYEhrexLkQVWSjxZDOq3EM1
    bub7MJgUq59OqAIo5jC/JA/H/pQN19cYqYfbQv9iQgEl5di66mtJyrYHNXnJvIdk
    mhn4A8TP19tNN0Xda/P2btHI0dJHtwVpjVpWr145ttMld6Qa1AW+8XA1b9/Nb4qz
    f3N8QSWdBeG9qp05lZVBYst1wUDPK7duCsLZI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521925774; bh=QofX2vBdUQTxHeOaoKqi9MEcO1
    2ERXyu1arYDGB0qUc=; b=FzY//7x2YPID41oFMa5GlmwMN02WkcarCkBOe2w8ix
    kapOGItim6wkjEGa3o51vVU0L8Y0XCUuHlthNocI8MBMY4pQekxOypoJACXiliPo
    m+OcCwbflIO05tfmBRLnqfr7s3C4G7MD6r+Kls8bcW5fTZOqutwBF0ulN7RBs3IE
    GNRYf318uUDMG1EPm8yA8rSdXeO2hnxEHfkA4jBl8LN8R+0g4QCCiLyVAc9sk7VD
    jkd6dEaMaR0aCTVBu6x7M8QwRiuMw89dIxB3H09GBvkvobsucxmQi4nGOL6MstTM
    qrqHti3A//fQ/NIKeSwVqCL2xTqlIYzETL2nNvqc28gg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hDPtu/Ie x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YIkDgz3b;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hDPtu/Ie x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YIkDgz3b;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752925AbeCXVJS (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Mar 2018 17:09:18 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34394 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752801AbeCXVJR (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sat, 24 Mar 2018 17:09:17 -0400
X-Google-Smtp-Source: AG47ELt2kyaZZGwfF+rWLwSZGAEHVUUK8KACupBrr7zx9QCdFPorbA/MFvP+VWKvc6hVC4vUqUhTCA==
From: Pawel Dembicki <paweldembicki@gmail.com>
To: linux-usb@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: qmi_wwan: add BroadMobi BM806U 2020:2033
Date: Sat, 24 Mar 2018 22:08:14 +0100
Message-Id: <1521925694-15433-1-git-send-email-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

BroadMobi BM806U is an Qualcomm MDM9225 based 3G/4G modem.
Tested hardware BM806U is mounted on D-Link DWR-921-C3 router.
The USB id is added to qmi_wwan.c to allow QMI communication with
the BM806U.

Tested on 4.14 kernel and OpenWRT.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 76ac480..7ced288 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1180,6 +1180,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x19d2, 0x2002, 4)},	/* ZTE (Vodafone) K3765-Z */
 	{QMI_FIXED_INTF(0x2001, 0x7e19, 4)},	/* D-Link DWM-221 B1 */
 	{QMI_FIXED_INTF(0x2001, 0x7e35, 4)},	/* D-Link DWM-222 */
+	{QMI_FIXED_INTF(0x2020, 0x2033, 4)},	/* BroadMobi BM806U */
 	{QMI_FIXED_INTF(0x0f3d, 0x68a2, 8)},    /* Sierra Wireless MC7700 */
 	{QMI_FIXED_INTF(0x114f, 0x68a2, 8)},    /* Sierra Wireless MC7750 */
 	{QMI_FIXED_INTF(0x1199, 0x68a2, 8)},	/* Sierra Wireless MC7710 in QMI mode */
-- 
2.7.4


Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-672961-1524856376-2-13451773986659444547
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524856375; b=TCOH75SQ1+zSe/Veoo1e/eK2+fv2Yi1vRKFaJf0A3WhqqYdHEe
    6W3Xe4mg1g+k5efXHRmxXYkPSWQO8d8t+lis8pYFhzcJw4xUkcu39CESWQK+3Kmb
    A5P6mWV2o9/lhsEJDcusbXzF9hmFhuCu/KsL2clneMdVdvm74Klr5Nn64lO7CqjC
    AnxY3vU4dvSW0IJzRT5hxiqLOdJbldwBTQpG7TGqWW61RRoiQcAGTFAWiDC8Nk5F
    1sJjttCKUJNdkI/xeI4+hmWL17sXamKBBXDT8sJoGAXyHCxXPEz4uGUR3u1XsZ8+
    F7cp0oSrWKTNHKper/MW2XG7PiDmGoQ8hR5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1524856375; bh=Jp2zPG0jH4GfETXNQ5r88yPIc2SmKn
    Nw9yaPYnkDxXg=; b=mFmPOB4XO/fnVddShLe34MBF/a7NhqmApS6/eh62QhRb3s
    JKlZYU9/WAVkecMxOpS+NIAqdzd+6nVOzIcteZLdCUMslOK2qWmsV06bS2ImpYSJ
    itgt7OGzc/PvfSogB1coByehaJ8jKBRvl1v3zW5Bf3nEFEqASymHRdK2gvqeXZqX
    MjsHLcrpyoVIneWc8e4yxTnf2cZEW7+yiUtF5CqSJUjm5mvbJ4LtIuDW6MrpiePK
    Hi3xg2WoIt2zkifxHG80TS2vW578TomsFD9hzEv/JH53KoeMlFN0gjuAo27zh8Ap
    SDGShJmq3uaC5e1spfzGkQTB6UtwGpuPP35EbRGQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE28LNmXs/1PqVEvTd8jYsVuLQr7lGA9Zn/JVDSjwyC6uUqG0rHCUO9AdpkA0qG+RFm9sv+iPfn3ZdXMk97xFyXl2s78wRt2Vafn+AtpX9lPJOdBXPSY
    xW81i/y45YI0/9V2qJUBcKijzJ2iGD1eymmh1UI5ldulIWi3bXpszSrL5T2d1/CiJ/0kNr6vg0c3Y4rclNO8Y0XZ/PVWGIdH+pf2bIPhqSKMGVUAfCTXlsMY
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=D9DHsTnTt1QpoLYdM_UA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758852AbeD0TMh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 15:12:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33523 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758203AbeD0TMe (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 27 Apr 2018 15:12:34 -0400
From: Colin King <colin.king@canonical.com>
To: Thomas Winischhofer <thomas@winischhofer.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb-misc: sisusbvga: fix spelling mistake: "asymmeric" -> "asymmetric"
Date: Fri, 27 Apr 2018 20:12:31 +0100
Message-Id: <20180427191231.17305-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in text string

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/misc/sisusbvga/sisusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb.c b/drivers/usb/misc/sisusbvga/sisusb.c
index 3e65bdc2615c..f92c5df26320 100644
--- a/drivers/usb/misc/sisusbvga/sisusb.c
+++ b/drivers/usb/misc/sisusbvga/sisusb.c
@@ -2107,7 +2107,7 @@ static void sisusb_get_ramconfig(struct sisusb_usb_data *sisusb)
 		bw = busSDR[(tmp8 & 0x03)];
 		break;
 	case 2:
-		ramtypetext1 = "asymmeric";
+		ramtypetext1 = "asymmetric";
 		sisusb->vramsize += sisusb->vramsize/2;
 		bw = busDDRA[(tmp8 & 0x03)];
 		break;
-- 
2.17.0


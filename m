Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-526264-1526486468-2-16856192212973312556
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FROM_WORDY 2.046, HEADER_FROM_DIFFERENT_DOMAINS 0.248,
  MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='GB'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526486467; b=DEi+9Z3oYLCGGGLttcVaBLyW8ePmvur2EpWFTFdqBXKavXkny7
    GKgNOaJXZBjuDEOCFfyUdq3dJuepO0g8ouqk2LCT2bkPrOSwLEmOPafiCfUfqe1L
    5KtG71VHeYRePIFaS1p2Voz2d9GsreL9ab6P6dWcB5tIU7YAfcf3iE9ObSLzCl1q
    EXE5KhqQH4BiZJJZb/DgjIX1VueXKP5d6QAQ8qr9EntRHO6k9MWVLeMsdCRtcmwH
    EWxqSCHw71D63wwZ0phNiGQr6uUiSw+q/3QmlQ9eayEwQ4GIxFTW76/gOGeYBjVW
    hYTTQlSUXned6ypz6lH5sVCf1FkWqVLuwiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:date:subject:to:cc:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1526486467;
    bh=XUPJWK3P7/0PQ+u4/Br/zbdi5vMrhOWCwI1kHlMb550=; b=bVDvluKmlf3G
    TE1A/C+GZNbHq00vb2hlG3MuAgHqAaTYcGVolJwRbUF1G7UJ7zkluLAa9cJtULDv
    L1ibTGsHhRg36vexF2v+DzHDy5selSZG2QnjZhKJpGkdcGrnl+DxHxwdupQwlJe/
    Lbfu8EXxHyFO0SZrNq5tQO7z6B01IoarmPUy1tHB+dMvYjhSSPfUVv5zHAKVgLHa
    qXxiGsNwPxpdDGERAlr6upDKNXa9jBysMTH0R3fDGe2BBbU1SQhBqWJZoSs4GT2I
    vAl6F/xqufnjLX+5Ulvb5/OPDcmUrNOlF03c1q0hCyXee1Bnb4P4KZ3PK0iOidW7
    uqJ1LJEMcw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAT4cRHgbc7mSxGrVGdSodZo2JRFg7gVwTVJ4Inkpkx6DiCI4cwlqmt7QetDsJLo6Ye+zd+9HJHz6oNunLfaY63hq9oc96857rZKy/wUsI2Tlcy+CXG7
    SYEF3joNXF8a5BLdnmLIh8sNzJePqfwf7i53lKeaYGRR3/dKfScpm/WSsG14yiUZmHyvnHzT2QwG1Uf7A4I3do2p/sPbizkVNbLia1tM5w+JYjXDIo8f8SAC
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=QRjQRLzp78EA:10 a=VUJBJC2UJ8kA:10
    a=X3a0BiUdAAAA:8 a=VwQbUJbxAAAA:8 a=1Tg_NjBZcfcoWUSjyrAA:9 a=x8gzFH9gYPwA:10
    a=aWu3muFgq6otJbhCXpL5:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbeEPQAy (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 12:00:54 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.132]:27320 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750858AbeEPQAx (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 16 May 2018 12:00:53 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRWlGSWpSXmKPExsUSt3Opse760D9
  RBlv2MVk0L17PZtG1eieLxeVdc9gsFi1rZbZ4svAMkwOrx7yTgR77565h99j5vYHd4/MmuQCW
  KNbMvKT8igTWjFWfEwqa2CoWLfjG0sA4m7WLkYtDSGA9o8TylwuAHE4gp0Li6byFLCA2m4CFx
  OQTD9hAbBYBVYkHN08A2RwcwgIeEif3pIH0igh0M0qc3PSUHaSGWSBJYu3bHmYQm1fAQeLSjW
  1sELagxMmZT1ggaiQkDr54wQyxy0Di9IJGsLiEgL3E9PdXmUHmSwjoSzQei4UIG0p8n/UNqsR
  c4k/7aqYJjPyzkEydhWTqAkamVYzmSUWZ6RkluYmZObqGBga6hoZGukYGxroWRnqJVbrJeqml
  uuWpxSW6hnqJ5cV6xZW5yTkpenmpJZsYgaHMAAQ7GK98Sz7EKMnBpCTK2/fvd5QQX1J+SmVGY
  nFGfFFpTmrxIUYZDg4lCd7HIX+ihASLUtNTK9Iyc4BRBZOW4OBREuG9BJLmLS5IzC3OTIdInW
  JUlBLnZQfGopAASCKjNA+uDRbJlxhlpYR5GYEOEeIpSC3KzSxBlX/FKM7BqCTM2wgyniczrwR
  u+iugxUxAixkP/AZZXJKIkJJqYGRRM+u9r1YxydPXKf9QvVrRo0sHLDdPC/qTzLPjAHtv8jKW
  5uyll2vKc/+pPm6rc5zbWb/B9o75/sPJWjIPPrzbyMjYx8MW43jlLO/5nacuav64cDvz5JadW
  8w2e8ic5Ml6Zjvj3p+tzzSmGFh/PP6ssveni0Nn2ZW4mEdXE4N1pp359U6LhUOJpTgj0VCLua
  g4EQC7Mpcn3wIAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-19.tower-302.messagelabs.com!1526486446!26404!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Wed, 16 May 2018 17:00:46 +0100
Subject: [PATCH] typec: tcpm: Provide of_node pointer as part of psy_cfg
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <support.opensource@diasemi.com>
Message-ID: <20180516160046.18FCF3FAD3@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 16/05/2018 13:16:00
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For supply registration, provide of_node pointer of the port device,
via the power_supply_config structure, to allow other psy drivers
to add us as a supplier using the 'power-supplies' DT property.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/usb/typec/tcpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 72996cc..e7c0b95 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -4500,6 +4500,7 @@ static int devm_tcpm_psy_register(struct tcpm_port *port)
 	char *psy_name;
 
 	psy_cfg.drv_data = port;
+	psy_cfg.of_node = port->dev->of_node;
 	psy_name = devm_kzalloc(port->dev, psy_name_len, GFP_KERNEL);
 	if (!psy_name)
 		return -ENOMEM;
-- 
1.9.1


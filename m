Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3328118-1521214606-4-852613986551375403
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521214606; b=q6shq5w2TgDzjGCAF60vfi2Er52U9ky22q0GXbQZwUZB0+M
    KBWbB8d2dcLjMyYGvtrRNbcX6NnaMFdn7Aofl5kRhDGSQ3hfH5ySZxRJO0HVEIj6
    vXerRH3OlZi23Z8Wh6MTEBT2dcBtyizfB2eL2kC6JazklLVJ9q60nL3NoOEI5RID
    6PTBUcX6Fr2bJjSvnxeYRXyunhyLmzGQxZgQRGLEdPbILjZl7B6NdNdWoGvS5OOu
    ulGer9FF9IR8oxpCPNH5KL/Sr9jGP7LJyZ0sENtJ2aDGBDM8gxTHYDCreeUD3jMp
    3hmgA0it+ihmv4LMEoctpson0Y8krGupDRT8VpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214606; bh=WQ41bSRDZGuxdWTHpWUcBs+z8K
    Z1fvCVmPDAfS4ULWA=; b=usUEciqymlBbieyWNoncylaM8ymfCaIU3oGreKG7vc
    2LP6WiszEuGs8scnLXyLag9MwCSZrPNVLr9UZXiBXXUbTCTJl81wvTIivPhlZBEV
    mAtCrXOjv8xXxPFYQyXJa5YF5b09/T5xKa/Id4p8XEgSCDsp6mANhLoIzJaE20qa
    tIjDyqtNZy5JvIE9uX5S8ljpgsdoKGAX2w8YDhyXtoKRXLQnuKgLlBWMjgr4a+ZE
    FD/eukUeklzAlSFTyKnJzOw6HJW3IjOBaSaqTP9RiDRa4OhSZkfV6AL863mPMMu+
    /4xN5OEKDVnOurqbVlIRjw84tyiPMo6oM5rOcz8VuA8Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934294AbeCPPga (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:36:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40292 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934217AbeCPPg3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:36:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 058/109] power: supply: ab8500_charger: Bail out in case of error in ab8500_charger_init_hw_registers()
Date: Fri, 16 Mar 2018 16:23:27 +0100
Message-Id: <20180316152333.100508843@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit 09edcb647542487864e23aa8d2ef26be3e08978a ]

If an error occurs when we enable the backup battery charging, we should
go through the error handling path directly.

Before commit db43e6c473b5 ("ab8500-bm: Add usb power path support") this
was the case, but this commit has added some code between the last test and
the 'out' label.
So, in case of error, this added code is executed and the error may be
silently ignored.

Fix it by adding the missing 'goto out', as done in all other error
handling paths.

Fixes: db43e6c473b5 ("ab8500-bm: Add usb power path support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/ab8500_charger.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3221,8 +3221,10 @@ static int ab8500_charger_init_hw_regist
 	ret = abx500_mask_and_set_register_interruptible(di->dev,
 		AB8500_RTC, AB8500_RTC_CTRL_REG,
 		RTC_BUP_CH_ENA, RTC_BUP_CH_ENA);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(di->dev, "%s mask and set failed\n", __func__);
+		goto out;
+	}
 
 	if (is_ab8540(di->parent)) {
 		ret = abx500_mask_and_set_register_interruptible(di->dev,

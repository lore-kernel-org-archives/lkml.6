Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835614-2-2138621944093762417
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835614; b=a3v5jqH1Vl8sy+ZC9U4BXHeOK2UgXXUBsJMuaEBHPiT9Gt7
    dLrWrEdsIdxur1O1ZsyyOtBbgo1egzKzZ+I8CExRbUQIdW7WzfT6GGMvGgda/+SV
    Ab5YXCm6rTdQ5T+Vvn4CiSKixwU7xQjeUwAKfUGUXHc2iuNnYv1R0tzV3Q3sGJni
    CrAbwz1rPI9RMGyJ0wUxGTeZYItXg3BP18Qo94k8MwTyouotNmKvrjVMZzxYHtlY
    xFHUIHI22KeyhiXY0p+P+4WNZ5jigJqmVyhKa73zw9hoVrXArF3LJfHdKzUZ6tvn
    /e3u+0SbxHO3+rSR2DGxuYvtHcKvOmjn9BRR3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835614; bh=LriiJijAU7uLefXR+KW
    rmt6W0pHcjsgHSttLd+uwVK8=; b=lXimPTCLlH4IfpcslbQ16sYVAecBpVdp5an
    PvRbAD4QRlOPrfR0oYHAEooEUblUCrb2Q57f4Pdh39LaNxjorddPLLwApbT7flaf
    idTdC0SVSa81VINc+90tjDJ8Rw5WPViQmsr8zNxcwy8ZbMijuiAEAPFROI2ESLRE
    Wzg2NJrW/MZIbLH7PW5IiSJhUp1htYQ/MeqRkYeNoKHik9aCUugw4OPFeHaZ/sUN
    b7IgQrsnE53pQYD3XSWOiUnk+rnrCxeHWid91Y1iNnptkFFT24CnfFt8v9AQ1Jr+
    5IAAoulQkUy+sby9YvffSonc2ezwLc1jmwIaXhAY3ZHc0AAEtnw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753114AbeB1QdQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:33:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35096 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752697AbeB1QOP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:14:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Heiner Kallweit" <hkallweit1@gmail.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.280477732@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 020/140] eeprom: at24: check at24_read/write arguments
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

commit d9bcd462daf34aebb8de9ad7f76de0198bb5a0f0 upstream.

So far we completely rely on the caller to provide valid arguments.
To be on the safe side perform an own sanity check.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/misc/eeprom/at24.c | 6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -274,6 +274,9 @@ static ssize_t at24_read(struct at24_dat
 	if (unlikely(!count))
 		return count;
 
+	if (off + count > at24->chip.byte_len)
+		return -EINVAL;
+
 	/*
 	 * Read data from chip, protecting against concurrent updates
 	 * from this host, but not from other I2C masters.
@@ -396,6 +399,9 @@ static ssize_t at24_write(struct at24_da
 	if (unlikely(!count))
 		return count;
 
+	if (off + count > at24->chip.byte_len)
+		return -EINVAL;
+
 	/*
 	 * Write data to chip, protecting against concurrent updates
 	 * from this host, but not from other I2C masters.

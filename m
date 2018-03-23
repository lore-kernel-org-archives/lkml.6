Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521804254-2-14600701336414998203
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
    t=1521804254; b=lAEIRFzVPe+o2d2yXpgi2nKDx9R1/Q8fcp4mikWLuGucggM
    LS5LGohhLq25waUN9qFTMjtSF5epcKtVZbnpm/GK2PxS4mrzdPI+lnDydVX0wKZ0
    b+OEUHyAvN34H/B+qID3TErY33MYrgOpdmLRJPR3OLLwUvFMofDTdGIxs+vQ+lMG
    yFmAn6hqoITlJz8sDuG/eGYVEOBjoMpZR/jlm9zQ4VGT/+GXqpkTHbQSnMU1CN0q
    V8IY3J848r5pTbAtdiyY8KBmSIr4zYenGXXsBG0HEGc693TeZ90AY9wPa/xZMHvY
    yzdnsWKhsAxYg4KGFBNClFaFxqAt7fthffhCHJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804254; bh=lwTP6xyLUkMDKh6Qlu2zBQBsS/
    lnskT+y2bNcJmLwnU=; b=gq7xIqH4oyVAsaeeh4JrFmFh03gxqDtozf4nYSiyec
    O1pP1a+nARIgceRvhdR2w7+ZsE39Jj3q+YGEpOXzTUfHqnEIov8feNPZFLhxNPLr
    5l4mJzQt76m6N1saRosPZJBC6aYWDzzjVHR32V0zRDkVSujVLUghMkUEd13oQZS5
    X03rA4rXrERhOmywdJyR+6WZtKDd8XMW+hgmasUvTLUz1hci//y7mOXa6hKYlsgz
    k+6o5J385VCLwkRUtvUK/Pe2c2zGYenPRrlo/dzQMNK0dF6fIMjU0EFHOdVdU6jx
    pKQp9yB4OgyR5pkKBTMY7k9B+A8JWiLLnjPZrd22vJSA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755375AbeCWKHv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:07:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41392 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755388AbeCWKHu (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:07:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 084/177] mfd: palmas: Reset the POWERHOLD mux during power off
Date: Fri, 23 Mar 2018 10:53:32 +0100
Message-Id: <20180323094209.004748082@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keerthy <j-keerthy@ti.com>


[ Upstream commit 85fdaf8eb9bbec1f0f8a52fd5d85659d60738816 ]

POWERHOLD signal has higher priority  over the DEV_ON bit.
So power off will not happen if the POWERHOLD is held high.
Hence reset the MUX to GPIO_7 mode to release the POWERHOLD
and the DEV_ON bit to take effect to power off the PMIC.

PMIC Power off happens in dire situations like thermal shutdown
so irrespective of the POWERHOLD setting go ahead and turn off
the powerhold.  Currently poweroff is broken on boards that have
powerhold enabled. This fixes poweroff on those boards.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mfd/palmas.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -430,6 +430,20 @@ static void palmas_power_off(void)
 {
 	unsigned int addr;
 	int ret, slave;
+	struct device_node *np = palmas_dev->dev->of_node;
+
+	if (of_property_read_bool(np, "ti,palmas-override-powerhold")) {
+		addr = PALMAS_BASE_TO_REG(PALMAS_PU_PD_OD_BASE,
+					  PALMAS_PRIMARY_SECONDARY_PAD2);
+		slave = PALMAS_BASE_TO_SLAVE(PALMAS_PU_PD_OD_BASE);
+
+		ret = regmap_update_bits(palmas_dev->regmap[slave], addr,
+				PALMAS_PRIMARY_SECONDARY_PAD2_GPIO_7_MASK, 0);
+		if (ret)
+			dev_err(palmas_dev->dev,
+				"Unable to write PRIMARY_SECONDARY_PAD2 %d\n",
+				ret);
+	}
 
 	if (!palmas_dev)
 		return;

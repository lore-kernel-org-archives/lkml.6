Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3798145-1519936518-2-5636770422171592709
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519936518; b=DGEMgu5EBNl9WCLfLtO9c9LZ76znA8Xx8zVzqFXaJSi2WZr
    wXL5ZnPeOCOGT4iNteC4nld5MRyCnDrFOARFCeru+Uq7SgMRekjKv4JpVuVGAvt5
    kzmNfIL6d9eMYXwBTIZvHa6YHJgQJXKGKhxFgzTY1J5JG7qqszxvQcHxRHNhA3tv
    BPdNi3I+/NUuaEoIKeBzn271J6NHi5KApCAngqxRyjSBfFzozigj19DgIQlWSykS
    roki4SvzJIjvkA1a1aYSZISnrnp5WUr4pnezl6Yu73Zz4p8F18rm1/j5fnSLrU5O
    BiFO28LkHrQdNAJiVFQA3/lMWYAVIubZPpwhC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519936518; bh=ddOCaVdep0ITbwlkMnM8j2hcdc
    mJBrMcFQ7HSWAqQqI=; b=HeI83Ylh+eUFFxnr/WjU7IVEjc/fOqTFVWyWxAk/O3
    Kxd6tfX2hxkS6tLw+4LfVGtBm6mPr8+eeZIjT+uWA47YuD3Dshu+Nxh2OhzwzfcO
    BK65kJDbC2FrMCQun37e3udeZWW5J/yBrImS+heStSWzLqvOfd3elr6NfMDmkxxZ
    EadDPHqMx+qECNDomtJdP2XyXYqeA6AhDqhYTT8r7QQ/XBUjjmf4TIeiBtBSnHRA
    6wBu1i/mv4HBWL4GkQ5BEQdHDdQujNiZPLTwOaZ3O5pl67HdfhOp3pZrjea3dLpz
    NwIWo4XYZtnyja2WsFhS9IWyapkdKk4zi8Eg33DokkRg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161596AbeCAUfA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 15:35:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:41712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033189AbeCAUe7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Mar 2018 15:34:59 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A323B21782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        Ben Dooks <ben-linux@fluff.org>, stable@vger.kernel.org
Subject: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
Date: Thu,  1 Mar 2018 21:34:44 +0100
Message-Id: <1519936484-23132-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Interrupt number 0 (returned by platform_get_irq()) might be a valid IRQ
so do not treat it as an error.  If interrupt 0 was configured, the driver
would exit the probe early, before finishing initialization, but with
0-exit status.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: stable@vger.kernel.org
Fixes: e0d1ec97853f ("i2c-s3c2410: Change IRQ to be plain integer.")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/i2c/busses/i2c-s3c2410.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 5d97510ee48b..783a93404f47 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -1178,7 +1178,7 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 	 */
 	if (!(i2c->quirks & QUIRK_POLL)) {
 		i2c->irq = ret = platform_get_irq(pdev, 0);
-		if (ret <= 0) {
+		if (ret < 0) {
 			dev_err(&pdev->dev, "cannot find IRQ\n");
 			clk_unprepare(i2c->clk);
 			return ret;
-- 
2.7.4

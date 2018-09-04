Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE181C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBAF206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="klBc1QI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBAF206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeIDTzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:55:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeIDTzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oBi8AOWHUiLXVpkRqCLnQV6umzf5m9T7gygirx6CK/w=; b=klBc1QI4cDz89PaWR1RtYEfgY
        BFL5BbVMSf8cXNLE8gKTugGSxbpypzQEzMJ567qGniCmj47eVmcCD8i1q4FdATcdi8R9k2YfaLnJW
        mpXMf+dJ5QPDjCvCEW5JXkJRIb+VdOHq0jQi6dZCnPDGh+gJCh9eeuLgKRWTR8NPCoGrecaFCyaqI
        llVsjv+v7W4iG435ZPDUsGwn/+lENK8vd1rhHr6DUfythYND2bSnrSbuL0v5yzee+SbQPKMBML0tm
        0+Pz3Sg96T7DcWZgTHGN3svx++uJVMGjINohFalm3+kOpj2Vx9Xau52LPTan+sxZSTMo+h2/cvdti
        dHwDpx+pA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxDHK-0000Di-9W; Tue, 04 Sep 2018 15:30:06 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3] regulator: fix kernel-doc for regulator_suspend()
Message-ID: <d4cfd9fb-743c-6778-5e2f-fc5f5e51a8dd@infradead.org>
Date:   Tue, 4 Sep 2018 08:30:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warning:

../drivers/regulator/core.c:4479: warning: Excess function parameter 'state' description in 'regulator_suspend'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
---
v2: add missing Cc:s and update patch description.
v3: respin, v2 did not apply cleanly.

 drivers/regulator/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20180904.orig/drivers/regulator/core.c
+++ linux-next-20180904/drivers/regulator/core.c
@@ -4466,7 +4466,7 @@ EXPORT_SYMBOL_GPL(regulator_unregister);
 #ifdef CONFIG_SUSPEND
 /**
  * regulator_suspend - prepare regulators for system wide suspend
- * @state: system suspend state
+ * @dev: ``&struct device`` pointer that is passed to _regulator_suspend()
  *
  * Configure each regulator with it's suspend operating parameters for state.
  */



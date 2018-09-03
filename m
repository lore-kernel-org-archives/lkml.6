Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55924C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DACB20645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uVRWa56V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DACB20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeICU0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 16:26:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39180 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbeICU0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 16:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Jc4/UUjkyOO8BgEnWjXyr11fPXB6FXO/6fETLU4cHjY=; b=uVRWa56VY6KVdMsbLny+N5c+vn
        +sH1UxZWLPWKA+B6Y2pqRjQUc9dAak29pHD0BE3ae8eTBsB2MT/WI9/6KIuxlYPwdD/znROtbAjgL
        6BPBDkIxpbdAb6Rb1N+I57KqCULy7f19dlhg0VDM24AJ8QvxO6f5byYnrZ+EDHX3pLUGQiY2VYf+D
        Z3itvQQtiToEabI83Hg9x9y8I+WaqdMW26RwzHZGIQ6CxPrqDYfx73IoldCqFOlZPFJ6XrnbgcfUU
        5buUVMbZO9KzB1g6/kYkI7JQfJ2USrg+Ul2JPyvt1+53Ff8BE8NIg9s0GQM4CZ30oBjr2caWcP6bf
        dhCt8uog==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwrLt-0000Pu-RK; Mon, 03 Sep 2018 16:05:22 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] regulator: fix kernel-doc function parameter and warning
Message-ID: <c71b22a5-fd31-0b19-4b0b-244f01b11afa@infradead.org>
Date:   Mon, 3 Sep 2018 09:05:20 -0700
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

Fix kernel-doc warning by using correct parameter description:

../drivers/regulator/core.c:4479: warning: Excess function parameter 'state' description in 'regulator_suspend'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
---
v2: add Cc:s and update patch description.

 drivers/regulator/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-419-rc2.orig/drivers/regulator/core.c
+++ lnx-419-rc2/drivers/regulator/core.c
@@ -4470,7 +4470,7 @@ static int _regulator_suspend(struct dev
 
 /**
  * regulator_suspend - prepare regulators for system wide suspend
- * @state: system suspend state
+ * @dev: ``&struct device`` pointer that is passed to _regulator_suspend()
  *
  * Configure each regulator with it's suspend operating parameters for state.
  */



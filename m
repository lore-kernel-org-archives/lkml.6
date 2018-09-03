Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD56CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B7520857
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FHlNSKzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B7520857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeICGvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:51:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33182 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICGvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=us23EShlGFlCKcgIZpt9I3BxDF9Jfxb0igboTmjiN7U=; b=FHlNSKzAygtKobVunHmN59MN5K
        QxjqdEA8/vnoF3H+dOnSYZtiPsuiOkoyqtDfR6h6fG2TvG37CmE/9ddw+pMlIhGGm/n8DQs1UDmZJ
        pBiO2BC0WQ11gQb9QKNg6+aoAv1kq7AAKhXKeTyiHX2ao80rODXgnMP+lNH7H2XUF9e9uvITVhj/L
        UGzExZo0nGiK+DsyGzytXe0VzIGvOb0ez1L5ZRemRuE9j8sMlyh3Tmq4PbbNALGzR0Ka8LvXMdY/p
        LtUZLWWbuHsPdRHWTtAGX2rU48pFpTYm2ENbtUG2jF4V5/xSCPm4Jefc+2LLqZ3ZA1HiueC7rBFbH
        2PmIK/OA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwegY-0005UM-1I
        for linux-kernel@vger.kernel.org; Mon, 03 Sep 2018 02:33:50 +0000
To:     LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] regulator: fix kernel-doc parameter warning
Message-ID: <6307dcdd-7e4a-d708-eda8-b81edbc8e52c@infradead.org>
Date:   Sun, 2 Sep 2018 19:33:49 -0700
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


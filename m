Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DCBC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A71240C2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lxcEwKDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A71240C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbeGDT7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 15:59:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53146 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752794AbeGDT7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 15:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9VpWxNpkpRhpDCCbZ6I13oYfyCKA+f8JqHd3mEp4qZY=; b=lxcEwKDToSl7rknUwUS9LPDru
        t+miXp8TbDK2XwCbwNziKuTwZGfs40d59nEaNuRc1i+ggnXAKCTOV+8ZFSVrthK49Cn+RvIEW9Oe5
        wMbAA3ROBLlqBg9qozih0qkLW2F5vqCX5Jfy9fV6okn2JVNAL53ifWeLAUA9uGy58Jydt6JbhstR+
        gqNJunJOz+PRNum3XOzjVU11t3277u9XT2pIhWRKJ4jm8A/UaKVWSq/NsQWEPFTNKopCGUG8f4ern
        733v0eIOV/tnWdvMNjJsazFGaxfu491xEs2mreCWY9HCT8stmHqsHh0YEJKGCJu3UIFSceDlh1hOx
        QBdffHrcQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fanvp-0000CU-Qv; Wed, 04 Jul 2018 19:59:17 +0000
To:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] kbuild: delete INSTALL_FW_PATH from kbuild documentation
Message-ID: <6477e1be-6686-582b-35b5-72e9f677619f@infradead.org>
Date:   Wed, 4 Jul 2018 12:59:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Removed Kbuild documentation for INSTALL_FW_PATH.

The kbuild symbol INSTALL_FW_PATH was removed from Kbuild tools in
September 2014 (for 4.14) but the symbol was not deleted from
the kbuild documentation, so do that now.

Fixes: 5620a0d1aac ("firmware: delete in-kernel firmware")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: stable@vger.kernel.org # 4.14 and later
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/kbuild/kbuild.txt |    9 ---------
 1 file changed, 9 deletions(-)

--- linux-next-20180704.orig/Documentation/kbuild/kbuild.txt
+++ linux-next-20180704/Documentation/kbuild/kbuild.txt
@@ -149,15 +149,6 @@ stripped after they are installed.  If I
 the default option --strip-debug will be used.  Otherwise,
 INSTALL_MOD_STRIP value will be used as the options to the strip command.
 
-INSTALL_FW_PATH
---------------------------------------------------
-INSTALL_FW_PATH specifies where to install the firmware blobs.
-The default value is:
-
-    $(INSTALL_MOD_PATH)/lib/firmware
-
-The value can be overridden in which case the default value is ignored.
-
 INSTALL_HDR_PATH
 --------------------------------------------------
 INSTALL_HDR_PATH specifies where to install user space headers when



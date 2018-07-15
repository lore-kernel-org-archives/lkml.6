Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93670ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 17:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFA9208EA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 17:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FwqmKf9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFA9208EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeGORzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 13:55:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeGORzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 13:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UJV2aNSacZ7n2QUc6nmSqxOziviyAL2oUcXWdCQgnF0=; b=FwqmKf9coziB7wbhv21sU5wiG
        Ll8eWaB5/B83mWc6goCn9Qat6OV1QaQ4gjspmt3rnnKkO6uBvmGhAP9IfWC3SS4ZBN6cF+MLw7gIJ
        kqRrRiShfDmVYgacwXXJXsseewifVigi5hLUBzDcbIlN4w4RkVnFRoTRL/a8It+LFclBy/YwgxAsG
        R8zNLD3xxEeO8iDO9JWITJ38WHGpdofhdaWvLYz6A7U58pCH/qRwHnz1QtIHgZc4sBhCWyjdeCwMq
        l1k4YRMnlQq0Upqd3jeeE5182EGAqDJKigjVIFE7KGs/m67i6V7DLTiBxk/BEDPDeIoFUoolngJQK
        5JzyTMFjA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fekrq-0002FF-Vj; Sun, 15 Jul 2018 17:31:31 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] sysfs.h: fix non-kernel-doc comment
Message-ID: <2a60601b-7c74-3cdc-94b7-068001b06dd3@infradead.org>
Date:   Sun, 15 Jul 2018 10:31:28 -0700
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

Don't use "/**" to begin this comment block since it is not a
kernel-doc comment block.

Also adjust comment line to fit in 80 characters.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 include/linux/sysfs.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- lnx-418-rc4.orig/include/linux/sysfs.h
+++ lnx-418-rc4/include/linux/sysfs.h
@@ -91,9 +91,9 @@ struct attribute_group {
 	struct bin_attribute	**bin_attrs;
 };
 
-/**
- * Use these macros to make defining attributes easier. See include/linux/device.h
- * for examples..
+/*
+ * Use these macros to make defining attributes easier.
+ * See include/linux/device.h for examples..
  */
 
 #define SYSFS_PREALLOC 010000


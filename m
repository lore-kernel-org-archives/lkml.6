Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D323EECDE44
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9965F2087D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="O6YIsquY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9965F2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeJGElc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 00:41:32 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55210 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725778AbeJGElc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 00:41:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D74D08EE2BB;
        Sat,  6 Oct 2018 14:36:40 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yxbp5bBTMtCZ; Sat,  6 Oct 2018 14:36:40 -0700 (PDT)
Received: from [153.66.254.242] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8180D8EE2AF;
        Sat,  6 Oct 2018 14:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1538861800;
        bh=+QZvj6P8lk4CV34tCDcay5eaAzK83wNjmcG0cheCoLc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=O6YIsquY+fOJzAIwtoqwMChcTGR7G82VApbOhsZ+g5qT6Ok/zybATJgZHSobsJXzH
         8NT1GjGcO4pBA76hVF7VQS7u+Ll/DBG9VktcgA4MpahYvupMD9fJ/27IDWS2AzZvZl
         J/ynczCh5e9w1ljKss0/Xhqb7CuhWdMUln67ZqrM=
Message-ID: <1538861799.4088.6.camel@HansenPartnership.com>
Subject: [PATCH 1/2] code-of-conduct: Fix the ambiguity about collecting
 email addresses
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 06 Oct 2018 14:36:39 -0700
In-Reply-To: <1538861738.4088.5.camel@HansenPartnership.com>
References: <1538861738.4088.5.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 4a614e9440148894207bef5bf69e74071baceb3b Mon Sep 17 00:00:00 2001
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Sat, 6 Oct 2018 14:21:56 -0700
Subject: [PATCH 1/2] code-of-conduct: Fix the ambiguity about collecting email
 addresses

The current code of conduct has an ambiguity in the it considers publishing
private information such as email addresses unacceptable behaviour.  Since
the Linux kernel collects and publishes email addresses as part of the patch
process, add an exception clause for email addresses ordinarily collected by
the project to correct this ambiguity.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 Documentation/process/code-of-conduct.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
index ab7c24b5478c..aa40e34e7785 100644
--- a/Documentation/process/code-of-conduct.rst
+++ b/Documentation/process/code-of-conduct.rst
@@ -31,7 +31,7 @@ Examples of unacceptable behavior by participants include:
 * Trolling, insulting/derogatory comments, and personal or political attacks
 * Public or private harassment
 * Publishing others’ private information, such as a physical or electronic
-  address, without explicit permission
+  address not ordinarily collected by the project, without explicit permission
 * Other conduct which could reasonably be considered inappropriate in a
   professional setting
 
-- 
2.13.7


Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7583C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6306C21736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jCU1lfUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfBSAed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 19:34:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfBSAec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 19:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:To:From:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MuSagUH5XPEJCwh3elDPVuxbyPPp7iyK4WfM21b8kCM=; b=jCU1lfUGNYi6QWT28N6jUS82P
        iSX2/NoVZVaojzE1rJLuq3vZra11oaOMfWDCCVjq65qRmIWfDUMU31BW6a7uwPXv9QIOWKzHfRgN/
        zyjqfHl9kFUasjrVXDbTQonmUH4+IzrQ2RFyZW1KDxUSKH9YVSFSiqsa8lnl6raSx0rP4ateVxZnR
        qf1h+RHJQvfdbGzkmNV0UAXNMEPFhXP4DFTiOhAHbIHOgG3js9HqfE0OmB6/E0bOjS6C253He50xJ
        Pz3jaXCUXYPojg+OCWYeWhrQzgZwGVjyXmYltQs/OtU1g81rzJCgIm41vDA4k/IVSDU5MIjaFf0ER
        0Lb34n4cg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvtMl-0003Nc-B9; Tue, 19 Feb 2019 00:34:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] linux/kernel.h: fix reST markup warning for roundup
Message-ID: <e79e49d4-4a7d-48c6-afdf-0f958f423f62@infradead.org>
Date:   Mon, 18 Feb 2019 16:34:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix reST inline markup warning:

../include/linux/kernel.h:137: WARNING: Inline interpreted text or phrase reference start-string without end-string.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 include/linux/kernel.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20190218.orig/include/linux/kernel.h
+++ linux-next-20190218/include/linux/kernel.h
@@ -108,7 +108,7 @@
  * Rounds @x up to next multiple of @y. If @y will always be a power
  * of 2, consider using the faster round_up().
  *
- * The `const' here prevents gcc-3.3 from calling __divdi3
+ * The ``const`` here prevents gcc-3.3 from calling __divdi3
  */
 #define roundup(x, y) (					\
 {							\



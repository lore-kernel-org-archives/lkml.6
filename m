Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CC2ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9390E214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jHaNPen6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9390E214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeJTJTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:19:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49074 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeJTJTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=85nIwNDxq55n7RSHpITgtwkG2TZpwJvyQ6+CTRRpEYs=; b=jHaNPen68G+2Dirq9B7mPaGgGG
        A2zKseivgtBkPVkBLGRcJzTIF1FFg3j/qF7GHISpw1ygJYwM28uCxGY8/MsPaZMRHjbpFuSZd0a+B
        tHykDQ0P0dWHhoO9lEsgAA49AULPeR7ZY7Go2cV6Oh0h0zsmyf+s8ohp9QlyV9RUsJyWFVkKXJDP1
        u3935ITjk5O85ULptgn5fjTI+PHmzoHqWkSHEzAJQANl7GSDLiggOadciOOz4iktZJIcYn/roqKr5
        JTsla2fnlIVgTpsXwFARBGfMPxzP38ic0ZB0jUzbvY8iRyYfPIpE2JbmCMFeXNBuCBxjMgq3ajHbJ
        dPyEqhBA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDfn9-0001SH-Li; Sat, 20 Oct 2018 01:11:00 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Jason Baron <jbaron@akamai.com>, Will Korteland <will@korte.land>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] Documentation: dynamic-debug: fix wildcard description
Message-ID: <c3bedde3-4653-f66d-c30f-4772d3d8bae2@infradead.org>
Date:   Fri, 19 Oct 2018 18:10:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix grammar about wildcards and insert a space between sentences.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Will Korteland <will@korte.land>
---
v2: s/A another/Another/ # from Will

 Documentation/admin-guide/dynamic-debug-howto.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lnx-419-rc8.orig/Documentation/admin-guide/dynamic-debug-howto.rst
+++ lnx-419-rc8/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -110,8 +110,8 @@ If your query set is big, you can batch
 
   ~# cat query-batch-file > <debugfs>/dynamic_debug/control
 
-A another way is to use wildcard. The match rule support ``*`` (matches
-zero or more characters) and ``?`` (matches exactly one character).For
+Another way is to use wildcards. The match rule supports ``*`` (matches
+zero or more characters) and ``?`` (matches exactly one character). For
 example, you can match all usb drivers::
 
   ~# echo "file drivers/usb/* +p" > <debugfs>/dynamic_debug/control



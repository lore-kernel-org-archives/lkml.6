Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E8CECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C49C20C01
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jUs9hXNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C49C20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJTID7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 04:03:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48778 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbeJTID7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 04:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=u865q4kRFH65IiCFJeJ/orv4tGFA1Q4k3KsjMAJEtUk=; b=jUs9hXNF1dgg3VJheSciv/8i06
        S7dqDt2pKBSq3xT6aEEbghNHE3aIkBz25H/11NtzW28yU2PuZohj1N808JANCEnai9MQ48PkJ3ui2
        dw3GtmnskIeM16BMAMXCHpnKRJp9LBRJsdv3LjWMKGKS5l7j0squRyD9bv8KTp1p1/WRykjphLBEL
        cuswwEZfhgR5ucHwdKvWR9JVoRWLsmR/zfmnkWbuxOlt0tysUl3EL///lqkVCV762eUYMz/eFKUPw
        40mUz0M+d5w7An8+EOe9UBjnTYyAofukGw6fZtaaorNgDIqBnsinPrukBIh97pl+1WolNgNbtrRDf
        aoZzuQtw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDecD-0001L2-Il; Fri, 19 Oct 2018 23:55:37 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Jason Baron <jbaron@akamai.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: dynamic_debug: fix a couple of typos
Message-ID: <73dabf1e-e6a5-2c4e-9495-289953fa510f@infradead.org>
Date:   Fri, 19 Oct 2018 16:55:34 -0700
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

Fix a few "typos" in dynamic-debug-howto.rst.

s/dyndbg_query/ddebug_query/
s/sysfs/debugfs/

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/admin-guide/dynamic-debug-howto.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lnx-419-rc8.orig/Documentation/admin-guide/dynamic-debug-howto.rst
+++ lnx-419-rc8/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -258,7 +258,7 @@ this boot parameter for debugging purpos
 
 If ``foo`` module is not built-in, ``foo.dyndbg`` will still be processed at
 boot time, without effect, but will be reprocessed when module is
-loaded later. ``dyndbg_query=`` and bare ``dyndbg=`` are only processed at
+loaded later. ``ddebug_query=`` and bare ``dyndbg=`` are only processed at
 boot.
 
 
@@ -301,7 +301,7 @@ The ``dyndbg`` option is a "fake" module
 
 For ``CONFIG_DYNAMIC_DEBUG`` kernels, any settings given at boot-time (or
 enabled by ``-DDEBUG`` flag during compilation) can be disabled later via
-the sysfs interface if the debug messages are no longer needed::
+the debugfs interface if the debug messages are no longer needed::
 
    echo "module module_name -p" > <debugfs>/dynamic_debug/control
 



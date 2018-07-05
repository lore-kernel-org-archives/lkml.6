Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3A8C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44F124069
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HsXxmC8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44F124069
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753362AbeGECrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:47:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43236 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbeGECrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V/HFZ5NWv/p3t1crZ9G91fh6TY4vcTzEkqOwJD8woDs=; b=HsXxmC8soATl3Ftk55uJz7iRW
        tJqR0oIfx7/b6XqNqeKyTvXauBswD7GHI5W+w5h0e+Z1vdm6bhYfIUNZh27Ia3bGmFf3WN3lzrK16
        OZ8IevjvaYuhU3FdDFWA+vtJVLajYiZR8mThmhQ8xYrBaacvc2hvjreq/n2sDYyoGML3ohIDQHwWB
        653Y80S2sDuBWoa55Bi5rzUoqkL4KlVsmtOAcZJj/NqKDnMaFOERF4NMKNGIiIvmogj3mCLtMHdjb
        uMGVG784fJY7INBsrKN6hha/ueBHkJBJ4vnZo5v79RPlX/JBrNnTM53jb4Zh3ILLSH4mrVoMlvU5G
        Huzhr+06Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fauJ1-00062D-Tc; Thu, 05 Jul 2018 02:47:39 +0000
To:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] kbuild: document the KBUILD_KCONFIG env. variable
Message-ID: <70d08f42-27e4-ccc2-00f6-266568123d8c@infradead.org>
Date:   Wed, 4 Jul 2018 19:47:39 -0700
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

Add usage info for the Kbuild environment variable KBUILD_KCONFIG.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/kbuild/kbuild.txt |    5 +++++
 1 file changed, 5 insertions(+)

--- lnx-418-rc3.orig/Documentation/kbuild/kbuild.txt
+++ lnx-418-rc3/Documentation/kbuild/kbuild.txt
@@ -50,6 +50,11 @@ LDFLAGS_MODULE
 --------------------------------------------------
 Additional options used for $(LD) when linking modules.
 
+KBUILD_KCONFIG
+--------------------------------------------------
+Set the top-level Kconfig file to the value of this environment
+variable.  The default name is "Kconfig".
+
 KBUILD_VERBOSE
 --------------------------------------------------
 Set the kbuild verbosity. Can be assigned same values as "V=...".



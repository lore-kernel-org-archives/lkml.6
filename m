Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B002C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451E6208AF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mWJe7dfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451E6208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757022AbeFQCCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:02:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933349AbeFQCCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VLoZ0nExZaV7bi903v5RBgJocAea+K18TMM60l7Ys10=; b=mWJe7dfS9Dz7Jnn9cyk21y+Wl
        CFAtaxWkCEHSdBF4FIwgD0V2QCbmE7HpO5gT8Jq6likhO95cT4Zq9xwVOREHYXRsvYaGseVuj8bum
        YoSlTwF4Yy1IIYf1GaB3IPoRfj/ozNcF/6zVqNeycadfcm1QLNWqPhRMX+htwRbnuDYt6kK4ClGA8
        P14DiSbC0hTFVjWWgyZArl4MT76NrB1+SNtmbJS2WTcGX9aU+eDlVh7iUOpQ5/DpZfbZ0xEVWV5jh
        C9Tf99B06KgVevGL3yfs3sKdJOJ7skdb9nUGn36URZS9EWyFSqQz8EV3oNXkupq4oOtfiHE1j+CWa
        SyAhCjgeg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUN12-0001pI-4o; Sun, 17 Jun 2018 02:02:04 +0000
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Tim Bird <tbird20d@gmail.com>, LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation/process: fix reST table border error
Message-ID: <727cda41-e8e5-06f5-ae54-3e91571fa6ac@infradead.org>
Date:   Sat, 16 Jun 2018 19:02:03 -0700
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

Fix reST error in Documentation/process/:

Documentation/process/2.Process.rst:131: ERROR: Malformed table.
Bottom/header table border does not match top border.

Fixes: 8962e40c1993 ("docs: update kernel versions and dates in tables")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Tim Bird <tbird20d@gmail.com>
---
 Documentation/process/2.Process.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-418-rc1.orig/Documentation/process/2.Process.rst
+++ lnx-418-rc1/Documentation/process/2.Process.rst
@@ -134,7 +134,7 @@ and their maintainers are:
 	4.4	Greg Kroah-Hartman	(very long-term stable kernel)
 	4.9	Greg Kroah-Hartman
 	4.14	Greg Kroah-Hartman
-	======  ======================  ===========================
+	======  ======================  ==============================
 
 The selection of a kernel for long-term support is purely a matter of a
 maintainer having the need and the time to maintain that release.  There



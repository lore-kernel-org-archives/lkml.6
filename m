Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F5EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 04:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1013521523
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 04:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BQAq8G3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1013521523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbeHQHKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 03:10:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33340 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbeHQHKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 03:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cxqgqBH5HQeMEDXqTjWL5mdZdRcS0bCSs6jjj9gkJ3Y=; b=BQAq8G3DzDu/KjS0v3eo3AJuY
        tF/rRVwzvhG3WNcct9nh5O2efnqgYtgpJm6I/TQjiykKWGvlqWwF4qkzvL5aHUCFf6g+iIXGNRTsP
        WkGIPZXpUDToY2HQ7dsg1uVSEfUWsdQ6CXdiLgybYUNlXrhznfAZD+Z/xHmvEU/MAufQH7X1znxGO
        Dt5I7BxLWt8MsDE4TFs0sm8DcBOVlhHXBeD+kKqI/hNOpOOQfIk4a6vm2UTNzkb7BC30L+elgNqST
        4wDpgpb3wsMAYnhIro4JN57Baood97NTUEyqoEKYCrZMR7B6a0LcxzQzjjnHzvTsE9MPCLJ4VmHDJ
        EO5RFnATg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fqW4M-0008Tx-9f; Fri, 17 Aug 2018 04:09:02 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] faddr2line: fix path name comment
Message-ID: <a2aa8e29-a551-8e53-b9e5-80925b6f6428@infradead.org>
Date:   Thu, 16 Aug 2018 21:09:00 -0700
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

Fix a source file reference location to the correct path name.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
 scripts/faddr2line |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-418.orig/scripts/faddr2line
+++ lnx-418/scripts/faddr2line
@@ -71,7 +71,7 @@ die() {
 
 # Try to figure out the source directory prefix so we can remove it from the
 # addr2line output.  HACK ALERT: This assumes that start_kernel() is in
-# kernel/init.c!  This only works for vmlinux.  Otherwise it falls back to
+# init/main.c!  This only works for vmlinux.  Otherwise it falls back to
 # printing the absolute path.
 find_dir_prefix() {
 	local objfile=$1



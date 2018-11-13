Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F866C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A192243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=net.com.org.es header.i=@net.com.org.es header.b="OLo8N0LQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A192243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=net.com.org.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbeKMQb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:31:59 -0500
Received: from delany.relativists.org ([176.31.98.17]:48258 "EHLO
        delany.relativists.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeKMQb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 11:31:59 -0500
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Nov 2018 11:31:59 EST
Received: from geertz.rel (geertz.rel [192.168.82.3])
        by delany.relativists.org (Postfix) with ESMTPSA id AB376334;
        Tue, 13 Nov 2018 03:28:55 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=net.com.org.es;
        s=delany-v1; t=1542090535;
        bh=/rgSE1V5F5ZppPzmMzRzcRlqszxkIy6pRKrTJLgEPMk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type:From;
        b=OLo8N0LQuEHyBUi3T2vZjZlD0b03E1S+B4xJBOIKphMF9wLYC3sPmla8hh34H6Ppx
         cqllIVV5bc1NifWuND1Cwec9lI7sIpS6ZLk5BFAWZYAAhdwBB3j0unvjtZmHi1XVhj
         ouwB/7/3IeHOjbXancdBt5HLK9gcBwT+IC33A8Uc=
Received: by geertz.rel (Postfix, from userid 1000)
        id 9ECC47FE3F; Tue, 13 Nov 2018 03:28:53 -0300 (-03)
From:   =?UTF-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        v9fs-developer@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/9p: include trans_common.h to fix missing prototype warning.
Date:   Tue, 13 Nov 2018 03:28:53 -0300
Message-Id: <b1c4df8f21689b10d451c28fe38e860722d20e71.1542089696.git.dato@net.com.org.es>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113055324.GB5116@nautica>
References: <20181113055324.GB5116@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This silences -Wmissing-prototypes when defining p9_release_pages.

Signed-off-by: Adeodato Simó <dato@net.com.org.es>
---
 net/9p/trans_common.c | 1 +
 1 file changed, 1 insertion(+)

It was suggested in the kernel-janitors mailing list that silencing
-Wmissing-prototypes would make for a worthy cause.

https://www.spinics.net/lists/linux-kernel-janitors/msg43981.html

Resending w/ Cc: linux-kernel as requested by Dominique.

diff --git a/net/9p/trans_common.c b/net/9p/trans_common.c
index b718db2085b2..3dff68f05fb9 100644
--- a/net/9p/trans_common.c
+++ b/net/9p/trans_common.c
@@ -14,6 +14,7 @@
 
 #include <linux/mm.h>
 #include <linux/module.h>
+#include "trans_common.h"
 
 /**
  *  p9_release_pages - Release pages after the transaction.
-- 
2.19.1


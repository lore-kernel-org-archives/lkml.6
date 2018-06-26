Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC97C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297A226D6B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297A226D6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbeFZP7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:59:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752569AbeFZP7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:59:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0ADB808255B;
        Tue, 26 Jun 2018 15:59:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-238.rdu2.redhat.com [10.10.120.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 108072026E0E;
        Tue, 26 Jun 2018 15:59:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/3] certs/blacklist: fix const confusion
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     dhowells@redhat.com, linux-security-module@vger.kernel.org,
        keyrings@vger.kernel.org,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 26 Jun 2018 16:59:40 +0100
Message-ID: <153002878055.31726.289273416003704588.stgit@warthog.procyon.org.uk>
In-Reply-To: <153002876741.31726.8580751276453556884.stgit@warthog.procyon.org.uk>
References: <153002876741.31726.8580751276453556884.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 26 Jun 2018 15:59:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 26 Jun 2018 15:59:41 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Desaulniers <nick.desaulniers@gmail.com>

Fixes commit 2be04df5668d ("certs/blacklist_nohashes.c: fix const confusion
in certs blacklist")

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 certs/blacklist.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/blacklist.h b/certs/blacklist.h
index 150d82da8e99..1efd6fa0dc60 100644
--- a/certs/blacklist.h
+++ b/certs/blacklist.h
@@ -1,3 +1,3 @@
 #include <linux/kernel.h>
 
-extern const char __initdata *const blacklist_hashes[];
+extern const char __initconst *const blacklist_hashes[];


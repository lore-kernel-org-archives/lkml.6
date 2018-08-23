Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CE4C43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF6C2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF6C2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbeHWMAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:00:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48070 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730656AbeHWMAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:00:37 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6C67D8B1;
        Thu, 23 Aug 2018 08:32:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 176/217] tools: build: Use HOSTLDFLAGS with fixdep
Date:   Thu, 23 Aug 2018 09:54:49 +0200
Message-Id: <20180823075513.539312604@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Laura Abbott <labbott@redhat.com>

[ Upstream commit 8b247a92ebd0cda7dec49a6f771d9c4950f3d3ad ]

The final link of fixdep uses LDFLAGS but not the existing HOSTLDFLAGS.
Fix this.

Signed-off-by: Laura Abbott <labbott@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/build/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -43,7 +43,7 @@ $(OUTPUT)fixdep-in.o: FORCE
 	$(Q)$(MAKE) $(build)=fixdep
 
 $(OUTPUT)fixdep: $(OUTPUT)fixdep-in.o
-	$(QUIET_LINK)$(HOSTCC) $(LDFLAGS) -o $@ $<
+	$(QUIET_LINK)$(HOSTCC) $(HOSTLDFLAGS) -o $@ $<
 
 FORCE:
 



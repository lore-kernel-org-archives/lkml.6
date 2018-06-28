Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF798C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8A427372
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="PNU0XTYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8A427372
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965949AbeF1MrK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:47:10 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:2169 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933945AbeF1MrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1530190028; x=1561726028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=rvBVN9SXnwwMBJu2G4VrvWnZK+TM7FK5Gl+oQyuFEYc=;
  b=PNU0XTYkD11UF7pWovDE8FCKiGEb66qis4HmnpOIw39z3rABTbOnEis/
   HdRbdXZ8SlRQ1wENb1VIfVo+aHUImvkWZCnvb8U9+j3Rh3uASd3Cv0KMW
   2+EG9t5p0VhpnGZJP4Za5K80WBG8CkKebuRpHnSG7lbwvwHkmJS2cNSCD
   c=;
X-IronPort-AV: E=Sophos;i="5.51,283,1526342400"; 
   d="scan'208";a="726297680"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Jun 2018 12:47:06 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5SCl2dR032011
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 28 Jun 2018 12:47:05 GMT
Received: from EX13D02EUB001.ant.amazon.com (10.43.166.150) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 28 Jun 2018 12:46:57 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D02EUB001.ant.amazon.com (10.43.166.150) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 28 Jun 2018 12:46:56 +0000
Received: from uc1a35a69ae4659.ant.amazon.com (10.28.85.80) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 28 Jun 2018 12:46:54 +0000
From:   Norbert Manthey <nmanthey@amazon.de>
To:     Norbert Manthey <nmanthey@amazon.de>,
        <linux-kernel@vger.kernel.org>
CC:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, "Josef Bacik" <jbacik@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [less-CONFIG_NET v2 7/8] seccomp: drop CONFIG_NET
Date:   Thu, 28 Jun 2018 14:45:35 +0200
Message-ID: <1530189936-25780-8-git-send-email-nmanthey@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530189936-25780-1-git-send-email-nmanthey@amazon.de>
References: <ef0fe0ef-3620-3628-2a7e-c8b73e466a21@amazon.de>
 <1530189936-25780-1-git-send-email-nmanthey@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the goal of dropping CONFIG_NET, we have to drop the dependency
in the configuration management. Since SECCOMP_FILTER also requires
BPF functionality, which is usually activated by CONFIG_NET, imply
BPF from SECCOMP_FILTER directly.

In case both CONFIG_NET and CONFIG_SECCOMP_FILTER are activated, BPF
will be activated as well, so this additional dependency does not
destroy original builds.

Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
---
 arch/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 1aa5906..8cfb634 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -397,7 +397,8 @@ config HAVE_ARCH_SECCOMP_FILTER
 
 config SECCOMP_FILTER
 	def_bool y
-	depends on HAVE_ARCH_SECCOMP_FILTER && SECCOMP && NET
+	depends on HAVE_ARCH_SECCOMP_FILTER && SECCOMP
+	select BPF
 	help
 	  Enable tasks to build secure computing environments defined
 	  in terms of Berkeley Packet Filter programs which implement
-- 
2.7.4

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B


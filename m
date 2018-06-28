Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90E2C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9766D2736E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="gzcnDh6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9766D2736E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965931AbeF1Mqn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:46:43 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:36231 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965899AbeF1Mqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1530189999; x=1561725999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=xHoURDxwRabgC0TRe+fgzKBp+lgnKj+HuVv2ouGbyP0=;
  b=gzcnDh6H7yJkgviWxNPVN4zmghVsgeLQXcW/rZk2qO4FjgctDiUMTkZ8
   dHJpDho6fzaJXLiaJlwB0VJl7jq6WobjUcUyG8yhe8KAUNjzUWuplnJEb
   IBVQtv2AIXh7XdyIGyA/WgGgxcfIShEMx5abdqPmM4Fy6TQWDvBJLYSTW
   4=;
X-IronPort-AV: E=Sophos;i="5.51,283,1526342400"; 
   d="scan'208";a="740115570"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Jun 2018 12:46:39 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5SCka0m090020
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 28 Jun 2018 12:46:38 GMT
Received: from EX13D02EUB002.ant.amazon.com (10.43.166.170) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 28 Jun 2018 12:46:37 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D02EUB002.ant.amazon.com (10.43.166.170) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 28 Jun 2018 12:46:37 +0000
Received: from uc1a35a69ae4659.ant.amazon.com (10.28.85.80) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 28 Jun 2018 12:46:35 +0000
From:   Norbert Manthey <nmanthey@amazon.de>
To:     Norbert Manthey <nmanthey@amazon.de>,
        <linux-kernel@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>
Subject: [less-CONFIG_NET v2 3/8] seccomp: include net
Date:   Thu, 28 Jun 2018 14:45:31 +0200
Message-ID: <1530189936-25780-4-git-send-email-nmanthey@amazon.de>
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

When we want to use CONFIG_SECCOMP_FILTER without CONFIG_NET, we have
to ensure that the required files that would be pulled in via
CONFIG_NET are compiled when dropping CONFIG_NET.

Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
---
 kernel/bpf/Makefile | 1 +
 net/Makefile        | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index f27f549..16936c0 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o
 obj-$(CONFIG_BPF_SYSCALL) += btf.o
+
 ifeq ($(CONFIG_NET),y)
 obj-$(CONFIG_BPF_SYSCALL) += devmap.o
 obj-$(CONFIG_BPF_SYSCALL) += cpumap.o
diff --git a/net/Makefile b/net/Makefile
index 13ec0d5..f3fb03a 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -11,6 +11,11 @@ obj-$(CONFIG_NET)		:= socket.o core/
 tmp-$(CONFIG_COMPAT) 		:= compat.o
 obj-$(CONFIG_NET)		+= $(tmp-y)
 
+ifneq ($(CONFIG_NET),y)
+obj-$(CONFIG_SECCOMP_FILTER)    += core/filter.o
+obj-$(CONFIG_SECCOMP_FILTER)    += core/flow_dissector.o
+endif
+
 # LLC has to be linked before the files in net/802/
 obj-$(CONFIG_LLC)		+= llc/
 obj-$(CONFIG_NET)		+= ethernet/ 802/ sched/ netlink/ bpf/
-- 
2.7.4

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B


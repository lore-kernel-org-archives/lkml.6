Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF77C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EEB20672
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731922AbeLQMly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:41:54 -0500
Received: from relay.sw.ru ([185.231.240.75]:43408 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbeLQMlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:41:53 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gYsDT-0007ol-7O; Mon, 17 Dec 2018 15:41:47 +0300
Subject: [PATCH] scripts/tags: Add more declarations
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        const@MakeLinux.com, ktkhai@virtuozzo.com, joeypabalinas@gmail.com,
        willy@infradead.org, arend.vanspriel@broadcom.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 17 Dec 2018 15:41:46 +0300
Message-ID: <154505048571.504.18330420599768007443.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New declarations and identifier (__always_inline).

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 scripts/tags.sh |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 4fa070f9231a..f470d9919ed7 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -191,7 +191,7 @@ regex_c=(
 	'/^DEF_PCI_AC_\(\|NO\)RET(\([[:alnum:]_]*\).*/\2/'
 	'/^PCI_OP_READ(\(\w*\).*[1-4])/pci_bus_read_config_\1/'
 	'/^PCI_OP_WRITE(\(\w*\).*[1-4])/pci_bus_write_config_\1/'
-	'/\<DEFINE_\(MUTEX\|SEMAPHORE\|SPINLOCK\)(\([[:alnum:]_]*\)/\2/v/'
+	'/\<DEFINE_\(RT_MUTEX\|MUTEX\|SEMAPHORE\|SPINLOCK\)(\([[:alnum:]_]*\)/\2/v/'
 	'/\<DEFINE_\(RAW_SPINLOCK\|RWLOCK\|SEQLOCK\)(\([[:alnum:]_]*\)/\2/v/'
 	'/\<DECLARE_\(RWSEM\|COMPLETION\)(\([[:alnum:]_]\+\)/\2/v/'
 	'/\<DECLARE_BITMAP(\([[:alnum:]_]*\)/\1/v/'
@@ -204,6 +204,15 @@ regex_c=(
 	'/\(^\s\)OFFSET(\([[:alnum:]_]*\)/\2/v/'
 	'/\(^\s\)DEFINE(\([[:alnum:]_]*\)/\2/v/'
 	'/\<\(DEFINE\|DECLARE\)_HASHTABLE(\([[:alnum:]_]*\)/\2/v/'
+	'/\<DEFINE_ID\(R\|A\)(\([[:alnum:]_]\+\)/\2/'
+	'/\<DEFINE_WD_CLASS(\([[:alnum:]_]\+\)/\1/'
+	'/\<ATOMIC_NOTIFIER_HEAD(\([[:alnum:]_]\+\)/\1/'
+	'/\<RAW_NOTIFIER_HEAD(\([[:alnum:]_]\+\)/\1/'
+	'/\<DECLARE_FAULT_ATTR(\([[:alnum:]_]\+\)/\1/'
+	'/\<BLOCKING_NOTIFIER_HEAD(\([[:alnum:]_]\+\)/\1/'
+	'/\<DEVICE_ATTR_\(RW\|RO\|WO\)(\([[:alnum:]_]\+\)/dev_attr_\2/'
+	'/\<DRIVER_ATTR_\(RW\|RO\|WO\)(\([[:alnum:]_]\+\)/driver_attr_\2/'
+	'/\<\(DEFINE\|DECLARE\)_STATIC_KEY_\(TRUE\|FALSE\)\(\|_RO\)(\([[:alnum:]_]\+\)/\4/'
 )
 regex_kconfig=(
 	'/^[[:blank:]]*\(menu\|\)config[[:blank:]]\+\([[:alnum:]_]\+\)/\2/'
@@ -249,7 +258,7 @@ exuberant()
 	-I __initdata,__exitdata,__initconst,__ro_after_init	\
 	-I __initdata_memblock					\
 	-I __refdata,__attribute,__maybe_unused,__always_unused \
-	-I __acquires,__releases,__deprecated			\
+	-I __acquires,__releases,__deprecated,__always_inline	\
 	-I __read_mostly,__aligned,____cacheline_aligned        \
 	-I ____cacheline_aligned_in_smp                         \
 	-I __cacheline_aligned,__cacheline_aligned_in_smp	\


Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD4DC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9602168B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9602168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933891AbeGFUUK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:20:10 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:33093 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932328AbeGFUUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:20:08 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LqlM2-1g5exT1tRq-00eNrm; Fri, 06 Jul 2018 22:19:25 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Omar Sandoval <osandov@fb.com>,
        Ming Lei <ming.lei@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] sbitmap, scsi/target: add seq_file forward declaration
Date:   Fri,  6 Jul 2018 22:19:07 +0200
Message-Id: <20180706201920.2185565-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:gFLHbI4SRZKu7sStNHVecPi+UOtkhZ+hdXsQ2znEm66YVUlsntB
 ulVjcxVsbxzROTPA28V38wSS6Ntl7+3aXErFJUEm6W4xjZeU+mQgJhrxkhBf9StOoiHXou4
 WKx3uudT2YK5KiJd8vf12IWGw80hbbxbxCb3s/MgyxzWAZbPTHU3hhRIiEgWP8Sp/0Dz3lz
 YGv8yEH4YiLXUdToLRdHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r3leehaQw6o=:nNNvtjeraBL8bHXSUymWNG
 UtkKfhslqlELGUHHtkvlxcQ7WvGT/D2g1X/qi/01M0RBoX+6GIKRn6a9N6pCvxlwha8l6h/N/
 ut+12PfAs2OaSxhHlYropQgrfsEGFOlTgPoVxDAwMlT3IdSF5IUJNSR2Cf6Q7c3+SVskusrgP
 sim6cR/e01RqzSorj9krr4lO07mMcJqR7/XcylESQa94qYXIDFjiqMoxN4KbHOdwKG+683uV7
 8jcRdGG0QuQMH1NsB3iS+jJP8WKA9Fx3qRhWPTXy561inz/ANoQFhMXnBv9Ok2/d5pohISMk3
 U3Ak+bkw2Qr/SAZuhfV8ZWRn1mVnPqTziCs2Sgqx7M1so+ec14S468hJDUqB9FYkZI1oLqPKF
 EJEfTA3eEu1Fr1+rlxnE/P374XMrsO/y6okijH+UOuhGjH1YAIZnzJesjpdSfo++ubtxHIDG5
 Pmh8JFyV84/vybvstmU6ABwdKWOJChdaCDQ57999Dv0vC9zwajmxnZpJ/VUT+gntn7CZrxrIc
 w2+L0UPmj6LLEeXPTitl5fjMmiUsQZtTc0aOGr2yqkjky0Oh0PX6D9ySbOLZHnECefIdgGd8F
 mnOo6qAkPb/yZy+pOtg+EjgRS9x/J7xu0OHQFuRspKqMp7U7yVFjDNcw026kCfNnIa9tHGXZi
 5d/IOClYansyNu2UwlR8iI7K0wjieOZWLUGoKNYcIBdpOI4cv9O0AM4OwAWCMZe1LBc0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The target core runs into a warning in the linux/sbitmap.h
file in some configurations:

In file included from include/target/target_core_base.h:7,
                 from drivers/target/target_core_fabric_lib.c:41:
include/linux/sbitmap.h:331:46: error: 'struct seq_file' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
 void sbitmap_show(struct sbitmap *sb, struct seq_file *m);
                                              ^~~~~~~~

In general, headers should not depend on others being included first,
so this fixes it with a forward declaration for that struct name, but
we probably want to merge the patch through the scsi tree to help
bisection.

Fixes: 10e9cbb6b531 ("scsi: target: Convert target drivers to use sbitmap")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: move declaration to the start of the header, as suggested by Bart
---
 include/linux/sbitmap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index e6539536dea9..804a50983ec5 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -23,6 +23,8 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 
+struct seq_file;
+
 /**
  * struct sbitmap_word - Word in a &struct sbitmap.
  */
-- 
2.9.0


Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8A9ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2FD2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2FD2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=skynet.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeJSQZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:25:14 -0400
Received: from mailrelay101.isp.belgacom.be ([195.238.20.128]:36171 "EHLO
        mailrelay101.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727366AbeJSQZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:25:14 -0400
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3AYsTFhxVsajMx/9vAz2YFLNqj38/V8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbR2Et8tkgFKBZ4jH8fUM07OQ7/i/HzRYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba9wIRmssQndqtQdjJd/JKo21h?=
 =?us-ascii?q?bHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2UbJXDDI9M2?=
 =?us-ascii?q?Ao/8LrrgXMTRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VD?=
 =?us-ascii?q?K/5KptVRTmijoINyQh/W/XlMJ+kaxVrhGmqRN9zY7Ze52ZOOZkc6/BZ94WWX?=
 =?us-ascii?q?ZNU8BMXCJBGIO8aI4PAvIBM+lCtIb9pkEBrR2jDgesHuPg1CJHiWHs3a07z+?=
 =?us-ascii?q?shEhzN0QsuH90Uq3vUos74NLwRUeG1yqnH0ynDY+lN1jjj8YXFdA0qr/KUXb?=
 =?us-ascii?q?9ocsfcy1MjGgLEg1mKq4HoOymZ2vkOvmWV6edrSPihhHQ9qw5rpzii3sIsio?=
 =?us-ascii?q?7UiY0L0l3E7iB5wJotJd2/VU57fcaoEJtOuCGeMIt7WsciQ2Z0tykgzr0GuZ?=
 =?us-ascii?q?m7fDMWyJg9wx7fbOCIfJKM4h3+U+aRJC13hHNjeL6nhhay91avyvHkW8S30l?=
 =?us-ascii?q?tGtCtIn9jWun0P0xHf8NWLR/hz80u53DaAzQHT6uVKIUAukqrbLoYswrAqmZ?=
 =?us-ascii?q?UIv0TOBTT2mEb2ja+QaEok5vKk5P/5bbn+vJ+TK5d0ih3iMqQpgsGwG+c4Mh?=
 =?us-ascii?q?ALX2WA/eS81bvj/VD2QblTgP02lbTZsJbHKssBuq65AghV0oA55xa4FTem38?=
 =?us-ascii?q?wSnWMbI1JdZBKHk4/pNknMIP/iDfewmU6skDR1yPDdJbDuHo7NImLfn7fkYL?=
 =?us-ascii?q?Zx8VBTxxcuzdpH/ZJbFqkBIO7vWk/2rNHXEhg5PBGuzOv8FNp9zZkSVn6KAq?=
 =?us-ascii?q?+EKq/dr0KH5v83KemWeIAVoCr9K+Qi5/P2iX85mFkdfbSm3JcOZnC4BelpLF?=
 =?us-ascii?q?uHYXXyhtcMCnkKvgUgQ+zwklGCUiBcZ2y0X60i4jE3EoWmDZ3MRoq1mryOwD?=
 =?us-ascii?q?+7HoFKZmBBEl2MFXbod4OZW/YDcS6SIdFukiYCVbe/T48szg+utADkxLp9NO?=
 =?us-ascii?q?bU+TMXtYjl1Ndr4+3fjxYy9SZ7D86FyWGCU3l0nn8URz8xxK1/r1ZyxUyN0a?=
 =?us-ascii?q?VjmPxYFtxS5/VXXQcmL5LT1PJ1WJjOXVfIfc+MYFKnRMi2RD82U9Q9ysMPZE?=
 =?us-ascii?q?A7HM+t3T7Z2C//LbYflrWNTLIu/67RxXn6JI4pxX/M2oE6jEggT9cJP2Dw1f?=
 =?us-ascii?q?03zBTaG4OcyxbRrK2tb6lJhCM=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AQAACMkslb/7dPQldjGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBUQYBAQELAYEIfIFTEiiMDV+NfgGIUI4JgXo4AYQ6BAIChQMiNA0?=
 =?us-ascii?q?NAQMBAQIBAQIBbCiCNiKCYgZWIxBROR4ZgyGBdRGoDYN9hieHLIQ6gUE/iGq?=
 =?us-ascii?q?BBIUNAp5BCYYhiksCFYFAjmksl2k4gVVNIBiDJ4ImF44cPTCBAwE9AYdlgk0?=
 =?us-ascii?q?BAQ?=
X-IPAS-Result: =?us-ascii?q?A2AQAACMkslb/7dPQldjGwEBAQEDAQEBBwMBAQGBUQYBA?=
 =?us-ascii?q?QELAYEIfIFTEiiMDV+NfgGIUI4JgXo4AYQ6BAIChQMiNA0NAQMBAQIBAQIBb?=
 =?us-ascii?q?CiCNiKCYgZWIxBROR4ZgyGBdRGoDYN9hieHLIQ6gUE/iGqBBIUNAp5BCYYhi?=
 =?us-ascii?q?ksCFYFAjmksl2k4gVVNIBiDJ4ImF44cPTCBAwE9AYdlgk0BAQ?=
Received: from 183.79-66-87.adsl-dyn.isp.belgacom.be (HELO localhost.localdomain) ([87.66.79.183])
  by relay.skynet.be with ESMTP; 19 Oct 2018 10:20:11 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     akpm@linux-foundation.org
Cc:     jaharkes@cs.cmu.edu, coda@cs.cmu.edu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        fabf@skynet.be
Subject: [PATCH 4/7 linux-next] coda: add __init to init_coda_psdev()
Date:   Fri, 19 Oct 2018 10:19:30 +0200
Message-Id: <1539937173-26260-5-git-send-email-fabf@skynet.be>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1539937173-26260-1-git-send-email-fabf@skynet.be>
References: <1539937173-26260-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_coda_psdev() was only called by __init function.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/coda/psdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index cbdddf4..6d1c95f 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -352,7 +352,7 @@ static const struct file_operations coda_psdev_fops = {
 	.llseek		= noop_llseek,
 };
 
-static int init_coda_psdev(void)
+static int __init init_coda_psdev(void)
 {
 	int i, err = 0;
 	if (register_chrdev(CODA_PSDEV_MAJOR, "coda", &coda_psdev_fops)) {
-- 
2.4.11


Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F40ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EE52064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EE52064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=skynet.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeJSQZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:25:18 -0400
Received: from mailrelay101.isp.belgacom.be ([195.238.20.128]:36171 "EHLO
        mailrelay101.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727398AbeJSQZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:25:15 -0400
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3Al4kUqRMQOWJFIkaXAD0l6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/X4rarrMEGX3/hxlliBBdydt6obzbKO+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxlKiTanfb9+MAi9oBnMuMURnYZsMLs6xA?=
 =?us-ascii?q?HTontPdeRWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjTbxFFzsmKH?=
 =?us-ascii?q?w65NfqtRbYUwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr0yRD?=
 =?us-ascii?q?+s7bpkSAXwhSkHKTA37W/ZhM93gq1ZrhKsvABzz5LObY2JLvdyYr/RcNUHTm?=
 =?us-ascii?q?RBRMZRUClBD5u8YYQVFOUBPPxXr4/grFUOtxuxGxSjC/31yj9JmnD23rAx3u?=
 =?us-ascii?q?MvEQ7cxwMgEckDsG/XrNT1MqcdT/y1wLPTwjrddv5b3yr25ovQch05ovyBX6?=
 =?us-ascii?q?h8fMvQxEU1FQ7Iik+cpZHmMj6b0OkGrnKV4PB6Ve21jm4qswRxoj+yycgyko?=
 =?us-ascii?q?TJnYcVykzc9SV+3YY1OcW0SE5lbt6gF5tdryWaN4xqTcw4R2FouCE6yqYauZ?=
 =?us-ascii?q?KheCgKz4goyATba/OadIiI5wjsVOeXITtghXJlfqywhwqq/EWjyODwTMi53V?=
 =?us-ascii?q?dQoidHltTArG0B2h/d58SfT/ty5Eah2TKB1wDJ7eFEJFg5laTBJJE6zL49jY?=
 =?us-ascii?q?ETsUfDHy/whkr2kLWaeV469eSw8eTofq3mpoOAN49zkgzxKKcumtS6AekjNg?=
 =?us-ascii?q?gOXm6b+fmz1bH68035R6hKjvsrnabDrJDaJMMbpqijDw9SyIYj5A61Dy2639?=
 =?us-ascii?q?QAgXkHMFVFdQqFj4fzO1HBOur4DfShjFS3izpk2+vGMqf9DZXIM3jPiqnucq?=
 =?us-ascii?q?tg60RE0go80chf545ICrEGOP/8Rkjxu8HCARIiLwO02PzrB8l41oMDQ26AHL?=
 =?us-ascii?q?KWML7Ku1+S+u0vO/WMZJMSuDvlL/gl5vjujWI2mFMEc6mpxoYYZ26mHvt4J0?=
 =?us-ascii?q?WUemTsgtgfHmcQpAY+T/LliEeEUTFNY3a+RaU85is0CIi+F4fMWpitgKCd3C?=
 =?us-ascii?q?e8BpBWYmFGClaREXbnbomEWOkDaDiUIsB/ljwJTqahS4A/2hG0rgP6yKRoLv?=
 =?us-ascii?q?DS+iIGsZLvzt915/fclRsq7zx7E9yd032RT2Fzhm4ISSU507txoUFm0VeD0q?=
 =?us-ascii?q?h5g/pGGtxP/f9GSRk1ZtbgyLlzCMj3cgbAeMqZDVihX9OqCC0wSdR3xMUBMG?=
 =?us-ascii?q?hnHND3oBnJ3iOsS5EPmrCGHp0/8eqI0XH7Ke5myGfA2bVnhVRwEZgHDnGvmq?=
 =?us-ascii?q?Mqr1ubPIXOiUjMz6s=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AQAACMkslb/7dPQldjGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBUQYBAQELAYEIfIFTEiiMDV+NfgGIUIkdhGyBejgBhDoEAgKFAyI?=
 =?us-ascii?q?0DQ0BAwEBAgEBAgFsKII2IoJiBlYjEFE5HhmDIYF1EagNg32GJ4cshDqBQT+?=
 =?us-ascii?q?BEYRdhACFDQKeQQmGIYpLAhWQKSyXaTiBVU0gGIMngiUBF44cPTCBAwE9AYo?=
 =?us-ascii?q?yAQE?=
X-IPAS-Result: =?us-ascii?q?A2AQAACMkslb/7dPQldjGwEBAQEDAQEBBwMBAQGBUQYBA?=
 =?us-ascii?q?QELAYEIfIFTEiiMDV+NfgGIUIkdhGyBejgBhDoEAgKFAyI0DQ0BAwEBAgEBA?=
 =?us-ascii?q?gFsKII2IoJiBlYjEFE5HhmDIYF1EagNg32GJ4cshDqBQT+BEYRdhACFDQKeQ?=
 =?us-ascii?q?QmGIYpLAhWQKSyXaTiBVU0gGIMngiUBF44cPTCBAwE9AYoyAQE?=
Received: from 183.79-66-87.adsl-dyn.isp.belgacom.be (HELO localhost.localdomain) ([87.66.79.183])
  by relay.skynet.be with ESMTP; 19 Oct 2018 10:20:13 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     akpm@linux-foundation.org
Cc:     jaharkes@cs.cmu.edu, coda@cs.cmu.edu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        fabf@skynet.be
Subject: [PATCH 6/7 linux-next] coda: remove sb test in coda_fid_to_inode()
Date:   Fri, 19 Oct 2018 10:19:32 +0200
Message-Id: <1539937173-26260-7-git-send-email-fabf@skynet.be>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1539937173-26260-1-git-send-email-fabf@skynet.be>
References: <1539937173-26260-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coda_fid_to_inode() is only called by coda_downcall() where
sb is already being tested.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/coda/cnode.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/coda/cnode.c b/fs/coda/cnode.c
index 845b5a6..c42d340 100644
--- a/fs/coda/cnode.c
+++ b/fs/coda/cnode.c
@@ -137,11 +137,6 @@ struct inode *coda_fid_to_inode(struct CodaFid *fid, struct super_block *sb)
 	struct inode *inode;
 	unsigned long hash = coda_f2i(fid);
 
-	if ( !sb ) {
-		pr_warn("%s: no sb!\n", __func__);
-		return NULL;
-	}
-
 	inode = ilookup5(sb, hash, coda_test_inode, fid);
 	if ( !inode )
 		return NULL;
-- 
2.4.11


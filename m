Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BFFC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 21:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284CB2146D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 21:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P7PQKMbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284CB2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbeLBIRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 03:17:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49868 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeLBIRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 03:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gmEKfCMY3wMeJuXACp5/uT8XvMmNlcWaDS2ny5BZemA=; b=P7PQKMbC3TL8geXE0LcByxCzMV
        z2YaLBlRnXUXoz2luVkPpwuc7dd7cnTMOT5wDCqiodNHUWjgnYU8yDDxILVp7uZm35AaXWWBcKLyX
        tuX8sHbf0eqHKMwcy6qIb+/9oMukSZecRlOX34/1Q+BtjP+MFwkJcf85HrVOftaWSVgl2ALKItWMR
        RpBy0Luouy1xuOlkZB12bZlrt5YpkWJ8/zMoLqlUPg2/3wqfnnLykR57kM2HbzJmqdRTew76WEk6y
        HRu4w6jk1HPKcTIrYUH3lTbOt8awLoPhaFPEGo6lHUNmciZ9imZozGWm1bvgrRjRTufz3zFA7Hk+8
        bJ6mWBBg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTCQV-0005EQ-BT; Sat, 01 Dec 2018 21:03:47 +0000
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] vfs: fix typos etc. in
 Documentation/filesystems/mount_api.txt
Message-ID: <8a522bc9-5964-7fd7-9920-32920185ffd7@infradead.org>
Date:   Sat, 1 Dec 2018 13:03:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix typos, grammar, missing '_'s in mount_api.txt.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
Also, is this meant to be "baz" or "bar"?

	static const struct constant_table afs_param_keys[] = {
		{ "baz",	Opt_bar },
		{ "dynamic",	Opt_dyn },
	};

 Documentation/filesystems/mount_api.txt |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20181130.orig/Documentation/filesystems/mount_api.txt
+++ linux-next-20181130/Documentation/filesystems/mount_api.txt
@@ -258,7 +258,7 @@ manage the filesystem context.  They are
  (*) int (*validate)(struct fs_context *fc);
 
      Called when all the options have been applied and the mount is about to
-     take place.  It is should check for inconsistencies from mount options and
+     take place.  It should check for inconsistencies from mount options and
      it is also allowed to do preliminary resource acquisition.  For instance,
      the core NFS module could load the NFS protocol module here.
 
@@ -438,7 +438,7 @@ returned.
  (*) int vfs_parse_fs_param(struct fs_context *fc,
 			    struct fs_parameter *param);
 
-     Supply a single mount parameter to the filesystem context.  This include
+     Supply a single mount parameter to the filesystem context.  This includes
      the specification of the source/device which is specified as the "source"
      parameter (which may be specified multiple times if the filesystem
      supports that).
@@ -533,7 +533,7 @@ The members are as follows:
      used in the values that the ->keys[] array maps to.
 
      It is expected that, for example, two parameters that are related, say
-     "acl" and "noacl" with have the same ID, but will be flagged to indicate
+     "acl" and "noacl" will have the same ID, but will be flagged to indicate
      that one is the inverse of the other.  The value can then be picked out
      from the parse result.
 
@@ -574,9 +574,9 @@ The members are as follows:
      For example:
 
 	static const struct fs_parameter_spec afs_param_specs[nr__afs_params] = {
-		[Opt_autocell]	= { fs_param_is flag },
+		[Opt_autocell]	= { fs_param_is_flag },
 		[Opt_bar]	= { fs_param_is_enum },
-		[Opt_dyn]	= { fs_param_is flag },
+		[Opt_dyn]	= { fs_param_is_flag },
 		[Opt_foo]	= { fs_param_is_bool, fs_param_neg_with_no },
 		[Opt_source]	= { fs_param_is_string },
 	};
@@ -725,7 +725,7 @@ process the parameters it is given.
 
  (*) bool fs_validate_description(const struct fs_parameter_description *desc);
 
-     This is validates the parameter description.  It returns true if the
+     This validates the parameter description.  It returns true if the
      description is good and false if it is not.
 
  (*) int fs_lookup_param(struct fs_context *fc,



Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA32C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6932C2238D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvhmBoUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6932C2238D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeHIUhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:37:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41401 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeHIUhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:37:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id z8-v6so3112964pgu.8;
        Thu, 09 Aug 2018 11:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K9pEvg/1xtQMCMUm7eNfeyd82C7DFAaxfDmz/G7l5JI=;
        b=lvhmBoUvi1sgETLgmrkk5/eJG+QjX7O20Kipqn2vLQt1OaFSYGpF0I5Sok1tWryjmT
         ivKJvmWenEck4SeICntWYPAjfgXXfjMPV15a1hHUPvTlL5qX0sZ9JlYfR+3zVph8G0A4
         JQ0wJr4ewwYUA7YAHaRZd8trcMbFCNY+bll1/FE/07yQ1OXFFMWb7N5e5A1bXJPQQY8j
         aS+YSYNZhbe1TfuwRh5GVmQKmSwxY3Lxkn0I1xzDZ7Q5tVk6SHB/p6LGEKmOHZJ1jRBL
         91XzmtQPS2Vaw7wnt/hIHiEk1K2HjUhVQYozCxc9Wgon1FOwfIaiOfRIOCOicWY8Z55x
         7kvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=K9pEvg/1xtQMCMUm7eNfeyd82C7DFAaxfDmz/G7l5JI=;
        b=QJ1e3rX6uzWnttnO+MSZYGJNZskSyHv8hgBMUKTHARB9mlw/+sEtt2+cN/i3lTAreT
         x+m8xdfLHCsUb24stLmFWAYsqjLKYixvdkpA9Gjgzr8RIndlhVpgnNMZswOdSfBNzbqU
         lzNptP1/r70Xb+KKCyxsprRw9uzUO0p/nLcjlzun2Bw0mz4jnzW1N/a9OdbqKj93XAqa
         IHsR3i4iNYm+Z24krnBcY107fqHb7RT+sS+L2WbR4ImBqIryEdk+CsLMtGCMqIMk4o9m
         +DS1Mz2cL0UK0wU2d+D7wnJtaIgR7M+/2L6QV3OUlkLo/Ao5uyND5XiRv9b8TDvGFmdS
         K7zg==
X-Gm-Message-State: AOUpUlFPvOPlY8XePLT4eXC8AQg6lcpGDT1iKkjoVgik2dt9Zii1hBQ2
        7tdr25IVa88DebBCkuOPjhw=
X-Google-Smtp-Source: AA+uWPzaTMXOmHRmVsxbO/K96mYFCFENRcXwFP4B/ytP2Oh9PKVkbRvrQyAM8a5KxKjQanghoVoIQQ==
X-Received: by 2002:a63:1360:: with SMTP id 32-v6mr3200393pgt.159.1533838298870;
        Thu, 09 Aug 2018 11:11:38 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id t12-v6sm14913273pgg.72.2018.08.09.11.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:11:38 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 11/12] btrfs-progs: replace: disable in HMZONED device
Date:   Fri, 10 Aug 2018 03:11:04 +0900
Message-Id: <20180809181105.12856-11-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809181105.12856-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
 <20180809181105.12856-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As show in the kernel patches, device replace feature needs more works to
complete. Disable the feature for now.

Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 cmds-replace.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/cmds-replace.c b/cmds-replace.c
index 1fa80284..642fbd4b 100644
--- a/cmds-replace.c
+++ b/cmds-replace.c
@@ -116,6 +116,7 @@ static const char *const cmd_replace_start_usage[] = {
 
 static int cmd_replace_start(int argc, char **argv)
 {
+	struct btrfs_ioctl_feature_flags feature_flags;
 	struct btrfs_ioctl_dev_replace_args start_args = {0};
 	struct btrfs_ioctl_dev_replace_args status_args = {0};
 	int ret;
@@ -123,6 +124,7 @@ static int cmd_replace_start(int argc, char **argv)
 	int c;
 	int fdmnt = -1;
 	int fddstdev = -1;
+	int hmzoned;
 	char *path;
 	char *srcdev;
 	char *dstdev = NULL;
@@ -200,6 +202,13 @@ static int cmd_replace_start(int argc, char **argv)
 		goto leave_with_error;
 	}
 
+	ret = ioctl(fdmnt, BTRFS_IOC_GET_FEATURES, &feature_flags);
+	if (ret) {
+		error("error getting feature flags '%s': %m", path);
+		return 1;
+	}
+	hmzoned = feature_flags.incompat_flags & BTRFS_FEATURE_INCOMPAT_HMZONED;
+
 	if (string_is_numerical(srcdev)) {
 		struct btrfs_ioctl_fs_info_args fi_args;
 		struct btrfs_ioctl_dev_info_args *di_args = NULL;
@@ -238,6 +247,12 @@ static int cmd_replace_start(int argc, char **argv)
 		goto leave_with_error;
 	}
 
+	if (hmzoned) {
+		error("cannot replace device on HMZONED file system '%s'",
+		      dstdev);
+		goto leave_with_error;
+	}
+
 	ret = test_dev_for_mkfs(dstdev, force_using_targetdev);
 	if (ret)
 		goto leave_with_error;
-- 
2.18.0


Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98791C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F45F21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nanometrics.ca header.i=@nanometrics.ca header.b="iEUX2VIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F45F21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nanometrics.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeJJAtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:49:33 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50793 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJJAta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:49:30 -0400
Received: by mail-it1-f194.google.com with SMTP id j81-v6so3911064ite.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanometrics.ca; s=google;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WZfKZ9mFsu/vTwKnPT3eAzz4AisFJiTsIBVv1y3D8mI=;
        b=iEUX2VIxr9Pju08ZhQ97lwRt5s/z4g1dKSKNKSR0AGNW4v2qO5ZskBbGAhNG0nMLn3
         nYw+1TuItf7LEORjaQa3Ly9GR8j9tiopYxV5oY9smfSWxb0ZbrG97do1B5D+ScWcnW9I
         Ov8viMASBDD+Az3vF/M5CVH9Z+fJoDa693TLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=WZfKZ9mFsu/vTwKnPT3eAzz4AisFJiTsIBVv1y3D8mI=;
        b=GwkrFbaGvcHJgp+FF1Yp3AGYhEgYb3wwGs9cGc/7Rn94eeBByF7xR2hOJRn6Rwm/ub
         cUM0oFRL6i+H8828kR5LT5t8eewLn9NCLTVrI3fT42iQ6y4AgFY7ZVH+zmDzN8iKA6ov
         wj7khjhf6anKWCIcu5U7XA20Y69eeCdoJqtEJ455vz23BYVKgw3P4BienvD8XZKdPxoO
         CM3XAHGuo7acKf09mFyVJqKVgE8n/XRYUVjTBgoCjZyZyh841alfiSE3TsefEao+rEEc
         11pgwnNC/2ZL16k0AbfYTyUKJsRaeM/Dp4RK2/XPK4THUcEC5jxfWxcook2k1ghamxCE
         YiDw==
X-Gm-Message-State: ABuFfojdWUivwZSaso07ifs8xFKUIEfa4xkyKJqsJ7E0xDpVwjdowX/E
        PIgsGnZx0R9BmyeM/T2XXjpjwKc8vjCp0tGnhh7ziVFBATFFnLSIEmqggzBxkZRBE1c9MJ6+i1A
        BCSMIx2/28J9xW/4W+Ls/Lg==
MIME-Version: 1.0
X-Google-Smtp-Source: ACcGV60x+M2GO3PwEruzH0zWaqVBJ8fvrffm6an2DzvhMqmdtRLyI1LtM59PNcKjjkbRq4VqwS7GwA==
X-Received: by 2002:a24:76c6:: with SMTP id z189-v6mr2804214itb.5.1539106288287;
        Tue, 09 Oct 2018 10:31:28 -0700 (PDT)
Received: from jamesnuss-kubuntu.nanometrics.ca ([72.142.127.130])
        by smtp.gmail.com with ESMTPSA id c24-v6sm6321018iod.44.2018.10.09.10.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 10:31:27 -0700 (PDT)
From:   James Nuss <jamesnuss@nanometrics.ca>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] mmc-utils: remove write_reliability set command
Date:   Tue,  9 Oct 2018 13:31:09 -0400
Message-Id: <212d6c6557b21584f9e3254ff72d57ca2682e2b2.1539103468.git.jamesnuss@nanometrics.ca>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1539103468.git.jamesnuss@nanometrics.ca>
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
In-Reply-To: <cover.1539103468.git.jamesnuss@nanometrics.ca>
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "write_reliability set" command is dangerous since it will only set
write-reliability on one partition per command and this command is a
one-time programmable action. This makes it impossible to set
write-reliability on multiple partitions.

Remove the command so it cannot be used in the future.
Use "write_reliability set_register" instead.

Signed-off-by: James Nuss <jamesnuss@nanometrics.ca>
---
 mmc.c      |  5 -----
 mmc_cmds.c | 67 --------------------------------------------------------------
 mmc_cmds.h |  1 -
 3 files changed, 73 deletions(-)

diff --git a/mmc.c b/mmc.c
index aaefd3d..655546b 100644
--- a/mmc.c
+++ b/mmc.c
@@ -97,11 +97,6 @@ static struct Command commands[] = {
 		"Enable the enhanced user area for the <device>.\nDry-run only unless -y or -c is passed.\nUse -c if more partitioning settings are still to come.\nNOTE!  This is a one-time programmable (unreversible) change.",
 	  NULL
 	},
-	{ do_write_reliability_set, -2,
-	  "write_reliability set", "<-y|-n|-c> " "<partition> " "<device>\n"
-		"Enable write reliability per partition for the <device>.\nDry-run only unless -y or -c is passed.\nUse -c if more partitioning settings are still to come.\nNOTE!  This is a one-time programmable (unreversible) change.",
-	  NULL
-	},
 	{ do_write_reliability_set_register, -2,
 	  "write_reliability set_register", "<partition-mask> " "<device>\n"
 		"Set the write-reliability register (WR_REL_SET) for the <device>.\n"
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 68c73ef..9565bc9 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1303,73 +1303,6 @@ int do_write_reliability_set_register(int nargs, char **argv)
 	return 0;
 }
 
-int do_write_reliability_set(int nargs, char **argv)
-{
-	__u8 value;
-	__u8 ext_csd[512];
-	int fd, ret;
-
-	int dry_run = 1;
-	int partition;
-	char *device;
-
-	if (nargs != 4) {
-		fprintf(stderr,"Usage: mmc write_reliability set <-y|-n|-c> <partition> </path/to/mmcblkX>\n");
-		exit(1);
-	}
-
-	if (!strcmp("-y", argv[1])) {
-		dry_run = 0;
-	} else if (!strcmp("-c", argv[1])) {
-		dry_run = 2;
-	}
-
-	partition = strtol(argv[2], NULL, 10);
-	device = argv[3];
-
-	fd = open(device, O_RDWR);
-	if (fd < 0) {
-		perror("open");
-		exit(1);
-	}
-
-	ret = read_extcsd(fd, ext_csd);
-	if (ret) {
-		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
-		exit(1);
-	}
-
-	/* assert not PARTITION_SETTING_COMPLETED */
-	if (ext_csd[EXT_CSD_PARTITION_SETTING_COMPLETED])
-	{
-		printf(" Device is already partitioned\n");
-		exit(1);
-	}
-
-	/* assert HS_CTRL_REL */
-	if (!(ext_csd[EXT_CSD_WR_REL_PARAM] & HS_CTRL_REL)) {
-		printf("Cannot set write reliability parameters, WR_REL_SET is "
-				"read-only\n");
-		exit(1);
-	}
-
-	value = ext_csd[EXT_CSD_WR_REL_SET] | (1<<partition);
-	ret = write_extcsd_value(fd, EXT_CSD_WR_REL_SET, value);
-	if (ret) {
-		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
-				value, EXT_CSD_WR_REL_SET, device);
-		exit(1);
-	}
-
-	printf("Done setting EXT_CSD_WR_REL_SET to 0x%02x on %s\n",
-		value, device);
-
-	if (set_partitioning_setting_completed(dry_run, device, fd))
-		exit(1);
-
-	return 0;
-}
-
 int do_read_extcsd(int nargs, char **argv)
 {
 	__u8 ext_csd[512], ext_csd_rev, reg;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 8ca9ac9..cf6c6fb 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -34,7 +34,6 @@ int do_sanitize(int nargs, char **argv);
 int do_status_get(int nargs, char **argv);
 int do_create_gp_partition(int nargs, char **argv);
 int do_enh_area_set(int nargs, char **argv);
-int do_write_reliability_set(int nargs, char **argv);
 int do_write_reliability_set_register(int nargs, char **argv);
 int do_rpmb_write_key(int nargs, char **argv);
 int do_rpmb_read_counter(int nargs, char **argv);
-- 
2.7.4


-- 
This message is intended exclusively for the individual or entity to which 
it is addressed. This communication may contain information that is 
proprietary, privileged, confidential or otherwise legally exempt from 
disclosure. If you are not the named addressee, or have been inadvertently 
and erroneously referenced in the address line, you are not authorized to 
read, print, retain, copy or disseminate this message or any part of it. If 
you have received this message in error, please notify the sender 
immediately by e-mail and delete all copies of the message.

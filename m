Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2317C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0442238B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xk+K3KwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0442238B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeHIUhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:37:37 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38694 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbeHIUhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:37:37 -0400
Received: by mail-pl0-f65.google.com with SMTP id u11-v6so2881103plq.5;
        Thu, 09 Aug 2018 11:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hE4t/T5xBCjUgD1IFsfSM9RZtqZj7metO9MTlR+zsb8=;
        b=Xk+K3KwUHXcywGM+K3ut6NnKXWYEqvXnqXIz2VvWDycdVMxNYfdkSGfQATZ0aIMiKp
         1k0TWycLBJmcxbU5pLVJkEy85akmJPaupu1JfdhFso09KTcootzUISgUI57Pl9LLwJdX
         q31Vb+tun4nLl7X7AAnTf2kUd4bkYc7TdT68qEulTDDrF2BOiDYWqHzUaROTspX+ElJR
         k5c8aCbaTDBlIciziy0Wnpkiwv1BTJYkeBBDPgOF3N+9/LIMtaEkJIAQfNtMg+5r1pzA
         SwJVI1jUQHAUwKQAmVZPQlZzr5i5SBLdXR1EfjSblxNBDhs0V4iJ/1gTque3BsnjG5ia
         sqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=hE4t/T5xBCjUgD1IFsfSM9RZtqZj7metO9MTlR+zsb8=;
        b=Ssa2V18CEL/BAurzSuCRsX6aSkcrrCpcii7Bq1cxvKtk5cN8UzNZ1N/vFlpuo6fAUT
         edLFIEioCNnndsp1YlynB8PTgpOw0amp5XEQt99SDT9b3CJMzh5Fadslj18L408oGxLs
         2MsX42B6fNVz7d4tAkFeuFLGxBhzl7gMsgrJhSUsfkHJGdmRmb+ea87cgurXfgGRLCHI
         VV8kgoPT2vMR9P7SP3gz/rSqlA244eYaGV48sEUkCM1tCeQI9un75m7rrT/Znb+nd2kv
         0hYWTj5p8aJxj6gcWtYkN19YY/uYEkFguMWtwDx7CbAz/yKSM1CuCRdCBTMTcHXpUDUc
         fOdg==
X-Gm-Message-State: AOUpUlFxe2vU8BeVals/9pn2DVzuCHBC5Cdwr3JWq8XI8LXuj9GXJ+6T
        aqFrFUXxxCCCNJwS2fzwDmw=
X-Google-Smtp-Source: AA+uWPx0Ok9f+uiGer0s+0tAOTlYBfKqeTl23atym9n4jQS7pJsLD94drVD1gdLgtwrGLPL80nqmnA==
X-Received: by 2002:a17:902:6105:: with SMTP id t5-v6mr3025295plj.92.1533838295955;
        Thu, 09 Aug 2018 11:11:35 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id t12-v6sm14913213pgg.72.2018.08.09.11.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:11:35 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 10/12] btrfs-progs: device-add: support HMZONED device
Date:   Fri, 10 Aug 2018 03:11:03 +0900
Message-Id: <20180809181105.12856-10-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809181105.12856-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
 <20180809181105.12856-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch check if the target file system is flagged as HMZONED. If it is,
the device to be added is flagged PREP_DEVICE_HMZONED.  Also add checks to
prevent mixing non-zoned devices and zoned devices.

Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 cmds-device.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/cmds-device.c b/cmds-device.c
index 2a05f70a..10696bf7 100644
--- a/cmds-device.c
+++ b/cmds-device.c
@@ -56,6 +56,9 @@ static int cmd_device_add(int argc, char **argv)
 	int discard = 1;
 	int force = 0;
 	int last_dev;
+	int res;
+	int hmzoned;
+	struct btrfs_ioctl_feature_flags feature_flags;
 
 	optind = 0;
 	while (1) {
@@ -91,12 +94,33 @@ static int cmd_device_add(int argc, char **argv)
 	if (fdmnt < 0)
 		return 1;
 
+	res = ioctl(fdmnt, BTRFS_IOC_GET_FEATURES, &feature_flags);
+	if (res) {
+		error("error getting feature flags '%s': %m", mntpnt);
+		return 1;
+	}
+	hmzoned = feature_flags.incompat_flags & BTRFS_FEATURE_INCOMPAT_HMZONED;
+
 	for (i = optind; i < last_dev; i++){
 		struct btrfs_ioctl_vol_args ioctl_args;
-		int	devfd, res;
+		int	devfd;
 		u64 dev_block_count = 0;
 		char *path;
 
+		if (hmzoned && zoned_model(argv[i]) == ZONED_NONE) {
+			error("cannot add non-zoned device to HMZONED file system '%s'",
+			      argv[i]);
+			ret++;
+			continue;
+		}
+
+		if (!hmzoned && zoned_model(argv[i]) == ZONED_HOST_MANAGED) {
+			error("cannot add host managed zoned device to non-HMZONED file system '%s'",
+			      argv[i]);
+			ret++;
+			continue;
+		}
+
 		res = test_dev_for_mkfs(argv[i], force);
 		if (res) {
 			ret++;
@@ -112,7 +136,8 @@ static int cmd_device_add(int argc, char **argv)
 
 		res = btrfs_prepare_device(devfd, argv[i], &dev_block_count, 0,
 				PREP_DEVICE_ZERO_END | PREP_DEVICE_VERBOSE |
-				(discard ? PREP_DEVICE_DISCARD : 0));
+				(discard ? PREP_DEVICE_DISCARD : 0) |
+				(hmzoned ? PREP_DEVICE_HMZONED : 0));
 		close(devfd);
 		if (res) {
 			ret++;
-- 
2.18.0


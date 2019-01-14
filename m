Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B81EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB4620659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FilRKiE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfANUjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:39:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44084 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfANUjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:39:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so409924wrt.11;
        Mon, 14 Jan 2019 12:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7OB8l1HfewCN1zRGPnCcAWYhfDZSLytYFckK0OsM5qo=;
        b=FilRKiE9Zd0zSrjWFWt8vqwpFgSmF9QfZrf5UHUSw+qb4PEd4ds3aTvtQ/A65vuXRn
         JNzf6rbbFTs83IsS2lT+kZsNMcX4uWoWQsvQM69DRymJoz6UE21VnN4pS+Hngdu7L47F
         DJDkvSQbU6MYOlvSU5ws4PfW0DlK/nREc5pDe0cbPQcBSU8o98die3BLDh23hVKbNhkO
         hnQYGRhDPpPmddgECujATYxwb4CihDMQN3mAmQT1wx8SM0P7g6wEVug4byGRyYu4O4lO
         pe65znHquHn7lqRNHGWlH5xw/TL0Lhf2jwItkCYMpMhRN6D7MjwXF/ITUFFLB558t+u4
         S19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7OB8l1HfewCN1zRGPnCcAWYhfDZSLytYFckK0OsM5qo=;
        b=A1f8p/wS9kqQ0weLdvNTY852gH6veVpBRZJqPH26T8vsNZs0EMwcDg/CQzloEobtvA
         kMJPjkwEg0gJwZTa5887+CI6O54xaf+OJTbgdr0h4c+PmGc/wOCGxVgOVN/gS+i4FebG
         D5sN1eDLrMrWObTCEC9vnfPzPffDaUQrG0opORwg/n/EU/QLH0W5b4aLy7bpaMpznUfs
         +EYy2iYQ7l3wIusVGy+4UIhF6ZtkYN8qLKJaELu5if2ihFf4iylb9aYPjt1lNltvtUJP
         x2iqzYxpkHABu+ldTDfT+LtrbmErF4iZC2tuiQ7EWjU0gO/jGHOPGqlS+vDxlX6dMICu
         hpGQ==
X-Gm-Message-State: AJcUukdrIRopkqQE47Phvcqpl7vQxHM0C0AEB25ItdruvtuZ89XYDXQN
        R2kIrsUsLymbrp8IGPnu7KQ=
X-Google-Smtp-Source: ALg8bN4hHr+Qv5rWGyplun6OuMg4qWO0fzlMGO4MdU2mxbsilIhdxt/txLwa3GCRu96zIfDwNA2GAQ==
X-Received: by 2002:adf:9f10:: with SMTP id l16mr233373wrf.206.1547498348124;
        Mon, 14 Jan 2019 12:39:08 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id i186sm33660913wmd.19.2019.01.14.12.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:39:07 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id F3B5111422AD; Mon, 14 Jan 2019 21:39:05 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] fs/fcntl: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:38:58 +0100
Message-Id: <20190114203859.19875-3-malat@debian.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190114203859.19875-1-malat@debian.org>
References: <20190114203859.19875-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

In this particular case change a ‘:’ with a ‘-’ so as to match the
regular expression expected by GCC.

This commit remove the following warning:

  fs/fcntl.c:770:7: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 fs/fcntl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 083185174c6d..3d40771e8e7c 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -769,7 +769,7 @@ static void send_sigio_to_task(struct task_struct *p,
 			si.si_fd    = fd;
 			if (!do_send_sig_info(signum, &si, p, type))
 				break;
-		/* fall-through: fall back on the old plain SIGIO signal */
+		/* fall-through - fall back on the old plain SIGIO signal */
 		case 0:
 			do_send_sig_info(SIGIO, SEND_SIG_PRIV, p, type);
 	}
-- 
2.19.2


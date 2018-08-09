Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF22C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B726C2238B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCmVuOg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B726C2238B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeHIUhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:37:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45171 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeHIUhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:37:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id i26-v6so3204767pfo.12;
        Thu, 09 Aug 2018 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=As0lKa5+Tv1HOY4/e5U6uHnlYo/L2iz6KBMvgOghx1Y=;
        b=ZCmVuOg/8mUD/pHRWoLO2xWqalxH6ZPuvTCZH7XOdigAWIVj/2e/lmiF4WzUOOT+1f
         MKNLo9fyl0HMqJcX+spvYlpVsOj4L4A3+fnSvq/cIs2BmSS3y2ndxF5hjmntkcYBhdl1
         S4oPoU8FnHU4otOsvZtGZWzqX2OR7pdSx6/zZ7ecTjZ/thsfkkZ8Q2p9sG8UhPMR/9gI
         cRHMVReU2bA4/TddrH/JBeEBn0SRRh9pEf5i6mK22etQObTQumQJnPbucz5ewp4JMlYV
         2SQyVV3BX/5vAybol4xNgl9gTy5w+0ZxwbK+xtH1jTTZ7wKv5VefIyxzGwwcAVuwuMMJ
         KlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=As0lKa5+Tv1HOY4/e5U6uHnlYo/L2iz6KBMvgOghx1Y=;
        b=VuHONOtvh616urvewvb8mDLwDEKPBFseJOMeDCfCpnikTjcUSToB6zuc9j1gh/v/ar
         R55NmhcLvaY55EQJq8jQfC7Y3+ztKt2tOAG64iB20UI8aQDweZhwL/iD6y+0cDy14FkW
         iGQVDIYtpi0gheJbN3JVAB5x8FApJ4q3XgTOMVE70eVQw6tUAfM3UzM+6jm6uzxQ1pVA
         Ebusp915//PbzHTXvCxk5ViEVZb2SyvwIT0KzUakQNGF/bUwLyIUxM64l9uTOJNd/+NP
         SKW9+GWrkckGt05m2V6e6AjKuQXK4ddDhL7Z0AJAky6HTsz9PHtmL5oOodnDEju/sGgv
         BqLw==
X-Gm-Message-State: AOUpUlG8LcHrruVpXMrHEWsUFxdXQ36HY0Y2LAMmFzkbiIbVEw+4OTzF
        V98jtk1eXgoeS0onNQF1A5o=
X-Google-Smtp-Source: AA+uWPyIbjyaTx1S5zcMuNHJC26GI+Pj9ruSSvDqGqrOYJuqqKUDHKFWzYLSHJ1NaI9pf8NDc6cbfA==
X-Received: by 2002:a62:1f8c:: with SMTP id l12-v6mr3482696pfj.143.1533838270075;
        Thu, 09 Aug 2018 11:11:10 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id i125-v6sm7017445pgc.16.2018.08.09.11.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:11:09 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 01/12] btrfs-progs: build: Check zoned block device support
Date:   Fri, 10 Aug 2018 03:10:54 +0900
Message-Id: <20180809181105.12856-1-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809180450.5091-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kernel supports zoned block devices, the file
/usr/include/linux/blkzoned.h will be present. Check this and define
BTRFS_ZONED if the file is present.

If it present, enables HMZONED feature, if not disable it.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 configure.ac | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configure.ac b/configure.ac
index df02f206..616d62a1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -207,6 +207,18 @@ else
 AC_DEFINE([HAVE_OWN_FIEMAP_EXTENT_SHARED_DEFINE], [0], [We did not define FIEMAP_EXTENT_SHARED])
 fi
 
+AC_CHECK_HEADER(linux/blkzoned.h, [blkzoned_found=yes], [blkzoned_found=no])
+AC_ARG_ENABLE([zoned],
+  AS_HELP_STRING([--disable-zoned], [disable zoned block device support]),
+  [], [enable_zoned=$blkzoned_found]
+)
+
+AS_IF([test "x$enable_zoned" = xyes], [
+	AC_CHECK_HEADER(linux/blkzoned.h, [],
+		[AC_MSG_ERROR([Couldn't find linux/blkzoned.h])])
+	AC_DEFINE([BTRFS_ZONED], [1], [enable zoned block device support])
+])
+
 dnl Define <NAME>_LIBS= and <NAME>_CFLAGS= by pkg-config
 dnl
 dnl The default PKG_CHECK_MODULES() action-if-not-found is end the
@@ -308,6 +320,7 @@ AC_MSG_RESULT([
 	btrfs-restore zstd: ${enable_zstd}
 	Python bindings:    ${enable_python}
 	Python interpreter: ${PYTHON}
+	zoned device:       ${enable_zoned}
 
 	Type 'make' to compile.
 ])
-- 
2.18.0


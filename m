Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D6CC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9A12238B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQJqXaeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9A12238B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeHIUcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:32:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43644 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeHIUb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:31:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id a14-v6so3096035pgv.10;
        Thu, 09 Aug 2018 11:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=th2DL5AhDXI5K/RU49B+KPIKtEk+BoJ2NCXW6+0Iepo=;
        b=iQJqXaeLIhka/DlpPwd2wv1DhmxZlQGpNNu5gBeW+CnKKKhIRTC1dF3sMe2g9W1sbD
         YgfphpEXrFq+BUAJBm57L/gYwnZJ9BoN0T1+bmIS9NosNKfmOB2JLQJPmgt79URYIFqX
         SsB2H+XhLxIDjGjgaH0vHVEQhWgFHNAhr47SPQ0FyFMgyj/HROjLTrG6BxfDYpj4n7tp
         q/rgeatM/EK6Ahh+dmjFhJLcFBIWNIHGmTv3Vly9yLcIV2ffoZfS8eECYljhNdY4PigB
         DLjlYei3n4GZeKSNfivGv+uipTugYHabMjoo/Ee2MlZhrJGLDhJVgptHllpeyuEMCF3E
         0DTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=th2DL5AhDXI5K/RU49B+KPIKtEk+BoJ2NCXW6+0Iepo=;
        b=CW+AvIUgm9iuKSObCaU2JgJ1L0FyUU8gvtDbY2Dll0yEd2er6posT3omv63Ker4dMB
         xk324iSGIFAU+glNeTuGhuhUnHQqQFYWGXt9rSFPN5AjAoC6xnvoqI307u7L7CPHLPEd
         bNp9yG6DVAtVDBRMZZ5T47eNqBFVcsffkP7ze4NzhPrPIFWnj0GwZgO/IG1euMc3WyV1
         klkb8Ksr6KmBqoexikkiiIsmSeYSCI6Maw2LnzDZd70xNwKRlzkB+GWFiLK7hb4WagS8
         PogeYXd7e5QmZ4cTJyGi/0JPU1cIJ7cj749UzYWOOlaqq7DMfMDivYyIC61tRdB6nZTN
         2ENw==
X-Gm-Message-State: AOUpUlEx7plL8RT5FYGlUxvqsGIFA1rFPIdW38vFIbEANWxJmlMeHPbc
        fTkOE5rnBTGsIEZMs/VEjfk=
X-Google-Smtp-Source: AA+uWPxsMzc2+KUPvoyDkxHaP6NzkIW+JjWOQt/zEC36V8ENrtqJyu1ean2G4p65xR5LN85E+Qw4nA==
X-Received: by 2002:a63:8a41:: with SMTP id y62-v6mr3050315pgd.291.1533837960238;
        Thu, 09 Aug 2018 11:06:00 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id z184-v6sm10354622pgd.83.2018.08.09.11.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:05:59 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 05/17] btrfs: disable fallocate in HMZONED mode
Date:   Fri, 10 Aug 2018 03:04:38 +0900
Message-Id: <20180809180450.5091-6-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809180450.5091-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fallocate() is implemented by reserving actual extent instead of
reservations. This can result in exposing the sequential write constraint
of host-managed zoned block devices to the application, which would break
the POSIX semantic for the fallocated file.  To avoid this, report
fallocate() as not supported when in HMZONED mode.

Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 fs/btrfs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 095f0bb86bb7..6f4546ccb57d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2993,6 +2993,10 @@ static long btrfs_fallocate(struct file *file, int mode,
 	alloc_end = round_up(offset + len, blocksize);
 	cur_offset = alloc_start;
 
+	/* Do not allow fallocate in HMZONED mode */
+	if (btrfs_fs_incompat(btrfs_sb(inode->i_sb), HMZONED))
+		return -EOPNOTSUPP;
+
 	/* Make sure we aren't being give some crap mode */
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 		     FALLOC_FL_ZERO_RANGE))
-- 
2.18.0


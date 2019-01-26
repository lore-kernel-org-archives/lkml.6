Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F6EC282C3
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E684920833
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbfAZDfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 22:35:50 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:60472 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726030AbfAZDfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 22:35:50 -0500
X-Greylist: delayed 2015 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Jan 2019 22:35:49 EST
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x0Q32DGb003400
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 22:02:14 -0500
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x0Q328W6017646
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 22:02:13 -0500
Received: by mail-qt1-f199.google.com with SMTP id q3so13218681qtq.15
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 19:02:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:mime-version:date:message-id;
        bh=BYfgDlGlTIN/7TdD4cBo/pBUguFrDva6TtNClYrVCZQ=;
        b=f0Dzc/tdz3h2ZKRgC4C3a23P+cJVB23pl6fTsyW3qfL6hbGBMJt8futIL7WX9aBCwY
         YjOrpZGRxGfA35lKX7S7PilrXkUFvgX3PvQ+Rkq7l/95Au2ZcGo3Ws2Pzt3p28z24dYp
         GmE6SXv5peneHRf4ByInWUfDCmRvVa2Fu4kPabryvnPaPpkBcxZMqTxAzZHW2wdFcYYk
         q9BqLirjfNOIhT0VejNcqrWkTG71uG+I/rDkWaBOYxK8imo3t3+UWoW68kbzSAEhs4ac
         Q6Z/OKOBp/W2Iv1Exp0/1jQAINesaQOAMMKpinztj7N+9xgxbaFq1jFyjXrL+UWOkJr+
         0iVQ==
X-Gm-Message-State: AJcUukd21krg4tw5z6Ua/kyHGiNn8wpUunKNVAgFqlA5bkH4dOi7upTM
        K5NaSzgieakiRqgd9FSywnL+D/xnea3+xvizn3J4IbUX3ekBEzf3n622g0Ct/+gDPgk2qokGJ2z
        gY78NFNk3yjnfrKfQnSTXUrOtt4zX8ZncI+F2TzNvqJ1k2cjxUEsEB6vnVbAX6vHwickq4pwat8
        AuLUvTKv7I1rxIv1wH
X-Received: by 2002:a0c:b786:: with SMTP id l6mr12866937qve.244.1548471728472;
        Fri, 25 Jan 2019 19:02:08 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5YfbViMq73MoytuFlfQTM2PrHDhk//lXn4DP7+eF9crtblyiA/GqKAGhGZ50rP+H+kcuz0dQ==
X-Received: by 2002:a0c:b786:: with SMTP id l6mr12866925qve.244.1548471728204;
        Fri, 25 Jan 2019 19:02:08 -0800 (PST)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id z18sm52819685qkz.96.2019.01.25.19.02.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 19:02:06 -0800 (PST)
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
From:   valdis.kletnieks@vt.edu
To:     linux-kernel@vger.kernel.org
Subject: Heads up: next-20190115 and GCC 9.0 don't play nice.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Fri, 25 Jan 2019 22:02:05 -0500
Message-ID: <19134.1548471725@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So a GCC 9 escaped to Fedora Rawhide in the last few days, and things didn't
go well. Fortunately, I had the 8.2.1-7 RPMs still around.

Issue 1: There's a new warning added for taking the address of a member of
a packed array. It wasn't *too* noisy.

Issue 2: Looks like it's not ready for prime time.

  CC [M]  fs/ntfs/super.o
fs/ntfs/super.c: In function 'is_boot_sector_ntfs':
fs/ntfs/super.c:597:3: warning: converting a packed 'const NTFS_BOOT_SECTOR *' {aka 'const struct <anonymous> *'} pointer (alignment 1) to 'le32' {aka 'unsigned int'} (alignment 4) may result in an unaligned pointer value [-Waddress-of-packed-member]
  597 |   for (i = 0, u = (le32*)b; u < (le32*)(&b->checksum); ++u)
      |   ^~~
fs/ntfs/super.c:597:3: internal compiler error: Segmentation fault
Please submit a full bug report,
with preprocessed source if appropriate.
See <http://bugzilla.redhat.com/bugzilla> for instructions.
Preprocessed source stored into /tmp/cc0KDLoH.out file, please attach this to your bugreport.
make[2]: *** [scripts/Makefile.build:277: fs/ntfs/super.o] Error 1
make[1]: *** [scripts/Makefile.build:491: fs/ntfs] Error 2
make: *** [Makefile:1044: fs] Error 2

I've reported this to the RedHat/Fedora crew as:
https://bugzilla.redhat.com/show_bug.cgi?id=1669696


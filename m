Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CB0C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0524F21710
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MP3W1KEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0524F21710
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbeI1BKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:10:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43062 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbeI1BKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:10:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id q19-v6so2586178pgn.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 11:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:cc:from:to:message-id;
        bh=azWPOKqWWFSGqe6aQhQ6tNpWbbpg2xrzIx5NPKK1yVA=;
        b=MP3W1KELwdxZbu0ygcHjtm/i4y7HO8qY4jczI9DxNL+GyVP7eXIev0Cb0gVTxd8Ooo
         jzf2xpjrX0gO8cuO4Sot6nR0lB3jEqC18kdNVXgKlCdHWlSSbUKOQKZwRWNWjkPBK16C
         GdBJMLa2DWA5Lyrs8+u7njaPkZS9ArZRoMKosifNbJ3ssSXHGL7fGAYE2cXg7RBdhs1c
         1zJBkhOwyZqRmNnUNkE8uJKsu9xAe8zN+jopD9kG2C8GnZlVlh/fH/s3Z3aB6ksOrsur
         TosjPqg+exXNRE0z13IJQmo+UHdutRih3a55+yhxEGYQ00ws6FQZRSdn3V/41JnCS/cI
         p6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=azWPOKqWWFSGqe6aQhQ6tNpWbbpg2xrzIx5NPKK1yVA=;
        b=GKg77qawSVJBezHDxAxdqPZ50SOi0Vy509AVwIbRmVJPXkhurCXptE3tvBQVP23IGX
         VnfVssd9iFrxYehmsxqnCaM35kzRyxd51KKUdVHVgJsHmaqIq46PCGbB83Vp8K6yOelN
         /PrHD0Wzizp0P9GxrVlnlwxKKJSJkMUTzLAFVIYuOwgS7WUaiwtZ8RzO7PkEAtc/Bhrl
         PSIK9/FLq3hXzVZqLkPYY4NLi7NtNFMfS5A3k3KivgTx05XDSmjM4ntbKLvEKX3JoMLU
         lrjCsfK+wskIlk/dO1RFEyMGRKvIFPnk4TS8GPUsOL6WWNhEyMQbrfrX97nBXJLFOuAi
         K80A==
X-Gm-Message-State: ABuFfogRe4TfTgq7OtI7/0bEzo7tghfQki7pKiAgyx5xmSvxYSEfErdP
        dhX59G58ujBLBVG5a0WWS5S/iw==
X-Google-Smtp-Source: ACcGV63kyLzh6l7CteavuoSH14wiZpGIpQyzNFKe2Nv8G1pC4wtckyjVdjO1Qc6n+ti1Gx0Dwsb9lA==
X-Received: by 2002:a17:902:3c5:: with SMTP id d63-v6mr12262827pld.145.1538074268234;
        Thu, 27 Sep 2018 11:51:08 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id e7-v6sm5630127pfk.3.2018.09.27.11.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 11:51:07 -0700 (PDT)
Date:   Thu, 27 Sep 2018 11:51:07 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Sep 2018 11:18:36 PDT (-0700)
Subject: [GIT PULL] A Single RISC-V Update for 4.19-rc6
CC:      linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-61f81f3e-1f1c-4b5d-a36c-caabba09a7b9@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84:

  Linux 4.19-rc5 (2018-09-23 19:15:18 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-4.19-rc6

for you to fetch changes up to 57a489786de9ec37d6e25ef1305dc337047f0236:

  RISC-V: include linux/ftrace.h in asm-prototypes.h (2018-09-24 13:12:27 -0700)

----------------------------------------------------------------
A Single RISC-V Update for 4.19-rc6

The Debian guys have been pushing on our port and found some unversioned
symbols leaking into modules.  This PR contains a single fix for that
issue.

----------------------------------------------------------------
James Cowgill (1):
      RISC-V: include linux/ftrace.h in asm-prototypes.h

 arch/riscv/include/asm/asm-prototypes.h | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 arch/riscv/include/asm/asm-prototypes.h

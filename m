Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8AFC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367BB2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbsthVoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfBDU1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:27:20 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:54313 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbfBDU1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:27:20 -0500
Received: by mail-wm1-f41.google.com with SMTP id a62so1293852wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 12:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bz4JbNJnEOGM0ZEeO/rNAutvM5cuFXFUGyB7HbtjIsI=;
        b=vbsthVoOU3Xc6S0aBF+qRVcrUZ6iMclKkaPXVcXtlVoBB0+amREUKdmTb3tH9ov8e3
         xNTzg5wG5F1H5/MCvSwEO4wCSEAm1yStUhdmJ+p2DD8/HogCwCKNXcDAVIs9IvkytK5H
         yirmgAx0X+4ID77ZPGQe4B+gcrfcTTgv6Fdpf2gEWV8rQ3lt++CXbgN6GqSiM1Mo4CgU
         dUx8z955RRTATDtV9WADgOzJKZQEmd98B28OZsq3lylHGy4EkHWjqAAvTlPotiOr76IF
         lJVgKnfMxPFC8ntwz6KaNSbjqccNARuB//9Y1JuH6G0yzLTaiGuZyKu8hC8YqqWuiLB9
         7dVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bz4JbNJnEOGM0ZEeO/rNAutvM5cuFXFUGyB7HbtjIsI=;
        b=VYgaybbwL4TTZn4v/X94UIQWaSYyno2zBDTJbj6ffKrt2y4e/Qjd6y4UIhn+OZ/Zxn
         d0i7FtyGk+8nAWd9puxIY90zFnP/eIpFbsYVvy+lNymLdplTCnYXWMyVbpDN1ejakPWo
         kFhbeqReh7ssc29Fn4F/5uAdHLufp5Fv7VYnBuXUhcf0D+f18x9JKHiX6As3QwFeppG+
         0eSjKV545U8XSdaYjcYlAjsFMAu7vEco0f2lAVhGDECU1owqZRx01w4jToCPgYVubEUU
         Vx+YCmkUfzOd0yHXc+my1li5golMnPKDfTMjsE6HTz2pfafq0pC436hfysNYCMvMe0lJ
         RZWQ==
X-Gm-Message-State: AHQUAubTgeU7fvi504l5NbwgxqytGMCRAmy1KMhg0gcbuO4PKR2tFC31
        V6UyqcuFh2X1EwD/KwH8oNfRt68=
X-Google-Smtp-Source: AHgI3Ib37Rinzi4si1SLI57PYKsDoca6FdWSldQcaoefPCjDi6ahudOUXllaotn2uXrGNZhTgtt45w==
X-Received: by 2002:a7b:c191:: with SMTP id y17mr865706wmi.60.1549312038321;
        Mon, 04 Feb 2019 12:27:18 -0800 (PST)
Received: from avx2 ([46.53.245.13])
        by smtp.gmail.com with ESMTPSA id n15sm9496995wrt.21.2019.02.04.12.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 12:27:17 -0800 (PST)
Date:   Mon, 4 Feb 2019 23:27:15 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] elf: don't be afraid of overflow
Message-ID: <20190204202715.GA27482@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Number of ELF program headers is 16-bit by spec, so total size
comfortably fits into "unsigned int".

Space savings: 7 bytes!

	add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-7 (-7)
	Function                                     old     new   delta
	load_elf_phdrs                               137     130      -7

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -418,8 +418,9 @@ static struct elf_phdr *load_elf_phdrs(struct elfhdr *elf_ex,
 				       struct file *elf_file)
 {
 	struct elf_phdr *elf_phdata = NULL;
-	int retval, size, err = -1;
+	int retval, err = -1;
 	loff_t pos = elf_ex->e_phoff;
+	unsigned int size;
 
 	/*
 	 * If the size of this structure has changed, then punt, since
@@ -429,13 +430,9 @@ static struct elf_phdr *load_elf_phdrs(struct elfhdr *elf_ex,
 		goto out;
 
 	/* Sanity check the number of program headers... */
-	if (elf_ex->e_phnum < 1 ||
-		elf_ex->e_phnum > 65536U / sizeof(struct elf_phdr))
-		goto out;
-
 	/* ...and their total size. */
 	size = sizeof(struct elf_phdr) * elf_ex->e_phnum;
-	if (size > ELF_MIN_ALIGN)
+	if (size == 0 || size > 65536 || size > ELF_MIN_ALIGN)
 		goto out;
 
 	elf_phdata = kmalloc(size, GFP_KERNEL);

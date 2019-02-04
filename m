Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483BEC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153A02073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMezhE9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbfBDU2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:28:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50358 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfBDU2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:28:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id z5so1316334wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 12:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DXTHThtkK5NZH0hGp5387dLPASx26bqJjS1W4mSqbUQ=;
        b=bMezhE9o1CkcBY2Xo9zsTBooNTSLnt70QJP8BCA0nJc1QNLPOD7TKyTbp+RgcRJQ9Y
         j3LudIAHRIWi+3eeohOKXQZCzVkSMR2Kq+B9EfU1eOrCxhaSibHG+0YmXpHPrS6hXE3U
         4vcpZOPFHR2J31Vi2jTfL8gS3TuJGG2QaGQwcx//DKOkQU3pph7BXBKLGW0y8r5rG19S
         nK+wNH+ZFo/DRVRXPOJk3o+1MP8tCyWG2N3VhS1bW/dS/WRGoAXGphuK2PufR0pSD3P8
         Aciimiu86Vqe1jRSEJXCOOkxpRzjNMpkVxdXI4KMGUude2UjbP6du0WpS1bJeBRcXYjF
         29cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DXTHThtkK5NZH0hGp5387dLPASx26bqJjS1W4mSqbUQ=;
        b=MnCPn+tWpKY9IRArn+JjkbU2SDEoHrapWr5XELykJc7K/Vurf7T7Em6ztPN7eEFEv+
         TA0YWKIjnAvjU+ImM3LTQ/04eB3dknkR3NbmQjmJ/MDqa8mSy0oV4IyOA7GLzUgOpZTL
         /Z0QNwUrehzaUQXAkWbkmE7Z4kqEEpXjZi7xGTXpt/lvsvrHCU4vEeI5IDaipEiZszbt
         tYc2nSPABCHPvPXAkq3p0qAJzWrDLgo0cochyyEwvDSPmgBEryc/AkL8MeMc8m6mhqev
         JmIcjY3dAK2hNXihbX3y1onKDv4eG1MOSIUGMy6LmfG2qmcv1/nSuKHmj9qyLGI2hm4q
         yvTw==
X-Gm-Message-State: AHQUAubYfCErv8McoYTe+NsXmyeLRDfkKhIJ5ohkUcJozGNKIyRhzMyl
        J0wgAjOh/fOqpl1Ogy+YW7t0sNw=
X-Google-Smtp-Source: AHgI3IYGk6QY8VsSpbbJRLVGqLjrYJUcGmpeVsTZQ+a1HplAo/+mDT4kgstY3NLdFMrh5hHtnlb3Ng==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr835001wmi.61.1549312112574;
        Mon, 04 Feb 2019 12:28:32 -0800 (PST)
Received: from avx2 ([46.53.245.13])
        by smtp.gmail.com with ESMTPSA id g9sm13851755wmg.44.2019.02.04.12.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 12:28:32 -0800 (PST)
Date:   Mon, 4 Feb 2019 23:28:30 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] elf: spread const a little
Message-ID: <20190204202830.GC27482@avx2>
References: <20190204202715.GA27482@avx2>
 <20190204202800.GB27482@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190204202800.GB27482@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -57,8 +57,6 @@
 #endif
 
 static int load_elf_binary(struct linux_binprm *bprm);
-static unsigned long elf_map(struct file *, unsigned long, struct elf_phdr *,
-				int, int, unsigned long);
 
 #ifdef CONFIG_USELIB
 static int load_elf_library(struct file *);
@@ -347,7 +345,7 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 #ifndef elf_map
 
 static unsigned long elf_map(struct file *filep, unsigned long addr,
-		struct elf_phdr *eppnt, int prot, int type,
+		const struct elf_phdr *eppnt, int prot, int type,
 		unsigned long total_size)
 {
 	unsigned long map_addr;
@@ -387,7 +385,7 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 
 #endif /* !elf_map */
 
-static unsigned long total_mapping_size(struct elf_phdr *cmds, int nr)
+static unsigned long total_mapping_size(const struct elf_phdr *cmds, int nr)
 {
 	int i, first_idx = -1, last_idx = -1;
 
@@ -414,7 +412,7 @@ static unsigned long total_mapping_size(struct elf_phdr *cmds, int nr)
  * header pointed to by elf_ex, into a newly allocated array. The caller is
  * responsible for freeing the allocated data. Returns an ERR_PTR upon failure.
  */
-static struct elf_phdr *load_elf_phdrs(struct elfhdr *elf_ex,
+static struct elf_phdr *load_elf_phdrs(const struct elfhdr *elf_ex,
 				       struct file *elf_file)
 {
 	struct elf_phdr *elf_phdata = NULL;

Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A64C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0C72073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re1JstSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfBDU2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:28:05 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:39555 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbfBDU2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:28:05 -0500
Received: by mail-wr1-f51.google.com with SMTP id t27so1315188wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 12:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LBClLUDFKscxAo7nqyeXZDoG4kGxLYqICy0GGs1PfUw=;
        b=Re1JstSqXE8hIqM9yWHTLzbwZEgN8ksYXPLsNLB+9TNs7/3JP7DD8MafZx64PwPwfv
         t5ECfGYDS9P6BB8oBG0CQebyuri9EewW2sSmqfH5JLsC5/6IZtPQnU1TdxRDbEWEPKlp
         OrFtllBb/Sjd3JJiB7NupsRK8XOqZ4Iwjk9dqQMvotO4IuJoqqiGNG6ae4S1YVkyMRvd
         zfSSvG6KhMaxFP/72pPsL7PxMbIdkpa7VtzIJi9fKBEXQj/6qLtsxbYpdYbHPFiO2vMQ
         T3uMOPLn5ff1EINJw/MCI9IbI9vM8NACZCs1W8OZVU9U68Q1iwkeCwoQeaWD1Vg4v0Qb
         7kUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LBClLUDFKscxAo7nqyeXZDoG4kGxLYqICy0GGs1PfUw=;
        b=qGcFEnwIrlZ9Gdh9NCkDIR+FPo+GuYgAfS9B3lzbHmGM/v8EfRil43AzIMTKkySAlA
         WmPDxRWruo/qIBkE6d7XGkrDsCcS8RIUq0rvCWCUJM1+m8OSGraF8yQIQoZbku2KnFb/
         9hT55Zmb0IP1tzcwltYuqBrh302fitapiwfwlmqAUcfNunowQwX/UOJWG0bo+R7YK/A4
         kNpzXtZgi/o8NWdlMqPfFnn4a5jfXg8RPwtvsaoYvYXH2s5rKwU+pyUlyhEqs6gaYONt
         pHCGYlsIrjhIK99Iq0ujUTRPM86UqUFdnPGOWse3sz7LMZYaKl4jBN+eyfVTDaL1obRY
         iCaw==
X-Gm-Message-State: AHQUAuZ1EOx8V97w7DHDteRj3/tYIL5wxGFTjkcXc15GRKiDMASCQV10
        cX4W56dGgM71BCDLvhR0V1Tlc4o=
X-Google-Smtp-Source: AHgI3IYCFFzsTel3udx7uJZyObvon5GV2NEmD1DFx3SXigd/3/1oCNwdqflwEJa9vELP6aBovzpkUw==
X-Received: by 2002:adf:f9ca:: with SMTP id w10mr855988wrr.189.1549312083508;
        Mon, 04 Feb 2019 12:28:03 -0800 (PST)
Received: from avx2 ([46.53.245.13])
        by smtp.gmail.com with ESMTPSA id w125sm28809479wmb.45.2019.02.04.12.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 12:28:02 -0800 (PST)
Date:   Mon, 4 Feb 2019 23:28:00 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] elf: use list_for_each_entry()
Message-ID: <20190204202800.GB27482@avx2>
References: <20190204202715.GA27482@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190204202715.GA27482@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2030,7 +2030,6 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 			  struct elf_note_info *info,
 			  const kernel_siginfo_t *siginfo, struct pt_regs *regs)
 {
-	struct list_head *t;
 	struct core_thread *ct;
 	struct elf_thread_status *ets;
 
@@ -2047,10 +2046,9 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 		list_add(&ets->list, &info->thread_list);
 	}
 
-	list_for_each(t, &info->thread_list) {
+	list_for_each_entry(ets, &info->thread_list, list) {
 		int sz;
 
-		ets = list_entry(t, struct elf_thread_status, list);
 		sz = elf_dump_thread_status(siginfo->si_signo, ets);
 		info->thread_status_size += sz;
 	}
@@ -2114,18 +2112,15 @@ static size_t get_note_info_size(struct elf_note_info *info)
 static int write_note_info(struct elf_note_info *info,
 			   struct coredump_params *cprm)
 {
+	struct elf_thread_status *ets;
 	int i;
-	struct list_head *t;
 
 	for (i = 0; i < info->numnote; i++)
 		if (!writenote(info->notes + i, cprm))
 			return 0;
 
 	/* write out the thread status notes section */
-	list_for_each(t, &info->thread_list) {
-		struct elf_thread_status *tmp =
-				list_entry(t, struct elf_thread_status, list);
-
+	list_for_each_entry(ets, &info->thread_list, list) {
 		for (i = 0; i < tmp->num_notes; i++)
 			if (!writenote(&tmp->notes[i], cprm))
 				return 0;

Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAEEC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867D7247D7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcT415it"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867D7247D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934427AbeFVT1d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:27:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51840 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933382AbeFVT1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:27:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id r15-v6so3224101wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 12:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BuNiJYXU55yPBiJ1qJb1TWqB/sJK+368JoJKHB6Tbg4=;
        b=LcT415it8xUOYXZP4EKMm7heKLOFfvEhEmwih1s5OKujT5SjiomQazif9fJdLRtEiS
         2DbzzDdlMgSIcHE5xM6rvSMb4lZfcmDEqgU5wlnLd9FgXpx/ivWLqdOC+X/093qMYQzG
         Q0BFQjuU0TA6v5DdBbYw6bBqrzgxJPgonff0JTLSWvi18EOaA9W27ARipsYYZ9us2Apj
         wKx2bJn8ps2LAqggCg/DbHNDrXIWWGT0nYEb45Bpcg5bIFgIBrBdvDjEch29RJVTRv8T
         cHtKV0V78n3M8LBh9OvwSvZLmkCIj00e0dLbW6kQa9lC7pZYH+mRCB0ng+OZ9y9gdG88
         w2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=BuNiJYXU55yPBiJ1qJb1TWqB/sJK+368JoJKHB6Tbg4=;
        b=Tnsvct64GFJ8CxBxIwc5s6VcUfZnh4q1PXIUBBBq665rxIMft/VttHdJafjWLjrqVU
         Mr2WPX7za3I9BCGi7gzHEImKj6xyIjqOKxcVvq9q4ypsbnJahsXUCAp45PzJXHZRDG0h
         ocoTcA+Pv50BId5Vj5RqZcYm3Rxwo26sqxdHcWSovAif9lyxT+WzEoZ3pF4O8mhh/Dmr
         yq7U+9RW06w/2JGWsbLqKMjeq4ou42gG2fh82MbbDg8414/Gd3EnmNapqEDmL+FjTGqk
         pyC3hIS1Hnf2RjFrxNUA/gZ3OUqVfagjZV9+neg19ZvGGx+ERsvLQ9rLtV9mBrOrP28g
         Lr+w==
X-Gm-Message-State: APt69E1/HXZMKN9ODOYOZ39Vk5yZ5IgloTtyt7APxKlZMAzXma5PAq/h
        brvLRPYfBzdvDck65kwK6Ps=
X-Google-Smtp-Source: ADUXVKJqaUwUNhMA5lDBpiOAh5trTRIE5EG0vSe4KAOHj9L3rTvBlrXHtxoE0JNmzBoGM5rN75LoTQ==
X-Received: by 2002:a1c:3607:: with SMTP id d7-v6mr2801210wma.39.1529695650868;
        Fri, 22 Jun 2018 12:27:30 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id s191-v6sm4063478wmd.27.2018.06.22.12.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 12:27:30 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 4D12810C0452; Fri, 22 Jun 2018 21:27:29 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Breno Leitao <leitao@debian.org>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?powerpc/xmon:=20avoid=20warnings=20about=20vari?= =?UTF-8?q?ables=20that=20might=20be=20clobbered=20by=20=E2=80=98longjmp?= =?UTF-8?q?=E2=80=99?=
Date:   Fri, 22 Jun 2018 21:27:17 +0200
Message-Id: <20180622192718.24242-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move initialization of variables after data definitions. This silence
warnings treated as error with W=1:

  arch/powerpc/xmon/xmon.c:3389:14: error: variable ‘name’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Werror=clobbered]
  arch/powerpc/xmon/xmon.c:3100:22: error: variable ‘tsk’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Werror=clobbered]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/xmon/xmon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 47166ad2a669..982848c784ff 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3097,10 +3097,11 @@ static void show_pte(unsigned long addr)
 static void show_tasks(void)
 {
 	unsigned long tskv;
-	struct task_struct *tsk = NULL;
+	struct task_struct *tsk;
 
 	printf("     task_struct     ->thread.ksp    PID   PPID S  P CMD\n");
 
+	tsk = NULL;
 	if (scanhex(&tskv))
 		tsk = (struct task_struct *)tskv;
 
@@ -3386,10 +3387,11 @@ static void xmon_print_symbol(unsigned long address, const char *mid,
 			      const char *after)
 {
 	char *modname;
-	const char *name = NULL;
+	const char *name;
 	unsigned long offset, size;
 
 	printf(REG, address);
+	name = NULL;
 	if (setjmp(bus_error_jmp) == 0) {
 		catch_memory_errors = 1;
 		sync();
-- 
2.11.0


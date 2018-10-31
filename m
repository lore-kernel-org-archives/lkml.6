Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E89C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA83E20685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPb+Z7nC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA83E20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbeJaVaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:30:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53787 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbeJaVaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:30:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id v24-v6so5120870wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 05:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=WgHkHlKH5h23Lr+mABtPK0cTX37CfKxS8tJSHtuvTgU=;
        b=OPb+Z7nC1bds8q6XTLEpUH8R3d7sSdK1ZoHBkVXN4fq3n0yPCB57hZONT7M0I+9H9S
         AyOC6E/S+3TKPjgSAyE3/Xk8RBzyxdBdtFFzypUx18EWM7hYGEYYcb4B0mRIW170Qt5f
         qf9HesTCPjTbDXfYCqh2lP/XGc+FLDfKwmSrvDb1lxUJUtJLk8+c8Y33bdghVIrNakPq
         Cwcwsn3rfDSnqO1rSo2mFe3AgGQFKGCmNm9PSFbKddWJCJEdSN+hipL+JUafWKaV9PMB
         ww4IDeT9E0TkRb1TAVbwQQNUNmM8xPFwWjM1MSAw9SbeE+4IuYJquGe1fYpIY5WVTU2x
         OHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=WgHkHlKH5h23Lr+mABtPK0cTX37CfKxS8tJSHtuvTgU=;
        b=t78dtppFisMFaIJjO8hKWpUZ6eXtzCLoXeuz0EG/7FOiHTkWxutoPTg890KuSPnAE8
         8Uw/Pn0gyyiKEAR5ZMQ73yyBtv+ZSEzlsVjW5WPOA5Tvyj3ssPuavznRs/j7m3R58T25
         xnscyMGNOblXn59oL5O29jf79AJEH3UFvTsSs4Dlke+UJKHMLhn6jaGuC88GS3Xv8fz4
         +/9RdOFHga/mCsqkBesZASD+zWj5lqKBO9lH/X5NAexQRHDMgCChBExGdWFUeNlcKK6R
         MfRMNtO6a8h35pPqdFQQcoSbtReBKJ6LuZIOAjmm8+aueb9DPA4CPisvCOI5kIzfU8NH
         3nJQ==
X-Gm-Message-State: AGRZ1gL8kk17QHw/nsPDtfep9I4atuy6vXHaRjVznb+9sphyx6yt3tfc
        z1mRpIDbLbb54aNr6BMxSeM=
X-Google-Smtp-Source: AJdET5fh+LKAmHufCXnnBYzzusrl7/Jg3ns1oFwjgqrqw353cRrnremPG2q6tATkA6aiRVG1BYP/Kw==
X-Received: by 2002:a1c:1694:: with SMTP id 142-v6mr2288120wmw.113.1540989132627;
        Wed, 31 Oct 2018 05:32:12 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id v11-v6sm17398781wrw.3.2018.10.31.05.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 05:32:11 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 4DEAE1142338; Wed, 31 Oct 2018 13:32:10 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/32: Add .data..Lubsan_data*/.data..Lubsan_type* sections explicitly
Date:   Wed, 31 Oct 2018 13:31:56 +0100
Message-Id: <20181031123157.24947-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When both `CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y` and `CONFIG_UBSAN=y`
are set, link step typically produce numberous warnings about orphan
section:

  + powerpc-linux-gnu-ld -EB -m elf32ppc -Bstatic --orphan-handling=warn --build-id --gc-sections -X -o .tmp_vmlinux1 -T ./arch/powerpc/kernel/vmlinux.lds --who
  le-archive built-in.a --no-whole-archive --start-group lib/lib.a --end-group
  powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_data393' from `init/main.o' being placed in section `.data..Lubsan_data393'.
  powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_data394' from `init/main.o' being placed in section `.data..Lubsan_data394'.
  ...
  powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_type11' from `init/main.o' being placed in section `.data..Lubsan_type11'.
  powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_type12' from `init/main.o' being placed in section `.data..Lubsan_type12'.
  ...

This commit remove those warnings produced at W=1.

Link: https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg135407.html
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/vmlinux.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 434581bcd5b4..1148c3c60c3b 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -308,6 +308,10 @@ SECTIONS
 #ifdef CONFIG_PPC32
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
 		DATA_DATA
+#ifdef CONFIG_UBSAN
+		*(.data..Lubsan_data*)
+		*(.data..Lubsan_type*)
+#endif
 		*(.data.rel*)
 		*(SDATA_MAIN)
 		*(.sdata2)
-- 
2.11.0


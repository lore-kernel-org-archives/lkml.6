Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3B7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAEA20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7Lsl9aO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAEA20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbeGQK2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:28:14 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34172 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbeGQK2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:28:12 -0400
Received: by mail-pl0-f67.google.com with SMTP id f6-v6so253535plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 02:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OP9d8s3+jqqX8NpZ8EoaEbYX0CdFVbr8J+seeihCynU=;
        b=e7Lsl9aO+i1IRwaIRT8vQAUEKEhsUdBBUZ2gT9a7iBVFjYD9HhSk/J2yWDGnNEHFIl
         y2jCvDcLwFNLC4erdD6tPs9JFPHBPQ5U1FVop7dQ4loYt4JOoGe2TMCzWkT/ouAGUnrj
         t0VEXWJqQQyAJiT72swrus94bR4rhkJjs7caRknwP2Vc/elL3cQeoY/Pqj8ZkiwRZUTe
         tzD2tn/mFR2jx9lfimfPN6v2FiNHUxtqKM8K7ljaDaeLmcXAUe4cKDyjDVmZJtZz2ak3
         oadkc96eEuLe7xU7wqgYr8eqb0l9LPCpUd3O8otHuJgdhUyo0J4osQwM8Zt4qp/hTrql
         cRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OP9d8s3+jqqX8NpZ8EoaEbYX0CdFVbr8J+seeihCynU=;
        b=CifnYp0palc0OhShDwRyCYEDTv78Gp15cK4R+0r6kj+3o/ix+cc9kycCpknehd6/RF
         sqVd9PVmb6HibiTo8a8kBGB7Z8dt76qU3vUGj6afKdHksq4+sUI8hm6MqXol4NVWQjz3
         mxGsNuIqD9eajAgUfnKu1QYNHvIObnXhMPUDf58IpJD0zds8fkeQpWiRcCOXuPM6mgrB
         IoXJQQC+ujPTzF+uRh3R8dGOefYi0cuLfVxoU9jv6HKARDVOXUVnSGOZRohsb48Lur0T
         gugVVnGQbCBdgFMH2NHDjZXhJsm/C1CiTu521B6U2ap00JRcKZRT4n1EVpwP/q28s3J3
         zIqA==
X-Gm-Message-State: AOUpUlEErd8Egq14OeKWgzelrTo/a42swBb0p4RkuLL3cxGuNYg/DBwE
        Pl+wf5GdNvVfWglv9YpZs14=
X-Google-Smtp-Source: AAOMgpeFWy8NzJtPcpicWcbBfzfvz6ICiKhnH1Nyskbs62T0BjeF/Oc3myv7HQWUVlMsoT42xG4Z2w==
X-Received: by 2002:a17:902:8482:: with SMTP id c2-v6mr968334plo.45.1531821384634;
        Tue, 17 Jul 2018 02:56:24 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id u2-v6sm1232542pfn.59.2018.07.17.02.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 02:56:24 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] arm64/mm: Move {idmap_pg_dir,swapper_pg_dir} to
Date:   Tue, 17 Jul 2018 17:56:02 +0800
Message-Id: <20180717095608.11008-1-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 4 changes:
	1. Rename INIT_DIR to INIT_PG_TABLES and move it outside the
	   '.init.data' section[1].
	2. Move the 'count' calculation to clear_pages()[1].
	3. Rearrange register in __enable_mmu() and pass ttbr1 through
	   the x1 register[2].
	4. Add commit message to explain why we can make swapper_pg_dir
	   smaller[3].
	5. Rewrite in_swapper_pgdir() and use pgd_set_fixmap() to
	   populate swapper_pg_dir. At the same time, add a spin lock to
	   avoid race conditions[4].
	6. Move {idmap_pg_dir,tramp_pg_dir,reserved_ttbr0,swapper_pg_dir}
	   to the KERNEL_PG_TABLES macro. And put this macro after
	   NOTES[4].

v3: https://www.spinics.net/lists/arm-kernel/msg662537.html
v2: https://patchwork.kernel.org/patch/10485641/
v1: https://patchwork.kernel.org/patch/10476595/

[1] https://lkml.org/lkml/2018/7/6/238
[2] https://lkml.org/lkml/2018/7/6/239
[3] https://lkml.org/lkml/2018/7/6/243
[4] https://lkml.org/lkml/2018/7/11/782

Jun Yao (6):
  arm64/mm: Introduce init_pg_dir
  arm64/mm: Make __enable_mmu() take the ttbr1 page as an argument
  arm64/mm: Create initial page tables in init_pg_dir
  arm64/mm: Make swapper_pg_dir smaller
  arm64/mm: Populate swapper_pg_dir by fixmap
  arm64/mm: Move {idmap_pg_dir, swapper_pg_dir} to .rodata section

 arch/arm64/include/asm/assembler.h | 29 +++++++++++++
 arch/arm64/include/asm/pgtable.h   | 66 ++++++++++++++++++++++++++----
 arch/arm64/kernel/head.S           | 45 ++++++++++++--------
 arch/arm64/kernel/setup.c          |  1 +
 arch/arm64/kernel/sleep.S          |  1 +
 arch/arm64/kernel/vmlinux.lds.S    | 47 ++++++++++++++-------
 arch/arm64/mm/mmu.c                | 34 +++------------
 7 files changed, 154 insertions(+), 69 deletions(-)

-- 
2.17.1


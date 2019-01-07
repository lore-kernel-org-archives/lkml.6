Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64226C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0922147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ddH/1tiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfAGOxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:53:19 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34560 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfAGOxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:53:18 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so270246plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 06:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=C4W4tGQs/4aSuOdcjVltlo4CS5kRV1BEfEL5UEJ/zjg=;
        b=ddH/1tiTLkcAh38u8Y225jplQlfMckshzN/Plqs8z9BhFN2zcAHGm5KSbAc19KPbB2
         6gZkMleICfQI5eauxg63VnNe2zFq1NWJSNBf57hE8oT5VKRwzeD0Za7LztESa9zBvgH/
         AdL4+JfMVdziFf0O2+q86VQ5x3CcrdMx36fug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C4W4tGQs/4aSuOdcjVltlo4CS5kRV1BEfEL5UEJ/zjg=;
        b=siUHdoLlrlPTo1W3ZHBEz4nm9avpY7FYrrq+LyKmzFzzVewBRrAYHyHAmbGun8uRR+
         V+BLdqifR0EWne8CXfsgcCvQLPG/ABSh8avwvwzo82PLeiE3cPC2Slt8fa9Z1Gx/KyTy
         bLH75VtirH3Ude87tptHkyBtcnVyPLEpHm+rUc5FeeaVDuSLLPpkwEpm0QmAKgAnt7XO
         NmOUbxGeQ4iRloWiWRmcITiZQSc80LhAD3/izZNd339OcVnUtN94HqAQ5CFhzUIAVyMu
         DTzlhKP024oyV5OR4qKTBq6LI+tu/gU4YI57kpvxEtk8NXhTQjayOuw+wv+IIN6mOACg
         BhJg==
X-Gm-Message-State: AJcUuke2VppDha3RxW2+cKnEF0fWJHcqSf2IqZZhyZC4vG3aeP1hs8n3
        8ZheTKn82ylebVV+D2dT4QJS/A==
X-Google-Smtp-Source: ALg8bN7oyWgYzBfL6s8XsMB/NZRf9W/DuDwrMrW8GAwMABAQQ1TRTdRgjAujwy4o+wB/69fl8GZFng==
X-Received: by 2002:a17:902:9045:: with SMTP id w5mr59041293plz.32.1546872797321;
        Mon, 07 Jan 2019 06:53:17 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id o84sm121145584pfi.172.2019.01.07.06.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Jan 2019 06:53:16 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-c6x-dev@linux-c6x.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 0/3] c6x: system call table generation for asm-generic
Date:   Mon,  7 Jan 2019 20:22:43 +0530
Message-Id: <1546872766-3354-1-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be an automated scripts to provide easy support
for add/modify/delete the system call entry by add entry 
in respective syscall.tbl file.

System call table generation support for asm-generic is
provide for c6x architecture which will use the common
scripts resides in scripts directory and use syscall.tbl
as inputs. This implementation will replace asm-generic-
/unistd.h.

This patch depends on:
 https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/
 https://lore.kernel.org/lkml/1546520681-24453-1-git-send-email-firoz.khan@linaro.org/

Firoz Khan (3):
  c6x: add Makefile to invoke syscall table generation script
  c6x: add __ARCH_NOMMU as a bugfix
  c6x: generate uapi and kapi headers

 arch/c6x/Makefile                  |  3 +++
 arch/c6x/include/asm/Kbuild        |  1 +
 arch/c6x/include/uapi/asm/Kbuild   |  1 +
 arch/c6x/include/uapi/asm/unistd.h | 15 +++++++++-----
 arch/c6x/kernel/sys_c6x.c          |  3 ++-
 arch/c6x/kernel/syscalls/Makefile  | 41 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 58 insertions(+), 6 deletions(-)
 create mode 100644 arch/c6x/kernel/syscalls/Makefile

-- 
1.9.1


Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00EBC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFCF20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHpf3pfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFCF20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388827AbeGXVyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:54:44 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:34463 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388604AbeGXVyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:54:44 -0400
Received: by mail-pg1-f171.google.com with SMTP id y5-v6so3702610pgv.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 13:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rd00ppayFTAhJT13a14Fk1ThMfDRwB/IV1E03cn8Dz0=;
        b=QHpf3pfKjQc4DTzxpqIVyocXwGzf06unpj+Yo7jdIx0NIy9UesuG2XaZWluzkP25pG
         CeAnPsTMIImplE94ghxNfUJ/3Zu1kVO5dOFhNdwINBbeW8prSD+XwoZyRIE5PkNg93S2
         IlkeT/HQlrJUFz6QJr/Lchiw5r1dfhpfLe7lmBUD8RgdDyhYmCAh246Mji/pjuDrAcAt
         6rGUOHob4VtYSYLRI5qHmtDfYdJSZ3xHnDP7FkgyHktSGy9C4mRSMh83ZrCtxR0qKjmd
         yLTu55KvEx+qVYpDCRRLtMzz5fisvMoSpsv7kAg4IEW1dM8EXmt6n69b64oFsYaRoO1Q
         O5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rd00ppayFTAhJT13a14Fk1ThMfDRwB/IV1E03cn8Dz0=;
        b=Ypbg0i67G7kUVSPBKmQ2stcxrQFs9Ua5SWphmjJUDNtRFUI69QLQIYhd5FAsbRL94w
         ZLnnPtJTcmcMcTfr/1yamFE6/eGzHkjd1CsrZxDkuVzYoKFiYXJxkFCkOvy6VNr3klSO
         CGoJ2zIxy5CkLSjL2vISYZZAuVx8J1n5IpVf7UfMpktc5rAfI3QRvapzEgm8qOdrcxsx
         nVyelHur3KhID0ISxJBq273biK0dk+CQB3f37w9RZTxt9y8Q/R+g/FmURwF2JuYkzuTb
         OG80CHj4QoKNYjWgjw582wIrQGxOED/h3A0hDUwyeOXCFPkLRYUHwwWQasNTuZRk6b1S
         LpPg==
X-Gm-Message-State: AOUpUlFyAIQ/UhU2MwcmfJZ78PP5CJBopjLNLkckeBrYIda1FgPSwZi9
        0HLIVaYkP0OricFV6KNSOa/43tcJ
X-Google-Smtp-Source: AAOMgpftaAwtU38Z7DSNuBQfqgChbb7mLqkdXjMIbeuEBkj2GrgMOXzO9tq1zvwpGC8ja5RcPRfhTg==
X-Received: by 2002:a65:5286:: with SMTP id y6-v6mr17766403pgp.65.1532465190016;
        Tue, 24 Jul 2018 13:46:30 -0700 (PDT)
Received: from midway.home (static-50-53-52-16.bvtn.or.frontiernet.net. [50.53.52.16])
        by smtp.gmail.com with ESMTPSA id t21-v6sm21536110pfi.73.2018.07.24.13.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Jul 2018 13:46:28 -0700 (PDT)
From:   Randy Dunlap <rd.dunlab@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Ofer Levi <oferle@mellanox.com>,
        linux-snps-arc@lists.infradead.org
Subject: arc: some allmodconfig fixup patches
Date:   Tue, 24 Jul 2018 13:46:18 -0700
Message-Id: <20180724204622.2366-1-rd.dunlab@gmail.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Hi,

Here are a few patches that fix build errors or warnings that
I encountered while doing arc "allmodconfig" builds.

These patches do not fix all of the build issues.


 arch/arc/include/asm/delay.h            |    2 ++
 arch/arc/mm/cache.c                     |   11 ++++++-----
 arch/arc/plat-eznps/include/plat/ctop.h |    1 +
 arch/arc/plat-eznps/mtm.c               |    6 ++++--
 4 files changed, 13 insertions(+), 7 deletions(-)

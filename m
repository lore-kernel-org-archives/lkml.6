Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF909C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889B720685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbtm3Vs9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889B720685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbeKFAAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:00:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44278 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeKFAAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:00:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id j17-v6so4661871wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 06:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Km825+85SpwT6OL7WxEGVjzI0rN5HmKE1nN73PZAbRY=;
        b=sbtm3Vs9lnWBRIn7DYOsvY+Ohuvpk6elLiYg1uHG7Cqccvv9od9m0prQEoSWCEbciP
         k0hENR2uDXI4AiV+1tUgVA8qADQVtgrKc0dEbL2ujNTb+6gMKVZKzaU6JTECyYH1Prms
         XyXeNKihxFynukv3tnFeVrwGKk6Jbeeuu8qKhaeKTdUWvoN3bOtxmnkmuGcJ149kULo8
         jpbXc+O2Q8uVOZWzZREoA26fw9oULXxZDxPwZYpBEBRpOeV3QqMRAS1sVZr+/58BGUXj
         m5lPEYeJVKetuHnkyiXvbcv3EQXx9YoJ2HcXjXBre+s35faJ2+QrUvdA8ev5bwsVs2sx
         c8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Km825+85SpwT6OL7WxEGVjzI0rN5HmKE1nN73PZAbRY=;
        b=dPnB7kXh0ya04/xiWwOoRa+z81EpqC8VIeQrAvK/O+H5GKGngF88Xkim8S0Icx3P2y
         6ILtiVc6YWk17XwPB/1Ha0qzo4xx2dxs2G7F5KkJrvEbuTSA72LaYA9Qog6zTXV8dqS5
         bKBKk/kcqOqkUDU9ShBtHB5GVqx/Hqkt0S9vkY4je8Pqm17IDxYxUde0eoyEVxl9s9IQ
         UECP8BLmrdRxJAmSX0xheF3sWz3J1HJ20cYTOKqrmweWdibTZXueeQZeoqYoEvFlEv7x
         LXlrthUS+BFcxpbF2O2N4bvm2XRAsaDndBzxEjpWL17Y7mjag4aO5bWGBNEIMOmmGnLG
         qtWg==
X-Gm-Message-State: AGRZ1gKrQLs+H1GEj6UXp07MkYxCfA/4z6Qo9U/TTnVbVY9AB/XhtpKv
        0fI7RxrtiG/qYhWEsxvuDM0=
X-Google-Smtp-Source: AJdET5dovkIWMsL56D2YRurZepz8AHbuijPFXBFOTAhZzeikL/+QSpLNReIEu70aIXHtcanYSX6b8w==
X-Received: by 2002:adf:90af:: with SMTP id i44-v6mr18455036wri.77.1541428811867;
        Mon, 05 Nov 2018 06:40:11 -0800 (PST)
Received: from localhost.localdomain (ip-76.net-89-3-178.rev.numericable.fr. [89.3.178.76])
        by smtp.gmail.com with ESMTPSA id e66-v6sm3783346wmf.40.2018.11.05.06.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 06:40:11 -0800 (PST)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH] riscv: fix spacing in struct pt_regs
Date:   Mon,  5 Nov 2018 15:40:04 +0100
Message-Id: <20181105144004.28267-1-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 8 spaces with tab to match styling.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
---
 arch/riscv/include/asm/ptrace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
index 2c5df945d43c..bbe1862e8f80 100644
--- a/arch/riscv/include/asm/ptrace.h
+++ b/arch/riscv/include/asm/ptrace.h
@@ -56,8 +56,8 @@ struct pt_regs {
 	unsigned long sstatus;
 	unsigned long sbadaddr;
 	unsigned long scause;
-        /* a0 value before the syscall */
-        unsigned long orig_a0;
+	/* a0 value before the syscall */
+	unsigned long orig_a0;
 };
 
 #ifdef CONFIG_64BIT
-- 
2.19.1


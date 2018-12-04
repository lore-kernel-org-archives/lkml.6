Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DCFC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51D52082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="gopouSyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51D52082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeLDOLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:11:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33703 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeLDOLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:11:22 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so7443957pgu.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 06:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rquojr46N0DT8TNw1OqodG4b4JFdn/DRt/UImRH2pNs=;
        b=gopouSypkCUDiKsYoLEe34rSJgyCu3D13Whb2hsHrWlUMo9FK1M9GD0JjmxxQlAu06
         DC/fyyVT+JQZ8LwBpjwQL7BTT2sY35HrAqonl03n2Qz5l+aPJOE4S9bRm+FvX4fp0tcw
         ngrWx3s2pdaqyY0NmevKTqf8meVtOV7bYjQ5JfvRnB5dHPlTbzKZ+6XkH4KbrUXQvGs1
         Q7Dgwkxma55agw3W2UAgAYcG1ftTDeSX8rCEcudNsyEat86SEXKfg59g/NTe4JgQH6Ox
         sWAn1adcanyWHyjvCK0q2eLi9f4EgIlZw8iKMglVt8MzJHhQHWHhcMPJlO8gXz5GVkEf
         6BKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rquojr46N0DT8TNw1OqodG4b4JFdn/DRt/UImRH2pNs=;
        b=BnaDQZ3JqgWim2M/trM1RxJzNFnM4EEefjaeg0cPWJKzy+CvYGaFjUBZHv8GA9IdpD
         smKsGnYc2du+7PKZm/CDG3DWrXY1XYhCc5/mVQmR0ZleToXQfQzr45YHGLuU74BeorWx
         4GGQCktM/ZgVBgZr9HZHjBO4U4VapEDdoz+1h6R8eeUQmrGvHnYT286jqsvlrYzLC73g
         VwN0zjufX39fPPfrDT1oxHcKmTyIfc1BZXSk8vAXpWFzpCeVpwysuDOdr1Oi0c00vx/I
         28VYx6zvFjwnnmDVDq5fP4jOItKs8Bd8PWzEvyE/PHHopzKqui8AAd4WSCkfIItTK0Ia
         ftGg==
X-Gm-Message-State: AA+aEWZRvIN2EzYkNDTtVYUf/YrlTglN6qEkJwh6xwpChjr7vTs25UlR
        au/JnW6rzIyt4DV83HSxk5WoEg==
X-Google-Smtp-Source: AFSGD/U2ACi+EMyJKkM+0b6OcU8NBpdc3iaZaawwGFLQGWmj3usKTeCb5cqTPEnNsYR7r4P0oDOtoA==
X-Received: by 2002:a62:644:: with SMTP id 65mr20270358pfg.161.1543932681416;
        Tue, 04 Dec 2018 06:11:21 -0800 (PST)
Received: from anup-ubuntu64.qualcomm.com ([49.207.53.58])
        by smtp.googlemail.com with ESMTPSA id k129sm31298884pgk.29.2018.12.04.06.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 06:11:20 -0800 (PST)
From:   Anup Patel <anup@brainfault.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH 2/3] RISC-V: defconfig: Enable RISC-V SBI earlycon support
Date:   Tue,  4 Dec 2018 19:25:06 +0530
Message-Id: <20181204135507.3706-3-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204135507.3706-1-anup@brainfault.org>
References: <20181204135507.3706-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables RISC-V SBI earlycon support in default defconfig
so that we can use "earlycon=sbi" in kernel parameters for early
debug prints.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index ef4f15df9adf..f399659d3b8d 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -46,6 +46,7 @@ CONFIG_INPUT_MOUSEDEV=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
 CONFIG_HVC_RISCV_SBI=y
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_DRM=y
-- 
2.17.1


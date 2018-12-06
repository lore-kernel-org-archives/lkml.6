Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A518C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117D820838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxNMS0N3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117D820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbeLFK0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:26:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36216 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFK0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:26:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id u3so22666044wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 02:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JIo8gyovFcHHP3y/e5BB5AOjOQoS1zn42GCJihBO9/4=;
        b=SxNMS0N3R2K/psBC8KX6M+4h/Jk02fnlru1t5rd/nTFTy4RXW3F0Qt0KHr7Vj4+R2d
         dBBZSYMGLHtwpY4zkmt+rI4izAEdka5gOtgjE54kQP0YQqPtwaJ/DqVpSSWIhGOOAQZR
         xbnYzwKHSiDMfh6PR6Jx88gb03KcB+uZGSbxy1hKSIUflOhmXG7FoX1jV7FQk1Z8N/J5
         JfCXYR7xJb6w2/JO+AqUunApTjqWFpbbewuW1WF+rSwagXjVStYDHhXE/+/LdPHs0myH
         8gOCCH9nm8mnAMun/uJNHE27kML/5iFFaqU6OnaXKBAobZi+nH/mhs4EJexz0ivMTo1C
         GiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JIo8gyovFcHHP3y/e5BB5AOjOQoS1zn42GCJihBO9/4=;
        b=oqRwo4WxoGWP/jzadM4F7vPriDIE3uoeyI//5X4mTYi1GECzalq7372fTEIP0Ul4iY
         BNQeyJ+azWphrE0mqqSRhzcHwk/jsnZuHBTfeTkzae9+nFOCnSB2J0TWn1lpsJvGJqPX
         Y19zIpff2VTLBOKhn2jqF6yaHUZyBtq3d6GP24ME6NiN9CsfASPu4qK1c2Vys7fEm067
         7r+HQ/StZMQelzz9aLgV9rpO0b+dccGeh09kKMrcSyQjcuYfOFYzOwDciezX74og9/Mv
         +uiiltPUTOWgPO501+j6ZiV1WHAYdS4nEQi1CPRZ2UHTFHU8+Gi7XneYf167EZSZLIEs
         UdzA==
X-Gm-Message-State: AA+aEWauJVLu9YX21Iuhcg+3oMj7tyH70u9c4MkFQJF0TsYBB2lpGn2H
        OWpFnnN6mHYKn4SKS0UyurM=
X-Google-Smtp-Source: AFSGD/UUSGuJ8qCxB5+P9wUNNlK41wW6I1rFngcEZC0vI2YeNVjiVxbw9dT91H2NXvKvUOcD9XPvjg==
X-Received: by 2002:a5d:69c9:: with SMTP id s9mr494844wrw.129.1544091996274;
        Thu, 06 Dec 2018 02:26:36 -0800 (PST)
Received: from localhost.localdomain (ip-76.net-89-3-178.rev.numericable.fr. [89.3.178.76])
        by smtp.gmail.com with ESMTPSA id z8sm20453938wrr.52.2018.12.06.02.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 02:26:35 -0800 (PST)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH] riscv: remove unused variable in ftrace
Date:   Thu,  6 Dec 2018 11:26:26 +0100
Message-Id: <20181206102626.2557-1-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed while building kernel-4.20.0-0.rc5.git2.1.fc30 for
Fedora 30/RISCV.

[..]
BUILDSTDERR: arch/riscv/kernel/ftrace.c: In function 'prepare_ftrace_return':
BUILDSTDERR: arch/riscv/kernel/ftrace.c:135:6: warning: unused variable 'err' [-Wunused-variable]
BUILDSTDERR:   int err;
BUILDSTDERR:       ^~~
[..]

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
---
 arch/riscv/kernel/ftrace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index c433f6d3dd64..a840b7d074f7 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -132,7 +132,6 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 {
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
 	unsigned long old;
-	int err;
 
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
-- 
2.19.2


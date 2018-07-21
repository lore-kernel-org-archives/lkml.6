Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C81DECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 21:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322CB20854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 21:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDoqf9A+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322CB20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeGUWOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 18:14:11 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35772 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeGUWOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 18:14:11 -0400
Received: by mail-qt0-f194.google.com with SMTP id a5-v6so13312308qtp.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 14:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:reply-to:organization;
        bh=alr++acJZndVpVDYxC46i7EI+g2gGGzbImppcFILxAs=;
        b=eDoqf9A+Y+K5EeQ6+5CwJxvgzvS8pTV+AwMu5OD9KyyPGSVLqkMzt6MIybxhsetMNo
         54WAHU9sg1Bb+4NIGx9NdZSSwtjYemkiibvFCsHh5NxTrQwOTXw2QfGpRB7uWEYVi47Z
         fwlzwdlFMn9XNbZRfnOi1gFvfPGfeztgHyRckd1TT14GgqimO40+rE8eSLR0+w3bOfZL
         smGLGqWyTj8yJwk0TVq2lALyWAeuYdlfDmfYbOOOPpdJcyusaEQblkahMCk6UOlthjZh
         XpJtekxcN+bsS3nLlYNQSVWooIR97RsTpqT8dNWaD1t13sqygNJcKArSCO31TRiPhFOa
         xD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :reply-to:organization;
        bh=alr++acJZndVpVDYxC46i7EI+g2gGGzbImppcFILxAs=;
        b=Lv2QQNzRwNrQPO6bJwe2GTW8YEdxInQpuz+7S3Woh/0fWg40G0lAqKTrFgufEgzfoA
         5qREKaqE4YbkIKX5Lp2NKFMQmGqqWruDBo5VVGzoMi7C9+BBNzN53t7oM4wHI1FRIZu7
         XGOskZgEDsM2uDH4uo5ji6H9LONOeadPmhUWA+pQQoyuyoe7UyREp4GO+WCHgn28XuPA
         2dnoGk60Qu0ghBMu3ocTnQ1QnEzT84txdSjvC63vzmSF+Ecx3wb6CQapIIGxdwWBoffg
         oQOxQzL2BJ4lVab1evT1vRxjSMkXIxryRdPpRuCYNv0kiCLmONZIKu7vfkrKsdLFX7Lu
         blTw==
X-Gm-Message-State: AOUpUlG6O360dDIdn4vxeZsZsX4HNSvjDttxiFJ6tkuPGOK1mqwOVTJU
        HtpPM5X+QCIrY4+t2LWlMqs=
X-Google-Smtp-Source: AAOMgpf7xofiG32PVBt1Ciymwvktz/Q+XM58tYcJJOw+ld5+KzlfrLzuVaJy7ei1BCCmxng1dwXnPg==
X-Received: by 2002:a0c:814e:: with SMTP id 72-v6mr6232407qvc.29.1532208003113;
        Sat, 21 Jul 2018 14:20:03 -0700 (PDT)
Received: from localhost.localdomain (h66-222-27-236.cntcnh.dsl.dynamic.tds.net. [66.222.27.236])
        by smtp.gmail.com with ESMTPSA id d4-v6sm4060240qtd.72.2018.07.21.14.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 Jul 2018 14:20:02 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 1/1] x86/apic: Future-proof TSC_DEADLINE quirk for SKX
Date:   Sat, 21 Jul 2018 17:19:19 -0400
Message-Id: <d0c7129e509660be9ec6b233284b8d42d90659e8.1532207856.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

All SKX with stepping higher than 4 support the TSC_DEADLINE,
no matter the microcode version.

Fixes: 616dd5872e ("x86/apic: Update TSC_DEADLINE quirk with additional SKX stepping")

Signed-off-by: Len Brown <len.brown@intel.com>
---
Without this patch, upcoming SKX steppings will not be able to use
their TSC_DEADLINE timer.

 arch/x86/kernel/apic/apic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b203af0855b5..5caf8890fbe4 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -573,6 +573,9 @@ static u32 skx_deadline_rev(void)
 	case 0x04: return 0x02000014;
 	}
 
+	if (boot_cpu_data.x86_stepping > 4)
+		return 0;
+
 	return ~0U;
 }
 
-- 
2.18.0-rc0


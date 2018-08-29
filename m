Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACD9C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E4120657
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVa61H5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E4120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbeH2Tld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:41:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41600 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbeH2Tld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:41:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id b12-v6so2469105plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 08:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
        bh=ObMsyCXoi8o75WeBPtKajxOWs5WrMUXDu+BccTU4S/8=;
        b=TVa61H5Lbd26u2c5juU6jtayOqg+HOEVa5GRwU0TWt8fYtWUrtiql2QPjf6R7C1NtU
         NHc/CFH06o9OY4uQZ37E+vGZ1vCO7rZbJDoPkaWm9krQ+awX5S1y4ll+3SjV/FBUEM/h
         0uEKXQAHFZSQkL15txVhr08nMgswVhvyE46kInFq3h+1s5YjrVziKbWRzU4YKhj3bdvi
         S7kTfCQxCSChkmfbWtXQAaFXkxinzLOC3zZNft4VtQe+sUFjMczFHYsRS/cXmPs+JXhq
         hg9hiqIJrKc40ejiuOapg6MejnVcN+ktP5VTsNuun1rC4y1Xea4VrID4uZTijB2xvxZD
         aRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to;
        bh=ObMsyCXoi8o75WeBPtKajxOWs5WrMUXDu+BccTU4S/8=;
        b=C5zV8f+1M3LlIQ0tZPbvPmTmxmW7pZQTVGr8rkwq4DSCVtM9xzzZI7d0cvQlQBnPde
         oJo+qP57WraEOK+AHBS0tDLQDAoHTcQneBxtD02uNRKlqrP/UiHz6cG+NgCSmKPBylNp
         JutUKxjxeIzfYeuRqZTkdj3/vBKmkCtxqw/6V3+au6ISuiZXuX2eKr2WgynaTMxBUVwQ
         vXv6DOOl0Qi/sMq1WJn5cEqbtkbVO0H+3saT/T3epLizDxWlfbvO9kkYHFnI6GpsZ/9d
         El8Z8XjNTe6myuI6khTabd8TiiNksneG9TEAwzSq5zZC0hBJO2bailwe2vvCwMGJ3Z0x
         uhCg==
X-Gm-Message-State: APzg51B+HsjIZSFKRWLgECGUKzI/48Ts3fXNhUP3DqV8onNI+OP8Kn/R
        wAhUJX31umxojh5DUuOdVRY=
X-Google-Smtp-Source: ANB0VdZugLMKbbUc3AiWRyLekpAWiSPus0Z5V9CpQup8E6YRb9cRQJ+GGZBMREIB0NVpoUfi1W2Gag==
X-Received: by 2002:a17:902:1025:: with SMTP id b34-v6mr6564947pla.291.1535557441864;
        Wed, 29 Aug 2018 08:44:01 -0700 (PDT)
Received: from mhkkerneltest.corp.microsoft.com ([131.107.160.79])
        by smtp.gmail.com with ESMTPSA id z6-v6sm6178821pgr.41.2018.08.29.08.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 08:44:01 -0700 (PDT)
From:   mhkelley58@gmail.com
X-Google-Original-From: mikelley@microsoft.com
To:     will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        vkuznets@redhat.com, jasowang@redhat.com,
        marcelo.cerri@canonical.com, sthemmin@microsoft.com,
        kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v2 4/4] Drivers: hv: Enable CONFIG_HYPERV on ARM64
Date:   Wed, 29 Aug 2018 08:22:28 -0700
Message-Id: <1535556148-10452-5-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1535556148-10452-1-git-send-email-mikelley@microsoft.com>
References: <1535556148-10452-1-git-send-email-mikelley@microsoft.com>
Reply-To: mikelley@microsoft.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

Update drivers/hv/Kconfig so CONFIG_HYPERV can be selected on ARM64,
causing the Hyper-V specific code to be built.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: James Morris <jmorris@namei.org>
---
 drivers/hv/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 97954f5..c3e11a2 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -4,7 +4,8 @@ menu "Microsoft Hyper-V guest support"
 
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
-	depends on X86 && ACPI && PCI && X86_LOCAL_APIC && HYPERVISOR_GUEST
+	depends on ACPI && PCI && \
+			((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) || ARM64)
 	select PARAVIRT
 	help
 	  Select this option to run Linux as a Hyper-V client operating
-- 
1.8.3.1


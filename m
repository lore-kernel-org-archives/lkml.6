Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F2BC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAF7208AD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tda+0A4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AAF7208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeHJQdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:33:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35683 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbeHJQdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:33:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10-v6so4466910pgv.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=Ki08Jx3YnliSGLAPep/p6sfozxcIOOmrbzzkmFF5pxo=;
        b=Tda+0A4DXk/rpo/qbcFAfTQcWTgnIeg10hHf1aTiXdu5aX2DRdajj98G5hlpxpx4cg
         jBoijHE4hPS4PgVBIoURwlb/MH+v9zGAOassn1TfWQYBsDmTeVB7j14XyVvJGFSWDewS
         BynzY9EhMM4HSVaijlvumbmTRVxcnEJONovw7L3CWbRpitkESi+KsuIl0FN8f4g6Pdju
         R1gcDwUu79yZWjXNnmyei90U6DY+2m7PeT4SUD4SrlEkkgJBhEUlJ2VesD+zPx9ck1lW
         qMvFtlTeuM0BVYM+Yh5Xz6woXAHR1SMjAe2Oo4JpYUTIISv1bSCVA15kmFJHoBE+9nHf
         O6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=Ki08Jx3YnliSGLAPep/p6sfozxcIOOmrbzzkmFF5pxo=;
        b=Yjr556bnXLW2Epf3f5bDH303DH0PMyrXy74CLd8VPjzxEsXu/d7EUmW2E3qrumb+BD
         IaAZNiTVV4q9YDz1Kb98K+g/8zF62np9QWLwabdckGW2l+AZRgx14T2WjZA1Wvx+1zoK
         1gjScW2qSERhEBjV1lEPUy/RGXpOfxR39xfhxArj7UDVTamoGM38/b6lLQKKBgrISz7I
         q33BfdwIMNmPe7HHZXahUw9vDp+sVcJADCAYvwoRrcgmtBZZgQkMKvwGxcoShiJ7Yw9s
         giGJXGHgG5kAWkyjVQ8pSHvgY5Y2l8VjS1K+gRecsRKryIL8JRLXYQ0AwAxmiwmpHWuh
         6zIg==
X-Gm-Message-State: AOUpUlEWgCopKvQ8vyofThYUAf80QzJK19zRCEliLFRQ1IizsVlsAc0S
        VB/MT4Ee2vbbAHiYLluBTLRzzurv
X-Google-Smtp-Source: AA+uWPwU7pMAMtgmYdf7KBE4PbxYAejGCycAhsokRyRs3Jno5CsrTPOHOZe24sOTBGEaNnIWnFlnEw==
X-Received: by 2002:a62:cc4d:: with SMTP id a74-v6mr7298626pfg.200.1533909787606;
        Fri, 10 Aug 2018 07:03:07 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.51? ([2402:f000:1:1501:200:5efe:a66f:4733])
        by smtp.gmail.com with ESMTPSA id p11-v6sm17791954pfj.72.2018.08.10.07.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 07:03:06 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        hpa@zytor.com, mark.rutland@arm.com, swood@redhat.com,
        paulmck@linux.vnet.ibm.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [BUG] x86: kernel: nmi: A possible sleep-in-atomic-context bug in
 nmi_handle()
Message-ID: <75833c57-d263-3b09-8306-62b4a3e371c8@gmail.com>
Date:   Fri, 10 Aug 2018 22:03:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code may sleep with holding a rcu read lock.

The function call paths (from bottom to top) in Linux-4.16 are:

========== BUG ==========
[FUNC] kmalloc(GFP_KERNEL)
arch/x86/mm/mmio-mod.c, 237: kmalloc in ioremap_trace_core
arch/x86/mm/mmio-mod.c, 289: ioremap_trace_core in mmiotrace_ioremap
arch/x86/mm/ioremap.c, 243: mmiotrace_ioremap in __ioremap_caller
arch/x86/mm/ioremap.c, 367: __ioremap_caller in ioremap_cache
./include/acpi/acpi_io.h, 13: ioremap_cache in acpi_os_ioremap
drivers/acpi/osl.c, 702: acpi_os_ioremap in acpi_os_read_memory
drivers/acpi/apei/apei-base.c, 662: acpi_os_read_memory in apei_read
drivers/acpi/apei/ghes.c, 335: apei_read in ghes_read_estatus
drivers/acpi/apei/ghes.c, 941: ghes_read_estatus in ghes_notify_nmi
arch/x86/kernel/nmi.c, 137: [FUNC_PTR]ghes_notify_nmi in nmi_handle
arch/x86/kernel/nmi.c, 124: rcu_read_lock in nmi_handle

Note that [FUNC_PTR] means a function pointer call is used.

I do not find a good way to fix it, so I only report.
These possible bugs are found by my static analysis tool (DSAC) and 
checked by my code review.


Best wishes,
Jia-Ju Bai


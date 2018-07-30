Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBFEC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3A220890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gboBMiBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3A220890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbeG3VRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:17:47 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33111 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbeG3VRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:17:47 -0400
Received: by mail-qt0-f195.google.com with SMTP id c15-v6so13423615qtp.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 12:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a+ca1vxAOuJUacVS23AlXBFQEFdvj/NW90HJG+CvGmc=;
        b=gboBMiBmBaBk9/CH0BOU1A4/1xDdNiJycG/mgKI2cytRHsA7hoW6hV4aau5zhrviMd
         PNkjXwN27HJk5DTdfWrJNRnpiMpYB4K4LB/HIDyrKigG0XkxyVU0RS3g0q4f5hPghPW9
         Zk4sw00hQQZ7Iud50EcYLK6iepJO99N6OkyXMyaigWYWuaLW5VdkoS//FvOcOjcP5MRr
         yl/J1U/lYSJRmFsnbNtKcXtVDu5hqHMUgYCkWugqMSH4HX9obXQjoMb4Z886CU0fJO2x
         Rxq0DMOPgQVOb31cT4m1oU+/rU/O/AbWsI8okO0xMx+B01AIzeE62QhfXvNMYhXhLTGi
         jDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a+ca1vxAOuJUacVS23AlXBFQEFdvj/NW90HJG+CvGmc=;
        b=lnwd9x3oZvwBv4Up0r/sYaTXDD7lwK2tJ7Z51VU2kS3+I+kPpyoKlO+Wthpw+3ZqIP
         x6b5hcwMjD+Uofs0VCq5ogvTXTUkX/t9qsWlklQdkN2n229267W/dWqEgiQrcNQ8nwM4
         s3uerrBoEskX9LCt0zqVk5mw9JTMAJPogpkFyiADcw7cwO0nuigPUPSgGcDP5xXcE5ba
         YTObDRjs/WrJPIrGoyLJe2i5wFhtRtMpKFqAbogLkVdqM/TplF+dR1BxkNe9aLVrDpK6
         k8zkHmfo4ILK6ngCcYNND91fjZTARy6Cf19YVgf5PTZtB2oYdyWEEJGwyaM72fx7KP92
         QJrw==
X-Gm-Message-State: AOUpUlHR32JWARhaIXB4ypzBTpJgHgXxrmm6iqnUQ61wvkJhKHxNai9g
        PACFs2JkSHOIAzLxs9B/VmzklEA=
X-Google-Smtp-Source: AAOMgpd5pjoqUkF0846NV336nt+IPBV9kcvCMSqsvjMmd5QBLnD3kvGASa2cFQuFVful31EiKAtETA==
X-Received: by 2002:a0c:ae71:: with SMTP id z46-v6mr16371782qvc.108.1532979675373;
        Mon, 30 Jul 2018 12:41:15 -0700 (PDT)
Received: from localhost.localdomain (c-98-233-228-187.hsd1.md.comcast.net. [98.233.228.187])
        by smtp.gmail.com with ESMTPSA id t3-v6sm6619756qto.26.2018.07.30.12.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 12:41:14 -0700 (PDT)
From:   Matthew Whitehead <tedheadster@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Whitehead <tedheadster@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] x86: kvm: Restrict X86_FEATURE_VMMCALL to x86_64 platform
Date:   Mon, 30 Jul 2018 15:40:59 -0400
Message-Id: <20180730194059.5781-1-tedheadster@gmail.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

early_init_amd() is called on all AMD processors, both 64 and 32 bit.
Presently 32 bit processors get the X86_FEATURE_VMMCALL feature set, which
they do not support. Add conditionals to restrict it to 64 bit processors.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
---
 arch/x86/kernel/cpu/amd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 38915fbfae73..df06919324cd 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -662,12 +662,14 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 	}
 #endif
 
+#ifdef CONFIG_X86_64
 	/*
 	 * This is only needed to tell the kernel whether to use VMCALL
 	 * and VMMCALL.  VMMCALL is never executed except under virt, so
 	 * we can set it unconditionally.
 	 */
 	set_cpu_cap(c, X86_FEATURE_VMMCALL);
+#endif
 
 	/* F16h erratum 793, CVE-2013-6885 */
 	if (c->x86 == 0x16 && c->x86_model <= 0xf)
-- 
2.16.1


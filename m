Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F23EC64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5382082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ith00azY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5382082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeJCFbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:31:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41016 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbeJCFbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:31:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id x12-v6so3967962wru.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iKHwbOMexOHcGm3EoTgnHu1Qzjunj8XZb9aUUc9ghag=;
        b=Ith00azYF5YgAFr/bmp5cA5Q38x7WCl2upH2mjt5CJuMwyVs0BIp1VFRd7OHPzlmLQ
         EoQbOZzDdC7dXFBOnBe8AkpFiCOnQdkuL0wYXgNc+1C/C0/YKv5TOpW3gHNYiXtmX6uo
         TMD8exnvm1dOyIwtmwqbLYg4YufNWuO1F88Htf6lklYoUqC9E92VIAkodysH2pzDnULn
         coDfbjf7gu5U5vI/N7TQQy/q1TzNSYSdsxAFxDzSR7sNp5U/0PCaAPpI49T1eVi8vx6K
         yNkmpQ8ORoH383Xj1uIqW6T1aaDeULohNZzhg3UgAr8mDFuK39nVKNptbORAIOr4rjak
         QAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iKHwbOMexOHcGm3EoTgnHu1Qzjunj8XZb9aUUc9ghag=;
        b=nXhlPgJSh4Xnmeg4vBMtVLLzk7FxTxO0NsUoW7ybbD6sH+HbWLD1J+dGonWzv2k6fq
         r0bLmiZ9ewb0MrYAKqQKumH6zfnxmvff537K7g6T2U1t6Sv9tzOhZ9OZPixUsTu7Iyjm
         NMqX1efbI37pZtjhZnyb1alSJ/9wuTCEvT7imSAnGFVSIYOdQkX8wT2f8OW8HZ7VU8fN
         APxOBrxlxxXJeSxSKCo+UO3kn+E4vevGJptSxkvSFccNCD2521AonrC8npDuXi049H89
         CDjCo8D9N/IpbiyZEHCe+TY/iubRvrrDylzLJA2zrlwB6sV+2201K3TTKXXDrr4a5jCU
         w0zg==
X-Gm-Message-State: ABuFfogz5rLRemu5qG29qllibjkJZMSHcNCnPh8NQwmRWO6VCGmtHJV6
        78b/f1QE9m8xOrfAyUzbOYU=
X-Google-Smtp-Source: ACcGV601lvkJlfUce9fgdWcTHbzyA/j2CfkZ7M9PmxvIqQDxYNvNmxu2yOlx6PQgJ5yaNwwsEGSEAQ==
X-Received: by 2002:adf:f111:: with SMTP id r17-v6mr12554432wro.303.1538520319383;
        Tue, 02 Oct 2018 15:45:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id g75-v6sm25708568wrd.1.2018.10.02.15.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 15:45:18 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] x86/cpu/amd: Remove unnecessary parentheses
Date:   Tue,  2 Oct 2018 15:45:11 -0700
Message-Id: <20181002224511.14929-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when multiple pairs of parentheses are used for a single
conditional statement.

arch/x86/kernel/cpu/amd.c:925:14: warning: equality comparison with
extraneous parentheses [-Wparentheses-equality]
        if ((c->x86 == 6)) {
             ~~~~~~~^~~~
arch/x86/kernel/cpu/amd.c:925:14: note: remove extraneous parentheses
around the comparison to silence this warning
        if ((c->x86 == 6)) {
            ~       ^   ~
arch/x86/kernel/cpu/amd.c:925:14: note: use '=' to turn this equality
comparison into an assignment
        if ((c->x86 == 6)) {
                    ^~
                    =
1 warning generated.

Link: https://github.com/ClangBuiltLinux/linux/issues/187
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/x86/kernel/cpu/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 22ab408177b2..eeea634bee0a 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -922,7 +922,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 static unsigned int amd_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 {
 	/* AMD errata T13 (order #21922) */
-	if ((c->x86 == 6)) {
+	if (c->x86 == 6) {
 		/* Duron Rev A0 */
 		if (c->x86_model == 3 && c->x86_stepping == 0)
 			size = 64;
-- 
2.19.0


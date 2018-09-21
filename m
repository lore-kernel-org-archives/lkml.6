Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE19ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C7321571
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTKqW3eF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C7321571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391537AbeIVDLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 23:11:55 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44806 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391318AbeIVDLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 23:11:55 -0400
Received: by mail-qt1-f194.google.com with SMTP id k38-v6so3162341qtk.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 14:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IU0P6BrXFlMlgaLK7ko2MKMUICeD90odXc1dn/3PADU=;
        b=cTKqW3eF0J+1ghOisVt0bW1TqGwW9tDcx2DOzhQFJIsa6EDZIMj/T2tcGfKLjl21eC
         Wj+y2Bs7UNjoeGwGNG1RVbKovDyx3derY34oJ1xhYX9+G1s3gft8QmWgArWp73k98b9S
         hVbvCgPrgzxVBB9cxi2Sd5RPJ4euUL62tBkNv51MWV8Nq9jTdF8zLCtOpB3JNOYF97la
         MlqTY0nIhS11ZPnDx6ZMXfDZlSNFfQm4yJ2MjxOgs8jI7DjdTL0FAaI3aHxGysXozQan
         DQL1dUKAtz+fS28rOr3OGTingowI7fjLbsNO2HmuX8XrVkCzQNAhSK3TGOXXeLzLZ9MI
         cpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IU0P6BrXFlMlgaLK7ko2MKMUICeD90odXc1dn/3PADU=;
        b=M7b2lQFU9O0pdd0x6eZtZamMrWqlA+lLCE52kg3SYNBOhu9uRs1SLGHgC/DGdlY9Pv
         FGgHs55fYnCqC+EkBBq0OTC21yFUii0c/Rnu/ULc8MX5RuDmVQ4pDyhrZIM+8cKpfGmq
         pECfLK7vtHTKU3B84DgUKAkUPOtTYgKlbwHI/96gDc1H9TekY+xckEm6bfehRPwxSl9v
         YXRsjCaQkZXaIV5cu6Hq/K0A3ztsgxF2tmYJFuZq9IDUqqdv4nVT2MvxzASvQxF4tkxR
         jga8v+bHYxNQmjd73JrHH/UY6u0vWjRYp+b3RrqEehXsgS/htTPWLx8uIxVcB9JABtoW
         ZI5w==
X-Gm-Message-State: APzg51AuXhbyYX0QnxveWZf1XH97EhhN+Rn6vPStngKWRE6PI4x2c3jv
        dCN6MAsmeT+w1qCTeUb7pKGiiBI=
X-Google-Smtp-Source: ANB0VdbaQe/fNFsTaf6hgcU+6WZkQpGLjYOytlbQ9TZLiP3eE/mJdM1/tHcif4Pr3zQ8QO10rZFTgA==
X-Received: by 2002:ac8:2b78:: with SMTP id 53-v6mr34354426qtv.255.1537564873874;
        Fri, 21 Sep 2018 14:21:13 -0700 (PDT)
Received: from localhost.localdomain ([2603:3003:4107:8d00::5ce6])
        by smtp.gmail.com with ESMTPSA id f6-v6sm16740401qke.77.2018.09.21.14.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 14:21:12 -0700 (PDT)
From:   Matthew Whitehead <tedheadster@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        luto@amacapital.net, bp@alien8.de, hpa@zytor.com,
        Matthew Whitehead <tedheadster@gmail.com>
Subject: [PATCH v2 0/2] x86/cpu: Enable cpuid on Cyrix 6x86/6x86L processors
Date:   Fri, 21 Sep 2018 17:20:39 -0400
Message-Id: <20180921212041.13096-1-tedheadster@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On power up, the cpuid instruction is disabled on Cyrix 6x86 and 6x86L
processors and needs to be enabled. This patchset enables it.

Matthew Whitehead (2):
  x86/cpu: Use correct macros for Cyrix calls
  x86/cpu: Change query logic so cpuid is enabled before testing

 arch/x86/kernel/cpu/common.c | 4 +++-
 arch/x86/kernel/cpu/cyrix.c  | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.16.4


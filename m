Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521D6C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D63B2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="uGN7WWU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D63B2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbeKCF1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:27:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38519 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeKCF1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:27:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id p7-v6so1495804plk.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 13:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fmXmL1drLK2jBMrqIWQlv81ucFSfJxj9YZfzsbzZC/Q=;
        b=uGN7WWU5EXXelnqbKeZfxOm9szf3DuzWeuaEawriIOk7oH3SfMxr9Dz/V7+I2W2gfw
         /bFfz3UwvJ57hN1XLpoXlgEiAP4FnyJaAibwdJ0Zf1qOoYF/cwq9aaGSlxuk6wqGdwbU
         mbrhCCqGpAhmcq+jgEsnvZh6RLUlVQJwDrZrXrnU/RuPBkzoU5l9D9ED/hkiSwcgdLq0
         6fo1Jz8jWSRHDN7+fpXMgyu/f7I4bW+5AjtMdSHVkvFhh1xJL8EXbNofxbOGT5onVYiZ
         dL/rqZ4dOLAmLOEeWKWBPTK9T63QeYgXJxE/gDUI7qhBFctl8dBkjgPaCWKSFcPccjM6
         VSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fmXmL1drLK2jBMrqIWQlv81ucFSfJxj9YZfzsbzZC/Q=;
        b=XSFZjOXYFWYaxkhbvrhwUURsAjFZl2FUqaL6ilxGjpdnqzrUK69qlQUDFdpw77bxaq
         BiYjuVtTcm6XEziiIqMVrmapgBVCcLfEaI4X1DlINQRRiB36TcvoLLvjBx3HeQXVH2ZX
         ZcVu/o1KKvBx38UzOkUqSq5sDg9qN/DZ/b8XXIbkVHK5MEsOsiyADF3QL8dFBSw4XnAm
         Mp4GAWbptGZPD5uABVTv/BPECPUTActfV4DDbEwst+abvfP9MV9bmgjBmI/mgWMOLOCi
         bUynwyn0NngZNABPzNvtIQ3LQm3Df+PFPjJCb1v8Gpd6GqXAfM2bP8VVjjXVvSe2ibyR
         YPBw==
X-Gm-Message-State: AGRZ1gIi7Po7W4ijd4DKbWbVHRJDcR52oLNiQgMe0XzqniiEGZu8UG2u
        aTA5hAo+n797ioUbzstWVuVbfQ==
X-Google-Smtp-Source: AJdET5dYVR94n1U9uTV/NbX8cOb0zt+D0C3O9FlKFZYp2AnPhw+TO/T9wXK317tCJs15VjfhCzIZEA==
X-Received: by 2002:a17:902:7408:: with SMTP id g8-v6mr12658380pll.168.1541189917614;
        Fri, 02 Nov 2018 13:18:37 -0700 (PDT)
Received: from localhost.localdomain ([128.107.241.162])
        by smtp.gmail.com with ESMTPSA id h62-v6sm26641676pfg.27.2018.11.02.13.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 13:18:36 -0700 (PDT)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH 3/3] dlm: don't leak kernel pointer to userspace
Date:   Fri,  2 Nov 2018 14:18:22 -0600
Message-Id: <20181102201822.12518-4-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181102201822.12518-1-tycho@tycho.ws>
References: <20181102201822.12518-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In copy_result_to_user(), we first create a struct dlm_lock_result, which
contains a struct dlm_lksb, the last member of which is a pointer to the
lvb. Unfortunately, we copy the entire struct dlm_lksb to the result
struct, which is then copied to userspace at the end of the function,
leaking the contents of sb_lvbptr, which is a valid kernel pointer in some
cases (indeed, later in the same function the data it points to is copied
to userspace).

It is an error to leak kernel pointers to userspace, as it undermines KASLR
protections (see e.g. 65eea8edc31 ("floppy: Do not copy a kernel pointer to
user memory in FDGETPRM ioctl") for another example of this).

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 fs/dlm/user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index 2a669390cd7f..13f29409600b 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -702,7 +702,7 @@ static int copy_result_to_user(struct dlm_user_args *ua, int compat,
 	result.version[0] = DLM_DEVICE_VERSION_MAJOR;
 	result.version[1] = DLM_DEVICE_VERSION_MINOR;
 	result.version[2] = DLM_DEVICE_VERSION_PATCH;
-	memcpy(&result.lksb, &ua->lksb, sizeof(struct dlm_lksb));
+	memcpy(&result.lksb, &ua->lksb, offsetof(struct dlm_lksb, sb_lvbptr));
 	result.user_lksb = ua->user_lksb;
 
 	/* FIXME: dlm1 provides for the user's bastparam/addr to not be updated
-- 
2.17.1


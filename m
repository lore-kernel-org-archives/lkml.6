Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140D0C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AFF22507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XuGcgN50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AFF22507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbeKML7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:59:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35135 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730805AbeKML7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:59:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id 32-v6so4918337pgu.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 18:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=JM+S/eFsNskgo7atW/iBIZzDQR4tvlY1/M1nNBefE3A=;
        b=XuGcgN502rs9GsiYN10cXgrgKSex88J3/+pPISvc+m2TdFHfUDOnNFsNs6ZBGtV5qL
         Jj+0p0S1FE8+mMwy0k4BGzRJLNVOOJlEhMSVzRlhWNCaSGK4smyRQnUPoE7TOMT0UnIr
         1AwlGVZfM5qGDJ1jKKrAzTdaNhcvjf4TqrAFg0ScnkT5CjUBihY1i1D4eHc3FCYzjicL
         nGZKQnRH5kLKqz9tOnVTsI7o4QZSHHfSglDhfCzVdRIqPACRLORn1tvhJQlF34l/t+Ag
         c5jb7J0r1BHpXWgZzsrO0iL1cQc/Q4SWgDDdPMGXrnyVBcTLMpPV2aL+Qt+WchCqmG/E
         471w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=JM+S/eFsNskgo7atW/iBIZzDQR4tvlY1/M1nNBefE3A=;
        b=QtVTzLlAPMbdM8fcJ7c7xE/DEQ9yPqNyA0hMjeXKvycy2yftYnhMNoXVMtG0YBGKLQ
         FWtGJ4Mu7BWktQBA3k2iSCNXQ4PJ8nanUyrEQPJWq0lhs+4GWCJVNUrIpX/ylA7KIlTq
         C98XaV5+Gis4kY4LKtBdEWW4Iamf1B+BShdYkKH+T7koPkquGTvAOdh4tiHa+IwwOXTn
         G/0TAC1MJXLjK9wnBXaAr4i4AKZAtfXZ4y0zJYAnSLa3poyJB6gMQ5txPcyjxBlhV5Jx
         oTuDyOBWBe5rJ/0Kr3gA1qV8hV3Ii87J/+VjXKOPB7xDeMA6GSVd+OFWbJf0xI4ZVbey
         sgSg==
X-Gm-Message-State: AGRZ1gK3nTE3RARFpmK9JrxRPlk4w7xny3ujphRU3up5UFylq0TBdk2U
        0GOmEtCS2d/3QHl2YUt1BFUgRQ==
X-Google-Smtp-Source: AJdET5e5F9BMkGMJpsPyH9pjxG2eOrIWxjz1Z71qqgOUywCdnDfywSML5a9VGIZ5Wm3QckGBAzfIlA==
X-Received: by 2002:a63:31d0:: with SMTP id x199mr2982886pgx.10.1542074624095;
        Mon, 12 Nov 2018 18:03:44 -0800 (PST)
Received: from localhost ([216.9.110.4])
        by smtp.gmail.com with ESMTPSA id d65-v6sm24529216pfc.144.2018.11.12.18.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 18:03:43 -0800 (PST)
Subject: [PATCH 4/7] doc: Indicate that xtensa supports sg-chain
Date:   Mon, 12 Nov 2018 18:01:10 -0800
Message-Id: <20181113020113.29640-5-palmer@sifive.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181113020113.29640-1-palmer@sifive.com>
References: <20181113020113.29640-1-palmer@sifive.com>
Cc:     corbet@lwn.net, Palmer Dabbelt <palmer@sifive.com>,
        aou@eecs.berkeley.edu, ren_guo@c-sky.com,
        andrea.parri@amarulasolutions.com, Arnd Bergmann <arnd@arndb.de>,
        jhogan@kernel.org, dhowells@redhat.com, jcmvbkbc@gmail.com,
        keescook@chromium.org, yamada.masahiro@socionext.com,
        mathieu.desnoyers@efficios.com, mingo@kernel.org,
        rmk+kernel@armlinux.org.uk, Will Deacon <will.deacon@arm.com>,
        jglisse@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        david.abdurachmanov@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was suggested by features-refresh.sh

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 Documentation/features/io/sg-chain/arch-support.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/features/io/sg-chain/arch-support.txt b/Documentation/features/io/sg-chain/arch-support.txt
index eac96f99174f..3c85efb8bc8d 100644
--- a/Documentation/features/io/sg-chain/arch-support.txt
+++ b/Documentation/features/io/sg-chain/arch-support.txt
@@ -30,5 +30,5 @@
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
-    |      xtensa: | TODO |
+    |      xtensa: |  ok  |
     -----------------------
-- 
2.18.1


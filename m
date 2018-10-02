Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF590C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B59D206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3rqMQ+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B59D206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeJBT4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:56:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43295 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbeJBT4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:56:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id n1-v6so2160599wrt.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NvErLiPb7Dhi68E8otsA18THd2lbB+9b3/NhcG854Xk=;
        b=J3rqMQ+OwoWESxRlNUNZvjq3C/i5394uPASFBYI9muB/L1ZiyOZBCro1+FKtx6blgw
         Zf3QR0zbR9aBLw8k94HJn2BihJomkAwGXZ6D3IccQan79jH4+JXMjrtrO30iOwbiwlL7
         ZXwh97DJrxJryJEPEhuLlgAGLLAKtiHeczVtcczOfqs5HYQ7W2vG5CxdrOSeUx2uSvN5
         GAAUamfcPXwAaP0TYFJuhfKsE1NhlhzkhRgg8V0uSoEfQtqHCiPnIouALNbppfaPkHjL
         VYO3WaSNSHcsFRl7xSVGvwVKBnyNE6GtDLcbcOxwj/EAXF0Z2usZxGp1Hq2AoDKtY0gx
         DxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NvErLiPb7Dhi68E8otsA18THd2lbB+9b3/NhcG854Xk=;
        b=CaIm3DqY65P/iQMcxfkLBlWenRLXVd4MVzm2HhzqROwvumxDCcf6Q2Ms1yEQAAgc8G
         nUqj/MrNK4B1KRDzmSaeO2P/aB5HI1/5kEIMmcJ9hlELsV2qpnkiTl2N/rX2u3+ggbR4
         +VObYVAu5M3aCptROXEHoZX+lcOHrmkl5Bgxmbu3xDoU3GPV3tnTggkfFKe3VO9bAbwc
         56t03XffuJomJhn0ZJv0gY5nrw4Go9FLxDwPvG27E/kjw/HpEX4gGZ+31iHOdmJuLFn7
         I5YaEd4A/yxjeRP5V1xxqr1AuabKAmnB48mMDYGGEUaXfKXtiQbN8+gRkZkj8xoGgcQ9
         iXTQ==
X-Gm-Message-State: ABuFfojt4kqIakYuEDd4zytXBIM+dPsqk0bgtU1D24VARCwEFjibyY8T
        Med/QMzTogat8QfifsatomNtMQ==
X-Google-Smtp-Source: ACcGV63nabJtbVmhZN2ucFxis2mJLsrnliWxzagWfRZDa1M/aDSkXCme9Zu5EuIB9WfhAKLrjz02yA==
X-Received: by 2002:a5d:4101:: with SMTP id l1-v6mr6433311wrp.45.1538485973338;
        Tue, 02 Oct 2018 06:12:53 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id v10-v6sm17458681wrp.0.2018.10.02.06.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 06:12:52 -0700 (PDT)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v7 5/8] lib, arm64: untag addrs passed to strncpy_from_user and strnlen_user
Date:   Tue,  2 Oct 2018 15:12:40 +0200
Message-Id: <978d6bcda7f6cc9420d77b1155d54300e73a634d.1538485901.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <cover.1538485901.git.andreyknvl@google.com>
References: <cover.1538485901.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy_from_user and strnlen_user accept user addresses as arguments, and
do not go through the same path as copy_from_user and others, so here we
need to handle the case of tagged user addresses separately.

Untag user pointers passed to these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/strncpy_from_user.c | 2 ++
 lib/strnlen_user.c      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index b53e1b5d80f4..97467cd2bc59 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -106,6 +106,8 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	src = untagged_addr(src);
+
 	max_addr = user_addr_max();
 	src_addr = (unsigned long)src;
 	if (likely(src_addr < max_addr)) {
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 60d0bbda8f5e..8b5f56466e00 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -108,6 +108,8 @@ long strnlen_user(const char __user *str, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	str = untagged_addr(str);
+
 	max_addr = user_addr_max();
 	src_addr = (unsigned long)str;
 	if (likely(src_addr < max_addr)) {
-- 
2.19.0.605.g01d371f741-goog


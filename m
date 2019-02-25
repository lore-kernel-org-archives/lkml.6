Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3112AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020E320449
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131653;
	bh=3FXVwUvF4yemI1h2Z60RpSZOMPjo07moXavvhZr3BOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HP+5YrkSWIJ1/i5w8WTiG+gBlplCxtz6CZDdXJFVF9zWQgl43ERUzaIKgkDFBgI8e
	 nr9TGbn/uDIks4c2UQzEvabmE2H4ODMyNiLQ/lc6T0MAr1BPBgeifh+XhLKuO4lDhY
	 /4mfdy0UJWEfl5ZNJqEjgaZ+oc9bBMRJXxXpbv/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbfBYVyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:54:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729827AbfBYVWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2325121852;
        Mon, 25 Feb 2019 21:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129730;
        bh=3FXVwUvF4yemI1h2Z60RpSZOMPjo07moXavvhZr3BOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=doO6zHCTNqSINhSP+xAoh0IrXKIALN8TQKu0x2RIsSX9jFabR19aIxib21cjEdIVX
         ob1iGNrFYaCpiwUEpLC8ULR93LNaTu4lbCywcpukwudzidNoxdOpZrEpAsnpcOfsZe
         WkhBmH+L3NDCUX5JzLnm3Fp9SJrNzDK2pTWxgRHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 022/152] mfd: twl-core: Fix section annotations on {,un}protect_pm_master
Date:   Mon, 25 Feb 2019 22:10:14 +0100
Message-Id: <20190225195045.185563054@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8838555089f0345b87f4277fe5a8dd647dc65589 ]

When building the kernel with Clang, the following section mismatch
warning appears:

WARNING: vmlinux.o(.text+0x3d84a3b): Section mismatch in reference from
the function twl_probe() to the function
.init.text:unprotect_pm_master()
The function twl_probe() references
the function __init unprotect_pm_master().
This is often because twl_probe lacks a __init
annotation or the annotation of unprotect_pm_master is wrong.

Remove the __init annotation on the *protect_pm_master functions so
there is no more mismatch.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/twl-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 4be3d239da9ec..299016bc46d90 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -979,7 +979,7 @@ add_children(struct twl4030_platform_data *pdata, unsigned irq_base,
  * letting it generate the right frequencies for USB, MADC, and
  * other purposes.
  */
-static inline int __init protect_pm_master(void)
+static inline int protect_pm_master(void)
 {
 	int e = 0;
 
@@ -988,7 +988,7 @@ static inline int __init protect_pm_master(void)
 	return e;
 }
 
-static inline int __init unprotect_pm_master(void)
+static inline int unprotect_pm_master(void)
 {
 	int e = 0;
 
-- 
2.19.1




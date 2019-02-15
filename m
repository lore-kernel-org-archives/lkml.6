Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30305C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFF220840
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198030;
	bh=vT1Coe+uTKY7WyKmDFgT9baF9t702twQ/EnGifizVwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=moV+PeDLyH5FY/tsUjtz1pEEDL6Q3h64iL/4scor7nfSf7AYK/I5ufhHTord+IujA
	 njP2AVsPK5eSFivsMBhzgLTzLXm0Fu2j8xzsgf06kNd8oCm6uFRDmdVi2HBnK72gEE
	 X/9NK9BQYV+Y7nwlzOZF3R6bpL9SOLwn1zmsUuk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388518AbfBOCds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:33:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:51934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390862AbfBOCLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:11:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51D3421934;
        Fri, 15 Feb 2019 02:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196713;
        bh=vT1Coe+uTKY7WyKmDFgT9baF9t702twQ/EnGifizVwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kadL/POkszp+ZJF4WOjWC6d8oLUU91kUJBENPdC8pXAG+qPLUzJkPmxuDUPFpWUTm
         UclYGNvetilFdOqP8VjUiwJkFP4yKco2uJUBNGTet2+A1bmXgOk26aNU3sJQCGgmzb
         ffqj0wTpRwldYIbki5M173ZbZln2zpZ6YCjJ3CoI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 19/65] selftests/vm/gup_benchmark.c: match gup struct to kernel
Date:   Thu, 14 Feb 2019 21:10:35 -0500
Message-Id: <20190215021121.177674-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

[ Upstream commit 91cd63d320f84dcbf21d4327f31f7e1f85adebd0 ]

An expansion field was added to the kernel copy of this structure for
future use. See mm/gup_benchmark.c.

Add the same expansion field here, so that the IOCTL command decodes
correctly. Otherwise, it fails with EINVAL.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/vm/gup_benchmark.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
index 36df55132036..9601bc24454d 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -22,6 +22,7 @@ struct gup_benchmark {
 	__u64 size;
 	__u32 nr_pages_per_call;
 	__u32 flags;
+	__u64 expansion[10];	/* For future use */
 };
 
 int main(int argc, char **argv)
-- 
2.19.1


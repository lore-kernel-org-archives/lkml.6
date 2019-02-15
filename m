Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85A4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787EB21A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198465;
	bh=JJLWOw5LLD1Lg0ZmECfqNzQ3X16kfv5gFGW3KC5cyPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i2orgi8t+pv9br+rCMLeOlhA7rBjtDEBWNpPmNwAzy2vIP6RxaouqrNQoKTzyLbto
	 ErWvCKoehg3rd+gzDbBP8ljC8isBihEKdgArSAK5Kwk079BpqZAjP39cMsM5QSVUh5
	 YdBnu/4F+aGyJMifrY+BSCL4e+2NtPWOsEKRCYGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389055AbfBOCJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:09:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388638AbfBOCJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:09:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B8D7222D7;
        Fri, 15 Feb 2019 02:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196582;
        bh=JJLWOw5LLD1Lg0ZmECfqNzQ3X16kfv5gFGW3KC5cyPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMdY9AlxALsBxNxNWe1ZfXUSJmt2uXzFKEdhkvtJZV1f/xB8rQM+6M3MjTkeZP2IO
         ukNq29JsiiuIYQHIyHCndrJQ+aGPMol1beFzKwKfCzCUAe6E2/+euFOhXhOx1v2zjy
         r4u+4f472iTZ00BDbU+GS0LYod0+jD/XSnm2Lk4Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 26/77] selftests/vm/gup_benchmark.c: match gup struct to kernel
Date:   Thu, 14 Feb 2019 21:08:04 -0500
Message-Id: <20190215020855.176727-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
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
index 880b96fc80d4..c0534e298b51 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -25,6 +25,7 @@ struct gup_benchmark {
 	__u64 size;
 	__u32 nr_pages_per_call;
 	__u32 flags;
+	__u64 expansion[10];	/* For future use */
 };
 
 int main(int argc, char **argv)
-- 
2.19.1


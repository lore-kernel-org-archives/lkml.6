Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C699FC67874
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A93C21104
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675329;
	bh=PHlnXzD4ezrTAWqIoECBrKFZ3fTpKZNtwLgUOCugjtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FqrNxTHSP3jKaoldwtXEAEh4oe0+WFKKWCE+ODK92Whyj4SpgM6XjtnTYJGELrs4p
	 CDL07aBQhWB/0rdSlZXLTzjplbunh0c8Is83JtjAj9fObH36MvkgveW+91Ev6yvWNS
	 HdsF0OXTO6jpzp5jFB3rY4vX9rj8L9Vdhtbggfkc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A93C21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbeLME2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:28:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbeLME2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:28:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E295620879;
        Thu, 13 Dec 2018 04:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675326;
        bh=PHlnXzD4ezrTAWqIoECBrKFZ3fTpKZNtwLgUOCugjtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gz2WHQZ6WHDqbHA+BwziEpobWtojW3NJUQvrYphXQS3PHI+TPkuydnERL4Xjx8gPA
         DRA4l87i3Av/AIT9WqXTOmABf8oy6AkWHPi4hu7mFwUpK/51Q5gIf3uelb2i+o/yKW
         KBHmuhasnlM+jUkgKPKaCQgATFxbcK1XfqZ93DJE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 06/73] tools/bpf: fix two test_btf unit test cases
Date:   Wed, 12 Dec 2018 23:27:31 -0500
Message-Id: <20181213042838.75160-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin KaFai Lau <kafai@fb.com>

[ Upstream commit 8800cd031af085807028656c6ba7eb7908d78262 ]

There are two unit test cases, which should encode
TYPEDEF type, but instead encode PTR type.
The error is flagged out after enforcing name
checking in the previous patch.

Fixes: c0fa1b6c3efc ("bpf: btf: Add BTF tests")
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_btf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_btf.c b/tools/testing/selftests/bpf/test_btf.c
index 6b5cfeb7a9cc..4909aab4d6ab 100644
--- a/tools/testing/selftests/bpf/test_btf.c
+++ b/tools/testing/selftests/bpf/test_btf.c
@@ -431,11 +431,11 @@ static struct btf_raw_test raw_tests[] = {
 		/* const void* */	/* [3] */
 		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_PTR, 0, 0), 2),
 		/* typedef const void * const_void_ptr */
-		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_PTR, 0, 0), 3),
-		/* struct A { */	/* [4] */
+		BTF_TYPEDEF_ENC(NAME_TBD, 3),	/* [4] */
+		/* struct A { */	/* [5] */
 		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 1), sizeof(void *)),
 		/* const_void_ptr m; */
-		BTF_MEMBER_ENC(NAME_TBD, 3, 0),
+		BTF_MEMBER_ENC(NAME_TBD, 4, 0),
 		/* } */
 		BTF_END_RAW,
 	},
@@ -493,10 +493,10 @@ static struct btf_raw_test raw_tests[] = {
 		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_CONST, 0, 0), 0),
 		/* const void* */	/* [3] */
 		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_PTR, 0, 0), 2),
-		/* typedef const void * const_void_ptr */	/* [4] */
-		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_PTR, 0, 0), 3),
-		/* const_void_ptr[4] */	/* [5] */
-		BTF_TYPE_ARRAY_ENC(3, 1, 4),
+		/* typedef const void * const_void_ptr */
+		BTF_TYPEDEF_ENC(NAME_TBD, 3),	/* [4] */
+		/* const_void_ptr[4] */
+		BTF_TYPE_ARRAY_ENC(4, 1, 4),	/* [5] */
 		BTF_END_RAW,
 	},
 	.str_sec = "\0const_void_ptr",
-- 
2.19.1


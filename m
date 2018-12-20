Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E456EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B5520449
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298449;
	bh=xO6P+4apIuYCPqkfotwv70elLzOT3BGt6T6JXGfdqX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qL98+p3Xab22vLulkbFsuyQ+Ff0fxEhzKKqqTVu9cJSnH/LnZ0P1itepHSPaHf07Z
	 9iovSaAnlNnQPJGw6YPtpvLNdPjkIWhG/u3kmNrzT+kORWIA3mXXXccLTT23sYAKZb
	 +erpXqARV4pYwAiPznfANAIXuNmW9mulb8nPWD3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbeLTJ3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:29:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:57738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732740AbeLTJ3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:29:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C5DC20656;
        Thu, 20 Dec 2018 09:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298175;
        bh=xO6P+4apIuYCPqkfotwv70elLzOT3BGt6T6JXGfdqX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qBUW42d7nqg+FXNZDmC1cZnovDeWJI6DUd65uzitThVIE7uvzpTuuDbhNKTfKKLi+
         dhCeplgmVRDptbW0ExwuZIDrI0havJ/EW2xSmtYfHmC6igjTJcrIJyC5fOb7f8kv5/
         vx3fDl7zcGJmy7e+5uXQR6TNX6c2YdJcFcBOeQKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 09/67] tools/bpf: fix two test_btf unit test cases
Date:   Thu, 20 Dec 2018 10:18:21 +0100
Message-Id: <20181220085903.935713990@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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




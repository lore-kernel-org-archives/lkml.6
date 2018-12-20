Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE62C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9ACE21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298134;
	bh=YD4J486qqK+UtiMu+/djw/e1jVKfnOGrwHPIcawwbfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PtaLpzEWXJKm+LJOhlvnnvDl5oizO6XmIkzfQ+QgyxsBZZUgP4Gv3gJ9iVGXpBwy9
	 kwVlNB8GHMJ3j11FE1RRpkvzaJeIbLiX6bxDGx+2UyEj9RLbQ8w2OlGhLdcsvoKql0
	 izpQgZWQaAAGFkLwo4iP7avZbTE4GRPJNCkWtFAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732596AbeLTJ2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:28:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732568AbeLTJ2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:28:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A06F420656;
        Thu, 20 Dec 2018 09:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298129;
        bh=YD4J486qqK+UtiMu+/djw/e1jVKfnOGrwHPIcawwbfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJp9NwUJsIrxaqX2nFtWpJOjuRqTYAYd0hoegN2G31sQs53gqF+ZhZQeoZOr5Qki2
         z9wAooJgnsb1hAfUnyhNLoE/77ryORqdxCAcpjZRBkgDOazvYobngVfncpLyf9JxER
         lqELBJt2D/4QI0MPLt9rW033bzPpTI8L56NDGcG0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 10/67] tools/bpf: add addition type tests to test_btf
Date:   Thu, 20 Dec 2018 10:18:22 +0100
Message-Id: <20181220085903.969894172@linuxfoundation.org>
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

[ Upstream commit d08489125e04a9f73d9323caea43270fd22d395f ]

The following additional unit testcases are added to test_btf:
...
BTF raw test[42] (typedef (invalid name, name_off = 0)): OK
BTF raw test[43] (typedef (invalid name, invalid identifier)): OK
BTF raw test[44] (ptr type (invalid name, name_off <> 0)): OK
BTF raw test[45] (volatile type (invalid name, name_off <> 0)): OK
BTF raw test[46] (const type (invalid name, name_off <> 0)): OK
BTF raw test[47] (restrict type (invalid name, name_off <> 0)): OK
BTF raw test[48] (fwd type (invalid name, name_off = 0)): OK
BTF raw test[49] (fwd type (invalid name, invalid identifier)): OK
BTF raw test[50] (array type (invalid name, name_off <> 0)): OK
BTF raw test[51] (struct type (name_off = 0)): OK
BTF raw test[52] (struct type (invalid name, invalid identifier)): OK
BTF raw test[53] (struct member (name_off = 0)): OK
BTF raw test[54] (struct member (invalid name, invalid identifier)): OK
BTF raw test[55] (enum type (name_off = 0)): OK
BTF raw test[56] (enum type (invalid name, invalid identifier)): OK
BTF raw test[57] (enum member (invalid name, name_off = 0)): OK
BTF raw test[58] (enum member (invalid name, invalid identifier)): OK
...

Fixes: c0fa1b6c3efc ("bpf: btf: Add BTF tests")
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_btf.c | 361 +++++++++++++++++++++++++
 1 file changed, 361 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_btf.c b/tools/testing/selftests/bpf/test_btf.c
index 4909aab4d6ab..29116366a9fc 100644
--- a/tools/testing/selftests/bpf/test_btf.c
+++ b/tools/testing/selftests/bpf/test_btf.c
@@ -1291,6 +1291,367 @@ static struct btf_raw_test raw_tests[] = {
 	.err_str = "type != 0",
 },
 
+{
+	.descr = "typedef (invalid name, name_off = 0)",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPEDEF_ENC(0, 1),				/* [2] */
+		BTF_END_RAW,
+	},
+	.str_sec = "\0__int",
+	.str_sec_size = sizeof("\0__int"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "typedef_check_btf",
+	.key_size = sizeof(int),
+	.value_size = sizeof(int),
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 4,
+	.btf_load_err = true,
+	.err_str = "Invalid name",
+},
+
+{
+	.descr = "typedef (invalid name, invalid identifier)",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPEDEF_ENC(NAME_TBD, 1),			/* [2] */
+		BTF_END_RAW,
+	},
+	.str_sec = "\0__!int",
+	.str_sec_size = sizeof("\0__!int"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "typedef_check_btf",
+	.key_size = sizeof(int),
+	.value_size = sizeof(int),
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 4,
+	.btf_load_err = true,
+	.err_str = "Invalid name",
+},
+
+{
+	.descr = "ptr type (invalid name, name_off <> 0)",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
+		BTF_TYPE_ENC(NAME_TBD,
+			     BTF_INFO_ENC(BTF_KIND_PTR, 0, 0), 1),	/* [2] */
+		BTF_END_RAW,
+	},
+	.str_sec = "\0__int",
+	.str_sec_size = sizeof("\0__int"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "ptr_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = sizeof(int),
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 4,
+	.btf_load_err = true,
+	.err_str = "Invalid name",
+},
+
+{
+	.descr = "volatile type (invalid name, name_off <> 0)",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
+		BTF_TYPE_ENC(NAME_TBD,
+			     BTF_INFO_ENC(BTF_KIND_VOLATILE, 0, 0), 1),	/* [2] */
+		BTF_END_RAW,
+	},
+	.str_sec = "\0__int",
+	.str_sec_size = sizeof("\0__int"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "volatile_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = sizeof(int),
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 4,
+	.btf_load_err = true,
+	.err_str = "Invalid name",
+},
+
+{
+	.descr = "const type (invalid name, name_off <> 0)",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
+		BTF_TYPE_ENC(NAME_TBD,
+			     BTF_INFO_ENC(BTF_KIND_CONST, 0, 0), 1),	/* [2] */
+		BTF_END_RAW,
+	},
+	.str_sec = "\0__int",
+	.str_sec_size = sizeof("\0__int"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "const_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = sizeof(int),
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 4,
+	.btf_load_err = true,
+	.err_str = "Invalid name",
+},
+
+{
+	.descr = "restrict type (invalid name, name_off <> 0)",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_PTR, 0, 0), 1),	/* [2] */
+		BTF_TYPE_ENC(NAME_TBD,
+			     BTF_INFO_ENC(BTF_KIND_RESTRICT, 0, 0), 2),	/* [3] */
+		BTF_END_RAW,
+	},
+	.str_sec = "\0__int",
+	.str_sec_size = sizeof("\0__int"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "restrict_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = sizeof(int),
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 4,
+	.btf_load_err = true,
+	.err_str = "Invalid name",
+},
+
+{
+	.descr = "fwd type (invalid name, name_off = 0)",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FWD, 0, 0), 0),	/* [2] */
+		BTF_END_RAW,
+	},
+	.str_sec = "\0__skb",
+	.str_sec_size = sizeof("\0__skb"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "fwd_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = sizeof(int),
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 4,
+	.btf_load_err = true,
+	.err_str = "Invalid name",
+},
+
+{
+	.descr = "fwd type (invalid name, invalid identifier)",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
+		BTF_TYPE_ENC(NAME_TBD,
+			     BTF_INFO_ENC(BTF_KIND_FWD, 0, 0), 0),	/* [2] */
+		BTF_END_RAW,
+	},
+	.str_sec = "\0__!skb",
+	.str_sec_size = sizeof("\0__!skb"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "fwd_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = sizeof(int),
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 4,
+	.btf_load_err = true,
+	.err_str = "Invalid name",
+},
+
+{
+	.descr = "array type (invalid name, name_off <> 0)",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
+		BTF_TYPE_ENC(NAME_TBD,
+			     BTF_INFO_ENC(BTF_KIND_ARRAY, 0, 0), 0),	/* [2] */
+		BTF_ARRAY_ENC(1, 1, 4),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0__skb",
+	.str_sec_size = sizeof("\0__skb"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "array_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = sizeof(int),
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 4,
+	.btf_load_err = true,
+	.err_str = "Invalid name",
+},
+
+{
+	.descr = "struct type (name_off = 0)",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
+		BTF_TYPE_ENC(0,
+			     BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 1), 4),	/* [2] */
+		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A",
+	.str_sec_size = sizeof("\0A"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "struct_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = sizeof(int),
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 4,
+},
+
+{
+	.descr = "struct type (invalid name, invalid identifier)",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
+		BTF_TYPE_ENC(NAME_TBD,
+			     BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 1), 4),	/* [2] */
+		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A!\0B",
+	.str_sec_size = sizeof("\0A!\0B"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "struct_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = sizeof(int),
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 4,
+	.btf_load_err = true,
+	.err_str = "Invalid name",
+},
+
+{
+	.descr = "struct member (name_off = 0)",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
+		BTF_TYPE_ENC(0,
+			     BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 1), 4),	/* [2] */
+		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A",
+	.str_sec_size = sizeof("\0A"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "struct_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = sizeof(int),
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 4,
+},
+
+{
+	.descr = "struct member (invalid name, invalid identifier)",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
+		BTF_TYPE_ENC(NAME_TBD,
+			     BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 1), 4),	/* [2] */
+		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A\0B*",
+	.str_sec_size = sizeof("\0A\0B*"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "struct_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = sizeof(int),
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 4,
+	.btf_load_err = true,
+	.err_str = "Invalid name",
+},
+
+{
+	.descr = "enum type (name_off = 0)",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
+		BTF_TYPE_ENC(0,
+			     BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1),
+			     sizeof(int)),				/* [2] */
+		BTF_ENUM_ENC(NAME_TBD, 0),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A\0B",
+	.str_sec_size = sizeof("\0A\0B"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "enum_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = sizeof(int),
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 4,
+},
+
+{
+	.descr = "enum type (invalid name, invalid identifier)",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
+		BTF_TYPE_ENC(NAME_TBD,
+			     BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1),
+			     sizeof(int)),				/* [2] */
+		BTF_ENUM_ENC(NAME_TBD, 0),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A!\0B",
+	.str_sec_size = sizeof("\0A!\0B"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "enum_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = sizeof(int),
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 4,
+	.btf_load_err = true,
+	.err_str = "Invalid name",
+},
+
+{
+	.descr = "enum member (invalid name, name_off = 0)",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
+		BTF_TYPE_ENC(0,
+			     BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1),
+			     sizeof(int)),				/* [2] */
+		BTF_ENUM_ENC(0, 0),
+		BTF_END_RAW,
+	},
+	.str_sec = "",
+	.str_sec_size = sizeof(""),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "enum_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = sizeof(int),
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 4,
+	.btf_load_err = true,
+	.err_str = "Invalid name",
+},
+
+{
+	.descr = "enum member (invalid name, invalid identifier)",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
+		BTF_TYPE_ENC(0,
+			     BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1),
+			     sizeof(int)),				/* [2] */
+		BTF_ENUM_ENC(NAME_TBD, 0),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A!",
+	.str_sec_size = sizeof("\0A!"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "enum_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = sizeof(int),
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 4,
+	.btf_load_err = true,
+	.err_str = "Invalid name",
+},
 {
 	.descr = "arraymap invalid btf key (a bit field)",
 	.raw_types = {
-- 
2.19.1




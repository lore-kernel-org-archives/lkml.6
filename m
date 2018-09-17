Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3D9ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F792146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F792146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbeIREi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:38:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50120 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbeIREi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:38:58 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BADB3C7D;
        Mon, 17 Sep 2018 23:09:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Arthur Fabre <afabre@cloudflare.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 054/158] selftests/bpf: fix a typo in map in map test
Date:   Tue, 18 Sep 2018 00:41:24 +0200
Message-Id: <20180917211713.749852618@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Gushchin <guro@fb.com>

[ Upstream commit 0069fb854364da79fd99236ea620affc8e1152d5 ]

Commit fbeb1603bf4e ("bpf: verifier: MOV64 don't mark dst reg unbounded")
revealed a typo in commit fb30d4b71214 ("bpf: Add tests for map-in-map"):
BPF_MOV64_REG(BPF_REG_0, 0) was used instead of
BPF_MOV64_IMM(BPF_REG_0, 0).

I've noticed the problem by running bpf kselftests.

Fixes: fb30d4b71214 ("bpf: Add tests for map-in-map")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Arthur Fabre <afabre@cloudflare.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/bpf/test_verifier.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -6997,7 +6997,7 @@ static struct bpf_test tests[] = {
 			BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
 				     BPF_FUNC_map_lookup_elem),
-			BPF_MOV64_REG(BPF_REG_0, 0),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
 			BPF_EXIT_INSN(),
 		},
 		.fixup_map_in_map = { 3 },
@@ -7020,7 +7020,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
 			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
 				     BPF_FUNC_map_lookup_elem),
-			BPF_MOV64_REG(BPF_REG_0, 0),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
 			BPF_EXIT_INSN(),
 		},
 		.fixup_map_in_map = { 3 },
@@ -7042,7 +7042,7 @@ static struct bpf_test tests[] = {
 			BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
 				     BPF_FUNC_map_lookup_elem),
-			BPF_MOV64_REG(BPF_REG_0, 0),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
 			BPF_EXIT_INSN(),
 		},
 		.fixup_map_in_map = { 3 },



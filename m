Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1794019-1519878054-2-2922647499818919115
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519878054; b=hc7H+Oppq0u7+7yW2lcMBYEvCuNAxEfo95ddf5kEYtua4s/
    kwQ5T491mvx5YxVhdGk0on+Ta4cgGimWFc5Su30ajdAuzbxUEnsZxy8pjb3OFUT/
    jpIqtNRu+HLIF4O+3BWZWhF95BXFUFOIoIt4uIpFlkPsZWunOAVgYSrJ2DXj63aH
    i7FWBDU2M5gBnl7ZWomQ0eWbhsJqsy0/MKnuCm/8rpo3nR9pidYv8/TKKre5iTFk
    0psR4rKR+tZsIAvqBA6jciPCqmmcxvwAE0uY0a2N+gwe0XaNUrNHojKUg/a0izTS
    JgZ8TFzukgQVtZ+FQeCCWYV2cJ5DW1AjrngOBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519878054; bh=gcIMVcbmWE3g5JpUhZZBAGQUTb
    MpcSgFxono2Bc3U54=; b=oJ1yi4X+LZikYSYfCsWVc5zVOxexy01gLNMx7yLgJC
    1lvn4Dp+droDW3yiH8mcyBW5xU/2nweGIQQA4WyCTXEYuuRND2BRSIdmTEzSDgBS
    tRwyx+wKSMKJ0ijvWZnZ356JQGFdNzzb2rDaEEv8Di2P6+9RztN/EXfAS0pcn0WT
    LNeExu5Q93uOfOTXFLctUL1EkQf9gVN1bn6od9GysJXRlC8YkHLqnY/DMylUuXOb
    Qa4/QNbyn9UulAULdeKE07T//T/Nmu6JmKcabseadakaZB3YNr+5ngND05mRLuh5
    dh5AOO26y8ay2nJUwQ4MoqZ+T2j+lc2V3r5LUS+g+h9A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965928AbeCAEUf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 23:20:35 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42388 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965829AbeCAET7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Feb 2018 23:19:59 -0500
Smtp-Origin-Hostprefix: devbig
From: Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig500.prn1.facebook.com
To: <davem@davemloft.net>
CC: <daniel@iogearbox.net>, <torvalds@linux-foundation.org>,
        <peterz@infradead.org>, <mingo@kernel.org>, <rostedt@goodmis.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-api@vger.kernel.org>
Smtp-Origin-Cluster: prn1c29
Subject: [PATCH bpf-next 4/5] libbpf: add bpf_raw_tracepoint_open helper
Date: Wed, 28 Feb 2018 20:19:56 -0800
Message-ID: <20180301041957.399230-5-ast@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180301041957.399230-1-ast@kernel.org>
References: <20180301041957.399230-1-ast@kernel.org>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/include/uapi/linux/bpf.h | 11 +++++++++++
 tools/lib/bpf/bpf.c            | 10 ++++++++++
 tools/lib/bpf/bpf.h            |  1 +
 3 files changed, 22 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index db6bdc375126..50bf5f9054da 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -94,6 +94,7 @@ enum bpf_cmd {
 	BPF_MAP_GET_FD_BY_ID,
 	BPF_OBJ_GET_INFO_BY_FD,
 	BPF_PROG_QUERY,
+	BPF_RAW_TRACEPOINT_OPEN,
 };
 
 enum bpf_map_type {
@@ -133,6 +134,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SOCK_OPS,
 	BPF_PROG_TYPE_SK_SKB,
 	BPF_PROG_TYPE_CGROUP_DEVICE,
+	BPF_PROG_TYPE_RAW_TRACEPOINT,
 };
 
 enum bpf_attach_type {
@@ -143,6 +145,7 @@ enum bpf_attach_type {
 	BPF_SK_SKB_STREAM_PARSER,
 	BPF_SK_SKB_STREAM_VERDICT,
 	BPF_CGROUP_DEVICE,
+	BPF_RAW_TRACEPOINT,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -320,6 +323,10 @@ union bpf_attr {
 		__aligned_u64	prog_ids;
 		__u32		prog_cnt;
 	} query;
+
+	struct {
+		__u64 name;
+	} raw_tracepoint;
 } __attribute__((aligned(8)));
 
 /* BPF helper function descriptions:
@@ -1106,4 +1113,8 @@ struct bpf_cgroup_dev_ctx {
 	__u32 minor;
 };
 
+struct bpf_raw_tracepoint_args {
+	__u64 args[0];
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 592a58a2b681..4cbe7b6afcc0 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -428,6 +428,16 @@ int bpf_obj_get_info_by_fd(int prog_fd, void *info, __u32 *info_len)
 	return err;
 }
 
+int bpf_raw_tracepoint_open(const char *name)
+{
+	union bpf_attr attr;
+
+	bzero(&attr, sizeof(attr));
+	attr.raw_tracepoint.name = ptr_to_u64(name);
+
+	return sys_bpf(BPF_RAW_TRACEPOINT_OPEN, &attr, sizeof(attr));
+}
+
 int bpf_set_link_xdp_fd(int ifindex, int fd, __u32 flags)
 {
 	struct sockaddr_nl sa;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 8d18fb73d7fb..f672d39bd9fa 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -79,4 +79,5 @@ int bpf_map_get_fd_by_id(__u32 id);
 int bpf_obj_get_info_by_fd(int prog_fd, void *info, __u32 *info_len);
 int bpf_prog_query(int target_fd, enum bpf_attach_type type, __u32 query_flags,
 		   __u32 *attach_flags, __u32 *prog_ids, __u32 *prog_cnt);
+int bpf_raw_tracepoint_open(const char *name);
 #endif
-- 
2.9.5


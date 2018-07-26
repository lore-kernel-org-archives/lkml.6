Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01082C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0B5205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WpmOdhdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0B5205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbeGZSIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:08:50 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:47247 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731732AbeGZSIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:08:49 -0400
Received: by mail-vk0-f73.google.com with SMTP id b63-v6so884691vkf.14
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=C14wB0B6Vjxk29Z+2i5VLR9Y7UfpstNpOXC4VFZGbDs=;
        b=WpmOdhdKimotsnIn7qu88S/bXh50tUyRa/UrXkN1SxIBq7rhSBjyWP56conyvGP1NA
         0MTLxFZcvHHT/H0wWhLo173QBJ5DQHmKW1zPJIuIXzy4JSxMB5VeDOyxugypKEXcbicn
         2Q+f3kO3vCzpdLi9MVb+bcSNovg8QvKtHd/bxaj7UTJcTJw5ofxpOu1bLQR36h69Cswx
         eNUZRAbUXx5N13GLwhRNKGazTRB42Th18BjFqD3EAWuxLqRMI0ytN4eWZBbs4wQw9dkZ
         jAx/ZdDU7ohWDQk5yeeMdRnBwqPon6eXGWbDmpPgdc9OLuzLNM4tzrHgeDEEbm210+9H
         5Ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=C14wB0B6Vjxk29Z+2i5VLR9Y7UfpstNpOXC4VFZGbDs=;
        b=b5LICvc7gbZR9KCJqkjwbC9sGYwKCMBhAtLgnTihF/hgwIzIbf+0hR6/06GCZSHguG
         uaJlDjq8Ro1060KABrDtcQtbPdVJYCMOWhOb4UyVuyNujATOFcGhqmNp9yNK/iP+/Qz5
         tcckqQVto7cllDkUKlbdw67qJP10mLQjIzxGYyhmZBT8Rnui+gzjjnw5koZuVJ+Zp7LZ
         xSXYEryVfL5n7rNAew69KmfTmHsKtjVEE0+otNp3Waen30azqnzQV902obx25Eh4eGg5
         DyhCZBI+Hi8h08t2KnrE5mF9TvKkofJWeZ7MoVWItpQzCLDXoTufdfCWx+2ljXQ411Md
         4d8g==
X-Gm-Message-State: AOUpUlF7wvAUfEjFEPSpydA2IGtb5UFX65hLbHJINT6pt6zTYWLy3dpQ
        WlNheGN71hzXSjJ3RVUtYFD8TP9mdUo=
X-Google-Smtp-Source: AAOMgpdNJdcU9Ds7gSCX0NCCncSdph3QsewHYEaacbQvQiMGTn9wALs3ccPzdz+oxANTodaHvnId0z5cwAI=
MIME-Version: 1.0
X-Received: by 2002:a1f:9209:: with SMTP id u9-v6mr1245686vkd.73.1532623869478;
 Thu, 26 Jul 2018 09:51:09 -0700 (PDT)
Date:   Thu, 26 Jul 2018 09:51:05 -0700
In-Reply-To: <20180716202301.GB160902@joelaf.mtv.corp.google.com>
Message-Id: <20180726165105.8634-1-dancol@google.com>
References: <20180716202301.GB160902@joelaf.mtv.corp.google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH v2] Add BPF_SYNCHRONIZE_MAPS bpf(2) command
From:   Daniel Colascione <dancol@google.com>
To:     joelaf@google.com
Cc:     linux-kernel@vger.kernel.org, timmurray@google.com,
        netdev@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPF_SYNCHRONIZE_MAPS waits for the release of any references to a BPF
map made by a BPF program that is running at the time the
BPF_SYNCHRONIZE_MAPS command is issued. The purpose of this command is
to provide a means for userspace to replace a BPF map with another,
newer version, then ensure that no component is still using the "old"
map before manipulating the "old" map in some way.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 include/uapi/linux/bpf.h |  9 +++++++++
 kernel/bpf/syscall.c     | 13 +++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b7db3261c62d..5b27e9117d3e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -75,6 +75,14 @@ struct bpf_lpm_trie_key {
 	__u8	data[0];	/* Arbitrary size */
 };
 
+/* BPF_SYNCHRONIZE_MAPS waits for the release of any references to a
+ * BPF map made by a BPF program that is running at the time the
+ * BPF_SYNCHRONIZE_MAPS command is issued. The purpose of this command
+ * is to provide a means for userspace to replace a BPF map with
+ * another, newer version, then ensure that no component is still
+ * using the "old" map before manipulating the "old" map in some way.
+ */
+
 /* BPF syscall commands, see bpf(2) man-page for details. */
 enum bpf_cmd {
 	BPF_MAP_CREATE,
@@ -98,6 +106,7 @@ enum bpf_cmd {
 	BPF_BTF_LOAD,
 	BPF_BTF_GET_FD_BY_ID,
 	BPF_TASK_FD_QUERY,
+	BPF_SYNCHRONIZE_MAPS,
 };
 
 enum bpf_map_type {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a31a1ba0f8ea..8bbd1a5d01d1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2274,6 +2274,19 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (cmd == BPF_SYNCHRONIZE_MAPS) {
+		if (uattr != NULL || size != 0)
+			return -EINVAL;
+		err = security_bpf(cmd, NULL, 0);
+		if (err < 0)
+			return err;
+		/* BPF programs always enter a critical section while
+		 * they have a map reference outstanding.
+		 */
+		synchronize_rcu();
+		return 0;
+	}
+
 	err = bpf_check_uarg_tail_zero(uattr, sizeof(attr), size);
 	if (err)
 		return err;
-- 
2.18.0.233.g985f88cf7e-goog


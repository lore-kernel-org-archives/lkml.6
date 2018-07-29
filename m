Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28973C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE0120873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HLSfDvdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE0120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbeG2Wag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:30:36 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:55198 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbeG2Wag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:30:36 -0400
Received: by mail-it0-f73.google.com with SMTP id l8-v6so10874781ita.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 13:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AokGEKCgwJ737GNoCwSaZTwt/QvtFfmxL6P86g1wy5w=;
        b=HLSfDvdY9AbuDbTZYWPhcZkUhQegd7dQVwl/J+Y1zsvQhfy5P2HQZxQU6fOK8vh9Zb
         Sv7dlfEEzLSaiK7S8eCPnDP+K0staviqRlm8zismaM/B53HtoAQ+a5ogcEwlibC0G4Lc
         UWiFB5p5ZWNl75ftk3FuT9EPT6ahpf6OcppjfQ9HvvhhUbO1L8lVPafT3ivcWHocgldr
         z5q0QFkJ0o388m5ukFcLY2/ewM3yhS5YTYAy36gKYW+724BZuiYdo1GXjYC9//mwRAuR
         GX2Yv7AvSpVE+YbEk5duPEmzAEv4VwN3iQA99X/9T0Wz0DcFI/YWOQuEaOpD43Zh0vfO
         xN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AokGEKCgwJ737GNoCwSaZTwt/QvtFfmxL6P86g1wy5w=;
        b=nwGnTcRvqQhavuHvekRtwyWDlbLfaivtk6k7GTl6FiGlZkSe3SRXri5sXII7Aez+rk
         BozYkAb+4GWE/Oyx1fC40Hw3vE+LV8ePa/2/pDqOu6/PTmjUOD59lbR7gzzks0nUBvJL
         dwaTH1asFa4Q55lk90xIlaaJGXZVnY83qT4QN5wt2bdRLjrlmILQuNlV+70rSKy9bBEV
         z81bREXVyjJVEZ5+oMVjN+gMivDWdO5PkUcGznQ8BzOjtFeZouQyCXrGW9zfQQPqbivF
         io2YJkoiwGxGMl+6fR6iL/jCRGNJ4N12LLTr8p4cbxw1KVAXyxzbkqGszdzcmsuVvw+X
         gr1w==
X-Gm-Message-State: AOUpUlEDCNiip1f78xTOsQUqDQs4RbsmytTXDrPeuf+m2XwvOnU8eKfy
        PB9Nwt7VtvBEqDEnwjL7aBlfjeSVlT8=
X-Google-Smtp-Source: AAOMgpdGbmfwNLTiELcs/i5Vnv387G0yY8MWtQy81BajVVPSBOIxXxNYz9myLIIA0ddT8ur5R5+K6wYfP6w=
X-Received: by 2002:a24:47ca:: with SMTP id t193-v6mr6874648itb.24.1532897927126;
 Sun, 29 Jul 2018 13:58:47 -0700 (PDT)
Date:   Sun, 29 Jul 2018 13:58:35 -0700
In-Reply-To: <CAKOZuesQ6GdNTGDFsNi4o8LYzxLBtYZ=Cz4=aZbqqCNia+QFnQ@mail.gmail.com>
Message-Id: <20180729205835.34850-1-dancol@google.com>
Mime-Version: 1.0
References: <CAKOZuesQ6GdNTGDFsNi4o8LYzxLBtYZ=Cz4=aZbqqCNia+QFnQ@mail.gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH v3] Add BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES bpf(2) command
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

BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES waits for the release of all
references to maps active at the instant the
BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES is
issued. BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES waits only for the
expiration of map references obtained by BPF programs from other maps.

The purpose of this command is to provide a means for userspace to
replace a BPF map with another, newer version, then ensure that no
component is still using the "old" map before manipulating the "old"
map in some way.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 include/uapi/linux/bpf.h | 14 ++++++++++++++
 kernel/bpf/syscall.c     | 13 +++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b7db3261c62d..ca3cfca76edc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -75,6 +75,19 @@ struct bpf_lpm_trie_key {
 	__u8	data[0];	/* Arbitrary size */
 };
 
+/* BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES waits for the release of all
+ * references to maps active at the instant the
+ * BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES is
+ * issued. BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES waits only for the
+ * expiration of map references obtained by BPF programs from
+ * other maps.
+ *
+ * The purpose of this command is to provide a means for userspace to
+ * replace a BPF map with another, newer version, then ensure that no
+ * component is still using the "old" map before manipulating the
+ * "old" map in some way.
+ */
+
 /* BPF syscall commands, see bpf(2) man-page for details. */
 enum bpf_cmd {
 	BPF_MAP_CREATE,
@@ -98,6 +111,7 @@ enum bpf_cmd {
 	BPF_BTF_LOAD,
 	BPF_BTF_GET_FD_BY_ID,
 	BPF_TASK_FD_QUERY,
+	BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES,
 };
 
 enum bpf_map_type {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a31a1ba0f8ea..bc9a0713f47d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2274,6 +2274,19 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (cmd == BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES) {
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
2.18.0.345.g5c9ce644c3-goog


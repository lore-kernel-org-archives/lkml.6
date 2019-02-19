Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80F3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EE420823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqgSGYti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfBSONz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:13:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35438 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfBSONz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:13:55 -0500
Received: by mail-ed1-f67.google.com with SMTP id g19so7881478edp.2;
        Tue, 19 Feb 2019 06:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZkemQaXDdoLf47LKaqQ66xqnzc6sSNK3Q/PXS/ocVm0=;
        b=gqgSGYtiwwts7SqL9ZbRwwd2E3NmiJ4RbJnHiiT1eJXAZuAo0kSgProGeKI/+ggU0J
         U7q0FjWBWXzhxv0IOji8+RNYSvVOPHwPUrMc06PvmHeM4jL0K31QLylAjXz9kdHGMSzA
         lAs1EnA8+epTo2pmknLGvwHrqynHgWbdcZLMXNL5QI3gpCsjHkIb5gL503t9T1wS4lXy
         obgaBs0CstVJUb1KslTXUdXbRdY7PH9t91kRXXLtdbih1FpRNulEcxSHrbscLYHSGRh8
         YddXZzDxTT3EpL1hh30HcC/1n+LBYMHw2HHVORsgoikGVVd5MN/EF0OeBDptnbiVgs1D
         Xg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ZkemQaXDdoLf47LKaqQ66xqnzc6sSNK3Q/PXS/ocVm0=;
        b=sCkk9Lmc9dicm6HnIZ8nQQMafQj8gnqyA2BpBFZV/2Te+nWjlmWRG13Rjc+qKPyHx9
         QYQzTHJstyFbTqO5r2IFEm1JddkkfERY/vqV6WiCIYr80OypIFJYOExCgUNDzEqhp53I
         eDGKxKWKvYY47VYHhHDJb3tkjZgBtlgCD+p3+IOTdmEqFWcg3FCMTWWdDxmtEW2zA7xf
         nyKvk0QLo13qcVaOkqL06rLDsB8XsAPAXAkqoZDqrdYXvS7xIQR5+D7b03KJkWluDOnb
         6cIBwOkQkvL6RVURTbWmy3/PbUfugzyWWH0cCdbNQu+cOwUNEd87QfHhXVqaZzEAEGYe
         q7Ww==
X-Gm-Message-State: AHQUAuZTJe9UbLVb7cBV9uUTd8v+5urnZG/EDIpqFVQLB6h7FQvf9HKr
        Z5MbF3j1Ub0NgCPDNnY/Iahu+eIYISQ=
X-Google-Smtp-Source: AHgI3IZejhkWJv9KT/paZ96MCUqlzD3QVMbal1+H5R9DXgLJqPYzU/uEmHwVYxqI/eYKva/b9DEKow==
X-Received: by 2002:a50:b286:: with SMTP id p6mr23536245edd.202.1550585632803;
        Tue, 19 Feb 2019 06:13:52 -0800 (PST)
Received: from neptune.fritz.box ([178.19.216.175])
        by smtp.gmail.com with ESMTPSA id f16sm1378848ejc.27.2019.02.19.06.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 06:13:52 -0800 (PST)
From:   Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <alban@kinvolk.io>
To:     ast@kernel.org, daniel@iogearbox.net, quentin.monnet@netronome.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.fastabend@gmail.com, alban@kinvolk.io, iago@kinvolk.io
Subject: [PATCH bpf-next v2] bpf: bpftool, fix documentation for attach types
Date:   Tue, 19 Feb 2019 15:13:32 +0100
Message-Id: <20190219141332.23103-1-alban@kinvolk.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

bpftool has support for attach types "stream_verdict" and
"stream_parser" but the documentation was referring to them as
"skb_verdict" and "skb_parse". The inconsistency comes from commit
b7d3826c2ed6 ("bpf: bpftool, add support for attaching programs to
maps").

This patch changes the documentation to match the implementation:
- "bpftool prog help"
- man pages
- bash completion

Signed-off-by: Alban Crequy <alban@kinvolk.io>

---

Changes v1 to v2:
- fix man pages & bash completion (from Quentin's review)
---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst | 2 +-
 tools/bpf/bpftool/bash-completion/bpftool        | 4 ++--
 tools/bpf/bpftool/prog.c                         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 7e59495cb028..12bc1e2d4b46 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -42,7 +42,7 @@ PROG COMMANDS
 |		**cgroup/connect4** | **cgroup/connect6** | **cgroup/sendmsg4** | **cgroup/sendmsg6**
 |	}
 |       *ATTACH_TYPE* := {
-|		**msg_verdict** | **skb_verdict** | **skb_parse** | **flow_dissector**
+|		**msg_verdict** | **stream_verdict** | **stream_parser** | **flow_dissector**
 |	}
 
 
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 763dd12482aa..b803827d01e8 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -311,8 +311,8 @@ _bpftool()
                             return 0
                             ;;
                         5)
-                            COMPREPLY=( $( compgen -W 'msg_verdict skb_verdict \
-                                skb_parse flow_dissector' -- "$cur" ) )
+                            COMPREPLY=( $( compgen -W 'msg_verdict stream_verdict \
+                                stream_parser flow_dissector' -- "$cur" ) )
                             return 0
                             ;;
                         6)
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 33ed0806ccc0..db978c8d76a8 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1199,7 +1199,7 @@ static int do_help(int argc, char **argv)
 		"                 cgroup/bind4 | cgroup/bind6 | cgroup/post_bind4 |\n"
 		"                 cgroup/post_bind6 | cgroup/connect4 | cgroup/connect6 |\n"
 		"                 cgroup/sendmsg4 | cgroup/sendmsg6 }\n"
-		"       ATTACH_TYPE := { msg_verdict | skb_verdict | skb_parse |\n"
+		"       ATTACH_TYPE := { msg_verdict | stream_verdict | stream_parser |\n"
 		"                        flow_dissector }\n"
 		"       " HELP_SPEC_OPTIONS "\n"
 		"",
-- 
2.20.1


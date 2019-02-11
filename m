Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733FBC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D45218F0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vaYzKu60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfBKM5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:57:31 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38383 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfBKM5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:57:31 -0500
Received: by mail-ed1-f66.google.com with SMTP id h58so1504312edb.5;
        Mon, 11 Feb 2019 04:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tv4TgAYhDYmOnoLw7U2uAxQBjPNqBC/ZnQfdFp3DWwk=;
        b=vaYzKu60uFz4TJ/6AV3HStPXob84K6l+YdNgOBbHPO9Q2g9qCELpXBTBeVoHkuNvfw
         VIOHRiRaWAvFA+O0vLVIYxDgLhcD1hWkCMfi8owBHvrVAeHt1HJX6CqmVqJq+unQDlS8
         3aBNbmm21mC9pJPg/ByumS1jmTPDaQGjrSBWjqrKU7AB0Sih9ir97YeDbwXIm+Bvm34E
         SEGKTadneFty754DLcRY39UoCug8KNMYhv5zgAgRQ44oqpu4iYPiylaL7QxFnN/dwOTc
         j8yo/mW9KKITveKQqzA6Ys+dXRTGiGad5UZYX9LIHRgvH2w1hbEQSv9NB/kDzdp49TFx
         zyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Tv4TgAYhDYmOnoLw7U2uAxQBjPNqBC/ZnQfdFp3DWwk=;
        b=nC6ecfKEw6JPCks668Y0xvjSWc+1Ve1fb2M9SRa4pKIbBZGE+SlPHbDAD6VLqYVB+Z
         2qjk4P6BpjxM1yXrIovu9g6WBUuYuw7AV8Wi1OijlfLcpOBkLp3OSBA8o2Szk/iioapn
         Zn3LOznAc9Jy6voj1qVU6ZHOT8dIVPdPcfkyzoL0jVWXZ6pjRwDuaNYeJyePp6LBG5IP
         JInzCim44/jhuWpW2ZWjbe8FrMTq3WiGh7ejwXDRGNj4FigndiqEEOGSglOpWU8UvxCh
         U4u/TQzv1Ea2i/8onMBTeh/HMHowbISiBTMmSECMJQthUArrz5HsJRu2jay1BgQ64nGC
         bVUw==
X-Gm-Message-State: AHQUAuYmRLeOPx9DtLQfwohYwfvacmkrLLX9KWPk6IDGPVgmCBRCTcP1
        KkRV9ux4qZKS11kN2vXQzK4=
X-Google-Smtp-Source: AHgI3IYa+XOeNcBVI3boGhrkQODVb103ScuJGjNHmdH9MDEc4/6DVt+6qhhDFfWnQIFH1U/vJubECA==
X-Received: by 2002:a50:c281:: with SMTP id o1mr304890edf.136.1549889849522;
        Mon, 11 Feb 2019 04:57:29 -0800 (PST)
Received: from neptune.fritz.box ([178.19.216.175])
        by smtp.gmail.com with ESMTPSA id k13-v6sm2390684ejk.50.2019.02.11.04.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 04:57:28 -0800 (PST)
From:   Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <alban@kinvolk.io>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.fastabend@gmail.com, alban@kinvolk.io
Subject: [PATCH] bpf: bpftool, fix documentation for attach types
Date:   Mon, 11 Feb 2019 13:54:26 +0100
Message-Id: <20190211125426.21072-1-alban@kinvolk.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

bpftool has support for attach types "stream_verdict" and
"stream_parser" but the documentation was referring to them with
"skb_verdict" and "skb_parse". The inconsistency comes from commit
b7d3826c2ed6 ("bpf: bpftool, add support for attaching programs to
maps").

This patch changes the documentation to match the implementation.

Signed-off-by: Alban Crequy <alban@kinvolk.io>
---
 tools/bpf/bpftool/prog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 0640e9bc0ada..dfaa019a60f0 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1198,7 +1198,7 @@ static int do_help(int argc, char **argv)
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


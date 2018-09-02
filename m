Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8AEC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 23:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA94A20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 23:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZuyQXp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA94A20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeICDsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 23:48:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38365 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeICDsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 23:48:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id u11-v6so7771989plq.5;
        Sun, 02 Sep 2018 16:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sFaPtY6nI7qDQThR+HnBM/AIrP7kAf9zPQVSwd4WFro=;
        b=UZuyQXp+vZlyU+kv/moj5oJNA3T3olN85ySmDTxpWdqlGBEuKMpbZd63Q94ULZa1sW
         37iulkiEntrNWIorUWcnwfxcMqlPVj4nLYtN9TpHC6MeOtWxdEa6Whuup3dav2n5aCzy
         yjSda13KgYgWnTf2AllkAjvbWFJMIdWQqUJAfasHnNk2yTp/PNDFb3/nHZintH8KxFq8
         GThxBynawjbicOgw7/bLAihzs3o+vroBLcKpdNCIJwIKXp2IHRjEnkn+w1B12hIa6zbe
         oQBI7UcfQGWmzmg7Hf+KysfGlDkg5zOM9PlVasqQVb+V+oPPVPkJR9kk9ycG2iTSGENu
         zI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sFaPtY6nI7qDQThR+HnBM/AIrP7kAf9zPQVSwd4WFro=;
        b=oxNZk+eBhhFA73sSFJ3fvl/J5TkGn8oe+k3QjWs6IPdl6Tz/0a/mkVudenWpE9pZZ+
         z/dcw+oKYTB7cUTh0XkrrPgOD9Z+LwJAd9YTAIE0cxwlCtlVsgIn1Wd5JK4Gc16TaOlh
         bIlFDQg8wkxCw3tgrthz3gPr1yvTqyux/IiPXWwbwKHMlB7LpqmVdauVBob8C1p7r4Kn
         AMOfmqZ1OWswCPqt/G6Tqexv8EEo9gaVc/FHgakv35gfftRKweU5pZKGcjd9wkKBPiyf
         y20iYY4wpF/PjZa6mH6NwsdkItnUTkiQauou04l6HBqlVPTIyLIJPgtvxeSZG4K/b4OY
         biog==
X-Gm-Message-State: APzg51DGg5f/f+zifxvCZWnsui+xMLHVHpdMzfkBqgXuSfOlGyd4txFv
        9Mm5V6UNhXedjJjg3KVlD1JYGpfH
X-Google-Smtp-Source: ANB0VdZWWUQIycFni68NbJgm7YfyKMfErFphiOJbgrfviG0ZejZPEAPTJBKsV1NZh0mop2xiQhyzOw==
X-Received: by 2002:a17:902:8ec8:: with SMTP id x8-v6mr25700197plo.308.1535931036420;
        Sun, 02 Sep 2018 16:30:36 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id d19-v6sm25345583pgi.50.2018.09.02.16.30.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 16:30:35 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH bpf-next v2] libbpf: Remove the duplicate checking of function storage
Date:   Mon,  3 Sep 2018 08:30:07 +0900
Message-Id: <20180902233007.3003-1-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commit eac7d84519a3 ("tools: libbpf: don't return '.text'
as a program for multi-function programs"), bpf_program__next()
in bpf_object__for_each_program skips the function storage such as .text,
so eliminate the duplicate checking.

Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2abd0f112627..8476da7f2720 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2336,7 +2336,7 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
 		bpf_program__set_expected_attach_type(prog,
 						      expected_attach_type);
 
-		if (!bpf_program__is_function_storage(prog, obj) && !first_prog)
+		if (!first_prog)
 			first_prog = prog;
 	}
 
-- 
2.17.1


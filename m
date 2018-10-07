Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4751C65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 20:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FBB2086D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 20:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="c7CuiUUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53FBB2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeJHDb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 23:31:57 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:57732 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeJHDb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 23:31:57 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 8C5CD1D5
        for <linux-kernel@vger.kernel.org>; Sun,  7 Oct 2018 20:23:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M46LQDsHOaF1 for <linux-kernel@vger.kernel.org>;
        Sun,  7 Oct 2018 15:23:30 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 601B49FC
        for <linux-kernel@vger.kernel.org>; Sun,  7 Oct 2018 15:23:30 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id k69-v6so1349077ite.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GDHzrbWwf7H50BYiqvccLLc+rwpiyI9fiUsRn1ypPgY=;
        b=c7CuiUUD1utj2cLcXLY7DVlYIJ+7KcfFvUPUPFdut3Uh4kDV6xyhYUXn2WaBL+5v6K
         jvs7Mx3WeuAG2y/Qtr73JVJESl9vbWQ822JLhbisftKI2E1RcSiA3VDM+q0Pksk8SasS
         o7U2ddJwZbNKoRLYXu+INwuHinvDh0xouXwHuLPrPyQy0ExKbJWkCYNwgQxOkT40bSjj
         Ayklu4wFntdx8p+Px1B4y3hEV3M+5lqotD2KciEFLd/ReCwhO/nKjpyus1jaM2N15FlK
         CFos/Z5T1FgFbTcNmdcgaL2HDmOxh4sMDxcWaCHBVCuKNb0OQ7cRQTRwfFeXladXBJ1e
         4OeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GDHzrbWwf7H50BYiqvccLLc+rwpiyI9fiUsRn1ypPgY=;
        b=qtEBsshp0lbJzDX7DJfBGMo0nKipNihNdusj6ZDANaqwhGD6+d+GN05QLuf1zzgpnc
         arJ7nktX7XlcBvqvZ5kVE7+ARB2JDkh7ooqCouk38rE5xExjMvx5FPAqAx4CPbPNcrot
         BsPQ0BqEkpOZn1ic+4f86Pg8Ql3h4yphN50Ywkn1sTUwGTSzA8gqgY3vedYaXzyCUR8t
         SJ5Ax4WffBwbjPRRjA8G1Jr4wiennR0feVlA5jLONS2iK7UPHG+HXf8UowIjHEhFRTeU
         c4h3uzAvgsaQMVNVjJO2GjJzY2DPa/9EJXcSkAwFdwB+7lUcotS7IDySeQVdp3kO0d8I
         SRZQ==
X-Gm-Message-State: ABuFfogjeD3ae8/S+6iaW0w12mquGaD3g/HIq/heP99t5s/JNbtSI55Z
        3Zr/lpTw7hLA7MBRMUhHc1nj/WUSqxcMNY8/aFeLHtjopTICA6YC/FY7Qm+gHU0G6xw0FUuTsPF
        nqH2zjGLUYJOtPT907tKjrFrcshkv
X-Received: by 2002:a24:25c1:: with SMTP id g184-v6mr14260637itg.120.1538943810068;
        Sun, 07 Oct 2018 13:23:30 -0700 (PDT)
X-Google-Smtp-Source: ACcGV60rinK7Yu4tkPN05/q5x0S7kIx1qvle1YoC9BQr/QR28Or1zHd5NkNgdAZavZKzwOWrZqIFFg==
X-Received: by 2002:a24:25c1:: with SMTP id g184-v6mr14260628itg.120.1538943809886;
        Sun, 07 Oct 2018 13:23:29 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id w134-v6sm4023152itc.12.2018.10.07.13.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Oct 2018 13:23:29 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev@vger.kernel.org (open list:BPF (Safe dynamic programs and tools)),
        linux-kernel@vger.kernel.org (open list:BPF (Safe dynamic programs and
        tools))
Subject: [PATCH] bpf: btf: Fix a missing check bug
Date:   Sun,  7 Oct 2018 15:23:15 -0500
Message-Id: <1538943795-30895-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In btf_parse_hdr(), the length of the btf data header is firstly copied
from the user space to 'hdr_len' and checked to see whether it is larger
than 'btf_data_size'. If yes, an error code EINVAL is returned. Otherwise,
the whole header is copied again from the user space to 'btf->hdr'.
However, after the second copy, there is no check between
'btf->hdr->hdr_len' and 'hdr_len' to confirm that the two copies get the
same value. Given that the btf data is in the user space, a malicious user
can race to change the data between the two copies. By doing so, the user
can provide malicious data to the kernel and cause undefined behavior.

This patch adds a necessary check after the second copy, to make sure
'btf->hdr->hdr_len' has the same value as 'hdr_len'. Otherwise, an error
code EINVAL will be returned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 kernel/bpf/btf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2590700..7cce7db 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -2114,6 +2114,9 @@ static int btf_parse_hdr(struct btf_verifier_env *env, void __user *btf_data,
 
 	hdr = &btf->hdr;
 
+	if (hdr->hdr_len != hdr_len)
+		return -EINVAL;
+
 	btf_verifier_log_hdr(env, btf_data_size);
 
 	if (hdr->magic != BTF_MAGIC) {
-- 
2.7.4


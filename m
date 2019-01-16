Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7CAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAAC20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAccO/xI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbfAPTcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:32:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44229 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730949AbfAPTcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:32:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so8265261wrt.11;
        Wed, 16 Jan 2019 11:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cLAkezdImgjAZNPsAelp7TW27U5Jn+/8v6IVUEoQBRU=;
        b=WAccO/xIlKMLISMp4ICQve40+BPtURzTAYMASHFpXpbHUpLrr63kHpfHdF93gIsl+3
         faUNsLbHR8A9V7EqgUtPavU80nFL6v8oTis6ruTfO4jllGBjjhxj2ENh9XM70qoWknYc
         lTIEc0XDblVRQ5gs46DB+6sA9oxZmG36WPuzdclgQsHAK4ryEuvVG6Zn7SbArxr2Sf1u
         kWDXj44s8/3uT/ArtmzGgfCPysjeagSI56EOSxzyDxohvQjimGV60KNleZ6++nYGYz1y
         PpI/fP1bdsXCkpj+y+JdNHvxTfm+1TigDNbdZavF2OFe/ASXyFgRDL9Nk4S0dvwBUsDS
         hrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cLAkezdImgjAZNPsAelp7TW27U5Jn+/8v6IVUEoQBRU=;
        b=fAWGFQt82U2buPgvD4upBcRfn89mXTAmC3sYzbGM3XIxmmzrzzJqPK8GX/3R0J/D9f
         YgNoF10xbeV3RmPRmHgEkJYoi7kAJP4GZkCOeI1U2a8XIPzE6F7tOexvtVI8yleivxPL
         iJfmhU4ftuACL9B4Lq2YLjBhT5ILkWR17b+mYoYmVY2qoPX1RpNzvaGC5+ObLsZ8DwRm
         q+k2Xz1XSO2smMKFK4QYB5k/UzSVfM6HiiW9M4l6t2z6TrBnd/fc2SW2hK2n+wmOHcBh
         KNl2Rc53wbW35ZXzUBR2rCq3QTGWf7UQ6K6yVlrso9LqoheRR2JCwvNW7PJYNIkrPGBR
         p2cg==
X-Gm-Message-State: AJcUukcCWFEVXlGfOq5t91dwzaC0MlRYX9jGBBcNq2kvVSfTa7rU5HG/
        /52qcjYhuzSqv30NZ1uMAyE=
X-Google-Smtp-Source: ALg8bN6vJlZKjlHwglAwTvrR2P1tBz+37mOt6MtW/qOWS42mOLYoGXXsAYs7LN6miuclhbuQEsfxfw==
X-Received: by 2002:adf:b307:: with SMTP id j7mr9412984wrd.46.1547667166746;
        Wed, 16 Jan 2019 11:32:46 -0800 (PST)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id n15sm66967640wrt.21.2019.01.16.11.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 11:32:45 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 9F44B11423A3; Wed, 16 Jan 2019 20:32:44 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] bpf: Annotate implicit fall through in cgroup_dev_func_proto
Date:   Wed, 16 Jan 2019 20:32:10 +0100
Message-Id: <20190116193210.32252-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190114202941.16183-1-malat@debian.org>
References: <20190114202941.16183-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warnings (W=1).

This commit remove the following warning:

  kernel/bpf/cgroup.c:719:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 kernel/bpf/cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 9425c2fb872f..ab612fe9862f 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -718,6 +718,7 @@ cgroup_dev_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_trace_printk:
 		if (capable(CAP_SYS_ADMIN))
 			return bpf_get_trace_printk_proto();
+		/* fall through */
 	default:
 		return NULL;
 	}
-- 
2.19.2


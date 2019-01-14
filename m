Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14C2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4B32064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMu62+4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfANU02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:26:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42014 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfANU01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:26:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so383214wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NlFI7P8PMBcLMyvOkDgyAeBWuGU24UiWelShT2QIoEA=;
        b=qMu62+4A1k+Hh4aBgC6UJN8FI90nuGrGuwBajwAiODYMByVzBtjRyy3ax4Xel6D98U
         cN2ZHJulTLXj9elFiOif5YpSqjBxLJKLnqQDa8ZVz81dWWyEa/Y/vD20kGip+dO5VH2t
         NPFrlSpgWiGnMjezGmCHbSG/mHTGzit2mkshi8wc458PcZuQEys8U69jhE2zDG7QaaXY
         FP/f51CTzEQcvnifbJ59XCbGlB8+zDvkdqnxIWbbi99RSpHRC3Y9X9oI6t7jfQdTcX7F
         XHFOCoeqtB1p8yg0LJnDMsQv3eKoTXEWu1Mb/s+XB+XqSaeh+utwFjhpYy7kE3/ShC52
         t51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=NlFI7P8PMBcLMyvOkDgyAeBWuGU24UiWelShT2QIoEA=;
        b=BLrwmQb8ZGHeSuNBIjbZ3Jx5YppCouMxHMC12FhwABu32IbxvqZqF6dKVZG3gxzGMP
         KF3hhHiPjzyOHDZrv8TQkWtnDdILpX93cW3jFeBomYsrMEVCiFK+O3+yWUytYLZ9HpC0
         LpRp2I5/zspQh7tt1wLw7nqvupE8Av2iT0x7gCw+q0WNriQt6028kkFbCzQjFaQgBc4x
         c+NtLZh1sOjdtJiDlCWCEpGqLYUfTux5t4STh43NVnK9VNSxtzP4v6XcvuGfhgkZDS2Q
         4hqRvZOYUMaGRKCLVkQzrmrAlznsIqBWzb/TqzwKo0qHSh4DwV5l4Vz2Sno97StHe5RA
         VyPw==
X-Gm-Message-State: AJcUukczrvYqMvTWUXDcOeMAavuZdDl6CDanX0bSIKcMqK2+RX+mEG3N
        ssc+nOYzD++S4eXN7gEXJglp++Oh
X-Google-Smtp-Source: ALg8bN6J9BXapxGxuGTvAMhkURs+Wd96cE8+wQR9UUJvOtjR3eBc07korXgM2EzBw2iECFURJpAotQ==
X-Received: by 2002:adf:f211:: with SMTP id p17mr162071wro.293.1547497585972;
        Mon, 14 Jan 2019 12:26:25 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id l20sm149997557wrb.93.2019.01.14.12.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:26:25 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 318C011422AD; Mon, 14 Jan 2019 21:26:24 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ASN.1: annotate implicit fall throughs
Date:   Mon, 14 Jan 2019 21:26:22 +0100
Message-Id: <20190114202622.14917-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
these places in the code produced warnings (W=1). Fix them up.

This commit remove the following warnings:

  lib/asn1_decoder.c:386:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
  lib/asn1_decoder.c:449:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 lib/asn1_decoder.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/asn1_decoder.c b/lib/asn1_decoder.c
index dc14beae2c9a..fbd46bec313c 100644
--- a/lib/asn1_decoder.c
+++ b/lib/asn1_decoder.c
@@ -385,6 +385,7 @@ int asn1_ber_decoder(const struct asn1_decoder *decoder,
 	case ASN1_OP_END_SET_ACT:
 		if (unlikely(!(flags & FLAG_MATCHED)))
 			goto tag_mismatch;
+		/* fall through */
 	case ASN1_OP_END_SEQ:
 	case ASN1_OP_END_SET_OF:
 	case ASN1_OP_END_SEQ_OF:
@@ -450,6 +451,7 @@ int asn1_ber_decoder(const struct asn1_decoder *decoder,
 			pc += asn1_op_lengths[op];
 			goto next_op;
 		}
+		/* fall through */
 	case ASN1_OP_ACT:
 		ret = actions[machine[pc + 1]](context, hdr, tag, data + tdp, len);
 		if (ret < 0)
-- 
2.19.2


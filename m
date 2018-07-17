Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40984ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD42208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FwiiI4j9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD42208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbeGQBFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:05:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37240 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbeGQBFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:05:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so1295739pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 17:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DpfcA4DL5DGiiXNwkLOURJ+Yp3GG6BMVyLv9uuXYaWU=;
        b=FwiiI4j9lzXbwCUGZ35pPm6QqcSJu9MosBo+5cSpVpb9hzMZfwhSyEH5SJlhdsn6gN
         bOeeCvLIf3RbhNvgPVN1G6xwrlA8x5zPaljJyIwk8gdWOOOQg0Cayn6e5odrPTrQ4MfM
         Kb/0H4Vn9XG2ahe10c6CTAHn3Q6SXT1VAclo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DpfcA4DL5DGiiXNwkLOURJ+Yp3GG6BMVyLv9uuXYaWU=;
        b=iiQ9WOgKA1K/+kz8cFaNFATrKfNFUVvlhBPc+Par/HNsXsRZhzQd30rv9Y+khEqkJC
         29Q43HrZZF88aBiKm0DPaE3bE+MvjFA/PKthprQHFYOqNrwZRWWs3jn6Jp8SRF+Q+5bz
         XXqV1nw8hhxoHkSbRjdudnljRmEJdL88UFVyPnTkPfFSgrtK8ZmzeqP+FlX+9xSi1Rzz
         iJ9VkEdndLMKsNLzIIRBR5+BLtv4jurLMvMb6qoWvoYCHvglb/I7T0CWQTKxN/mg6pwC
         u2B8hSGubrTOUgUtEOPA7VPKTC8SYxeZCzyNQLip7oIjBuNpU2snFFCqcqIymaLA95p9
         yE+A==
X-Gm-Message-State: AOUpUlFhbyTwedijfE49MSsd8f7sqIbuCc8Ip8lzDnWenrCKcC3JoXnz
        7Mn2Qkj/HI3Llg5N8mUQzA6oZM0DsYQ=
X-Google-Smtp-Source: AAOMgpd7qF1KJCdBwN/SUwJREMt60xOm6nvCD1adpnPqPsF77Dm5UZc99LsQpCFCqwpkQ2mc5j4NLg==
X-Received: by 2002:a63:fb07:: with SMTP id o7-v6mr2805267pgh.333.1531787734225;
        Mon, 16 Jul 2018 17:35:34 -0700 (PDT)
Received: from belgium.mtv.corp.google.com ([2620:0:1000:1501:d2b0:ee44:7e40:11aa])
        by smtp.gmail.com with ESMTPSA id g11-v6sm44864206pfh.63.2018.07.16.17.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 17:35:33 -0700 (PDT)
From:   Chirantan Ekbote <chirantan@chromium.org>
To:     asmadeus@codewreck.org
Cc:     groug@kaod.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, dgreid@chromium.org,
        groeck@chromium.org, Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v2] Fix zero-copy path in the 9p virtio transport
Date:   Mon, 16 Jul 2018 17:35:29 -0700
Message-Id: <20180717003529.114368-1-chirantan@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zero-copy optimization when reading or writing large chunks of data
is quite useful.  However, the 9p messages created through the zero-copy
write path have an incorrect message size: it should be the size of the
header + size of the data being written but instead it's just the size
of the header.

This only works if the server ignores the size field of the message and
otherwise breaks the framing of the protocol. Fix this by re-writing the
message size field with the correct value.

Tested by running `dd if=/dev/zero of=out bs=4k count=1` inside a
virtio-9p mount.

Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>
---
 net/9p/trans_virtio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 05006cbb3361..65761381c58f 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -406,6 +406,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	p9_debug(P9_DEBUG_TRANS, "virtio request\n");
 
 	if (uodata) {
+		__le32 sz;
 		int n = p9_get_mapped_pages(chan, &out_pages, uodata,
 					    outlen, &offs, &need_drop);
 		if (n < 0)
@@ -416,6 +417,12 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 			memcpy(&req->tc->sdata[req->tc->size - 4], &v, 4);
 			outlen = n;
 		}
+		/* The size field of the message must include the length of the
+		 * header and the length of the data.  We didn't actually know
+		 * the length of the data until this point so add it in now.
+		 */
+		sz = cpu_to_le32(req->tc->size + outlen);
+		memcpy(&req->tc->sdata[0], &sz, sizeof(sz));
 	} else if (uidata) {
 		int n = p9_get_mapped_pages(chan, &in_pages, uidata,
 					    inlen, &offs, &need_drop);
-- 
2.18.0.203.gfac676dfb9-goog


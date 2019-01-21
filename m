Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B333C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B7521721
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjuGoXh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfAUSjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:39:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41477 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfAUSjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:39:43 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so10189513plm.8;
        Mon, 21 Jan 2019 10:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BKe9N+H2G6D7izWbPdbTh2BqAmbuiAIdIC7xoriL2EM=;
        b=WjuGoXh3LY87PQKyCPcDrK6veg43LkyFXUXhX2vDzkaNd6xNycsbN/4vpM8jvzf5uS
         o7UYAiifQNQV6Kyacwj9snA+TvyIxDRfztAKE4DhN5Dwi6/ftODYdjA8UjlrjGh1yuX+
         OVK0vc/S2LTIexhMTZcBOzZs1wG1rnbcrjpVoZmDJC6GfGYnk7UPbmsKajb8rmYN+fqx
         FGlHqqG9hoWeyHesZHwEhLdWnidCrLXbnZHQ0bQq01+gCPiIJPdrs1lqGDxoSaHVunxh
         uY7XBg6gnThJp3Hbn5ErV3a1ciU5RpMiLPoMDes8/fOLCRT1cQb2ykfdiuSjG6KfH6NW
         Qavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BKe9N+H2G6D7izWbPdbTh2BqAmbuiAIdIC7xoriL2EM=;
        b=obI6kagu3IR+AMyEEh5OlDlINftNrVyj8gTv0rPjhrqzxU1HE4TqwQiuyb2RNon7D0
         y8F28csUC80E6Ac2Y4bx5Ym5wYdT40BSDEq1r2ne4ikbzKZjz6l5dgelYmMpf1aQCpsA
         OLShpCJMlBe97KK6DJbXduohoFLdSimJ7tysCU3RxflaFAqjz6PtVI/00nsN1NAAx9Ru
         T+NwZ11S8YKx7+kLbm98vUTZBqS0Qt0CshCwyE/sNaSpS2XvymEd7U7cWLMmQwqWXhqi
         z8pFzOKhrjMjmKHsvq0XloULybsq6+ncN+HEjtTE766Ovk3TXA9Tf51tgQgDCPakd0vq
         9aQA==
X-Gm-Message-State: AJcUuke8tfE9foznbD7PjUhVCY9m0bHQfjEKwt86MJloip3TJxqCNKfV
        laDty5n5zs77SwpgSPWTuASPMoZz
X-Google-Smtp-Source: ALg8bN6IvzL3F+mmUrCCO6BMdcnq+2oiz+YODILD3UNvIhC5ztrczxG557tSTpEDl+c1ug8VK6LkhQ==
X-Received: by 2002:a17:902:7c05:: with SMTP id x5mr30650379pll.273.1548095982390;
        Mon, 21 Jan 2019 10:39:42 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v12sm14650011pgg.41.2019.01.21.10.39.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 10:39:41 -0800 (PST)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-kernel@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH net] sctp: improve the events for sctp stream reset
Date:   Tue, 22 Jan 2019 02:39:34 +0800
Message-Id: <dc740e7814086bd4d759c39310c98b214a76ae21.1548095974.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to improve sctp stream reset events in 4 places:

  1. In sctp_process_strreset_outreq(), the flag should always be set with
     SCTP_STREAM_RESET_INCOMING_SSN instead of OUTGOING, as receiver's in
     stream is reset here.
  2. In sctp_process_strreset_outreq(), move up SCTP_STRRESET_ERR_WRONG_SSN
     check, as the reset has to succeed after reconf_timer stops for the
     in stream reset request retransmission.
  3. In sctp_process_strreset_inreq(), no event should be sent, as no in
     or out stream is reset here.
  4. In sctp_process_strreset_resp(), SCTP_STREAM_RESET_INCOMING_SSN or
     OUTGOING event should always be sent for stream reset requests, no
     matter it fails or succeeds to process the request.

Fixes: 810544764536 ("sctp: implement receiver-side procedures for the Outgoing SSN Reset Request Parameter")
Fixes: 16e1a91965b0 ("sctp: implement receiver-side procedures for the Incoming SSN Reset Request Parameter")
Fixes: 11ae76e67a17 ("sctp: implement receiver-side procedures for the Reconf Response Parameter")
Reported-by: Ying Xu <yinxu@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/stream.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index 3892e76..6c188b0 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -585,9 +585,9 @@ struct sctp_chunk *sctp_process_strreset_outreq(
 	struct sctp_strreset_outreq *outreq = param.v;
 	struct sctp_stream *stream = &asoc->stream;
 	__u32 result = SCTP_STRRESET_DENIED;
-	__u16 i, nums, flags = 0;
 	__be16 *str_p = NULL;
 	__u32 request_seq;
+	__u16 i, nums;
 
 	request_seq = ntohl(outreq->request_seq);
 
@@ -615,6 +615,15 @@ struct sctp_chunk *sctp_process_strreset_outreq(
 	if (!(asoc->strreset_enable & SCTP_ENABLE_RESET_STREAM_REQ))
 		goto out;
 
+	nums = (ntohs(param.p->length) - sizeof(*outreq)) / sizeof(__u16);
+	str_p = outreq->list_of_streams;
+	for (i = 0; i < nums; i++) {
+		if (ntohs(str_p[i]) >= stream->incnt) {
+			result = SCTP_STRRESET_ERR_WRONG_SSN;
+			goto out;
+		}
+	}
+
 	if (asoc->strreset_chunk) {
 		if (!sctp_chunk_lookup_strreset_param(
 				asoc, outreq->response_seq,
@@ -637,32 +646,19 @@ struct sctp_chunk *sctp_process_strreset_outreq(
 			sctp_chunk_put(asoc->strreset_chunk);
 			asoc->strreset_chunk = NULL;
 		}
-
-		flags = SCTP_STREAM_RESET_INCOMING_SSN;
 	}
 
-	nums = (ntohs(param.p->length) - sizeof(*outreq)) / sizeof(__u16);
-	if (nums) {
-		str_p = outreq->list_of_streams;
-		for (i = 0; i < nums; i++) {
-			if (ntohs(str_p[i]) >= stream->incnt) {
-				result = SCTP_STRRESET_ERR_WRONG_SSN;
-				goto out;
-			}
-		}
-
+	if (nums)
 		for (i = 0; i < nums; i++)
 			SCTP_SI(stream, ntohs(str_p[i]))->mid = 0;
-	} else {
+	else
 		for (i = 0; i < stream->incnt; i++)
 			SCTP_SI(stream, i)->mid = 0;
-	}
 
 	result = SCTP_STRRESET_PERFORMED;
 
 	*evp = sctp_ulpevent_make_stream_reset_event(asoc,
-		flags | SCTP_STREAM_RESET_OUTGOING_SSN, nums, str_p,
-		GFP_ATOMIC);
+		SCTP_STREAM_RESET_INCOMING_SSN, nums, str_p, GFP_ATOMIC);
 
 out:
 	sctp_update_strreset_result(asoc, result);
@@ -738,9 +734,6 @@ struct sctp_chunk *sctp_process_strreset_inreq(
 
 	result = SCTP_STRRESET_PERFORMED;
 
-	*evp = sctp_ulpevent_make_stream_reset_event(asoc,
-		SCTP_STREAM_RESET_INCOMING_SSN, nums, str_p, GFP_ATOMIC);
-
 out:
 	sctp_update_strreset_result(asoc, result);
 err:
@@ -1036,10 +1029,10 @@ struct sctp_chunk *sctp_process_strreset_resp(
 					sout->mid_uo = 0;
 				}
 			}
-
-			flags = SCTP_STREAM_RESET_OUTGOING_SSN;
 		}
 
+		flags |= SCTP_STREAM_RESET_OUTGOING_SSN;
+
 		for (i = 0; i < stream->outcnt; i++)
 			SCTP_SO(stream, i)->state = SCTP_STREAM_OPEN;
 
@@ -1058,6 +1051,8 @@ struct sctp_chunk *sctp_process_strreset_resp(
 		nums = (ntohs(inreq->param_hdr.length) - sizeof(*inreq)) /
 		       sizeof(__u16);
 
+		flags |= SCTP_STREAM_RESET_INCOMING_SSN;
+
 		*evp = sctp_ulpevent_make_stream_reset_event(asoc, flags,
 			nums, str_p, GFP_ATOMIC);
 	} else if (req->type == SCTP_PARAM_RESET_TSN_REQUEST) {
-- 
2.1.0


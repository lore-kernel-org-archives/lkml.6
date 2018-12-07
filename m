Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B6CC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADCA20892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5eR0qyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADCA20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeLGGbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:31:10 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:40469 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeLGGbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:31:08 -0500
Received: by mail-pl1-f174.google.com with SMTP id u18so1359507plq.7;
        Thu, 06 Dec 2018 22:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=X6IUw1lo5W2A3uJWtvZsyMI3bRMD3FmSX7BiWko5brM=;
        b=b5eR0qyf591FzLkV8GccCUgmW6DpdjXBfOoMmf0Lcjx0MJFKXr6k0kL788LEwCG3VV
         acI9cr/G8yqx5/xYm0hxiJAx92V9W8fzMY279L27Ho6n7lfvg4ytfelQNEGlljtexX5m
         qsM7/1dvuX0q1qP1jnRp+Ikvd5jY7x5fdsTtokJR/K3yNiTofmj/2bhbI3+urUeGGgsu
         whN+NzEb21HGlEqOmJvlrhRlXMcSZTtFBCqtWQQpWAijZuWZZO9TjSrrofUHgZYO6mBp
         9Wyk4ZIlMn0SJcS7/Njevh+BVPNKjOtxB9r2i7g69QJRahrFLL2M0nlZv+QKBdPjhj+d
         /Xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=X6IUw1lo5W2A3uJWtvZsyMI3bRMD3FmSX7BiWko5brM=;
        b=dsCjkCMlMO5XwWwx9hw2m5zsYjBk8w0np3+a2walm+8G1xz/wXJVhjX6uTbTPnyzk9
         dXAP/zlrZthIokMBKLdez3OilSlzvSD7bTF2tLl5hO+ZfB/HzQNJUj6I5u1m+Sz6Wwon
         f+Rt6zp6MM2wHCa6Ic2IK06MgirB/YnSHUBp6aiYWS6BGQxjHlvlip/QS+9onLCvIhCc
         +KUiBtGwRZgabfBoktYzCg/1i3Iov6OVW5S5EzGJsfIBoilUyqPwLbDdB4foT1ozSO3d
         VC/UcDlF0yyTODdIs1evnHSMqhrxNSdRK/hCes76s5fR3VS4Rj8MtrpiOyJNYBRYyWJ0
         IsAw==
X-Gm-Message-State: AA+aEWYMNrOsmBKIFbc2ehqHF6KwDfxrorIU4bPnVHCXIDVQ3ShWYdSG
        uoKb/bHhtJYDPTrAerLd6yj5jVtwypw=
X-Google-Smtp-Source: AFSGD/VbFhC0OV/ov17Xmscq2qWShZyrvjQ1UkbzhfA1vT0Xtu8035pmmDpeN4ar/vm0Z1+6Z0CgaA==
X-Received: by 2002:a17:902:142:: with SMTP id 60mr1026596plb.330.1544164267880;
        Thu, 06 Dec 2018 22:31:07 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q199sm3431612pfc.97.2018.12.06.22.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 22:31:07 -0800 (PST)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-kernel@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Eric Paris <eparis@redhat.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCHv2 net 3/3] sctp: fa_resize sctp stream instead of redo fa_alloc
Date:   Fri,  7 Dec 2018 14:30:35 +0800
Message-Id: <3bc7041d4157e92a36a60c4868834d0a8a439041.1544163962.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <9122685dd16d04613de02594325acf79b2d04a3d.1544163962.git.lucien.xin@gmail.com>
References: <cover.1544163962.git.lucien.xin@gmail.com>
 <a4474a5886807d13146dc67e2d214b7ba3029d32.1544163962.git.lucien.xin@gmail.com>
 <9122685dd16d04613de02594325acf79b2d04a3d.1544163962.git.lucien.xin@gmail.com>
In-Reply-To: <cover.1544163962.git.lucien.xin@gmail.com>
References: <cover.1544163962.git.lucien.xin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now when doing 4-shakehand or adding new streams, sctp has to allocate
new memory for asoc->stream and copy the old stream's information from
the old asoc->stream to the new one. It also cause the stream pointers
to change, by which a panic was even caused due to stream->out_curr's
change.

To fix this, flex_array_resize() is used in sctp_stream_alloc_out/in()
when asoc->stream has been allocated. Besides, with this asoc->stream
will only be allocated once, and grow or shrink dynamically later.

Note that flex_array_prealloc() is needed before growing as fa_alloc
does, while flex_array_clear() and flex_array_shrink() are called to
free the unused memory before shrinking.

Fixes: 5bbbbe32a431 ("sctp: introduce stream scheduler foundations")
Reported-by: Ying Xu <yinxu@redhat.com>
Reported-by: syzbot+e33a3a138267ca119c7d@syzkaller.appspotmail.com
Suggested-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
---
 net/sctp/stream.c | 87 +++++++++++++++++++++++++------------------------------
 1 file changed, 40 insertions(+), 47 deletions(-)

diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index 3892e76..aff30b2 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -37,6 +37,17 @@
 #include <net/sctp/sm.h>
 #include <net/sctp/stream_sched.h>
 
+static void fa_zero(struct flex_array *fa, size_t index, size_t count)
+{
+	void *elem;
+
+	while (count--) {
+		elem = flex_array_get(fa, index);
+		memset(elem, 0, fa->element_size);
+		index++;
+	}
+}
+
 static struct flex_array *fa_alloc(size_t elem_size, size_t elem_count,
 				   gfp_t gfp)
 {
@@ -48,8 +59,9 @@ static struct flex_array *fa_alloc(size_t elem_size, size_t elem_count,
 		err = flex_array_prealloc(result, 0, elem_count, gfp);
 		if (err) {
 			flex_array_free(result);
-			result = NULL;
+			return NULL;
 		}
+		fa_zero(result, 0, elem_count);
 	}
 
 	return result;
@@ -61,27 +73,28 @@ static void fa_free(struct flex_array *fa)
 		flex_array_free(fa);
 }
 
-static void fa_copy(struct flex_array *fa, struct flex_array *from,
-		    size_t index, size_t count)
+static int fa_resize(struct flex_array *fa, size_t count, gfp_t gfp)
 {
-	void *elem;
+	int nr = fa->total_nr_elements, n;
 
-	while (count--) {
-		elem = flex_array_get(from, index);
-		flex_array_put(fa, index, elem, 0);
-		index++;
+	if (count > nr) {
+		if (flex_array_resize(fa, count, gfp))
+			return -ENOMEM;
+		if (flex_array_prealloc(fa, nr, count - nr, gfp))
+			return -ENOMEM;
+		fa_zero(fa, nr, count - nr);
+
+		return 0;
 	}
-}
 
-static void fa_zero(struct flex_array *fa, size_t index, size_t count)
-{
-	void *elem;
+	/* Shrink the unused memory,
+	 * FLEX_ARRAY_FREE check is safe for sctp stream.
+	 */
+	for (n = count; n < nr; n++)
+		flex_array_clear(fa, n);
+	flex_array_shrink(fa);
 
-	while (count--) {
-		elem = flex_array_get(fa, index);
-		memset(elem, 0, fa->element_size);
-		index++;
-	}
+	return flex_array_resize(fa, count, gfp);
 }
 
 /* Migrates chunks from stream queues to new stream queues if needed,
@@ -138,47 +151,27 @@ static void sctp_stream_outq_migrate(struct sctp_stream *stream,
 static int sctp_stream_alloc_out(struct sctp_stream *stream, __u16 outcnt,
 				 gfp_t gfp)
 {
-	struct flex_array *out;
-	size_t elem_size = sizeof(struct sctp_stream_out);
-
-	out = fa_alloc(elem_size, outcnt, gfp);
-	if (!out)
-		return -ENOMEM;
+	if (!stream->out) {
+		stream->out = fa_alloc(sizeof(struct sctp_stream_out),
+				       outcnt, gfp);
 
-	if (stream->out) {
-		fa_copy(out, stream->out, 0, min(outcnt, stream->outcnt));
-		fa_free(stream->out);
+		return stream->out ? 0 : -ENOMEM;
 	}
 
-	if (outcnt > stream->outcnt)
-		fa_zero(out, stream->outcnt, (outcnt - stream->outcnt));
-
-	stream->out = out;
-
-	return 0;
+	return fa_resize(stream->out, outcnt, gfp);
 }
 
 static int sctp_stream_alloc_in(struct sctp_stream *stream, __u16 incnt,
 				gfp_t gfp)
 {
-	struct flex_array *in;
-	size_t elem_size = sizeof(struct sctp_stream_in);
+	if (!stream->in) {
+		stream->in = fa_alloc(sizeof(struct sctp_stream_in),
+				      incnt, gfp);
 
-	in = fa_alloc(elem_size, incnt, gfp);
-	if (!in)
-		return -ENOMEM;
-
-	if (stream->in) {
-		fa_copy(in, stream->in, 0, min(incnt, stream->incnt));
-		fa_free(stream->in);
+		return stream->in ? 0 : -ENOMEM;
 	}
 
-	if (incnt > stream->incnt)
-		fa_zero(in, stream->incnt, (incnt - stream->incnt));
-
-	stream->in = in;
-
-	return 0;
+	return fa_resize(stream->in, incnt, gfp);
 }
 
 int sctp_stream_init(struct sctp_stream *stream, __u16 outcnt, __u16 incnt,
-- 
2.1.0


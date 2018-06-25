Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360BFC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9AF26089
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cw1zWgVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9AF26089
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935098AbeFYTsb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:48:31 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45200 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935028AbeFYTs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:48:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id x22-v6so1837769edq.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 12:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=etSldo+TTaIxyBqdR+aXwM2wiHco5+65A1h2yeD17QE=;
        b=cw1zWgViqVMuvVISxzbNCQo8gBMCS2YOG+H3FbHu2G1DRAdyq847wPvR2qcqDXbnaM
         wKmfSeXd4QAEzCUj3YtjL6otUSB3cALB7nKXXvRNuLic7cwZlet3F7KYtZjHKCqrRC6+
         KCDA/1fXnwWDSjJwKIRyeekejTgAoxRZI/vac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=etSldo+TTaIxyBqdR+aXwM2wiHco5+65A1h2yeD17QE=;
        b=qvUiJKKE5pqzJM9xsohMG7u/dfvF/ojb1QW/Fgm2XxQa5THoXvguqMYgWWAYZCmt5+
         GKj9ut1OL7ue+Rfkn1/vTucD2vFupKbxFYm0mmMvwhFVgkGEX3IFgqPd3pe7HLPNqKtx
         MYhfCvxmDonQGsZTphlB85SnUaNGk3pb2nBqMVTppAIqSL9p5ZixxjavmnXLiVOHiARb
         MewVbhNt89eNhc5fXflW3HPKAy+Rcu9pY8BUq7l9rzLEuSmMSiBV4bUYkfHFz8MFU9sM
         Z71+kGc/47P7Fs71ep/kWz/P614QsGE+7Pbri/VWt19f5WpRfmd8Jk3NQLe3cX2mP2AH
         n3Jw==
X-Gm-Message-State: APt69E2WGVDMuewgh29xnuNYIAEyszeVL4SvvpTFdQYO9Wm67hRAMaXq
        BiRp70ypHyAcpzVyN2kdMoBkvQ==
X-Google-Smtp-Source: ADUXVKIIA0CR35ug28qjWJjDxu+bauOCikquqHBRK3Z0owjfUh2iT+gMgn1Ou7ApKONc71031ITDfw==
X-Received: by 2002:a50:b761:: with SMTP id g88-v6mr12542608ede.129.1529956105838;
        Mon, 25 Jun 2018 12:48:25 -0700 (PDT)
Received: from localhost.localdomain (146-241-36-97.dyn.eolo.it. [146.241.36.97])
        by smtp.gmail.com with ESMTPSA id d11-v6sm17553edh.61.2018.06.25.12.48.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 12:48:25 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 4/4] block, bfq: fix service being wrongly set to zero in case of preemption
Date:   Mon, 25 Jun 2018 21:48:06 +0200
Message-Id: <20180625194806.7619-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180625194806.7619-1-paolo.valente@linaro.org>
References: <20180625194806.7619-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If
- a bfq_queue Q preempts another queue, because one request of Q
arrives in time,
- but, after this preemption, Q is not the queue that is set in service,
then Q->entity.service is set to 0 when Q is eventually set in
service. But Q should have continued receiving service with its old
budget (which is why preemption has occurred) and its old service.

This commit addresses this issue by resetting service on queue real
expiration.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d579cc8e0db6..41d9036b1822 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -634,7 +634,7 @@ static bool bfq_differentiated_weights(struct bfq_data *bfqd)
  * The following function returns true if every queue must receive the
  * same share of the throughput (this condition is used when deciding
  * whether idling may be disabled, see the comments in the function
- * bfq_bfqq_may_idle()).
+ * bfq_better_to_idle()).
  *
  * Such a scenario occurs when:
  * 1) all active queues have the same weight,
@@ -3355,7 +3355,7 @@ static bool bfq_may_expire_for_budg_timeout(struct bfq_queue *bfqq)
  * issues taken into account are not trivial. We discuss these issues
  * individually while introducing the variables.
  */
-static bool bfq_bfqq_may_idle(struct bfq_queue *bfqq)
+static bool bfq_better_to_idle(struct bfq_queue *bfqq)
 {
 	struct bfq_data *bfqd = bfqq->bfqd;
 	bool rot_without_queueing =
@@ -3588,19 +3588,19 @@ static bool bfq_bfqq_may_idle(struct bfq_queue *bfqq)
 }
 
 /*
- * If the in-service queue is empty but the function bfq_bfqq_may_idle
+ * If the in-service queue is empty but the function bfq_better_to_idle
  * returns true, then:
  * 1) the queue must remain in service and cannot be expired, and
  * 2) the device must be idled to wait for the possible arrival of a new
  *    request for the queue.
- * See the comments on the function bfq_bfqq_may_idle for the reasons
+ * See the comments on the function bfq_better_to_idle for the reasons
  * why performing device idling is the best choice to boost the throughput
- * and preserve service guarantees when bfq_bfqq_may_idle itself
+ * and preserve service guarantees when bfq_better_to_idle itself
  * returns true.
  */
 static bool bfq_bfqq_must_idle(struct bfq_queue *bfqq)
 {
-	return RB_EMPTY_ROOT(&bfqq->sort_list) && bfq_bfqq_may_idle(bfqq);
+	return RB_EMPTY_ROOT(&bfqq->sort_list) && bfq_better_to_idle(bfqq);
 }
 
 /*
@@ -3686,7 +3686,7 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 	 * may idle after their completion, then keep it anyway.
 	 */
 	if (bfq_bfqq_wait_request(bfqq) ||
-	    (bfqq->dispatched != 0 && bfq_bfqq_may_idle(bfqq))) {
+	    (bfqq->dispatched != 0 && bfq_better_to_idle(bfqq))) {
 		bfqq = NULL;
 		goto keep_queue;
 	}
@@ -4734,7 +4734,7 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 					BFQQE_BUDGET_TIMEOUT);
 		else if (RB_EMPTY_ROOT(&bfqq->sort_list) &&
 			 (bfqq->dispatched == 0 ||
-			  !bfq_bfqq_may_idle(bfqq)))
+			  !bfq_better_to_idle(bfqq)))
 			bfq_bfqq_expire(bfqd, bfqq, false,
 					BFQQE_NO_MORE_REQUESTS);
 	}
-- 
2.16.1


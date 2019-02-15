Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07B5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F80222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191678;
	bh=yroGFyXr1DKQoOXBtBFkaB/GilLvU7Nfnt5EmXm6KWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WrUaSriCbH/FkIFvXhK9MwzAzodO6Vikx7cssXuWYyyBgSFo3w5Is0Tm8AOBwByDM
	 Rh+Jy8VYihwbTgk8Eup4S3c2BdElhsPeJ/c/49R1Ng3Lh+/yhbzf1BqGdM9NSRjWZv
	 FcK4LGxTz6e/L1tCvj2CkcV6psirEVwo96kZtWns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389439AbfBOAr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:47:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:46838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389360AbfBOArz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:47:55 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 606CC222D9;
        Fri, 15 Feb 2019 00:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191674;
        bh=yroGFyXr1DKQoOXBtBFkaB/GilLvU7Nfnt5EmXm6KWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cw8O50MJ7nTEMaq2mfUU8rgq5KbmIxMSFJWLvhiU2F8FjjwLkMH59h5RKWpb8a8Cf
         C3qPbl6xg6gV6ufLYZ9f0vTXFPwN/cziHy55/X8ikvh92l0NbrzFDv2Qjldj23PBpa
         ZH6Y5h6wb3fzdJD58bnzos3UUStWVdCq2vVTQAkk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki K Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 29/43] perf cs-etm: Fix erroneous comment
Date:   Thu, 14 Feb 2019 21:45:25 -0300
Message-Id: <20190215004539.23571-30-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

The comment just before initialising the decoder is plane wrong since it
is part of the decoding queue setup function and the operation code
specifically mention that trace data is to be decoded rather than printed
out.

This patch simply fix the comment to prevent people from getting really
confused.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-8-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f3a6dfaf3026..4cc9fce97a86 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -459,7 +459,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 	if (cs_etm__init_trace_params(t_params, etm))
 		goto out_free;
 
-	/* Set decoder parameters to simply print the trace packets */
+	/* Set decoder parameters to decode trace packets */
 	if (cs_etm__init_decoder_params(&d_params, etmq,
 					CS_ETM_OPERATION_DECODE))
 		goto out_free;
-- 
2.19.1


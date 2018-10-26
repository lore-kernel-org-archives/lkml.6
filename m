Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEF9C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8529620834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="d1vYLkVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8529620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbeJZQs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:48:58 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40219 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeJZQsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:48:53 -0400
Received: by mail-it1-f195.google.com with SMTP id i191-v6so678510iti.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 01:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ZSk+vaI/1PdBVCuPWBLaeX/wD8mWlhTzJ8mRM+gr6n0=;
        b=d1vYLkVgHBieLHu7bmTiu7ussyvllHywUObgx3oSYPgrirOVfnPe/SzhSCrBy481OC
         H0iwbw5ls+8gJeDe8zaKzSOEt40rpa09ihGJ3/8ndk/8BA7QrT834brsYpzkA5PPXsry
         rvqMJV4Wlp0k3LxT8XNP6g6KNLLmpFzYMLO7F2IxYRNV2ISLcDJWqbG/49pYnz9/6jP9
         K8KQlh55bqUugao6fe3tMrDzy6AGHyhPBGplRIX0dqQ0obHCwlO0YXW8e4hMGmSvRwwu
         eww3hCqQStgUhH/JLsaSnQFqYAAg2i+fN35TyskzkuabUT9gc5V6gc/k6htrZ1237KeR
         3x/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZSk+vaI/1PdBVCuPWBLaeX/wD8mWlhTzJ8mRM+gr6n0=;
        b=Vf1lnoSQCQjn7NH1OiWWOfBBprQVfQFBZoSYSkN5/lsAmJ/JkGBQAlQQe0bWr5reYW
         XaJgGqy/5jBtpv4j+fk2+i88SkwsPp6SLC6iITJrYvXItwWMqbh2gNs0SyC0bSTF9HKE
         y21LMmfkOUxB+hJo0edE9IINhW80lLWQYsBMf0/mF5TwAweubKEX0P8p8v6K6mPX/UP5
         C+0ujFwRVa4wpaTHQVtpUL1vX+/lnaCTvLLKybj5jDDaSgER7MGlFMsxJw3KLGHBwAJz
         Fn1j2ukn4gSQMimbFkA5U4yeozAiBsltrMndzZP/N659I3In2hk3pmx20K+iMlGGFo1W
         7aIA==
X-Gm-Message-State: AGRZ1gIPLtMbffO2ssC6chdvtNlltKT+7Q5LIV7D4EBIoVbkTVVK47Nf
        pCr4Gqom5jDEds16gblV0HLbLg==
X-Google-Smtp-Source: AJdET5c5rhtvgCjNSUGFiZSEk6/gFKCm83GxoJOgwyRtDHnNpOx9hTSNH3LPNkCWuL9ZYiJaUJl9uw==
X-Received: by 2002:a24:1706:: with SMTP id 6-v6mr3336366ith.16.1540541569917;
        Fri, 26 Oct 2018 01:12:49 -0700 (PDT)
Received: from titan.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id v193-v6sm1580973ita.2.2018.10.26.01.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 01:12:49 -0700 (PDT)
From:   Hans Holmberg <hans@owltronix.com>
X-Google-Original-From: Hans Holmberg <hans.holmberg@cnexlabs.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, Javier Gonzales <javier@cnexlabs.com>,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: fix chunk close trace event check
Date:   Fri, 26 Oct 2018 10:12:24 +0200
Message-Id: <1540541544-7761-1-git-send-email-hans.holmberg@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for chunk closes suffers from an off-by-one issue, leading
to chunk close events not being traced. Fix this.

Fixes: 4c44abf43d00 ("lightnvm: pblk: add trace events for chunk states")

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---

 drivers/lightnvm/pblk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 6944aac43b01..6581c35f51ee 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -531,7 +531,7 @@ void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq *rqd)
 		if (caddr == 0)
 			trace_pblk_chunk_state(pblk_disk_name(pblk),
 							ppa, NVM_CHK_ST_OPEN);
-		else if (caddr == chunk->cnlb)
+		else if (caddr == (chunk->cnlb - 1))
 			trace_pblk_chunk_state(pblk_disk_name(pblk),
 							ppa, NVM_CHK_ST_CLOSED);
 	}
-- 
2.7.4


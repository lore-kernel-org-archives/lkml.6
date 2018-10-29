Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25518C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23592075D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="wmZhbSgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23592075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbeJ2MCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 08:02:50 -0400
Received: from nag.0l.de ([207.154.252.120]:44932 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbeJ2MCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 08:02:50 -0400
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bgTNLPMi893MPdp9xGlBIcXo5282HPUKigTLwKqNTGY=;
        b=wmZhbSgbfDBoPDszPzOXy97RoKGyNqPAmF5lWLKi/48O7zRY3XZ79pTb/JYFEQOCe8EMCL
        Y5W3AC69W5WvswprQUQ/uf5LHQFa2s7YMxFZtm40LSe/R5oaMcuCrmgJLSWJYkR574HboF
        JEYDODsk5RReJKFnhDM3S4u/YpRjqm0+JXC5DpNXWVaiJtsu94+Npj0jusyG1r+8QH+7n1
        Qha+4QRMOFuQD55RC4Hg0vw498nJy7ejrsiy2ceHi76h4c3uwdXRkd2VzxawHCFUUJdPWV
        qopxrHL4a6Va1K8OItqjqzAJIzbc+F925XTzXhTABzKBvxuA72tSvx1SXiSAXA==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, Joe Perches <joe@perches.com>,
        Steffen Vogel <post@steffenvogel.de>
Subject: [PATCH v2 12/12] w1: fix typo in comment
Date:   Mon, 29 Oct 2018 04:03:42 +0100
Message-Id: <4b3c34b6f28415eb5b73e32c6305e6d3b975a7ed.1540782140.git.post@steffenvogel.de>
In-Reply-To: <cover.1540782140.git.post@steffenvogel.de>
References: <cover.1540782140.git.post@steffenvogel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bgTNLPMi893MPdp9xGlBIcXo5282HPUKigTLwKqNTGY=;
        b=ufLA9wasEYhHEG7Be14xIxFDBeweWhPQIrEeTpguIW7PI3ig9/qv7t7BDnvKpSYKLvWByg
        FxA+J+ySCzya25hpSz38mwITtPvw5x5K5khFq8GwfIldPN0+8T2woxWopn0DVqTrZnJA8s
        9iybYPEmjxePXRX3o/ucHnIGPjBq991N+3ZgTgz+N5/WD5ElZTixsV5yh/w7L5OudES2XH
        XOAWs+Ysc52uDdiLbvPs68bOVK9M18GsLfqlqDnFxK4lk4bASPBGD+wLNzbuCKFhbBGHGU
        2BoRsc6zGZFJtI9O3Z3qotnIHiZ8M1bslMaaSaA+eXK+qbyg6qFJuKUWulRmiQ==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540782276; a=rsa-sha256;
        cv=none;
        b=BoP6rVJMLwI++WWW27lXAirx9oKKqMUTGwNOtgBIGuyOaFJx89djV7ygHEWovKfHRFajtWqOV5QlJ+/OqswzcgFmOkgtbleUfK/BGYEvYcViGgTdDaYoiB36nFFNaHN5OJ1rwoxqofpHn5j9MvdE6uaE3jouWhUYMHCN3e/Vsd4krVrFpdRSoXAS5UUVjnJWNoQbfgSxBlJuZfYZgUqptaOmyO4cUunF7jUWgiLTNhgs7bF7kEEd3xbWNtYhWkgH/rEwOE0JTy8dTFvsPCMKzQPtbBNzE4ZANweMSyuBIsEU2TMeQkD5HBjW61ppqK5jQ/XYcS6oh1WW63Q71WlPXA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Steffen Vogel <post@steffenvogel.de>
---
 drivers/w1/w1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 1326bd52888a..94747eeff0fa 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -1196,7 +1196,7 @@ int w1_process(void *data)
 
 		__set_current_state(TASK_INTERRUPTIBLE);
 
-		/* hold list_mutex until after interruptible to prevent loosing
+		/* hold list_mutex until after interruptible to prevent losing
 		 * the wakeup signal when async_cmd is added.
 		 */
 		mutex_unlock(&dev->list_mutex);
-- 
2.11.0


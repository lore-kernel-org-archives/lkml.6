Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F6FC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 18:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8045921477
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 18:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cfu8GmYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8045921477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeIXA5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 20:57:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33170 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeIXA5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 20:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GnMZaU79acqOb3GpZAVp8FSzYmznOaNUQNwxndMS23w=; b=cfu8GmYhwicqB7i+Q0HokB1yo
        CLvWFijU9iuJcJquLUdE7nARR8AYMUDOrRCxxkvUjLWP+uqKBpGW1B78/yailRGc73jKXhqk8EQNt
        pcP+Jwv5KZEQGkq+GTbacfD7PfbSBVrrlQo4g6B4619anBmQ6yiGPo9lr9vTMfr8R3j3djGYZbxUv
        o401EvcrEm8y8bH5iN5fpf8614b5YHDtOuU+tR03WOZqgrJCTbKGvGG4SllFYkeuNRFMMFx08rG78
        sM7/QkPcmOHWITKo8hMp61QNgABPTVKAaomhi0YEm8gHuOsrH5BGhE5U4es4Vvrt7SI2V3BSqNUiS
        Yyd7EJ+Ig==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g49bC-0005Lw-Jf; Sun, 23 Sep 2018 18:59:18 +0000
To:     linux-wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] cfg80211: fix reg_query_regdb_wmm kernel-doc
Message-ID: <cfbd4e00-0abc-f265-9e38-ce6655f09b83@infradead.org>
Date:   Sun, 23 Sep 2018 11:59:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop @ptr from kernel-doc for function reg_query_regdb_wmm().
This function parameter was recently removed so update the
kernel-doc to match that and remove the kernel-doc warnings.

Removes 109 occurrences of this warning message:
../include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'

Fixes: 38cb87ee47fb ("cfg80211: make wmm_rule part of the reg_rule structure")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org
---
 include/net/cfg80211.h |    2 --
 1 file changed, 2 deletions(-)

--- lnx-419-rc5.orig/include/net/cfg80211.h
+++ lnx-419-rc5/include/net/cfg80211.h
@@ -4852,8 +4852,6 @@ const char *reg_initiator_name(enum nl80
  *
  * @alpha2: the ISO/IEC 3166 alpha2 wmm rule to be queried.
  * @freq: the freqency(in MHz) to be queried.
- * @ptr: pointer where the regdb wmm data is to be stored (or %NULL if
- *	irrelevant). This can be used later for deduplication.
  * @rule: pointer to store the wmm rule from the regulatory db.
  *
  * Self-managed wireless drivers can use this function to  query



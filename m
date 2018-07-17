Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6003AECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082932086B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyfNfQnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082932086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeGQGDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 02:03:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45487 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeGQGDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 02:03:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id f1-v6so259347pgq.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 22:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=1IjHaOgEjZD2spV2dDvxU8iK7OSWSfmBppTX7LrDDHY=;
        b=KyfNfQnQn3pyqMl8YT6L5nhNMgDbFfCgmdnTiOAcLUcxrIFdU8uTQetMW+FCClANJC
         YcMm+X/alWYfzs1ZpYoGKkiLcCM5Zlb5q9QAqKk3XLJf+OVJraqA1l9IK0ESawrPpc3m
         X3rXqK6vrdORbzXL5ZvYg9IrjFjd8+BYm3fByclKPNQbR4wQyOITDyPfQBDlROfHBkoA
         zAGK1/4rWbwl62WCvknaiACuxisstZr44kvNCaN7oA10MV3Tpw21KAoExDwFgIaiG/bw
         Yzh/epLYTabm4B/iM/HK2bTwBFo+sfWjA8hGUE9j9JWNdLCIRjdXG8gedX5ZlmlNu47N
         q6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=1IjHaOgEjZD2spV2dDvxU8iK7OSWSfmBppTX7LrDDHY=;
        b=gcNQ6FKE29279/3drQeOs3b5D4MlwV6I38mQMQbrqTmj58SEZ/pc2RIqrGMXlidFam
         e0GBTJwZWabZNVIKg8/5aE/0WMGJMf+b9zuB4Rj3WanX7IyfoOnqzMENOor24CHAyvd9
         YD4sqM4+HanUktr1WLv/2UzPSJ+y8TLqgFd3KHrZLwoVD6ZkaMqmpVWI9t0F6h2z0zVk
         xDUoST7sl1DFqvaaCZa/OqvoKBuuJC8br4BxRnXRf8oQEotOfGREuvk3OtAp2OS0GqyZ
         AWvsvrrkqHIOdgiWVAD8hc/S2/Qu5CzrCHQ9TSid8eQZhKuyWzcFHEwkHATLzNbtzDUD
         54ww==
X-Gm-Message-State: AOUpUlFlu/hggt5w39hcXFlYA1pG0bhIb1xv5BeAFcrWiCAJthNW19i4
        6Itctginl5VE0xUgUtr3ycmT
X-Google-Smtp-Source: AAOMgpdPSbXQrdEOG57G8b8Xv7CldTeTcqdLSaMENAYBR/YAdTvn8vXI2I37JyA0uh1+kVYRgDQC/w==
X-Received: by 2002:a65:4107:: with SMTP id w7-v6mr182405pgp.302.1531805565089;
        Mon, 16 Jul 2018 22:32:45 -0700 (PDT)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id y85-v6sm156220pfa.170.2018.07.16.22.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 22:32:44 -0700 (PDT)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        xishi.qiuxishi@alibaba-inc.com, zy.zhengyi@alibaba-inc.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mm: soft-offline: fix race against page allocation
Date:   Tue, 17 Jul 2018 14:32:30 +0900
Message-Id: <1531805552-19547-1-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've updated the patchset based on feedbacks:

- updated comments (from Andrew),
- moved calling set_hwpoison_free_buddy_page() from mm/migrate.c to mm/memory-failure.c,
  which is necessary to check the return code of set_hwpoison_free_buddy_page(),
- lkp bot reported a build error when only 1/2 is applied.

  >    mm/memory-failure.c: In function 'soft_offline_huge_page':
  > >> mm/memory-failure.c:1610:8: error: implicit declaration of function
  > 'set_hwpoison_free_buddy_page'; did you mean 'is_free_buddy_page'?
  > [-Werror=implicit-function-declaration]
  >        if (set_hwpoison_free_buddy_page(page))
  >            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
  >            is_free_buddy_page
  >    cc1: some warnings being treated as errors

  set_hwpoison_free_buddy_page() is defined in 2/2, so we can't use it
  in 1/2. Simply doing s/set_hwpoison_free_buddy_page/!TestSetPageHWPoison/
  will fix this.

v1: https://lkml.org/lkml/2018/7/12/968

Thanks,
Naoya Horiguchi
---
Summary:

Naoya Horiguchi (2):
      mm: fix race on soft-offlining free huge pages
      mm: soft-offline: close the race against page allocation

 include/linux/page-flags.h |  5 +++++
 include/linux/swapops.h    | 10 ---------
 mm/hugetlb.c               | 11 +++++-----
 mm/memory-failure.c        | 53 ++++++++++++++++++++++++++++++++++++++--------
 mm/migrate.c               | 11 ----------
 mm/page_alloc.c            | 30 ++++++++++++++++++++++++++
 6 files changed, 84 insertions(+), 36 deletions(-)

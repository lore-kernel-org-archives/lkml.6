Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9825CC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53AA4219C5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OeYrg3uK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AA4219C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754186AbeFUSI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:08:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51660 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFUSI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:08:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id r15-v6so6575956wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 11:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id;
        bh=787i5ne8xOGmRrDvt2UBjOT4szY03r5HD4JmyT5Q9Q8=;
        b=OeYrg3uKJWBCcFNZCJBF6sU4jzYFHIvvcBVv0PcgJuFzCbIF2CR/gEF/ry9HDq6/Ok
         qdMGebGEWgkNyr+nzfsc0s/LrN19oneTK7l0RTiK7upiVgtsxHVUl9VFdgnCvgLuiFtl
         ctWMcmPeFsiHVICHN8ycBGqu22Tvd6gHrM9qHHIr40ILSfhxBrUcJLS4sS0flcon/4jB
         OsXfQ07DnjkoDD+wNt5zrhHUCqXFAd3M5l58n/ki4dlYDyKaoG7JI19N0t98OO5Nw3EH
         hZluXyjMbZ6iV/1TtNWVWODf4H0ZqbWNb9AQzpM3SPlRTaxzvWTcZQUlKABFlB2h3C7M
         4AWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=787i5ne8xOGmRrDvt2UBjOT4szY03r5HD4JmyT5Q9Q8=;
        b=KT+NmPmYQXHlqcw/CowaEbpitHaqSQoqD+LPZMjXJTKgoxHsnUBSwLgMxZmxlwKCLY
         6EplBOCzlX2X8g80Xe1PC5bZv3F+nS4sf1/IRLT0n71jmn6lho+nC/3FTxPLcc48LERL
         rX/Ar2oBPxsqR3uyMH/1DYHrJ5hqL7lOqniRftru6yhn4xqTkuxTLwED2GUQvEfvRd2b
         VC1LyLi2yxJF9O0pNVxdOavFVpACvihJjZQXbyLCwzOINu9QEIR7Q53gU4EWbrwzDMmI
         r/xcGBDqsYe/Va2JU4OKIcRWIx3c5PaYKwYcVz9jdPzHiF4SmqjVBjJPVD30YVfZtis/
         Z1VQ==
X-Gm-Message-State: APt69E3eJX1OcD1oqfFQ1SRMYx3x99VV0hSNV8bnNSH3qweO0cmok6dW
        X+jKlU8ZgZi8Taw08FCSq6RwjS5o5LY=
X-Google-Smtp-Source: ADUXVKKExCs30ybjtuWOrTuRtCWIP4UUmojf/c2lcu6g5dxw48AxC1cusm2oDMnh2Ak2b63njS//Yg==
X-Received: by 2002:a1c:1d1:: with SMTP id 200-v6mr5806590wmb.145.1529604504672;
        Thu, 21 Jun 2018 11:08:24 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id 127-v6sm9165927wmk.45.2018.06.21.11.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 11:08:24 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [RFC 0/3] iommu/iova: Unsafe locking in find_iova()
Date:   Thu, 21 Jun 2018 19:08:20 +0100
Message-Id: <20180621180823.805-1-dima@arista.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_iova() looks to be using a bad locking practice: it locks the
returned iova only for the search time.
And looking in code, the element can be removed from the tree and freed
under rbtree lock. That happens during memory hot-unplug and cleanup on
module removal.
Here I cleanup users of the function and delete it.

Dmitry Safonov (3):
  iommu/iova: Find and split iova under rbtree's lock
  iommu/iova: Make free_iova() atomic
  iommu/iova: Remove find_iova()

 drivers/iommu/intel-iommu.c | 14 +++----------
 drivers/iommu/iova.c        | 48 +++++++++++++++++----------------------------
 include/linux/iova.h        | 17 ++++------------
 3 files changed, 25 insertions(+), 54 deletions(-)

-- 
2.13.6


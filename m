Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78282C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFF9214C1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIq1rICa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFF9214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbeIYVn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:43:57 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45753 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbeIYVn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:43:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id l2-v6so13814976qtr.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zmMx8yGF2OFaGDrGLP10cOWskpeqGFJHfbD3OLaMleM=;
        b=uIq1rICakArgZk3qwEvxox6OmyjePwiG7xh9g+kVuhOFuL8b2xrVmTfn6nQadYj8Ra
         d3NinKLYTjyUKbOwVlKsH+/SGExZfqKyOdBBLI7EUdE1fzh2iK6RlwaJ79SrGntMP5mC
         LV8e8VBHI2W7oTRCawjmp57F0qRiGizkISSQrZUJ5bdARTXmo/l+4GvQSiG48JuoE/KL
         pbT3ezTr5cbd6gg4ZnFxwMX7yjVbHrbwMZL/vGi4hRJmHniitVCsPVmb24tBHqlJoA01
         QjkHUl4LTtNVbDYg3U2IPoPXUD0YNCdwS8VOcIwAyRu/d9CIQH8wW4QkwxYm3cJH16A9
         GvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zmMx8yGF2OFaGDrGLP10cOWskpeqGFJHfbD3OLaMleM=;
        b=ZDQnsaM8gVP8qo6cs/qbE6nVjk1uVBzQ/nyrQA6Cos29pCxwcHW4HIePEPy26bF+Cc
         HyKVOjpnbS2fMevXqyGDFv0Vu7HAtNRs1wYS2v5T3ZqwFI/+fhxBfCEAuv3aROJtbW/E
         Dw2LoIVPfoAhGtPO8mf//axvC/yPRqP/LhwbPROKHy7Dnis24eSoySOWOfI/Fg3DwrnN
         7QvE3w4EDt0EQ1Lxcd1nXzDAhNZuP5GB9NdrhXSle1pcBUHkgeT2qJJI6tg4wYHRU9eu
         9DuLI+Ov+wfdY0oIrB/pEauImKfC4A/vlXlcSAvcq06jIMhkqcbRI2Gas+h7eX3KJwp1
         /Yvw==
X-Gm-Message-State: ABuFfojQ2evrrZ4V7BSuNNcsybzphp/u6JOkCgHykTCYDHEhfs94ngPS
        jb73dTcI/R74YOG+5BFgsQ==
X-Google-Smtp-Source: ACcGV63wS1WKBI0YbhfLHP4QihtHouz+H9wVNMXZhdJdir1trbreD+SW5t6byYt+GdN0dRoX3+cMDg==
X-Received: by 2002:aed:2a0d:: with SMTP id c13-v6mr1204944qtd.147.1537889753461;
        Tue, 25 Sep 2018 08:35:53 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p18-v6sm2056304qtp.3.2018.09.25.08.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 08:35:52 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     linux-mm@kvack.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2 0/3] mm: Fix for movable_node boot option
Date:   Tue, 25 Sep 2018 11:35:29 -0400
Message-Id: <20180925153532.6206-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series are the fix for movable_node boot option
issue which was introduced by commit 124049decbb1 ("x86/e820:
put !E820_TYPE_RAM regions into memblock.reserved").

First patch, revert the commit. Second and third patch fix the
original issue.

Masayoshi Mizuma (1):
  Revert "x86/e820: put !E820_TYPE_RAM regions into memblock.reserved"

Naoya Horiguchi (1):
  mm: zero remaining unavailable struct pages

Pavel Tatashin (1):
  mm: return zero_resv_unavail optimization

 arch/x86/kernel/e820.c   | 15 +++--------
 include/linux/memblock.h | 15 -----------
 mm/page_alloc.c          | 54 +++++++++++++++++++++++++++-------------
 3 files changed, 40 insertions(+), 44 deletions(-)

-- 
2.18.0


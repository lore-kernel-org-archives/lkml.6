Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28653C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D935123FDF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D935123FDF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753583AbeGFHN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:13:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:44850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753096AbeGFHNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:13:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7568FAD72;
        Fri,  6 Jul 2018 07:13:24 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Herbert <tom@quantonium.net>
Date:   Fri, 06 Jul 2018 17:11:32 +1000
Subject: [PATCH 0/3] rhashtable: replace rhashtable_walk_peek implementation
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <153086101070.2825.6850140624411927465.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of these three patches with no change
from last time.
The last patch has an Ack from Tom Herbert and Herbert Xu, but the
first two which are necessary pre-requisites don't yet.

Thanks,
NeilBrown

---

NeilBrown (3):
      rhashtable: further improve stability of rhashtable_walk
      rhashtable: add rhashtable_walk_last_seen()
      rhashtable: implement rhashtable_walk_peek() using rhashtable_walk_last_seen()


 include/linux/rhashtable-types.h |    1 
 include/linux/rhashtable.h       |   40 +++++++++++-
 lib/rhashtable.c                 |  124 ++++++++++++++++++++++----------------
 3 files changed, 110 insertions(+), 55 deletions(-)

--
Signature


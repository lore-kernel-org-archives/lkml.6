Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB91ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C211920857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C211920857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbeKIBke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:40:34 -0500
Received: from anholt.net ([50.246.234.109]:33190 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbeKIBkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:40:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 7212710A1336;
        Thu,  8 Nov 2018 08:04:24 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id KCeizwoiU-U8; Thu,  8 Nov 2018 08:04:23 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 208D410A1218;
        Thu,  8 Nov 2018 08:04:23 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 4F0E92FE1B8F; Thu,  8 Nov 2018 08:04:22 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH 0/2] reverts to un-regress v3d
Date:   Thu,  8 Nov 2018 08:04:20 -0800
Message-Id: <20181108160422.17743-1-eric@anholt.net>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not committed to any of these reverts, as long as the authors can
get them fixed.  The changes are too intricate for me to make sense of
and try to fix myself.

Eric Anholt (2):
  Revert "drm/sched: fix timeout handling v2"
  drm: Revert syncobj timeline changes.

 drivers/gpu/drm/drm_syncobj.c          | 359 +++++--------------------
 drivers/gpu/drm/scheduler/sched_main.c |  30 +--
 include/drm/drm_syncobj.h              |  73 +++--
 3 files changed, 106 insertions(+), 356 deletions(-)

-- 
2.19.1


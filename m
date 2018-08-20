Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C25C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C4621534
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C4621534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeHTUpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 16:45:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726455AbeHTUpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 16:45:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92458401BF61;
        Mon, 20 Aug 2018 17:20:36 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-120-60.rdu2.redhat.com [10.10.120.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 314F32156889;
        Mon, 20 Aug 2018 17:20:33 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     "David Airlie" <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, "Ben Skeggs" <bskeggs@redhat.com>,
        "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH 0/2] drm/nouveau: Fix GM107 disp init failures on ThinkPad P50
Date:   Mon, 20 Aug 2018 13:20:25 -0400
Message-Id: <20180820172030.10963-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 20 Aug 2018 17:20:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 20 Aug 2018 17:20:36 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes some intermittent issues with bringing up the
dedicated GM107 GPU that I've been observing on my ThinkPad P50. More
details within.

Lyude Paul (2):
  drm/nouveau: Fix GM107 disp core chan init on ThinkPad P50
  drm/nouveau: Fix GM107 disp dmac chan init on ThinkPad P50

 .../drm/nouveau/nvkm/engine/disp/coregf119.c  | 21 +++++++++++++++++--
 .../drm/nouveau/nvkm/engine/disp/dmacgf119.c  | 19 +++++++++++++++--
 2 files changed, 36 insertions(+), 4 deletions(-)

-- 
2.17.1


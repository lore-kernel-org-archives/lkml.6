Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EBBC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE11206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE11206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeIGCVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:21:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726086AbeIGCVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:21:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E17E402170B;
        Thu,  6 Sep 2018 21:43:40 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3662A30BB;
        Thu,  6 Sep 2018 21:43:37 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     "David Airlie" <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, "Ben Skeggs" <bskeggs@redhat.com>
Subject: [PATCH v4 0/6] Backlight fixes and cleanup
Date:   Thu,  6 Sep 2018 17:43:20 -0400
Message-Id: <20180906214328.24012-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 06 Sep 2018 21:43:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 06 Sep 2018 21:43:40 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor for Ben, hopefully this time this should apply to his tree.
Next version of https://patchwork.freedesktop.org/series/48596/

No changes otherwise.

Lyude Paul (6):
  drm/nouveau: Check backlight IDs are >= 0, not > 0
  drm/nouveau: Add NV_PRINTK_ONCE and variants
  drm/nouveau: Move backlight device into nouveau_connector
  drm/nouveau: s/nouveau_backlight_exit/nouveau_backlight_fini/
  drm/nouveau: Cleanup indenting in nouveau_backlight.c
  drm/nouveau: Refactor nvXX_backlight_init()

 drivers/gpu/drm/nouveau/nouveau_backlight.c | 220 ++++++++++----------
 drivers/gpu/drm/nouveau/nouveau_connector.c |  20 ++
 drivers/gpu/drm/nouveau/nouveau_connector.h |  33 +++
 drivers/gpu/drm/nouveau/nouveau_display.c   |   2 -
 drivers/gpu/drm/nouveau/nouveau_display.h   |  25 ---
 drivers/gpu/drm/nouveau/nouveau_drv.h       |  10 +-
 6 files changed, 168 insertions(+), 142 deletions(-)

-- 
2.17.1


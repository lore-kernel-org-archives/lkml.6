Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AADC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBF52150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBF52150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732956AbeISWwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:52:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731056AbeISWwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:52:50 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E2C7317C3E8;
        Wed, 19 Sep 2018 17:13:59 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-122-250.rdu2.redhat.com [10.10.122.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07CCF45B29;
        Wed, 19 Sep 2018 17:13:55 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     "David Airlie" <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, "Ben Skeggs" <bskeggs@redhat.com>
Subject: [PATCH 0/2] drm/nouveau: Allow parsing vbios.rom with nvbios from debugfs
Date:   Wed, 19 Sep 2018 13:13:50 -0400
Message-Id: <20180919171353.29648-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 19 Sep 2018 17:13:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small patch series that adds a strap_peek file into our
debugfs, and sets the size of the vbios.rom debugfs file so that nvbios
can easily be used to parse the vbios even on systems where the normal
BIOS retrieval methods (for example, laptops that need ACPI to access
the vbios for the nvidia GPU) won't work. This should make it a little
easier to collect vbioses.

Lyude Paul (2):
  drm/nouveau: Add strap_peek to debugfs
  drm/nouveau: Add size to vbios.rom file in debugfs

 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 46 ++++++++++++++++++++---
 1 file changed, 41 insertions(+), 5 deletions(-)

-- 
2.17.1


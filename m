Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C29CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52682086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52682086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbeKQJjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:39:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbeKQJjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:39:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B4F3931256C4;
        Fri, 16 Nov 2018 23:24:51 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08C7B5D6B3;
        Fri, 16 Nov 2018 23:24:47 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     Jerry Zuo <Jerry.Zuo@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        "Leo Li" <sunpeng.li@amd.com>, "David Airlie" <airlied@linux.ie>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, "Roman Li" <roman.li@amd.com>,
        dri-devel@lists.freedesktop.org,
        "David (ChunMing) Zhou" <david1.zhou@amd.com>,
        "Shirish S" <shirish.s@amd.com>,
        "Jerry (Fangzhi) Zuo" <jerry.zuo@amd.com>,
        "Harry Wentland" <harry.wentland@amd.com>,
        "Lyude Paul" <lyude@redhat.com>, "Tony Cheng" <tony.cheng@amd.com>
Subject: [PATCH 0/2] drm/amd/dm: Misc MST connector fixes
Date:   Fri, 16 Nov 2018 18:24:37 -0500
Message-Id: <20181116232443.1709-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 16 Nov 2018 23:24:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some fixes for things I spotted after trying to look at a bug Jerry Zuo
mentioned to me. Didn't manage to reproduce the bug! But I found these.

Cc: Jerry Zuo <Jerry.Zuo@amd.com>

Lyude Paul (2):
  drm/amd/dm: Don't forget to attach MST encoders
  drm/amd/dm: Understand why attaching path/tile properties are needed

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.19.1


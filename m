Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3902C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690B8217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130564;
	bh=dAnFGKfg8IJWOTpJrl1WBr4c4BZZrX9/eaDigz7P4U8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vr4EKQMeVYe1JsyUn0KzBnQcwVhLi8r10bhmebtdAvLNKkDbaMM9O4o17MuYTyBIr
	 9NCLpOzQIPn3UECmw8rsrYFZC1XIZwcNFwXJpViUsyM5ZZ5ZBnhiS9i//USLR7HnF3
	 rMfdhghsY0S8/hIX8NU3OQomeDAfKgLWkxUuGztY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733096AbfBYVgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:36:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733083AbfBYVf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:35:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FCDC217F5;
        Mon, 25 Feb 2019 21:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130559;
        bh=dAnFGKfg8IJWOTpJrl1WBr4c4BZZrX9/eaDigz7P4U8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ox+DWGrb6+GFIzJ/W4MaL+vEYgAjqWP8e+jyPX253wDBPfAbGIJmSwI253mCjioNh
         hjTqnhScI8Qwl3RFZys1vR0pM3/k76fBcp1sWrpa3yk0cbk51spoYECVzqEY5LZtA+
         lXJOdTqs2QatPRTVrzV7tYWASD0MR2BdViQXy/gw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 4.20 159/183] drm/amdgpu: disable bulk moves for now
Date:   Mon, 25 Feb 2019 22:12:12 +0100
Message-Id: <20190225195121.805039311@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian König <ckoenig.leichtzumerken@gmail.com>

commit a213c2c7e235cfc0e0a161a558f7fdf2fb3a624a upstream.

The changes to fix those are two invasive for backporting.

Just disable the feature in 4.20 and 5.0.

Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Cc: <stable@vger.kernel.org>    [4.20+]
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -637,12 +637,14 @@ void amdgpu_vm_move_to_lru_tail(struct a
 	struct ttm_bo_global *glob = adev->mman.bdev.glob;
 	struct amdgpu_vm_bo_base *bo_base;
 
+#if 0
 	if (vm->bulk_moveable) {
 		spin_lock(&glob->lru_lock);
 		ttm_bo_bulk_move_lru_tail(&vm->lru_bulk_move);
 		spin_unlock(&glob->lru_lock);
 		return;
 	}
+#endif
 
 	memset(&vm->lru_bulk_move, 0, sizeof(vm->lru_bulk_move));
 



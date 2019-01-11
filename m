Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0B0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B335620872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217862;
	bh=+rYH8lvAmI6yrFP2QNefAba/v+8jRraooH24duOg0Xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m87RWmS3zhX9jgNBsXnkHJ+JwFLvRjC0lVP4XFJctyCC4Y4eYXfuNT7MgEs+VtoNB
	 mSZd7yXvj4SohqIALIUBm/xEYZmNTx3E2cPf6OYS1BBMZN1FA0or7OqdPRqGDKWUHd
	 SMkx9VQCzN2HhEwicgzrsNUoGmtPXj7fMxIDpS9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404601AbfAKOoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:44:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:37184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404569AbfAKOoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:44:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89C5020872;
        Fri, 11 Jan 2019 14:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217854;
        bh=+rYH8lvAmI6yrFP2QNefAba/v+8jRraooH24duOg0Xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUKvZL6l1wlvQpW3eJAbDBI3AMT937H/tpd5sKy2wzjLQSnZy7ja9W6VWQXzmn3cA
         ZVSUJViE5mWxWFeBPEpW8IFXs0GsfNEaorKaRAWyId2/BJW4Xwel7nSd6PEcz/8RrZ
         SoCaibIbZM9AXpJQT4+nRZxyKY8G5/j09QuiJWB4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 4.20 64/65] drm/vc4: Set ->is_yuv to false when num_planes == 1
Date:   Fri, 11 Jan 2019 15:15:50 +0100
Message-Id: <20190111131104.489893319@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
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

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit 2b02a05bdc3a62d36e0d0b015351897109e25991 upstream.

When vc4_plane_state is duplicated ->is_yuv is left assigned to its
previous value, and we never set it back to false when switching to
a non-YUV format.

Fix that by setting ->is_yuv to false in the 'num_planes == 1' branch
of the vc4_plane_setup_clipping_and_scaling() function.

Fixes: fc04023fafecf ("drm/vc4: Add support for YUV planes.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20181009132446.21960-1-boris.brezillon@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vc4/vc4_plane.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -321,6 +321,7 @@ static int vc4_plane_setup_clipping_and_
 		if (vc4_state->is_unity)
 			vc4_state->x_scaling[0] = VC4_SCALING_PPF;
 	} else {
+		vc4_state->is_yuv = false;
 		vc4_state->x_scaling[1] = VC4_SCALING_NONE;
 		vc4_state->y_scaling[1] = VC4_SCALING_NONE;
 	}



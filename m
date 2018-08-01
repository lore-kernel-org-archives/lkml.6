Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEF4C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE862083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE862083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbeHAUJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:09:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46032 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404414AbeHATDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:39 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 23E6E11DF;
        Wed,  1 Aug 2018 17:08:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philippe Cornu <philippe.cornu@st.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        yannick fertre <yannick.fertre@st.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 279/336] drm/stm: ltdc: fix warning in ltdc_crtc_update_clut()
Date:   Wed,  1 Aug 2018 18:50:14 +0200
Message-Id: <20180801165039.702352794@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philippe CORNU <philippe.cornu@st.com>

[ Upstream commit c20f5f69c898899027c3e573afaab837195895b6 ]

Fix the warning
"warn: variable dereferenced before check 'crtc' (see line 390)"
by removing unnecessary checks as ltdc_crtc_update_clut() is
only called from ltdc_crtc_atomic_flush() where crtc and
crtc->state are not NULL.

Many thanks to Dan Carpenter for the bug report
https://lists.freedesktop.org/archives/dri-devel/2018-February/166918.html

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: yannick fertre <yannick.fertre@st.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180410135312.3553-1-philippe.cornu@st.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/stm/ltdc.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -392,9 +392,6 @@ static void ltdc_crtc_update_clut(struct
 	u32 val;
 	int i;
 
-	if (!crtc || !crtc->state)
-		return;
-
 	if (!crtc->state->color_mgmt_changed || !crtc->state->gamma_lut)
 		return;
 



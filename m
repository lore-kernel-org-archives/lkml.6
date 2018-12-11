Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23596C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA29A2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543649;
	bh=i1AL47QXyFpCHR2KRj1Rd/S/qHnibn+6CAjJhtbas24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nY6/2NeWbcI+ApbqMJC0b47VsjfWTH3JVA0Glgi3LWR6qYunOeJavRN82cRrjPXjw
	 i5UVkRgIZN8hYoAfIXdeAeZAireCsf+4ufVDYb+w7tj/SeS1k95fAxqh3MrJR0/oWk
	 X0KMMlcTnD7tO5ChhqDwsLaDUa8FpIKO+AuXGvXM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA29A2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbeLKPyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:54:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:42704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730035AbeLKPyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:54:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF70820855;
        Tue, 11 Dec 2018 15:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543644;
        bh=i1AL47QXyFpCHR2KRj1Rd/S/qHnibn+6CAjJhtbas24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C0mKRJUN/aHdDV19WIXzRiSyeg/Jpo5XFdaYq3QVpWlIgL+ZJuxzNWCx4HHDTdhmM
         oEQh61Xgx2e+H5DXLZoV9oxa+zryFwsXdXIzC7V2qUYcpQ1HpKMUgjE9aOML18hqdH
         fZvISbWwKTyKTnKgqKRof7+964YiqO96qZbesK0I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 001/118] media: vicodec: lower minimum height to 360
Date:   Tue, 11 Dec 2018 16:40:20 +0100
Message-Id: <20181211151644.276995450@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7cf7b2e977abf3f992036939e35a8eab60013aff ]

Lower the minimum height to 360 to be consistent with the webcam input of vivid.

The 480 was rather arbitrary but it made it harder to use vivid as a source for
encoding since the default resolution when you load vivid is 640x360.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/vicodec/vicodec-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index 408cd55d3580..daa5caa6adc6 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -42,7 +42,7 @@ MODULE_PARM_DESC(debug, " activates debug info");
 #define MAX_WIDTH		4096U
 #define MIN_WIDTH		640U
 #define MAX_HEIGHT		2160U
-#define MIN_HEIGHT		480U
+#define MIN_HEIGHT		360U
 
 #define dprintk(dev, fmt, arg...) \
 	v4l2_dbg(1, debug, &dev->v4l2_dev, "%s: " fmt, __func__, ## arg)
-- 
2.19.1




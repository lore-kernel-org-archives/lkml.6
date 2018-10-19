Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CD6ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCEA2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNGt6uWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCEA2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeJTAGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:06:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36762 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeJTAGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:06:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id l81-v6so16676227pfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 08:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=aRdDiHe4/sndMA8uYoTMNRqKpt8F2QZrlYWsAdyjnPw=;
        b=XNGt6uWCAyOLUMvpYTkfloT/6xkuzKQyw/aDh7yjFl3ipDGvPpFeKO0THNa8Hdiru3
         W+dII2EwgPTBKoSYShD48FHJISbAuJ7g5N2N1+/6vAHier+KBVCusRlcP1bAnmApMnYa
         8r+JVqzW4HQ781ADtXHiAYx29MtJbcB05aS4SBSKpSaEwNyPg6P+q2AQKm5wfd4g3CjZ
         gj7Rb9TXdKBgcuJbLw9dy3l6VcYss/tN81ugMkRNRzD5RHEb16uE3+9cCBMUX1vnXMI4
         V8JZHuYtVkwxM2gDdg9+WcgqiaCbroSpsDRlOmLHAeUampAeSL1dPIpDZDcqQJC0dGoK
         S04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=aRdDiHe4/sndMA8uYoTMNRqKpt8F2QZrlYWsAdyjnPw=;
        b=pgh3RB0L3X4VrowDpKoqHM5LVBZxQaRBOn08GCyk6R9d295tepinfDCzOdm3iBxwgj
         oH2ZwIRLDd49XOx3cUqDf71jnW2WwScr3UvLdqLfAL/y+mke3FL528RsQdcryt15S3cl
         scAOo0lzqaKKVJ+kkjYKYGhvtIOqOqx9xs5C5SJBGuooifz7fz5DuZYQiyqG7FHEHGzo
         PliPhtIqC5LynrPASZF/16XzMMVTVgmUN1x21DEyHlhJiEJrL4AhkHrCBxE9HLRDH/6M
         q7ZY9k0PFf8khYSUImpXxEiZmtzoSP9hGmrmezD1yEXXTLT1CUFVG84AkHz/pAudc6Ex
         5UsQ==
X-Gm-Message-State: ABuFfoiaSzmH3SreuHhLKx2ANul0HXzNwWRIWj3JL1kRlAOC1Y+J2f1s
        HDS6JnPbtFpZE5KFBLrhGwGWHITNy8M=
X-Google-Smtp-Source: ACcGV63iFoC8Ha6SiJihuB28h6XdpkYV/I/z0dDnxAatkoGdUKSxQAC7I9iHtpIv69yxmKOCV+uRFw==
X-Received: by 2002:a63:5d03:: with SMTP id r3-v6mr33616391pgb.445.1539964799648;
        Fri, 19 Oct 2018 08:59:59 -0700 (PDT)
Received: from sabyasachi ([45.116.191.241])
        by smtp.gmail.com with ESMTPSA id g35-v6sm861208pgl.45.2018.10.19.08.59.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Oct 2018 08:59:58 -0700 (PDT)
Message-ID: <5bc9ff7e.1c69fb81.105c2.1fef@mx.google.com>
X-Google-Original-Message-ID: <20181019155954.GA8124@sabyasachi.linux@gmail.com>
Date:   Fri, 19 Oct 2018 21:29:54 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     airlied@linux.ie, kraxel@redhat.com
Cc:     jrdr.linux@gmail.com, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] gpu/drm/virtio/virtgpu_vq.c: Use kmem_cache_zalloc
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced kmem_cache_alloc + memset with kmem_cache_zalloc
Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 020070d..e001b79 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -98,10 +98,9 @@ virtio_gpu_get_vbuf(struct virtio_gpu_device *vgdev,
 {
 	struct virtio_gpu_vbuffer *vbuf;
 
-	vbuf = kmem_cache_alloc(vgdev->vbufs, GFP_KERNEL);
+	vbuf = kmem_cache_zalloc(vgdev->vbufs, GFP_KERNEL);
 	if (!vbuf)
 		return ERR_PTR(-ENOMEM);
-	memset(vbuf, 0, VBUFFER_SIZE);
 
 	BUG_ON(size > MAX_INLINE_CMD_SIZE);
 	vbuf->buf = (void *)vbuf + sizeof(*vbuf);
-- 
2.7.4


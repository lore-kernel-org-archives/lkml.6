Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F2AC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD3120675
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvvwswM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfAMUkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 15:40:43 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38159 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfAMUkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 15:40:43 -0500
Received: by mail-qk1-f196.google.com with SMTP id a1so9503893qkc.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 12:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rptQAy+euE6r2OD3EenqkJPAbPdG8qp5CyfYNbnUeek=;
        b=EvvwswM2/qxiDGwZD8XRmMnhP97jeAyPUcodkJd50r6owPYB2rRCLkdDp2+jKoHaMT
         Bp8rZe3E99Q1ZHcN0IjeIYsA8pCbMoOSwXkrNi30azNL21AdrnMX4FHM6OHTMEffuBvm
         8rxXOkcSmaQNs3/nnn2upJo0teEn6z8mhHYFKR6Bj4Vf2o445jQxIy0b/8r+wYKou+OE
         eiQSCGpQSdnTs21710aw/iVE9TLuGIKdfMI3aUQVq6SxrPxu6MXRlXucxgIvBo234dlx
         YtOlWVnK4ycPRq8Y3xr+QPoX1SJ48YwYPwibtdb+JhaT4EyjGx25EjihbMXwp4ncOb/F
         mEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rptQAy+euE6r2OD3EenqkJPAbPdG8qp5CyfYNbnUeek=;
        b=pDevLihI1WtuoZa0wfqktEuPn9DZc8Qr82+s4T+J0vRM5O3hFmEARu3nZ0TsqtmR56
         Blh9cwGi8bkxF4Fq1bo+hd2k8LbPQbido06ZVLw5JCwUM/HhdofuhFqyIPqAIiJu/3Mz
         r8socFtw+qyRO96iNQ+oICHHbueXZxWnfdChulI6GkAeQ+kc1LQEyTKqLg8R42M88Xio
         rLcVLunGZtCT5FZ8QlE+B5KpNylu7ObUw31yFt0omEnC8SadLtPcHjHb4g8UFVOLcBXG
         KWlCLPz4FvcGezGeh/hDGc98SKxjf2hG2ERdSNx3rHJ0043Do1tq1HDSzYVAyQv7BU9Z
         47Sw==
X-Gm-Message-State: AJcUukfc6uK9MTpTNjBouTHcKi5uvyZnEzEBh7u0LWzyWRIuqe2oHN7K
        Axbq11Wzm41uaTlscOxm/4s=
X-Google-Smtp-Source: ALg8bN59lmZtlHLD7UgW5i+XzYSWdJIi8MorXNMqvrqqE7ZitFjb66/pJgh0HmXUk2o2w7VF8yVMVQ==
X-Received: by 2002:a37:8fc1:: with SMTP id r184mr20231915qkd.32.1547412042367;
        Sun, 13 Jan 2019 12:40:42 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id f143sm853670qka.73.2019.01.13.12.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 12:40:41 -0800 (PST)
Date:   Sun, 13 Jan 2019 18:40:38 -0200
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Haneen Mohammed <hamohammed.sa@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RESEND] MAINTAINERS: Add entry for VKMS
Message-ID: <20190113204038.bvdc6d5tyxjz6bzf@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers and reviewers for VKMS driver

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
Changes in v2:
  - Insert the section in alphabetical order

Resend:
  - Update patch due to changes in MAINTAINER file

 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 163c8f76a1c8..6e1cef2f21d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4925,6 +4925,16 @@ S:	Odd Fixes
 F:	drivers/gpu/drm/udl/
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 
+DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
+M:	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
+R:	Haneen Mohammed <hamohammed.sa@gmail.com>
+R:	Daniel Vetter <daniel@ffwll.ch>
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+S:	Maintained
+L:	dri-devel@lists.freedesktop.org
+F:	drivers/gpu/drm/vkms/
+F:	Documentation/gpu/vkms.rst
+
 DRM DRIVER FOR VMWARE VIRTUAL GPU
 M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
 M:	Thomas Hellstrom <thellstrom@vmware.com>
-- 
2.20.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753277AbeCYLAW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 07:00:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37150 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752526AbeCYLAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 07:00:07 -0400
X-Google-Smtp-Source: AG47ELtrKERvqXoBKXmBPlp8DQ3oLjKGs3J+8GocffaCTOUGdHD5koWGjNI8Rl16dA5v375PKsZHRQ==
From: "=?UTF-8?q?Christian=20K=C3=B6nig?="
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To: linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] drm/amdgpu: note that we can handle peer2peer DMA-buf
Date: Sun, 25 Mar 2018 12:59:58 +0200
Message-Id: <20180325110000.2238-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180325110000.2238-1-christian.koenig@amd.com>
References: <20180325110000.2238-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Importing should work out of the box.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
index fb43faf88eb0..2566268806c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
@@ -353,6 +353,7 @@ struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
 	if (IS_ERR(obj))
 		return obj;
 
+	attach_info.peer2peer = true;
 	attach_info.priv = obj;
 	attach = dma_buf_attach(&attach_info);
 	if (IS_ERR(attach)) {
-- 
2.14.1

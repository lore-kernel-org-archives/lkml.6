Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934876AbeCHCDk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:03:40 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:46805 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934551AbeCHCDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:03:38 -0500
X-Google-Smtp-Source: AG47ELv/sqR2Wxr81cWFy+sarBuahGyk0/6tgreysN4f8bd9bVt0yzz04PMxFUONY3JjA8Zpg2pEJw==
Date: Wed, 7 Mar 2018 23:03:34 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] drm/vgem: Remove '(' from the end of line
Message-ID: <58bfa1f547c18bf8d145b1a8500f3a5f6df3704e.1520474055.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520474055.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1520474055.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl check:

vgem_drv.c:91: CHECK: Lines should not end with a '('

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vgem/vgem_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
index 6e6084e3204a..4ddf3b8c3875 100644
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -87,10 +87,10 @@ static int vgem_gem_fault(struct vm_fault *vmf)
 	mutex_unlock(&obj->pages_lock);
 	if (ret) {
 		struct page *page;
+		struct address_space *mapping;
 
-		page = shmem_read_mapping_page(
-					file_inode(obj->base.filp)->i_mapping,
-					page_offset);
+		mapping = file_inode(obj->base.filp)->i_mapping;
+		page = shmem_read_mapping_page(mapping, page_offset);
 		if (!IS_ERR(page)) {
 			vmf->page = page;
 			ret = 0;
-- 
2.16.2

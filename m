Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeEEUHL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 16:07:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35103 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbeEEUHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 16:07:10 -0400
X-Google-Smtp-Source: AB8JxZoyLrBm0tHDGTzDU7T0EFOfYPkOWlMxCqurxSnjigsBzHtlT3YI2va74UHsV2AGqjMscOgmcw==
From: Mathieu Malaterre <malat@debian.org>
To: Christoph Lameter <cl@linux.com>
Cc: Mathieu Malaterre <malat@debian.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?slub:=20add=20=5F=5Fprintf=20verification=20to?= =?UTF-8?q?=20=E2=80=98slab=5Ferr=E2=80=99:?=
Date: Sat,  5 May 2018 22:07:05 +0200
Message-Id: <20180505200706.19986-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__printf is useful to verify format and arguments. Remove the following
warning (with W=1):

  mm/slub.c:721:2: warning: function might be possible candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 44aa7847324a..7d38cfb6a619 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -711,7 +711,7 @@ void object_err(struct kmem_cache *s, struct page *page,
 	print_trailer(s, page, object);
 }
 
-static void slab_err(struct kmem_cache *s, struct page *page,
+static __printf(3, 4) void slab_err(struct kmem_cache *s, struct page *page,
 			const char *fmt, ...)
 {
 	va_list args;
-- 
2.11.0

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425570AbeBOQJF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:09:05 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:39711 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424566AbeBOQJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:09:03 -0500
X-Google-Smtp-Source: AH8x226pSU0IJxJ4fsFRCaZ2tz1makS/xR7OT2MXkd4167RwPeyaGL4Vu1twOJ83yAbatk0kk6KNBQ==
From: Dennis Zhou <dennisszhou@gmail.com>
To: Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dennis Zhou <dennisszhou@gmail.com>
Subject: [PATCH 1/3] percpu: match chunk allocator declarations with definitions
Date: Thu, 15 Feb 2018 10:08:14 -0600
Message-Id: <3865d86559d8499f9bbb12f578bf9e6aa8f8882e.1518668149.git.dennisszhou@gmail.com>
X-Mailer: git-send-email 1.8.5.2 (Apple Git-48)
In-Reply-To: <cover.1518668149.git.dennisszhou@gmail.com>
References: <cover.1518668149.git.dennisszhou@gmail.com>
In-Reply-To: <cover.1518668149.git.dennisszhou@gmail.com>
References: <cover.1518668149.git.dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At some point the function declaration parameters got out of sync with
the function definitions in percpu-vm.c and percpu-km.c. This patch
makes them match again.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
---
 mm/percpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 50e7fdf..e1ea410 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1277,8 +1277,10 @@ static void pcpu_chunk_depopulated(struct pcpu_chunk *chunk,
  * pcpu_addr_to_page		- translate address to physical address
  * pcpu_verify_alloc_info	- check alloc_info is acceptable during init
  */
-static int pcpu_populate_chunk(struct pcpu_chunk *chunk, int off, int size);
-static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk, int off, int size);
+static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
+			       int page_start, int page_end);
+static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
+				  int page_start, int page_end);
 static struct pcpu_chunk *pcpu_create_chunk(void);
 static void pcpu_destroy_chunk(struct pcpu_chunk *chunk);
 static struct page *pcpu_addr_to_page(void *addr);
-- 
1.8.3.1

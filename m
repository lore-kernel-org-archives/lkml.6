Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752967AbeFEXky (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 19:40:54 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33828 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752962AbeFEXkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 19:40:52 -0400
X-Google-Smtp-Source: ADUXVKJUPoIPR1ir87eG9nNDJcPDXPNKkPm+PGjPlug7FaDiMJG4p03zW2V1pdsBhsF5JiDNwRFzHQ==
From: Daniel Rosenberg <drosen@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, linux-kernel@vger.kernel.org
Cc: Gustavo Padovan <gustavo@padovan.org>, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>,
        Divya Ponnusamy <pdivya@codeaurora.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH resend] drivers: dma-buf: Change %p to %pK in debug messages
Date: Tue,  5 Jun 2018 16:40:41 -0700
Message-Id: <20180605234041.246060-1-drosen@google.com>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The format specifier %p can leak kernel addresses
while not valuing the kptr_restrict system settings.
Use %pK instead of %p, which also evaluates whether
kptr_restrict is set.

Signed-off-by: Divya Ponnusamy <pdivya@codeaurora.org>
Signed-off-by: Daniel Rosenberg <drosen@google.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/dma-buf/sync_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/sync_debug.c b/drivers/dma-buf/sync_debug.c
index c4c8ecb24aa9..d8d340542a79 100644
--- a/drivers/dma-buf/sync_debug.c
+++ b/drivers/dma-buf/sync_debug.c
@@ -133,7 +133,7 @@ static void sync_print_sync_file(struct seq_file *s,
 	char buf[128];
 	int i;
 
-	seq_printf(s, "[%p] %s: %s\n", sync_file,
+	seq_printf(s, "[%pK] %s: %s\n", sync_file,
 		   sync_file_get_name(sync_file, buf, sizeof(buf)),
 		   sync_status_str(dma_fence_get_status(sync_file->fence)));
 
-- 
2.17.0.441.gb46fe60e1d-goog

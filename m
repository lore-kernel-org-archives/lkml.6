Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeEEUAr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 16:00:47 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41407 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbeEEUAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 16:00:44 -0400
X-Google-Smtp-Source: AB8JxZp/lJjvn8Y9a5fvnjWauoudLAq4kdnN5CYObV4Wju+RSIWqDXlpIQ0wsGvOSVjsfiJuFlQ0qQ==
From: Mathieu Malaterre <malat@debian.org>
To: Tejun Heo <tj@kernel.org>
Cc: Mathieu Malaterre <malat@debian.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: add __printf verification to __ata_ehi_pushv_desc
Date: Sat,  5 May 2018 22:00:37 +0200
Message-Id: <20180505200038.17840-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__printf is useful to verify format and arguments. Remove the following
warning (with W=1):

  drivers/ata/libata-eh.c:183:10: warning: function might be possible candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/ata/libata-eh.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index c016829a38fd..513b260bcff1 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -175,8 +175,8 @@ static void ata_eh_handle_port_resume(struct ata_port *ap)
 { }
 #endif /* CONFIG_PM */
 
-static void __ata_ehi_pushv_desc(struct ata_eh_info *ehi, const char *fmt,
-				 va_list args)
+static __printf(2, 0) void __ata_ehi_pushv_desc(struct ata_eh_info *ehi,
+				 const char *fmt, va_list args)
 {
 	ehi->desc_len += vscnprintf(ehi->desc + ehi->desc_len,
 				     ATA_EH_DESC_LEN - ehi->desc_len,
-- 
2.11.0

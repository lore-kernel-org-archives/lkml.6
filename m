Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163490AbeBOVdp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:33:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1162678AbeBOVdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:33:42 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: slp@redhat.com, bhe@redhat.com, mst@redhat.com, somlo@cmu.edu,
        xiaolong.ye@intel.com,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v15 07/11] fw_cfg: remove inline from fw_cfg_read_blob()
Date: Thu, 15 Feb 2018 22:33:08 +0100
Message-Id: <20180215213312.29234-8-marcandre.lureau@redhat.com>
In-Reply-To: <20180215213312.29234-1-marcandre.lureau@redhat.com>
References: <20180215213312.29234-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is not small and getting bigger.

Let the compiler decide instead. No profiling done, hopefully
unnecessary.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 drivers/firmware/qemu_fw_cfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 805372e8e50d..f6f90bef604c 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -59,8 +59,8 @@ static void fw_cfg_sel_endianness(u16 key)
 }
 
 /* read chunk of given fw_cfg blob (caller responsible for sanity-check) */
-static inline void fw_cfg_read_blob(u16 key,
-				    void *buf, loff_t pos, size_t count)
+static void fw_cfg_read_blob(u16 key,
+			void *buf, loff_t pos, size_t count)
 {
 	u32 glk = -1U;
 	acpi_status status;
-- 
2.16.1.73.g5832b7e9f2

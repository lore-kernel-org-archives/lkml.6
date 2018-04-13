Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeDMRnO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 13:43:14 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:51298 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbeDMRnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 13:43:10 -0400
X-Google-Smtp-Source: AIpwx493ipXFMAk1ggwcQ3qirGRwP04qEf1M7hnD1M/d6qwIdAR0Fp5zhBpynLCKA0HatUC+VmTf22rVseM8
MIME-Version: 1.0
Date: Fri, 13 Apr 2018 10:42:55 -0700
Message-Id: <20180413174257.139182-1-hansens@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH v3 1/3] Documentation/i2c: whitespace cleanup
From: Sam Hansen <hansens@google.com>
To: linux-i2c@vger.kernel.org, hansens@google.com, wsa@the-dreams.de,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Sam Hansen <hansens@google.com>, wsa@the-dreams.de, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This strips trailing whitespace in Documentation/i2c/dev-interface.

Signed-off-by: Sam Hansen <hansens@google.com>
---
No changes from v2.

 Documentation/i2c/dev-interface | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/i2c/dev-interface b/Documentation/i2c/dev-interface
index d04e6e4964ee..c8737d502791 100644
--- a/Documentation/i2c/dev-interface
+++ b/Documentation/i2c/dev-interface
@@ -9,8 +9,8 @@ i2c adapters present on your system at a given time. i2cdetect is part of
 the i2c-tools package.
 
 I2C device files are character device files with major device number 89
-and a minor device number corresponding to the number assigned as 
-explained above. They should be called "i2c-%d" (i2c-0, i2c-1, ..., 
+and a minor device number corresponding to the number assigned as
+explained above. They should be called "i2c-%d" (i2c-0, i2c-1, ...,
 i2c-10, ...). All 256 minor device numbers are reserved for i2c.
 
 
@@ -38,7 +38,7 @@ Next thing, open the device file, as follows:
   int file;
   int adapter_nr = 2; /* probably dynamically determined */
   char filename[20];
-  
+
   snprintf(filename, 19, "/dev/i2c-%d", adapter_nr);
   file = open(filename, O_RDWR);
   if (file < 0) {
@@ -72,7 +72,7 @@ the device supports them. Both are illustrated below.
     /* res contains the read word */
   }
 
-  /* Using I2C Write, equivalent of 
+  /* Using I2C Write, equivalent of
      i2c_smbus_write_word_data(file, reg, 0x6543) */
   buf[0] = reg;
   buf[1] = 0x43;
@@ -147,7 +147,7 @@ You can do plain i2c transactions by using read(2) and write(2) calls.
 You do not need to pass the address byte; instead, set it through
 ioctl I2C_SLAVE before you try to access the device.
 
-You can do SMBus level transactions (see documentation file smbus-protocol 
+You can do SMBus level transactions (see documentation file smbus-protocol
 for details) through the following functions:
   __s32 i2c_smbus_write_quick(int file, __u8 value);
   __s32 i2c_smbus_read_byte(int file);
@@ -158,7 +158,7 @@ for details) through the following functions:
   __s32 i2c_smbus_write_word_data(int file, __u8 command, __u16 value);
   __s32 i2c_smbus_process_call(int file, __u8 command, __u16 value);
   __s32 i2c_smbus_read_block_data(int file, __u8 command, __u8 *values);
-  __s32 i2c_smbus_write_block_data(int file, __u8 command, __u8 length, 
+  __s32 i2c_smbus_write_block_data(int file, __u8 command, __u8 length,
                                    __u8 *values);
 All these transactions return -1 on failure; you can read errno to see
 what happened. The 'write' transactions return 0 on success; the
-- 
2.17.0.484.g0c8726318c-goog

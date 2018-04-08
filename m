Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AIpwx48XLJnG49brgBSi1KqV/XnA++YFoJSj9UMknxv0hDEyBBH8d7AHD+gFZYk8dgTEpoYvbfdz
ARC-Seal: i=1; a=rsa-sha256; t=1523195271; cv=none;
        d=google.com; s=arc-20160816;
        b=vaOXqwllxlieYlaN4vTi8oZHa+TUqyDXbvjnR/ZLZmkL8fuKq4Ewgs60gtL4fFAEPP
         1XxAmuCnKvHewd1IDDoHLOyHgROCBOkfhH7J7woTWepl4Y/5f+q2B6AyhQgcualSmf02
         k3WhTIREPoyZllzd39TQ6ogYWHox6wDUzdhLMs/tf/UIfiUpg40Ygv/zsLijWrTQHFca
         S9qoEb8vmK5cXOkdA88F80G2Ab2wK9q8//Zy/0X76WYQpuneejJmQ6ISevp2vcZS8LuH
         wrwV6B31lOOmkjVliBOWtgZklyyV0EmroX2LbO2s5YAAnDn/Un7R0fq4b0J9VyW5q3d+
         zdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=YG1pE8YRF6iDpkI6r5e21EaGuLxJQt2ZZ7ozMfwc9JM=;
        b=FsoWUKT4icUPt6RZ7tdtLLOTTzmKNgwZxhyn0dosT0cCN/UTIvewbwJT+p8XrtoloR
         IBCEM63bt98VGmCjVCjb3dyAcMELQLNFDJvK4HWM+lAce/3pjyI4ISxWPwZxIZoc3bFR
         iiSfVBV4kv1SVb/eYIMjfyZMezXCfRZGo73Je6c5a2hCZHBKhGTKwsSQBBw4SfFutzBF
         0QBbh4IKL5qtm8FtqRFGMsMGjgGIho2nR77WTQBpjSt4ynGgevIRulLrpAiGcSUNPYVW
         ex59xaXULjy20y+lf7Pb2BNcBXbiQiZYBNbm6IjTPDQ3WyPcnQsS72U7HLGEu9/TO6HS
         jI/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Hans de Goede <hdegoede@redhat.com>
To: "Luis R . Rodriguez" <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: Fix firmware documentation for recent file renames
Date: Sun,  8 Apr 2018 15:47:49 +0200
Message-Id: <20180408134749.16871-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597186005083902615?=
X-GMAIL-MSGID: =?utf-8?q?1597186005083902615?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

firmware_class.c was split into several files under
drivers/base/firmware_loader. The new main.c has the functions which
/request_firmware.rst references.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/driver-api/firmware/request_firmware.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/firmware/request_firmware.rst b/Documentation/driver-api/firmware/request_firmware.rst
index 61eaa81c61f6..e9557d2eae0a 100644
--- a/Documentation/driver-api/firmware/request_firmware.rst
+++ b/Documentation/driver-api/firmware/request_firmware.rst
@@ -17,17 +17,17 @@ an error is returned.
 
 request_firmware
 ----------------
-.. kernel-doc:: drivers/base/firmware_class.c
+.. kernel-doc:: drivers/base/firmware_loader/main.c
    :functions: request_firmware
 
 request_firmware_direct
 -----------------------
-.. kernel-doc:: drivers/base/firmware_class.c
+.. kernel-doc:: drivers/base/firmware_loader/main.c
    :functions: request_firmware_direct
 
 request_firmware_into_buf
 -------------------------
-.. kernel-doc:: drivers/base/firmware_class.c
+.. kernel-doc:: drivers/base/firmware_loader/main.c
    :functions: request_firmware_into_buf
 
 Asynchronous firmware requests
@@ -41,7 +41,7 @@ in atomic contexts.
 
 request_firmware_nowait
 -----------------------
-.. kernel-doc:: drivers/base/firmware_class.c
+.. kernel-doc:: drivers/base/firmware_loader/main.c
    :functions: request_firmware_nowait
 
 Special optimizations on reboot
@@ -55,7 +55,7 @@ firmare to be loaded.
 
 firmware_request_cache()
 -----------------------
-.. kernel-doc:: drivers/base/firmware_class.c
+.. kernel-doc:: drivers/base/firmware_loader/main.c
    :functions: firmware_request_cache
 
 request firmware API expected driver use
-- 
2.17.0

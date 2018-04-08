Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AIpwx4+9K6Ft0Cxwb0TWwcDacZKMCwB4O3UZyYvVFcwtppIfNYZfKrv1GRuU8tjaGmvWKci0Yu+K
ARC-Seal: i=1; a=rsa-sha256; t=1523203584; cv=none;
        d=google.com; s=arc-20160816;
        b=GvXRy8djYGeD5DAIgLwHkbfWk6EHd0wH2DKHaIlXcmlnRHVTnmYDma2Vs+U5/+2jGt
         67idHulzSrKXZAntS5ScMfIK2HVeYiRbfgygr7tydzUu7nVWS09cNoeRFD3BIArFRayO
         71PNbYRYoTSEZ32HIEVakikNZ/OqPELG4CyyyMEAiofDy3rbpVi9c3KAF/c3YXrLgVji
         oKHyG8rg9bA255QcA7j/UmOmsPjeHwbHfReGOo6gWhhqOhdqxjb5rxVf/YMStf/w4Qk7
         E0sUQsffmAUtZnHZjbPRO/sT+pfkm2h0/4po/RDn4QEUnPkbNBfUhB5w9P6fnS3Tae8A
         cM2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=2MgJykez0BJm/yfLJ4cTjF4J41F5c/kTfIoqmRfh8ic=;
        b=Z7X9RjeJoUeurPs5hH88nQucZPq92UXp5llutTY4FxsTKG6zPtLO9v4uoogWmbXc1y
         EIdCg15qBXEXbfEg2MdO15FLkRf8UL/mdksZKKhqj/6pcJ5sH0Gev+9D1dvrThEliYnB
         i/rGW1moqeEbPi9yPMKUZJmudo2VFUthhMTUJfOjgnbzZnRoQVJeDmeY9pODybItsB+X
         rfJOI769h9wnHVeLlsaA+1H/4Hgo3j8eMxFa/MXNrwqpSFrUJhDoe3InfButFhomA6Mq
         gSOV+gXl1mam9AbM4Q4OyLX+W7HwVON8E+FF6Hope1Bt8c1loAqrIhTIYDlwrKMfiWnw
         2q5w==
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
Subject: [PATCH v2] firmware: Fix firmware documentation for recent file renames
Date: Sun,  8 Apr 2018 18:06:21 +0200
Message-Id: <20180408160621.13042-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597194722140266854?=
X-GMAIL-MSGID: =?utf-8?q?1597194722140266854?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

firmware_class.c was split into several files under
drivers/base/firmware_loader. The new main.c has the functions which
/request_firmware.rst references.

Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
Changes in v2:
-Fix the same issue in 2 more files
-Add Luis' Acked-by
---
 Documentation/driver-api/firmware/request_firmware.rst | 10 +++++-----
 Documentation/driver-api/infrastructure.rst            |  2 +-
 Documentation/power/suspend-and-cpuhotplug.txt         |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/driver-api/firmware/request_firmware.rst b/Documentation/driver-api/firmware/request_firmware.rst
index cf4516dfbf96..20f21ed427a5 100644
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
diff --git a/Documentation/driver-api/infrastructure.rst b/Documentation/driver-api/infrastructure.rst
index 6d9ff316b608..bee1b9a1702f 100644
--- a/Documentation/driver-api/infrastructure.rst
+++ b/Documentation/driver-api/infrastructure.rst
@@ -28,7 +28,7 @@ Device Drivers Base
 .. kernel-doc:: drivers/base/node.c
    :internal:
 
-.. kernel-doc:: drivers/base/firmware_class.c
+.. kernel-doc:: drivers/base/firmware_loader/main.c
    :export:
 
 .. kernel-doc:: drivers/base/transport_class.c
diff --git a/Documentation/power/suspend-and-cpuhotplug.txt b/Documentation/power/suspend-and-cpuhotplug.txt
index 31abd04b9572..6f55eb960a6d 100644
--- a/Documentation/power/suspend-and-cpuhotplug.txt
+++ b/Documentation/power/suspend-and-cpuhotplug.txt
@@ -168,7 +168,7 @@ update on the CPUs, as discussed below:
 
 [Please bear in mind that the kernel requests the microcode images from
 userspace, using the request_firmware() function defined in
-drivers/base/firmware_class.c]
+drivers/base/firmware_loader/main.c]
 
 
 a. When all the CPUs are identical:
-- 
2.17.0

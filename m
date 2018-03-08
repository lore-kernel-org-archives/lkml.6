Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeCHXmh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:42:37 -0500
Received: from mout.gmx.net ([212.227.17.22]:53369 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750857AbeCHXlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:41:21 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 7/8] Documentation: gpio: Move GPIO mapping documentation to driver-api
Date: Fri,  9 Mar 2018 00:40:23 +0100
Message-Id: <20180308234024.24145-8-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180308234024.24145-1-j.neuschaefer@gmx.net>
References: <20180308234024.24145-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:g5HOoQDx/EQAMWkFPzbgtabiRRktZTjSYpb/+ZQioZZRx/BL5op
 kOY8T1EFytYduUmtptpWEg7WgY8uoBZHT1NZlWhM6Vin+pi0hrZcvapAjRecWwxhVSu8wOO
 4V2NERKCaf5JD+PudNZNQzMENathP0caAqjOuEU4AKggW1+6v8exFbuw+a/mM5fUKWIrQS+
 pqQUL1XQ3n7b9xNTBGTxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DoEwwa8ZGxI=:XQ7KYgg7iaG68ZiGJkuDKh
 edskO2bxlwE2YUBXV9S8nq9C0y/IAGFH5PWXfQ9epC/XYzjGtY5xiA06VFJa9rK/1EMnFnDIA
 Xjnlnu0Zqw/2Q7d4SIE3G4EZUpkLAZ/pShwHr6Moxd7kY+EyGrft/HnmJuQPntdQjUEsmWmr4
 +n+4b49nROxycNBRiyV882VooQ0uJ3WXCYFg5aPgjFklRVAyFNk6XM5ctDrvxu4FGxriDHSlP
 eFmtpOXER3J47hwN/E+9J+QIU5ajgVJ680gAeFKsx/DLJGhRBXL2Dfg37tK1EWgyhGuERk+OR
 E3Yg54dizNPThgfoihqQC3mbjmlGUkQmfdb5wIuVd9G8eOzLBLEVCKo7awaFiV17dMFJWYgAd
 q6Ue6wGx9HEbXmWdrRLECjBW6m/p0hRlAF3RtondVuiVZ4r5BsB9XPSJqV7xUqtpUDuAophh/
 Ly6UGEIOOjXwyiXeAM2L6CWnEw/0vkz7YpNvhjWuU7VdG1xiqZRfF9h6avq4Ttjup0ITXChMG
 z5s5YR4yzDQmjqmNj3+LypwRFT51fMna2tMl6VNcqzaHFj+2DkntFtTS7pwXSn3efIhEkcBSY
 LyxnJkt2t4hwvO1iIPPTFbySK/L2B+XKWxD1euFpwIKwdktz4Id7nfcAT4cKUZNKZihU+Lmsc
 4S/7ijajTEFfEfTlpiflbi5QxkM6NuDFmvmpNVhwhAeuDmudQPnDIeupKu3RfZUGLZPuNaIxQ
 jcknongrTPp0KssUuupRQfrIrJjr1qUAz8/fuSde4BWh1qZlSVIXN1Ld4WM62uUVZkHCrnqzD
 ooI7kIC08KHRwUe7mCmHYk4cngcMVb2KQMf92TQyocvEHcnwQ0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move gpio/board.txt to driver-api/gpio/board.rst and make sure it builds
cleanly as ReST.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 .../{gpio/board.txt => driver-api/gpio/board.rst}  | 39 ++++++++++++----------
 Documentation/driver-api/gpio/index.rst            |  1 +
 Documentation/gpio/00-INDEX                        |  2 --
 3 files changed, 22 insertions(+), 20 deletions(-)
 rename Documentation/{gpio/board.txt => driver-api/gpio/board.rst} (88%)

diff --git a/Documentation/gpio/board.txt b/Documentation/driver-api/gpio/board.rst
similarity index 88%
rename from Documentation/gpio/board.txt
rename to Documentation/driver-api/gpio/board.rst
index 659bb19f5b3c..25d62b2e9fd0 100644
--- a/Documentation/gpio/board.txt
+++ b/Documentation/driver-api/gpio/board.rst
@@ -1,3 +1,4 @@
+=============
 GPIO Mappings
 =============
 
@@ -23,7 +24,7 @@ device tree bindings for your controller.
 
 GPIOs mappings are defined in the consumer device's node, in a property named
 <function>-gpios, where <function> is the function the driver will request
-through gpiod_get(). For example:
+through gpiod_get(). For example::
 
 	foo_device {
 		compatible = "acme,foo";
@@ -40,7 +41,7 @@ it but are only supported for compatibility reasons and should not be used for
 newer bindings since it has been deprecated.
 
 This property will make GPIOs 15, 16 and 17 available to the driver under the
-"led" function, and GPIO 1 as the "power" GPIO:
+"led" function, and GPIO 1 as the "power" GPIO::
 
 	struct gpio_desc *red, *green, *blue, *power;
 
@@ -60,13 +61,13 @@ looked up by the gpiod functions internally) used in the device tree. With above
 
 Internally, the GPIO subsystem prefixes the GPIO suffix ("gpios" or "gpio")
 with the string passed in con_id to get the resulting string
-(snprintf(... "%s-%s", con_id, gpio_suffixes[]).
+(``snprintf(... "%s-%s", con_id, gpio_suffixes[]``).
 
 ACPI
 ----
 ACPI also supports function names for GPIOs in a similar fashion to DT.
 The above DT example can be converted to an equivalent ACPI description
-with the help of _DSD (Device Specific Data), introduced in ACPI 5.1:
+with the help of _DSD (Device Specific Data), introduced in ACPI 5.1::
 
 	Device (FOO) {
 		Name (_CRS, ResourceTemplate () {
@@ -105,12 +106,12 @@ Documentation/acpi/gpio-properties.txt.
 Platform Data
 -------------
 Finally, GPIOs can be bound to devices and functions using platform data. Board
-files that desire to do so need to include the following header:
+files that desire to do so need to include the following header::
 
 	#include <linux/gpio/machine.h>
 
 GPIOs are mapped by the means of tables of lookups, containing instances of the
-gpiod_lookup structure. Two macros are defined to help declaring such mappings:
+gpiod_lookup structure. Two macros are defined to help declaring such mappings::
 
 	GPIO_LOOKUP(chip_label, chip_hwnum, con_id, flags)
 	GPIO_LOOKUP_IDX(chip_label, chip_hwnum, con_id, idx, flags)
@@ -141,22 +142,24 @@ end. The 'dev_id' field of the table is the identifier of the device that will
 make use of these GPIOs. It can be NULL, in which case it will be matched for
 calls to gpiod_get() with a NULL device.
 
-struct gpiod_lookup_table gpios_table = {
-	.dev_id = "foo.0",
-	.table = {
-		GPIO_LOOKUP_IDX("gpio.0", 15, "led", 0, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("gpio.0", 16, "led", 1, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("gpio.0", 17, "led", 2, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("gpio.0", 1, "power", GPIO_ACTIVE_LOW),
-		{ },
-	},
-};
+.. code-block:: c
+
+        struct gpiod_lookup_table gpios_table = {
+                .dev_id = "foo.0",
+                .table = {
+                        GPIO_LOOKUP_IDX("gpio.0", 15, "led", 0, GPIO_ACTIVE_HIGH),
+                        GPIO_LOOKUP_IDX("gpio.0", 16, "led", 1, GPIO_ACTIVE_HIGH),
+                        GPIO_LOOKUP_IDX("gpio.0", 17, "led", 2, GPIO_ACTIVE_HIGH),
+                        GPIO_LOOKUP("gpio.0", 1, "power", GPIO_ACTIVE_LOW),
+                        { },
+                },
+        };
 
-And the table can be added by the board code as follows:
+And the table can be added by the board code as follows::
 
 	gpiod_add_lookup_table(&gpios_table);
 
-The driver controlling "foo.0" will then be able to obtain its GPIOs as follows:
+The driver controlling "foo.0" will then be able to obtain its GPIOs as follows::
 
 	struct gpio_desc *red, *green, *blue, *power;
 
diff --git a/Documentation/driver-api/gpio/index.rst b/Documentation/driver-api/gpio/index.rst
index 6ba9e0043310..2b73ea5a1fbb 100644
--- a/Documentation/driver-api/gpio/index.rst
+++ b/Documentation/driver-api/gpio/index.rst
@@ -10,6 +10,7 @@ Contents:
    intro
    driver
    consumer
+   board
    legacy
 
 Core
diff --git a/Documentation/gpio/00-INDEX b/Documentation/gpio/00-INDEX
index f960fc00a3ef..650cb0696211 100644
--- a/Documentation/gpio/00-INDEX
+++ b/Documentation/gpio/00-INDEX
@@ -3,7 +3,5 @@
 drivers-on-gpio.txt:
 	- Drivers in other subsystems that can use GPIO to provide more
 	  complex functionality.
-board.txt
-	- How to assign GPIOs to a consumer device and a function
 sysfs.txt
 	- Information about the GPIO sysfs interface
-- 
2.16.1

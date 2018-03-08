Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbeCHXn2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:43:28 -0500
Received: from mout.gmx.net ([212.227.17.20]:60081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750867AbeCHXlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:41:18 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 4/8] Documentation: gpio: Move driver documentation to driver-api
Date: Fri,  9 Mar 2018 00:40:20 +0100
Message-Id: <20180308234024.24145-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180308234024.24145-1-j.neuschaefer@gmx.net>
References: <20180308234024.24145-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:8rS+WcQCZR8DVJdh7hacJ1BYYS9o7/tecm487E7BsyOHpYQyxz4
 TPwTzPkF2FYDo1wfTjI5VsXoKoftxKSXpZxWjyKzHU93OhQ8fvr2e65Sh/t3KS3pUSJlIIY
 Wf9hH0/FhnCtH5HfDudF46ww7GoEHGB2HJFaV+Fy076GT/Wxq9GbKsjBeDIIBkiPKSk9c0w
 +OstKlOtzsleWnSt0To6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p6as9tltgjs=:3Z38SPzqAZ3juRNFs98d7a
 HksJUUhbiyVFhHtYgNPpp4wNGC2a9ZXTBy5uhRZX9g1kb6C+3Wr2gGVLzr6hFrVfFq0ElBPPp
 PXw1XanPviD6dw33obzJO6QQmcTuCgyI7ZZx59hI37DCBZG6E6znTfStWg/mbZgozdbWdOjDp
 3jzYwqaLRnYSA7hTQ2dUBS61o51RYli/6Gp1I/Ee1HUcJPidIuoLMBDtwRH15yRAiMoRQ8q3u
 eQghNsa10IInkjmNbkvl7YdcABOOP+kuxlOjZk0EoqwmSjrXhBg6Q/UVWILnNS9CnboagWN0D
 K0bUkgjIjqpfpw13M0FAQLipJSxSkJuMB0geQm88SyCe3fogZx2ODju/dpT19UiIwBv47O53D
 yA9p3jAKeezRCMlUtH+SFiSJnq35XKThxmhkNSJ6KMBIjnr1GEXuYRPCGp6msgDOQG5xfaRya
 jdwMDdvsWdyq1my4L2OcTm4pz6Ad9pAlaZNREW7B45QFQrcja28F00TNY3DW3VWyXi+YZfdqc
 e7uxWRPFpGLpK/k+DeIU/UZfHroA4kdYxwsbGjLc/IBsT+hSbIm5ZwimxTwbGOQp4VtaAV/2v
 nTH6I7y9KcNqzUE7BYGjsWQa7UTAM9XFyCpS7UNHhRW6+oUSikoRvF1dAfg5CfsE9lgESepmx
 gbikChIyUwUkqA4iK0yRumrGTK8tVyhWrU5YSs3dP/6YLu64e+8qpsyTSqKV0y3bkTk492Dqp
 L+KIraqBPU2uN8s0E/XuseAGFvGblPCuxBt9EEDLvVps0Kz8+GZ3+XmtkxW9IiZc9x6moefT+
 nUDNst1yDoXGjeMNxMO+DpfvPGhoftQDoZiMoJrM9W6K6Pb8ro=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move gpio/driver.txt to driver-api/gpio/driver.rst and make sure it
builds cleanly as ReST.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 .../driver.txt => driver-api/gpio/driver.rst}      | 80 +++++++++++-----------
 Documentation/driver-api/gpio/index.rst            |  1 +
 Documentation/gpio/00-INDEX                        |  2 -
 3 files changed, 42 insertions(+), 41 deletions(-)
 rename Documentation/{gpio/driver.txt => driver-api/gpio/driver.rst} (93%)

diff --git a/Documentation/gpio/driver.txt b/Documentation/driver-api/gpio/driver.rst
similarity index 93%
rename from Documentation/gpio/driver.txt
rename to Documentation/driver-api/gpio/driver.rst
index 3392a0fd4c23..505ee906d7d9 100644
--- a/Documentation/gpio/driver.txt
+++ b/Documentation/driver-api/gpio/driver.rst
@@ -1,3 +1,4 @@
+================================
 GPIO Descriptor Driver Interface
 ================================
 
@@ -53,9 +54,9 @@ common to each controller of that type:
 
 The code implementing a gpio_chip should support multiple instances of the
 controller, possibly using the driver model. That code will configure each
-gpio_chip and issue gpiochip_add[_data]() or devm_gpiochip_add_data().
-Removing a GPIO controller should be rare; use [devm_]gpiochip_remove() when
-it is unavoidable.
+gpio_chip and issue ``gpiochip_add[_data]()`` or ``devm_gpiochip_add_data()``.
+Removing a GPIO controller should be rare; use ``[devm_]gpiochip_remove()``
+when it is unavoidable.
 
 Often a gpio_chip is part of an instance-specific structure with states not
 exposed by the GPIO interfaces, such as addressing, power management, and more.
@@ -115,7 +116,7 @@ GPIOs with open drain/source support
 
 Open drain (CMOS) or open collector (TTL) means the line is not actively driven
 high: instead you provide the drain/collector as output, so when the transistor
-is not open, it will present a high-impedance (tristate) to the external rail.
+is not open, it will present a high-impedance (tristate) to the external rail::
 
 
    CMOS CONFIGURATION      TTL CONFIGURATION
@@ -148,19 +149,19 @@ level-shift to the higher VDD.
 Integrated electronics often have an output driver stage in the form of a CMOS
 "totem-pole" with one N-MOS and one P-MOS transistor where one of them drives
 the line high and one of them drives the line low. This is called a push-pull
-output. The "totem-pole" looks like so:
-
-                 VDD
-                  |
-        OD    ||--+
-     +--/ ---o||     P-MOS-FET
-     |        ||--+
-IN --+            +----- out
-     |        ||--+
-     +--/ ----||     N-MOS-FET
-        OS    ||--+
-                  |
-                 GND
+output. The "totem-pole" looks like so::
+
+                     VDD
+                      |
+            OD    ||--+
+         +--/ ---o||     P-MOS-FET
+         |        ||--+
+    IN --+            +----- out
+         |        ||--+
+         +--/ ----||     N-MOS-FET
+            OS    ||--+
+                      |
+                     GND
 
 The desired output signal (e.g. coming directly from some GPIO output register)
 arrives at IN. The switches named "OD" and "OS" are normally closed, creating
@@ -219,8 +220,9 @@ systems simultaneously: gpio and irq.
 
 RT_FULL: a realtime compliant GPIO driver should not use spinlock_t or any
 sleepable APIs (like PM runtime) as part of its irq_chip implementation.
-- spinlock_t should be replaced with raw_spinlock_t [1].
-- If sleepable APIs have to be used, these can be done from the .irq_bus_lock()
+
+* spinlock_t should be replaced with raw_spinlock_t [1].
+* If sleepable APIs have to be used, these can be done from the .irq_bus_lock()
   and .irq_bus_unlock() callbacks, as these are the only slowpath callbacks
   on an irqchip. Create the callbacks if needed [2].
 
@@ -232,12 +234,12 @@ GPIO irqchips usually fall in one of two categories:
   system interrupt controller. This means that the GPIO irqchip handler will
   be called immediately from the parent irqchip, while holding the IRQs
   disabled. The GPIO irqchip will then end up calling something like this
-  sequence in its interrupt handler:
+  sequence in its interrupt handler::
 
-  static irqreturn_t foo_gpio_irq(int irq, void *data)
-      chained_irq_enter(...);
-      generic_handle_irq(...);
-      chained_irq_exit(...);
+    static irqreturn_t foo_gpio_irq(int irq, void *data)
+        chained_irq_enter(...);
+        generic_handle_irq(...);
+        chained_irq_exit(...);
 
   Chained GPIO irqchips typically can NOT set the .can_sleep flag on
   struct gpio_chip, as everything happens directly in the callbacks: no
@@ -252,7 +254,7 @@ GPIO irqchips usually fall in one of two categories:
   (for example, see [3]).
   Know W/A: The generic_handle_irq() is expected to be called with IRQ disabled,
   so the IRQ core will complain if it is called from an IRQ handler which is
-  forced to a thread. The "fake?" raw lock can be used to W/A this problem:
+  forced to a thread. The "fake?" raw lock can be used to W/A this problem::
 
 	raw_spinlock_t wa_lock;
 	static irqreturn_t omap_gpio_irq_handler(int irq, void *gpiobank)
@@ -265,11 +267,11 @@ GPIO irqchips usually fall in one of two categories:
   but chained IRQ handlers are not used. Instead GPIO IRQs dispatching is
   performed by generic IRQ handler which is configured using request_irq().
   The GPIO irqchip will then end up calling something like this sequence in
-  its interrupt handler:
+  its interrupt handler::
 
-  static irqreturn_t gpio_rcar_irq_handler(int irq, void *dev_id)
-	for each detected GPIO IRQ
-		generic_handle_irq(...);
+    static irqreturn_t gpio_rcar_irq_handler(int irq, void *dev_id)
+        for each detected GPIO IRQ
+            generic_handle_irq(...);
 
   RT_FULL: Such kind of handlers will be forced threaded on -RT, as result IRQ
   core will complain that generic_handle_irq() is called with IRQ enabled and
@@ -282,11 +284,11 @@ GPIO irqchips usually fall in one of two categories:
   in a quick IRQ handler with IRQs disabled. Instead they need to spawn a
   thread and then mask the parent IRQ line until the interrupt is handled
   by the driver. The hallmark of this driver is to call something like
-  this in its interrupt handler:
+  this in its interrupt handler::
 
-  static irqreturn_t foo_gpio_irq(int irq, void *data)
-      ...
-      handle_nested_irq(irq);
+    static irqreturn_t foo_gpio_irq(int irq, void *data)
+        ...
+        handle_nested_irq(irq);
 
   The hallmark of threaded GPIO irqchips is that they set the .can_sleep
   flag on struct gpio_chip to true, indicating that this chip may sleep
@@ -359,12 +361,12 @@ below exists.
 Locking IRQ usage
 -----------------
 Input GPIOs can be used as IRQ signals. When this happens, a driver is requested
-to mark the GPIO as being used as an IRQ:
+to mark the GPIO as being used as an IRQ::
 
 	int gpiochip_lock_as_irq(struct gpio_chip *chip, unsigned int offset)
 
 This will prevent the use of non-irq related GPIO APIs until the GPIO IRQ lock
-is released:
+is released::
 
 	void gpiochip_unlock_as_irq(struct gpio_chip *chip, unsigned int offset)
 
@@ -408,7 +410,7 @@ Sometimes it is useful to allow a GPIO chip driver to request its own GPIO
 descriptors through the gpiolib API. Using gpio_request() for this purpose
 does not help since it pins the module to the kernel forever (it calls
 try_module_get()). A GPIO driver can use the following functions instead
-to request and free descriptors without being pinned to the kernel forever.
+to request and free descriptors without being pinned to the kernel forever::
 
 	struct gpio_desc *gpiochip_request_own_desc(struct gpio_desc *desc,
 						    const char *label)
@@ -422,6 +424,6 @@ These functions must be used with care since they do not affect module use
 count. Do not use the functions to request gpio descriptors not owned by the
 calling driver.
 
-[1] http://www.spinics.net/lists/linux-omap/msg120425.html
-[2] https://lkml.org/lkml/2015/9/25/494
-[3] https://lkml.org/lkml/2015/9/25/495
+* [1] http://www.spinics.net/lists/linux-omap/msg120425.html
+* [2] https://lkml.org/lkml/2015/9/25/494
+* [3] https://lkml.org/lkml/2015/9/25/495
diff --git a/Documentation/driver-api/gpio/index.rst b/Documentation/driver-api/gpio/index.rst
index db47d845f473..e1fbc5408cf6 100644
--- a/Documentation/driver-api/gpio/index.rst
+++ b/Documentation/driver-api/gpio/index.rst
@@ -8,6 +8,7 @@ Contents:
    :maxdepth: 2
 
    intro
+   driver
 
 Core
 ====
diff --git a/Documentation/gpio/00-INDEX b/Documentation/gpio/00-INDEX
index 52fe0fa6c964..06c25fb7604c 100644
--- a/Documentation/gpio/00-INDEX
+++ b/Documentation/gpio/00-INDEX
@@ -2,8 +2,6 @@
 	- This file
 consumer.txt
 	- How to obtain and use GPIOs in a driver
-driver.txt
-	- How to write a GPIO driver
 drivers-on-gpio.txt:
 	- Drivers in other subsystems that can use GPIO to provide more
 	  complex functionality.
-- 
2.16.1

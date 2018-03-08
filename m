Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeCHXmi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:42:38 -0500
Received: from mout.gmx.net ([212.227.15.19]:42459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751337AbeCHXlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:41:20 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 6/8] Documentation: gpio: Move gpiod_* consumer documentation to driver-api
Date: Fri,  9 Mar 2018 00:40:22 +0100
Message-Id: <20180308234024.24145-7-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180308234024.24145-1-j.neuschaefer@gmx.net>
References: <20180308234024.24145-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:tXk7tqpVYGyJKpTRhKyucOvCagGbixppHtFmzQuCch0/GgiWPNO
 3361QGvbXVZMDMpkq9IYHrI38cisnP3zFSfNOx8tmvuIbMl02TQDkkPAwHfwYioR374xjim
 sJnt/SOTR+NU/PtRSyh7wL4k+QFdK3Y3nWCyGlUo0Qh+2EohPjUZGqxkMLRL4szD21ThtBw
 GoSzrKn7dIizFjMv/FAPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wqwdiyxYFWs=:ronfFKlemQ5Qvx+EDycfPJ
 ieYctQxBoqQ73jD6OzSSuxpWc5pBLD9U2MSSI3Z95k2fLJR/SeKM3mKZHiRejAKyQtHyk2uwb
 hsl8AEtFDKS2AM8zncpo3VI3BqVB5iYuUoT0SqWe2jOWcj19rhAwPe8ZU1Isc3KcZ+5EHnsUh
 rWM/XAbA3gMvj1/4pyRAx66oPTkLK7zhIyt5i4p8bmsCK34OqfIRq2a37b/tK6+o0EV+7wKl0
 wXW8FsuNQrGN4JVVq0wfVfODQjIZjTT+cVWYWC5cowq9iT0m49NJwGMVEqeCDXkYFPo726tFQ
 LbfJH6iqpIjPKchIaTfzYGV2hDIkpHYBNbdl0wtBsbo46Dq9Pk+3+5TUBAFXJnusL0dC3QesQ
 U8KeKfgGFX3N9q2GOJmuojeOwG8nQC7H7ucTN/BDgu+481wtBxjcBwO1gw4xTWE+5s/XEkjAY
 TwEKQLQZDSn7yUnMSfRx5/Q/YMvZ2rGK6bMWHgnoOUlfkZnn4GLTDrhbLknAtPTMDY5GldQfr
 MY7LFnXWtpPmhAgjYqBqx/yLOKc4kJYBRR71Nic0SmUJaofZG/sMGN7ycr4MkGIW5fLjw6PG1
 lMXDpuCEc02IvtjaCCoOoOtm/Rc6ggUlxIZtmHSfTHAPIWyG/56H3fSGrF7iTy1cLjmSzL1dV
 97o5K/HFw1AJOZsPBrnpsR/iNgG+GaxUUpwVk7OO/IOHqWfmb7Rjodpoy4OkFRXycypQBgrDD
 Qlx0q1g+ZqJblgZTfpiQzja0SEJNxDfGEMuy7IyJ6CBndwrzAIXzBh+OVBoc3h6kmG+hwE7oV
 kwYQRLVr4VaFGmvACSZd2uNOTARnYcJ8MtvDNoP28HaL86sBGA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move gpio/consumer.txt to driver-api/gpio/consumer.rst and make sure it
builds cleanly as ReST.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 .../consumer.txt => driver-api/gpio/consumer.rst}  | 85 +++++++++++-----------
 Documentation/driver-api/gpio/index.rst            |  1 +
 Documentation/gpio/00-INDEX                        |  2 -
 3 files changed, 44 insertions(+), 44 deletions(-)
 rename Documentation/{gpio/consumer.txt => driver-api/gpio/consumer.rst} (89%)

diff --git a/Documentation/gpio/consumer.txt b/Documentation/driver-api/gpio/consumer.rst
similarity index 89%
rename from Documentation/gpio/consumer.txt
rename to Documentation/driver-api/gpio/consumer.rst
index d53e5b5cfc9c..c71a50d85b50 100644
--- a/Documentation/gpio/consumer.txt
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -1,3 +1,4 @@
+==================================
 GPIO Descriptor Consumer Interface
 ==================================
 
@@ -30,10 +31,10 @@ warnings. These stubs are used for two use cases:
   be met with console warnings that may be perceived as intimidating.
 
 All the functions that work with the descriptor-based GPIO interface are
-prefixed with gpiod_. The gpio_ prefix is used for the legacy interface. No
-other function in the kernel should use these prefixes. The use of the legacy
-functions is strongly discouraged, new code should use <linux/gpio/consumer.h>
-and descriptors exclusively.
+prefixed with ``gpiod_``. The ``gpio_`` prefix is used for the legacy
+interface. No other function in the kernel should use these prefixes. The use
+of the legacy functions is strongly discouraged, new code should use
+<linux/gpio/consumer.h> and descriptors exclusively.
 
 
 Obtaining and Disposing GPIOs
@@ -43,13 +44,13 @@ With the descriptor-based interface, GPIOs are identified with an opaque,
 non-forgeable handler that must be obtained through a call to one of the
 gpiod_get() functions. Like many other kernel subsystems, gpiod_get() takes the
 device that will use the GPIO and the function the requested GPIO is supposed to
-fulfill:
+fulfill::
 
 	struct gpio_desc *gpiod_get(struct device *dev, const char *con_id,
 				    enum gpiod_flags flags)
 
 If a function is implemented by using several GPIOs together (e.g. a simple LED
-device that displays digits), an additional index argument can be specified:
+device that displays digits), an additional index argument can be specified::
 
 	struct gpio_desc *gpiod_get_index(struct device *dev,
 					  const char *con_id, unsigned int idx,
@@ -84,7 +85,7 @@ occurred while trying to acquire it. This is useful to discriminate between mere
 errors and an absence of GPIO for optional GPIO parameters. For the common
 pattern where a GPIO is optional, the gpiod_get_optional() and
 gpiod_get_index_optional() functions can be used. These functions return NULL
-instead of -ENOENT if no GPIO has been assigned to the requested function:
+instead of -ENOENT if no GPIO has been assigned to the requested function::
 
 	struct gpio_desc *gpiod_get_optional(struct device *dev,
 					     const char *con_id,
@@ -101,14 +102,14 @@ This is helpful to driver authors, since they do not need to special case
 -ENOSYS return codes.  System integrators should however be careful to enable
 gpiolib on systems that need it.
 
-For a function using multiple GPIOs all of those can be obtained with one call:
+For a function using multiple GPIOs all of those can be obtained with one call::
 
 	struct gpio_descs *gpiod_get_array(struct device *dev,
 					   const char *con_id,
 					   enum gpiod_flags flags)
 
 This function returns a struct gpio_descs which contains an array of
-descriptors:
+descriptors::
 
 	struct gpio_descs {
 		unsigned int ndescs;
@@ -116,13 +117,13 @@ descriptors:
 	}
 
 The following function returns NULL instead of -ENOENT if no GPIOs have been
-assigned to the requested function:
+assigned to the requested function::
 
 	struct gpio_descs *gpiod_get_array_optional(struct device *dev,
 						    const char *con_id,
 						    enum gpiod_flags flags)
 
-Device-managed variants of these functions are also defined:
+Device-managed variants of these functions are also defined::
 
 	struct gpio_desc *devm_gpiod_get(struct device *dev, const char *con_id,
 					 enum gpiod_flags flags)
@@ -149,11 +150,11 @@ Device-managed variants of these functions are also defined:
 							 const char *con_id,
 							 enum gpiod_flags flags)
 
-A GPIO descriptor can be disposed of using the gpiod_put() function:
+A GPIO descriptor can be disposed of using the gpiod_put() function::
 
 	void gpiod_put(struct gpio_desc *desc)
 
-For an array of GPIOs this function can be used:
+For an array of GPIOs this function can be used::
 
 	void gpiod_put_array(struct gpio_descs *descs)
 
@@ -161,7 +162,7 @@ It is strictly forbidden to use a descriptor after calling these functions.
 It is also not allowed to individually release descriptors (using gpiod_put())
 from an array acquired with gpiod_get_array().
 
-The device-managed variants are, unsurprisingly:
+The device-managed variants are, unsurprisingly::
 
 	void devm_gpiod_put(struct device *dev, struct gpio_desc *desc)
 
@@ -175,7 +176,7 @@ Setting Direction
 -----------------
 The first thing a driver must do with a GPIO is setting its direction. If no
 direction-setting flags have been given to gpiod_get*(), this is done by
-invoking one of the gpiod_direction_*() functions:
+invoking one of the gpiod_direction_*() functions::
 
 	int gpiod_direction_input(struct gpio_desc *desc)
 	int gpiod_direction_output(struct gpio_desc *desc, int value)
@@ -189,7 +190,7 @@ of early board setup.
 For output GPIOs, the value provided becomes the initial output value. This
 helps avoid signal glitching during system startup.
 
-A driver can also query the current direction of a GPIO:
+A driver can also query the current direction of a GPIO::
 
 	int gpiod_get_direction(const struct gpio_desc *desc)
 
@@ -206,7 +207,7 @@ Most GPIO controllers can be accessed with memory read/write instructions. Those
 don't need to sleep, and can safely be done from inside hard (non-threaded) IRQ
 handlers and similar contexts.
 
-Use the following calls to access GPIOs from an atomic context:
+Use the following calls to access GPIOs from an atomic context::
 
 	int gpiod_get_value(const struct gpio_desc *desc);
 	void gpiod_set_value(struct gpio_desc *desc, int value);
@@ -231,11 +232,11 @@ head of a queue to transmit a command and get its response. This requires
 sleeping, which can't be done from inside IRQ handlers.
 
 Platforms that support this type of GPIO distinguish them from other GPIOs by
-returning nonzero from this call:
+returning nonzero from this call::
 
 	int gpiod_cansleep(const struct gpio_desc *desc)
 
-To access such GPIOs, a different set of accessors is defined:
+To access such GPIOs, a different set of accessors is defined::
 
 	int gpiod_get_value_cansleep(const struct gpio_desc *desc)
 	void gpiod_set_value_cansleep(struct gpio_desc *desc, int value)
@@ -271,23 +272,23 @@ As an example, if the active low property for a dedicated GPIO is set, and the
 gpiod_set_(array)_value_xxx() passes "asserted" ("1"), the physical line level
 will be driven low.
 
-To summarize:
-
-Function (example)                 line property          physical line
-gpiod_set_raw_value(desc, 0);      don't care             low
-gpiod_set_raw_value(desc, 1);      don't care             high
-gpiod_set_value(desc, 0);          default (active high)  low
-gpiod_set_value(desc, 1);          default (active high)  high
-gpiod_set_value(desc, 0);          active low             high
-gpiod_set_value(desc, 1);          active low             low
-gpiod_set_value(desc, 0);          default (active high)  low
-gpiod_set_value(desc, 1);          default (active high)  high
-gpiod_set_value(desc, 0);          open drain             low
-gpiod_set_value(desc, 1);          open drain             high impedance
-gpiod_set_value(desc, 0);          open source            high impedance
-gpiod_set_value(desc, 1);          open source            high
-
-It is possible to override these semantics using the *set_raw/'get_raw functions
+To summarize::
+
+  Function (example)                 line property          physical line
+  gpiod_set_raw_value(desc, 0);      don't care             low
+  gpiod_set_raw_value(desc, 1);      don't care             high
+  gpiod_set_value(desc, 0);          default (active high)  low
+  gpiod_set_value(desc, 1);          default (active high)  high
+  gpiod_set_value(desc, 0);          active low             high
+  gpiod_set_value(desc, 1);          active low             low
+  gpiod_set_value(desc, 0);          default (active high)  low
+  gpiod_set_value(desc, 1);          default (active high)  high
+  gpiod_set_value(desc, 0);          open drain             low
+  gpiod_set_value(desc, 1);          open drain             high impedance
+  gpiod_set_value(desc, 0);          open source            high impedance
+  gpiod_set_value(desc, 1);          open source            high
+
+It is possible to override these semantics using the set_raw/get_raw functions
 but it should be avoided as much as possible, especially by system-agnostic drivers
 which should not need to care about the actual physical line level and worry about
 the logical value instead.
@@ -300,7 +301,7 @@ their device will actually receive, no matter what lies between it and the GPIO
 line.
 
 The following set of calls ignore the active-low or open drain property of a GPIO and
-work on the raw line value:
+work on the raw line value::
 
 	int gpiod_get_raw_value(const struct gpio_desc *desc)
 	void gpiod_set_raw_value(struct gpio_desc *desc, int value)
@@ -308,7 +309,7 @@ work on the raw line value:
 	void gpiod_set_raw_value_cansleep(struct gpio_desc *desc, int value)
 	int gpiod_direction_output_raw(struct gpio_desc *desc, int value)
 
-The active low state of a GPIO can also be queried using the following call:
+The active low state of a GPIO can also be queried using the following call::
 
 	int gpiod_is_active_low(const struct gpio_desc *desc)
 
@@ -318,7 +319,7 @@ should not have to care about the physical line level or open drain semantics.
 
 Access multiple GPIOs with a single function call
 -------------------------------------------------
-The following functions get or set the values of an array of GPIOs:
+The following functions get or set the values of an array of GPIOs::
 
 	int gpiod_get_array_value(unsigned int array_size,
 				  struct gpio_desc **desc_array,
@@ -361,7 +362,7 @@ The functions take three arguments:
 The descriptor array can be obtained using the gpiod_get_array() function
 or one of its variants. If the group of descriptors returned by that function
 matches the desired group of GPIOs, those GPIOs can be accessed by simply using
-the struct gpio_descs returned by gpiod_get_array():
+the struct gpio_descs returned by gpiod_get_array()::
 
 	struct gpio_descs *my_gpio_descs = gpiod_get_array(...);
 	gpiod_set_array_value(my_gpio_descs->ndescs, my_gpio_descs->desc,
@@ -384,7 +385,7 @@ values are stored in value_array rather than passed back as return value.
 GPIOs mapped to IRQs
 --------------------
 GPIO lines can quite often be used as IRQs. You can get the IRQ number
-corresponding to a given GPIO using the following call:
+corresponding to a given GPIO using the following call::
 
 	int gpiod_to_irq(const struct gpio_desc *desc)
 
@@ -424,7 +425,7 @@ Interacting With the Legacy GPIO Subsystem
 Many kernel subsystems still handle GPIOs using the legacy integer-based
 interface. Although it is strongly encouraged to upgrade them to the safer
 descriptor-based API, the following two functions allow you to convert a GPIO
-descriptor into the GPIO integer namespace and vice-versa:
+descriptor into the GPIO integer namespace and vice-versa::
 
 	int desc_to_gpio(const struct gpio_desc *desc)
 	struct gpio_desc *gpio_to_desc(unsigned gpio)
diff --git a/Documentation/driver-api/gpio/index.rst b/Documentation/driver-api/gpio/index.rst
index fd22c0d1419e..6ba9e0043310 100644
--- a/Documentation/driver-api/gpio/index.rst
+++ b/Documentation/driver-api/gpio/index.rst
@@ -9,6 +9,7 @@ Contents:
 
    intro
    driver
+   consumer
    legacy
 
 Core
diff --git a/Documentation/gpio/00-INDEX b/Documentation/gpio/00-INDEX
index 64cf61245861..f960fc00a3ef 100644
--- a/Documentation/gpio/00-INDEX
+++ b/Documentation/gpio/00-INDEX
@@ -1,7 +1,5 @@
 00-INDEX
 	- This file
-consumer.txt
-	- How to obtain and use GPIOs in a driver
 drivers-on-gpio.txt:
 	- Drivers in other subsystems that can use GPIO to provide more
 	  complex functionality.
-- 
2.16.1

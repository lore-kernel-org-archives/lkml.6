Return-Path: <dmitry.torokhov@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520705712; cv=none;
        d=google.com; s=arc-20160816;
        b=q9Ad1C5J7CCD22xqxu3pVHgvtwVBFC3CzsnzYKr9TKLcEGMHq52xv2zNR3A7FUF3SB
         eZ+qQbW2sDo3+SCkvAeP3TJR3KEWJTOvgGlwb3k8RuszX9ELHlxoCOLl24Tsz7Ozx+b3
         HcbD5/n0Fj9y5w7C/7NhipFN3TBDhwdnFa2QnaC2rU/uVxanLIQMDoSfC20XQCUTAwk+
         GwewwI32w6Ox4gF7PjayF1T5i+xgkgEf09nDACwuLuSxcTs7Sy9gbbQgpV0vqs5bHd5C
         uKo2+1UgK5heiWkbevx99WgHZVPccKQ7895RZEJb1qg+BghevEEAvbj6cw6/lf+xBAkW
         mbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=8XPkr+GA6YSTN3L3OMmIDgswhQepTf0svmuV0noq714=;
        b=XG4QhgGtuDZE+5OnO2FfO/TdiaGdwI4kjXUCEFE2+g4ni1PbPcHCrusQsOIlfMPHP3
         rRQbjaobs+NuZ5C2HpTt8TwJafPtCwgolCYhaBiEPVdQ/rKJEeJA1i35fGgC+vyKsg4o
         iORZGX4Mp0vt6bruqacN/XnGLc5eUbWl61SksBxlLmJBVnyMU7yt0CxPp2A8i+TuQ5QR
         ea0NsRjit0poXMptnwRLpzoDFxTxe7+36MxqmMIdx+h7I52YyyfHObHn+5SLkKebIzqC
         W1ZGSlxWVcnkgnCYgaJ5Ktqu8QiJ+JMHQWlasuNesuIIe1MBhQbFB+bZfkHG7Qrjb4Wm
         z6Lw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jl2bmM9i;
       spf=pass (google.com: domain of dmitry.torokhov@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dmitry.torokhov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jl2bmM9i;
       spf=pass (google.com: domain of dmitry.torokhov@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dmitry.torokhov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtEtJUsCfhvPuUCbq+jyaoVuv0+wl6VG3tbqjVdKaiXFxTgbzhDaxUZJCgpZN0Ybe7cyAP3KA==
Date: Sat, 10 Mar 2018 10:15:09 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, briannorris@google.com, heiko@sntech.de,
	dtor@google.com, dianders@google.com, devicetree@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joseph Lo <josephl@nvidia.com>, stephen lu <lumotuwe@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-input@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH v5 1/3] Input: gpio-keys - add support for wakeup event
 action
Message-ID: <20180310181509.GB260013@dtor-ws>
References: <20180308073213.8419-1-jeffy.chen@rock-chips.com>
 <20180308073213.8419-2-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308073213.8419-2-jeffy.chen@rock-chips.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593796398351218110?=
X-GMAIL-MSGID: =?utf-8?q?1594575513651437936?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jeffy,

On Thu, Mar 08, 2018 at 03:32:11PM +0800, Jeffy Chen wrote:
> Add support for specifying event actions to trigger wakeup when using
> the gpio-keys input device as a wakeup source.
> 
> This would allow the device to configure when to wakeup the system. For
> example a gpio-keys input device for pen insert, may only want to wakeup
> the system when ejecting the pen.
> 
> Suggested-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v5:
> Remove unneeded irq_wake flag as Andy suggested.
> 
> Changes in v4:
> Add dt-binding gpio-keys.h, stop saving irq trigger type, add enable/disable wakeup helpers as Dmitry suggested.
> 
> Changes in v3:
> Adding more comments as Brian suggested.
> 
> Changes in v2:
> Specify wakeup event action instead of irq trigger type as Brian
> suggested.
> 
>  drivers/input/keyboard/gpio_keys.c    | 63 +++++++++++++++++++++++++++++++++--
>  include/dt-bindings/input/gpio-keys.h | 13 ++++++++
>  include/linux/gpio_keys.h             |  2 ++
>  3 files changed, 75 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/input/gpio-keys.h
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 87e613dc33b8..f6d5cfd44833 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -30,6 +30,7 @@
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
>  #include <linux/spinlock.h>
> +#include <dt-bindings/input/gpio-keys.h>
>  
>  struct gpio_button_data {
>  	const struct gpio_keys_button *button;
> @@ -45,6 +46,7 @@ struct gpio_button_data {
>  	unsigned int software_debounce;	/* in msecs, for GPIO-driven buttons */
>  
>  	unsigned int irq;
> +	unsigned int wakeup_trigger_type;
>  	spinlock_t lock;
>  	bool disabled;
>  	bool key_pressed;
> @@ -540,6 +542,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  	}
>  
>  	if (bdata->gpiod) {
> +		int active_low = gpiod_is_active_low(bdata->gpiod);
> +
>  		if (button->debounce_interval) {
>  			error = gpiod_set_debounce(bdata->gpiod,
>  					button->debounce_interval * 1000);
> @@ -568,6 +572,24 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  		isr = gpio_keys_gpio_isr;
>  		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
>  
> +		switch (button->wakeup_event_action) {
> +		case EV_ACT_ASSERTED:
> +			bdata->wakeup_trigger_type = active_low ?
> +				IRQ_TYPE_EDGE_FALLING : IRQ_TYPE_EDGE_RISING;
> +			break;
> +		case EV_ACT_DEASSERTED:
> +			bdata->wakeup_trigger_type = active_low ?
> +				IRQ_TYPE_EDGE_RISING : IRQ_TYPE_EDGE_FALLING;
> +			break;
> +		case EV_ACT_ANY:
> +			/* fall through */
> +		default:
> +			/*
> +			 * For other cases, we are OK letting suspend/resume
> +			 * not reconfigure the trigger type.
> +			 */
> +			break;
> +		}
>  	} else {
>  		if (!button->irq) {
>  			dev_err(dev, "Found button without gpio or irq\n");
> @@ -586,6 +608,11 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  
>  		isr = gpio_keys_irq_isr;
>  		irqflags = 0;
> +
> +		/*
> +		 * For IRQ buttons, there is no interrupt for release.
> +		 * So we don't need to reconfigure the trigger type for wakeup.
> +		 */
>  	}
>  
>  	bdata->code = &ddata->keymap[idx];
> @@ -718,6 +745,9 @@ gpio_keys_get_devtree_pdata(struct device *dev)
>  			/* legacy name */
>  			fwnode_property_read_bool(child, "gpio-key,wakeup");
>  
> +		fwnode_property_read_u32(child, "wakeup-event-action",
> +					 &button->wakeup_event_action);
> +
>  		button->can_disable =
>  			fwnode_property_read_bool(child, "linux,can-disable");
>  
> @@ -845,6 +875,31 @@ static int gpio_keys_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int gpio_keys_enable_wakeup(struct gpio_button_data *bdata)

These new helpers need to be __maybe_unused in case we compile on system
without suspend support.

I also wanted a bit more of error handling, so I ended up with the
version of the patch below. Can you please try it and let me know if I
broke it.

Thanks.

-- 
Dmitry


Input: gpio-keys - add support for wakeup event action

From: Jeffy Chen <jeffy.chen@rock-chips.com>

Add support for specifying event actions to trigger wakeup when using
the gpio-keys input device as a wakeup source.

This would allow the device to configure when to wakeup the system. For
example a gpio-keys input device for pen insert, may only want to wakeup
the system when ejecting the pen.

Suggested-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../devicetree/bindings/input/gpio-keys.txt        |    8 +
 drivers/input/keyboard/gpio_keys.c                 |  145 ++++++++++++++++++--
 include/dt-bindings/input/gpio-keys.h              |   13 ++
 include/linux/gpio_keys.h                          |    2 
 4 files changed, 154 insertions(+), 14 deletions(-)
 create mode 100644 include/dt-bindings/input/gpio-keys.h

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
index a94940481e55a..996ce84352cbf 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
@@ -26,6 +26,14 @@ Optional subnode-properties:
 	  If not specified defaults to 5.
 	- wakeup-source: Boolean, button can wake-up the system.
 			 (Legacy property supported: "gpio-key,wakeup")
+	- wakeup-event-action: Specifies whether the key should wake the
+	  system when asserted, when deasserted, or both. This property is
+	  only valid for keys that wake up the system (e.g., when the
+	  "wakeup-source" property is also provided).
+	  Supported values are defined in linux-event-codes.h:
+		EV_ACT_ASSERTED		- asserted
+		EV_ACT_DEASSERTED	- deasserted
+		EV_ACT_ANY		- both asserted and deasserted
 	- linux,can-disable: Boolean, indicates that button is connected
 	  to dedicated (not shared) interrupt which can be disabled to
 	  suppress events from the button.
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 87e613dc33b80..966428da6bc71 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -30,6 +30,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/spinlock.h>
+#include <dt-bindings/input/gpio-keys.h>
 
 struct gpio_button_data {
 	const struct gpio_keys_button *button;
@@ -45,6 +46,7 @@ struct gpio_button_data {
 	unsigned int software_debounce;	/* in msecs, for GPIO-driven buttons */
 
 	unsigned int irq;
+	unsigned int wakeup_trigger_type;
 	spinlock_t lock;
 	bool disabled;
 	bool key_pressed;
@@ -540,6 +542,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	}
 
 	if (bdata->gpiod) {
+		bool active_low = gpiod_is_active_low(bdata->gpiod);
+
 		if (button->debounce_interval) {
 			error = gpiod_set_debounce(bdata->gpiod,
 					button->debounce_interval * 1000);
@@ -568,6 +572,24 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		isr = gpio_keys_gpio_isr;
 		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
 
+		switch (button->wakeup_event_action) {
+		case EV_ACT_ASSERTED:
+			bdata->wakeup_trigger_type = active_low ?
+				IRQ_TYPE_EDGE_FALLING : IRQ_TYPE_EDGE_RISING;
+			break;
+		case EV_ACT_DEASSERTED:
+			bdata->wakeup_trigger_type = active_low ?
+				IRQ_TYPE_EDGE_RISING : IRQ_TYPE_EDGE_FALLING;
+			break;
+		case EV_ACT_ANY:
+			/* fall through */
+		default:
+			/*
+			 * For other cases, we are OK letting suspend/resume
+			 * not reconfigure the trigger type.
+			 */
+			break;
+		}
 	} else {
 		if (!button->irq) {
 			dev_err(dev, "Found button without gpio or irq\n");
@@ -586,6 +608,11 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 
 		isr = gpio_keys_irq_isr;
 		irqflags = 0;
+
+		/*
+		 * For IRQ buttons, there is no interrupt for release.
+		 * So we don't need to reconfigure the trigger type for wakeup.
+		 */
 	}
 
 	bdata->code = &ddata->keymap[idx];
@@ -718,6 +745,9 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 			/* legacy name */
 			fwnode_property_read_bool(child, "gpio-key,wakeup");
 
+		fwnode_property_read_u32(child, "wakeup-event-action",
+					 &button->wakeup_event_action);
+
 		button->can_disable =
 			fwnode_property_read_bool(child, "linux,can-disable");
 
@@ -845,19 +875,112 @@ static int gpio_keys_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused
+gpio_keys_button_enable_wakeup(struct gpio_button_data *bdata)
+{
+	int error;
+
+	error = enable_irq_wake(bdata->irq);
+	if (error) {
+		dev_err(bdata->input->dev.parent,
+			"failed to configure IRQ %d as wakeup source: %d\n",
+			bdata->irq, error);
+		return error;
+	}
+
+	if (bdata->wakeup_trigger_type) {
+		error = irq_set_irq_type(bdata->irq,
+					 bdata->wakeup_trigger_type);
+		if (error) {
+			dev_err(bdata->input->dev.parent,
+				"failed to set wakeup trigger %08x for IRQ %d: %d\n",
+				bdata->wakeup_trigger_type, bdata->irq, error);
+			disable_irq_wake(bdata->irq);
+			return error;
+		}
+	}
+
+	return 0;
+}
+
+static void __maybe_unused
+gpio_keys_button_disable_wakeup(struct gpio_button_data *bdata)
+{
+	int error;
+
+	/*
+	 * The trigger type is always both edges for gpio-based keys and we do
+	 * not support changing wakeup trigger for interrupt-based keys.
+	 */
+	if (bdata->wakeup_trigger_type) {
+		error = irq_set_irq_type(bdata->irq, IRQ_TYPE_EDGE_BOTH);
+		if (error)
+			dev_warn(bdata->input->dev.parent,
+				 "failed to restore interrupt trigger for IRQ %d: %d\n",
+				 bdata->irq, error);
+	}
+
+	error = disable_irq_wake(bdata->irq);
+	if (error)
+		dev_warn(bdata->input->dev.parent,
+			 "failed to disable IRQ %d as wake source: %d\n",
+			 bdata->irq, error);
+}
+
+static int __maybe_unused
+gpio_keys_enable_wakeup(struct gpio_keys_drvdata *ddata)
+{
+	struct gpio_button_data *bdata;
+	int error;
+	int i;
+
+	for (i = 0; i < ddata->pdata->nbuttons; i++) {
+		bdata = &ddata->data[i];
+		if (bdata->button->wakeup) {
+			error = gpio_keys_button_enable_wakeup(bdata);
+			if (error)
+				goto err_out;
+		}
+		bdata->suspended = true;
+	}
+
+	return 0;
+
+err_out:
+	while (--i >= 0) {
+		bdata = &ddata->data[i];
+		if (bdata->button->wakeup)
+			gpio_keys_button_disable_wakeup(bdata);
+		bdata->suspended = false;
+	}
+
+	return error;
+}
+
+static void __maybe_unused
+gpio_keys_disable_wakeup(struct gpio_keys_drvdata *ddata)
+{
+	struct gpio_button_data *bdata;
+	int i;
+
+	for (i = 0; i < ddata->pdata->nbuttons; i++) {
+		bdata = &ddata->data[i];
+		bdata->suspended = false;
+		if (irqd_is_wakeup_set(irq_get_irq_data(bdata->irq)))
+			gpio_keys_button_disable_wakeup(bdata);
+	}
+}
+
 static int __maybe_unused gpio_keys_suspend(struct device *dev)
 {
 	struct gpio_keys_drvdata *ddata = dev_get_drvdata(dev);
 	struct input_dev *input = ddata->input;
-	int i;
+	int error;
 
 	if (device_may_wakeup(dev)) {
-		for (i = 0; i < ddata->pdata->nbuttons; i++) {
-			struct gpio_button_data *bdata = &ddata->data[i];
-			if (bdata->button->wakeup)
-				enable_irq_wake(bdata->irq);
-			bdata->suspended = true;
-		}
+		error = gpio_keys_enable_wakeup(ddata);
+		if (error)
+			return error;
 	} else {
 		mutex_lock(&input->mutex);
 		if (input->users)
@@ -873,15 +996,9 @@ static int __maybe_unused gpio_keys_resume(struct device *dev)
 	struct gpio_keys_drvdata *ddata = dev_get_drvdata(dev);
 	struct input_dev *input = ddata->input;
 	int error = 0;
-	int i;
 
 	if (device_may_wakeup(dev)) {
-		for (i = 0; i < ddata->pdata->nbuttons; i++) {
-			struct gpio_button_data *bdata = &ddata->data[i];
-			if (bdata->button->wakeup)
-				disable_irq_wake(bdata->irq);
-			bdata->suspended = false;
-		}
+		gpio_keys_disable_wakeup(ddata);
 	} else {
 		mutex_lock(&input->mutex);
 		if (input->users)
diff --git a/include/dt-bindings/input/gpio-keys.h b/include/dt-bindings/input/gpio-keys.h
new file mode 100644
index 0000000000000..8962df79e753b
--- /dev/null
+++ b/include/dt-bindings/input/gpio-keys.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for gpio keys bindings.
+ */
+
+#ifndef _DT_BINDINGS_GPIO_KEYS_H
+#define _DT_BINDINGS_GPIO_KEYS_H
+
+#define EV_ACT_ANY		0x00	/* asserted or deasserted */
+#define EV_ACT_ASSERTED		0x01	/* asserted */
+#define EV_ACT_DEASSERTED	0x02	/* deasserted */
+
+#endif /* _DT_BINDINGS_GPIO_KEYS_H */
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index d06bf77400f16..7160df54a6fe3 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -13,6 +13,7 @@ struct device;
  * @desc:		label that will be attached to button's gpio
  * @type:		input event type (%EV_KEY, %EV_SW, %EV_ABS)
  * @wakeup:		configure the button as a wake-up source
+ * @wakeup_event_action:	event action to trigger wakeup
  * @debounce_interval:	debounce ticks interval in msecs
  * @can_disable:	%true indicates that userspace is allowed to
  *			disable button via sysfs
@@ -26,6 +27,7 @@ struct gpio_keys_button {
 	const char *desc;
 	unsigned int type;
 	int wakeup;
+	int wakeup_event_action;
 	int debounce_interval;
 	bool can_disable;
 	int value;

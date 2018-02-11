Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753814AbeBKVVN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 16:21:13 -0500
Received: from casper.infradead.org ([85.118.1.10]:57368 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753719AbeBKVVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 16:21:11 -0500
Subject: Re: [PATCH 7/7] platform/x86: fujitsu-laptop: Clean up constants
To: =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Jonathan Woithe <jwoithe@just42.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180211210727.12130-1-kernel@kempniu.pl>
 <20180211210727.12130-8-kernel@kempniu.pl>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <628c2c03-c855-ed2a-b175-5238c561548e@infradead.org>
Date: Sun, 11 Feb 2018 13:20:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180211210727.12130-8-kernel@kempniu.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/18 13:07, Michał Kępień wrote:
> Align all constant values defined in the module to a common indentation.
> Rename ACPI_FUJITSU_NOTIFY_CODE1 to ACPI_FUJITSU_NOTIFY_CODE as there is
> only one ACPI notification code used throughout the driver.  Define all
> bitmasks using the BIT() macro.  Clean up comments.
> 
> Signed-off-by: Michał Kępień <kernel@kempniu.pl>
> ---
>  drivers/platform/x86/fujitsu-laptop.c | 65 ++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index 0ee03d1fcbc4..07c713d9d273 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -63,9 +63,9 @@
>  #include <linux/platform_device.h>
>  #include <acpi/video.h>

Hi,

It looks like this driver needs to #include <linux/bitops.h>
for use of BIT() macros.

See Documentation/process/submit-checklist.rst:
1) If you use a facility then #include the file that defines/declares
   that facility.  Don't depend on other header files pulling in ones
   that you use.

Some $ARCH may work without it while another one may not.

> -#define FUJITSU_DRIVER_VERSION "0.6.0"
> +#define FUJITSU_DRIVER_VERSION		"0.6.0"
>  
> -#define FUJITSU_LCD_N_LEVELS 8
> +#define FUJITSU_LCD_N_LEVELS		8
>  
>  #define ACPI_FUJITSU_CLASS		"fujitsu"
>  #define ACPI_FUJITSU_BL_HID		"FUJ02B1"
> @@ -75,46 +75,47 @@
>  #define ACPI_FUJITSU_LAPTOP_DRIVER_NAME	"Fujitsu laptop FUJ02E3 ACPI hotkeys driver"
>  #define ACPI_FUJITSU_LAPTOP_DEVICE_NAME	"Fujitsu FUJ02E3"
>  
> -#define ACPI_FUJITSU_NOTIFY_CODE1     0x80
> +#define ACPI_FUJITSU_NOTIFY_CODE	0x80
>  
>  /* FUNC interface - command values */
> -#define FUNC_FLAGS	0x1000
> -#define FUNC_LEDS	0x1001
> -#define FUNC_BUTTONS	0x1002
> -#define FUNC_BACKLIGHT  0x1004
> +#define FUNC_FLAGS			BIT(12)
> +#define FUNC_LEDS			(BIT(12) | BIT(0))
> +#define FUNC_BUTTONS			(BIT(12) | BIT(1))
> +#define FUNC_BACKLIGHT			(BIT(12) | BIT(2))
>  
>  /* FUNC interface - responses */
> -#define UNSUPPORTED_CMD 0x80000000
> +#define UNSUPPORTED_CMD			BIT(31)
>  
>  /* FUNC interface - status flags */
> -#define FLAG_RFKILL	0x020
> -#define FLAG_LID	0x100
> -#define FLAG_DOCK	0x200
> +#define FLAG_RFKILL			BIT(5)
> +#define FLAG_LID			BIT(8)
> +#define FLAG_DOCK			BIT(9)
>  
>  /* FUNC interface - LED control */
> -#define FUNC_LED_OFF	0x1
> -#define FUNC_LED_ON	0x30001
> -#define KEYBOARD_LAMPS	0x100
> -#define LOGOLAMP_POWERON 0x2000
> -#define LOGOLAMP_ALWAYS  0x4000
> -#define RADIO_LED_ON	0x20
> -#define ECO_LED	0x10000
> -#define ECO_LED_ON	0x80000
> +#define FUNC_LED_OFF			BIT(0)
> +#define FUNC_LED_ON			(BIT(0) | BIT(16) | BIT(17))
> +#define LOGOLAMP_POWERON		BIT(13)
> +#define LOGOLAMP_ALWAYS			BIT(14)
> +#define KEYBOARD_LAMPS			BIT(8)
> +#define RADIO_LED_ON			BIT(5)
> +#define ECO_LED				BIT(16)
> +#define ECO_LED_ON			BIT(19)
>  
>  /* FUNC interface - backlight power control */
> -#define BACKLIGHT_POWER	0x4
> -#define BACKLIGHT_OFF	0x3
> -#define BACKLIGHT_ON	0x0
> +#define BACKLIGHT_POWER			BIT(2)
> +#define BACKLIGHT_OFF			(BIT(0) | BIT(1))
> +#define BACKLIGHT_ON			0
>  
> -/* Hotkey details */
> -#define KEY1_CODE	0x410	/* codes for the keys in the GIRB register */
> -#define KEY2_CODE	0x411
> -#define KEY3_CODE	0x412
> -#define KEY4_CODE	0x413
> -#define KEY5_CODE	0x420
> +/* Scancodes read from the GIRB register */
> +#define KEY1_CODE			0x410
> +#define KEY2_CODE			0x411
> +#define KEY3_CODE			0x412
> +#define KEY4_CODE			0x413
> +#define KEY5_CODE			0x420
>  
> -#define MAX_HOTKEY_RINGBUFFER_SIZE 100
> -#define RINGBUFFERSIZE 40
> +/* Hotkey ringbuffer limits */
> +#define MAX_HOTKEY_RINGBUFFER_SIZE	100
> +#define RINGBUFFERSIZE			40
>  
>  /* Module parameters */
>  static int use_alt_lcd_levels = -1;
> @@ -428,7 +429,7 @@ static void acpi_fujitsu_bl_notify(struct acpi_device *device, u32 event)
>  	struct fujitsu_bl *priv = acpi_driver_data(device);
>  	int oldb, newb;
>  
> -	if (event != ACPI_FUJITSU_NOTIFY_CODE1) {
> +	if (event != ACPI_FUJITSU_NOTIFY_CODE) {
>  		acpi_handle_info(device->handle, "unsupported event [0x%x]\n",
>  				 event);
>  		sparse_keymap_report_event(priv->input, -1, 1, true);
> @@ -902,7 +903,7 @@ static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u32 event)
>  	int scancode, i = 0;
>  	unsigned int irb;
>  
> -	if (event != ACPI_FUJITSU_NOTIFY_CODE1) {
> +	if (event != ACPI_FUJITSU_NOTIFY_CODE) {
>  		acpi_handle_info(device->handle, "Unsupported event [0x%x]\n",
>  				 event);
>  		sparse_keymap_report_event(priv->input, -1, 1, true);
> 


-- 
~Randy

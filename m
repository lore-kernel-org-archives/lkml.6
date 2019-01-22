Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659EDC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111C120879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vv9dL3K3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfAVPCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:02:10 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40378 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbfAVPCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:02:09 -0500
Received: by mail-qt1-f195.google.com with SMTP id k12so27845814qtf.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 07:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OcQUj4JCiqLswECfOBtwmy17SycA2VJ+Rj/QyUr7W+o=;
        b=Vv9dL3K3z6reT286NNhxTm83LZinLMp0f6wS0S1jm8e3+cMdSH7XTTFdVQ+3u82Eix
         GpSGQoZ0HdcHv2bYE57Yt0PjoRTK00Qp+gcDvEL8PlBMKbsGihjkV+Ir9VisqJAhtcLz
         cTpyU7xBcWjBmJJ5vko3fZysgXX+Wp64MTeWCn0S1VvC/UcoMzl5r6mcf1Gjh58Bb3S3
         9ePifPmcCiHqSiQZyJXha9fzSw7QwhR0D3JX59d/M26Hmt0HLm7B/8sjscG8tyhgG8x8
         RCeCjDqWY3ayAGaTgLqdTJXA8XaBzHTYYw+it68pKVfeZAmyuiyjCVntlK919vHFy3Tm
         Fj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OcQUj4JCiqLswECfOBtwmy17SycA2VJ+Rj/QyUr7W+o=;
        b=R68ro02wAtBKTqaRAOZQzuH7N3FpHKrQoCRmZw7SIj4nveiICxxAi+y1kEEM8tnbmZ
         +zI/daLOnL69AJt2b8OXEG3Zs+tIutKhubpD3CSVVOtx+pPY4EniDyvfn15Q86QVnvkb
         O8zsllaBo6BaQW1oPJoh6YQpxM8OVwK+UPG+Ayi2BwTlokWWHoO9p3o99mc41/n0Fsqk
         79KwPxTlxspGpPxKsOBElSVgnHytlcdZnzt/TGGWEf3ddIT1cXzEyRYRFeVNbZnCcyoS
         r77vBulbVdEg99nHW+4I6uc7O1d+ZRcOFUvkfRdh8cbi3eCnxomY7BIa3KMJHZxtwh6R
         akyQ==
X-Gm-Message-State: AJcUukeh1+1h3pSFwU3QMRzM80pINFbwZ9tl25SAmomXAg6HV6RI+3GY
        +NZkeSFqeVZBrtjt3DYXKpNL3Y9GKPTpJvHai1Y=
X-Google-Smtp-Source: ALg8bN7Z9lbBK+t/izSA/dXOyBH42lMZYEgbIhhsFwZ3hervR0wE/GzZawrTUe9SSpR9mzPAClkXaLStNGBHEjrXjMo=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr30583389qtd.257.1548169326512;
 Tue, 22 Jan 2019 07:02:06 -0800 (PST)
MIME-Version: 1.0
References: <20190119001422.48186-1-ncrews@chromium.org> <20190119001422.48186-7-ncrews@chromium.org>
In-Reply-To: <20190119001422.48186-7-ncrews@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 22 Jan 2019 16:01:55 +0100
Message-ID: <CAFqH_51w213x3W9PTDWu1Qa+fqsGqUtrAFwZqX5zX4Y7kspteg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] platform/chrome: Add event handling
To:     Nick Crews <ncrews@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Simon Glass <sjg@chromium.org>,
        Daniel Kurtz <djkurtz@google.com>, dlaurie@chromium.org,
        Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

I'd like to have some feedback from input subsystem if it's possible,
so adding linux-input@vger.kernel.org and Dmitry. Don't forget to add
them for the next versions.

Missatge de Nick Crews <ncrews@chromium.org> del dia ds., 19 de gen.
2019 a les 1:16:
>
> From: Duncan Laurie <dlaurie@google.com>
>
> The Wilco Embedded Controller can return extended events that
> are not handled by standard ACPI objects.  These events can
> include hotkeys which map to standard functions like brightness
> controls, or information about EC controlled features like the
> charger or battery.
>
> These events are triggered with an ACPI Notify(0x90) and the
> event data buffer is read through an ACPI method provided by
> the BIOS which reads the event buffer from EC RAM.
>
> These events are then processed, with hotkey events being sent
> to the input subsystem and other events put into a queue which
> can be read by a userspace daemon via a sysfs attribute.
>
> > evtest /dev/input/event6
> Input driver version is 1.0.1
> Input device ID: bus 0x19 vendor 0x0 product 0x0 version 0x0
> Input device name: "Wilco EC hotkeys"
> Supported events:
>   Event type 0 (EV_SYN)
>   Event type 1 (EV_KEY)
>     Event code 224 (KEY_BRIGHTNESSDOWN)
>     Event code 225 (KEY_BRIGHTNESSUP)
>     Event code 240 (KEY_UNKNOWN)
>   Event type 4 (EV_MSC)
>     Event code 4 (MSC_SCAN)
> Properties:
> Testing ... (interrupt to exit)
> Event: type 4 (EV_MSC), code 4 (MSC_SCAN), value 57
> Event: type 1 (EV_KEY), code 224 (KEY_BRIGHTNESSDOWN), value 1
> Event: -------------- SYN_REPORT ------------
> Event: type 1 (EV_KEY), code 224 (KEY_BRIGHTNESSDOWN), value 0
> Event: -------------- SYN_REPORT ------------
> Event: type 4 (EV_MSC), code 4 (MSC_SCAN), value 58
> Event: type 1 (EV_KEY), code 225 (KEY_BRIGHTNESSUP), value 1
> Event: -------------- SYN_REPORT ------------
> Event: type 1 (EV_KEY), code 225 (KEY_BRIGHTNESSUP), value 0
> Event: -------------- SYN_REPORT ------------
>
> Signed-off-by: Duncan Laurie <dlaurie@google.com>
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> ---
>
> Changes in v3:
> - change err check from "if (ret < 0)" to "if (ret)"
>
> Changes in v2:
> - rm "wilco_ec_event -" prefix from docstring
> - rm license boiler plate
> - Add sysfs directory documentation
> - Fix cosmetics
> - events are init()ed before subdrivers now
>
>  drivers/platform/chrome/wilco_ec/Makefile |   2 +-
>  drivers/platform/chrome/wilco_ec/core.c   |  14 +-
>  drivers/platform/chrome/wilco_ec/event.c  | 347 ++++++++++++++++++++++
>  include/linux/platform_data/wilco-ec.h    |  34 +++
>  4 files changed, 395 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/platform/chrome/wilco_ec/event.c
>
> diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
> index 84ad2772247c..18070d0f8b5e 100644
> --- a/drivers/platform/chrome/wilco_ec/Makefile
> +++ b/drivers/platform/chrome/wilco_ec/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  wilco_ec-objs                          := core.o mailbox.o debugfs.o sysfs.o \
> -                                          legacy.o
> +                                          legacy.o event.o
>  obj-$(CONFIG_WILCO_EC)                 += wilco_ec.o
> diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
> index dd8b896b3833..65588cfcc7a2 100644
> --- a/drivers/platform/chrome/wilco_ec/core.c
> +++ b/drivers/platform/chrome/wilco_ec/core.c
> @@ -77,6 +77,13 @@ static int wilco_ec_probe(struct platform_device *pdev)
>                 goto rm_debugfs;
>         }
>
> +       /* Prepare to handle events */
> +       ret = wilco_ec_event_init(ec);
> +       if (ret) {
> +               dev_err(dev, "Failed to setup event handling\n");
> +               goto remove_sysfs;
> +       }
> +
>         /*
>          * Register a RTC platform device that will get picked up by the RTC
>          * subsystem. This platform device will get freed when its parent device
> @@ -88,11 +95,13 @@ static int wilco_ec_probe(struct platform_device *pdev)
>         if (IS_ERR(child_pdev)) {
>                 dev_err(dev, "Failed to create RTC platform device\n");
>                 ret = PTR_ERR(child_pdev);
> -               goto remove_sysfs;
> +               goto remove_events;
>         }
>
>         return 0;
>
> +remove_events:
> +       wilco_ec_event_remove(ec);
>  remove_sysfs:
>         wilco_ec_sysfs_remove(ec);
>  rm_debugfs:
> @@ -106,6 +115,9 @@ static int wilco_ec_remove(struct platform_device *pdev)
>  {
>         struct wilco_ec_device *ec = platform_get_drvdata(pdev);
>
> +       /* Stop handling EC events */
> +       wilco_ec_event_remove(ec);
> +
>         /* Remove sysfs attributes */
>         wilco_ec_sysfs_remove(ec);
>
> diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
> new file mode 100644
> index 000000000000..7601c02dffe8
> --- /dev/null
> +++ b/drivers/platform/chrome/wilco_ec/event.c
> @@ -0,0 +1,347 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Event handling for Wilco Embedded Controller
> + *
> + * Copyright 2018 Google LLC
> + *
> + * The Wilco Embedded Controller can return extended events that
> + * are not handled by standard ACPI objects.  These events can
> + * include hotkeys which map to standard functions like brightness
> + * controls, or information about EC controlled features like the
> + * charger or battery.
> + *
> + * These events are triggered with an ACPI Notify(0x90) and the
> + * event data buffer is read through an ACPI method provided by
> + * the BIOS which reads the event buffer from EC RAM.
> + *
> + * These events are then processed, with hotkey events being sent
> + * to the input subsystem and other events put into a queue which
> + * can be read by a userspace daemon via a sysfs attribute.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/input.h>
> +#include <linux/input/sparse-keymap.h>
> +#include <linux/list.h>
> +#include <linux/platform_data/wilco-ec.h>
> +#include <linux/platform_device.h>
> +
> +/* ACPI Notify event code indicating event data is available */
> +#define EC_ACPI_NOTIFY_EVENT           0x90
> +
> +/* ACPI Method to execute to retrieve event data buffer from the EC */
> +#define EC_ACPI_GET_EVENT              "^QSET"
> +
> +/* Maximum number of words in event data returned by the EC */
> +#define EC_ACPI_MAX_EVENT_DATA         6
> +
> +/* Keep at most 100 events in the queue */
> +#define EC_EVENT_QUEUE_MAX             100
> +
> +/**
> + * enum ec_event_type - EC event categories.
> + * @EC_EVENT_TYPE_HOTKEY: Hotkey event for handling special keys.
> + * @EC_EVENT_TYPE_NOTIFY: EC feature state changes.
> + * @EC_EVENT_TYPE_SYSTEM: EC system messages.
> + */
> +enum ec_event_type {
> +       EC_EVENT_TYPE_HOTKEY = 0x10,
> +       EC_EVENT_TYPE_NOTIFY = 0x11,
> +       EC_EVENT_TYPE_SYSTEM = 0x12,
> +};
> +
> +/**
> + * struct ec_event - Extended event returned by the EC.
> + * @size: Number of words in structure after the size word.
> + * @type: Extended event type from &enum ec_event_type.
> + * @event: Event data words.  Max count is %EC_ACPI_MAX_EVENT_DATA.
> + */
> +struct ec_event {
> +       u16 size;
> +       u16 type;
> +       u16 event[0];
> +} __packed;
> +
> +/**
> + * struct ec_event_entry - Event queue entry.
> + * @list: List node.
> + * @size: Number of bytes in event structure.
> + * @event: Extended event returned by the EC.  This should be the last
> + *         element because &struct ec_event includes a zero length array.
> + */
> +struct ec_event_entry {
> +       struct list_head list;
> +       size_t size;
> +       struct ec_event event;
> +};
> +
> +static const struct key_entry wilco_ec_keymap[] = {
> +       { KE_KEY, 0x0057, { KEY_BRIGHTNESSDOWN } },
> +       { KE_KEY, 0x0058, { KEY_BRIGHTNESSUP } },
> +       { KE_END, 0 }
> +};
> +
> +/**
> + * wilco_ec_handle_events() - Handle Embedded Controller events.
> + * @ec: EC device.
> + * @buf: Buffer of event data.
> + * @length: Length of event data buffer.
> + *
> + * Return: Number of events in queue or negative error code on failure.
> + *
> + * This function will handle EC extended events, sending hotkey events
> + * to the input subsystem and queueing others to be read by userspace.
> + */
> +static int wilco_ec_handle_events(struct wilco_ec_device *ec,
> +                                 u8 *buf, u32 length)
> +{
> +       struct wilco_ec_event *queue = &ec->event;
> +       struct ec_event *event;
> +       struct ec_event_entry *entry;
> +       size_t entry_size, num_words;
> +       u32 offset = 0;
> +
> +       while (offset < length) {
> +               event = (struct ec_event *)(buf + offset);
> +               if (!event)
> +                       return -EINVAL;
> +
> +               dev_dbg(ec->dev, "EC event type 0x%02x size %d\n", event->type,
> +                       event->size);
> +
> +               /* Number of 16bit event data words is size - 1 */
> +               num_words = event->size - 1;
> +               entry_size = sizeof(*event) + (num_words * sizeof(u16));
> +
> +               if (num_words > EC_ACPI_MAX_EVENT_DATA) {
> +                       dev_err(ec->dev, "Invalid event word count: %d > %d\n",
> +                               num_words, EC_ACPI_MAX_EVENT_DATA);
> +                       return -EOVERFLOW;
> +               };
> +
> +               /* Ensure event does not overflow the available buffer */
> +               if ((offset + entry_size) > length) {
> +                       dev_err(ec->dev, "Event exceeds buffer: %d > %d\n",
> +                               offset + entry_size, length);
> +                       return -EOVERFLOW;
> +               }
> +
> +               /* Point to the next event in the buffer */
> +               offset += entry_size;
> +
> +               /* Hotkeys are sent to the input subsystem */
> +               if (event->type == EC_EVENT_TYPE_HOTKEY) {
> +                       if (sparse_keymap_report_event(queue->input,
> +                                                      event->event[0],
> +                                                      1, true))
> +                               continue;
> +
> +                       /* Unknown hotkeys are put into the event queue */
> +                       dev_dbg(ec->dev, "Unknown hotkey 0x%04x\n",
> +                               event->event[0]);
> +               }
> +
> +               /* Prepare event for the queue */
> +               entry = kzalloc(entry_size, GFP_KERNEL);
> +               if (!entry)
> +                       return -ENOMEM;
> +
> +               /* Copy event data */
> +               entry->size = entry_size;
> +               memcpy(&entry->event, event, entry->size);
> +
> +               /* Add this event to the queue */
> +               mutex_lock(&queue->lock);
> +               list_add_tail(&entry->list, &queue->list);
> +               queue->count++;
> +               mutex_unlock(&queue->lock);
> +       }
> +
> +       return queue->count;
> +}
> +
> +/**
> + * wilco_ec_acpi_notify() - Handler called by ACPI subsystem for Notify.
> + * @device: EC ACPI device.
> + * @value: Value passed to Notify() in ACPI.
> + * @data: Private data, pointer to EC device.
> + */
> +static void wilco_ec_acpi_notify(acpi_handle device, u32 value, void *data)
> +{
> +       struct wilco_ec_device *ec = data;
> +       struct acpi_buffer event_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +       union acpi_object *obj;
> +       acpi_status status;
> +       int count;
> +
> +       /* Currently only handle event notifications */
> +       if (value != EC_ACPI_NOTIFY_EVENT) {
> +               dev_err(ec->dev, "Invalid event: 0x%08x\n", value);
> +               return;
> +       }
> +
> +       /* Execute ACPI method to get event data buffer */
> +       status = acpi_evaluate_object(device, EC_ACPI_GET_EVENT,
> +                                     NULL, &event_buffer);
> +       if (ACPI_FAILURE(status)) {
> +               dev_err(ec->dev, "Error executing ACPI method %s()\n",
> +                        EC_ACPI_GET_EVENT);
> +               return;
> +       }
> +
> +       obj = (union acpi_object *)event_buffer.pointer;
> +       if (!obj) {
> +               dev_err(ec->dev, "Nothing returned from %s()\n",
> +                       EC_ACPI_GET_EVENT);
> +               return;
> +       }
> +       if (obj->type != ACPI_TYPE_BUFFER) {
> +               dev_err(ec->dev, "Invalid object returned from %s()\n",
> +                       EC_ACPI_GET_EVENT);
> +               kfree(obj);
> +               return;
> +       }
> +       if (obj->buffer.length < sizeof(struct ec_event)) {
> +               dev_err(ec->dev, "Invalid buffer length %d from %s()\n",
> +                       obj->buffer.length, EC_ACPI_GET_EVENT);
> +               kfree(obj);
> +               return;
> +       }
> +
> +       /* Handle events and notify sysfs if any queued for userspace */
> +       count = wilco_ec_handle_events(ec, obj->buffer.pointer,
> +                                      obj->buffer.length);
> +
> +       if (count > 0) {
> +               dev_dbg(ec->dev, "EC event queue has %d entries\n", count);
> +               sysfs_notify(&ec->dev->kobj, NULL, "event");
> +       }
> +
> +       kfree(obj);
> +}
> +
> +static ssize_t wilco_ec_event_read(struct file *filp, struct kobject *kobj,
> +                                  struct bin_attribute *attr,
> +                                  char *buf, loff_t off, size_t count)
> +{
> +       struct wilco_ec_device *ec = attr->private;
> +       struct ec_event_entry *entry;
> +
> +       /* Only supports reading full events */
> +       if (off != 0)
> +               return -EINVAL;
> +
> +       /* Remove the first event and provide it to userspace */
> +       mutex_lock(&ec->event.lock);
> +       entry = list_first_entry_or_null(&ec->event.list,
> +                                        struct ec_event_entry, list);
> +       if (entry) {
> +               if (entry->size < count)
> +                       count = entry->size;
> +               memcpy(buf, &entry->event, count);
> +               list_del(&entry->list);
> +               kfree(entry);
> +               ec->event.count--;
> +       } else {
> +               count = 0;
> +       }
> +       mutex_unlock(&ec->event.lock);
> +
> +       return count;
> +}
> +
> +static void wilco_ec_event_clear(struct wilco_ec_device *ec)
> +{
> +       struct ec_event_entry *entry, *next;
> +
> +       mutex_lock(&ec->event.lock);
> +
> +       /* Clear the event queue */
> +       list_for_each_entry_safe(entry, next, &ec->event.list, list) {
> +               list_del(&entry->list);
> +               kfree(entry);
> +               ec->event.count--;
> +       }
> +
> +       mutex_unlock(&ec->event.lock);
> +}
> +
> +int wilco_ec_event_init(struct wilco_ec_device *ec)
> +{
> +       struct wilco_ec_event *event = &ec->event;
> +       struct device *dev = ec->dev;
> +       struct acpi_device *adev = ACPI_COMPANION(dev);
> +       acpi_status status;
> +       int ret;
> +
> +       if (!adev) {
> +               dev_err(dev, "Unable to find Wilco ACPI Device\n");
> +               return -ENODEV;
> +       }
> +
> +       INIT_LIST_HEAD(&event->list);
> +       mutex_init(&event->lock);
> +
> +       /* Allocate input device for hotkeys */
> +       event->input = input_allocate_device();
> +       if (!event->input)
> +               return -ENOMEM;
> +       event->input->name = "Wilco EC hotkeys";
> +       event->input->phys = "ec/input0";
> +       event->input->id.bustype = BUS_HOST;
> +       ret = sparse_keymap_setup(event->input, wilco_ec_keymap, NULL);
> +       if (ret) {
> +               dev_err(dev, "Unable to setup input device keymap\n");
> +               input_free_device(event->input);
> +               return ret;
> +       }
> +       ret = input_register_device(event->input);
> +       if (ret) {
> +               dev_err(dev, "Unable to register input device\n");
> +               input_free_device(event->input);
> +               return ret;
> +       }
> +
> +       /* Create sysfs attribute for userspace event handling */
> +       sysfs_bin_attr_init(&event->attr);
> +       event->attr.attr.name = "event";
> +       event->attr.attr.mode = 0400;
> +       event->attr.read = wilco_ec_event_read;
> +       event->attr.private = ec;
> +       ret = device_create_bin_file(dev, &event->attr);
> +       if (ret) {
> +               dev_err(dev, "Failed to create event attribute in sysfs\n");
> +               input_unregister_device(event->input);
> +               return ret;
> +       }
> +
> +       /* Install ACPI handler for Notify events */
> +       status = acpi_install_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
> +                                            wilco_ec_acpi_notify, ec);
> +       if (ACPI_FAILURE(status)) {
> +               dev_err(dev, "Failed to register notifier %08x\n", status);
> +               device_remove_bin_file(dev, &event->attr);
> +               input_unregister_device(event->input);
> +               return -ENODEV;
> +       }
> +
> +       return 0;
> +}
> +
> +void wilco_ec_event_remove(struct wilco_ec_device *ec)
> +{
> +       struct acpi_device *adev = ACPI_COMPANION(ec->dev);
> +
> +       /* Stop new events */
> +       if (adev)
> +               acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
> +                                          wilco_ec_acpi_notify);
> +
> +       /* Remove event interfaces */
> +       device_remove_bin_file(ec->dev, &ec->event.attr);
> +       input_unregister_device(ec->event.input);
> +
> +       /* Clear the event queue */
> +       wilco_ec_event_clear(ec);
> +}
> diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
> index b1487a259a12..2728fad90a3a 100644
> --- a/include/linux/platform_data/wilco-ec.h
> +++ b/include/linux/platform_data/wilco-ec.h
> @@ -9,7 +9,9 @@
>  #define WILCO_EC_H
>
>  #include <linux/device.h>
> +#include <linux/input.h>
>  #include <linux/kernel.h>
> +#include <linux/list.h>
>
>  #define WILCO_EC_FLAG_NO_RESPONSE      BIT(0) /* EC does not respond */
>  #define WILCO_EC_FLAG_EXTENDED_DATA    BIT(1) /* EC returns 256 data bytes */
> @@ -24,6 +26,22 @@
>  /* Extended commands have 256 bytes of response data */
>  #define EC_MAILBOX_DATA_SIZE_EXTENDED  256
>
> +/**
> + * struct wilco_ec_event - EC extended events.
> + * @lock: Mutex to guard the list of events.
> + * @list: Queue of EC events to be provided to userspace.
> + * @attr: Sysfs attribute for userspace to read events.
> + * @count: Count of events in the queue.
> + * @input: Input device for hotkey events.
> + */
> +struct wilco_ec_event {
> +       struct mutex lock;
> +       struct list_head list;
> +       struct bin_attribute attr;
> +       size_t count;
> +       struct input_dev *input;
> +};
> +
>  /**
>   * struct wilco_ec_device - Wilco Embedded Controller handle.
>   * @dev: Device handle.
> @@ -34,6 +52,7 @@
>   * @data_buffer: Buffer used for EC communication.  The same buffer
>   *               is used to hold the request and the response.
>   * @data_size: Size of the data buffer used for EC communication.
> + * @event: EC extended event handler.
>   */
>  struct wilco_ec_device {
>         struct device *dev;
> @@ -43,6 +62,7 @@ struct wilco_ec_device {
>         struct resource *io_packet;
>         void *data_buffer;
>         size_t data_size;
> +       struct wilco_ec_event event;
>  };
>
>  /**
> @@ -152,4 +172,18 @@ int wilco_ec_sysfs_init(struct wilco_ec_device *ec);
>   */
>  void wilco_ec_sysfs_remove(struct wilco_ec_device *ec);
>
> +/**
> + * wilco_ec_event_init() - Prepare to handle EC events.
> + * @ec: EC device.
> + *
> + * Return: 0 for success or negative error code on failure.
> + */
> +int wilco_ec_event_init(struct wilco_ec_device *ec);
> +
> +/**
> + * wilco_ec_event_remove() - Remove EC event handler.
> + * @ec: EC device.
> + */
> +void wilco_ec_event_remove(struct wilco_ec_device *ec);
> +
>  #endif /* WILCO_EC_H */
> --
> 2.20.1.321.g9e740568ce-goog
>

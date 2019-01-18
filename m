Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453E8C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88BF2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pC+yXeiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbfARV0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:26:30 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45792 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729601AbfARV03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:26:29 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so15636401ota.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 13:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F0he9Q+Wbddv9A2Ubbaz6yRJGalQna4fo+XYZhPJGmk=;
        b=pC+yXeiZEHKohqwiUhgI50jXDbT4Q5KrOeOSduLhGekAcQ/GGoP1dxVXTUQWjhzZiO
         f47WuIP2xIp+Sbd+CyBmelxF99AaJQp8ZgZfefd/0bETBhMttxOaUFhKBSWyvf23z0JR
         spgyfGFVf1JmF0O/r1dZ4ZZmYgPzG1FEPo2YPfTCcdW/ke+OjeJzhjllafQ0WOsTUQAm
         wDDjQv0rjiO+zDoL9W6BU6G/l6kViNXZN8VfSSfkI4R8M7+7M5BJ9hWow+Ts8oN5IET6
         2jky/9JVmYP8WkTlVOSz7li8Z3Lx1BZ7DtBH7qHdMP4zVlWR0TpoyYPsihVE/ea+jH9i
         2edQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F0he9Q+Wbddv9A2Ubbaz6yRJGalQna4fo+XYZhPJGmk=;
        b=BNjDR+lPVE6XiBlXMm3NExzXuVaB4LtLu20w7pKjAgVVcQ4y/Ld8oR+r8m/hE7pOew
         e3a10yLWbVC3HdqZf42Z0krRXXfJnFk3qI1L1HLAFAns4xMnlgrmlESUvJvfxg7YLUbH
         Oh6T+IuBxEe3LkvSMJhu9Yi6NVly7efXYcjLqtRtCsZ7IqF0AiCyaJkEAOa9mfUBD7Tw
         xHuaHxxUWaNjAVv3n091hiXMahBfpLB+jwNX0LA2oMKnt/osRrmaeze9hVCsSxB6AXaD
         wwnDAgcrU7F4uvlZ0agLjaigfVYIfPkq/nR2io/h8nTKk7P8WyLK5xCHvVvdXf9iZj33
         VgOQ==
X-Gm-Message-State: AJcUukeokQ/EYO+svXN0ioBhtpcMv08iVH+ImojYqFJT4ZIMHYWCVdke
        JUDgPIOODwvhxoL/G3ra2Bujo8rtliysltxEPQnusw==
X-Google-Smtp-Source: ALg8bN4MxnTYUcq8wXq0nSn/1eEL/2IBbL0wLwPfdQyYePXNfSvWpd3phxZr0l73rC38HWra7j8eZZvNq6X3mgAhoZo=
X-Received: by 2002:a9d:6c44:: with SMTP id g4mr11929562otq.368.1547846788452;
 Fri, 18 Jan 2019 13:26:28 -0800 (PST)
MIME-Version: 1.0
References: <20190114220356.108916-1-ncrews@google.com> <20190114220356.108916-5-ncrews@google.com>
 <CAFqH_50wExmQ=4UUVx-7KKeFXH3WHEpbYDoxDe0-JsJtonge0w@mail.gmail.com>
In-Reply-To: <CAFqH_50wExmQ=4UUVx-7KKeFXH3WHEpbYDoxDe0-JsJtonge0w@mail.gmail.com>
From:   Nick Crews <ncrews@google.com>
Date:   Fri, 18 Jan 2019 14:26:17 -0700
Message-ID: <CAHX4x85oVkuJONxL6hUCX2G3=fNitYmRu7O6111eGC-bY0eddQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] platform/chrome: Add support for raw commands in sysfs
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Simon Glass <sjg@chromium.org>, dlaurie@chromium.org,
        Duncan Laurie <dlaurie@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric, thanks for the comments. I'll send out a new version soon,
with this moved to debugfs.

On Tue, Jan 15, 2019 at 12:37 PM Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
>
> Hi Nick,
>
> Missatge de Nick Crews <ncrews@google.com> del dia dl., 14 de gen.
> 2019 a les 23:07:
> >
> > From: Duncan Laurie <dlaurie@google.com>
> >
> > Add a sysfs attribute that allows sending raw commands to the EC.
> > This is useful for development and debug but should not be enabled
> > in a production environment.
> >
>
> Shouldn't you use debugfs for all this stuff instead?

Yes, I probably should. I've moved this all to there in the newest version.

>
>
> > > echo 00 f0 38 00 03 00 > /sys/bus/platform/devices/GOOG000C\:00/raw
> > > cat /sys/bus/platform/devices/GOOG000C\:00/raw
> > 00 37 33 38 65 64 00...
> >
> > Signed-off-by: Duncan Laurie <dlaurie@google.com>
> > Signed-off-by: Nick Crews <ncrews@google.com>
> > ---
> >
> > Changes in v2:
> > - Add sysfs documentation
> > - rm duplicate EC_MAILBOX_DATA_SIZE defs
> > - Make docstrings follow kernel style
> > - Fix tags in commit msg
> > - Reading raw now includes ASCII translation
> >
> >  .../ABI/testing/sysfs-platform-wilcoec        | 21 ++++
> >  drivers/platform/chrome/wilco_ec/Kconfig      |  9 ++
> >  drivers/platform/chrome/wilco_ec/legacy.c     | 99 +++++++++++++++++++
> >  drivers/platform/chrome/wilco_ec/legacy.h     | 46 +++++++++
> >  drivers/platform/chrome/wilco_ec/sysfs.c      |  6 ++
> >  5 files changed, 181 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-platform-wilcoec b/Documentation/ABI/testing/sysfs-platform-wilcoec
> > index 09552338c160..cac2cf11835f 100644
> > --- a/Documentation/ABI/testing/sysfs-platform-wilcoec
> > +++ b/Documentation/ABI/testing/sysfs-platform-wilcoec
> > @@ -24,3 +24,24 @@ Description:
> >                 off and remain off even if activated from the off state.
> >                 External monitors connected to the system are not affected.
> >                 In addition Wireless devices are turned off.
> > +
> > +What:          /sys/bus/platform/devices/GOOG000C\:00/raw
> > +Date:          January 2019
> > +KernelVersion: 4.19
> > +Description:
> > +               Write and read raw mailbox commands to the EC.
> > +
> > +               For writing:
> > +               Bytes 0-1 indicate the message type:
> > +                       00 F0 = Execute Legacy Command
> > +                       00 F2 = Read/Write NVRAM Property
> > +               Byte 2 provides the command code
> > +               Bytes 3+ consist of the data passed in the request
> > +
> > +               Example:
> > +               // Request EC info type 3 (EC firmware build date)
> > +               $ echo 00 f0 38 00 03 00 > raw
> > +               // View the result. The decoded ASCII result "12/21/18" is
> > +               // included after the raw hex.
> > +               $ cat raw
> > +               00 31 32 2f 32 31 2f 31 38 00 38 00 01 00 2f 00  .12/21/18.8...
> > diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
> > index f8e6c9e8c5cd..0bd84c98b79b 100644
> > --- a/drivers/platform/chrome/wilco_ec/Kconfig
> > +++ b/drivers/platform/chrome/wilco_ec/Kconfig
> > @@ -21,4 +21,13 @@ config WILCO_EC
> >           To compile this driver as a module, choose M here: the
> >           module will be called wilco_ec.
> >
> > +config WILCO_EC_SYSFS_RAW
> > +       bool "Enable raw access to EC via sysfs"
> > +       depends on WILCO_EC
> > +       help
> > +         If you say Y here, you get support for sending raw commands to
> > +         the Wilco EC via sysfs.  These commands do not do any byte
> > +         manipulation and allow for testing arbitrary commands.  This
> > +         interface is intended for debug only and is disabled by default.
> > +
> >  endif # WILCO_EC_PLATFORM
> > diff --git a/drivers/platform/chrome/wilco_ec/legacy.c b/drivers/platform/chrome/wilco_ec/legacy.c
> > index 1fdf94d22f57..79bac5dccb39 100644
> > --- a/drivers/platform/chrome/wilco_ec/legacy.c
> > +++ b/drivers/platform/chrome/wilco_ec/legacy.c
> > @@ -11,6 +11,105 @@
> >
> >  #include "legacy.h"
> >
> > +#ifdef CONFIG_WILCO_EC_SYSFS_RAW
> > +
> > +/* Raw data buffer, large enough to hold extended responses */
> > +static size_t raw_response_size;
> > +static u8 raw_response_data[EC_MAILBOX_DATA_SIZE_EXTENDED];
> > +
> > +ssize_t wilco_ec_raw_store(struct device *dev, struct device_attribute *attr,
> > +                          const char *buf, size_t count)
> > +{
> > +       struct wilco_ec_device *ec = dev_get_drvdata(dev);
> > +       struct wilco_ec_message msg;
> > +       u8 raw_request_data[EC_MAILBOX_DATA_SIZE];
> > +       int in_offset = 0;
> > +       int out_offset = 0;
> > +       int ret;
> > +
> > +       while (in_offset < count) {
> > +               char word_buf[EC_MAILBOX_DATA_SIZE];
> > +               u8 byte;
> > +               int start_offset = in_offset;
> > +               int end_offset;
> > +
> > +               /* Find the start of the byte */
> > +               while (buf[start_offset] && isspace(buf[start_offset]))
> > +                       start_offset++;
> > +               if (!buf[start_offset])
> > +                       break;
> > +
> > +               /* Find the start of the next byte, if any */
> > +               end_offset = start_offset;
> > +               while (buf[end_offset] && !isspace(buf[end_offset]))
> > +                       end_offset++;
> > +               if (start_offset > count || end_offset > count)
> > +                       break;
> > +               if (start_offset > EC_MAILBOX_DATA_SIZE ||
> > +                   end_offset > EC_MAILBOX_DATA_SIZE)
> > +                       break;
> > +
> > +               /* Copy to a new NULL terminated string */
> > +               memcpy(word_buf, buf + start_offset, end_offset - start_offset);
> > +               word_buf[end_offset - start_offset] = '\0';
> > +
> > +               /* Convert from hex string */
> > +               ret = kstrtou8(word_buf, 16, &byte);
> > +               if (ret)
> > +                       break;
> > +
> > +               /* Fill this byte into the request buffer */
> > +               raw_request_data[out_offset++] = byte;
> > +               if (out_offset >= EC_MAILBOX_DATA_SIZE)
> > +                       break;
> > +
> > +               in_offset = end_offset;
> > +       }
> > +       if (out_offset == 0)
> > +               return -EINVAL;
> > +
> > +       /* Clear response data buffer */
> > +       memset(raw_response_data, '\0', EC_MAILBOX_DATA_SIZE_EXTENDED);
> > +
> > +       msg.type = raw_request_data[0] << 8 | raw_request_data[1];
> > +       msg.flags = WILCO_EC_FLAG_RAW;
> > +       msg.command = raw_request_data[2];
> > +       msg.request_data = raw_request_data + 3;
> > +       msg.request_size = out_offset - 3;
> > +       msg.response_data = raw_response_data;
> > +       msg.response_size = EC_MAILBOX_DATA_SIZE;
> > +
> > +       /* Telemetry commands use extended response data */
> > +       if (msg.type == WILCO_EC_MSG_TELEMETRY) {
> > +               msg.flags |= WILCO_EC_FLAG_EXTENDED_DATA;
> > +               msg.response_size = EC_MAILBOX_DATA_SIZE_EXTENDED;
> > +       }
> > +
> > +       ret = wilco_ec_mailbox(ec, &msg);
> > +       if (ret < 0)
> > +               return ret;
> > +       raw_response_size = ret;
> > +       return count;
> > +}
> > +
> > +ssize_t wilco_ec_raw_show(struct device *dev, struct device_attribute *attr,
> > +                         char *buf)
> > +{
> > +       ssize_t count = 0;
> > +
> > +       if (raw_response_size) {
> > +               count = hex_dump_to_buffer(raw_response_data, raw_response_size,
> > +                                          16, 1, buf, PAGE_SIZE, true);
> > +
> > +               /* Only return response the first time it is read */
> > +               raw_response_size = 0;
> > +       }
> > +
> > +       return count;
> > +}
> > +
> > +#endif /* CONFIG_WILCO_EC_SYSFS_RAW */
> > +
> >  struct ec_info {
> >         u8 index;
> >         const char *label;
> > diff --git a/drivers/platform/chrome/wilco_ec/legacy.h b/drivers/platform/chrome/wilco_ec/legacy.h
> > index 5c857cb57fa9..340787d25d44 100644
> > --- a/drivers/platform/chrome/wilco_ec/legacy.h
> > +++ b/drivers/platform/chrome/wilco_ec/legacy.h
> > @@ -14,6 +14,52 @@
> >  #define EC_INFO_SIZE                   9
> >  #define EC_COMMAND_STEALTH_MODE                0xfc
> >
> > +#ifdef CONFIG_WILCO_EC_SYSFS_RAW
> > +
> > +/**
> > + * wilco_ec_raw_store() - Write a raw command to EC, store result to view later
> > + * @dev: Device representing the EC
> > + * @attr: The attribute in question
> > + * @buf: Input buffer, format explained below
> > + * @count: Number of bytes in input buffer
> > + *
> > + * Bytes 0-1 indicate the message type:
> > + *  00 F0 = Execute Legacy Command
> > + *  00 F2 = Read/Write NVRAM Property
> > + * Byte 2 provides the command code
> > + * Bytes 3+ consist of the data passed in the request
> > + *
> > + * example: read the EC info type 3 (EC firmware build date):
> > + *  # echo 00 f0 38 00 03 00 > raw
> > + *
> > + * After calling this function, read the result by using raw_show()
> > + *
> > + * Return: Number of bytes consumed from input, negative error code on failure
> > + */
> > +ssize_t wilco_ec_raw_store(struct device *dev, struct device_attribute *attr,
> > +                          const char *buf, size_t count);
> > +
> > +/**
> > + * wilco_ec_raw_show() - Show result from previous call to raw_store()
> > + * @dev: Device representing the EC
> > + * @attr: The attribute in question
> > + * @buf: Output buffer to be filled
> > + *
> > + * Example usage:
> > + *     // Call raw_store(), read EC info type 3 (EC firmware build date)
> > + *     # echo 00 f0 38 00 03 00 > raw
> > + *     // Call this function, view the result. The decoded ASCII result
> > + *     // "12/21/18" is included after the raw hex.
> > + *     # cat raw
> > + *     00 31 32 2f 32 31 2f 31 38 00 38 00 01 00 2f 00  .12/21/18.8.../.
> > + *
> > + * Return: Number of bytes written to output, negative error code on failure
> > + */
> > +ssize_t wilco_ec_raw_show(struct device *dev, struct device_attribute *attr,
> > +                         char *buf);
> > +
> > +#endif /* CONFIG_WILCO_EC_SYSFS_RAW */
> > +
> >  /**
> >   * wilco_ec_version_show() - Display Wilco Embedded Controller version info
> >   *
> > diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
> > index e78a3ec3506b..0611a73fcdce 100644
> > --- a/drivers/platform/chrome/wilco_ec/sysfs.c
> > +++ b/drivers/platform/chrome/wilco_ec/sysfs.c
> > @@ -28,9 +28,15 @@ __ATTR(_name, 0644, wilco_ec_##_name##_show, wilco_ec_##_name##_store)
> >  /* Make top-level attributes, which will live inside GOOG000C:00/ */
> >  static struct device_attribute version_attr = WILCO_EC_ATTR_RO(version);
> >  static struct device_attribute stealth_attr = WILCO_EC_ATTR_WO(stealth_mode);
> > +#ifdef CONFIG_WILCO_EC_SYSFS_RAW
> > +static struct device_attribute raw_attr = WILCO_EC_ATTR_RW(raw);
> > +#endif
> >  static struct attribute *wilco_ec_toplevel_attrs[] = {
> >         &version_attr.attr,
> >         &stealth_attr.attr,
> > +#ifdef CONFIG_WILCO_EC_SYSFS_RAW
> > +       &raw_attr.attr,
> > +#endif
> >         NULL
> >  };
> >  ATTRIBUTE_GROUPS(wilco_ec_toplevel);
> > --
> > 2.20.1.97.g81188d93c3-goog
> >

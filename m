Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB8DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DCA20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DCA20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeH3LTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:19:19 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33658 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbeH3LTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:19:19 -0400
Received: by mail-qk0-f178.google.com with SMTP id z78-v6so5123970qka.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 00:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IiZxBNjxW+DaKGchM85AzbdML9Ok520SR2CkdBPCFRM=;
        b=BecN/nMZcGFczZLK96OrbItIL4t22ZFfZ9E8+GJZjRuIOloRDqzCsVaPIXJzinIzSk
         vkqI1QKW0jQnn2SEfH1t2YNtWy/zlHim9cT7iQMeuJjbNjFceAbtZqYIfGVr1lDlOh0Y
         99P4LOksoYWoorADhqBOHCbIDbkml89oBt6Wdk/RUggTa5mJAxoLS+t6fwPqqJQUxcpB
         5GWLLy9DpOzTe9n0tA1uYiPZn4393o6Zy/5MV7EWsRw4tPV5pxKHXiznHdzOAJMOLnXX
         yOJnMctPZOYnuK/Rs/YqQpEKoRaPTMmsJny3cg30zS9L2lGxpftQs8SkyZB8PmkcEiKG
         aPRQ==
X-Gm-Message-State: APzg51BoFF7j+iBCKgRIByOiDkUJEJJVkplPEeESLkB1CZNuA7s/ccoA
        K0b5ccO18GiRtpqSM1ULZv+ahxe0Ue/Ame/pYqUPoQ==
X-Google-Smtp-Source: ANB0Vda8ceDry5Dn51xNEPqULALjYvWJUTx5HuAs8O2Jzo0vJ8XPzlLbCCDPov+0uUf7lSJci7E0v7vS5EWZGX3TVNc=
X-Received: by 2002:a37:a05:: with SMTP id 5-v6mr9934714qkk.325.1535613513945;
 Thu, 30 Aug 2018 00:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180823183057.247630-1-hcutts@chromium.org> <20180823183057.247630-4-hcutts@chromium.org>
 <CAO-hwJ+rR8ft96AGjoEApr1ZkythKfcxjVzdULzgpRy-aRv_vg@mail.gmail.com> <CA+jURcvguwXAVnpQ9+84QQOaJG74oeV8U4zzM1X0UabaY5DJBQ@mail.gmail.com>
In-Reply-To: <CA+jURcvguwXAVnpQ9+84QQOaJG74oeV8U4zzM1X0UabaY5DJBQ@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 30 Aug 2018 09:18:22 +0200
Message-ID: <CAO-hwJ+tb6XdEM76r0jxBfCx2r_PqQp9T5=A2ALociyHOKUeMg@mail.gmail.com>
Subject: Re: [PATCH 3/3] Enable high-resolution scrolling on Logitech mice
To:     hcutts@chromium.org, Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harry,

On Thu, Aug 30, 2018 at 1:06 AM Harry Cutts <hcutts@chromium.org> wrote:
>
> Hi Benjamin,
>
> On Tue, 28 Aug 2018 at 01:47, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> > On Thu, Aug 23, 2018 at 8:31 PM Harry Cutts <hcutts@chromium.org> wrote:
> > > [snip]
> > > @@ -400,32 +409,53 @@ static void hidpp_prefix_name(char **name, int name_length)
> > >  #define HIDPP_SET_LONG_REGISTER                                0x82
> > >  #define HIDPP_GET_LONG_REGISTER                                0x83
> > >
> > > -#define HIDPP_REG_GENERAL                              0x00
> > > -
> > > -static int hidpp10_enable_battery_reporting(struct hidpp_device *hidpp_dev)
> > > +/**
> > > + * hidpp10_set_register_bit() - Sets a single bit in a HID++ 1.0 register.
> > > + * @hidpp_dev: the device to set the register on.
> > > + * @register_address: the address of the register to modify.
> > > + * @byte: the byte of the register to modify. Should be less than 3.
> > > + * Return: 0 if successful, otherwise a negative error code.
> > > + */
> > > +static int hidpp10_set_register_bit(struct hidpp_device *hidpp_dev,
> > > +       u8 register_address, u8 byte, u8 bit)
> > >  {
> > >         struct hidpp_report response;
> > >         int ret;
> > >         u8 params[3] = { 0 };
> > >
> > >         ret = hidpp_send_rap_command_sync(hidpp_dev,
> > > -                                       REPORT_ID_HIDPP_SHORT,
> > > -                                       HIDPP_GET_REGISTER,
> > > -                                       HIDPP_REG_GENERAL,
> > > -                                       NULL, 0, &response);
> > > +                                         REPORT_ID_HIDPP_SHORT,
> > > +                                         HIDPP_GET_REGISTER,
> > > +                                         register_address,
> > > +                                         NULL, 0, &response);
> > >         if (ret)
> > >                 return ret;
> > >
> > >         memcpy(params, response.rap.params, 3);
> > >
> > > -       /* Set the battery bit */
> > > -       params[0] |= BIT(4);
> > > +       params[byte] |= BIT(bit);
> > >
> > >         return hidpp_send_rap_command_sync(hidpp_dev,
> > > -                                       REPORT_ID_HIDPP_SHORT,
> > > -                                       HIDPP_SET_REGISTER,
> > > -                                       HIDPP_REG_GENERAL,
> > > -                                       params, 3, &response);
> > > +                                          REPORT_ID_HIDPP_SHORT,
> > > +                                          HIDPP_SET_REGISTER,
> > > +                                          register_address,
> > > +                                          params, 3, &response);
> > > +}
> > > +
> > > +
> > > +#define HIDPP_REG_GENERAL                              0x00
> > > +
> > > +static int hidpp10_enable_battery_reporting(struct hidpp_device *hidpp_dev)
> > > +{
> > > +       return hidpp10_set_register_bit(hidpp_dev, HIDPP_REG_GENERAL, 0, 4);
> > > +}
> >
> > This hunk should be dealt in a separate patch (including the one function below)
>
> OK, will do in v2.
>
> > > [snip]
> > > @@ -2399,7 +2524,8 @@ static int m560_raw_event(struct hid_device *hdev, u8 *data, int size)
> > >                 input_report_rel(mydata->input, REL_Y, v);
> > >
> > >                 v = hid_snto32(data[6], 8);
> > > -               input_report_rel(mydata->input, REL_WHEEL, v);
> > > +               hid_scroll_counter_handle_scroll(
> > > +                               &hidpp->vertical_wheel_counter, v);
> >
> > The conversion input_report_rel(... REL_WHEEL,...) to
> > hid_scroll_counter_handle_scroll() should be dealt in a separate
> > patch.
>
> OK, I'll do that in v2, but might I ask why? I don't see how this
> particular hunk is special.

I tend to consider that existing code rewrite need to be in their
special commit, especially if the change isn't supposed to change the
behaviour. This is my personal taste in case something goes wrong and
(in this case) a m560 suddenly starts complaining about an issue with
this mouse.
I wouldn't mind too much if you rather keep the
hid_scroll_counter_handle_scroll() introduction to this commit though.

>
> >
> > >
> > >                 input_sync(mydata->input);
> > >         }
> > > @@ -2527,6 +2653,71 @@ static int g920_get_config(struct hidpp_device *hidpp)
> > >         return 0;
> > >  }
> > >
> > > +/* -------------------------------------------------------------------------- */
> > > +/* High-resolution scroll wheels                                              */
> > > +/* -------------------------------------------------------------------------- */
> > > +
> > > +/**
> > > + * struct hi_res_scroll_info - Stores info on a device's high-res scroll wheel.
> > > + * @product_id: the HID product ID of the device being described.
> > > + * @mm256_per_hi_res_unit: the distance moved by the user's finger for each
> > > + *                         high-resolution unit reported by the device, in
> > > + *                         256ths of a millimetre.
> > > + */
> > > +struct hi_res_scroll_info {
> > > +       __u32 product_id;
> > > +       int mm256_per_hi_res_unit;
> > > +};
> > > +
> > > +static struct hi_res_scroll_info hi_res_scroll_devices[] = {
> > > +       { /* Anywhere MX */
> > > +         .product_id = 0x1017, .mm256_per_hi_res_unit = 114 },
> > > +       { /* Performance MX */
> > > +         .product_id = 0x101a, .mm256_per_hi_res_unit = 104 },
> > > +       { /* M560 */
> > > +         .product_id = 0x402d, .mm256_per_hi_res_unit = 111 },
> > > +       { /* MX Master 2S */
> > > +         .product_id = 0x4069, .mm256_per_hi_res_unit = 104 },
> > > +       { .product_id = USB_DEVICE_ID_LOGITECH_MOUSE_MX_MASTER_2S_BT,
> > > +         .mm256_per_hi_res_unit = 104 },
> > > +};
> > > +
> > > +static int hi_res_scroll_look_up_mm256(__u32 product_id)
> > > +{
> > > +       int i;
> > > +       int num_devices = sizeof(hi_res_scroll_devices)
> > > +                         / sizeof(hi_res_scroll_devices[0]);
> > > +       for (i = 0; i < num_devices; i++) {
> > > +               if (hi_res_scroll_devices[i].product_id == product_id)
> > > +                       return hi_res_scroll_devices[i].mm256_per_hi_res_unit;
> > > +       }
> > > +       return 104;
> >
> > 104?
>
> This seems like a sensible default value in case we don't have a value
> for this mouse in hi_res_scroll_devices. I'll add a comment explaining
> this in v2.
>
> >
> > > [snip]
> > > +static int hidpp_event(struct hid_device *hdev, struct hid_field *field,
> > > +       struct hid_usage *usage, __s32 value)
> > > +{
> > > +       struct hidpp_device *hidpp = hid_get_drvdata(hdev);
> > > +       struct hid_scroll_counter *counter = &hidpp->vertical_wheel_counter;
> > > +
> > > +       /* A scroll event may occur before the multiplier has been retrieved or
> > > +        * the input device set, or high-res scroll enabling may fail. In such
> > > +        * cases we must return early (falling back to default behaviour) to
> > > +        * avoid a crash in hid_scroll_counter_handle_scroll.
> > > +        */
> > > +       if (!(hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL) || value == 0
> > > +           || counter->dev == NULL || counter->resolution_multiplier == 0)
> > > +               return 0;
> >
> > You are using usage_table to force the .event function to be called
> > only on the WHEEL events. This is correct, but I have a feeling this
> > will be harder to understand when we are going to extend the .event()
> > function for other events.
> > If you rather keep the cde that way, please add a comment at the
> > beginning of the function stating that we are only called against
> > WHEEL events because of usage_table.
>
> OK, I'll add the comment in v2.
>
> > > [snip]
> > >
> > > +#define LDJ_DEVICE(product) \
> > > +       HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE, \
> > > +                  USB_VENDOR_ID_LOGITECH, (product))
> > > +
> > >  static const struct hid_device_id hidpp_devices[] = {
> > >         { /* wireless touchpad */
> > > -         HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
> > > -               USB_VENDOR_ID_LOGITECH, 0x4011),
> > > +         LDJ_DEVICE(0x4011),
> > >           .driver_data = HIDPP_QUIRK_CLASS_WTP | HIDPP_QUIRK_DELAYED_INIT |
> > >                          HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS },
> > >         { /* wireless touchpad T650 */
> > > -         HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
> > > -               USB_VENDOR_ID_LOGITECH, 0x4101),
> > > +         LDJ_DEVICE(0x4101),
> >
> > The rewrite of the existing supported devices should be in a separate patch too.
>
> OK, will do.
>
> > > [snip]
> > > diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> > > index 249d49b6b16c..7926c275f258 100644
> > > --- a/drivers/hid/hid-quirks.c
> > > +++ b/drivers/hid/hid-quirks.c
> > > @@ -463,6 +463,17 @@ static const struct hid_device_id hid_have_special_driver[] = {
> > >  #endif
> > >  #if IS_ENABLED(CONFIG_HID_LOGITECH_HIDPP)
> > >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_T651) },
> > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_M336_337_535_BT1) },
> > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_M336_337_535_BT2) },
> > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_M720_BT) },
> > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_MX_ANYWHERE_2_BT1) },
> > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_MX_ANYWHERE_2_BT2) },
> > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_MX_ANYWHERE_2_BT3) },
> > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_MX_ANYWHERE_2S_BT) },
> > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_MX_MASTER_BT1) },
> > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_MX_MASTER_BT2) },
> > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_MX_MASTER_BT3) },
> > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_MX_MASTER_2S_BT) },
> >
> > Since v4.16, this should not be required anymore. Please drop the hunk
> > if I am correct.
>
> Yes, it seems to work fine without it (at least for the MX Master 2S).
> Unfortunately, while testing this I encountered a bug with high-res
> scrolling over Bluetooth. (It seems that if you turn off the MX Master
> 2S while it's connected over Bluetooth, we don't detect that and
> remove the input device, meaning that when it reconnects the driver
> thinks it's in high-res mode but the mouse is in low-res.) I'm
> investigating, but in the meantime I'll remove the Bluetooth support
> from v2 and add it back in later.

As far as I can see, the MX Master 2S is connected over BLE. Bluez
keeps the uhid node opened (and thus the existing bluetooth HID
device) to be able to reconnect faster.
I would suppose you should get notified in the connect event of a
reconnection, but it doesn't seem to be the case.

Nestor, is there any event emitted by the mouse when it gets
reconnected over BLE or is that a bluez issue?

Cheers,
Benjamin

>
> >
> > Cheers,
> > Benjamin
> >
> > >         { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL) },
> > >  #endif
> > >  #if IS_ENABLED(CONFIG_HID_LOGITECH_DJ)
> > > --
> > > 2.18.0.1017.ga543ac7ca45-goog
> > >
>
> Thanks,
>
> Harry Cutts
> Chrome OS Touch/Input team

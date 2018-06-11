Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qXcZGE6WHltFNgAAmS7hNA
	; Mon, 11 Jun 2018 15:34:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 62E0F607E4; Mon, 11 Jun 2018 15:34:36 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuCKFqhY"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7411E607BB;
	Mon, 11 Jun 2018 15:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7411E607BB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932903AbeFKPee (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932433AbeFKPeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:34:31 -0400
Received: from mail-io0-f170.google.com (mail-io0-f170.google.com [209.85.223.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68A08208B3;
        Mon, 11 Jun 2018 15:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528731270;
        bh=vs/Lw80umkzo8t2vza/vTMzI1eOxDFM9SJWcFZJhNPQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=YuCKFqhYDIdL1Za3yfLoTc4LwngdH6spqAnyjGQzJXlk78uTKa7Ynd44zxevm8+zL
         hbQHdaqYcXQXQESyFXrrwY2BDqxkV0lcTG24cJVt4M6lpNZ21FbsGmYARSgFRM6+SJ
         g1I7i8Kl5qx84xToFvd7JWTI2+RvCRPvp/+aJkW4=
Received: by mail-io0-f170.google.com with SMTP id g22-v6so24364085iob.7;
        Mon, 11 Jun 2018 08:34:30 -0700 (PDT)
X-Gm-Message-State: APt69E18kOCk1RC3bFAfafcG7kpFq3782OOvHLRZkJHUEgmb+8g3sh4s
        Z5ewYkq4QEqL/mRV2Ud9YwY+QaiwjnJJ73lBSw==
X-Google-Smtp-Source: ADUXVKLyl2EUw9ExbF1wBpsAAOXesVlK75GZxEc0KUODEdwFYuZK4VvqqclC0lZ+JjveXvVtQZ9Q/42c1hIN+5t9BlE=
X-Received: by 2002:a6b:bd47:: with SMTP id n68-v6mr14972500iof.111.1528731269784;
 Mon, 11 Jun 2018 08:34:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 08:34:09
 -0700 (PDT)
In-Reply-To: <CAMoM21HshLyv+Np1vOKYTAunsPCazyP-WESiaheNXHsC078S8g@mail.gmail.com>
References: <280FCB2C-6DF1-4790-A89F-AF5BE3513AE5@holtmann.org>
 <20180608162009.22762-1-attitokes@gmail.com> <CAL_JsqKGeCEBBLNQNdymQovknRM7zt4+nNJy0YSkxRicOxkCSg@mail.gmail.com>
 <CAMoM21HshLyv+Np1vOKYTAunsPCazyP-WESiaheNXHsC078S8g@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 11 Jun 2018 09:34:09 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+a93Rpf3UAPBQ5QmA8KavberGXz76WCiZ7feHH5GgcDA@mail.gmail.com>
Message-ID: <CAL_Jsq+a93Rpf3UAPBQ5QmA8KavberGXz76WCiZ7feHH5GgcDA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm: Configure SCO routing automatically
To: =?UTF-8?B?QXR0aWxhIFTFkWvDqXM=?= <attitokes@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Artiom Vaskov <velemas@gmail.com>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 9, 2018 at 12:26 AM, Attila T=C5=91k=C3=A9s <attitokes@gmail.co=
m> wrote:
> Hello Rob,
>
> On Fri, Jun 8, 2018 at 8:25 PM, Rob Herring <robh+dt@kernel.org> wrote:
>>
>> On Fri, Jun 8, 2018 at 10:20 AM,  <attitokes@gmail.com> wrote:
>> > From: Attila T=C5=91k=C3=A9s <attitokes@gmail.com>
>> >
>> > Added support to automatically configure the SCO packet routing at the
>> > device setup. The SCO packets are used with the HSP / HFP profiles, bu=
t in
>> > some devices (ex. CYW43438) they are routed to a PCM output by default=
. This
>> > change allows sending the vendor specific HCI command to configure the=
 SCO
>> > routing. The parameters of the command are loaded from the device tree=
.
>>
>> Please wrap your commit msg.
>
>
> Sure.
>>
>>
>> >
>> > Signed-off-by: Attila T=C5=91k=C3=A9s <attitokes@gmail.com>
>> > ---
>> >  .../bindings/net/broadcom-bluetooth.txt       |  7 ++
>>
>> Please split bindings to separate patch.
>
>
> Ok, I will split this in two.
>>
>>
>>
>>
>> >  drivers/bluetooth/hci_bcm.c                   | 72 ++++++++++++++++++=
+
>> >  2 files changed, 79 insertions(+)
>> >
>> > diff --git
>> > a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>> > b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>> > index 4194ff7e..aea3a094 100644
>> > --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>> > +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>> > @@ -21,6 +21,12 @@ Optional properties:
>> >   - clocks: clock specifier if external clock provided to the controll=
er
>> >   - clock-names: should be "extclk"
>> >
>> > + SCO routing parameters:
>> > + - sco-routing: 0-3 (PCM, Transport, Codec, I2S)
>> > + - pcm-interface-rate: 0-4 (128 Kbps - 2048 Kbps)
>> > + - pcm-frame-type: 0 (short), 1 (long)
>> > + - pcm-sync-mode: 0 (slave), 1 (master)
>> > + - pcm-clock-mode: 0 (slave), 1 (master)
>>
>> Are these Broadcom specific? Properties need either vendor prefix or
>> to be documented in a common location. I think these look like the
>> latter.
>
>
> These will be used as parameters of a vendor specific (Broadcom/Cypress)
> command configuring the SCO packet routing. See the Write_SCO_PCM_Int_Par=
am
> command from: http://www.cypress.com/file/298311/download.

The DT should just describe how the h/w is hooked-up. What the s/w has
to do based on that is the driver's problem which is certainly
vendor/chip specific, but that is all irrelevant to the binding.

> What would be the property names with a Broadcom / Cypress vendor prefix?
>
>     brcm,sco-routing
>     brcm,pcm-interface-rate
>     brcm,pcm-frame-type
>     brcm,pcm-sync-mode
>     brcm,pcm-clock-mode
>
> ?

Yes.

>
>>
>>
>> However, this also looks incomplete to me. For example, which SoC
>> I2S/PCM port is BT audio connected to and how does it fit into the
>> existing audio related bindings? There's been work on HDMI audio
>> bindings which would be similar (except for the SCO over UART at
>> least).
>
>
> The I2S / PCM pins of the Bluetooth chip most likely will not be connecte=
d
> to the host SoC. When used with a SoC we probably want tor route the SCO
> packets over the UART transport. A2DP data already goes here and we proba=
bly
> want the same for HSP / HFP.

Then that should be the default with no properties.

I imagine for phones, vendors want I2S hooked up for voice calls so
audio can be routed directly to/from the modem and the power hungry
apps processor can be kept in low power modes.

> For example in the Raspberry Pi 3 B, the CYW43438's PCM output is not
> connected (there is no I2S output), But it may be connected to any other
> device in other hardware.
>
> The purpose of this command is to tell the BT chip where to send the SCO
> packets. From the driver's perspective, it does not really matters where
> these pins are connected.

Bindings are for h/w description (and config to some extent).


>> >  Example:
>> >
>> > @@ -31,5 +37,6 @@ Example:
>> >         bluetooth {
>> >                 compatible =3D "brcm,bcm43438-bt";
>> >                 max-speed =3D <921600>;
>> > +               sco-routing =3D <1>; /* 1 =3D transport (UART) */
>> >         };
>> >  };
>> > diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>> > index ddbd8c6a..0e729534 100644
>> > --- a/drivers/bluetooth/hci_bcm.c
>> > +++ b/drivers/bluetooth/hci_bcm.c
>> > @@ -83,6 +83,16 @@
>> >   * @hu: pointer to HCI UART controller struct,
>> >   *     used to disable flow control during runtime suspend and system
>> > sleep
>> >   * @is_suspended: whether flow control is currently disabled
>> > + *
>> > + *  SCO routing parameters:
>> > + *   used as the parameters for the bcm_set_pcm_int_params command
>> > + *     @sco_routing:
>> > + *      >=3D 255 (skip SCO routing configuration)
>> > + *      0-3 (PCM, Transport, Codec, I2S)
>> > + *     @pcm_interface_rate: 0-4 (128 Kbps - 2048 Kbps)
>> > + *     @pcm_frame_type: 0 (short), 1 (long)
>> > + *     @pcm_sync_mode: 0 (slave), 1 (master)
>> > + *     @pcm_clock_mode: 0 (slave), 1 (master)
>> >   */
>> >  struct bcm_device {
>> >         /* Must be the first member, hci_serdev.c expects this. */
>> > @@ -114,6 +124,13 @@ struct bcm_device {
>> >         struct hci_uart         *hu;
>> >         bool                    is_suspended;
>> >  #endif
>> > +
>> > +       /* SCO routing parameters */
>> > +       u8                      sco_routing;
>> > +       u8                      pcm_interface_rate;
>> > +       u8                      pcm_frame_type;
>> > +       u8                      pcm_sync_mode;
>> > +       u8                      pcm_clock_mode;
>> >  };
>> >
>> >  /* generic bcm uart resources */
>> > @@ -189,6 +206,40 @@ static int bcm_set_baudrate(struct hci_uart *hu,
>> > unsigned int speed)
>> >         return 0;
>> >  }
>> >
>> > +static int bcm_configure_sco_routing(struct hci_uart *hu, struct
>> > bcm_device *bcm_dev)
>> > +{
>> > +       struct hci_dev *hdev =3D hu->hdev;
>> > +       struct sk_buff *skb;
>> > +       struct bcm_set_pcm_int_params params;
>> > +
>> > +       if (bcm_dev->sco_routing >=3D 0xff) {
>> > +               /* SCO routing configuration should be skipped */
>> > +               return 0;
>> > +       }
>> > +
>> > +       bt_dev_dbg(hdev, "BCM: Configuring SCO routing (%d %d %d %d
>> > %d)",
>> > +                       bcm_dev->sco_routing,
>> > bcm_dev->pcm_interface_rate, bcm_dev->pcm_frame_type,
>> > +                       bcm_dev->pcm_sync_mode,
>> > bcm_dev->pcm_clock_mode);
>> > +
>> > +       params.routing =3D bcm_dev->sco_routing;
>> > +       params.rate =3D bcm_dev->pcm_interface_rate;
>> > +       params.frame_sync =3D bcm_dev->pcm_frame_type;
>> > +       params.sync_mode =3D bcm_dev->pcm_sync_mode;
>> > +       params.clock_mode =3D bcm_dev->pcm_clock_mode;
>> > +
>> > +       /* Send the SCO routing configuration command */
>> > +       skb =3D __hci_cmd_sync(hdev, 0xfc1c, sizeof(params), &params,
>> > HCI_CMD_TIMEOUT);
>> > +       if (IS_ERR(skb)) {
>> > +               int err =3D PTR_ERR(skb);
>> > +               bt_dev_err(hdev, "BCM: failed to configure SCO routing
>> > (%d)", err);
>> > +               return err;
>> > +       }
>> > +
>> > +       kfree_skb(skb);
>> > +
>> > +       return 0;
>> > +}
>> > +
>> >  /* bcm_device_exists should be protected by bcm_device_lock */
>> >  static bool bcm_device_exists(struct bcm_device *device)
>> >  {
>> > @@ -534,6 +585,9 @@ static int bcm_setup(struct hci_uart *hu)
>> >                         host_set_baudrate(hu, speed);
>> >         }
>> >
>> > +       /* Configure SCO routing if needed */
>> > +       bcm_configure_sco_routing(hu, bcm->dev);
>> > +
>> >  finalize:
>> >         release_firmware(fw);
>> >
>> > @@ -1004,9 +1058,21 @@ static int bcm_acpi_probe(struct bcm_device *de=
v)
>> >  }
>> >  #endif /* CONFIG_ACPI */
>> >
>> > +static void read_u8_device_property(struct device *device, const char
>> > *property, u8 *destination) {
>> > +       u32 temp;
>> > +       if (device_property_read_u32(device, property, &temp) =3D=3D 0=
) {
>> > +               *destination =3D temp & 0xff;
>> > +       }
>> > +}
>> > +
>> >  static int bcm_of_probe(struct bcm_device *bdev)
>> >  {
>> >         device_property_read_u32(bdev->dev, "max-speed",
>> > &bdev->oper_speed);
>> > +       read_u8_device_property(bdev->dev, "sco-routing",
>> > &bdev->sco_routing);
>> > +       read_u8_device_property(bdev->dev, "pcm-interface-rate",
>> > &bdev->pcm_interface_rate);
>> > +       read_u8_device_property(bdev->dev, "pcm-frame-type",
>> > &bdev->pcm_frame_type);
>> > +       read_u8_device_property(bdev->dev, "pcm-sync-mode",
>> > &bdev->pcm_sync_mode);
>> > +       read_u8_device_property(bdev->dev, "pcm-clock-mode",
>> > &bdev->pcm_clock_mode);
>>
>> These are actually broken because the DT properties are 32-bit.
>>
> The properties from device tree are read as 32-bit values, then they are
> truncated to 8-bit (see the read_u8_device_property function above). Is
> anything wrong with this?
Ah, NM, I missed the wrapper.

Rob

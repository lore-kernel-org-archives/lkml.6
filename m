Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1541532-1524703315-2-12952275444860812934
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES daensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524703314; b=PT3G4t5+FkmQGAW/epgx1JDpAIkqMeoFsPKmTqKGt1iA2bcg2f
    rsuPNzxV2iMLB9e90Hd1w/yUzzzu7ntJW0eV9eeeNYOyhmMQzHz828rVXo3mEA3L
    EFldFrq1qddNI4w8gH98+4EMPXZ5wqTCU1goB6IU86Vgv2nIkbKqlW/+cSruoBpL
    AMUgJZLOB2N7a6hw0G++JfxI07BntmnWB8pR1qbyVgKVexE/2WZW/lIPSsKB5h76
    oGPlFkjRNqFALwMrAF4PA46cvni1t5kcNjF7QGDvfSfRQRwkamGNwDIVbRw6TSo5
    AGCKfTxYs/e3udIk6xauNJmk9B5onupvUq/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524703314; bh=AndC0lXkcx32HT8VWHzpN5MxOekXEZU/4v/q1WRVYW
    Q=; b=pJqbvrgj67EtDkfamWo2AAsNDtMdZPJ2HPdGPBEwhMqjR2iX31mGnJ19+S
    z0ZzFHBQ9JL7mEYwvLVP3m91dA4hcqhi0khR5UxOT63K/r5blVvHGGw6OFgwHD6t
    Bu9+BjzLcQFPQy4N5XFKtuwTp21Ds2iVqJwi0pepMDVttIQhalJAf5XDv144UKKZ
    NbpDyY7i6sMuxeQojMGVNd1HR5hNBWqzXos0XNSpwR9tAnoy9E8j9SGza3edU9WM
    9HKsoPPUr+a+gjMjxqeibl+hCePyWSPf/XhjkP1dAX6hFCsbP/KGPACmW1tFLoim
    vXuBDwZzUi4Kc7QauzvyJndyQqxQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=JSpL2NJT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=Mrau0NpN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rBevKX+f;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=JSpL2NJT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=Mrau0NpN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rBevKX+f;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFTTgdNgghGOCjRHg/MKW8MosobbiNDw/GVXBhxJVzKNkmmMIhAk4luIiMKFdHJ3SE6XlRjdBQ5B083L7bMkubNvJe7WA85K19RMi+17KrN2fBKj/xSM
    O6+Y+APvIFXbz+iAq2LYxu1CcRHfoV72MYVD8TrpXxmcoMzk0pU6H+ERIrn6WeMvYDC9EpTqN4y8Sxb1QLnje3BTHKhOt6POWCFscdFfQBJIpTE7kmjvqJwN
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=J1Y8HTJGAAAA:8 a=Oh2cFVv5AAAA:8
    a=enmlZl3n62gfH4RcvNgA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=7KeoIwV6GZqOttXkcoxL:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753505AbeDZAlk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 20:41:40 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54614 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753178AbeDZAlc (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 25 Apr 2018 20:41:32 -0400
X-Google-Smtp-Source: AIpwx4/p6oXCIBjgybg2PFERb+cUmB95/nXpCF/Gd56Zf2aQm8Uvk18xAh3sNC1F1TallWMcugMb36OoyGxqmbY7gIE=
MIME-Version: 1.0
In-Reply-To: <1524650077-13270-1-git-send-email-krzk@kernel.org>
References: <1524650077-13270-1-git-send-email-krzk@kernel.org>
From: Grant Grundler <grundler@chromium.org>
Date: Wed, 25 Apr 2018 17:41:30 -0700
X-Google-Sender-Auth: 1UiDqbBPcUdtwaUIihSCwLl3S1Q
Message-ID: <CANEJEGu6Yi=0inHaYxDmB5gsPXdtRjEXvm0Q6gJC8y0r9D7W_A@mail.gmail.com>
Subject: Re: [PATCH stable v4.4+] r8152: add Linksys USB3GIGV1 id
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Oliver Neukum <oliver@neukum.org>,
        "David S. Miller" <davem@davemloft.net>, linux-usb@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Grant Grundler <grundler@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 2:54 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> commit 90841047a01b452cc8c3f9b990698b264143334a upstream
>
> This linksys dongle by default comes up in cdc_ether mode.
> This patch allows r8152 to claim the device:
>    Bus 002 Device 002: ID 13b1:0041 Linksys
>
> Signed-off-by: Grant Grundler <grundler@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> [krzk: Rebase on v4.4]
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

thanks krzk!

FTR, to support RTL8153B (HW ID 0x6010), the follow patch series to
bring r8152 v1.09.9 driver from 4.14 kernel.org to 3 (of 5) older
Chrome OS kernels:

3.14: https://chromium-review.googlesource.com/q/topic:%22update_r8152-3.14%22+(status:open%20OR%20status:merged)
3.18: https://chromium-review.googlesource.com/q/topic:%2522update-r8152-3.18%2522+(status:open+OR+status:merged)
4.4: https://chromium-review.googlesource.com/q/topic:%2522update_r8152-4.4%2522+(status:open+OR+status:merged)

caveat: These series are not suitable directly for kernel.org
submission (extraneous stuff in the commit messages, order is
different). Using the original SHA1 (in each commit message), this can
all be fixed up by hand/simple scripts.

cheers,
grant


> ---
>  drivers/net/usb/cdc_ether.c | 10 ++++++++++
>  drivers/net/usb/r8152.c     |  2 ++
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
> index 6578127db847..f71abe50ea6f 100644
> --- a/drivers/net/usb/cdc_ether.c
> +++ b/drivers/net/usb/cdc_ether.c
> @@ -461,6 +461,7 @@ static const struct driver_info wwan_info = {
>  #define REALTEK_VENDOR_ID      0x0bda
>  #define SAMSUNG_VENDOR_ID      0x04e8
>  #define LENOVO_VENDOR_ID       0x17ef
> +#define LINKSYS_VENDOR_ID      0x13b1
>  #define NVIDIA_VENDOR_ID       0x0955
>  #define HP_VENDOR_ID           0x03f0
>
> @@ -650,6 +651,15 @@ static const struct usb_device_id  products[] = {
>         .driver_info = 0,
>  },
>
> +#if IS_ENABLED(CONFIG_USB_RTL8152)
> +/* Linksys USB3GIGV1 Ethernet Adapter */
> +{
> +       USB_DEVICE_AND_INTERFACE_INFO(LINKSYS_VENDOR_ID, 0x0041, USB_CLASS_COMM,
> +                       USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE),
> +       .driver_info = 0,
> +},
> +#endif
> +
>  /* Lenovo Thinkpad USB 3.0 Ethernet Adapters (based on Realtek RTL8153) */
>  {
>         USB_DEVICE_AND_INTERFACE_INFO(LENOVO_VENDOR_ID, 0x7205, USB_CLASS_COMM,
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 89950f5cea71..b2c1a435357f 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -506,6 +506,7 @@ enum rtl8152_flags {
>  #define VENDOR_ID_REALTEK              0x0bda
>  #define VENDOR_ID_SAMSUNG              0x04e8
>  #define VENDOR_ID_LENOVO               0x17ef
> +#define VENDOR_ID_LINKSYS              0x13b1
>  #define VENDOR_ID_NVIDIA               0x0955
>
>  #define MCU_TYPE_PLA                   0x0100
> @@ -4376,6 +4377,7 @@ static struct usb_device_id rtl8152_table[] = {
>         {REALTEK_USB_DEVICE(VENDOR_ID_SAMSUNG, 0xa101)},
>         {REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x7205)},
>         {REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x304f)},
> +       {REALTEK_USB_DEVICE(VENDOR_ID_LINKSYS, 0x0041)},
>         {REALTEK_USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff)},
>         {}
>  };
> --
> 2.7.4
>

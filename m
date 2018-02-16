Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-220077-1518788888-2-7341737812570117992
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518788887; b=VbI7hph1xhyA8MutIHBGCoG+DkRybTohZvVH0PdtFtaKple
    unUFYu9dw185oI4vcRCqzWz5en+Kgv9hQ8hMTv1BGrXeancuETKUcxPqw1Nfc9Ad
    yTuHApEjYF4bVd7oFt/RkU2JwDf/Zalno9rHpyHus3TF+uYTd+ZU6gvKpWXqRxn4
    5mKFwgi11DdJWLwonFHQiWZ3a6fa+DWkVLkJ2/YpoNHv6xk6LdYmmNPzJgxgnS/Z
    bJ5toMpMussBNA8mFJApeTMwYH79h/K30twKVretbBOElJ42E+jcgtjHvdAJHHWo
    CWiYNPR4z2yQrktophLwJwJzXJ1dEbWjXPjC14A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518788887; bh=WUuUGSyjqDqNRcfQ5Evc5DtIbaS2AVHOIvhpAI
    /kmek=; b=LBGm/UF2Tjz2sh+sBxdRNaqJk0UIqIPNbHUspqRfYbT/B8lQjUT2kE
    HwAu4HCXCoPbsHug5pd+5McFMOzLOumvWDU1DPxM84hsXB0PH0cRxPiQGYjATaY/
    o7w6Mpkys5Jel6mVlJ3baQGAPyk71nq/3LsgrefE5xAKy6zvI+ZW9oDzAwdRQ7JZ
    BUulZP87qgO4Z5jUbGUdYocsdFbW0FJDYevbtpIg0fdjvFCoeFZl745myXzLEw4B
    9i777JHF29Vhnzmg7W7VZfRb4/Bwp9Ol6Zidj4UTyJ3SXzJRbvPoQZlicLFLdRkw
    lUPq2ul8kQ0WWfqmAVb3qamKAFEBiy/w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QeCuEEYF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sxWQh/dI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QeCuEEYF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sxWQh/dI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032128AbeBPNrH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 08:47:07 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:34949 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032117AbeBPNrF (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Feb 2018 08:47:05 -0500
X-Google-Smtp-Source: AH8x2265IiX93a9fscHFRJNOqbja9rBI86OLQh3jF/JJ/REUNfO7Eax7kwms3lKeDIPCYZqpR7sDxOtbzzlJpKb6iU0=
MIME-Version: 1.0
In-Reply-To: <20180216104751.8371-10-hdegoede@redhat.com>
References: <20180216104751.8371-1-hdegoede@redhat.com> <20180216104751.8371-10-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2018 15:47:04 +0200
Message-ID: <CAHp75VfnqbSecz4y-ThLRPVjTe6jrBPgwEnGEuxb6AunvNDvvg@mail.gmail.com>
Subject: Re: [PATCH 09/12] usb: roles: Add Intel XHCI USB role switch driver
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 12:47 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Various Intel SoCs (Cherry Trail, Broxton and others) have an internal USB
> role switch for swiching the OTG USB data lines between the xHCI host
> controller and the dwc3 gadget controller.
>
> Note on some Cherry Trail systems there is ACPI/AML code listening to
> edge interrupts on the id-pin (through an _AIE ACPI method) and switching
> the role between ROLE_HOST and ROLE_NONE based on the id-pin. Note it does
> not set the role to ROLE_DEVICE, because device-mode is usually not used
> under Windows.
>
> The presence of AML code which modifies the cfg0 reg (on some systems)
> means that we our read/write/modify of cfg0 may race with the AML code
> doing the same to avoid this we take the global ACPI lock while doing
> the read/write/modify.

> +/* register definition */
> +#define DUAL_ROLE_CFG0                 0x68
> +#define SW_VBUS_VALID                  (1 << 24)
> +#define SW_IDPIN_EN                    (1 << 21)
> +#define SW_IDPIN                       (1 << 20)
> +
> +#define DUAL_ROLE_CFG1                 0x6c
> +#define HOST_MODE                      (1 << 29)

Does it make sense to use BIT() macro above?


> +struct intel_xhci_acpi_match {
> +       const char *hid;
> +       int hrv;
> +};

Consider to unify with struct acpi_ac_bl.

> +static const struct intel_xhci_acpi_match allow_userspace_ctrl_ids[] = {
> +       { "INT33F4",  3 }, /* X-Powers AXP288 PMIC */
> +};
> +
> +static int intel_xhci_usb_set_role(struct device *dev, enum usb_role role)
> +{
> +       struct intel_xhci_usb_data *data = dev_get_drvdata(dev);
> +       unsigned long timeout;
> +       acpi_status status;

> +       u32 glk = -1U;

I prefer to see consistency and moreover less confusing set, like

~0U

> +       u32 val;
> +
> +       /*
> +        * On many CHT devices ACPI event (_AEI) handlers read / modify /
> +        * write the cfg0 register, just like we do. Take the ACPI lock
> +        * to avoid us racing with the AML code.
> +        */
> +       status = acpi_acquire_global_lock(ACPI_WAIT_FOREVER, &glk);

FOREVER?!
Wouldn't be slightly long under certain circumstances?

> +       if (ACPI_FAILURE(status) && status != AE_NOT_CONFIGURED) {
> +               dev_err(dev, "Error could not acquire lock\n");
> +               return -EIO;
> +       }

> +       acpi_release_global_lock(glk);

> +       /* Polling on CFG1 register to confirm mode switch.*/
> +       do {
> +               val = readl(data->base + DUAL_ROLE_CFG1);

> +               if (!!(val & HOST_MODE) == (role == USB_ROLE_HOST))

I would prefer ^ instead of first ==, but it's up to you.

> +                       return 0;
> +
> +               /* Interval for polling is set to about 5 - 10 ms */
> +               usleep_range(5000, 10000);
> +       } while (time_before(jiffies, timeout));
> +
> +       dev_warn(dev, "Timeout waiting for role-switch\n");
> +       return -ETIMEDOUT;
> +}

> +static int intel_xhci_usb_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct intel_xhci_usb_data *data;
> +       struct resource *res;
> +       resource_size_t size;
> +       int i, ret;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

> +       size = (res->end + 1) - res->start;

resource_size()

> +       data->base = devm_ioremap_nocache(dev, res->start, size);

So, what's wrong with devm_ioremap_resource() ?
...which also prints an error message.

> +       if (IS_ERR(data->base)) {
> +               ret = PTR_ERR(data->base);

> +               dev_err(dev, "Error iomaping registers: %d\n", ret);

At least printing return code is useless. Driver core does this.

> +               return ret;
> +       }
> +

> +       data->role_sw = usb_role_switch_register(dev, &sw_desc);
> +       if (IS_ERR(data->role_sw)) {
> +               ret = PTR_ERR(data->role_sw);

> +               dev_err(dev, "Error registering role-switch: %d\n", ret);

Ditto.

> +               return ret;
> +       }
> +
> +       return 0;
> +}

> +static const struct platform_device_id intel_xhci_usb_table[] = {
> +       { .name = DRV_NAME },

> +       {},

No comma, please.

> +};

-- 
With Best Regards,
Andy Shevchenko

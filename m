Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-220077-1518790087-2-16775668866129826568
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
    t=1518790086; b=Vou5DMzkis7/1ZOg/ammQpfi+y6MgshSeaPaFV9YMdcsAzS
    WPRofMuyBQTHke7UADMxhxhSD3KWYGB51VRdOMTz9uJuJAmoFu0MbwEYoo7sFGHR
    I5D1+Z67tQzZwEycP8XANlAeAtNGVQD24kXuVK8bwEdlw4qfvDdke5Z57jsvScXq
    Efex/Nd+AAV1rBYa2U2YCgrSUqTwlZb4G9WsQ7fbYNHJUXFGuaPdBpc/nR2cKp/3
    ln1BzKxmPMgaZJoMUbWZnVsB+1eixEMOgSBEv2f/7NyUwkEY7UESbDjFUdXPLcqk
    tHu1x/q1yh3hfwMs8IqpMxvFkNrU7v3+IDNZqAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518790086; bh=JF/0JlJZFQ0UG5D7aCLUYA+ShJES2OYgYoGgOk
    5LX7A=; b=AE3HVnlSYjh/x1DpNvmUFv8F/OiO/SLiXbg4kOutoXNg65LJrkEZJe
    pZwCAS0rmjiOG+DWehMxWNm+pF5pUqJvpsODdOxX3TVK1kW1R3FArzgUnSEGiGhE
    1jXCvJ7aJvKvgtWlh94grK7w7/v0Dn295g8qq/qzMnhlbE5+tLsVbdr8ShXZXemV
    /nVBH5ZmZJRGMUztSaVjRvS+CNq3oVm3rXX+uZks+odlzLWT94Vn0GbgfIX4DyUf
    auRFTsjo2V5aHDKMZxfYxI8YbIoaId9kIAaaH8Te0f9iedCkjOasxJ+IgpTk79Ne
    0gs6ROovVPSEcEWurRbT9rCPCAR4rIjg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mEVBlRey x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SN6U1Xbe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mEVBlRey x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SN6U1Xbe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033591AbeBPOIC (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 09:08:02 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38577 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033432AbeBPOIB (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Feb 2018 09:08:01 -0500
X-Google-Smtp-Source: AH8x224gYs44lT0s7qXwVHh6u+QK70S5XYJX4tc9nCLnrXWE97ROwWnOWyYvc1MZCL5HkvQa+f3GiS5auia2y8Nauxs=
MIME-Version: 1.0
In-Reply-To: <20180216104751.8371-5-hdegoede@redhat.com>
References: <20180216104751.8371-1-hdegoede@redhat.com> <20180216104751.8371-5-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2018 16:07:59 +0200
Message-ID: <CAHp75VcU1CUN5A9qFw4mDGjdeD+mtSWxx-YwtkaAXkUdcmcwpg@mail.gmail.com>
Subject: Re: [PATCH 04/12] usb: common: Small class for USB role switches
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

> USB role switch is a device that can be used to choose the
> data role for USB connector. With dual-role capable USB
> controllers, the controller itself will be the switch, but
> on some platforms the USB host and device controllers are
> separate IPs and there is a mux between them and the
> connector. On those platforms the mux driver will need to
> register the switch.
>
> With USB Type-C connectors, the host-to-device relationship
> is negotiated over the Configuration Channel (CC). That
> means the USB Type-C drivers need to be in control of the
> role switch. The class provides a simple API for the USB
> Type-C drivers for the control.
>
> For other types of USB connectors (mainly microAB) the class
> provides user space control via sysfs attribute file that
> can be used to request role swapping from the switch.

> +static int __switch_match(struct device *dev, const void *name)

bool?

> +{
> +       return !strcmp((const char *)name, dev_name(dev));
> +}


> +static ssize_t role_store(struct device *dev, struct device_attribute *attr,
> +                         const char *buf, size_t size)
> +{
> +       struct usb_role_switch *sw = to_role_switch(dev);
> +       int ret;
> +
> +       ret = sysfs_match_string(usb_roles, buf);
> +       if (ret < 0) {
> +               bool res;
> +
> +               /* Extra check if the user wants to disable the switch */
> +               ret = kstrtobool(buf, &res);
> +               if (ret || res)
> +                       return -EINVAL;
> +       }
> +

> +       ret = usb_role_switch_set_role(sw, ret);
> +       if (!ret)
> +               ret = size;
> +
> +       return ret;

Perhaps

ret = ...
if (ret)
 return ret;

return size;

> +}

> +struct usb_role_switch *
> +usb_role_switch_register(struct device *parent,
> +                        const struct usb_role_switch_desc *desc)
> +{
> +       struct usb_role_switch *sw;
> +       int ret;
> +
> +       if (!desc || !desc->set)
> +               return ERR_PTR(-EINVAL);
> +
> +       sw = kzalloc(sizeof(*sw), GFP_KERNEL);
> +       if (!sw)
> +               return ERR_PTR(-ENOMEM);

> +       ret = device_register(&sw->dev);
> +       if (ret) {
> +               put_device(&sw->dev);

Memory leak?

> +               return ERR_PTR(ret);
> +       }
> +
> +       /* TODO: Symlinks for the host port and the device controller. */
> +
> +       return sw;
> +}

> +void usb_role_switch_unregister(struct usb_role_switch *sw)
> +{
> +       if (sw && !IS_ERR(sw))

!IS_ERR_OR_NULL() ?

> +               device_unregister(&sw->dev);
> +}

-- 
With Best Regards,
Andy Shevchenko

Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3839317-1519561030-2-3231719779484226402
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519561030; b=KfjkIOX4uQKtuZUDg+xzziqgoY7zhnajPHhWyXz2e7GWLdI
    zC0fds+7b23KT813vJ33weszCTg+Zx2l70tPZUGTxnTzh/IujtXZXhbYo3nSo883
    o9x1+ZirCv3hAVrXmGFHRmYq11sfiFfBUbavihrpoR1xNMlTA4VkzgmEkhWh84Yz
    D66Mug34QUxnd0tShIrll3rv6OTzguexg/tAqWEd5Gs4zu1sQc7NGIoSSQQOc02f
    cVxhUFJ/IwZFTCeK/WYs7/07SA/6NlAGSG9v2ER9OSlWulnc9XyAvohrkt7G8xBx
    ZTWTI+gdPgVentDGz+2RNHYW/jQPd57I4ogAskg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519561030; bh=+bprHdAk5Q6FsSQOKBVDrC+YpvcnOq8bL+PC6K0w6Gc=; b=Y
    0MXuhg+uKYtQXjCZq/1rsbWao/UU7iqHlqj4BzQIeSc20En5xD+KQWb7pMSyyWTT
    XxzXT69s+pg/sosaOLlLNnRVlxMZaZQM5on8yR2R4/j0KQ9es7BnNVzqpFba2NY3
    ul0E2v1GMoVblgA6Ffiztuc22sO2LKqYVI/TzZb1RXxm6JAb/AcmVD3WrVDg6CZM
    DV/VsczPIHQo1FYL3cVHc/FTTndvZpjDr0MT37k+lwh+daYVBnqxDX8cPaUgnQPU
    4QP3wbi3000wAr7mfNGhYgbC+T9uOrOHbqRT/Peo4QG9fjT5ENNdNSoJe9Rhw9PR
    /8O54GISXhl6VPltkWf6Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=g+ILQtoY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=g+ILQtoY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751746AbeBYMQ4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 07:16:56 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53332 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbeBYMQz (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 25 Feb 2018 07:16:55 -0500
X-Google-Smtp-Source: AG47ELuEZQuHwpApK8BHELXDO2m+flzMyKs89ncoiFQvePhxyfS4+Mib1IM5ZoeZz50prF9Tbkdnkg==
Subject: Re: [PATCH 04/12] usb: common: Small class for USB role switches
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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
References: <20180216104751.8371-1-hdegoede@redhat.com>
 <20180216104751.8371-5-hdegoede@redhat.com>
 <CAHp75VcU1CUN5A9qFw4mDGjdeD+mtSWxx-YwtkaAXkUdcmcwpg@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <d7edd064-8590-1db5-d835-1c924ed3318e@redhat.com>
Date: Sun, 25 Feb 2018 13:16:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcU1CUN5A9qFw4mDGjdeD+mtSWxx-YwtkaAXkUdcmcwpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 16-02-18 15:07, Andy Shevchenko wrote:
> On Fri, Feb 16, 2018 at 12:47 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> USB role switch is a device that can be used to choose the
>> data role for USB connector. With dual-role capable USB
>> controllers, the controller itself will be the switch, but
>> on some platforms the USB host and device controllers are
>> separate IPs and there is a mux between them and the
>> connector. On those platforms the mux driver will need to
>> register the switch.
>>
>> With USB Type-C connectors, the host-to-device relationship
>> is negotiated over the Configuration Channel (CC). That
>> means the USB Type-C drivers need to be in control of the
>> role switch. The class provides a simple API for the USB
>> Type-C drivers for the control.
>>
>> For other types of USB connectors (mainly microAB) the class
>> provides user space control via sysfs attribute file that
>> can be used to request role swapping from the switch.
> 
>> +static int __switch_match(struct device *dev, const void *name)
> 
> bool?
> 
>> +{
>> +       return !strcmp((const char *)name, dev_name(dev));
>> +}
> 
> 
>> +static ssize_t role_store(struct device *dev, struct device_attribute *attr,
>> +                         const char *buf, size_t size)
>> +{
>> +       struct usb_role_switch *sw = to_role_switch(dev);
>> +       int ret;
>> +
>> +       ret = sysfs_match_string(usb_roles, buf);
>> +       if (ret < 0) {
>> +               bool res;
>> +
>> +               /* Extra check if the user wants to disable the switch */
>> +               ret = kstrtobool(buf, &res);
>> +               if (ret || res)
>> +                       return -EINVAL;
>> +       }
>> +
> 
>> +       ret = usb_role_switch_set_role(sw, ret);
>> +       if (!ret)
>> +               ret = size;
>> +
>> +       return ret;
> 
> Perhaps
> 
> ret = ...
> if (ret)
>   return ret;
> 
> return size;

Ack, that is better, fixed for v2.

Regards,

Hans


> 
>> +}
> 
>> +struct usb_role_switch *
>> +usb_role_switch_register(struct device *parent,
>> +                        const struct usb_role_switch_desc *desc)
>> +{
>> +       struct usb_role_switch *sw;
>> +       int ret;
>> +
>> +       if (!desc || !desc->set)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       sw = kzalloc(sizeof(*sw), GFP_KERNEL);
>> +       if (!sw)
>> +               return ERR_PTR(-ENOMEM);
> 
>> +       ret = device_register(&sw->dev);
>> +       if (ret) {
>> +               put_device(&sw->dev);
> 
> Memory leak?
> 
>> +               return ERR_PTR(ret);
>> +       }
>> +
>> +       /* TODO: Symlinks for the host port and the device controller. */
>> +
>> +       return sw;
>> +}
> 
>> +void usb_role_switch_unregister(struct usb_role_switch *sw)
>> +{
>> +       if (sw && !IS_ERR(sw))
> 
> !IS_ERR_OR_NULL() ?
> 
>> +               device_unregister(&sw->dev);
>> +}
> 

Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3833676-1519032757-2-1075659276652434805
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519032756; b=nJLX0deuK2r6P1Kd1sZrKEdw+m4mVvMj5kDl47Jrm0kQKpA
    54eBB4hNL7Dz9Ie1cQ1NcO3hLT6pr8/8IVkNhovaQa9Kxabz/Un8bwURS46AeE2C
    1vDkGTE04dKaGLPH1UxHzxkS+0d/tbel3yaWmDF5oBzx7jdyDO5cCoTVKWsANI4W
    34qUMYahew9ukIEi6NSe6dxq2FZQITZiGYWg+k+BN5r0OUCJQgqK5AB8Jr5l1bKx
    13HPqESDjnzoRrjMIc5aXnnv2gqGuFuRmEjU/g9hlGTzCBH2/J+gFxVVM4rT/YkZ
    035KzonIQjPcbYIJWf6bI6SzpIriZTCHc80J7Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519032756; bh=qg3KkT3ycq3/RscvlUWomyKgCMwDgSoxgheQ74tckP0=; b=n
    XmnUSVrq5FS70vWoOp5MfV8goHl35SUkmhBm2z4/EIrwsSpwe2AZTRFrvP9eOwrj
    Nons3Q0kjevGq+b1XoRjsFRIcUd+Yw2MEsQAiI8ke/qIfNF0ok+nMwn1GaW1p88a
    a/ZcUmvvhmiXttf01wHiYbuS1w0rr+joQhAi2vj1LPmeSpAM3JNTvzvX2HDfFQSV
    iJ7iE2TfUAZcpxY/pDoRWp1dbh/RUgBXuJUIV/o6dS0xijEdA0tidhYDAgeDhL3j
    CnLdXvQqjogbVUu9TO6w64gc6lOzi2exqN5aAwxOnmWoERyHfKRCzKnApd7ZadhE
    NnZuMU7uAXRIGIUix593g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fE5k78hd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fE5k78hd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeBSJcV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 04:32:21 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:39186 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbeBSJcT (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 19 Feb 2018 04:32:19 -0500
X-Google-Smtp-Source: AH8x227pSIhRXT8HR24r3MOKduBsyiF1kxPXvsEPPxkyRDNKFWjIKBaVzcX+aSumMb5+got9AixWcQ==
Subject: Re: [PATCH 04/12] usb: common: Small class for USB role switches
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
References: <20180216104751.8371-1-hdegoede@redhat.com>
 <20180216104751.8371-5-hdegoede@redhat.com>
 <CAHp75VcU1CUN5A9qFw4mDGjdeD+mtSWxx-YwtkaAXkUdcmcwpg@mail.gmail.com>
 <20180216142209.GS1480@kuha.fi.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <553006b6-4884-17ca-96cd-7ef6d60a38bf@redhat.com>
Date: Mon, 19 Feb 2018 10:32:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180216142209.GS1480@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 16-02-18 15:22, Heikki Krogerus wrote:
> On Fri, Feb 16, 2018 at 04:07:59PM +0200, Andy Shevchenko wrote:
>> On Fri, Feb 16, 2018 at 12:47 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>>> USB role switch is a device that can be used to choose the
>>> data role for USB connector. With dual-role capable USB
>>> controllers, the controller itself will be the switch, but
>>> on some platforms the USB host and device controllers are
>>> separate IPs and there is a mux between them and the
>>> connector. On those platforms the mux driver will need to
>>> register the switch.
>>>
>>> With USB Type-C connectors, the host-to-device relationship
>>> is negotiated over the Configuration Channel (CC). That
>>> means the USB Type-C drivers need to be in control of the
>>> role switch. The class provides a simple API for the USB
>>> Type-C drivers for the control.
>>>
>>> For other types of USB connectors (mainly microAB) the class
>>> provides user space control via sysfs attribute file that
>>> can be used to request role swapping from the switch.
>>
>>> +static int __switch_match(struct device *dev, const void *name)
>>
>> bool?
> 
> No, this is callback for class_find_device(). It takes int so int it
> is.
> 
>>> +{
>>> +       return !strcmp((const char *)name, dev_name(dev));
>>> +}
>>
>>
>>> +static ssize_t role_store(struct device *dev, struct device_attribute *attr,
>>> +                         const char *buf, size_t size)
>>> +{
>>> +       struct usb_role_switch *sw = to_role_switch(dev);
>>> +       int ret;
>>> +
>>> +       ret = sysfs_match_string(usb_roles, buf);
>>> +       if (ret < 0) {
>>> +               bool res;
>>> +
>>> +               /* Extra check if the user wants to disable the switch */
>>> +               ret = kstrtobool(buf, &res);
>>> +               if (ret || res)
>>> +                       return -EINVAL;
>>> +       }
>>> +
>>
>>> +       ret = usb_role_switch_set_role(sw, ret);
>>> +       if (!ret)
>>> +               ret = size;
>>> +
>>> +       return ret;
>>
>> Perhaps
>>
>> ret = ...
>> if (ret)
>>   return ret;
>>
>> return size;
> 
> Sure. Hans, can you clean-up this as well?

Yes I can, not sure when exactly I will get around to this, but I will
try to get out a v2 addressing all comments made this week.

And thank you for your reviews.

Andy, thank you for all the reviews too.

Regards,

Hans

> 
>>> +}
>>
>>> +struct usb_role_switch *
>>> +usb_role_switch_register(struct device *parent,
>>> +                        const struct usb_role_switch_desc *desc)
>>> +{
>>> +       struct usb_role_switch *sw;
>>> +       int ret;
>>> +
>>> +       if (!desc || !desc->set)
>>> +               return ERR_PTR(-EINVAL);
>>> +
>>> +       sw = kzalloc(sizeof(*sw), GFP_KERNEL);
>>> +       if (!sw)
>>> +               return ERR_PTR(-ENOMEM);
>>
>>> +       ret = device_register(&sw->dev);
>>> +       if (ret) {
>>> +               put_device(&sw->dev);
>>
>> Memory leak?
> 
> No. Check usb_role_switch_release().
> 
> 
> Thanks,
> 

Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2600559-1521853735-2-11075607768829094109
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521853735; b=YTvDKP0CVQCjwcVJddLT/D6AMmf8nIol0+4QNBfdLUfH3Bf
    TOIhxXyKnGbZ1JZGIAffDk57zBbFAbEjU2FsQuyU87HbmBm1YE+Hdunn7eTJJVO7
    YH3H5FH8ihWTZ0ODk9BDDXzaNwuCAzFHPLtS6LxXeKuTznX5zgUcKpeFHK5uwTqe
    YaErUyulvoBrdevP12AkcGFeMN926fJRIUP1NcMdUgbr8Z5S8a4EoYvdMkCiRxx+
    c/YZLz7LutQHZoM+9gfVGBN1tfMbGJXIjJtIfkl/deYy8G+d4gk6vmtviLw4aQmE
    d9vFyP7Jpm7OC6xEfzvbCf5SQ8fNV2TLy4XBlXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521853735; bh=uq9xc23hx1Ox+gvsmAozjJpWgoKtuyyDACl03W
    zwSgY=; b=bTrHDkqVT+PkcMAnYqYLeUsE+Km6EQCUMs9n/f9a46d6tTp8sfJZeC
    5MDFs5UoSWZrwCBGN5TWLG4BwkUAenYiLvnEQFycMjQsMVEs1tksHOpLob3mvhtr
    BFdOZHbw0N5JLGh3vssCIiIMEgccJ6QQl9oqob3gW9+g6Fw6iUH4EI92x2PbUIO3
    ml7PLuyxKvRxhQt59Pxnr6leyan04yphks1GubLhVJ4efB92mxZMuy86dZbu0oGD
    6sDSXzbuW2fuhL6olhmPUElMWYTRC1riMsbdOEo7q8sJ8gUU/x9sgxlQ2SpVpND0
    25w1oa8WcCHe+PNqghqU67ThFOpW5otA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=tCVQvfcv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sOTLTe3J;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=tCVQvfcv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sOTLTe3J;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeCXBIt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 21:08:49 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:46876 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751604AbeCXBIs (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 23 Mar 2018 21:08:48 -0400
X-Google-Smtp-Source: AG47ELsGh5MHWcRetHmSCzmQOgeQMw6XgD3bOCc+tjEHkcehXhAMKrEDBF9CgUtlNEKGa2AHBDUCNVpY0xDGEF4IAPE=
MIME-Version: 1.0
In-Reply-To: <CANVWZtHTuU-_zjvj8gjXXA-2VUU2zxsu=afcqZC8Oen_bFmk6A@mail.gmail.com>
References: <20180324003330.180726-1-bleung@chromium.org> <CANVWZtHTuU-_zjvj8gjXXA-2VUU2zxsu=afcqZC8Oen_bFmk6A@mail.gmail.com>
From: Andrew Chant <achant@google.com>
Date: Fri, 23 Mar 2018 18:08:07 -0700
Message-ID: <CANVWZtGS9x-zLAgtV0rkgnBR0kLHTT0LYjKEreNy6qjkcC75PA@mail.gmail.com>
Subject: Re: [PATCH] USB: announce bcdDevice as well as idVendor, idProduct.
To: Benson Leung <bleung@chromium.org>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 5:48 PM, Andrew Chant <achant@google.com> wrote:
> On Fri, Mar 23, 2018 at 5:33 PM, Benson Leung <bleung@chromium.org> wrote:
>> Print bcdDevice which is used by vendors to identify different versions
>> of the same product (or different versions of firmware).
>>
>> Adding this to the logs will be useful for support purposes.
>>
>> Signed-off-by: Benson Leung <bleung@chromium.org>
>> ---
>>  drivers/usb/core/hub.c | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index aaeef03c0d83..739d599814b6 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -2192,14 +2192,16 @@ static void show_string(struct usb_device *udev, char *id, char *string)
>>
>>  static void announce_device(struct usb_device *udev)
>>  {
>> -       dev_info(&udev->dev, "New USB device found, idVendor=%04x, idProduct=%04x\n",
>> -               le16_to_cpu(udev->descriptor.idVendor),
>> -               le16_to_cpu(udev->descriptor.idProduct));
>>         dev_info(&udev->dev,
>> -               "New USB device strings: Mfr=%d, Product=%d, SerialNumber=%d\n",
>> -               udev->descriptor.iManufacturer,
>> -               udev->descriptor.iProduct,
>> -               udev->descriptor.iSerialNumber);
>> +                "New USB device found, idVendor=%04x, idProduct=%04x, bcdDevice=%04x\n",
>> +                le16_to_cpu(udev->descriptor.idVendor),
>> +                le16_to_cpu(udev->descriptor.idProduct),
>> +                le16_to_cpu(udev->descriptor.bcdDevice));
>> +       dev_info(&udev->dev,
>> +                "New USB device strings: Mfr=%d, Product=%d, SerialNumber=%d\n",
>> +                udev->descriptor.iManufacturer,
>> +                udev->descriptor.iProduct,
>> +                udev->descriptor.iSerialNumber);
>>         show_string(udev, "Product", udev->product);
>>         show_string(udev, "Manufacturer", udev->manufacturer);
>>         show_string(udev, "SerialNumber", udev->serial);
>> --
>> 2.17.0.rc0.231.g781580f067-goog
>>
>
>> +                "New USB device found, idVendor=%04x, idProduct=%04x, bcdDevice=%04x\n",
> Can you please decode bcdDevice into a decimal string?
>
> lsusb -v does this (bcdDevice: 0.03 for example) and in my experience
> it has generally matched up with how hardware manufacturers refer
> to their firmware.

Nevermind, %x should show bcd properly.  looks fine.

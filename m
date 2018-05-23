Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-915550-1527118928-2-10615651864109454221
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527118927; b=Wl58qsyRJfNDYBcngvPNrrGQzSpC/Fnl6yQc36h51whuc6jLb8
    /1d53p/GXhgl6urEnrscp53w/kFFyxO2PxHkdtCUX7HDbzYYLsUTFS5Wqfj3s3oD
    wbZWQzffDzald+TXb5nOA7Vb4uPkkM2uwW2J85p9QZ0ST+cbcz/OOm/ATVhbTonP
    pLrfiAYNlXGVJBsuQTdNRKCCY73fE22Ww1rkaqURuQHRW3R/hbirx4zJMGIe391r
    kGzZZSx7zPkr+e1TtusfdmTB+DNeBtrL2Zz5g6rxWDRCCewX2pVuHywY5Y9P3Mc9
    rboGxZ9+8nJFPbQv63b4aWDxQPNZLHxukuWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527118927; bh=KWF0IkiFchfVAG07whDN2af2lx2jw3y7h3LTKmPW2m
    s=; b=gxt3O0I5Q3eH++dY8xWLRF45OQIbfKlzovTRE16tvVo6GIvi1jUyHUgZc0
    FfdNL1NoybiyBAHNbUX8yMLgT3y5BzgGXLyAAK9xsnC4i2+u40vqMIGZ9VI0PKoU
    +P6h6IIN2WvSQDJypqFesy3IkqpiymrYk3T3QpSs+NHAKcK2jtSyNqf0VmtWjUl3
    CZBYBKQSP48KVzfb71WIwXt+daj+D0QrZuERjaXGo+MGAzJmvqG4A7pEjtxqOta4
    OkwbKrLPhReTIOu25UlsCWO1iFLpBPSCeo7VMG+jgY+H28CX43a6mm5pU+pCegaw
    Nxz9fGV3bouU21IMJwVaStT2zBJA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=chromium.org header.i=@chromium.org header.b=L0FMffgH
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=dyct+TTo;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=chromium.org header.i=@chromium.org header.b=L0FMffgH
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=dyct+TTo;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKNkeJH2OWVo1R8ls4gpkkLfhg6SeRo9gfV3qfUPj1QiHX++3vK9cPcGKnW09GRyJLhcdRR316RBTx+KUwzODxxW5CNOUryHetv3WSD8CWopRN6uJZiX
    lsoo3AVYhH9arPVTzwK8Rzvp9vmKzx+Kqa+9IGyPYHe0HrYe2QcQbv2xmT1NYMI2H//szkmuRPLHVDDtn9JYi+J3YVE4xzAWb/562NfCLLPqO6euMoSwIow9
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=PndceNkOn8oKirbmRPQA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935198AbeEWXmD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 19:42:03 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42701 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935193AbeEWXmB (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 23 May 2018 19:42:01 -0400
X-Google-Smtp-Source: AB8JxZrFzH0Pcw4uKUV4b/h2EHGSrO+Ck1jqbD7sgHrjiB6w2XgVOjLPyvvayQ8syAQKJjjxzHJJUOJKSYz80uJPEf8=
MIME-Version: 1.0
In-Reply-To: <20180523163936.GE12456@kroah.com>
References: <20180523021656.122455-1-drinkcat@chromium.org>
 <Pine.LNX.4.44L0.1805230958590.1481-100000@iolanthe.rowland.org> <20180523163936.GE12456@kroah.com>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Thu, 24 May 2018 07:42:00 +0800
Message-ID: <CANMq1KD8SpPQ7UTy2wN0J84dsA86Skmbb5q0OjkG+-BZShiv-A@mail.gmail.com>
Subject: Re: [PATCH] usb: hub: Per-port setting to use old enumeration scheme
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Eugene Korenevsky <ekorenevsky@gmail.com>,
        Peter Chen <peter.chen@nxp.com>,
        Daniel Drake <drake@endlessm.com>,
        Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 12:39 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, May 23, 2018 at 10:03:55AM -0400, Alan Stern wrote:
>> On Wed, 23 May 2018, Nicolas Boichat wrote:
>>
>> > The "old" enumeration scheme is considerably faster (it takes
>> > ~294ms instead of ~439ms to get the descriptor).
>> >
>> > It is currently only possible to use the old scheme globally
>> > (/sys/module/usbcore/parameters/old_scheme_first), which is not
>> > desirable as the new scheme was introduced to increase compatibility
>> > with more devices.
>> >
>> > However, in our case, we care about time-to-active for a specific
>> > USB device (which we make the firmware for), on a specific port
>> > (that is pogo-pin based: not a standard USB port). This new
>> > sysfs option makes it possible to use the old scheme on a single
>> > port only.
>> >
>> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
>> > ---
>> >
>> > There are other "quirks" that we could add to reduce further
>> > enumeration time (e.g. reduce USB debounce time, reduce TRSTRCY
>> > to 10ms instead of 50ms as used currently), but the logic is quite
>> > similar, so it'd be good to have this reviewed first.
>>
>> I'm not opposed to the idea in principle, although I don't like your
>> implementation because it breaks the original old_scheme_first
>> parameter.

I don't think it breaks the original parameter? I mean,
/sys/module/usbcore/parameters/old_scheme_first is still a global
default, while bit 0 of /sys/bus/usb/devices/x/y/z/quirks becomes a
port-specific override.

>> Let's see what some other people think.
>>
>> Yours is a rather special case, because you know exactly what device
>> will be attached to a specific port.  Still, I can see that sort of
>> thing happening in constrained and special-purpose settings.
>>
>> How do you arrange to set the new quirk before the device is
>> discovered?
>
> Yeah, this last question is what I had when looking at this.  Or does it
> not matter at first boot and only matters for wake-up?

It does not matter on boot, we have plenty of time to enumerate the
device. We use USB (auto-)suspend and remote wake, so no
re-enumeration there either. It only matters on unplug/replug where
the device needs to be re-enumerated.

Somewhere in an init script, we would do this (we know in advance that
usb1 port2 is the bus/port where we have our pogo-pin USB interface,
so we can hard-code the path):
echo 1 > /sys/bus/usb/devices/usb1/1-0:1.0/usb1-port2/quirks

We could try to add ACPI support (just like connect_type), but we
don't strictly need it for our application.

Thanks,

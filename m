Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223491-1524185426-2-13342250824569260039
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524185426; b=O+bubjN6TkBLJq4SlzmIAmpAglmhLSZ2JeqD6xJ6Riva/Zqssc
    OwihoAMQspnyy08CIdwnypr/4YlN/Q3aGlMiYC0duY2Hf//yrByC02NKKIal3hHO
    2TnT7w8rRtpF7EWFLwy8eOgMhL5FXMRmVw77xs57eOpXM4oSPLQRWcrZ6oSRoY2P
    iiOAoGdxtBr4MvFEUlaWV588pWAkfqxpp0sAq1sBcWK/umlvc5WAgXzDw9/+ZUGA
    OyC0h4Ua+2gF1//+k+bVWx0UoJv8EIF68f3g+hqGMQVtZbOrYVUURJvY4zAjRtvg
    V6jstAT/cWm1s4GzFbaXlKoJcrJGG3eraJuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524185426; bh=DDxf5AqkmSmD1/GliHtpFvidD/e9rnMzS9+xbBTcYk
    M=; b=SZkV95dwrUUFAngz0j41oo6jClMBYpY05NJjxbr7iPawHp/3gq8/YK7zoT
    w27Og8CqIUUkOikXEhOxFtzRU3r5RaIL8Q4FSel9vIFLlLhrWrbnO4VEX7husfyo
    f/2fmvxGJVvQVvkaxLzEdOxPH+vm7Gsk4yryo08PotWz5uzH6JVIzL04cM5AhhXd
    cCxrpZ4T07CXvHe75hQBjK6XGn6IlHw0/NM8dpAdtnUmD2ei1+P5iLXQOCYWM8+N
    w0mJqobJe7Kg+o1Z1RQkFX5VzZ1nUv+x1s9g/8dE3qHurzE+3xbKu96NmUwppPrj
    g1v9H+SndObLIOKc+YFBgGjWF3fg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=eiDThguO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IJderJqJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=eiDThguO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IJderJqJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHrkJXjf0xagbKdhn2CNYkgoaGc7vK3zJN4FvtJRI28bCNI1wrlFD/0D3MlQsmALSR2cAxgmGtbH4H4MFIsk1bhq/6MYRmnDsOHovRpD6Crpj0ChVr7Y
    28emUz2OOdoZXVY33Vdb2HC1XAgmxfBXs6NKqdy3QEjODJ0DLdylEMHKa5I2ETg6Sl4LbPg+LYAEqNNl2TdDYYHljOSx9RDAy/dBoH9Eflag8DNoMADfpIM1
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=RTtc9UJCmEXoFN7E73kA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753991AbeDTAuY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 20:50:24 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:46603 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753919AbeDTAuX (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 19 Apr 2018 20:50:23 -0400
X-Google-Smtp-Source: AIpwx4+OtqZwxEtgVcKMb7yg9VdKjxUSTyrXKEdi3PSpv4raj/F68K//YrkCRQUPJLYkFdUrnAfuV4K18YmxJXbshlE=
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1804191053410.1288-100000@iolanthe.rowland.org>
References: <20180419001850.133110-1-ravisadineni@chromium.org> <Pine.LNX.4.44L0.1804191053410.1288-100000@iolanthe.rowland.org>
From: Ravi Chandra Sadineni <ravisadineni@google.com>
Date: Thu, 19 Apr 2018 17:50:01 -0700
Message-ID: <CAOGSYL0=XFAidyUBtaCp2fDWHsTuTLb7UXuu=NXZBp6kpurqPA@mail.gmail.com>
Subject: Re: [PATCH] USB: Increment wakeup count on remote wakeup.
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        gregkh@linuxfoundation.org, martin.blumenstingl@googlemail.com,
        chunfeng.yun@mediatek.com, johan@kernel.org,
        arvind.yadav.cs@gmail.com, Dmitry Torokhov <dtor@google.com>,
        anton.bondarenko.sama@gmail.com, f.fainelli@gmail.com,
        keescook@chromium.org, mathias.nyman@linux.intel.com,
        felipe.balbi@linux.intel.com, ekorenevsky@gmail.com,
        peter.chen@nxp.com, joe@perches.com,
        Todd Broch <tbroch@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>,
        Benson Leung <bleung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Alan,
Thanks for reviewing the change. Appreciate your time.  I tried to
address your comments in the V2 of the patch.

On Thu, Apr 19, 2018 at 8:01 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Wed, 18 Apr 2018, Ravi Chandra Sadineni wrote:
>
>> On chromebooks we depend on wakeup count to identify the wakeup source.
>> But currently USB devices do not increment the wakeup count when they
>> trigger the remote wake. This patch addresses the same.
>>
>> Resume condition is reported differently on USB 2.0 and USB 3.0 devices.
>>
>> On USB 2.0 devices, a wake capable device, if wake enabled, drives
>> resume signal to indicate a remote wake (USB 2.0 spec section 7.1.7.7).
>> The upstream facing port then sets C_PORT_SUSPEND bit and reports a
>> port change event (USB 2.0 spec section 11.24.2.7.2.3). Thus if a port
>> has resumed before driving the resume signal from the host and
>> C_PORT_SUSPEND is set, then the device attached to the given port might
>> be the reason for the last system wakeup. Increment the wakeup count for
>> the same.
>>
>> On USB 3.0 devices, a function may signal that it wants to exit from device
>> suspend by sending a Function Wake Device Notification to the host (USB3.0
>> spec section 8.5.6.4) Thus on receiving the Function Wake, increment the
>> wakeup count.
>>
>> Signed-off-by: ravisadineni@chromium.org
>> ---
>>  drivers/usb/core/hcd.c |  1 +
>>  drivers/usb/core/hub.c | 12 ++++++++++--
>>  2 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>> index 777036ae63674..79f95a878fb6e 100644
>> --- a/drivers/usb/core/hcd.c
>> +++ b/drivers/usb/core/hcd.c
>> @@ -2375,6 +2375,7 @@ void usb_hcd_resume_root_hub (struct usb_hcd *hcd)
>>  {
>>       unsigned long flags;
>>
>> +     pm_wakeup_event(dev, 0);
>
> Instead of dev, you probably want to use hcd->self.sysdev.  Or maybe
> hcd->self.controller, although the difference probably doesn't matter
> for your purposes.

Trying to increment the wakeup count for the roothub. So pointed dev
to &hcd->self.root_hub->dev. Hope this is fine.

>
> On the other hand, this wakeup event may already have been counted by
> the host controller's bus subsystem.  Does it matter if the same wakeup
> event gets counted twice?
>
> (This is inevitable with USB devices, in any case.  If a device sends a
> wakeup request, it will be counted for that device, for all the
> intermediate hubs, and for the host controller.)

We are o.k. with the wake-up count getting incremented for the
intermediate hubs. We just want to identify the leaf hid devices, if
they are cause of the remote wake. This way, we can differentiate user
triggered wake from a automatic wakes (Ex: wakes triggered by WOLAN
packets from USB ethernet adapter).

We are also o.k. with the wake-up count getting incremented twice. All
we look for is a change in the wake-up count for the interested
devices.
>
>> @@ -3432,10 +3437,13 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>>
>>       usb_lock_port(port_dev);
>>
>> -     /* Skip the initial Clear-Suspend step for a remote wakeup */
>>       status = hub_port_status(hub, port1, &portstatus, &portchange);
>> -     if (status == 0 && !port_is_suspended(hub, portstatus))
>> +     /* Skip the initial Clear-Suspend step for a remote wakeup */
>
> What is the reason for moving the comment line down after the
> hub_port_status() call?
Sorry. This was a mistake. Changed this back in V2.
>
> Alan Stern
>
>> +     if (status == 0 && !port_is_suspended(hub, portstatus)) {
>> +             if (portchange & USB_PORT_STAT_C_SUSPEND)
>> +                     pm_wakeup_event(&udev->dev, 0);
>>               goto SuspendCleared;
>> +     }
>>
>>       /* see 7.1.7.7; affects power usage, but not budgeting */
>>       if (hub_is_superspeed(hub->hdev))
>>
>

Thanks,
Ravi

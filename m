Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2094384-1524244058-2-2594614576990618845
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
    1524244058; b=qAhxHBv8gddo/xoTdLBIxRggf8s5tn87lqxm2ASDCzzu3U9yl7
    aunEe1B/qqTt7jufaHf0zOmkHDaRPRCtKrX7odb3ZPhYheoDYirwDKR8Ca9H8A/3
    vlVO4b757rpWkhoTBZ50ze6DOeVHCOQy/Ewnsrzc7Kgwci/aJkdJzNDqPJOeKw0o
    dG5cXaueCnfyREYxK7QgirLCMcbpZJOP3cLzh1axvFCEDTLJBD1gHFxl5mse1QS9
    Jw+BZ+bUbB4AlxCBNKi2L+iQMN+mDp6J/wWJ9mkVW93ASTF5zFwDppScZFYs2Mqi
    6oFtUoNIJ/CWbNAcp7DiE8tFlhLcj8ySnqYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524244058; bh=XmzS3BbS8RvGRZw/cVzwaz6A93kOT3lYGPK0fyijxn
    M=; b=fPLNSXWX4b1np2ENAw0cWiH5XovTo48vKxS8ywxIpmo88OKjgPz6sh/BkJ
    RKONfngyS1oy9h1AGpS0LbKULPuaKLAMDO5XgLIL77uCxGD22vMWZYDDojNY1CO2
    2NDFLOxEfosZ+1f0STr/rPCjOFA9BzFPJ9bB0VtuuvfvT2CWWVio32AKsDGlewtX
    X+eRi2Uo2xAuVsqJEnjlvh3371h6fUK8AdVDXefk1/B2X9Px56/WlrzFoh37cM21
    7LsOrQU/Zzh8KuGKumKEGRbecD0cFbVDfrLVlwm452KbFnG7jmjZlqeqKAWh+XMa
    M263syfuBnhJBHYegi+cVFHR8XGA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=ZdznHRVF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UnLhrgch;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=ZdznHRVF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UnLhrgch;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLoCdQoEEIhLwTjbFYSRNwhmtB2g2M7QaZQ0u8u6YOicdny4POV2mycFlXSVTNdB/OTujG2ynbr0UV97vkzVQIw9YsxVU6D5lGEbZyLOUrg/VkzMvvgS
    SQXFcpmhUfJCPRf0hfE5zS2yJuU0Yu7TPStTsRa9GsYlH3ovEnAErCDggYq3e8djoONbpDQn4qXJaBlKXPArlJr8fyRw96171/K9ijEuLitcOOxvf3R/kOtA
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=Xbb7MykS8d5ztlKFQX0A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753810AbeDTRH0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 13:07:26 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:38898 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753608AbeDTRHY (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 20 Apr 2018 13:07:24 -0400
X-Google-Smtp-Source: AIpwx49dUZ7QNTfqaEE1KEES7r/NDbApS01sIzNo7eQ7CPFgID0P8xcJgk8dZrZHDveEcGXPXkGTAKWPqagcQt+AtkU=
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1804201010110.1407-100000@iolanthe.rowland.org>
References: <20180420002752.181261-1-ravisadineni@chromium.org> <Pine.LNX.4.44L0.1804201010110.1407-100000@iolanthe.rowland.org>
From: Ravi Chandra Sadineni <ravisadineni@google.com>
Date: Fri, 20 Apr 2018 10:07:02 -0700
Message-ID: <CAOGSYL3umc6xD4sJDGcUh44-hs-ctLRQXaH5oMaD8riKMYk73g@mail.gmail.com>
Subject: Re: [PATCH V2] USB: Increment wakeup count on remote wakeup.
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

On Fri, Apr 20, 2018 at 7:12 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 19 Apr 2018, Ravi Chandra Sadineni wrote:
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
>> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
>> ---
>>  drivers/usb/core/hcd.c |  2 ++
>>  drivers/usb/core/hub.c | 10 +++++++++-
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>> index 777036ae63674..ee0f3ec57ce49 100644
>> --- a/drivers/usb/core/hcd.c
>> +++ b/drivers/usb/core/hcd.c
>> @@ -2374,7 +2374,9 @@ static void hcd_resume_work(struct work_struct *work)
>>  void usb_hcd_resume_root_hub (struct usb_hcd *hcd)
>>  {
>>       unsigned long flags;
>> +     struct device *dev = &hcd->self.root_hub->dev;
>>
>> +     pm_wakeup_event(dev, 0);
>>       spin_lock_irqsave (&hcd_root_hub_lock, flags);
>>       if (hcd->rh_registered) {
>>               set_bit(HCD_FLAG_WAKEUP_PENDING, &hcd->flags);
>
> In general, hcd->self.root_hub is guaranteed to be non-NULL only when
> hcd->rh_registered is set.  Therefore the assignment to dev and the
> call to pm_wakeup_event() should be moved within this "if" statement.
>
> The rest of the patch looks okay.

Added the check in V3.  Thanks.
>
> Alan Stern
>
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index f6ea16e9f6bb9..aa9968d90a48c 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -653,12 +653,17 @@ void usb_wakeup_notification(struct usb_device *hdev,
>>               unsigned int portnum)
>>  {
>>       struct usb_hub *hub;
>> +     struct usb_port *port_dev;
>>
>>       if (!hdev)
>>               return;
>>
>>       hub = usb_hub_to_struct_hub(hdev);
>>       if (hub) {
>> +             port_dev = hub->ports[portnum - 1];
>> +             if (port_dev && port_dev->child)
>> +                     pm_wakeup_event(&port_dev->child->dev, 0);
>> +
>>               set_bit(portnum, hub->wakeup_bits);
>>               kick_hub_wq(hub);
>>       }
>> @@ -3434,8 +3439,11 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>>
>>       /* Skip the initial Clear-Suspend step for a remote wakeup */
>>       status = hub_port_status(hub, port1, &portstatus, &portchange);
>> -     if (status == 0 && !port_is_suspended(hub, portstatus))
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

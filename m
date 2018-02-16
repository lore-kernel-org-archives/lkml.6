Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3785732-1518769604-2-4831530838794460511
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
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518769603; b=fM7xOyozRcmNBi/oIZtoIwWRzMBcjWnBNlAOluvNOftN8Xk
    gCVOTgbQf78FmaUQsW1G4qLJs27gYKFv35l4AgFOXHIPQGCBtk4noUp8jfZgPUxh
    va+Rptkyun7oZev4TXG21psOCO1MaWUHjd+0NHaC8uSYl0Z3X88gjY22gTtIcsg7
    v8BBMObmllLUYROjDg/TBuSkshVQEyabo96v1pTgnjKnVa/UH5lNLPDHhki9VhrB
    hCjatyj+EKAyJV42/qIuD3sAKjdhp1fehGIoGmznnexrT1uH2pCr20DgixnxtdJQ
    /VW3eWjQg8NZ7Kk6iSIW2/Qu1ApIfRrJ5W0Pkdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518769603; bh=n94Rt4cxefnwNAs0rZq20vpEH4mufsZBE9FMc2/9fbQ=; b=T
    xBjBWpyd/iGbTcx18rSxDCOfaL0sC66V08kdjg2hxSCz+93WMkR7ZqHjLKRfAVjP
    ajl0qqns4RZ/kfN5RkllVmMfiYqDxAHZFXXWnSVVH5Wi2TiCZqxdcQU8RYV6DXBA
    TH2E9+1PQMtHba9C9Gror+XnLiFSWh9CaCXgUO3p38qapYS6RTzlGNIPnUcAnMHg
    kJxSdPGCZyx42uIkuzWeQ+5SEccK32fQ618kWHlKJk+5+8IB4KO/cwGo8u4OioPT
    BGmPxmAfKmlwzYaNUmvYeTZCgYmZUSq8SrF8t+JFN9W+NOjQVI0BTMlDiMmGxsRR
    LqsiWI436DDZt+bCxz62Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MwlnuFou;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MwlnuFou;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754192AbeBPI0m (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 03:26:42 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38781 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754187AbeBPI0k (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 03:26:40 -0500
X-Google-Smtp-Source: AH8x22701AHeIaNWOmjw+dqPEPDObapxT/9NdZzXlES9UzlMuV5Ty7ZE16cR5kqClB2cQxSV/iFdSQ==
Subject: udev USB autosupend whitelist (was Re: [PATCH] Bluetooth: btusb:
 Restore QCA Rome suspend/resume fix with a "rewritten" version)
To: Brian Norris <briannorris@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, stable@vger.kernel.org,
        Leif Liddy <leif.linux@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Drake <drake@endlessm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        matadeen@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
 <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com>
 <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <0a13d0f3-8e0d-74df-df9c-2bf0622a9fb6@redhat.com>
Date: Fri, 16 Feb 2018 09:26:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Going a bit off-topic here, so changed the subject.
I will reply on topic in another mail.

On 16-02-18 03:27, Brian Norris wrote:
> Hi Hans,
> 
> On Tue, Feb 13, 2018 at 12:25:55PM +0100, Hans de Goede wrote:
>> On 13-02-18 03:24, Brian Norris wrote:
>>> On Mon, Jan 08, 2018 at 10:44:16AM +0100, Hans de Goede wrote:
>>>> Commit 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
>>>> removed the setting of the BTUSB_RESET_RESUME quirk for QCA Rome devices,
>>>> instead favoring adding USB_QUIRK_RESET_RESUME quirks in usb/core/quirks.c.
>>>>
>>>> This was done because the DIY BTUSB_RESET_RESUME reset-resume handling
>>>> has several issues (see the original commit message). An added advantage
>>>> of moving over to the USB-core reset-resume handling is that it also
>>>> disables autosuspend for these devices, which is similarly broken on these.
>>>
>>> Wait, is autosuspend actually broken for all QCA Rome chipsets? I don't
>>> think so -- I'm using one now.
>>
>> And have you manually enabled USB autosuspend for it, or are you
>> running something which might have done so, e.g. powertop --auto-tune ?
>>
>> Because if you did not do that then you're already not using autosuspend
>> for your QCA devices and this patch will change nothing.
> 
> I use a set of udev rules that manually whitelist devices for
> autosuspend. You can see it here:
> 
> https://chromium.googlesource.com/chromiumos/platform2/+/43728a93f6de137006c6b92fbb2a7cc4f353c9bf/power_manager/udev/gen_autosuspend_rules.py#83
> 
> You'll find at least one Rome chip in there.

Oh, that is a very interesting link for the work I've been doing to
improve Linux power-consumption in general:

https://fedoraproject.org/wiki/Changes/ImprovedLaptopBatteryLife

I was actually planning on at least doing such a list for WWAN modems,
for btusb my approach has been to just enable it everywhere
(except for QCA devices as I got bugreports for those).

Note that I plan to eventually submit this whitelist to the
udev rules which are part of systemd upstream, so if chromeos
is using systemd too, this is something to be aware of for you.

Question, is the white-listing of the root and rate-limiting
hubs really necessary? I thought these have this enabled by default?

Also any caveats here I should be aware of?

Regards,

Hans

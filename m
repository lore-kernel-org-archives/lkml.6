Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4104350-1519815295-5-15662689654369034548
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519815295; b=tQpmD7Rngr5/HA8CWKrLflrPGRmNG5GEtGS2CsEL/BjW22q
    SPa4+qlL7uHfbMa3hNXcUTcmbKZ1Dee3BLm1nSRatW3riad4Sxefn32cT3/oiQp7
    /SRVbeE3X7TOUrbre6DALw2UHBhgboINmDZZdMZECVggFG3+/SETII3kgkxDaUQe
    f4PE95EG8yga959M6YEEZa5vP5XzvAxenYew3ndvK+u7P6g4rcLisM40ciSiTSdM
    77hcWThC1dXAmRqfDAXv4h7pQTM04kfNiTbul+X887wuQBfnAbQrvHgFV4hZZFyv
    W0mDAURkmtphZ/FkhXixg53eKJPqN9GTnvjXSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519815295; bh=5adZn0gfQcto6bBpcshyK4KcQSnzH63U/VLwsLg1HVs=; b=u
    RI3m0m4EtfswRMvg8o8AOba2rfWzQjmGCZ46y8gw6lkR612yN6+QZIAgdzIQyXJY
    /x5ob1mFHqPv1F4tF8tiBX1Fji6jUzUPJIxNH4TDMY/pWJP8wugi7s4Jub5rcq5X
    E+vsdJA00MSrI5HuTAjezMnAlFv1V5N2s7vfR+vKsmMvwfyM7OCMOZ4ohhIXD733
    jSscZzH0HcMHAlpP4OqIfRoJYq5oRIfMOwSezR3L4UQYmcveV2HRMuyCKsp7fdTL
    5tp20oCJV8+I4f8w44eWjEFRrWt51dKpow851ad5M7xj7BbNPIQ+8HDNNq7Dq+pD
    uGBexmGoAFU+q2y8GHVrA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sKH9+V4c;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sKH9+V4c;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752473AbeB1Kyk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 05:54:40 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38024 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752477AbeB1Kyh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Feb 2018 05:54:37 -0500
X-Google-Smtp-Source: AH8x224B8RSDlvL48frwuBgkJitHZatStt1lIDaHdQSyOzdOG6NmHbBQb6N5WPOv6kRLmTKHyI4FDQ==
Subject: Re: [PATCH] Bluetooth: btusb: Restore QCA Rome suspend/resume fix
 with a "rewritten" version
From: Hans de Goede <hdegoede@redhat.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Leif Liddy <leif.linux@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Drake <drake@endlessm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matadeen Mishra <matadeen@qti.qualcomm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
 <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com>
 <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
 <345b0de8-1a23-d2f8-bc56-507eadf7faa7@redhat.com>
 <6B37F6AC-1103-4FCF-A5DC-4BA236A7B11B@holtmann.org>
 <1a08612e-2531-3711-ec0f-a867e86d0009@redhat.com>
 <20180216175955.GA80944@rodete-desktop-imager.corp.google.com>
 <a846c1ac-7dea-a30a-4133-32eac606d101@redhat.com>
 <20180223031216.GA230265@rodete-desktop-imager.corp.google.com>
 <a6090910-7941-b194-c094-7ce3ef047974@redhat.com>
 <CA+ASDXOGhi4t2R5qrbXHTFkjtzvUL=qHxkJqku4XKJ6u8Wr+cg@mail.gmail.com>
 <cdf043ef-b7d5-61f9-b8ea-7e75cb22485f@redhat.com>
Message-ID: <1711ebe8-8d1a-7d96-bcbe-17238988557a@redhat.com>
Date: Wed, 28 Feb 2018 11:54:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cdf043ef-b7d5-61f9-b8ea-7e75cb22485f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 27-02-18 15:07, Hans de Goede wrote:
> Hi,
> 
> On 27-02-18 03:29, Brian Norris wrote:
>> On Thu, Feb 22, 2018 at 11:14 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>>> On 23-02-18 04:12, Brian Norris wrote:
>>>> Hmm? I'm not sure I completely follow here when you say "he was not
>>>> hitting the firmware loading race". If things were functioning fine with
>>>> system suspend (but not with autosuspend), then he's not seeing the
>>>> controller (quoting commit fd865802c66b) "losing power during suspend".
>>>
>>>
>>> He was running a kernel with the original "fd865802c66b Bluetooth: btusb:
>>> fix QCA Rome suspend/resume" commit, which fixes regular suspend for
>>> devices which are "losing power during suspend", but does nothing for
>>> runtime-suspend.
>>>
>>> He ran tests both with and without runtime-pm enabled with that same kernel
>>> and he needed to disable runtime-pm to get working bluetooth.
>>
>> Did he ever test with commit fd865802c66b reverted?
>>
>> My symptoms were exactly the same as you described. BT was broken as
>> of v4.14 if I had runtime suspend enabled. Things were fine if I
>> either (a) reverted the patch or (b) disabled runtime suspend. I
>> obviously preferred (a), which is why I continued to complain :)
>>
>> Did your tester ever try (a)? If not, then I don't think you've really
>> ensured that he really needed a "fixed" version; he may not have
>> needed the patch at all.
>>
>> Or an alternative question: did that system work on an older Fedora
>> release (and presumably an older kernel)? If so, then he probably also
>> did not need that patch.
>>
>>>> So, that would suggest he could only be seeing the race (as I was), and
>>>> that his machine does not deserve a RESET_RESUME quirk?
>>>
>>>
>>> I hope my above answer helps to clarify why I believe the quirk is
>>> necessary on his machine.
>>
>> I'm sorry, but no it doesn't. If anything, it suggests to me even more
>> that it may not have been necessary.
> 
> Ok, I've started another test-kernel build for the reporter this time
> without any quirks at all and I've asked him to test.

You were right, the Yoga 920 works fine without any quirks, thank you
for being persistent on getting this tested properly.

I will submit a patch dropping the Yoga 920 from the
btusb_needs_reset_resume_table.

Regards,

Hans

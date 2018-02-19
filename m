Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-260566-1519052403-2-10013328398180357266
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
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519052403; b=EI3KL5InKU1am1ViqemmjpHp1rePhM7v4sCrQuRGNcIjsFH
    wP8gIvEm101WO++aK1BIgXZ91PqyQQcpsLzB7/b78RpS84w7yEAIHzO5ptmW2609
    mzletcLEI3g3K5lmJq1zbzaCeCSHyRoYWhNXjRP5JeQhq2Wwk6sjdsi/2JXhuBuJ
    +rTxuiiZvwdEKXfmmmwAfUUJUWiyH2Hc+4/T2JDj484GYes5cEsXiTugjbCz5zVu
    gm/aB0g1X+I54TlbFsaSLk3QqUrQN2hces9g0hVs+be6HBqFOCS8RR7QtgDnGgnQ
    p+w9Dh6/6L1JoJ3kE/IxbUYmhFM3qvwttMPy6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519052403; bh=Yo1i4k44ITu7kagek1uia/TqCT3zWd4XFj/71ZE67zQ=; b=C
    viIaYZvxJxV3VEJRj8wWwSPykCUfLDBp0/o5Zi32Fw2mkDw5ugmWKBga8W3Ijidx
    lf59fhfwE1QdkC/nsjA7f6t7Lch3AM2jghBBZhRHSzQKmo2OkPj/J2jxWwlwnSlt
    /C6rXi8CxOA6Q/+tpGVWQotIjfCrU59SrQH6mzZ1kU4/4G4E/kHdQvHy4KP6eZwH
    opif5S9egOTbEH8K17Z8m6mPNDtsEvCvNYF3ZcEfCGJ/OWIdiPSZvSPQ3zI5+SOR
    T3LkuGTUuh6J+SXjNimD8/ZisjODOSKuGOsagYQWL+3Ieu7WGnOPBK7Ti1UzFqBh
    BXS09USK70qXWW9jPKCzg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=V3Fi2tmq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=V3Fi2tmq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeBSO7s (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 09:59:48 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:53949 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753020AbeBSO7q (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 19 Feb 2018 09:59:46 -0500
X-Google-Smtp-Source: AH8x226Psv2HuJDC+P/Qm44yTH29ydkmyAy3zFRzqUA63jYknIaTcr7bULf4XyHavNhw8VqvBuH1/Q==
Subject: Re: udev USB autosupend whitelist (was Re: [PATCH] Bluetooth: btusb:
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
        Guenter Roeck <linux@roeck-us.net>,
        Benson Leung <bleung@chromium.org>
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
 <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com>
 <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
 <0a13d0f3-8e0d-74df-df9c-2bf0622a9fb6@redhat.com>
 <20180216164924.GA72213@rodete-desktop-imager.corp.google.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <28da6a0a-cda6-82f1-9200-4a0bb30c0663@redhat.com>
Date: Mon, 19 Feb 2018 15:59:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180216164924.GA72213@rodete-desktop-imager.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 16-02-18 17:49, Brian Norris wrote:
> + Benson (and there are probably others that know better answers)
> 
> Hi,
> 
> On Fri, Feb 16, 2018 at 09:26:37AM +0100, Hans de Goede wrote:
>> Going a bit off-topic here, so changed the subject.
>> I will reply on topic in another mail.
>>
>> On 16-02-18 03:27, Brian Norris wrote:
>>> I use a set of udev rules that manually whitelist devices for
>>> autosuspend. You can see it here:
>>>
>>> https://chromium.googlesource.com/chromiumos/platform2/+/43728a93f6de137006c6b92fbb2a7cc4f353c9bf/power_manager/udev/gen_autosuspend_rules.py#83
>>>
>>> You'll find at least one Rome chip in there.
>>
>> Oh, that is a very interesting link for the work I've been doing to
>> improve Linux power-consumption in general:
>>
>> https://fedoraproject.org/wiki/Changes/ImprovedLaptopBatteryLife
>>
>> I was actually planning on at least doing such a list for WWAN modems,
>> for btusb my approach has been to just enable it everywhere
>> (except for QCA devices as I got bugreports for those).
>>
>> Note that I plan to eventually submit this whitelist to the
>> udev rules which are part of systemd upstream, so if chromeos
>> is using systemd too, this is something to be aware of for you.
> 
> Chrome OS does not currently use systemd, but thanks for the heads up.
> 
>> Question, is the white-listing of the root and rate-limiting
>> hubs really necessary? I thought these have this enabled by default?
> 
> This list is old and maintained by several of my team, originating from
> quite a ways back (i.e., much older kernels). It's quite possible that
> some of it is redundant today.

Ok, I double checked and it seems that explicitly setting power/control
to auto for any USB hub is not necessary as they all default to auto
now.

So FWIW you may want to consider removing this.

Regards,

Hans

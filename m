Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3668840-1524604605-2-10999747372748242015
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524604604; b=Q8ZlZMC4/R72KoN5xIzIuD43ejn97InwpfyhPmYdEBLhlfr7+P
    ZG4TCRh9VexWz/ef6uTw2xxD59oq/9hdwKA1rlKyz3YTKIk/wRWq+AaR3U76/Lor
    fuBFMhdFp+SLtnsp+hoaAnZdUgPmj5fl82RAbNImLnYhlFgLRXkJKB+Uu4ZDzsKX
    sj65HspgFHZVQIYbDNyn0Be+rnaKERjz8nlHIv8655fmwVhdZNY1Pvtg/MYXlIsS
    7vb2xg3iSwIYlf++qqHWzoSgdegHF6l/DHbXXg/bfn8ESO4q6Ga1PVZMq30LSefZ
    0xR+JSs8lZkyhCxJi6fv8PiwVcKjJjQBi5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524604604;
    bh=3RGm8F/mD4UFyjaDpiXMNXUMnwhSPMEJI96VtqAa8oI=; b=aSD9Thhqqqck
    e8l5lKwksW+KZ5k0BuNYXhgEOGhuAQYQVHuxwcaHM63FK2uhBzy1ReBaakJVy3XA
    BxkFcLoqOOZFYcAe0Xwgd58uQNjTAOlHy4U+x3WoolDBadkZ4IEvICTz2SZUn5cL
    S/Up0IA5f5DrvngaNqT1L1LJU4vUaFZI29Ff9YDQ72MT1Mqh6zzQtaqUF1XVhDTS
    nMBSd5fRp8Y5Z1JJrrL2fwWjtJy8zT2TYmhPnTFrW1RU6FvCjmI8YfNLdbRZu/Bx
    LvAfpE6eOiVuejyJXW+zPSIk2K0nmXnu3I0vrL9w68gtbldsr9N7VfgVdtrcwRtp
    wmOfIokGEw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RX41al+V;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RX41al+V;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO8GeIH17k/zEYbwSJkFjzxHobK/avvy59i9o9vpQcL1AQfTAJtu6MdnjoigHQNVVadH0fc/GRDQIoENIHaoBLj0GCyWTAgTc7GQlT0QYOAHj4a4q0Cp
    rdEPihjYM0ffvBZK6cbHZAc9dML6LUf+7UeOGUd8J0jRbL6p5Q11toXMu63b35dUuJDLwbwmOO6kk58qs6OodMTzz1biFjk8u45hIONVuqZKfuohBD2w1lHC
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=75vZwA43Owu-q9OazF4A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbeDXVQm (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 17:16:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51118 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeDXVQl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Apr 2018 17:16:41 -0400
X-Google-Smtp-Source: AB8JxZrlUb4xv1W2pG5uu0aR8Zy8vUNQy53tEvsq8yjhZ4JEMrwpUg67Qr7ntLbv4+aot0AV34Nofg==
Subject: Re: [RFC][PATCH 0/1] serdev: Support HS-UART serdev slaves over tty
To: Johan Hovold <johan@kernel.org>,
        Shrirang Bagul <shrirang.bagul@canonical.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
References: <20180424082954.11453-1-shrirang.bagul@canonical.com>
 <20180424171846.GD4615@localhost>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <b4947b3c-15b3-15ea-e1b7-38169f11d0f9@redhat.com>
Date: Tue, 24 Apr 2018 23:16:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424171846.GD4615@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 24-04-18 19:18, Johan Hovold wrote:
> [ Adding some more people on CC. ]
> 
> On Tue, Apr 24, 2018 at 04:29:53PM +0800, Shrirang Bagul wrote:
>> On systems using Intel Atom (Baytrail-I) SoC's, slave devices connected on
>> HSUART1/2 ports are described by the ACPI BIOS as virtual hardware using
>> HID's INT3511/INT3512 [1].
>>
>> As a consequence, HW manufacturers have complete freedom to install any
>> devices on-board as long as they can be accessed over serial tty
>> interface. Once such device is Dell Edge 3002 IoT Gateway which sports
>> ZigBee & GPS devices on the HS-UART ports 1 & 2 respectively.
>>
>> In kernels before the introduction of 'Serial Device Bus (serdev)'
>> subsystem, these devices were accessible using /dev/ttySx nodes. But,
>> kernels since 4.15 can no longer do so.
>>
>> Post 4.15, with CONFIG_SERIAL_DEV_BUS=y, serdev port controller driver
>> handles the enumeration for the slaves connected on these ports. Also,
>> /dev/ttySx device nodes for these ports are no longer exposed to the
>> userspace.
>>
>> This patch implements a new driver which binds to the ACPI serdev slaves
>> enumerated by the serdev port controller and exposes /dev/ttyHSx device
>> nodes which the userspace applications can use. Otherwise, upgrades to 4.15
>> or higher kernels would certainly render these devices unusable.
>>
>> Considering serdev is new and evolving, this is one approach to solving
>> the problem at hand. An obvious drawback is the change in the tty device
>> node name from ttySx => ttyHSx, which means userspace applications have to
>> be modified (I know that this is strongly discouraged). For the same
>> reason, I am submitting these patches as RFC.
>>
>> If there are other/better ways of solving this or improving on the
>> proposed solution, that will be most helpful.
> 
> Yeah, I don't think this is the right solution to this problem. It seems
> we need to blacklist (or maybe even use whitelists) ACPI-ids until there
> are drivers for the slave devices that would otherwise be claimed by
> serdev.

FWIW I've been using this patch for a while for realtek UART attached bluetooth:
https://github.com/jwrdegoede/linux-sunxi/commit/bc904e3703940600ca66c65fcdb0a8cb01dff55d
which is a gross hack.

If we're going to do a whitelist for this, it better support some sort of
wildcards as there are a LOT of BCM2E?? devices which need to be on the
whitelist. I think a blacklist would actually be better though, this also
documents which devices are lacking a proper kernel (where applicable).

Regards,

Hans


> 
>> This patch is based on:
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v4.17-rc2
>>
>> [1] Enabling Multi-COM Port for Microsoft Windows OS 8.1 & 10 / IoT Core [Sec. 4.1]
>> (https://www.intel.com/content/dam/www/public/us/en/documents/white-papers/enabling-multi-com-port-white-paper.pdf)
> 
> Thanks,
> Johan
> 

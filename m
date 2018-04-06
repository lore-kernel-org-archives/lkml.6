Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-784116-1522999342-2-10125088842916318580
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522999342; b=C4gARzFC7O2E+hDwJpuN7R+b559UP3WDUMJ4nRNQaX41hUaVSX
    T+NiLEI6hvfAuKllgm1g0GTh/5VfvDSk/OFh+w4LeWSOH66EhwVkcxdThCaGuToA
    WDDI6kyu9yBg4BGEVx9o1+EcS1W1Lqu2gAW/mdcnh1ZIho0HvrbZliNV/OF5ULXN
    2E2ZEbV1yAmLDiK/S3pctoZ0PT+i8inkRxbjBkLNjnqGcQiw+5qd/iNJlbRP8LhK
    X7p4U5u0CzEwX3s2qwy+8GVxdHcWxXCh8yMvbuw7DT57FsrxBPK7oUdkUrWFrlbq
    2r1tLlayOPrKS1s7yxp7nErookb4mnb41gCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522999342; bh=QYlQDef4qdsajDGLAxN8a82OgagfP0Mlf8GG+zEe9o
    w=; b=Th3KwEOb4J4etHWDmfA5SKCkB9VoEO45r9VUg+Fg+XE2f9a6waYRcr/m+f
    9pVgooewItw/o0nlhbeEzzDhS1R/ZtWeU2OA0WQBD4UiirsCUXoLgjP1E5WXkwpL
    nES4mYBJMZLCqBHeua1y9A+gFV5dSuDLzOJyhay28ECGpN7rIoQb4ge3uo0IsQYJ
    NcC0dLRBn7jL8Py9i7hsGJ7ILUwI+ga47txS0h0jEIWHAhzirXVyr6+rWXTaYYeZ
    IsRSo1seV10kq6M+7KIlQ7lkPVkYD+9+mv27Lo6wD4maDQp8Vv4UQY48IggauVaV
    1YfYJBnfeT7tU8PJ5asGQmtatqng==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TVTkfrFv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PDv4dLbr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TVTkfrFv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PDv4dLbr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBlf5y3pBs87bo6vCtL1TSWwfgM0AZJzJNVpuOmnMk6TNi6ByQnv0xGxLxmspSsHan4TFGUQyeM8MgRzhJaUqgOGczQUqJGXN16+53yGYdin4vzk4woz
    TY4lqnYvtcsl2DXdYfC2FkiZHA5k6z21KK/OBE9eD0JUyails3OCBA8crR7KHye4pdm6eTCTHsX7zzZLcS++oRS5P/l0HnsdrYmJZCnEKDrK97C9l4780MrB
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=C4IUEKfDdgXLkHnAv2YA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeDFHWU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 03:22:20 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34485 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbeDFHWT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 03:22:19 -0400
X-Google-Smtp-Source: AIpwx4+4SShR73qxvmLrvXuSMfIQHhaLOTOaiXhxgIgqNbANQuswbA/cYZxqBTka+ahgb6AHayqfbEZ+LTQu9LBXE/g=
MIME-Version: 1.0
In-Reply-To: <20180406070938.GE8416@kroah.com>
References: <20180223170742.426320243@linuxfoundation.org> <b9046b98-acb6-c828-661f-ab67696ff1b8@gmail.com>
 <20180406070938.GE8416@kroah.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 6 Apr 2018 09:22:18 +0200
X-Google-Sender-Auth: 1WV13Fm5a0eoGICqZDLXz3JGEOA
Message-ID: <CAK8P3a0_rCMvcaxsi-XeOcdFxQk_FkJ7prOS1ySRAscXXROtnA@mail.gmail.com>
Subject: Re: [4.9, 137/145] spi: bcm-qspi: shut up warning about cfi header inclusion
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 6, 2018 at 9:09 AM, gregkh@linuxfoundation.org
<gregkh@linuxfoundation.org> wrote:
> On Tue, Apr 03, 2018 at 10:46:07AM -0700, Florian Fainelli wrote:
>> On 02/23/2018 10:27 AM, gregkh@linuxfoundation.org wrote:
>> > 4.9-stable review patch.  If anyone has any objections, please let me know.
>> >
>> > ------------------
>> >
>> > From: Arnd Bergmann <arnd@arndb.de>
>> >
>> > When CONFIG_MTD_CFI is disabled, we get a warning for this spi driver:
>> >
>> > include/linux/mtd/cfi.h:76:2: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work. [-Werror=cpp]
>> >
>> > The problem here is a layering violation that was fixed in mainline kernels with
>> > a larger rework in commit 054e532f8f90 ("spi: bcm-qspi: Remove hardcoded settings
>> > and spi-nor.h dependency"). We can't really backport that to stable kernels, so
>> > this just adds a Kconfig dependency to make it either build cleanly or force it
>> > to be disabled.
>>
>> Sorry for noticing so late, but this appears to be bogus, there is no
>> MTD_NORFLASH symbol being defined in 4.9, in fact I can't find this
>> Kconfig symbol in any kernel version, so this effectively results in the
>> driver no longer being selectable, so this sure does silence the warning.
>>
>> Arnd, should we just send reverts of this patch for the affected kernel
>> or should we be defining MTD_NORFLASH somehow? Am I missing something here?
>
> I'm going to revert this patch for now, thanks.

Yes, please do. Sorry for missing Florian's bug report. I looked at it again
and found that it was never intended for backports to 4.9, as the regression
addressed by the patch was originally merged into 4.14-rc1.

       Arnd

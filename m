Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759575AbeD1GoJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 02:44:09 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:46311 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752083AbeD1GoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 02:44:06 -0400
X-Google-Smtp-Source: AB8JxZrHDbII6yJkNqhGM2ZF64DvXWroqoZTbVr3OEu8kBzlT9qRVxcLvZ7r+McHHtZqGuWYjX5VZSevlJ0MogA8GM4=
MIME-Version: 1.0
In-Reply-To: <CAChtp74P5iXZjtooR5e1PgmNYU7qD07GSyKo9GV-3ObR1zGvHw@mail.gmail.com>
References: <20180310171244.70299-1-npcomplete13@gmail.com>
 <CACna6rz1TeRbPq-60HkHz9A0TDn+iXtmXniE6FCiANpUmV-qrw@mail.gmail.com>
 <20180311100313.znonhesgh462rz65@osboxes> <2ef6e4fc-cce7-372e-e35f-578fd6ada9ca@gmail.com>
 <20180313010210.ws4dugy3rrpqwzmk@osboxes> <00df9ee9-2bd2-ad2b-fdf8-682efdb9a4d1@gmail.com>
 <20180427140542.c3t5taztkciimfny@osboxes> <CAChtp74P5iXZjtooR5e1PgmNYU7qD07GSyKo9GV-3ObR1zGvHw@mail.gmail.com>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date: Sat, 28 Apr 2018 08:44:04 +0200
Message-ID: <CACna6rzxXt-v=kwMHsBSmALDEJrN27OTRN9WAyPoc1FkjwxAhg@mail.gmail.com>
Subject: Re: [PATCH] ARM: BCM5301X: Fix NAND ECC parameters for Linksys Panamera
To: Vivek Unune <npcomplete13@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3S6iHZK000859

On 28 April 2018 at 06:19, Vivek Unune <npcomplete13@gmail.com> wrote:
> On Fri, Apr 27, 2018 at 10:05 AM, Vivek Unune <npcomplete13@gmail.com> wrote:
>> On Wed, Apr 25, 2018 at 11:02:04AM +0200, Rafał Miłecki wrote:
>>>
>>> The easiest solution: ignore all these "error -74 (ECC error) while
>>> reading" errors (they may last for few minutes!). I believe UBI should
>>> simply recreate all pages it couldn't access and once you wait long
>>> enough, all your NAND flash will be using BCH8.
>>
>> Let me build the firmware with BCH-8 and wait it out. I'll report back my
>> results.
>
> I can confirm that BCH-8 indeed works after letting it run through those
> ECC errors.
>
> Thanks!

Great, thanks! That controller behavior (reading BCH8 fine while
working in BCH4 mode) is really confusing.

-- 
Rafał

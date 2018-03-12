Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932256AbeCLWSB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 18:18:01 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:34650 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbeCLWR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 18:17:58 -0400
X-Google-Smtp-Source: AG47ELvaanM3CxZikVuO5SiIRKw2pDl5EjojYLYYL/47jPvq4ET/6xPi6WccKcjDj72orJuppEjGcJoO8QsfPAQ11/E=
MIME-Version: 1.0
In-Reply-To: <20180312220751.GA1757@light.dominikbrodowski.net>
References: <4716007c23abeb0e42015786794539454aff487b.1520886814.git.dvhart@infradead.org>
 <20180312202319.GA88572@localhost.localdomain> <20180312220751.GA1757@light.dominikbrodowski.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Mar 2018 15:17:57 -0700
X-Google-Sender-Auth: lZopH4aFEXja_rm02b4RrGwLp7Y
Message-ID: <CA+55aFzUgk8c2n7GQfcCdYU-Jo86-W_b51gZCLyJahv_ZWMVsQ@mail.gmail.com>
Subject: Re: Dell Inc. XPS 13 9343/0TM99H fails to boot v4.16-rc5
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Darren Hart <dvhart@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 3:07 PM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> I'm awfully sorry, but this patch doesn't solve the issue.
> CONFIG_ACPI_WMI=y was/is set, but still enabling CONFIG_DELL_SMBIOS_WMI=y
> causes a very-early crash of v4.16-rc5. In fact, so early that the normal
> boot messages never show up on the screen...

Hmm. My xps13 works fine, but it's the 9350 version so not the same machine.

But it does sound like that commit 25d47027e10 ("platform/x86:
dell-smbios: Link all dell-smbios-* modules together") should just be
reverted. It has clearly caused a lot more pain than it fixed.

                Linus

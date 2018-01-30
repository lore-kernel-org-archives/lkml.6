Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbeA3CrC convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 21:47:02 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37883 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752131AbeA3CrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 21:47:00 -0500
X-Google-Smtp-Source: AH8x226D1UoJ+WhBVCckNGsEdDpggR0vNhUFFyd4cVWF69zGVWO8nBVfFGi1XQE3+Vu/ELoKtiTwZQ==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] ACPI: Parse entire table as a term_list for Dell XPS 9570
 and Precision M5530
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAHp75VfQH6ssvp14HSLNGPL=eUVQCnrC-ifoKMuKoCkR1s=3YA@mail.gmail.com>
Date: Tue, 30 Jan 2018 10:46:53 +0800
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <8351B08C-C4C0-49F7-BA60-960D6A5E1FA6@canonical.com>
References: <20180129061011.11214-1-kai.heng.feng@canonical.com>
 <CAHp75VfQH6ssvp14HSLNGPL=eUVQCnrC-ifoKMuKoCkR1s=3YA@mail.gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 29 Jan 2018, at 8:56 PM, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> On Mon, Jan 29, 2018 at 8:10 AM, Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> The i2c touchpad on Dell XPS 9570 and Precision M5530 doesn't work out
>> of box.
>> 
>> The touchpad relies on its _INI method to update its _HID value from
>> XXXX0000 to SYNA2393.
>> Also, the _STA relies on value of I2CN to report correct status.
>> 
>> Set acpi_gbl_parse_table_as_term_list so the value of I2CN can be
>> correctly set up, and _INI can get run. The ACPI table in this machine
>> is designed to get parsed this way.
> 
>> +#ifdef CONFIG_X86
> 
> Why do you need separate #ifdef?
> 
>> +static const struct dmi_system_id gbl_term_list_dmi_table[] __initconst = {
> 
> I think you can just add new items to the existing table, while renaming it like
> 
> dsdt_dmi_table -> acpi_quirks_dmi_table

Thanks for your suggestion, this is a better approach.
I’ll address them in V2 patch.

Kai-Heng

> 
> -- 
> With Best Regards,
> Andy Shevchenko

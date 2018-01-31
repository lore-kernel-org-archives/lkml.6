Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbeAaEUP convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 23:20:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35684 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbeAaEUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 23:20:11 -0500
X-Google-Smtp-Source: AH8x226Q0dNS9HOo5ZlpsIhPjAD0yjoWU7x2r9mJQ8pNS8sc1A3dn01n9ChJLte5mbukCl/xZoWfig==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] ACPI: Parse entire table as a term_list for Dell XPS 9570
 and Precision M5530
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAHp75VdPQuEwNOOakvZpC1gzWB9p5yx+CHUjRgMDZ9ZDvxGckQ@mail.gmail.com>
Date: Wed, 31 Jan 2018 12:20:04 +0800
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <C77D8F2F-285F-4627-9980-6EF94828EEFF@canonical.com>
References: <20180130060744.19049-1-kai.heng.feng@canonical.com>
 <CAHp75VdPQuEwNOOakvZpC1gzWB9p5yx+CHUjRgMDZ9ZDvxGckQ@mail.gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 31 Jan 2018, at 2:17 AM, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> On Tue, Jan 30, 2018 at 8:07 AM, Kai-Heng Feng
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
>> 
>> Also, change the quirk table to a more generic name.
> 
>> +static int set_gbl_term_list(const struct dmi_system_id *id)
>> +{
>> +       pr_notice("%s detected - parse the entire table as a term_list\n",
>> +                 id->ident);
>> +       acpi_gbl_parse_table_as_term_list = 1;
>> +       return 0;
>> +}
>> #endif
> 
> The above should be outside of another #ifdef. Basically after the above #endif.

Right, I overlooked that. Thanks.

> 
>> #else
> 
>> #endif
> 
>> @@ -1005,7 +1034,7 @@ void __init acpi_early_init(void)
> 
>>         * If the machine falls into the DMI check table,
>>         * DSDT will be copied to memory
>>         */
> 
> It might make sense to adjust comment above that it's about quirks in
> general. And, if needed, move current content to actual DMI group of
> records.

Thanks for the suggestions.

I’ll address them in patch v3.

Kai-Heng

> 
>> -       dmi_check_system(dsdt_dmi_table);
>> +       dmi_check_system(acpi_quirks_dmi_table);
> 
> -- 
> With Best Regards,
> Andy Shevchenko

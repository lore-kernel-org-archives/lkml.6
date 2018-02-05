Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbeBEFGt convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 00:06:49 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42151 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbeBEFGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 00:06:46 -0500
X-Google-Smtp-Source: AH8x224fm+wqk3/27fijb2mA1dnSreZCM5PPgUW7zEeuRLEM3yk1PiYeY9I1OVl17O4gvWmCy4nxDw==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.9\))
Subject: Re: [PATCH v3] ACPI: Parse entire table as a term_list for Dell XPS
 9570 and Precision M5530
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAJZ5v0ha9xZVSvUjUPO5ebM+JhPH7jk6W=M8AheirqOrhf8Ezg@mail.gmail.com>
Date: Mon, 5 Feb 2018 13:06:37 +0800
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <334D3FD8-FF56-410C-8B33-B973EDFDD7D7@canonical.com>
References: <20180131045634.13328-1-kai.heng.feng@canonical.com>
 <CAJZ5v0ha9xZVSvUjUPO5ebM+JhPH7jk6W=M8AheirqOrhf8Ezg@mail.gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: Apple Mail (2.3445.6.9)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 4, 2018, at 4:26 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> 
> On Wed, Jan 31, 2018 at 5:56 AM, Kai-Heng Feng
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
>> 
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198515
>> Cc: Mario Limonciello <mario.limonciello@dell.com>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> v3: Put the function under right #ifdef, comment adjustment
>> 
>> v2: Andy's suggestion, merge to a single quirk table.
>> 
>> drivers/acpi/bus.c | 40 +++++++++++++++++++++++++++++++++-------
>> 1 file changed, 33 insertions(+), 7 deletions(-)
>> 
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 4d0979e02a28..7cb18bc2b59a 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -66,10 +66,39 @@ static int set_copy_dsdt(const struct dmi_system_id *id)
>>        return 0;
>> }
>> #endif
>> +static int set_gbl_term_list(const struct dmi_system_id *id)
>> +{
>> +       pr_notice("%s detected - parse the entire table as a term_list\n",
>> +                 id->ident);
> 
> This is not a useful message for a user (who may not know what
> trem_list is).  Care to change it to something more useful, or even
> drop it?

Yes, I think it should be dropped. The information is already in the
commit log and comment section, if the user really wants to know
more.

Kai-Heng

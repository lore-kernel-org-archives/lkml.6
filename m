Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755531AbeD3X1T (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 19:27:19 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:56073 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753620AbeD3X1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 19:27:18 -0400
X-Google-Smtp-Source: AB8JxZr5MnCcp1fuL86aLxXDTTODPmB0BA63Kg5/OPdoYah+yxdaepPkujnqSkbAnOYluEmhbRJI4w==
Reply-To: ahs3@redhat.com
Subject: Re: [PATCH v2 1/3] ACPI: improve function documentation for
 acpi_parse_entries_array()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
References: <20180424193505.6934-1-ahs3@redhat.com>
 <20180424193505.6934-2-ahs3@redhat.com>
 <CAJZ5v0h+TcJg5iNFOFQYiXKmuN3+PWe8akx_0BT6jdfZ71yNwg@mail.gmail.com>
From: Al Stone <ahs3@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b3cc349d-d264-c0cf-9141-8e421a139b46@redhat.com>
Date: Mon, 30 Apr 2018 17:27:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h+TcJg5iNFOFQYiXKmuN3+PWe8akx_0BT6jdfZ71yNwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27/2018 05:04 AM, Rafael J. Wysocki wrote:
> On Tue, Apr 24, 2018 at 9:35 PM, Al Stone <ahs3@redhat.com> wrote:
>> I found the description of the table_size argument to the function
>> acpi_parse_entries_array() unclear and ambiguous.  This is a minor
>> documentation change to improve that description so I don't misuse
>> the argument again in the future, and it is hopefully clearer to
>> other future users.
>>
>> Signed-off-by: Al Stone <ahs3@redhat.com>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Len Brown <lenb@kernel.org>
>> ---
>>  drivers/acpi/tables.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>> index 849c4fb19b03..21535762b890 100644
>> --- a/drivers/acpi/tables.c
>> +++ b/drivers/acpi/tables.c
>> @@ -222,7 +222,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>>   * acpi_parse_entries_array - for each proc_num find a suitable subtable
>>   *
>>   * @id: table id (for debugging purposes)
>> - * @table_size: single entry size
>> + * @table_size: size of the root table; i.e., the offset from the very
>> + *              first byte of the complete ACPI table, to the first byte
>> + *              of the first subtable
> 
> But alas this needs to be one line.
> 
> You can add more details in the comment body below.

Whups.  Right.  Will do.

>>   * @table_header: where does the table start?
>>   * @proc: array of acpi_subtable_proc struct containing entry id
>>   *        and associated handler with it
>> @@ -400,7 +402,7 @@ int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
>>                 return -ENODEV;
>>  }
> 
> Thanks,
> Rafael
> 


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------

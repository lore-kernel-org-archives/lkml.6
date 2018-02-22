Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbeBVGDx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 01:03:53 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:42505 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752225AbeBVGDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 01:03:52 -0500
X-Google-Smtp-Source: AH8x224F1H+B1vcQS/yZuCpxKs8fYfnHVBadAGdefyvC3ZtJutAtbDr62vaBGj97MC26lNAShznPDQQt6CpBfRubkyY=
MIME-Version: 1.0
In-Reply-To: <1753aad2-6a9b-bf4f-72b9-921587424f79@infradead.org>
References: <20180222003749.GA4724@beast> <1753aad2-6a9b-bf4f-72b9-921587424f79@infradead.org>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 21 Feb 2018 22:03:50 -0800
X-Google-Sender-Auth: TXPfvJqL9daqUquNPw9c-lvrWbI
Message-ID: <CAGXu5jKn_8JSe8i2X9sJ-r4MhHkBVdC6rYMeKCZcBK_LtFJ8rA@mail.gmail.com>
Subject: Re: [PATCH] doc: process: Add "Root-caused-by" and "Suggested-by"
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 8:43 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 02/21/2018 04:37 PM, Kees Cook wrote:
>> As recently pointed out by Linus, "Root-caused-by" is a good tag to include
>> since it can indicate significantly more work than "just" a Reported-by.
>> This adds it and "Suggested-by" (which was also missing) to the documented
>> list of tags. Additionally updates checkpatch.pl to match the process docs.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  Documentation/process/5.Posting.rst | 7 +++++++
>>  scripts/checkpatch.pl               | 2 ++
>>  2 files changed, 9 insertions(+)
>
> I would still rather see Co-developed-by: in both the docs and in checkpatch. :(

Hm? It is in docs. This syncs the process doc to checkpatch...

-Kees

>
>> diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
>> index 645fa9c7388a..2ff01f76f02a 100644
>> --- a/Documentation/process/5.Posting.rst
>> +++ b/Documentation/process/5.Posting.rst
>> @@ -234,6 +234,13 @@ The tags in common use are:
>>     people who test our code and let us know when things do not work
>>     correctly.
>>
>> + - Suggested-by: names a person who suggested the solution, but may not
>> +   have constructed the full patch. A weaker version of `Co-Developed-by`.
>> +
>> + - Root-caused-by: names a person who diagnosed the root cause of a
>> +   problem. This usually indicates significantly more work than a simple
>> +   `Reported-by`.
>> +
>>   - Cc: the named person received a copy of the patch and had the
>>     opportunity to comment on it.
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 3d4040322ae1..a1ab82e70b54 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -464,9 +464,11 @@ our $logFunctions = qr{(?x:
>>  our $signature_tags = qr{(?xi:
>>       Signed-off-by:|
>>       Acked-by:|
>> +     Co-Developed-by:|
>>       Tested-by:|
>>       Reviewed-by:|
>>       Reported-by:|
>> +     Root-caused-by:|
>>       Suggested-by:|
>>       To:|
>>       Cc:
>>
>
>
> --
> ~Randy



-- 
Kees Cook
Pixel Security

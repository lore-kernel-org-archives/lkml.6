Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752490AbeDSNMr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:12:47 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33463 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeDSNMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:12:45 -0400
X-Google-Smtp-Source: AIpwx4+HnSkc9By9kAVFidUtiZzP0BlWJ5MU61IGWdLPMWR6of6VhI7PB+IH+jdfd/O4N+z9aJFOAg==
Subject: Re: [Xen-devel] [PATCH] Input: xen-kbdfront - allow better run-time
 configuration
To: Jason Andryuk <jandryuk@gmail.com>
Cc: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-input@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        dmitry.torokhov@gmail.com, lyan@suse.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180418150445.9805-1-andr2000@gmail.com>
 <ccb7a33b-7862-9803-fb24-67861d5ecab9@suse.com>
 <2bff035e-303e-d644-5f51-5e64150c097c@gmail.com>
 <c833ab0d-746c-c734-3dbe-e02ae7951d1d@suse.com>
 <d935e7d9-090f-a8b1-7f12-5e0a7f0adf1b@gmail.com>
 <CAKf6xpsM03AB-mHaYdpVfipRdtx9uO1rS=bHZdEi3fkfTo6b4g@mail.gmail.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <5ed20b99-263d-d906-9349-d064eead36ad@gmail.com>
Date: Thu, 19 Apr 2018 16:12:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAKf6xpsM03AB-mHaYdpVfipRdtx9uO1rS=bHZdEi3fkfTo6b4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/2018 04:10 PM, Jason Andryuk wrote:
> On Thu, Apr 19, 2018 at 9:01 AM, Oleksandr Andrushchenko
> <andr2000@gmail.com> wrote:
>> Ok, so I'll send v2 with the following changes:
>>
>> diff --git a/drivers/input/misc/xen-kbdfront.c
>> b/drivers/input/misc/xen-kbdfront.c
>> index a3306aad40b0..d8cca212f737 100644
>> --- a/drivers/input/misc/xen-kbdfront.c
>> +++ b/drivers/input/misc/xen-kbdfront.c
>> @@ -51,13 +51,13 @@ module_param_array(ptr_size, int, NULL, 0444);
>>   MODULE_PARM_DESC(ptr_size,
>>          "Pointing device width, height in pixels (default 800,600)");
>>
>> -static unsigned int no_ptr_dev;
>> -module_param(no_ptr_dev, uint, 0);
>> +static bool no_ptr_dev;
>> +module_param(no_ptr_dev, bool, 0);
>>   MODULE_PARM_DESC(no_ptr_dev,
>>          "If set then no virtual pointing device exposed to the guest");
>>
>> -static unsigned int no_kbd_dev;
>> -module_param(no_kbd_dev, uint, 0);
>> +static bool no_kbd_dev;
>> +module_param(no_kbd_dev, bool, 0);
>>   MODULE_PARM_DESC(no_kbd_dev,
>>          "If set then no virtual keyboard device exposed to the guest");
> I prefer direct logic over inverse logic.  Maybe just use kbd_dev,
> default to true, but allow it to be set off?
>
> static bool kbd_dev = true;
> module_param(kbd_dev, bool, 0);
I have no preference here, either way works for me
Juergen, what do you think about the above?
> Regards,
> Jason

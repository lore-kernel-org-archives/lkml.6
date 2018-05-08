Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755915AbeEHVTd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:19:33 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:44437 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755795AbeEHVT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:19:26 -0400
X-Google-Smtp-Source: AB8JxZohIBztqJAR9mY4uwPhtWyMWvC/jPpoKY5RqiiaIuFpPA8vh2+rJxBYd5tZ+nbS3AiWvfGDsA==
Subject: Re: bug in tag handling in blk-mq?
From: Jens Axboe <axboe@kernel.dk>
To: Mike Galbraith <efault@gmx.de>,
        Paolo Valente <paolo.valente@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
References: <999DF2B3-4EE8-4BDF-89C5-EB0C2D8BF69E@linaro.org>
 <7760d23b-7a4c-a645-1c7a-da7569bb44dc@kernel.dk>
 <84145CD7-B917-4B32-8A5C-310C1910DB71@linaro.org>
 <1525755090.24338.1.camel@gmx.de> <1525768632.5208.4.camel@gmx.de>
 <ffd0c030-43f8-0dbe-42b3-03bb9c410bea@kernel.dk>
 <1525797766.5204.2.camel@gmx.de>
 <3692ce7d-a767-72e6-65ae-6178b6c2e7d8@kernel.dk>
Message-ID: <f04636df-3f97-6c16-f37b-d407e062b9e5@kernel.dk>
Date: Tue, 8 May 2018 15:19:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <3692ce7d-a767-72e6-65ae-6178b6c2e7d8@kernel.dk>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/18 2:37 PM, Jens Axboe wrote:
> On 5/8/18 10:42 AM, Mike Galbraith wrote:
>> On Tue, 2018-05-08 at 08:55 -0600, Jens Axboe wrote:
>>>
>>> All the block debug files are empty...
>>
>> Sigh.  Take 2, this time cat debug files, having turned block tracing
>> off before doing anything else (so trace bits in dmesg.txt should end
>> AT the stall).
> 
> OK, that's better. What I see from the traces:
> 
> - You have regular IO and some non-fs IO (from scsi_execute()). This mix
>   may be key.
> 
> - sdd has nothing pending, yet has 6 active waitqueues.
> 
> I'm going to see if I can reproduce this. Paolo, what kind of attempts
> to reproduce this have you done?

No luck so far. Out of the patches you referenced, I can only find the
shallow depth change, since that's in the parent of this email. Can
you send those as well?

Perhaps also expand a bit on exactly what you are running. File system,
mount options, etc.

-- 
Jens Axboe

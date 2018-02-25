Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeBYTuZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 14:50:25 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:32942 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbeBYTuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 14:50:16 -0500
X-Google-Smtp-Source: AG47ELszQgov3d1tTOAS0aCQan25rFlXLo8B7A0FaIe7kCaMm12vdfFhtTUN4WnRZLHEhgp+5Qrd5WQnO8Mv5UANq58=
MIME-Version: 1.0
In-Reply-To: <682e1867-3fd3-3267-f626-724f08481e9c@infradead.org>
References: <20180225124652.76r5tucjebyplw2q@gmail.com> <682e1867-3fd3-3267-f626-724f08481e9c@infradead.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 25 Feb 2018 20:49:55 +0100
Message-ID: <CANiq72mL1yUOJkWDaPRkV2hirnfaUZ_D_dSx8m7g4VcJC=mioQ@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: arm-charlcd: Fix struct charlcd doc line
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linus Walleij <triad@df.lth.se>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2018 at 7:13 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 02/25/2018 04:46 AM, Miguel Ojeda wrote:
>> There was a missing first line and a missing member,
>> which gave a warning under W=1:
>>
>>     CC      drivers/auxdisplay/arm-charlcd.o
>>   drivers/auxdisplay/arm-charlcd.c:57: warning: Cannot understand
>>    * @dev: a pointer back to containing device on line 57 - I thought
>>   it was a doc line
>>
>> Cc: Linus Walleij <triad@df.lth.se>
>> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>> ---
>> Please let me know if anyone does not want this in 4.17.
>>
>>  drivers/auxdisplay/arm-charlcd.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/auxdisplay/arm-charlcd.c b/drivers/auxdisplay/arm-charlcd.c
>> index b3176ee92b90..27cf08a05e93 100644
>> --- a/drivers/auxdisplay/arm-charlcd.c
>> +++ b/drivers/auxdisplay/arm-charlcd.c
>> @@ -54,12 +54,14 @@
>>  #define HD_BUSY_FLAG                 0x80U
>>
>>  /**
>> + * struct charlcd
>
> Can you make that more like:
>  * struct charlcd - <some brief description>
>
> please.  And merged soon would be fine.
>

Sure! I will do:

 /**
+ * struct charlcd - Private data structure
  * @dev: a pointer back to containing device

Cheers,
Miguel

>>   * @dev: a pointer back to containing device
>>   * @phybase: the offset to the controller in physical memory
>>   * @physize: the size of the physical page
>>   * @virtbase: the offset to the controller in virtual memory
>>   * @irq: reserved interrupt number
>>   * @complete: completion structure for the last LCD command
>> + * @init_work: delayed work structure to initialize the display on boot
>>   */
>>  struct charlcd {
>>       struct device *dev;
>>
>
> thanks,
> --
> ~Randy

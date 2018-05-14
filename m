Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754600AbeENPjX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:39:23 -0400
Received: from [195.159.176.226] ([195.159.176.226]:59875 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1752416AbeENPjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:39:20 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: serial: custom baud rate
Date: Mon, 14 May 2018 15:36:56 +0000 (UTC)
Message-ID: <pdcaeo$d04$1@blaine.gmane.org>
References: <CAHhAz+hrmLiRJ77cM=CYj+iyH8aUJ64R6FtAwGqqB2pOS0n0aQ@mail.gmail.com>
 <pcfka2$gie$1@blaine.gmane.org> <20180513205726.5029c88a@alans-desktop>
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: slrn/1.0.2 (Linux)
Cc: linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-13, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
> On Thu, 3 May 2018 18:27:14 +0000 (UTC)
> Grant Edwards <grant.b.edwards@gmail.com> wrote:
>
>> On 2018-05-03, Muni Sekhar <munisekharrms@gmail.com> wrote:
>> 
>> > If I need to set a custom baud rates(e.g. 14400, 128000, 256000), does
>> > Linux serial framework has any supporting method?  
>> 
>> Sure, use the termios2 structure instead of the termios structure:
>> 
>>   #include <linux/termios.h>
>> 
>>   struct termios2 t;
>> 
>>   ioctl(fd, TCGETS2, &t)
>> 
>>   t.c_cflag &= ~CBAUD;
>>   t.c_cflag |= BOTHER;
>>   t.c_ispeed = baud;
>>   t.c_ospeed = baud;
>> 
>>   ioctl(fd, TCSETS2, &t)
>> 
>> [Not all devices/drivers support termios2]
>
> That shouldn't be true - all devices get passed ispeed/ospeed and
> everything in tree was using the correct fields as far as I could
> tell last time I checked this

Yep, my mistake.  It looks like the driver where I last ran into this
was an old out-of-tree driver.

-- 
Grant Edwards               grant.b.edwards        Yow! Mary Tyler Moore's
                                  at               SEVENTH HUSBAND is wearing
                              gmail.com            my DACRON TANK TOP in a
                                                   cheap hotel in HONOLULU!

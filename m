Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751875AbeDJFzY convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 01:55:24 -0400
Received: from emcscan.emc.com.tw ([192.72.220.5]:41094 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeDJFzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 01:55:22 -0400
From: =?utf-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
To: "'Benjamin Tissoires'" <benjamin.tissoires@redhat.com>,
        "'Dmitry Torokhov'" <dmitry.torokhov@gmail.com>
Cc: "'Oliver Haessler'" <oliver@redhat.com>,
        "'Benjamin Berg'" <bberg@redhat.com>,
        "'open list:HID CORE LAYER'" <linux-input@vger.kernel.org>,
        "'lkml'" <linux-kernel@vger.kernel.org>
References: <20180405132537.3218-1-benjamin.tissoires@redhat.com> <20180405235126.GB57189@dtor-ws> <CAO-hwJLY=OR1bk2y9c-6MZzoAYzorH9MEKf70=dnhqz8s-dCQg@mail.gmail.com>
In-Reply-To: <CAO-hwJLY=OR1bk2y9c-6MZzoAYzorH9MEKf70=dnhqz8s-dCQg@mail.gmail.com>
Subject: RE: [PATCH 0/8] Input: support for latest Lenovo thinkpads (series 80)
Date: Tue, 10 Apr 2018 13:45:33 +0800
Message-ID: <000301d3d08f$24b356b0$6e1a0410$@emc.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGx3tF9q04NbCgqaz93Ar88cJmSXgH4DjZEAnkTkxGkGcUBEA==
Content-Language: zh-tw
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

Thanks so much for your patch.

I have tested them for Elan Gen5/Gen6(new) touchpad with SMbus/PS2.
It works fine in my thinkpad so far but I find an issue today after lid-close/open.

I am not sure if you can see it in T480S , I "guess" it may be relative to i2c_i801.

The lid-close will enter deep sleep and cut touchpad power. 
I can see the resume flow after lid-open and SMbus-initial try to request hello package but fail.
Strangely, I can't see any SMbus host signal on LA scope after power-on.

I can't switch to SMbus after rmmod/modprobe psmouse because error happen in elantech_create_smbus.
It will be recovered only if I rmmod/modprobe i2c_i801 first.

Do you have any idea about it?

Thanks
KT
-----Original Message-----
From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com] 
Sent: Friday, April 06, 2018 2:51 PM
To: Dmitry Torokhov
Cc: 廖崇榮; Oliver Haessler; Benjamin Berg; open list:HID CORE LAYER; lkml
Subject: Re: [PATCH 0/8] Input: support for latest Lenovo thinkpads (series 80)

Hi Dmitry,

On Fri, Apr 6, 2018 at 1:51 AM, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> Hi Benjamin,
>
> On Thu, Apr 05, 2018 at 03:25:29PM +0200, Benjamin Tissoires wrote:
>> Hi Dmitry,
>>
>> well, this year, Lenovo gave us a surprise and decided to not use the 
>> same touchpad/trackstick in all its model. And by default, the 
>> support under Linux is less than ideal.
>>
>> Please find a series that should fix those issues. Compared to the 60 
>> series, there do not seem to e BIOS table issues this time, and 
>> suspend/resume works fine thanks to your latest trackstick fixes.
>>
>> The T480s is a different beast, as it uses an Elan touchpad.
>> I have been carrying the patches 3-6 for a while and tested previous 
>> versions on various Elan PS/2 hardware without an issue as far as I 
>> could tell. I was lacking tests from users with SMBus as all the 
>> laptops I tried where puer PS/2.
>>
>> Anyway, it would be cool if you could have a look at the series.
>
> I am mostly happy with the series, but I would love to hear KT's take 
> on it.

thanks for the quick review.
I worked closely with KT for this series. He helped me a lot for the tiny firmware changes that were required. However, quoting his email from Tuesday:
"There will be a spring vacation in Taiwan from tomorrow." I guess we won't hear from him until the end of next week as we always have a backlog of urgent things to do after holidays...

Cheers,
Benjamin

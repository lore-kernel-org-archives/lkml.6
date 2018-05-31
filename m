Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756091AbeEaS4N (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:56:13 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36419 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755955AbeEaS4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 14:56:10 -0400
X-Google-Smtp-Source: ADUXVKLX2ffX17t6T1EYlK2Ul22rX1+cllcdeOaaK83/6l7nMtmNyegZKbn4cX19birXRLDOyMfp2g==
Subject: Re: [PATCH v2 01/21] usb: phy: use match_string() helper
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-2-git-send-email-xieyisheng1@huawei.com>
 <af7838f0-9cae-d526-b52f-15996cd8031c@cogentembedded.com>
 <CAHp75VfAwj2P51ydOoe6aysB=Q9j8DaMNSbYaMqwbYHn7UFfdQ@mail.gmail.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <d06e5dd2-cee8-7648-c4e0-3f65977e0510@cogentembedded.com>
Date: Thu, 31 May 2018 21:56:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VfAwj2P51ydOoe6aysB=Q9j8DaMNSbYaMqwbYHn7UFfdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31/2018 09:47 PM, Andy Shevchenko wrote:

>>>  - donot rename err to ret  - per Andy
>>
>>    Hm...
> 
>>> -     int err, i;
> 
>>> +     err = match_string(usbphy_modes, ARRAY_SIZE(usbphy_modes), phy_type);
>>> +     if (err < 0)
>>
>>    This is one of the few cases when 'err' is not the best name for such a
>> variable. I'd prefer to see something like 'match' or even 'rc' or 'ret'... :-)
> 
> Then leaving i would make it?

   Yes. :-)

> I'm okay with either which just not renames err, b/c it's used with
> something else in this function.

   Looking at it again, 'err' seems equally bad for the result of 
of_property_read_string()... unless the check there is changed to just *if* (err) --
this function never returns positive values, 0 means success, others mean error.

MBR, Sergei 

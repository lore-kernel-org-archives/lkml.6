Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756028AbeEaS7U (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:59:20 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43419 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755895AbeEaS7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 14:59:17 -0400
X-Google-Smtp-Source: ADUXVKJ8CC+QDm6XrFkgjvugGQXbIQVWLvqH2ALixCn2m++g+g8kLAuLaOGH0QmLhWdaNX0N2uF9uum/d6df3wf81Rw=
MIME-Version: 1.0
In-Reply-To: <d06e5dd2-cee8-7648-c4e0-3f65977e0510@cogentembedded.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-2-git-send-email-xieyisheng1@huawei.com>
 <af7838f0-9cae-d526-b52f-15996cd8031c@cogentembedded.com> <CAHp75VfAwj2P51ydOoe6aysB=Q9j8DaMNSbYaMqwbYHn7UFfdQ@mail.gmail.com>
 <d06e5dd2-cee8-7648-c4e0-3f65977e0510@cogentembedded.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 31 May 2018 21:59:16 +0300
Message-ID: <CAHp75VfUvcCJEyisNG0cgiL8GCdNQvSaefJVW2yx7HWDHC45cw@mail.gmail.com>
Subject: Re: [PATCH v2 01/21] usb: phy: use match_string() helper
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 9:56 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 05/31/2018 09:47 PM, Andy Shevchenko wrote:

>>>> -     int err, i;

>>>> +     err = match_string(usbphy_modes, ARRAY_SIZE(usbphy_modes), phy_type);
>>>> +     if (err < 0)
>>>
>>>    This is one of the few cases when 'err' is not the best name for such a
>>> variable. I'd prefer to see something like 'match' or even 'rc' or 'ret'... :-)
>>
>> Then leaving i would make it?
>    Yes. :-)

So, I leave it to Greg to decide either it's okay in this version, or
needs update with i left untouched.

>> I'm okay with either which just not renames err, b/c it's used with
>> something else in this function.
>
>    Looking at it again, 'err' seems equally bad for the result of
> of_property_read_string()... unless the check there is changed to just *if* (err) --
> this function never returns positive values, 0 means success, others mean error.

While you seems right, this is matter of another change which you are
welcome to propose.

-- 
With Best Regards,
Andy Shevchenko

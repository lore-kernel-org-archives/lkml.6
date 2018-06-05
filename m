Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751577AbeFEJ3c (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:29:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8643 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751437AbeFEJ3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:29:31 -0400
Subject: Re: [PATCH v2 01/21] usb: phy: use match_string() helper
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-2-git-send-email-xieyisheng1@huawei.com>
 <af7838f0-9cae-d526-b52f-15996cd8031c@cogentembedded.com>
 <CAHp75VfAwj2P51ydOoe6aysB=Q9j8DaMNSbYaMqwbYHn7UFfdQ@mail.gmail.com>
 <d06e5dd2-cee8-7648-c4e0-3f65977e0510@cogentembedded.com>
 <CAHp75VfUvcCJEyisNG0cgiL8GCdNQvSaefJVW2yx7HWDHC45cw@mail.gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <4ea021ae-1284-4519-e467-5c03bc62c98b@huawei.com>
Date: Tue, 5 Jun 2018 17:28:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfUvcCJEyisNG0cgiL8GCdNQvSaefJVW2yx7HWDHC45cw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/6/1 2:59, Andy Shevchenko wrote:
> On Thu, May 31, 2018 at 9:56 PM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
>> On 05/31/2018 09:47 PM, Andy Shevchenko wrote:
> 
>>>>> -     int err, i;
> 
>>>>> +     err = match_string(usbphy_modes, ARRAY_SIZE(usbphy_modes), phy_type);
>>>>> +     if (err < 0)
>>>>
>>>>    This is one of the few cases when 'err' is not the best name for such a
>>>> variable. I'd prefer to see something like 'match' or even 'rc' or 'ret'... :-)
>>>
>>> Then leaving i would make it?
>>    Yes. :-)
> 
> So, I leave it to Greg to decide either it's okay in this version, or
> needs update with i left untouched.
Hi Greg,

IIRC, you seems want to keep the err unchanged, right?

Please let me know if another version is need.

Thanks
Yisheng

> 
>>> I'm okay with either which just not renames err, b/c it's used with
>>> something else in this function.
>>
>>    Looking at it again, 'err' seems equally bad for the result of
>> of_property_read_string()... unless the check there is changed to just *if* (err) --
>> this function never returns positive values, 0 means success, others mean error.
> 
> While you seems right, this is matter of another change which you are
> welcome to propose.
> 

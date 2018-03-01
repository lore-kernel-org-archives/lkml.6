Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965359AbeCAAph (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 19:45:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965328AbeCAApf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 19:45:35 -0500
Subject: Re: [PATCH] checkpatch: avoid error report caused by syzbot
To: Joe Perches <joe@perches.com>, <apw@canonical.com>,
        <akpm@linux-foundation.org>
References: <1519809018-1736-1-git-send-email-xieyisheng1@huawei.com>
 <1519835851.30349.7.camel@perches.com>
CC: <linux-kernel@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <4b58143b-2dc4-0d7c-e450-8e07cadb11c6@huawei.com>
Date: Thu, 1 Mar 2018 08:44:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <1519835851.30349.7.camel@perches.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On 2018/3/1 0:37, Joe Perches wrote:
> On Wed, 2018-02-28 at 17:10 +0800, Yisheng Xie wrote:
>> syzbot request to add his reported-by when fix the bug find by syzbot.
>> However, it will trigger a error when use checkpatch:
>>
>>   ERROR: Unrecognized email address: 'syzbot+d7a918a7a8e1c952bc36@syzkaller.appspotmail.com'
>>
>> For it include '+' in email and make regular expression works abnomal. Fix
>> it by adding check for syzbot.
>>
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> 
> Nack.
> 
> There's a proper patch already in -next
> 

Thanks for the information.

Thanks
Yisheng

> commit 14e45b3ecdb03211ab32656cd84e66fd6a28343e
> Author: Joe Perches <joe@perches.com>
> Date:   Thu Feb 22 09:59:45 2018 +1100
> 
>     checkpatch: improve parse_email signature checking
>     
>     Bare email addresses with non alphanumeric characters require escape
>     quoting before being substituted in the parse_email routine.
>     
>     e.g. Reported-by: syzbot+bbd8e9a06452cc48059b@syzkaller.appspotmail.com
>     
>     Do so.
>     
>     Link: http://lkml.kernel.org/r/1518631805.3678.12.camel@perches.com
> 
> 
> .
> 

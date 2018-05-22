Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbeEVAtx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 20:49:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60359 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751101AbeEVAtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 20:49:49 -0400
Subject: Re: [PATCH] intel_th: pti: Convert to use sysfs_match_string() helper
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1526462116-10894-1-git-send-email-xieyisheng1@huawei.com>
 <CAHp75VeJxQDuSXZNDgZsHsoWg37oe=h3L796jcv=44kZfZcSuQ@mail.gmail.com>
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <258eebad-2552-1581-5fba-a98c84340061@huawei.com>
Date: Tue, 22 May 2018 08:49:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeJxQDuSXZNDgZsHsoWg37oe=h3L796jcv=44kZfZcSuQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 2018/5/22 6:16, Andy Shevchenko wrote:
> On Wed, May 16, 2018 at 12:15 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>> The helper returns index of the matching string in an array,
>> use it to simpler the code.
> 
> IIRC I sent the patch with the same semantics week or so ago against this file.

Right, I get it. Sorry about that.

Thanks
Yisheng
> 
>>
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
>> ---
>>  drivers/hwtracing/intel_th/pti.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/hwtracing/intel_th/pti.c b/drivers/hwtracing/intel_th/pti.c
>> index 5669433..75cb368 100644
>> --- a/drivers/hwtracing/intel_th/pti.c
>> +++ b/drivers/hwtracing/intel_th/pti.c
>> @@ -272,15 +272,12 @@ static ssize_t lpp_dest_store(struct device *dev, struct device_attribute *attr,
>>                               const char *buf, size_t size)
>>  {
>>         struct pti_device *pti = dev_get_drvdata(dev);
>> -       ssize_t ret = -EINVAL;
>> -       int i;
>> +       ssize_t ret;
>>
>> -       for (i = 0; i < ARRAY_SIZE(lpp_dest_str); i++)
>> -               if (sysfs_streq(buf, lpp_dest_str[i]))
>> -                       break;
>> +       ret = sysfs_match_string(lpp_dest_str, buf);
>>
>> -       if (i < ARRAY_SIZE(lpp_dest_str) && pti->lpp_dest_mask & BIT(i)) {
>> -               pti->lpp_dest = i;
>> +       if (ret >= 0 && pti->lpp_dest_mask & BIT(ret)) {
>> +               pti->lpp_dest = ret;
>>                 ret = size;
>>         }
>>
>> --
>> 1.7.12.4
>>
> 
> 
> 

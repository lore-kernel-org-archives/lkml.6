Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750866AbeFAEgi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:36:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8246 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750738AbeFAEgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:36:37 -0400
Subject: Re: [PATCH v2 19/21] bcache: use match_string() helper
To: Coly Li <colyli@suse.de>, <linux-kernel@vger.kernel.org>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-20-git-send-email-xieyisheng1@huawei.com>
 <f8dea584-a7b1-a894-d4b6-d573fdb4da3d@suse.de>
CC: <andy.shevchenko@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        <linux-bcache@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <36b9f53d-66bd-076e-7c2e-045ca2fd4406@huawei.com>
Date: Fri, 1 Jun 2018 12:32:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <f8dea584-a7b1-a894-d4b6-d573fdb4da3d@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Coly,

On 2018/6/1 11:45, Coly Li wrote:
> On 2018/5/31 7:11 PM, Yisheng Xie wrote:
>> match_string() returns the index of an array for a matching string,
>> which can be used instead of open coded variant.
>>
>> Cc: Kent Overstreet <kent.overstreet@gmail.com>
>> Cc: linux-bcache@vger.kernel.org 
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> 
> Hi Yishenng,
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> submitted a patch to
> replace the whole bch_read_string_list() with __sysfs_match_string().
> And this patch is applied in Jens' block tree, will go into mainline
> kernel in v4.18.
> 
> If you search bcache mailing list, you may find a patch named with
> "bcache: Replace bch_read_string_list() by __sysfs_match_string()".
> 
> That means this patch will conflict with existing changes.

Get it, and thanks for this information.

Sorry Andy, for doing this once more.

Thanks
Yisheng
> 
> Thanks.
> 
> Coly Li
> 
>> ---
>>  drivers/md/bcache/util.c | 9 ++-------
>>  1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/md/bcache/util.c b/drivers/md/bcache/util.c
>> index 74febd5..cd1f4fd 100644
>> --- a/drivers/md/bcache/util.c
>> +++ b/drivers/md/bcache/util.c
>> @@ -136,22 +136,17 @@ ssize_t bch_snprint_string_list(char *buf, size_t size, const char * const list[
>>  
>>  ssize_t bch_read_string_list(const char *buf, const char * const list[])
>>  {
>> -	size_t i;
>> +	ssize_t i;
>>  	char *s, *d = kstrndup(buf, PAGE_SIZE - 1, GFP_KERNEL);
>>  	if (!d)
>>  		return -ENOMEM;
>>  
>>  	s = strim(d);
>>  
>> -	for (i = 0; list[i]; i++)
>> -		if (!strcmp(list[i], s))
>> -			break;
>> +	i = match_string(list, -1, s);
>>  
>>  	kfree(d);
>>  
>> -	if (!list[i])
>> -		return -EINVAL;
>> -
>>  	return i;
>>  }
>>  
>>
> 
> 
> 

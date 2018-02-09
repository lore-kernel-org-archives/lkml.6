Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeBIBHd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 20:07:33 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:53240 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752116AbeBIBHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 20:07:32 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Sxugoqr_1518138436;
Subject: Re: [PATCH 2/2] x86/mm/64: Add vsyscall page to /proc/kcore
 conditionally
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: Jiri Olsa <jolsa@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <1517294579-117473-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1517294579-117473-2-git-send-email-zhang.jia@linux.alibaba.com>
 <20180205092644.GA23191@krava>
From: Jia Zhang <zhang.jia@linux.alibaba.com>
Message-ID: <084400a6-4b8b-4050-b92a-d3737c1a5565@linux.alibaba.com>
Date: Fri, 9 Feb 2018 09:08:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180205092644.GA23191@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Anybody else here who can give an attention on this review?

Thanks,
Jia

On 2018/2/5 下午5:26, Jiri Olsa wrote:
> On Tue, Jan 30, 2018 at 02:42:59PM +0800, Jia Zhang wrote:
>> The vsyscall page should be visible only if
>> vsyscall=emulate/native when dumping /proc/kcore.
>>
>> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
>> ---
>>  arch/x86/mm/init_64.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>> index dab78f6..3d4cf33 100644
>> --- a/arch/x86/mm/init_64.c
>> +++ b/arch/x86/mm/init_64.c
>> @@ -1186,8 +1186,9 @@ void __init mem_init(void)
>>  	register_page_bootmem_info();
>>  
>>  	/* Register memory areas for /proc/kcore */
>> -	kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR,
>> -		   PAGE_SIZE, KCORE_USER);
>> +	if (get_gate_vma(&init_mm))
>> +		kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR,
>> +			   PAGE_SIZE, KCORE_USER);
> 
> nit, we use { } when there's more than 1 line code 
> 
> anyway the approach looks ok to me
> 
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>
> 
> thanks,
> jirka
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbeA3Ljg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 06:39:36 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:36910 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751391AbeA3Lje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 06:39:34 -0500
Subject: Re: [PATCH] ftrace: use helper function clear_ftrace_function
To: Steven Rostedt <rostedt@goodmis.org>
References: <1517273161-36355-1-git-send-email-xieyisheng1@huawei.com>
 <20180130051306.15f47965@vmware.local.home>
CC: <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <17da0ae7-32dc-fc7f-0a87-24d243510e88@huawei.com>
Date: Tue, 30 Jan 2018 19:39:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <20180130051306.15f47965@vmware.local.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 2018/1/30 18:13, Steven Rostedt wrote:
> On Tue, 30 Jan 2018 08:46:01 +0800
> Yisheng Xie <xieyisheng1@huawei.com> wrote:
> 
>> We have helper function clear_ftrace_function(), use it instead of hard
>> code. And this should not have any functional change.
>>
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
>> ---
>>  kernel/trace/ftrace.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index 554b517..ba78e03 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -6779,7 +6779,7 @@ int unregister_ftrace_function(struct ftrace_ops *ops)
>>  
>>  	} else {
>>  		/* stopping ftrace calls (just send to ftrace_stub) */
>> -		ftrace_trace_function = ftrace_stub;
>> +		clear_ftrace_function();
>>  
>>  		ftrace_shutdown_sysctl();
>>  	}
> 
> Honestly, I rather nuke that function and clear_ftrace_function_probe()

Do you means clear_ftrace_function_probes() ? I do not find clear_ftrace_function_probe
in mainline or trace tree:
  https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git/

clear_ftrace_function_probes() is used in trace.c instead of ftrace.c, and meanwhile it
has a local variable:

	struct ftrace_func_probe *probe, *n;

which defined in ftrace.c. So I am a litter puzzle about how to nuke it without moving
struct ftrace_func_probe 's definition to first class.

I'm not sure whether I am missing anything.

> along with it. They are not used outside of ftrace.c and they don't
> actually help.

For clear_ftrace_function it really can be nuked, for it's only used in ftrace.c.

Thanks
Yisheng

> 
> -- Steve
> 
> 

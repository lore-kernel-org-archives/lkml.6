Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753494AbeBVKqi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 05:46:38 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:52638 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753348AbeBVKqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 05:46:36 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180222104634epoutp01d53b700960555b4ecbec4ebe8b9782fb~VoAV8iw1r1622816228epoutp01S
X-AuditID: b6c32a4b-cb9ff70000001126-81-5a8e9f8a14e2
Mime-Version: 1.0
Subject: RE: Re: [PATCH] fanotify: allow freeze on suspend when waiting for
 response from userspace
Reply-To: k.shubham@samsung.com
From: Kunal Shubham <k.shubham@samsung.com>
To: "jack@suse.cz" <jack@suse.cz>
CC: VIVEK TRIVEDI <t.vivek@samsung.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PANKAJ MISHRA <pankaj.m@samsung.com>,
        Kunal Shubham <k.shubham@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180216102913.jcgvc5rhjqtzlkb6@quack2.suse.cz>
X-Drm-Type: Y,confirm
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180222094454epcms5p15e3538bdba8bcbc036dc379583bc3a55@epcms5p1>
Date: Thu, 22 Feb 2018 15:14:54 +0530
X-CMS-MailID: 20180222094454epcms5p15e3538bdba8bcbc036dc379583bc3a55
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
X-MTR: 20180222094454epcms5p15e3538bdba8bcbc036dc379583bc3a55
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7bCmum7X/L4og6dbpSwurFvNaDF7ejOT
        xcFlM5kt9uw9yWJxedccNot7b7YyWbzs28jmwO6xc9Zddo++LasYPc4sOMLu8XmTXABLFJdN
        SmpOZllqkb5dAlfGhgvv2QtW2Fcs2cHZwLjMqouRk0NCwETi/fTF7F2MXBxCArsZJY5O3MXY
        xcjBwSsgKPF3hzBIjbBAqsTrzTcYQWwhAXmJT4tvMkPEdSVaJqwEi7MJaEvMXbKfFcQWEVCU
        uLvzPCvITGaB5UwSu99OY4NYxisxo/0pC4QtLbF9+VawZk4BW4kXLxdBxUUl/jQ8hbPfH5vP
        CGGLSLTeO8sMYQtKPPi5GyouI7HywjkWkGUSAs2MEusOHGeCcHoYJR583QS12Vzi/Mn5YN28
        Ar4Saw/+YQKxWQRUJdqO9EDVuEhM7ZoP9gIz0DvLFr5mBoUEs4CmxPpd+hAlshJTT61jAglL
        AB198I4PRDWfRO/vJ0wwP+6YB2MrS6xqu8oKYUtKXLrazgjR6iHR+ih1AqPSLERIz0KydhbC
        2gWMzKsYJVMLinPTU4tNC4zzUsv1ihNzi0vz0vWS83M3MYJTi5b3DsZN53wOMQpwMCrx8EaU
        9EYJsSaWFVfmHmKU4GBWEuFdGtoXJcSbklhZlVqUH19UmpNafIhRmoNFSZzXMdAlSkggPbEk
        NTs1tSC1CCbLxMEp1cCYFXyfv1nutqzBCx8xLsvFqlb/DfLqLLd3c7nZcJqop2gt3rpe9PYS
        u/74bwLhdrPcm7bo+l3l+Vxta9VfOknK2bapYnvZk5urrE+yfpw5e6GdRNWf9IjpR8vMf609
        t05H0qVeZd/iF412WVl8n069bPaXu1X3Zkc8c7O763v2isutb63ZtZVYijMSDbWYi4oTAeSS
        Oq0pAwAA
X-CMS-RootMailID: 20180216094525epcas5p1e52ea815ed7dfb7516578384dedcf5ae
X-RootMTR: 20180216094525epcas5p1e52ea815ed7dfb7516578384dedcf5ae
References: <20180216102913.jcgvc5rhjqtzlkb6@quack2.suse.cz>
        <1518774280-38090-1-git-send-email-t.vivek@samsung.com>
        <CGME20180216094525epcas5p1e52ea815ed7dfb7516578384dedcf5ae@epcms5p1>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1MAkhrh008635

>> On Fri 16-02-18 15:14:40, t.vivek@samsung.com wrote:
>> From: Vivek Trivedi <t.vivek@samsung.com>
>> 
>> If fanotify userspace response server thread is frozen first,
>> it may fail to send response from userspace to kernel space listener.
>> In this scenario, fanotify response listener will never get response
>> from userepace and fail to suspend.
>> 
>> Use freeze-friendly wait API to handle this issue.
>> 
>> Same problem was reported here:
>> https://bbs.archlinux.org/viewtopic.php?id=232270
>> 
>> Freezing of tasks failed after 20.005 seconds
>> (1 tasks refusing to freeze, wq_busy=0)
>> 
>> Backtrace:
>> [<c0582f80>] (__schedule) from [<c05835d0>] (schedule+0x4c/0xa4)
>> [<c0583584>] (schedule) from [<c01cb648>] (fanotify_handle_event+0x1c8/0x218)
>> [<c01cb480>] (fanotify_handle_event) from [<c01c8238>] (fsnotify+0x17c/0x38c)
>> [<c01c80bc>] (fsnotify) from [<c02676dc>] (security_file_open+0x88/0x8c)
>> [<c0267654>] (security_file_open) from [<c01854b0>] (do_dentry_open+0xc0/0x338)
>> [<c01853f0>] (do_dentry_open) from [<c0185a38>] (vfs_open+0x54/0x58)
>> [<c01859e4>] (vfs_open) from [<c0195480>] (do_last.isra.10+0x45c/0xcf8)
>> [<c0195024>] (do_last.isra.10) from [<c0196140>] (path_openat+0x424/0x600)
>> [<c0195d1c>] (path_openat) from [<c0197498>] (do_filp_open+0x3c/0x98)
>> [<c019745c>] (do_filp_open) from [<c0186b44>] (do_sys_open+0x120/0x1e4)
>> [<c0186a24>] (do_sys_open) from [<c0186c30>] (SyS_open+0x28/0x2c)
>> [<c0186c08>] (SyS_open) from [<c0010200>] (__sys_trace_return+0x0/0x20)
>
> Yeah, good catch.
>
>> @@ -63,7 +64,9 @@ static int fanotify_get_response(struct fsnotify_group *group,
>>  
>>  	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
>>  
>> -	wait_event(group->fanotify_data.access_waitq, event->response);
>> +	while (!event->response)
>> +		wait_event_freezable(group->fanotify_data.access_waitq,
>> +				     event->response);
>
> But if the process gets a signal while waiting, we will just livelock the
> kernel in this loop as wait_event_freezable() will keep returning
> ERESTARTSYS. So you need to be a bit more clever here...

Hi Jack,
Thanks for the quick review.
To avoid livelock issue, is it fine to use below change? 
If agree, I will send v2 patch.

@@ -63,7 +64,11 @@ static int fanotify_get_response(struct fsnotify_group *group,

        pr_debug("%s: group=%p event=%p\n", __func__, group, event);

-       wait_event(group->fanotify_data.access_waitq, event->response);
+       while (!event->response) {
+               if (wait_event_freezable(group->fanotify_data.access_waitq,
+                                       event->response))
+                       flush_signals(current);
+       }

Thanks

 
--------- Original Message ---------
Sender : Jan Kara <jack@suse.cz>
Date   : 2018-02-16 15:59 (GMT+5:30)
Title  : Re: [PATCH] fanotify: allow freeze on suspend when waiting for response from userspace
To : VIVEK TRIVEDI<t.vivek@samsung.com>
CC : jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, PANKAJ MISHRA<pankaj.m@samsung.com>, Kunal Shubham<k.shubham@samsung.com>
 
On Fri 16-02-18 15:14:40, t.vivek@samsung.com wrote:
> From: Vivek Trivedi <t.vivek@samsung.com>
> 
> If fanotify userspace response server thread is frozen first,
> it may fail to send response from userspace to kernel space listener.
> In this scenario, fanotify response listener will never get response
> from userepace and fail to suspend.
> 
> Use freeze-friendly wait API to handle this issue.
> 
> Same problem was reported here:
> https://bbs.archlinux.org/viewtopic.php?id=232270
> 
> Freezing of tasks failed after 20.005 seconds
> (1 tasks refusing to freeze, wq_busy=0)
> 
> Backtrace:
> [<c0582f80>] (__schedule) from [<c05835d0>] (schedule+0x4c/0xa4)
> [<c0583584>] (schedule) from [<c01cb648>] (fanotify_handle_event+0x1c8/0x218)
> [<c01cb480>] (fanotify_handle_event) from [<c01c8238>] (fsnotify+0x17c/0x38c)
> [<c01c80bc>] (fsnotify) from [<c02676dc>] (security_file_open+0x88/0x8c)
> [<c0267654>] (security_file_open) from [<c01854b0>] (do_dentry_open+0xc0/0x338)
> [<c01853f0>] (do_dentry_open) from [<c0185a38>] (vfs_open+0x54/0x58)
> [<c01859e4>] (vfs_open) from [<c0195480>] (do_last.isra.10+0x45c/0xcf8)
> [<c0195024>] (do_last.isra.10) from [<c0196140>] (path_openat+0x424/0x600)
> [<c0195d1c>] (path_openat) from [<c0197498>] (do_filp_open+0x3c/0x98)
> [<c019745c>] (do_filp_open) from [<c0186b44>] (do_sys_open+0x120/0x1e4)
> [<c0186a24>] (do_sys_open) from [<c0186c30>] (SyS_open+0x28/0x2c)
> [<c0186c08>] (SyS_open) from [<c0010200>] (__sys_trace_return+0x0/0x20)
 
Yeah, good catch.
 
> @@ -63,7 +64,9 @@ static int fanotify_get_response(struct fsnotify_group *group,
>  
>          pr_debug("%s: group=%p event=%p\n", __func__, group, event);
>  
> -        wait_event(group->fanotify_data.access_waitq, event->response);
> +        while (!event->response)
> +                wait_event_freezable(group->fanotify_data.access_waitq,
> +                                     event->response);
 
But if the process gets a signal while waiting, we will just livelock the
kernel in this loop as wait_event_freezable() will keep returning
ERESTARTSYS. So you need to be a bit more clever here...
 
                                                                Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
 
 

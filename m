Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbeCLOPy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:15:54 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:50602 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751339AbeCLOPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:15:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0SzHkA5D_1520864148;
Subject: Re: [PATCH v2 0/4] modsign enhancement
To: Jessica Yu <jeyu@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <1520483223-6596-1-git-send-email-zhang.jia@linux.alibaba.com>
 <20180312132823.dixp7gkjypjlgymt@redbean.localdomain>
From: Jia Zhang <zhang.jia@linux.alibaba.com>
Message-ID: <6727b467-e2fe-4981-fe77-b9ec3ebf8818@linux.alibaba.com>
Date: Mon, 12 Mar 2018 22:15:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312132823.dixp7gkjypjlgymt@redbean.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/3/12 下午9:28, Jessica Yu wrote:
> +++ Jia Zhang [08/03/18 12:26 +0800]:
>> This patch series allows to disable module validity enforcement
>> in runtime through /sys/kernel/security/modsign/enforce interface.
>>
>> Assuming CONFIG_MODULE_SIG_FORCE=y, here are the instructions to
>> disable the validity enforcement.
>>
>> # cat /sys/kernel/security/modsign/enforce
>> # echo -n 0 > data
>> # openssl smime -sign -nocerts -noattr -binary -in data \
>>    -inkey <system_trusted_key> -signer <cert> -outform der \
>>    -out /sys/kernel/security/modsign/enforce
>>
>> Now enable enforcement again on demand.
>>
>> # echo 1 > /sys/kernel/security/modsign/enforce
>>
>> Changelog:
>> v2:
>> - Support to disable validity enforcement in runtime.
> 
> NAK - please use /sys/module/module/parameters/sig_enforce.
> 
> And I would rather keep this parameter bool_enable_only, plain and simple.
> What use case do you have/why would you want to disable signature
> enforcement - after having enabled it - during runtime?  None of this
> is explained nor justified in the cover letter.

Because there is no way to disable it such as module.no_sig_enforce when
MODULE_SIG_FORCE=y available unless re-compiling a kernel without this
enforcement. This is inconvenient a bit. IMA and SELinux both have
cmdline control, but modsign doesn't have.

Even we really have a module.no_sig_enforce in cmdline, runtime
disablement can be used to avoid machine reboot. Sometimes machine
reboot is expensive.

If you agree, I can implement the runtime disablement via
/sys/module/module/parameters/sig_enforce. Additionally, supporting
module.no_sig_enforce when MODULE_SIG_FORCE=y is another one to be
implemented.

Thanks,
Jia

> 
> Thanks,
> 
> Jessica

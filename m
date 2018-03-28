Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeC1BCe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 21:02:34 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:51529 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752689AbeC1BCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 21:02:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04421;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0T-Cm1IG_1522198949;
Subject: Re: [PATCH v3 0/3][RESEND] modsign enhancement
To: Jessica Yu <jeyu@kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <1521860389-19262-1-git-send-email-zhang.jia@linux.alibaba.com>
 <20180327221137.d7fhboicw2wi3a52@redbean>
From: Jia Zhang <zhang.jia@linux.alibaba.com>
Message-ID: <9a950016-0ea6-adec-5d9b-a1f1760d51a0@linux.alibaba.com>
Date: Wed, 28 Mar 2018 09:02:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327221137.d7fhboicw2wi3a52@redbean>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/3/28 上午6:11, Jessica Yu wrote:
> +++ Jia Zhang [24/03/18 10:59 +0800]:
>> This patch series allows to disable module validity enforcement
>> in runtime through the control switch located in securityfs.
>>
>> In order to keep /sys/module/module/parameters/sig_enforce simple,
>> the disablement switch is located at
>> /sys/kernel/security/modsign/disable_enforce.
>>
>> Assuming CONFIG_MODULE_SIG_FORCE=n, here are the instructions to
>> test this control switch.
>>
>> # cat /sys/module/module/parameters/sig_enforce
>> N
>> # echo 1 > /sys/module/module/parameters/sig_enforce
>> # cat /sys/module/module/parameters/sig_enforce
>> Y
>> # echo -n 0 > no_sig_enforce
>> # openssl smime -sign -nocerts -noattr -binary -in no_sig_enforce \
>>    -inkey <system_trusted_key> -signer <cert> -outform der \
>>    -out /sys/kernel/security/modsign/disable_enforce
>> # cat /sys/module/module/parameters/sig_enforce
>> N
> 
> I'm not convinced we need this. And neither the use case nor the
> motivation is explained in the cover letter :-(
> 
> The way I see it - the only time you'd actually use this is in the
> situation where you have *already* enabled sig_enforce, and then later
> you change your mind - meaning you wanted to load unsigned modules
> after all. And if you ever plan on loading unsigned modules, why would
> you have enabled sig_enforce in the first place? If you want to keep

Similar SELinux, this is just providing a runtime switch to disable
modsign temporarily in a safer way. At least it is cannot be simply
disabled.

Thanks,
Jia

> the option of loading unsigned modules, don't have sig_enforce or
> CONFIG_MODULE_SIG_FORCE enabled.
> 
> [ CC'd Rusty in case he has some thoughts on this ]
> 
> Jessica

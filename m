Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755175AbeDPNWL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 09:22:11 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:39377 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755159AbeDPNWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 09:22:10 -0400
Subject: Re: nds32 build failures
To: Greentime Hu <green.hu@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vincent Chen <vincentc@andestech.com>,
        Greentime Hu <greentime@andestech.com>, Arnd Bergmann <arnd@arndb.de>,
        kito.cheng@gmail.com, wuiw@andestech.com
References: <4ccb747b-fb3b-18c8-8737-2cc02d7b1c34@roeck-us.net>
 <CAEbi=3cr5i3HKLKOacFih9pz00c7UBKrd=o4ER8HAUT1j_oqGg@mail.gmail.com>
From: Guenter Roeck <private@roeck-us.net>
Message-ID: <a009bde1-c2d5-02ad-91ae-e2af2dc9f789@roeck-us.net>
Date: Mon, 16 Apr 2018 06:22:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAEbi=3cr5i3HKLKOacFih9pz00c7UBKrd=o4ER8HAUT1j_oqGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated_sender: private@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: private@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: private@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/16/2018 02:06 AM, Greentime Hu wrote:
> 2018-04-16 11:58 GMT+08:00 Guenter Roeck <private@roeck-us.net>:
>> I thought I should give the brand new architecture a try. Unfortunately,
>> that was not very successful.
>>
>> Build reference: v4.17-rc1
>> gcc version: nds32le-elf-gcc (GCC) 7.3.0
>>
>> Building nds32:defconfig ... failed
>>
>> arch/nds32/include/asm/nds32.h: In function 'GIE_ENABLE':
>> arch/nds32/include/asm/nds32.h:25:2: error: implicit declaration of function
>> '__nds32__gie_en'; did you mean '__nds32__'?
>>
>> arch/nds32/include/asm/nds32.h: In function 'CACHE_SET':
>> arch/nds32/include/asm/nds32.h:38:18: error: implicit declaration of
>> function '__nds32__mfsr'; did you mean '__nds32__'?
>>
>> arch/nds32/include/asm/nds32.h:38:32: error: 'NDS32_SR_ICM_CFG' undeclared
>>
>> arch/nds32/include/asm/nds32.h:41:32: error: 'NDS32_SR_DCM_CFG'
>>
>> Am I missing something ?
>>
> Hi, Guenter:
>
> This built failure is because the toolchain version you used is not
> supported the latest intrinsic function/macro.
> We are sending the latest patchset now and we expect the whole new
> features will be supported in gcc8.0.0 and binutil2.31+.
>
> If you'd like to get these new features of toolchain, you may use the
> github version.
> This is the built-script repo. https://github.com/andestech/build_script.git
>
Hmm. How comes that the defines are not there ? Also, is nds32_intrinsic.h supposed to be auto-generated ?

The toolchain as provided isn't usable for me since it is not position independent.

Arnd, it might make sense to drop the nds32 toolchain from kernel.org; its presence is at best misleading.

Guenter

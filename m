Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965116AbeBMOnA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:43:00 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46975 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935243AbeBMOm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:42:59 -0500
X-Google-Smtp-Source: AH8x2266qyIQ9EtBlkb9GE/0c3+6dl4Eyhhfdd6cOxuGm2ahlX+sEQehQ7CzJqGWQOX3gq9/+4l2sA==
Subject: Re: drivers/watchdog/rave-sp-wdt.c:278: undefined reference to
 `nvmem_cell_get'
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
References: <201802131728.QBRqHsyy%fengguang.wu@intel.com>
 <20180213093013.rsoprhs5aoimyy2r@dell>
 <CAHQ1cqHrTU+=tTxn_no-AdHLMi_j4-gDKLKCkaAuOF=v4TAHmg@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <8f269408-8234-3ad8-01b4-eb5114a8cc5e@roeck-us.net>
Date: Tue, 13 Feb 2018 06:42:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqHrTU+=tTxn_no-AdHLMi_j4-gDKLKCkaAuOF=v4TAHmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/2018 06:20 AM, Andrey Smirnov wrote:
> On Tue, Feb 13, 2018 at 1:30 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> On Tue, 13 Feb 2018, kbuild test robot wrote:
>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   178e834c47b0d01352c48730235aae69898fbc02
>>> commit: c3bb333457218ca4ed9553be47c0f567b4ef8a38 watchdog: Add RAVE SP watchdog driver
>>> date:   5 weeks ago
>>> config: x86_64-randconfig-u0-02131401 (attached as .config)
>>> compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
>>> reproduce:
>>>          git checkout c3bb333457218ca4ed9553be47c0f567b4ef8a38
>>>          # save the attached .config to linux build tree
>>>          make ARCH=x86_64
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>     drivers/watchdog/rave-sp-wdt.o: In function `rave_sp_wdt_probe':
>>>>> drivers/watchdog/rave-sp-wdt.c:278: undefined reference to `nvmem_cell_get'
>>>>> drivers/watchdog/rave-sp-wdt.c:281: undefined reference to `nvmem_cell_read'
>>>>> drivers/watchdog/rave-sp-wdt.c:287: undefined reference to `nvmem_cell_put'
>>>     make[2]: *** [vmlinux] Error 1
>>
>> Looks like the RAVE Watchdog driver should select NVMEM?
>>
> 
> AFAICT, this is happening when RAVE SP core and watchdog drivers are
> built as built-in and NVMEM is selected as module. Looking at other
> users on NVMEM in the kernel is seems that the pattern to prevent this
> problem is to add "depends on NVMEM || !NVMEM" line to consumer's
> Kconfig entry.
> 
> I'll submit a patch to that effect shortly.
> 

Actually, no need to send it. Arnd Bergmann sent the patch already back in January,
only for some reason it got lost in the commit window. I'll discuss with Wim how
to send it upstream.

Guenter

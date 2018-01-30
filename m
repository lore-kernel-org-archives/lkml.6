Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeA3OCi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 09:02:38 -0500
Received: from mail1.windriver.com ([147.11.146.13]:42322 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752066AbeA3OCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 09:02:37 -0500
Subject: Re: [PATCH v2] kdb: use ktime_get_mono_fast_ns() instead of
 ktime_get_ts()
To: Arnd Bergmann <arnd@arndb.de>, Baolin Wang <baolin.wang@linaro.org>
CC: Daniel Thompson <daniel.thompson@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Mark Brown <broonie@kernel.org>,
        <kgdb-bugreport@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3f15868475cb4b32353885ee03c983209279fa81.1517192387.git.baolin.wang@linaro.org>
 <CAK8P3a1_tNGhqN+tbfbxtpdPJ+=ksNS4QJ=sPYCz7ORAqKVQAw@mail.gmail.com>
From: Jason Wessel <jason.wessel@windriver.com>
Message-ID: <8c05803e-eda8-36a1-fd38-77cb570f4ba9@windriver.com>
Date: Tue, 30 Jan 2018 08:02:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1_tNGhqN+tbfbxtpdPJ+=ksNS4QJ=sPYCz7ORAqKVQAw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/2018 07:35 AM, Arnd Bergmann wrote:
> On Mon, Jan 29, 2018 at 3:22 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> The kdb code will print the monotonic time by ktime_get_ts(), but
>> the ktime_get_ts() will be protected by a sequence lock, that will
>> introduce one deadlock risk if the lock was already held in the
>> context from which we entered the debugger.
>>
>> Thus we can use the ktime_get_mono_fast_ns() to get the monotonic
>> time, which is NMI safe access to clock monotonic. Moreover we can
>> remove the 'struct timespec', which is not y2038 safe.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 


I'll add this in today, run some tests and it should be in the merge window.

Thanks,
Jason

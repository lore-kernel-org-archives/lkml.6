Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeFDKzP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:55:15 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33167 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752388AbeFDKzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:55:13 -0400
X-Google-Smtp-Source: ADUXVKL1yw6RquTtat/U6T/S2l1/lai5fLtNKAZKpTrNDzXfjS9E03r9R3fpCoW73lh9+wuNJ2TY0g==
Subject: Re: [PATCH] ASoC: dapm: delete dapm_kcontrol_data paths entry before
 freeing
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org, tiwai@suse.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com
References: <20180601225334.19064-1-srinivas.kandagatla@linaro.org>
 <20180604104541.GB7536@sirena.org.uk>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e37bf559-b040-db34-6273-d4f8ea1e2284@linaro.org>
Date: Mon, 4 Jun 2018 11:55:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180604104541.GB7536@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/06/18 11:45, Mark Brown wrote:
> On Fri, Jun 01, 2018 at 11:53:34PM +0100, Srinivas Kandagatla wrote:
> 
>> Below is the kernel BUG with SLAB Poisoning
> 
>> =============================================================================
>> BUG kmalloc-128 (Tainted: G        W        ): Poison overwritten
>> -----------------------------------------------------------------------------
>>
>> Disabling lock debugging due to kernel taint
>> INFO: 0xffff80003cf1c310-0xffff80003cf1c31f. First byte 0x10 instead of 0x6b
>> INFO: Allocated in dapm_kcontrol_data_alloc.isra.37+0x34/0x2a8 age=6929 cpu=0 pid=50
>>   __slab_alloc.isra.24+0x24/0x38
>>   kmem_cache_alloc+0x190/0x1d8
> 
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative then it's
> usually better to pull out the relevant sections.
I agree, Do you want me to resend the patch removing irrelevant sections 
in log?

thanks,
srini
> 

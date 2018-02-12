Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932516AbeBLXY5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 18:24:57 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:43046 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932272AbeBLXY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 18:24:56 -0500
X-Google-Smtp-Source: AH8x224IlFBMgZf7H1CqOf4oABhvO8JQxEAXq4o3OwUthPyynaQmHx/fo4NtdTUfzWVnrcPxcPXrQw==
Subject: Re: RFC: build config via DT names
From: Frank Rowand <frowand.list@gmail.com>
To: "Enrico Weigelt, metux IT consult" <metux@gmx.de>
Cc: linux-kernel@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <63f25fea-f163-f9cc-b5b2-f6f291d7f8d2@gmx.de>
 <d55f95cc-228b-e65f-b46c-2f314f4fa582@gmail.com>
Message-ID: <52140da5-0d49-c861-d752-8de9e4927380@gmail.com>
Date: Mon, 12 Feb 2018 15:24:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d55f95cc-228b-e65f-b46c-2f314f4fa582@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,

On 02/12/18 15:13, Frank Rowand wrote:
> + devicetree mail list
> 
> On 02/10/18 07:52, Enrico Weigelt, metux IT consult wrote:
>> Hi folks,
>>
>> I've regularily have the task of configuring a kernel for a given DT.
>> To make this a little bit easier, I'd like to do this automatically.
>>
>> The tuff task here is getting a mapping between dt compatible strings
>> and corresponding CONFIG_* flags. Automatically extracting it from the
>> source code seems pretty tricky, especially w/ corner cases (eg. some
>> drivers support groups of devices, depending on config options) - IMHO
>> it will need some code changes anyways.
>>
>> Therefore I propose a simple approach using the existing Kconfig system:
>>
>> Add an extra (toplevel) menu and config flag naming scheme which
>> directly map DT compatible strings to config flags. For example:
>>
>>> fsl,mpc5200-gpio <=> CONFIG_DTDEV_FSL_MPC5200_GPIO
>>
>>> config CONFIG_DTDEV_FSL_MPC5200_GPIO
>>>     tristate "fsl,mpc5200-gpio"
>>>     select GPIO_MPC5200
>>
>> Note that these flags are separate from the actual drivers - they just
>> enable them automatically. Of course they'll have to be maintained by
>> the driver maintainers.
>>
>>
>> What do you think about this idea ?
>>
>>
>> --mtx

As you note, it can be quite tricky getting the correct kernel configuration
for a given devicetree.

There is a tool to aid this process: scripts/dtc/dt_to_config.  It is not
a 100% solution, but it is very helpful.

The problem is difficult enough that this tool led to a conference talk.
The slides are at https://elinux.org/images/5/50/Dt_debugging_part_2.pdf
which is linked to from
https://elinux.org/Device_Tree_presentations_papers_articles#linux_kernel_configuration

dt_to_config and configuration issues are discussed in slides 33 - 80.

-Frank

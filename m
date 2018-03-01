Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031288AbeCAOTZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:19:25 -0500
Received: from foss.arm.com ([217.140.101.70]:39238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031206AbeCAOTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:19:23 -0500
Subject: Re: [PATCH v2 0/2] STM32 Extended TrustZone Protection driver
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Arnd Bergmann <arnd@arndb.de>, Loic PALLARDY <loic.pallardy@st.com>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
References: <20180301135806.19982-1-benjamin.gaignard@st.com>
 <20180301140243.3uamdvdcvmsxv6im@lakrids.cambridge.arm.com>
 <CA+M3ks6YPY6Lx-qBA+-Zrrtzr3Nqyzay=1wBHRGjd7PqJgAb0Q@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ad7a8214-875e-3c1a-87e1-0403d4328737@arm.com>
Date: Thu, 1 Mar 2018 14:19:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+M3ks6YPY6Lx-qBA+-Zrrtzr3Nqyzay=1wBHRGjd7PqJgAb0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/18 14:15, Benjamin Gaignard wrote:
> 2018-03-01 15:02 GMT+01:00 Mark Rutland <mark.rutland@arm.com>:
>> On Thu, Mar 01, 2018 at 02:58:04PM +0100, Benjamin Gaignard wrote:
>>> On early boot stages STM32MP1 platform is able to dedicate some hardware blocks
>>> to a secure OS running in TrustZone.
>>> We need to avoid using those hardware blocks on non-secure context (i.e. kernel)
>>> because read/write accesses could generate illegale access exceptions.
>>>
>>> Extended TrustZone Protection driver make sure that device is disabled if
>>> non-secure world can't acces to it.
>>>
>>> version 2:
>>> - do not use notifier anymore
>>> - change status property value in device-tree if needed
>>> - use a list of phandle instead of hard coded array
>>
>> As mentioned on v1, I don't think this should be done in Linux at all.
>>
>> If you wish to handle this dynamically, please fixup the DT *before*
>> entering Linux.
>>
>> If you want a sane default in the dts file, put status = "disabled" on
>> all nodes which the secure world might take ownership of.
> 
> That is the case, nodes are disabled by ealier boot stages before entering
> in Linux but, since mistakes and/or errors are always possible, fixup the DT
> to avoid illegal access exceptions make sense for me.

So why not also run a test on the memory controller in case the 
bootloader made a mistake in the memory node too? As I mentioned before, 
if you can't trust the DT to describe your hardware correctly you've 
already lost.

Robin.

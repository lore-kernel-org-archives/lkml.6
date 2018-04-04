Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbeDDIQq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:16:46 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:33815 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751356AbeDDIQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:16:42 -0400
Subject: Re: [PATCH v2 3/6] i2c: i2c-stm32f7: Add initial SMBus protocols
 support
To: Wolfram Sang <wsa@the-dreams.de>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-4-git-send-email-pierre-yves.mordret@st.com>
 <20180324224911.xz3fz2jojcdrovb4@ninjato>
 <2fadcd7f-3bfc-997e-a30e-808f6d854f2c@st.com>
 <20180403153122.ux6hnnmexwmq3soz@ninjato>
From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <79784d30-0a88-9aab-081f-ee14c214288b@st.com>
Date: Wed, 4 Apr 2018 10:16:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180403153122.ux6hnnmexwmq3soz@ninjato>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-04_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/03/2018 05:31 PM, Wolfram Sang wrote:
> 
>>>> All SMBus protocols are implemented except SMBus-specific protocols.
>>>
>>> What does that mean?
>>
>> It miss SMBus Host Notification and SMBBus Alert. They are almost ready but I'm
>> struggling to put them back to operational state after recent changes related to
>> SMBust Host Notification. A more "classic" interrupt base solution has been put
>> in place but I fail to use implement it in my side.
>> Another patch set is going to be delivered for these 2 commands.
> 
> This is totally fine to implement it incrementally. Please just update the
> commit message with the more detailed explanation above.
> 

Ok. I get.

>>> That is quite some complexity considering we have I2C_FUNC_SMBUS_EMUL. I
>>> don't mind, but you really want that?
>>>
>>
>> All SMBBus commands are implemented as such. I never try to emulation commands.
>> Should we use emulation SMBus commands or real commands... Don't know.
> 
> You won't see any difference on the wire. I don't know your HW. It might
> be that SMBus mode is more "automatic" and uses less interrupts. Or
> stuff like Alert or HostNotification only works in this mode. If you and
> the driver maintainers think it is worth the added complexity, I am
> fine, too.
> 
Ok. I see.
I am the maintainer. So yes I keep it as such ... with this complexity ;)

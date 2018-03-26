Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbeCZIN0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:13:26 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21942 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752096AbeCZINY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:13:24 -0400
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
From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <2fadcd7f-3bfc-997e-a30e-808f6d854f2c@st.com>
Date: Mon, 26 Mar 2018 10:13:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180324224911.xz3fz2jojcdrovb4@ninjato>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-26_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/24/2018 11:49 PM, Wolfram Sang wrote:
> On Wed, Mar 21, 2018 at 05:48:57PM +0100, Pierre-Yves MORDRET wrote:
>> This patch adds SMBus support for I2C controller embedded in STM32F7 Soc.
> 
>> All SMBus protocols are implemented except SMBus-specific protocols.
> 
> What does that mean?

It miss SMBus Host Notification and SMBBus Alert. They are almost ready but I'm
struggling to put them back to operational state after recent changes related to
SMBust Host Notification. A more "classic" interrupt base solution has been put
in place but I fail to use implement it in my side.
Another patch set is going to be delivered for these 2 commands.

> 
>>
>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
>> ---
>>   Version history:
>>     v1:
>>        * Initial
>>     v2:
>>        * fix Kbuild test robot issue (Unneeded semicolon)
>> ---
>>
>> fixup! i2c: i2c-stm32f7: Add initial SMBus protocols support
>> ---
>>  drivers/i2c/busses/i2c-stm32f7.c | 377 ++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 368 insertions(+), 9 deletions(-)
> 
> That is quite some complexity considering we have I2C_FUNC_SMBUS_EMUL. I
> don't mind, but you really want that?
> 

All SMBBus commands are implemented as such. I never try to emulation commands.
Should we use emulation SMBus commands or real commands... Don't know.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeCTJcR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:32:17 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41713 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752184AbeCTJcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:32:16 -0400
Subject: Re: [RESEND PATCH v1 6/6] i2c: i2c-stm32f7: Implement I2C recovery
 mechanism
From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
To: Wolfram Sang <wsa@the-dreams.de>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
 <1520852023-27083-7-git-send-email-pierre-yves.mordret@st.com>
 <20180317204720.mclh4jw5owobbtww@ninjato>
 <2672947b-46b2-7bd7-ac13-501db8bde72b@st.com>
Message-ID: <fdc16b28-3aab-1d37-3c93-40ed371bfd4f@st.com>
Date: Tue, 20 Mar 2018 10:31:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2672947b-46b2-7bd7-ac13-501db8bde72b@st.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-20_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

I do believe there is a misunderstanding of this recovery mechanism at my end.
I intends to solve a problem where my I2C was stall but not the slave.
Thus if bus is busy I reset the IP.

Looking at the recovery API, this recovery is for slave and nothing else with my
case. Therefore I think I have to get move this reset out of recovery API.
Please correct me whether I'm wrong

Slave Recovery mechanism is another story to implement in our platform since we
have to deal with GPIOs.

Let me know
Regards

On 03/19/2018 09:51 AM, Pierre Yves MORDRET wrote:
> Yes. Recovery mechanism is triggered whenever a busy line is detected.
> This busy state can be checked by sw when either SDA or SCL is low: a bit is set
> by Hw for this purpose.
> On busy state I2C is reconfigured and lines are released the time of recovery.
> 
> Regards
> On 03/17/2018 09:47 PM, Wolfram Sang wrote:
>> On Mon, Mar 12, 2018 at 11:53:43AM +0100, Pierre-Yves MORDRET wrote:
>>> Feature prevents I2C lock-ups. Mechanism resets I2C state machine
>>> and releases SCL/SDA signals but preserves I2C registers.
>>
>> Does it release SDA when held down by the slave? Because that is what
>> the recovery mechanism is for.
>>

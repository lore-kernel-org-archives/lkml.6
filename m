Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbeBAQuG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:50:06 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36898 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752680AbeBAQt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:49:57 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B4D0D60112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Thu, 1 Feb 2018 16:49:56 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sboyd@codeaurora.org,
        rnayak@codeaurora.org, asathyak@codeaurora.org
Subject: Re: [PATCH RFC 1/4] drivers: irqchip: pdc: add support for PDC
 interrupt controller
Message-ID: <20180201164956.GB13231@codeaurora.org>
References: <20180123175656.11942-1-ilina@codeaurora.org>
 <20180123175656.11942-2-ilina@codeaurora.org>
 <9dd8307c-4906-4707-d4d7-2ef0fc8307b6@arm.com>
 <20180130175654.GC20815@codeaurora.org>
 <619608bb-a9c5-27a1-2383-5f6b2f455499@arm.com>
 <20180131162432.GA13231@codeaurora.org>
 <83cfda67-511f-aa83-8eff-214c08de25e4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <83cfda67-511f-aa83-8eff-214c08de25e4@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31 2018 at 16:46 +0000, Marc Zyngier wrote:
>On 31/01/18 16:24, Lina Iyer wrote:
>> On Tue, Jan 30 2018 at 18:11 +0000, Marc Zyngier wrote:
>>> On 30/01/18 17:56, Lina Iyer wrote:
>>>> On Wed, Jan 24 2018 at 14:20 +0000, Marc Zyngier wrote:
>>>>> On 23/01/18 17:56, Lina Iyer wrote:
>>>>>> From : Archana Sathyakumar <asathyak@codeaurora.org>
>>>>>>
>>>>>> The Power Domain Controller (PDC) hardware block on Qualcomm SoCs houses
>>>>>> an interrupt controller along with other domain control functions to
>>>>>> handle interrupt related functions like handle falling edge or active
>>>>>> low which are not detected at the GIC and handle wakeup interrupts.
>>>>>>
>>>>>> The interrupt controller is on an always-on domain for the purpose of
>>>>>> waking up the processor, but only a subset of the processor's interrupts
>>>>>> are routed through the PDC to the GIC. The PDC powers on the processor's
>>>>>> domain, bringing the domain out of low power mode and replays the
>>>>>> pending interrupts so the GIC may wake up the processor.
>>>>>>
>>>>>> Signed-off-by: Archana Sathyakumar <asathyak@codeaurora.org>
>>>>>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>>>>>> [Lina: Split out DT bindings target data and initialization changes]
>>>>>> ---
>>>>
>> We looked at tegra's implementation and it appears similar, thought they
>> don't seemt to have the same complexity.
>
>Exactly. They are pretty similar. Hence my suggestion to adopt the same
>approach, which you don't seem to agree with.
>
I am reworking the driver based on what you have suggested in this
thread. Will submit a patchset for review in the next couple of days.

Once again, thank you for your time Marc.

-- Lina

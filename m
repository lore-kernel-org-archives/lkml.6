Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbeBAIBw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 03:01:52 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50678 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeBAIBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 03:01:48 -0500
X-Google-Smtp-Source: AH8x227FLa+Qcdi6TMm+f/OsAkXEsV70QcaOKBTuBTJHwOAyNmuTFGf15ZaNqfrjsp23hJjogQMKUg==
Subject: Re: [PATCH v11 2/6] mailbox: qcom: Create APCS child device for clock
 controller
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>
References: <20171205154701.27730-1-georgi.djakov@linaro.org>
 <20171205154701.27730-3-georgi.djakov@linaro.org>
 <CABb+yY146ho0gtbUzDv-Z_xESkU2y=UYfBA6i+522+m58LkABQ@mail.gmail.com>
 <20171224050625.GH12655@minitux>
 <CABb+yY3e1YTnf4ZYvXVzXPhOT9-6PzusDfpWRBorwd9nB97SSQ@mail.gmail.com>
 <f279f1ff-2117-c587-5018-3b3eeeedff8a@linaro.org>
 <CABb+yY3UvNx71xpt+=j4tTiLEjPTFZTxps0qe2ePa6f4yV61kQ@mail.gmail.com>
 <549f02e5-19d7-8cec-674f-247dfb2d2467@linaro.org>
 <CABb+yY3GSvSGFm54g3mt5-=AWrq+g2N2pb9Q-pBZgEzE4MXSJg@mail.gmail.com>
From: Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <384da443-a206-8db3-0a5f-90a68b7f42c2@linaro.org>
Date: Thu, 1 Feb 2018 10:01:44 +0200
MIME-Version: 1.0
In-Reply-To: <CABb+yY3GSvSGFm54g3mt5-=AWrq+g2N2pb9Q-pBZgEzE4MXSJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2018 08:57 AM, Jassi Brar wrote:
> On Thu, Feb 1, 2018 at 12:10 AM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
>> Hi Jassi,
>>
>> On 01/27/2018 05:44 AM, Jassi Brar wrote:
>>> On Thu, Jan 4, 2018 at 10:26 PM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>>> Hi Jassi,
>>>>
>>>> On 12/29/2017 08:14 AM, Jassi Brar wrote:
>>>>> Hi Bjorn,
>>>>>
>>>>> On Sun, Dec 24, 2017 at 10:36 AM, Bjorn Andersson
>>>>> <bjorn.andersson@linaro.org> wrote:
>>>>>> On Fri 22 Dec 20:57 PST 2017, Jassi Brar wrote:
>>>>>>
>>>>>>> On Tue, Dec 5, 2017 at 9:16 PM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>>>>>>> There is a clock controller functionality provided by the APCS hardware
>>>>>>>> block of msm8916 devices. The device-tree would represent an APCS node
>>>>>>>> with both mailbox and clock provider properties.
>>>>>>>>
>>>>>>> The spec might depict a 'clock' box and 'mailbox' box inside the
>>>>>>> bigger APCS box. However, from the code I see in this patchset, they
>>>>>>> are orthogonal and can & should be represented as independent DT
>>>>>>> nodes.
>>>>>>
>>>>>> The APCS consists of a number of different hardware blocks, one of them
>>>>>> being the "APCS global" block, which is what this node and drivers
>>>>>> relate to. On 8916 this contains both the IPC register and clock
>>>>>> control. But it's still just one block according to the hardware
>>>>>> specification.
>>>>>>
>>>>>> As such DT should describe the one hardware block by one node IMHO.
>>>>>>
>>>>> In my even humbler opinion, DT should describe a h/w functional unit
>>>>> which _could_ be seen as a standalone component.
>>>>
>>>> The APCS is one separate register block related to the CPU cluster. I
>>>> haven't seen any strict guidelines for such cases in the DT docs, and
>>>> during the discussion got the impression that this is the preferred
>>>> binding. Rob has also reviewed the binding, so we should be fine to move
>>>> forward with this one.
>>>>
>>> Well, I can't overrule Rob. But I am really not happy with random
>>> device spawning from mailbox drivers. I know there are such instances
>>> already in the kernel but that doesn't make it legit... unless there
>>> is some hard dependency. Is there?
>>
>> The dependency is that on this SoC, these functionalities are combined
>> into this "CPU subsystem" block.
>>
> I see the register space is shared between mailbox and the clock. So I
> guess, yes, simply creating a device here and passing the common
> regmap is tidier. Which patches are already picked up?

Patches 3, 4 and 6 are already picked into the clk tree. Still pending
are patches 1, 2 and 5.

Thanks,
Georgi

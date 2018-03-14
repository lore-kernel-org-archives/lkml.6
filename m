Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbeCNJZI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:25:08 -0400
Received: from mailproxy03.manitu.net ([217.11.48.67]:33128 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbeCNJZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:25:06 -0400
Subject: Re: [PATCH v2 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
From: Wolfgang Grandegger <wg@grandegger.com>
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
 <d7986f8f-6c52-bf39-93f0-7a837bd85241@grandegger.com>
 <03024ab7-5386-3bcf-76f2-ef2e0e9e7a78@theobroma-systems.com>
 <68564c40-396b-9081-8534-67fe96a6fb3f@grandegger.com>
Message-ID: <92e559b1-d392-015e-1aa1-0497cbd4c071@grandegger.com>
Date: Wed, 14 Mar 2018 10:25:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <68564c40-396b-9081-8534-67fe96a6fb3f@grandegger.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 14.03.2018 um 10:17 schrieb Wolfgang Grandegger:
> 
> 
> Am 14.03.2018 um 10:14 schrieb Jakob Unterwurzacher:
>> On 14.03.18 10:11, Wolfgang Grandegger wrote:
>>>> +    /* handle error frames */
>>>> +    canid = le32_to_cpu(m->msg.can_msg.id);
>>>> +    if (canid & CAN_ERR_FLAG) {
>>>> +        ucan_handle_error_frame(up, m, canid);
>>>> +        /* drop frame if berr-reporting is off */
>>>> +        if (!(up->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
>>>> +            return;
>>>> +    }
>>>
>>> You still do not generate error messages for state changes, IIUC.
>>
>> The hardware generates error frames on state changes - is that what 
>> you mean?
>>
>> In our testing, the state shows up (and updates) correctly in
>>
>>      ip -details -statistics link show can0
> 
> Counting the state changes is one thing but you should also generate 
> error messages for them.

The usual test here is:

$ candump -td -e any,0:0,#FFFFFFFF

should report proper state changes, if you send messages with

1. no cable connected
2. CAN high and low short-circuited

Also downwards if the hardware error is gone and you continue to send 
messages.

Wolfgang.

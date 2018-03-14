Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbeCNJqb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:46:31 -0400
Received: from mailproxy03.manitu.net ([217.11.48.67]:45286 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeCNJqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:46:30 -0400
Subject: Re: rx_packets/bytes stats for error frames
To: Marc Kleine-Budde <mkl@pengutronix.de>,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
 <b4f644dc-265e-01e0-acaa-88cc8f3f69f5@pengutronix.de>
 <6c1b7482-2cde-40e3-eff4-e4b94794a63e@theobroma-systems.com>
 <4c957d42-2b03-9416-75a4-e331f2ded8cf@pengutronix.de>
From: Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <e468bcfa-db2e-7fec-0cad-229561f87cdd@grandegger.com>
Date: Wed, 14 Mar 2018 10:46:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4c957d42-2b03-9416-75a4-e331f2ded8cf@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 14.03.2018 um 10:36 schrieb Marc Kleine-Budde:
> On 03/14/2018 10:09 AM, Jakob Unterwurzacher wrote:
>> On 14.03.18 08:51, Marc Kleine-Budde wrote:
>>>> +		memcpy(cf->data, m->msg.can_msg.data, cf->can_dlc);
>>>> +
>>>> +	/* don't count error frames as real packets */
>>>> +	if (!(canid & CAN_ERR_FLAG)) {
>>>> +		stats->rx_packets++;
>>>> +		stats->rx_bytes += cf->can_dlc;
>>>> +	}
>>> Please count them, too.
>>
>> We do count them, as errors!
>>
>> This is what happens when you transmit a single CAN frame with nothing
>> connected: "TX errors" shoots up but "RX packets" stays zero.
> 
> This is handled not consistent in the existing CAN drivers. In flexcan
> all and c_can (all but rx overflow) are counted as rx_packets and
> rx_bytes. (I haven't looked at the other drivers.)
> 
> I tend to count the error frames as ordinary frames.

+1, I think we should count the packets and bytes delivered to the 
network layer.

Wolfgang.

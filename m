Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeCNJ5r (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:57:47 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:41166 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750879AbeCNJ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:57:46 -0400
Subject: Re: rx_packets/bytes stats for error frames
To: Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
 <b4f644dc-265e-01e0-acaa-88cc8f3f69f5@pengutronix.de>
 <6c1b7482-2cde-40e3-eff4-e4b94794a63e@theobroma-systems.com>
 <4c957d42-2b03-9416-75a4-e331f2ded8cf@pengutronix.de>
 <e468bcfa-db2e-7fec-0cad-229561f87cdd@grandegger.com>
From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Message-ID: <ed46e696-9685-77ec-8df5-03db265d0f93@theobroma-systems.com>
Date: Wed, 14 Mar 2018 10:57:43 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e468bcfa-db2e-7fec-0cad-229561f87cdd@grandegger.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.03.18 10:46, Wolfgang Grandegger wrote:
>>> We do count them, as errors!
>>>
>>> This is what happens when you transmit a single CAN frame with nothing
>>> connected: "TX errors" shoots up but "RX packets" stays zero.
>>
>> This is handled not consistent in the existing CAN drivers. In flexcan
>> all and c_can (all but rx overflow) are counted as rx_packets and
>> rx_bytes. (I haven't looked at the other drivers.)
>>
>> I tend to count the error frames as ordinary frames.
> 
> +1, I think we should count the packets and bytes delivered to the 
> network layer.

Documentation/ABI/testing/sysfs-class-net-statistics says:

> What:		/sys/class/<iface>/statistics/rx_packets
> Date:		April 2005
> KernelVersion:	2.6.12
> Contact:	netdev@vger.kernel.org
> Description:
> 		Indicates the total number of good packets received by this
> 		network device.

I considered error frames not "good packets", but I can change that for 
v3, no problem.

Best regards,
Jakob

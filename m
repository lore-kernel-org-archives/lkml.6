Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeENUNx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:13:53 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:46647 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbeENUNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:13:50 -0400
Subject: Re: [PATCH v5 2/2] leds: lm3601x: Introduce the lm3601x LED driver
To: Pavel Machek <pavel@ucw.cz>
CC: Jacek Anaszewski <jacek.anaszewski@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <afd@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20180510174717.26540-1-dmurphy@ti.com>
 <20180510174717.26540-2-dmurphy@ti.com>
 <41267191-1308-6b9b-78fa-2893a525b49a@gmail.com>
 <17630aca-1225-df61-7a5d-a921ecd9c78c@ti.com>
 <86c2bc2f-e622-9447-e4bb-b4ee37e2d44a@ti.com> <20180514200503.GB3276@amd>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <4a631a8e-18ba-0886-039e-004980ae0cc3@ti.com>
Date: Mon, 14 May 2018 15:13:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514200503.GB3276@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 05/14/2018 03:05 PM, Pavel Machek wrote:
> Hi!
> 
>>> OK.
>>
>> OK I looked at the max776973 driver and well if the flash-max-microamp and
>> flash-max-timeout-us nodes are missing it sets a default value for each if the
>> node is not present.
>>
>> So should we remove this code from the Max77693 driver too and fail probe as being asked
>> in this driver?
> 
> Well, modifying driver without access to the hardware is tricky
> :-(. If it does something stupid (like using other than minimum values
> for the flash-max-microamp/flash-max-timeout-us), it needs to be
> fixed.

Well we should be able to test the probe/parse dt node and reject the probe if the node is not
present.  That can be done without HW the setup is done pretty early in the probe without even attempting to communicate
with the hardware.

Dan

> 
> And maybe comment "don't copy this, its wrong" would be in order...
> > Best regards,
> 									Pavel
> 


-- 
------------------
Dan Murphy

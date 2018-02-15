Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165201AbeBOR35 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:29:57 -0500
Received: from smtpweb130.aruba.it ([62.149.158.130]:50357 "EHLO
        smtpweb130.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164931AbeBOPds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:33:48 -0500
Subject: Re: [PATCH 2/2] pps-gpio: Set echo GPIO pin via devicetree
To: Lukas Senger <lukas@fridolin.com>
Cc: linux-kernel@vger.kernel.org
References: <ee4fdd16-0343-1a01-63a7-06046026659a@enneenne.com>
 <20180215125921.29494-1-lukas@fridolin.com>
 <20180215125921.29494-3-lukas@fridolin.com>
 <eb34d5ef-2e99-5983-8bdd-bf6fd0dc8bd2@enneenne.com>
 <20180215160845.72da12c3@dinghy.localdomain>
From: Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <1b0b8c09-340b-19a8-f1ac-c9e02803e88f@enneenne.com>
Date: Thu, 15 Feb 2018 16:33:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215160845.72da12c3@dinghy.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/18 16:08, Lukas Senger wrote:
>>> @@ -20,18 +21,20 @@
>>>    		target = <&gpio>;
>>>    		__overlay__ {
>>>    			pps_pins: pps_pins@12 {
>>> -				brcm,pins =     <18>;
>>> -				brcm,function = <0>;    // in
>>> -				brcm,pull =     <0>;    // off
>>> +				brcm,pins =     <18 17>;
>>> +				brcm,function = <0 1>;    // in
>>> out
>>> +				brcm,pull =     <0 0>;    // off
>>> off
>>
>> These modifications are not PPS related.
>>
>>>    			};
>>>    		};
>>>    	};
>>>    
>>>    	__overrides__ {
>>> -		gpiopin = <&pps>,"gpios:4",
>>> +		gpiopin = <&pps>,"in-gpios:4",
>>>    			  <&pps>,"reg:0",
>>>    			  <&pps_pins>,"brcm,pins:0",
>>>    			  <&pps_pins>,"reg:0";
>>> +		echopin = <&pps>,"out-gpios:4",
>>> +			  <&pps_pins>,"brcm,pins:4";
>>
>> Ditto.
> 
> I don't understand why these modifications are unrelated. Especially
> the echopin-option should exist, shouldn't it?

These modifications are needed to define a custom instance of a PPS device which 
is not part of the PPS subtree, that's why they should be put into another patch.

Ciao,

Rodolfo

-- 

HCE Engineering                      e-mail: giometti@hce-engineering.it
GNU/Linux Solutions                          giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Cosino Project - the quick prototyping embedded system - www.cosino.it
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it

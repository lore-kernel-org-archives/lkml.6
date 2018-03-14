Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeCNKFA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 06:05:00 -0400
Received: from mailproxy03.manitu.net ([217.11.48.67]:56196 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeCNKE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 06:04:58 -0400
Subject: Re: [PATCH v2 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
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
 <92e559b1-d392-015e-1aa1-0497cbd4c071@grandegger.com>
 <5b3df9d5-3e65-1114-4b51-9dcc329cbc31@theobroma-systems.com>
From: Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <b5bf52e2-0843-a2b3-b039-c39fb9c634e3@grandegger.com>
Date: Wed, 14 Mar 2018 11:04:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5b3df9d5-3e65-1114-4b51-9dcc329cbc31@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jakob,

Am 14.03.2018 um 10:48 schrieb Jakob Unterwurzacher:
> On 14.03.18 10:25, Wolfgang Grandegger wrote:
>>> Counting the state changes is one thing but you should also generate 
>>> error messages for them.
>>
>> The usual test here is:
>>
>> $ candump -td -e any,0:0,#FFFFFFFF
>>
>> should report proper state changes, if you send messages with
>>
>> 1. no cable connected
>> 2. CAN high and low short-circuited
>>
>> Also downwards if the hardware error is gone and you continue to send 
>> messages.
> Yes, we do, the hardware does it. Testcases:
> 
> (1) no cable connected
> 
>> root@rk3399-q7:~# candump -td -e any,0:0,#FFFFFFFF | head -n 1000
>>  (000.000000)  can0  178   [0]
>>  (000.000410)  can0  20000030   [8]  00 00 00 00 00 00 08 00   ERRORFRAME
>>     transceiver-status
>>     no-acknowledgement-on-tx
>>     error-counter-tx-rx{{8}{0}}
>>  (000.000445)  can0  20000030   [8]  00 00 00 00 00 00 10 00   ERRORFRAME
>>     transceiver-status
>>     no-acknowledgement-on-tx
>>     error-counter-tx-rx{{16}{0}}
>>  (000.000425)  can0  20000030   [8]  00 00 00 00 00 00 18 00   ERRORFRAME
>>     transceiver-status
>>     no-acknowledgement-on-tx
>>     error-counter-tx-rx{{24}{0}}
>>  (000.000451)  can0  20000030   [8]  00 00 00 00 00 00 20 00   ERRORFRAME
>>     transceiver-status
>>     no-acknowledgement-on-tx
>>     error-counter-tx-rx{{32}{0}}
>>  (000.000429)  can0  20000030   [8]  00 00 00 00 00 00 28 00   ERRORFRAME
>>     transceiver-status
>>     no-acknowledgement-on-tx
>>     error-counter-tx-rx{{40}{0}}
>>  (000.000448)  can0  20000030   [8]  00 00 00 00 00 00 30 00   ERRORFRAME
>>     transceiver-status
>>     no-acknowledgement-on-tx
>>     error-counter-tx-rx{{48}{0}}
>>  (000.000433)  can0  20000030   [8]  00 00 00 00 00 00 38 00   ERRORFRAME
>>     transceiver-status
>>     no-acknowledgement-on-tx
>>     error-counter-tx-rx{{56}{0}}
>>  (000.000437)  can0  20000030   [8]  00 00 00 00 00 00 40 00   ERRORFRAME
>>     transceiver-status
>>     no-acknowledgement-on-tx
>>     error-counter-tx-rx{{64}{0}}
>>  (000.000443)  can0  20000030   [8]  00 00 00 00 00 00 48 00   ERRORFRAME
>>     transceiver-status
>>     no-acknowledgement-on-tx
>>     error-counter-tx-rx{{72}{0}}
>>  (000.000437)  can0  20000030   [8]  00 00 00 00 00 00 50 00   ERRORFRAME
>>     transceiver-status
>>     no-acknowledgement-on-tx
>>     error-counter-tx-rx{{80}{0}}
>>  (000.000498)  can0  20000030   [8]  00 00 00 00 00 00 58 00   ERRORFRAME
>>     transceiver-status
>>     no-acknowledgement-on-tx
>>     error-counter-tx-rx{{88}{0}}
>>  (000.000394)  can0  20000034   [8]  00 0C 00 00 00 00 60 00   ERRORFRAME
>>     controller-problem{rx-error-warning,tx-error-warning}
>>     transceiver-status
>>     no-acknowledgement-on-tx
>>     error-counter-tx-rx{{96}{0}}
>>  (000.000433)  can0  20000034   [8]  00 0C 00 00 00 00 68 00   ERRORFRAME
>>     controller-problem{rx-error-warning,tx-error-warning}
>>     transceiver-status
>>     no-acknowledgement-on-tx
>>     error-counter-tx-rx{{104}{0}}
>>  (000.000437)  can0  20000034   [8]  00 0C 00 00 00 00 70 00   ERRORFRAME
>>     controller-problem{rx-error-warning,tx-error-warning}
>>     transceiver-status
>>     no-acknowledgement-on-tx
>>     error-counter-tx-rx{{112}{0}}
>>  (000.000443)  can0  20000034   [8]  00 0C 00 00 00 00 78 00   ERRORFRAME
>>     controller-problem{rx-error-warning,tx-error-warning}
>>     transceiver-status
>>     no-acknowledgement-on-tx
>>     error-counter-tx-rx{{120}{0}}
>>  (000.000444)  can0  20000034   [8]  00 3C 00 00 00 00 80 00   ERRORFRAME
>>     controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive} 

Just,

       controller-problem{rx-error-passive,tx-error-passive} 

>>
>>     transceiver-status
>>     no-acknowledgement-on-tx
>>     error-counter-tx-rx{{128}{0}}
>>  (000.000495)  can0  20000024   [8]  00 3C 00 00 00 00 80 00   ERRORFRAME
>>     controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive} 
>>
>>     no-acknowledgement-on-tx
>>     error-counter-tx-rx{{128}{0}}
> 
> Repeats ad infinitum...

Good! And without "berr-reporting" just the state changes should show up.

> 
> 
> (1b) cable gets connected:
> 
>>  (000.000883)  can0  20000034   [8]  00 3C 00 00 00 00 80 00   ERRORFRAME
>>     controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive} 
>>
>>     transceiver-status
>>     no-acknowledgement-on-tx
>>     error-counter-tx-rx{{128}{0}}
>>  (000.000996)  can0  20000004   [8]  00 0C 00 00 00 00 7F 00   ERRORFRAME
>>     controller-problem{rx-error-warning,tx-error-warning}
>>     error-counter-tx-rx{{127}{0}}

Back to error active is missing!? Have a look to:

https://elixir.bootlin.com/linux/latest/source/drivers/net/can/dev.c#L364

Wolfgang.

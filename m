Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6F1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3E22133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388416AbeLQRW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:22:28 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:47153 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388301AbeLQRV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:21:56 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43JScv0FWdz1r4vb;
        Mon, 17 Dec 2018 18:21:50 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43JSct5hvqz1qvRN;
        Mon, 17 Dec 2018 18:21:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id EkGWAJdMhQO8; Mon, 17 Dec 2018 18:21:49 +0100 (CET)
X-Auth-Info: zgkidFemLB6LopVG1HQXvKD6gxsi6d2hF8K5PLo8UjU=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 17 Dec 2018 18:21:49 +0100 (CET)
From:   Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Paul Burton <paul.burton@mips.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Daniel Jedrychowski <avistel@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
 <20181216213133.kwe24pif3v4wcgwp@pburton-laptop>
 <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
 <CAAEAJfAad75bHX39ETCdVv9vP0dF7PLz2vvFLLqgtyikPHqJyA@mail.gmail.com>
 <20181216222411.5jkexuaqxpfudj7b@pburton-laptop>
 <CAAEAJfAQ9=B6sm=Ard+YTDN5g5r03o=t9xU3Nu2QaKrXXZ4pGw@mail.gmail.com>
 <20181216223510.hxsdotf332ousinh@pburton-laptop>
 <CAAEAJfDHvGTPN9u4zwWRFvK1WmpLmz87CjsjzmyhcExTGHQPmA@mail.gmail.com>
Message-ID: <61a3177f-4e8d-fc51-1e81-95af3baab3a8@denx.de>
Date:   Mon, 17 Dec 2018 18:20:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAAEAJfDHvGTPN9u4zwWRFvK1WmpLmz87CjsjzmyhcExTGHQPmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/2018 05:30 PM, Ezequiel Garcia wrote:
> On Sun, 16 Dec 2018 at 19:35, Paul Burton <paul.burton@mips.com> wrote:
>>
>> Hi Ezequiel,
>>
>> On Sun, Dec 16, 2018 at 07:28:22PM -0300, Ezequiel Garcia wrote:
>>> On Sun, 16 Dec 2018 at 19:24, Paul Burton <paul.burton@mips.com> wrote:
>>>> This helps, but it only addresses one part of one of the 4 reasons I
>>>> listed as motivation for my revert. For example serial8250_do_shutdown()
>>>> also clearly intends to disable the FIFOs.
>>>>
>>>
>>> OK. So, let's fix that :-)
>>
>> I already did, or at least tried to, on Thursday [1].
>>
>>> By all means, it would be really nice to push forward and fix the garbage
>>> issue on JZ4780, as well as the transmission issue on AM335x.
>>>
>>> AM335x is a wildly popular platform, and it's not funny to break it.
>>
>> Well, clearly not if it was broken in v4.10 & only just fixed..? And
>> from Marek's commit message the patch in v4.10 doesn't break the whole
>> system just RS485.
>>
> 
> Careful here. It's naive to consider v4.10 as old in this context.
> 
> AM335x is used in hundreds of thousands of products, probably
> "industrial" products.
> Manufacturers don't always follow the kernel, and it's entirely
> likely that they notice a regression only when developing a new product,
> or when rebasing on top of a newer longterm kernel.
> 
> Then again, I don't have any details about what is Marek's original fix
> actually fixing.
> 
> Marek: could you please post the test case that you used to validate your fix?
> I can't find that anywhere.

I can't share the testcase itself because it has no license and I didn't
write it, but I can tell you what it's doing. (I'll check if I can share
the testcase verbatim too, I just sent an email to the author)

The test spawns two threads, one sending , one receiving. The sending
thread sends 8 bytes of data from /dev/ttyS4 , the receiving thread
receives the data on /dev/ttyS2 and compares the pattern. The port
settings is B1000000 8N1 with rs485conf.flags set to SER_RS485_ENABLED
and SER_RS485_RTS_AFTER_SEND. Sometimes the received data do not match
the sent data, but rather look as if one character was left over from
the previous transmission in the FIFO.

Those two UARTs are connected together by two wires, without any real
RS485 hardware to minimize the hardware complexity (it's easy to
implement that on the pocketbeagle, which is the cheap option here).

-- 
Best regards,
Marek Vasut

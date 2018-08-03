Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72C1C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B852173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B852173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbeHCLcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:32:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43389 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729913AbeHCLcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:32:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E023220789; Fri,  3 Aug 2018 11:36:43 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id B26952069C;
        Fri,  3 Aug 2018 11:36:43 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     aditya@kobol.io, Linus Walleij <linus.walleij@linaro.org>
Cc:     Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        "open list\:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        gauthier@kobol.io, alban.browaeys@gmail.com,
        "thierry.reding\@gmail.com" <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] gpio: mvebu: Add support for multiple PWM lines
References: <1532114623-81911-1-git-send-email-aditya@kobol.io>
        <CACRpkdbiAkt6hT+LeRXCjWDZwjeYDF-e3sckMOWqnL2rdqLDug@mail.gmail.com>
Date:   Fri, 03 Aug 2018 11:36:44 +0200
In-Reply-To: <CACRpkdbiAkt6hT+LeRXCjWDZwjeYDF-e3sckMOWqnL2rdqLDug@mail.gmail.com>
        (Linus Walleij's message of "Sun, 29 Jul 2018 22:58:16 +0200")
Message-ID: <87sh3vbxlf.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus and Adita
 
 On dim., juil. 29 2018, Linus Walleij <linus.walleij@linaro.org> wrote:

> Hoping for some review from Gergory, Ralph or Richard who all seem
> to use this driver!

Would it be possible to resend the series adding me in CC?  I would
like to comment the patches, but unfortunately it seems that I was in
none of the mailing list where the series had been sent.

I found the patches on patchwork, and started to have a look on it for
example, in the patch "gpio: mvebu: Add support for multiple PWM lines
per GPIO chip", I wonder why the id is stored as it was not used at all.

Having the patch inlined in an email would male the review easier.

Thanks,

Gregory

>
> Yours,
> Linus Walleij
>
> On Fri, Jul 20, 2018 at 9:24 PM Aditya Prayoga <aditya@kobol.io> wrote:
>>
>> Hi everyone,
>>
>> Helios4, an Armada 388 based NAS SBC, provides 2 (4-pins) fan connectors.
>> The PWM pins on both connector are connected to GPIO on bank 1. Current gpio-
>> mvebu does not allow more than one PWM on the same bank.
>>
>> Aditya
>>
>> ---
>>
>> Aditya Prayoga (2):
>>   gpio: mvebu: Add support for multiple PWM lines per GPIO chip
>>   gpio: mvebu: Allow to use non-default PWM counter
>>
>>  drivers/gpio/gpio-mvebu.c | 111 ++++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 92 insertions(+), 19 deletions(-)
>>
>> --
>> 2.7.4
>>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

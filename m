Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70040C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 11:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340032080D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 11:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340032080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbeKQVko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 16:40:44 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:36152 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbeKQVko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 16:40:44 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from sneezy.aussec.com (sneezy.aussec.com [172.16.0.4])
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTP id wAHBOAOc014730;
        Sat, 17 Nov 2018 22:24:15 +1100
Received: from c110-21-61-29.farfl4.nsw.optusnet.com.au
 (c110-21-61-29.farfl4.nsw.optusnet.com.au [110.21.61.29]) by www.aussec.com
 (Horde Framework) with HTTP; Sat, 17 Nov 2018 22:24:05 +1100
Message-ID: <20181117222405.14403260fhfcd07p@www.aussec.com>
Date:   Sat, 17 Nov 2018 22:24:05 +1100
From:   tom burkart <tom@aussec.com>
To:     Philipp Zabel <philipp.zabel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/4] pps: descriptor-based gpio, capture-clear
 addition
References: <20181113034007.3878-1-tom@aussec.com>
 <20181113034007.3878-2-tom@aussec.com>
 <20181113034007.3878-3-tom@aussec.com>
 <CA+gwMccq0dwEViy-u=_mTsJD+N-Long+-3z3vzvpDfFxT4UgSw@mail.gmail.com>
In-Reply-To:  <CA+gwMccq0dwEViy-u=_mTsJD+N-Long+-3z3vzvpDfFxT4UgSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.3.9)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philipp Zabel <philipp.zabel@gmail.com>:

> On Tue, Nov 13, 2018 at 5:08 AM Tom Burkart <tom@aussec.com> wrote:
>>
>> This patch changes the GPIO access for the pps-gpio driver from the
>> integer based API to the descriptor based API.  It also adds
>> documentation for the device tree capture-clear option and
>> device tree capture-clear extraction.
>>
>> The change from integer based GPIO API to the descriptor based API
>> breaks backward compatibility for the devicetree.  This is due to
>> the descriptor based API appending "-gpio" or "-gpios" (see
>> Documentation/gpio/base.txt.)
>
> Documentation/devicetree/bindings/gpio/gpio.txt says:
>  "While a non-existent <name> is considered valid
>   for compatibility reasons (resolving to the "gpios" property),
>   it is not allowed for new bindings."
>
> This is not a new binding, so there should be no reason to change it.
>
> gpiod_get() and friends support this by using the "gpios" property if
> they are passed a NULL con_id.
> of_find_gpio() in drivers/gpio/gpiolib-of.c contains the relevant code.

Hi Phillip,

Oops, sounds like I didn't read the documentation properly.  Thanks  
for the clarification.
A new patch will be on its way shortly...

Tom


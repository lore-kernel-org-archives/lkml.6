Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F61CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD0E2150F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD0E2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeHXOrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:47:07 -0400
Received: from 20.mo7.mail-out.ovh.net ([46.105.49.208]:49916 "EHLO
        20.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbeHXOrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:47:07 -0400
X-Greylist: delayed 603 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Aug 2018 10:47:06 EDT
Received: from player779.ha.ovh.net (unknown [10.109.143.145])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id EA46CC9384
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 12:56:54 +0200 (CEST)
Received: from [10.137.0.15] (093105046241.oswiecim.vectranet.pl [93.105.46.241])
        (Authenticated sender: piotr.krol@3mdeb.com)
        by player779.ha.ovh.net (Postfix) with ESMTPSA id 8BB137C00AF;
        Fri, 24 Aug 2018 12:56:49 +0200 (CEST)
Subject: Re: [PATCH] gpio: Add driver for PC Engines APU2/APU3 GPIOs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Florian Eckert <fe@dev.tdt.de>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.gpio
References: <20180801111243.2848-1-fe@dev.tdt.de>
 <CAHp75VdNf8BCYEq348CQe2OUUOLdYehsr5TmBDQXXEAm59+kDg@mail.gmail.com>
From:   =?UTF-8?Q?Piotr_Kr=c3=b3l?= <piotr.krol@3mdeb.com>
Openpgp: preference=signencrypt
Message-ID: <dc367319-8877-83cf-42e0-e3f7e8e14a7a@3mdeb.com>
Date:   Fri, 24 Aug 2018 12:56:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VdNf8BCYEq348CQe2OUUOLdYehsr5TmBDQXXEAm59+kDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16462345491141938199
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtjedrfeehgdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 09:08 PM, Andy Shevchenko wrote:

Hi Andy,

(...)

>> +#define APU_FCH_ACPI_MMIO_BASE 0xFED80000
>> +#define APU_FCH_GPIO_BASE      (APU_FCH_ACPI_MMIO_BASE + 0x1500)
> 
> Wow! Can we see ACPI tables for these boards? Care to share (via some
> file share service) output of `acpidump -o tables.dat` ?

Please find acpidump [1]. FYI I'm PC Engines firmware maintainer
(firmware is coreboot based), so I can fix required things. I'm pretty
sure that ACPI tables are not in best shape.

[1] https://pastebin.com/2neC1Sri

Best Regards,
--
Piotr Król
Embedded Systems Consultant
https://3mdeb.com | @3mdeb_com



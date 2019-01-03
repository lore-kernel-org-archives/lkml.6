Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4384C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF7B20883
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfACIHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 03:07:20 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:33972 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfACIHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 03:07:20 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-04.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gey28-0001XP-Hl from Vladimir_Zapolskiy@mentor.com ; Thu, 03 Jan 2019 00:07:16 -0800
Received: from [137.202.108.130] (137.202.0.90) by
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Thu, 3 Jan 2019 08:07:12 +0000
Subject: Re: RFC: gpio: mmio: add support for 3 direction regs
To:     "Fried, Ramon" <ramon.fried@linux.intel.com>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <linux-gpio@vger.kernel.org>
References: <32edfd70-95dc-26a1-2ea6-143344cb2384@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>,
        <vladimir.kondratiev@linux.intel.com>
From:   Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <ca7c1b99-4166-652b-aa53-8272aa66eb73@mentor.com>
Date:   Thu, 3 Jan 2019 10:07:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <32edfd70-95dc-26a1-2ea6-143344cb2384@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-08.mgc.mentorg.com (139.181.222.8) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ramon,

On 01/03/2019 09:36 AM, Fried, Ramon wrote:
> Hi.
> 
> I'm working on a driver for STA2X11 GPIO controller who seems to fit
> best to the generic mmio driver,

I hope you have seen the existing driver drivers/gpio/gpio-sta2x11.c

> the only problem I have is with the dir register case. The STA2X11
> has 3 registers for dir, one for data, one for set and one for
> clear. The generic-mmio driver has support for this fashion for the
> dat & set & clear registers but not for dirout/dirin registers.
> 
> I wonder if support for this is generic enough to deserve a patch, if
> so I'm willing to quickly add this support, if not, adding a flag
> such as below, will allow partly using the generic mmio driver only
> for set/get and the direction can be handled outside the driver.
> 

If gpio-mmio fits well, then it might be simpler to set a flag
BGPIOF_UNREADABLE_REG_DIR, then call bgpio_init() and then overwrite
.direction_input, .direction_output and .get_direction callbacks,
as a reference you can take a look at gpio-74xx-mmio.c

--
Best wishes,
Vladimir

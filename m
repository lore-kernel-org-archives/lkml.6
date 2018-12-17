Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4CCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE692133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389308AbeLQTzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:55:45 -0500
Received: from mout01.posteo.de ([185.67.36.141]:50687 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732875AbeLQTzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:55:45 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id ED3FE160064
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 20:48:08 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43JWsd1k86z6tmQ;
        Mon, 17 Dec 2018 20:48:05 +0100 (CET)
Date:   Mon, 17 Dec 2018 20:48:04 +0100 (CET)
From:   Marc Dietrich <marvin24@gmx.de>
X-X-Sender: lucile@macbook-pro.fritz.box
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Amir Mahdi Ghorbanian <indigoomega021@gmail.com>, marvin24@gmx.de,
        devel@driverdev.osuosl.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, ac100@lists.launchpad.net
Subject: Re: [PATCH 2/2] Staging: nvec: nvec: fixed check style issues
In-Reply-To: <20181217081640.GA16368@kroah.com>
Message-ID: <alpine.OSX.2.21.1812172039250.96577@macbook-pro.fritz.box>
References: <1544979463-10126-1-git-send-email-indigoomega021@gmail.com> <20181217081640.GA16368@kroah.com>
User-Agent: Alpine 2.21 (OSX 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Mon, 17 Dec 2018, Greg KH wrote:

> On Sun, Dec 16, 2018 at 08:57:43AM -0800, Amir Mahdi Ghorbanian wrote:
>> @@ -626,7 +628,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
>>  		break;
>>  	case 2:		/* first byte after command */
>>  		if (status == (I2C_SL_IRQ | RNW | RCVD)) {
>> -			udelay(33);
>> +			usleep_range(0, 33);
>
> Why is this a valid range to sleep for for this device?  Have you been
> able to verify/test this?

oh no, not again. Why does this come up again every half year? This udelay 
is a workaround for a hw bug which only seldom triggers (if it triggers at 
all). Secondly, this is in interrupt context, so *sleep timers are no go, 
afaik.

Marc


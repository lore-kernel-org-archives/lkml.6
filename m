Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1FDC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D5D2152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="soSErwte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D5D2152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388023AbeITX7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:59:46 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:40726 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbeITX7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:59:46 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 587B95C01FC;
        Thu, 20 Sep 2018 20:15:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537467301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NvkNGdf9DHW9+ltTYQVItkcIefIyBt4cGwG11YYx/U8=;
        b=soSErwtexVx+7kdzJFfo6aYPsbqjdt75IvkVXfh2vUYmGs1HetYV3Zl55EHG4wPPoEOhIy
        kjZjAI4nFYjw9fpH7vshFY2dB0XRDGvKbHUSbeYUdhIEasZWDJzQFvtB/ucpvNWKvwFT3D
        ggMnjBT3V4Qs5GkbK7BX/gyGvsk+4q4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Sep 2018 11:15:01 -0700
From:   Stefan Agner <stefan@agner.ch>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     thierry.reding@gmail.com, Jon Hunter <jonathanh@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pinctrl: tegra: move probe to __init section
In-Reply-To: <CACRpkdYZFt-FEnF86GCKqiLjFa-n3wHYLjFbvwFDWEp+AsGCZw@mail.gmail.com>
References: <20180919012427.12439-1-stefan@agner.ch>
 <20180919012427.12439-2-stefan@agner.ch>
 <CACRpkdYZFt-FEnF86GCKqiLjFa-n3wHYLjFbvwFDWEp+AsGCZw@mail.gmail.com>
Message-ID: <55d8d7831bc2504676873722958c2e4a@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.2018 08:16, Linus Walleij wrote:
> On Tue, Sep 18, 2018 at 6:24 PM Stefan Agner <stefan@agner.ch> wrote:
> 
>> The Tegra pinctrl drivers are always built-in. This allows to use
>> platform_driver_probe() and mark several functions as __init.
>> This allows the kernel to free about 1KiB of memory if Tegra
>> pinctrl drivers are not used.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> It appears the test robot complains about this patch, so I'll
> wait for a v2!

Yes I saw it, will send v2 of this patch only.

--
Stefan

> 
> Yours,
> Linus Walleij

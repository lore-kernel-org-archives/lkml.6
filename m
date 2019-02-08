Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1D4C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630D520855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfBHQAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:00:48 -0500
Received: from hs01.dk-develop.de ([173.249.23.66]:35828 "EHLO
        hs01.dk-develop.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfBHQAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:00:48 -0500
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Feb 2019 11:00:47 EST
Received: from mail.dk-develop.de (hs01.dk-develop.de [IPv6:::1])
        by hs01.dk-develop.de (Postfix) with ESMTP id CE9CE1DFEFA;
        Fri,  8 Feb 2019 16:51:53 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 08 Feb 2019 16:51:53 +0100
From:   Danilo Krummrich <danilokrummrich@dk-develop.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: ps2-gpio - flush TX work when closing port
In-Reply-To: <20190208073102.GA31622@dtor-ws>
References: <20190207222740.GA38612@dtor-ws>
 <CAGngYiWzC92Lw+Z-BAtPfEHgys0vcQOxdxo7g_JHKHF36-Hm7Q@mail.gmail.com>
 <20190208073102.GA31622@dtor-ws>
Message-ID: <fad6ebf83d088d676f0ba825ad4572ed@dk-develop.de>
X-Sender: danilokrummrich@dk-develop.de
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-08 08:31, Dmitry Torokhov wrote:
> On Thu, Feb 07, 2019 at 06:03:03PM -0500, Sven Van Asbroeck wrote:
>> On Thu, Feb 7, 2019 at 5:27 PM Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> >
>> > +       flush_work(&drvdata->tx_work.work);
>> 
>> Would cancel_work_sync() be better than flush_work() ?
> 
> No, because we want to have interrupt and gpios in a consistent state.
> If we cancel then we need to see if we should disable it or it may
> already be disabled, etc. This way we know it is enabled after
> flush_delayed_work() returns, and we need to disable it.
> 
> Thanks.

I agree with Dmitry - thanks for the fix.

Acked-by: Danilo Krummrich <danilokrummrich@dk-develop.de>

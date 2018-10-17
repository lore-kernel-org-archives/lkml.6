Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ADCECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9D92151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9D92151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeJQQPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:15:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45736 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbeJQQPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:15:02 -0400
Received: from Collabora (unknown [IPv6:2a01:cb19:8ad6:900:9b39:a64b:9838:998c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4E44B26041C;
        Wed, 17 Oct 2018 09:20:28 +0100 (BST)
Message-ID: <1539764425.3694.1.camel@collabora.com>
Subject: Re: [PATCH v3 1/1] serial: imx - Add dma buffer confugration via
 sysfs
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Date:   Wed, 17 Oct 2018 10:20:25 +0200
In-Reply-To: <20181015140118.GA16234@kroah.com>
References: <1539249903-6316-1-git-send-email-fabien.lahoudere@collabora.com>
         <20181015140118.GA16234@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, 2018-10-15 at 16:01 +0200, Greg KH wrote:
> On Thu, Oct 11, 2018 at 11:25:03AM +0200, Fabien Lahoudere wrote:
> > In order to optimize serial communication on imx53 and imx6, we may
> > need to tweak DMA period and buffer length per period.
> 
> Why can you not just automatically determine this information?  What is
> userspace going to know that the kernel can not just learn now?
> 
> Having tunables is nice, but it is even better to not need them at all.

I agree that it is better to let the kernel do the configuration.
However in our case we use several serial communication for different device
and one of them need to tweak that configuration to get small data with a better
period. However having this parameter for all serial port implies a bigger number
of interrupts for others too.

> 
> thanks,
> 
> greg k-h
-- 
Fabien

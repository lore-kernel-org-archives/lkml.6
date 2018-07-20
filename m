Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8973ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2F2204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2F2204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbeGTO2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:28:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49470 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731035AbeGTO2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:28:10 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A48A9E35;
        Fri, 20 Jul 2018 13:39:48 +0000 (UTC)
Date:   Fri, 20 Jul 2018 15:39:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH 4.9 11/66] spi/bcm63xx: make spi subsystem aware of
 message size limits
Message-ID: <20180720133946.GA22550@kroah.com>
References: <20180720121407.228772286@linuxfoundation.org>
 <20180720121407.910738439@linuxfoundation.org>
 <20180720123443.GF10784@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720123443.GF10784@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 01:34:43PM +0100, Mark Brown wrote:
> On Fri, Jul 20, 2018 at 02:13:28PM +0200, Greg Kroah-Hartman wrote:
> 
> > The bcm63xx SPI controller does not allow manual control of the CS
> > lines and will toggle it automatically before and after sending data,
> > so we are limited to messages that fit in the FIFO buffer. Since the CS
> > lines aren't available as GPIOs either, we will need to make slave
> > drivers aware of this limitation so they can handle them accordingly.
> 
> Same review comment as before: this will ask other code (which
> presumably never worked?) to change how they use the hardware in order
> to cope with the limiations which seems a bit risky to me given that
> limits like this are fairly rare so that code isn't super well exercised
> in general.

Ok, now I think I understand this better.  I've now dropped this, and
the follow-on fixup patch from the 4.9 queue.  Thanks for being patient
with me.

greg k-h

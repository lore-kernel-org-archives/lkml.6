Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF55DC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AB621BC9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AB621BC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933617AbeGDLgb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:36:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60034 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932733AbeGDLga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:36:30 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3B831CA6;
        Wed,  4 Jul 2018 11:36:27 +0000 (UTC)
Date:   Wed, 4 Jul 2018 13:36:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Pavel Machek <pavel@ucw.cz>, Andreas Klinger <ak@it-klinger.de>,
        jacek.anaszewski@gmail.com, ben.whitten@gmail.com,
        geert+renesas@glider.be, pombredanne@nexb.com,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2] leds: ledtrig-morse: send out morse code
Message-ID: <20180704113624.GA31417@kroah.com>
References: <20180703155328.GA18299@arbeit>
 <20180704065305.GA23509@amd>
 <20180704073443.GA9388@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704073443.GA9388@1wt.eu>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 09:34:43AM +0200, Willy Tarreau wrote:
> Hi Pavel,
> 
> On Wed, Jul 04, 2018 at 08:53:05AM +0200, Pavel Machek wrote:
> > As I stated before, I don't think morse encoder belongs in kernel.
> 
> On the opposite, I think that the kernel needs to be a bit more autonomous
> when it comes to reporting its own issues. Being able to report a panic
> when userland cannot be accessed for example is the reason why we've seen
> various features such as blinking keyboard LEDs for this.
> 
> > LED pattern trigger should be merged, instead.
> 
> Well, just like we have LED and LED triggers in the kernel, I think having
> a generic way to use patterns could be nice and in this case Morse could be
> one such pattern, but if that means it's limited to userland to configure
> it then it sadly voids all of its benefits.
> 
> Last, as I showed on my previous mail in this thread, the Morse encoding
> can be brought to 36 bytes, which is much less than even the registration
> code needed to feed it. At some point we need to focus on code efficiency
> and doing things right instead of how too many layers look like from far
> away. While I don't need Morse right now I consider it as a nice addition
> I would definitely enable by default on all my boards if it helps provide
> details about what prevents my system from booting or what just killed it.

I'm with Willy here, this can be some very tiny (I was waiting for
people to optimize it) code that will be smaller overall than a generic
"pattern trigger" kernel module + userspace implementation.  So I vote
for it to be merged this way.  Or, to appease everyone, why not turn
this code into a "generic" pattern trigger with the tiny addition of the
morse code interface if wanted?

thanks,

greg k-h

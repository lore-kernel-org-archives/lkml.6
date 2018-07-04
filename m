Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152C7C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A622F21A58
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A622F21A58
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933255AbeGDHfN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:35:13 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:6771 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932207AbeGDHfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:35:12 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w647Yh2T009538;
        Wed, 4 Jul 2018 09:34:43 +0200
Date:   Wed, 4 Jul 2018 09:34:43 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Andreas Klinger <ak@it-klinger.de>, jacek.anaszewski@gmail.com,
        ben.whitten@gmail.com, geert+renesas@glider.be,
        pombredanne@nexb.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2] leds: ledtrig-morse: send out morse code
Message-ID: <20180704073443.GA9388@1wt.eu>
References: <20180703155328.GA18299@arbeit>
 <20180704065305.GA23509@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704065305.GA23509@amd>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Wed, Jul 04, 2018 at 08:53:05AM +0200, Pavel Machek wrote:
> As I stated before, I don't think morse encoder belongs in kernel.

On the opposite, I think that the kernel needs to be a bit more autonomous
when it comes to reporting its own issues. Being able to report a panic
when userland cannot be accessed for example is the reason why we've seen
various features such as blinking keyboard LEDs for this.

> LED pattern trigger should be merged, instead.

Well, just like we have LED and LED triggers in the kernel, I think having
a generic way to use patterns could be nice and in this case Morse could be
one such pattern, but if that means it's limited to userland to configure
it then it sadly voids all of its benefits.

Last, as I showed on my previous mail in this thread, the Morse encoding
can be brought to 36 bytes, which is much less than even the registration
code needed to feed it. At some point we need to focus on code efficiency
and doing things right instead of how too many layers look like from far
away. While I don't need Morse right now I consider it as a nice addition
I would definitely enable by default on all my boards if it helps provide
details about what prevents my system from booting or what just killed it.

Cheers,
Willy

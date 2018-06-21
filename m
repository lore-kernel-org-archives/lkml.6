Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CB4C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D3220875
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D3220875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mielke.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754279AbeFUCVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 22:21:43 -0400
Received: from nimbus1.mmprivatehosting.com ([54.208.90.49]:57992 "EHLO
        nimbus1.mmprivatehosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754065AbeFUCVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 22:21:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by nimbus1.mmprivatehosting.com (Postfix) with ESMTP id 8E31F60028;
        Thu, 21 Jun 2018 02:21:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at mmprivatehosting.com
Received: from dave.mielke.cc (CPEc8be196b689f-CMac202ebc50a0.cpe.net.cable.rogers.com [174.115.138.203])
        (Authenticated sender: relay@dave.mielke.cc)
        by nimbus1.mmprivatehosting.com (Postfix) with ESMTPA;
        Thu, 21 Jun 2018 02:21:40 +0000 (UTC)
Received: from beta.private.mielke.cc (beta.private.mielke.cc [192.168.0.2])
        by dave.mielke.cc (Postfix) with ESMTPS id 6FC154B2;
        Wed, 20 Jun 2018 22:21:39 -0400 (EDT)
Received: from beta.private.mielke.cc (localhost [127.0.0.1])
        by beta.private.mielke.cc (8.15.2/8.15.2) with ESMTP id w5L2LdbC006170;
        Wed, 20 Jun 2018 22:21:39 -0400
Received: (from dave@localhost)
        by beta.private.mielke.cc (8.15.2/8.15.2/Submit) id w5L2LbP3006169;
        Wed, 20 Jun 2018 22:21:37 -0400
Date:   Wed, 20 Jun 2018 22:21:37 -0400
From:   Dave Mielke <Dave@mielke.cc>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Nicolas Pitre <nicolas.pitre@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] have the vt console preserve unicode characters
Message-ID: <20180621022137.GB18453@beta.private.mielke.cc>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org>
 <20180619130953.bxil552igfkckjmr@angband.pl>
 <nycvar.YSQ.7.76.1806191047070.16670@knanqh.ubzr>
 <20180621014317.ebslk3gwvpq3k6sq@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180621014317.ebslk3gwvpq3k6sq@angband.pl>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[quoted lines by Adam Borowski on 2018/06/21 at 03:43 +0200]

>It's meant for displaying braille to _sighted_ people.  And in real world,
>the main [ab]use is a way to show images that won't get corrupted by
>proportional fonts. :-þ

It's not abuse at all. I often use U+28xx to show sighted people what the
braille for something looks like. I often need to do this when, for example, I
need them to comapre what I'm showing them to what's on an actual braille
display. U+28xx is the only way for me to do this without a lengthy description
containing sequences of dot number combinations.

Also, U+28xx is the only reasonable way to share braille music between people
who use different languages.

>The primary users would be:
>* people who want symbols uncorrupted (especially if their language uses a
>  non-latin script)
>* CJK people (as discussed below)

Again, that's not true. Why aren't braille users included in this list? After
all, it's we who motivated this enhancement. I guess actual blind people
mustn't count just because there are relatively fewer of us. :-(

-- 
I believe the Bible to be the very Word of God: http://Mielke.cc/bible/
Dave Mielke            | 2213 Fox Crescent | WebHome: http://Mielke.cc/
EMail: Dave@Mielke.cc  | Ottawa, Ontario   | Twitter: @Dave_Mielke
Phone: +1 613 726 0014 | Canada  K2A 1H7   |

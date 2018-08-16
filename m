Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56FCC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826A8214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b="Cs4U9TRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826A8214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dd-wrt.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389099AbeHPJ7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 05:59:45 -0400
Received: from webmail.newmedia-net.de ([185.84.6.166]:48281 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeHPJ7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 05:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=AyR8DVGnpqa1r9O/nKIBDHakwJrguxqIdCMK0a68YIM=;
        b=Cs4U9TRQ2iV8RTE6giBnSt20PbF7itW+zhWR5lApcim644OniKwxwRacgSP1nCalO6ubsSDMdv3OPDcJQzZVSzSLfV4/UDrw108MbveT6U4eAldEk7YhxKJVsf5ImP0+xM6y0q0r/aU8AQx0JdtAD0T9XuRuP4GqblHfrnfP8xI=;
Subject: Re: [PATCH 4.9 000/107] 4.9.120-stable review
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Sven Joachim <svenjoac@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
References: <20180814171520.883143803@linuxfoundation.org>
 <6272e062-6cfc-0669-bebf-ebb039da051a@dd-wrt.com>
 <87k1orms9i.fsf@turtle.gmx.de>
 <55df6754-ce8c-520a-13f9-c610ac498173@dd-wrt.com>
 <20180815185553.GA18219@roeck-us.net>
 <69700876-f31a-ea0a-bdea-2e82b7a5d308@dd-wrt.com>
 <20180815192630.GA20575@roeck-us.net>
 <CA+55aFzHYYai0ZR3eapEqQzt9KVcg8+bGDSmTmc6CzhpmFVfdw@mail.gmail.com>
 <c05b614d-0d4d-6e6b-1014-d5d16875e096@dd-wrt.com>
 <CA+55aFzrU=d1y=D32fyyKfqBaxxE78ht=9yhOV4u30ft=x8mWg@mail.gmail.com>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <f7bc085f-0b9f-68c6-5854-82a06a0636ca@dd-wrt.com>
Date:   Thu, 16 Aug 2018 09:03:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFzrU=d1y=D32fyyKfqBaxxE78ht=9yhOV4u30ft=x8mWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [91.47.40.61] (helo=[10.88.193.131])
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1fqCJT-0003y6-8Z; Thu, 16 Aug 2018 09:03:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 15.08.2018 um 22:42 schrieb Linus Torvalds:
>
> It would definitely be helpful, since I'm already quite busy with the
> normal merge window work. Having the embargo for L1TF end just as the
> merge window opened wasn't all that convenient.

all good so far. i checked them all and i will see how my nightly build 
goes out which does compilation on alot of
mips, arm, powerpc etc. platforms

>
> Of course, I have my own "I will delay 4.18 by a week" to blame for the timing.
>
> So if you can find the places that break, and add the right header,
> and send me a patch for all the ones you find, that would be lovely.
will do so. but for now it seems that this was really the only one
>
> It's not necessarilky always <linux/io.h> or <linux/irq.h> that makes
> sense to add as an include. As mentioned, sometimes it's
> <linux/slab.h> or similar.

mmh why? i prefer to include the correct header which references the 
function or macro instead of adding
a header which finds the right way by multiple iterations. its more 
transparent


Sebastian


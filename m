Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id TieXCOmIGVuXTwAAmS7hNA
	; Thu, 07 Jun 2018 19:35:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1331D6089E; Thu,  7 Jun 2018 19:35:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=2.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,INVALID_DATE_TZ_ABSURD,L_SPAM_TOOL_13,
	MAILING_LIST_MULTI autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1F709601C3;
	Thu,  7 Jun 2018 19:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F709601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=mageia.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753325AbeFGTfC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:35:02 -0400
Received: from mx2.yrkesakademin.fi ([85.134.45.195]:54400 "EHLO
        mx2.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753014AbeFGTfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:35:00 -0400
Subject: Re: building in 32bit chroot on x86_64 host broken
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC: Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CA+55aFxhx_tKGm02UySguvbyfB_7oTF31QfgOHCK0YkBvmfV0g@mail.gmail.com>
 <8f46ed9a-85c0-8df4-2d1e-d268cbc9d0e9@mageia.org>
 <CA+55aFwJAbr8_Xs0ZX9K2iAr8bf=ZgNnKTLopQe6jPCgEBemrA@mail.gmail.com>
 <7a5458da-4222-7480-00ed-a51bed2c1e39@mageia.org>
 <CA+55aFyD0OMV1eoc9wh_hLcnRhHq2FwJf4EZcORmHPNxTRSX9Q@mail.gmail.com>
 <daf0fbba-6357-1748-d583-bcb5edf067ec@mageia.org>
 <CA+55aFwiyuA4fKztofM-fdDSc+ZH9aAR1xksL8ZWRDE-pdXruw@mail.gmail.com>
 <CAK7LNAS=PvYVrLczeJT0utq3UHNL5YtSE_w=RjJYJ3SD9ALrYA@mail.gmail.com>
 <CA+55aFzNCQZHEz9P2a4ZSyWB0RxZcTkh5TVfwTmup-Y-6b8qjw@mail.gmail.com>
 <CA+55aFwAwoDdZRP6n9xXDPkeCUm35mmGH3fXv=r1HOZq1bpiGw@mail.gmail.com>
 <CAK7LNAS4Xb_CQ31t_cqt3q0zRFZ-O2n3+qkxXfxZB_jmqvFmWQ@mail.gmail.com>
From: Thomas Backlund <tmb@mageia.org>
Message-ID: <f1f35cdf-bd03-54bb-7196-c13131f7d0fc@mageia.org>
Date: Thu, 7 Jun 2018 22:35:17 +0259
MIME-Version: 1.0
In-Reply-To: <CAK7LNAS4Xb_CQ31t_cqt3q0zRFZ-O2n3+qkxXfxZB_jmqvFmWQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-WatchGuard-Spam-ID: str=0001.0A0C0202.5B1988E4.0168,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-WatchGuard-Spam-Score: 0, clean; 0, virus threat unknown
X-WatchGuard-Mail-Client-IP: 85.134.45.195
X-WatchGuard-Mail-From: tmb@mageia.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 2018-06-06 kl. 06:30, skrev Masahiro Yamada:
> Hi Linus,
>
> 2018-06-06 11:19 GMT+09:00 Linus Torvalds <torvalds@linux-foundation.org>:
>> On Tue, Jun 5, 2018 at 6:54 PM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>> But once you *have* that particular Kconfig, I do think that "make
>>> oldconfig" should just work. And it apparently used to.
>>>
>>> So I think this is a behavioral regression.
>> That doesn't necessarily mean that he fix should be to revert.
>
> If this is a regression, I am OK with the revert,
> and it is the only quick solution.
>

It is a regression as the same "make oldconfig routine" has been working 
iirc since atleast 2.4 series kernels :)

But I dont see it as needing a "quick solution" revert if the "kconfig: 
only write '# CONFIG_FOO is not set' for visible symbols" is considered 
a "useful thing we want to keep"... I'd rather think waiting/working a 
bit for a proper fix is the better way then...

I can work around it for now (or keep the revert in our kernel builds 
for now) until it gets properly fixed...

Feel free to cc me on suggested fixes to test

--
Thomas

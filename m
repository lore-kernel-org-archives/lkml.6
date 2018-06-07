Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0+GpOLuLGVvWXwAAmS7hNA
	; Thu, 07 Jun 2018 19:47:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9BA966074D; Thu,  7 Jun 2018 19:47:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=2.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,INVALID_DATE_TZ_ABSURD,L_SPAM_TOOL_13,
	MAILING_LIST_MULTI autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 033C9605A2;
	Thu,  7 Jun 2018 19:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 033C9605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=mageia.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932582AbeFGTrz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:47:55 -0400
Received: from mx1.yrkesakademin.fi ([85.134.45.194]:39930 "EHLO
        mx1.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753588AbeFGTrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:47:53 -0400
Subject: Re: building in 32bit chroot on x86_64 host broken
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulf Magnusson <ulfalizer@gmail.com>,
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
 <f1f35cdf-bd03-54bb-7196-c13131f7d0fc@mageia.org>
 <CA+55aFxe+LooLzpvBLwW9Ehwomp45zdJ3a-P71ipHJzdMmtDkQ@mail.gmail.com>
From: Thomas Backlund <tmb@mageia.org>
Message-ID: <67595efc-410d-7517-d788-eb3c4d2d7129@mageia.org>
Date: Thu, 7 Jun 2018 22:48:11 +0259
MIME-Version: 1.0
In-Reply-To: <CA+55aFxe+LooLzpvBLwW9Ehwomp45zdJ3a-P71ipHJzdMmtDkQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-WatchGuard-Spam-ID: str=0001.0A0C0202.5B198BE9.011D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-WatchGuard-Spam-Score: 0, clean; 0, virus threat unknown
X-WatchGuard-Mail-Client-IP: 85.134.45.194
X-WatchGuard-Mail-From: tmb@mageia.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 2018-06-07 kl. 22:40, skrev Linus Torvalds:
> On Thu, Jun 7, 2018 at 12:35 PM Thomas Backlund <tmb@mageia.org> wrote:
>> I can work around it for now (or keep the revert in our kernel builds
>> for now) until it gets properly fixed...
> So rather than doing the revert, it's probably better if  your
> workaround just does
>
>     make ARCH=i386 oldconfig
>
> (or maybe even just a "export ARCH=i386" in the environment)
>
> That should get you to continue to otherwise do the same thing.
>
> And if it turns out that your flow is the *only* one affected by this,
> and nobody else complains, maybe we can just say "yeah, slight change
> in build rules, easy to work around" and leave it at that.
>
>                  Linus

Yeah, I can live with that too :)

I just wanted to point out the regression in case it was not (sort of) 
intentional...

--
Thomas

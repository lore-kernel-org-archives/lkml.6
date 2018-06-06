Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Bp/n2VM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 886E36063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932113AbeFFDcE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Tue, 5 Jun 2018 23:32:04 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:36808 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752762AbeFFDcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 23:32:03 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w563VppX029387
X-Nifty-SrcIP: [209.85.217.176]
X-Google-Smtp-Source: ADUXVKLxHbwjmjxE3GKSu9EPZe62024XAf5tx2AxnoBDel3nGXBEchueAIFCePWmVFnUhZ+zlT0WwHlmS+6JF4n9l/A=
MIME-Version: 1.0
In-Reply-To: <CA+55aFwAwoDdZRP6n9xXDPkeCUm35mmGH3fXv=r1HOZq1bpiGw@mail.gmail.com>
References: <CA+55aFxhx_tKGm02UySguvbyfB_7oTF31QfgOHCK0YkBvmfV0g@mail.gmail.com>
 <8f46ed9a-85c0-8df4-2d1e-d268cbc9d0e9@mageia.org> <CA+55aFwJAbr8_Xs0ZX9K2iAr8bf=ZgNnKTLopQe6jPCgEBemrA@mail.gmail.com>
 <7a5458da-4222-7480-00ed-a51bed2c1e39@mageia.org> <CA+55aFyD0OMV1eoc9wh_hLcnRhHq2FwJf4EZcORmHPNxTRSX9Q@mail.gmail.com>
 <daf0fbba-6357-1748-d583-bcb5edf067ec@mageia.org> <CA+55aFwiyuA4fKztofM-fdDSc+ZH9aAR1xksL8ZWRDE-pdXruw@mail.gmail.com>
 <CAK7LNAS=PvYVrLczeJT0utq3UHNL5YtSE_w=RjJYJ3SD9ALrYA@mail.gmail.com>
 <CA+55aFzNCQZHEz9P2a4ZSyWB0RxZcTkh5TVfwTmup-Y-6b8qjw@mail.gmail.com> <CA+55aFwAwoDdZRP6n9xXDPkeCUm35mmGH3fXv=r1HOZq1bpiGw@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 6 Jun 2018 12:31:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS4Xb_CQ31t_cqt3q0zRFZ-O2n3+qkxXfxZB_jmqvFmWQ@mail.gmail.com>
Message-ID: <CAK7LNAS4Xb_CQ31t_cqt3q0zRFZ-O2n3+qkxXfxZB_jmqvFmWQ@mail.gmail.com>
Subject: Re: building in 32bit chroot on x86_64 host broken
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: tmb@mageia.org, Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

2018-06-06 11:19 GMT+09:00 Linus Torvalds <torvalds@linux-foundation.org>:
> On Tue, Jun 5, 2018 at 6:54 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> But once you *have* that particular Kconfig, I do think that "make
>> oldconfig" should just work. And it apparently used to.
>>
>> So I think this is a behavioral regression.
>
> That doesn't necessarily mean that he fix should be to revert.


If this is a regression, I am OK with the revert,
and it is the only quick solution.



> Maybe the fix is to simply change how we generate the ARCH variable.
>
> Right now, in the Makefile, it is
>
>     ARCH ?= $(SUBARCH)
>
> so basically "if the user didn't specify ARCH, we pick it from SUBARCH".
>
> But that doesn't make much sense for "make oldconfig" does it?
>
> So maybe we could make the rule be that if the user didn't specify
> ARCH explicitly, we take it from SUBARCH, _except_ if we are doing
> "make oldconfig", in which case we take it from the .config file.
>
> That makes a certain amount of sense, wouldn't you agree? Doing
> "oldconfig" and silently changing ARCH under the user seems pretty
> user-hostile.
>
> In fact, I think it would _always_ make sense to take ARCH from the
> config file, _unless_ we're actively generating a new config file
> entirely (ie "make *config", not counting "oldconfig").
>
> Hmm?
>
>                 Linus


This is a big hammer.

It is difficult to make a quick answer.


In fact, I saw a patch series a few years ago.

https://lkml.org/lkml/2014/9/1/70

It was not accepted.
(I was not a maintainer at that time)

I do not remember the details,
but I thought it was a double-edged sword.




-- 
Best Regards
Masahiro Yamada

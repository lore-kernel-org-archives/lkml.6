Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YgF/Ip7GG1tyLwAAmS7hNA
	; Sat, 09 Jun 2018 12:24:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A5B1D607A4; Sat,  9 Jun 2018 12:24:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xa1LKJBP"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 01CBE602FC;
	Sat,  9 Jun 2018 12:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01CBE602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753259AbeFIMYp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 08:24:45 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:24592 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753175AbeFIMYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 08:24:43 -0400
Received: from mail-vk0-f54.google.com (mail-vk0-f54.google.com [209.85.213.54]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w59CObAX002527
        for <linux-kernel@vger.kernel.org>; Sat, 9 Jun 2018 21:24:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w59CObAX002527
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528547077;
        bh=JponS2F5yrkQN1tP9JrgCKS7Gl1jUTYQv7Q8hWNkGUg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=xa1LKJBP9qvc1HP2fHngsmV7E7tckjYEVgJI/EvX6W5dM25OPSG3YZpsYUM1CIM6v
         E59jCiBXHLoTb5erwCtA8MclptCD41Hx2ryIq1zhhRwCgljoAi9szcBXLy4vBFJaOa
         U2BkFDJpzFBsqfrJ+b3CcY86BoikjIirCxW7wRCl7vAaJhKG8SuCuw8/3D6vXO+xwx
         PxqmhlkCuqo7MGxhJfqGwkRhL5/TnKbSQHmiWvmNywtT2brVduKgxBj594ywmx83EQ
         ysrDdXsaC8ziIZQgy8HBm6M5B7JXpDxkLi9Ca6MkCcv7NHp5el560oWt5BCaDeEsKl
         CeNCfvTJfzA3Q==
X-Nifty-SrcIP: [209.85.213.54]
Received: by mail-vk0-f54.google.com with SMTP id d74-v6so9513861vke.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 05:24:37 -0700 (PDT)
X-Gm-Message-State: APt69E1//g9/lpELZrUHAJQh7iQfZLN80l/FcdrdEg/n8JuWgIya/s42
        JMnEPP5izuc+v6E5apzXIf2x4ocr62ajRS8xYDo=
X-Google-Smtp-Source: ADUXVKLt229qIdHbg7CWkBm54DdGRo2c09kDsmGPEcxAJL7Wu5bPnp/pG2mt/VzaC4KSXSX3rqahHIGsW97WZV6VZuE=
X-Received: by 2002:a1f:a945:: with SMTP id s66-v6mr6493826vke.54.1528547076397;
 Sat, 09 Jun 2018 05:24:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Sat, 9 Jun 2018 05:23:55 -0700 (PDT)
In-Reply-To: <20180608091227.jbigan3vplns2oxk@unicorn.suse.cz>
References: <7a5458da-4222-7480-00ed-a51bed2c1e39@mageia.org>
 <CA+55aFyD0OMV1eoc9wh_hLcnRhHq2FwJf4EZcORmHPNxTRSX9Q@mail.gmail.com>
 <daf0fbba-6357-1748-d583-bcb5edf067ec@mageia.org> <CA+55aFwiyuA4fKztofM-fdDSc+ZH9aAR1xksL8ZWRDE-pdXruw@mail.gmail.com>
 <CAK7LNAS=PvYVrLczeJT0utq3UHNL5YtSE_w=RjJYJ3SD9ALrYA@mail.gmail.com>
 <CA+55aFzNCQZHEz9P2a4ZSyWB0RxZcTkh5TVfwTmup-Y-6b8qjw@mail.gmail.com>
 <CA+55aFwAwoDdZRP6n9xXDPkeCUm35mmGH3fXv=r1HOZq1bpiGw@mail.gmail.com>
 <CAK7LNAS4Xb_CQ31t_cqt3q0zRFZ-O2n3+qkxXfxZB_jmqvFmWQ@mail.gmail.com>
 <f1f35cdf-bd03-54bb-7196-c13131f7d0fc@mageia.org> <CA+55aFxe+LooLzpvBLwW9Ehwomp45zdJ3a-P71ipHJzdMmtDkQ@mail.gmail.com>
 <20180608091227.jbigan3vplns2oxk@unicorn.suse.cz>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 9 Jun 2018 21:23:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQrhBukG14-ggBWPBauB1shAiuZvESo70KrFxuOwhRJjg@mail.gmail.com>
Message-ID: <CAK7LNAQrhBukG14-ggBWPBauB1shAiuZvESo70KrFxuOwhRJjg@mail.gmail.com>
Subject: Re: building in 32bit chroot on x86_64 host broken
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Backlund <tmb@mageia.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-08 18:12 GMT+09:00 Michal Kubecek <mkubecek@suse.cz>:
> On Thu, Jun 07, 2018 at 12:40:30PM -0700, Linus Torvalds wrote:
>> On Thu, Jun 7, 2018 at 12:35 PM Thomas Backlund <tmb@mageia.org> wrote:
>> >
>> > I can work around it for now (or keep the revert in our kernel builds
>> > for now) until it gets properly fixed...
>>
>> So rather than doing the revert, it's probably better if  your
>> workaround just does
>>
>>    make ARCH=i386 oldconfig
>>
>> (or maybe even just a "export ARCH=i386" in the environment)
>>
>> That should get you to continue to otherwise do the same thing.
>>
>> And if it turns out that your flow is the *only* one affected by this,
>> and nobody else complains, maybe we can just say "yeah, slight change
>> in build rules, easy to work around" and leave it at that.
>
> Not the only one, we hit the same problem when building openSUSE
> packages (4.17-rc1) but we resolved it by always setting ARCH:
>
>   https://github.com/openSUSE/kernel-source/commit/fb21b7321ab5
>
> It also revealed that we forgot to pass MAKE_ARGS to other phases of RPM
> build process so we don't have reason to complain.
>
> Michal Kubecek


Just a note.

In case of cross-compiling, not only ARCH but also CROSS_COMPILE
must be passed when you do "make *config".

In this merge window, some compiler option tests are being moved
from Makefiles to the Kconfig phase.

People tend to set "export CROSS_COMPILE=..."
in their build environment.
I have not received any complaint about this change so far.



-- 
Best Regards
Masahiro Yamada

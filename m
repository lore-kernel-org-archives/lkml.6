Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Hn1EBEvFG1uHHwAAmS7hNA
	; Sat, 09 Jun 2018 12:17:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EA9FF6089E; Sat,  9 Jun 2018 12:17:14 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wyUvB40V"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3F0A6606FA;
	Sat,  9 Jun 2018 12:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F0A6606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753261AbeFIMRM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 08:17:12 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:60935 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752979AbeFIMRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 08:17:10 -0400
Received: from mail-vk0-f41.google.com (mail-vk0-f41.google.com [209.85.213.41]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w59CGoXC006071
        for <linux-kernel@vger.kernel.org>; Sat, 9 Jun 2018 21:16:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w59CGoXC006071
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528546611;
        bh=X6AOlhC2rJJQXSuIWpUbByVrVAi64vekmYeNLzRIP2U=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=wyUvB40VdWV+gs1inwk+aei3StnNCUNlpMocketk8lepvxy285/JTX3QlB4flNRyK
         +1QC2VkHmNeUp2i7i2sKXRzvwjTNzeJBIbW6cHA6jknRPtn9M4T9RhGpkD3SNywVgt
         geiUUio1y3oaO3clax/IRoRy/E4nL+KPvlgWRN2Pvw40EbU6M7y7u9XtNWUhYpQ/yL
         MQ6PEj9t6wVhYJkouoPgv5aDVRhqtrdvgfQr29YlnVXbsSee29ECTT40NV/sYO7eNv
         w6UUPsOs886WaUi7b+RrBa/NM8gyltnNHfjwiHQlKEP1/thOikhOVyXpPIoAGyl0f0
         eb1tvbMik5INg==
X-Nifty-SrcIP: [209.85.213.41]
Received: by mail-vk0-f41.google.com with SMTP id q135-v6so9798554vkh.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 05:16:51 -0700 (PDT)
X-Gm-Message-State: APt69E0OLbctbrMR+YPfi53OwPVkY3ebfuSovrQGCT1xu0cNUFMTF7mF
        z/NzA1giVofRG9QbppfqFu6Uhilluse4Spd+j9E=
X-Google-Smtp-Source: ADUXVKLOWUAb5Qn0zZmxg2c5NeMMiG+0JZooIfb6JBIZSJZYMnIHOC177ZgGs1R2Rj1c3KFCkZtjw76kwXldCB0a/KQ=
X-Received: by 2002:a1f:cc85:: with SMTP id c127-v6mr6213662vkg.166.1528546610207;
 Sat, 09 Jun 2018 05:16:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Sat, 9 Jun 2018 05:16:09 -0700 (PDT)
In-Reply-To: <67595efc-410d-7517-d788-eb3c4d2d7129@mageia.org>
References: <CA+55aFxhx_tKGm02UySguvbyfB_7oTF31QfgOHCK0YkBvmfV0g@mail.gmail.com>
 <8f46ed9a-85c0-8df4-2d1e-d268cbc9d0e9@mageia.org> <CA+55aFwJAbr8_Xs0ZX9K2iAr8bf=ZgNnKTLopQe6jPCgEBemrA@mail.gmail.com>
 <7a5458da-4222-7480-00ed-a51bed2c1e39@mageia.org> <CA+55aFyD0OMV1eoc9wh_hLcnRhHq2FwJf4EZcORmHPNxTRSX9Q@mail.gmail.com>
 <daf0fbba-6357-1748-d583-bcb5edf067ec@mageia.org> <CA+55aFwiyuA4fKztofM-fdDSc+ZH9aAR1xksL8ZWRDE-pdXruw@mail.gmail.com>
 <CAK7LNAS=PvYVrLczeJT0utq3UHNL5YtSE_w=RjJYJ3SD9ALrYA@mail.gmail.com>
 <CA+55aFzNCQZHEz9P2a4ZSyWB0RxZcTkh5TVfwTmup-Y-6b8qjw@mail.gmail.com>
 <CA+55aFwAwoDdZRP6n9xXDPkeCUm35mmGH3fXv=r1HOZq1bpiGw@mail.gmail.com>
 <CAK7LNAS4Xb_CQ31t_cqt3q0zRFZ-O2n3+qkxXfxZB_jmqvFmWQ@mail.gmail.com>
 <f1f35cdf-bd03-54bb-7196-c13131f7d0fc@mageia.org> <CA+55aFxe+LooLzpvBLwW9Ehwomp45zdJ3a-P71ipHJzdMmtDkQ@mail.gmail.com>
 <67595efc-410d-7517-d788-eb3c4d2d7129@mageia.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 9 Jun 2018 21:16:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQiCz7bdDCyOc7VtA5=GdzT6nFp4kX7D21LEfFeJ8mURg@mail.gmail.com>
Message-ID: <CAK7LNAQiCz7bdDCyOc7VtA5=GdzT6nFp4kX7D21LEfFeJ8mURg@mail.gmail.com>
Subject: Re: building in 32bit chroot on x86_64 host broken
To: Thomas Backlund <tmb@mageia.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-08 4:49 GMT+09:00 Thomas Backlund <tmb@mageia.org>:
>
> Den 2018-06-07 kl. 22:40, skrev Linus Torvalds:
>>
>> On Thu, Jun 7, 2018 at 12:35 PM Thomas Backlund <tmb@mageia.org> wrote:
>>>
>>> I can work around it for now (or keep the revert in our kernel builds
>>> for now) until it gets properly fixed...
>>
>> So rather than doing the revert, it's probably better if  your
>> workaround just does
>>
>>     make ARCH=i386 oldconfig
>>
>> (or maybe even just a "export ARCH=i386" in the environment)
>>
>> That should get you to continue to otherwise do the same thing.
>>
>> And if it turns out that your flow is the *only* one affected by this,
>> and nobody else complains, maybe we can just say "yeah, slight change
>> in build rules, easy to work around" and leave it at that.
>>
>>                  Linus
>
>
> Yeah, I can live with that too :)
>
> I just wanted to point out the regression in case it was not (sort of)
> intentional...



If you want to do 'make oldconfig' without setting ARCH,
maybe the following could work.



diff --git a/Makefile b/Makefile
index 019a5a0..b491e86 100644
--- a/Makefile
+++ b/Makefile
@@ -292,7 +292,7 @@ export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE
KERNELVERSION
 # then ARCH is assigned, getting whatever value it gets normally, and
 # SUBARCH is subsequently ignored.

-SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
+SUBARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/x86_64/x86/ \
                                  -e s/sun4u/sparc64/ \
                                  -e s/arm.*/arm/ -e s/sa110/arm/ \
                                  -e s/s390x/s390/ -e s/parisc64/parisc/ \


or


diff --git a/Makefile b/Makefile
index 019a5a0..3586967 100644
--- a/Makefile
+++ b/Makefile
@@ -292,7 +292,7 @@ export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE
KERNELVERSION
 # then ARCH is assigned, getting whatever value it gets normally, and
 # SUBARCH is subsequently ignored.

-SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
+SUBARCH := $(shell uname -m | sed -e s/i.86/i386/ \
                                  -e s/sun4u/sparc64/ \
                                  -e s/arm.*/arm/ -e s/sa110/arm/ \
                                  -e s/s390x/s390/ -e s/parisc64/parisc/ \





-- 
Best Regards
Masahiro Yamada

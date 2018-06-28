Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426C5C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED735274AA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="hX0bAbY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED735274AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966371AbeF1N50 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:57:26 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:44237 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966300AbeF1N5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:57:25 -0400
Received: from mail-ua0-f173.google.com (mail-ua0-f173.google.com [209.85.217.173]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w5SDv8P9025348;
        Thu, 28 Jun 2018 22:57:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w5SDv8P9025348
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530194229;
        bh=X0qGhccR/BUGxsWeSawO+lbdpvGrG6zIT2TQkELeolY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=hX0bAbY3oBO4lis2e3e34N1T8LITs3+5hVsTiiIwi5HxeHSWsOvlY/zuJ/skspUw0
         nSvV+2MtJ80R+kZFwXGahwX0MN7q8n9bbOREWAtKjDkr4+MbwUPr4J+s3WNx2WbWE5
         DJI6l3z0/6x3Rn90bLCXulnkf4J48TXfsgZItvD4O9d5Vu/Jr+LFf8HBxoT5vmTyzv
         2KSedaJbTIQU2aqCY4sAhglsmez885xDT1qKgm8eZFMXKXx16VIk+sIHJVA2U/bTEy
         n3joCTQZtrXR0VSQgmiE6cytLy+CY3tm2BOdWxAkkPcxD87hhgzdYAjyP4MA7677Jg
         7Ma2syqnU3XuQ==
X-Nifty-SrcIP: [209.85.217.173]
Received: by mail-ua0-f173.google.com with SMTP id y8-v6so3615461uan.3;
        Thu, 28 Jun 2018 06:57:08 -0700 (PDT)
X-Gm-Message-State: APt69E3+QyNKkRzqNpq1GwQP8MiqC2+L2hPUmsENIG9sllV5wMjxS6du
        gdyE23w8SBDye4ns99aNSYYUlSGlX3XCsnL3lyg=
X-Google-Smtp-Source: AAOMgpeUmIoBeJvU7jDqw1I3ZkRjjf+75NwW+v8CqevaEGxhRyAXptzuJfl5Dqzi/qf2AxO7FHYOxgJGB4ZoO+3pM0Q=
X-Received: by 2002:ab0:2e3:: with SMTP id 90-v6mr6100315uah.144.1530194227612;
 Thu, 28 Jun 2018 06:57:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 06:56:27
 -0700 (PDT)
In-Reply-To: <d55c2992-09b8-5182-419d-8efa5782ea16@redhat.com>
References: <20180612003224.3658-1-labbott@redhat.com> <20180612003224.3658-4-labbott@redhat.com>
 <20180621124334.GA30110@gmail.com> <d55c2992-09b8-5182-419d-8efa5782ea16@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 28 Jun 2018 22:56:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNATnp8oow-Ra36Ucy3GOfYH_TxmxCPkwMw6WceW5fTbCcA@mail.gmail.com>
Message-ID: <CAK7LNATnp8oow-Ra36Ucy3GOfYH_TxmxCPkwMw6WceW5fTbCcA@mail.gmail.com>
Subject: Re: [PATCHv4 3/3] x86: Add build salt to the vDSO and kernel linker scripts
To:     Laura Abbott <labbott@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Mark Wielaard <mjw@fedoraproject.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


2018-06-22 0:58 GMT+09:00 Laura Abbott <labbott@redhat.com>:
> On 06/21/2018 05:43 AM, Ingo Molnar wrote:
>>
>>
>> * Laura Abbott <labbott@redhat.com> wrote:
>>
>>>
>>> Both the kernel and the vDSO need to have unique build ids.
>>> Insert the build salt section to make the build ids unique.
>>>
>>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>>> ---
>>>   arch/x86/entry/vdso/vdso-layout.lds.S | 3 ++-
>>>   arch/x86/kernel/vmlinux.lds.S         | 1 +
>>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>>
>> Acked-by: Ingo Molnar <mingo@kernel.org>
>>
>> What is the upstream merge plan for this series? kbuild tree?
>>
>> Thanks,
>>
>>         Ingo
>>
>
> There was an alternate proposal that requires slightly fewer
> changes that needs to be cleaned up and submitted. I do
> think the plan is for the series to eventually go through
> the kbuild tree.


Yes.  V5 is welcome.

Thanks.





-- 
Best Regards
Masahiro Yamada

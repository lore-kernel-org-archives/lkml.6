Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F47ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F2220856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjM9wBQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F2220856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388588AbeGXJRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:17:35 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36234 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388346AbeGXJRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:17:35 -0400
Received: by mail-qk0-f195.google.com with SMTP id a132-v6so2095685qkg.3;
        Tue, 24 Jul 2018 01:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=SO3D86iPlRAml+RVRGhV2rbTcWlABf9xdX7ksS4owRo=;
        b=IjM9wBQSNdTPJU55cO8gO/0E9KXyoeWysnHC97Mdsg/ID8EB1ec7qkr7iF86uh/SMw
         OVRrU/hFG7syblLSW7Hrqz773yg+dfpF8Rlm+cq9X74gaq2i3zbzlpApbF8pHzsFf5zC
         XuJ7lxG8vIVHmlKdZFijeiTsciRPMlgQFb4MGshnElDj4ocV9MGk4RXE1dAGcmJUH84u
         eyDv73Mz2sc0VgL+6297k6+cwTxeN8WCCex/0zd7qer6HGgF+orWHsMs7V3SsaMPcZez
         S5NKIrAUNtRFVgb7shxwz+naKrdMUsV85BWTFr/xodLodo57jKfvGJm37vWnn4EIORza
         RqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=SO3D86iPlRAml+RVRGhV2rbTcWlABf9xdX7ksS4owRo=;
        b=VB5gQxPfiPQrtj/SItBI9ObvERz/OMmghXnUqNJCPUKN1dyZH8dKfvgXGIq9IfOIFp
         8Mydwom3lte8d9HEoNG7neY4Jm0u2TGmmApLAZRPab5GsojDHAcyj002ZdqDwTz3U39y
         hBQC7h51gQKDz8hEAQkG8IoX6wv9Uwl06v5jAzhFFM5Z/GZ/ahL+1OZsil3uQnfN0Kq4
         gXXS0sG14zKNCOGOFDraB9KQmWIE7TLrUxtxsXDNO5RLLZSOjKE+VA5qBeiJB5L25cHA
         9ge6d13FMiRtFyk/rSGvlxgqxb4LtCIiZ1Bkl/d4/l0HXsMBJOkhTMZtU418ktJ32QVP
         wHhw==
X-Gm-Message-State: AOUpUlFbWt2/SLAxrdfm25lIzfviSO+DzHwTWpzdot88WuZkpfw9/qGd
        6ECu9jf9smQQhp0ZI/kmjfYPiNWj5tVQsOXCyWI=
X-Google-Smtp-Source: AAOMgpdJnj1WFv5LQFZA6NslsWz6CqwDN8FNY4czz4pnHzFSAMpKRxIdS1JcbGHZdzQaNmveQvQafOfIOMyWQ2nNmBE=
X-Received: by 2002:a37:2a65:: with SMTP id q98-v6mr14275439qkh.174.1532419938570;
 Tue, 24 Jul 2018 01:12:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 01:12:18
 -0700 (PDT)
In-Reply-To: <20180724002630.GV11258@linaro.org>
References: <20180724090545.2270d975@canb.auug.org.au> <20180724002630.GV11258@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 24 Jul 2018 10:12:18 +0200
X-Google-Sender-Auth: dnuCful06YdQLCsid-vYtjiv56Q
Message-ID: <CAK8P3a0bOYPtsCb8_etWtFCsnjB-xkMPFiy7iBubThi0b-LtVg@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the arm64 tree
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 2:26 AM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> On Tue, Jul 24, 2018 at 09:05:45AM +1000, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the arm64 tree, today's linux-next build (x86_64
>> allmodconfig) produced this warning:
>
> Where can I find this specific branch?
>
>> drivers/acpi/Kconfig:6:error: recursive dependency detected!
>> drivers/acpi/Kconfig:6:       symbol ACPI depends on EFI
>
> My patch created an additional dependency like:
>   menu ACPI
>     ...
>     depends on IA64 || X86 || (ARM64 && EFI)
>
>> arch/x86/Kconfig:1920:        symbol EFI depends on ACPI
>
> So I don't understand why this change makes a warning on x86_64 build.
> Is this a real recursive dependency?

On x86, we have

config EFI
        bool "EFI runtime service support"
        depends on ACPI

Kconfig cannot know that CONFIG_ARM64 is never set on x86, while
X86 is always set. So to Kconfig it it appears like a recursive
dependency.

The best workaround I can see is to have an intermediate symbol
on ARM64 that is invisible to Kconfig on x86, like

config ARCH_SUPPORTS_ACPI
        def_bool EFI

and then have ACPI depend on that.

       Arnd

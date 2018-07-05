Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D234C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34994241AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PiBt0rsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34994241AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbeGEGff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:35:35 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:59110 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753015AbeGEGfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:35:33 -0400
Received: from mail-ua0-f172.google.com (mail-ua0-f172.google.com [209.85.217.172]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w656ZPP7027510
        for <linux-kernel@vger.kernel.org>; Thu, 5 Jul 2018 15:35:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w656ZPP7027510
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530772526;
        bh=WtK52ishavkfmwWQcgsGOcZCCGDJynF5S1tG/oWFVKk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=PiBt0rsjnfRlaAW9yNKEjd98u7NybqCtO7AGKB4UWhPGYBMLthQfkv9AqZfYYBZqT
         EdTgOZwphMIeYVEGOcuEdiXVpPtOx+8CVDfSwfmqW9v2VFnPQ2MoEBo96bKePlVGXd
         q7Ep3Wqv0Ddv74/H3NWyNTw/YKq/Eb3Hr7M0N20pz8N+8Sr964BjuLqT6F3eZEScDs
         XgjCRApnVsrQB1eVlho4C0+2n/iYID0VadFo5LLuoEOohIoRhxDbF2ZUkDdKVWwUJs
         nko0ggjO7QwNesy5zYCf6NB6Jz+m4v1UvbH/9BjAtczO+cY5sMKTJ55/S8kCU4uT5T
         BzB7vifsmiFQg==
X-Nifty-SrcIP: [209.85.217.172]
Received: by mail-ua0-f172.google.com with SMTP id q12-v6so4746981ual.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 23:35:26 -0700 (PDT)
X-Gm-Message-State: APt69E0S34q+BMHvbHoS6/9ZJAtPGfDbY2zzje2rHJ0cDxAsq9ZMjE6j
        NtUSUaL7hKaaFrPYqnNspRc0hpBKnWKAj0C+/bg=
X-Google-Smtp-Source: AAOMgpdCVU0CGBCcJMRq2IoFaVMe7ftd0ilfG2+L/XaqnxJB2SHhstM5odDGsElAjCQGrUwp8VY3RlzHayuIjJ1tAPo=
X-Received: by 2002:ab0:e3:: with SMTP id 90-v6mr2601592uaj.52.1530772525323;
 Wed, 04 Jul 2018 23:35:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 23:34:44 -0700 (PDT)
In-Reply-To: <e9c2a4e820664c43a29d006153e5043c@SOC-EX01V.e01.socionext.com>
References: <eb82286e-cd9f-5847-0217-9387db5d6fe4@landley.net> <e9c2a4e820664c43a29d006153e5043c@SOC-EX01V.e01.socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 5 Jul 2018 15:34:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNATkH4AtDJ_zfPaarCOREuZjgLGbc6nOrWysTeMrmd3vcA@mail.gmail.com>
Message-ID: <CAK7LNATkH4AtDJ_zfPaarCOREuZjgLGbc6nOrWysTeMrmd3vcA@mail.gmail.com>
Subject: Re: [PATCH] Use short unix-style option instead of --longname.
To:     Rob Landley <rob@landley.net>, Jiri Kosina <trivial@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ulf Magnusson <ulfalizer@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-05 11:05 GMT+09:00  <yamada.masahiro@socionext.com>:
> Hi.
>
>> -----Original Message-----
>> From: Rob Landley [mailto:rob@landley.net]
>> Sent: Thursday, July 05, 2018 4:06 AM
>> To: trivial@kernel.org; Yamada, Masahiro/=E5=B1=B1=E7=94=B0 =E7=9C=9F=E5=
=BC=98
>> <yamada.masahiro@socionext.com>; Kees Cook <keescook@chromium.org>; Ulf
>> Magnusson <ulfalizer@gmail.com>
>> Subject: [PATCH] Use short unix-style option instead of --longname.
>>
>> From: Rob Landley <rob@landley.net>
>>
>> Use short unix-style option instead of --longname.
>
> This is the repeat of the subject.
> Instead, could you describe the reason of this patch here please?
>
>
>> Signed-off-by: Rob Landley <rob@landley.net>
>> ---
>>
>> Avoids warning messages with the latest release of toybox, which never
>> bothered
>> to implement the --longopts nothing was using.
>
> I am fine with this patch,
> but I want the information below the --- line
> to be recorded in git.
>
>
> I think WHY is the most important part in the commit log.
>
> If the commit log only mentions 'Use short unix-style option instead of -=
-longname'
> it is not easy to know why this commit is necessary.
>
>


Anyway, I am fine with the code diff.


Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>



>
>
>>  init/Kconfig |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/init/Kconfig b/init/Kconfig
>> index 041f3a0..192d400 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -2,9 +2,9 @@ config DEFCONFIG_LIST
>>       string
>>       depends on !UML
>>       option defconfig_list
>> -     default "/lib/modules/$(shell,uname --release)/.config"
>> +     default "/lib/modules/$(shell,uname -r)/.config"
>>       default "/etc/kernel-config"
>> -     default "/boot/config-$(shell,uname --release)"
>> +     default "/boot/config-$(shell,uname -r)"
>>       default ARCH_DEFCONFIG
>>       default "arch/$(ARCH)/defconfig"



--=20
Best Regards
Masahiro Yamada

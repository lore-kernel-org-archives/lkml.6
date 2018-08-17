Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A25AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A88214DC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jaGHK/ui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A88214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbeHQE5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 00:57:31 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:51404 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeHQE5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 00:57:31 -0400
Received: from mail-vk0-f51.google.com (mail-vk0-f51.google.com [209.85.213.51]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w7H1tsOE008867;
        Fri, 17 Aug 2018 10:55:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w7H1tsOE008867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534470955;
        bh=Aq8Fj3ayJpewlFTt5Nv6bRYesj2vG9TFB5go/PmIeS0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=jaGHK/ui7Mi5yrMlDouIeI+U1sakDPEQ2mWBTI5glbeymyNjslyBW36Zp2YMW+LU1
         9hKkU/9ITb5EU3b0SlH6FJ1Q5m702aTK123ygxNJ6JGwuJEq2ndXNJ8uDn5Niwhzmj
         myOzcDGEIUedqRV3RuEzhH8rVxg8i8gMoImfM/5El6rploG4IiqR3rODRlWlmPigTp
         mnhfjAJrrDwt7hx0drNeTg6aFlrrBfVIta5AwIWMlvgWcdE/LiTjm/jP58N5twSc0S
         Rrl5K+mh7VHqAVqq8excgGh1cE7Xd1f3bnd2eb7QDL4BvbCQAoQ/KincniOCAIFVi/
         6uPAkP9aCQsqA==
X-Nifty-SrcIP: [209.85.213.51]
Received: by mail-vk0-f51.google.com with SMTP id e139-v6so2432178vkf.6;
        Thu, 16 Aug 2018 18:55:55 -0700 (PDT)
X-Gm-Message-State: AOUpUlEztD4qBRyyo5op25BO7WzbOKzisvpWkDeaHU1JAEpVys1th7SL
        6tOozcPNsJZOryKqrcjM9oRKzXN+sA3Epxue708=
X-Google-Smtp-Source: AA+uWPwSkjzu+uuwBajMWEgBbBsH/s6fiIsm/R3MTdTHnqdSLYQ+wp7yCThV5QA047jSam4MNE4gdPZNiNKUriq0t3c=
X-Received: by 2002:a1f:3a95:: with SMTP id h143-v6mr21925364vka.42.1534470953729;
 Thu, 16 Aug 2018 18:55:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 18:55:13
 -0700 (PDT)
In-Reply-To: <a4139b9d-9842-a595-b273-1fce3eecf6a3@infradead.org>
References: <abba6b9a-597b-a3eb-6d91-8a7261492c78@infradead.org>
 <CAK7LNAQ3NnWvK=jJ5a-bpYuCGtpfYztu7qPpi4Gd+6jR_62eQQ@mail.gmail.com> <a4139b9d-9842-a595-b273-1fce3eecf6a3@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 17 Aug 2018 10:55:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNASb4+dvhWKaNgn66+9RiJEosAbv2f_d7RsD48Tt9_LziQ@mail.gmail.com>
Message-ID: <CAK7LNASb4+dvhWKaNgn66+9RiJEosAbv2f_d7RsD48Tt9_LziQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: add build-only configurator targets
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-17 1:30 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> On 08/15/2018 08:27 PM, Masahiro Yamada wrote:
>> 2018-08-15 9:36 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>
>>> Add build-only targets for build_menuconfig, build_nconfig,
>>> build_xconfig, and build_gconfig.
>>> (targets must end in "config" to qualify in top-level Makefile)
>>>
>>> This allows these target to be built without execution (e.g., to
>>> look for errors or warnings) and/or to be built and checked by sparse.
>>>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> ---


Applied to linux-kbuild. Thanks!

>>>  scripts/kconfig/Makefile |    8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> --- linux-next-20180814.orig/scripts/kconfig/Makefile
>>> +++ linux-next-20180814/scripts/kconfig/Makefile
>>> @@ -33,6 +33,14 @@ config: $(obj)/conf
>>>  nconfig: $(obj)/nconf
>>>         $< $(silent) $(Kconfig)
>>>
>>> +build_menuconfig: $(obj)/mconf
>>> +
>>> +build_nconfig: $(obj)/nconf
>>> +
>>> +build_gconfig: $(obj)/gconf
>>> +
>>> +build_xconfig: $(obj)/qconf
>>> +
>>>  localyesconfig localmodconfig: $(obj)/conf
>>>         $(Q)perl $(srctree)/$(src)/streamline_config.pl --$@ $(srctree) $(Kconfig) > .tmp.config
>>>         $(Q)if [ -f .config ]; then                                     \
>>>
>>
>>
>> OK, seems useful,
>> but these should be phony targets.
>>
>> May I squash the following change?
>>
>
> Of course.  Thanks.
>
>>
>> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
>> index c0ca9ea..f7bdcc9 100644
>> --- a/scripts/kconfig/Makefile
>> +++ b/scripts/kconfig/Makefile
>> @@ -3,7 +3,8 @@
>>  # Kernel configuration targets
>>  # These targets are used from top-level makefile
>>
>> -PHONY += xconfig gconfig menuconfig config localmodconfig localyesconfig
>> +PHONY += xconfig gconfig menuconfig config localmodconfig localyesconfig \
>> +       build_menuconfig build_nconfig build_gconfig build_xconfig
>>
>>  ifdef KBUILD_KCONFIG
>>  Kconfig := $(KBUILD_KCONFIG)
>
>
> --
> ~Randy



-- 
Best Regards
Masahiro Yamada

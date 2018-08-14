Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C606CC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363A321733
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lO5smvOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363A321733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbeHNMSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:18:36 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:17592 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbeHNMSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:18:36 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w7E9VkjP010554
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 18:31:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w7E9VkjP010554
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534239107;
        bh=E2C9GYJyw7K8DuYgWH73Q2Qsg1np22Qc5a6iNxZ+t6Q=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=lO5smvOXNdYfo25L6lOeePcpMZnXJd8PTgBCOQrjXjLEaN1aB6hBRWU9NHlTXPpx0
         xKjiiN6+b0hf46Q4LC/38l0y2Phd/NfI7Hb6yjz11cHUlQfeQA//6JilqvbBlddrZW
         84eiNaYyVNMZZP2xj1J12AIvxdwOaQX2HNi7jmiqB7/GBRE3lmCIriYsrVI7y18eZ5
         T1MTC+K9gpwqb70PRDHckbMx/MyFtNB6B3ByQ76nYs5zufblRhToMrHvAXn/b2hIxb
         loq0F53R73QszhXY4hY2ID/MbvlAaAaWaC8uiTMq6lAItL45wVWT//ZCpzs+qzP1fw
         1A5aOf1J8jesg==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id g18-v6so12371688uam.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 02:31:46 -0700 (PDT)
X-Gm-Message-State: AOUpUlGKUFV4Vsaq/dCCWehFVB5svmRlpT4sMZpmJSDYUfHlwb/aX/ef
        TpCPyakyMFxU+EY/V54VGJhWSYO86KXW1yG1Ijc=
X-Google-Smtp-Source: AA+uWPxuWpneqklwRF5E7aoJB89+lWqh4NJvRHr8LgY1g5SW0U+vkkoNbYjmDuq10W4dtQwqNqv20tZRHEO4Ham2CV8=
X-Received: by 2002:a1f:3a95:: with SMTP id h143-v6mr13540128vka.42.1534239105595;
 Tue, 14 Aug 2018 02:31:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 02:31:05
 -0700 (PDT)
In-Reply-To: <1534233405.3547.4.camel@sipsolutions.net>
References: <20180813220950.194841-1-arnd@arndb.de> <CAK7LNASVE-vZhGyAsWg8YmPb8P-sucwPVOUt5qsfVwZQuHg9gw@mail.gmail.com>
 <1534233405.3547.4.camel@sipsolutions.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 14 Aug 2018 18:31:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNARpRcF1b_Zx+vQAXcCyadcgFUzzQjfgJ4eCcBqWmUukVQ@mail.gmail.com>
Message-ID: <CAK7LNARpRcF1b_Zx+vQAXcCyadcgFUzzQjfgJ4eCcBqWmUukVQ@mail.gmail.com>
Subject: Re: [PATCH] bitfield: avoid gcc-8 -Wint-in-bool-context warning
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-14 16:56 GMT+09:00 Johannes Berg <johannes@sipsolutions.net>:
> On Tue, 2018-08-14 at 08:57 +0900, Masahiro Yamada wrote:
>> 2018-08-14 7:09 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>> > Passing an enum into FIELD_GET() produces a long but harmless warning on
>> > newer compilers:
>> >
>> >                  from include/linux/linkage.h:7,
>> >                  from include/linux/kernel.h:7,
>> >                  from include/linux/skbuff.h:17,
>> >                  from include/linux/if_ether.h:23,
>> >                  from include/linux/etherdevice.h:25,
>> >                  from drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:63:
>> > drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c: In function 'iwl_mvm_rx_mpdu_mq':
>> > include/linux/bitfield.h:56:20: error: enum constant in boolean context [-Werror=int-in-bool-context]
>> >    BUILD_BUG_ON_MSG(!(_mask), _pfx "mask is zero"); \
>> >                     ^
>> > ...
>> > include/linux/bitfield.h:103:3: note: in expansion of macro '__BF_FIELD_CHECK'
>> >    __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: "); \
>> >    ^~~~~~~~~~~~~~~~
>> > drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1025:21: note: in expansion of macro 'FIELD_GET'
>> >     le16_encode_bits(FIELD_GET(IWL_RX_HE_PHY_SIBG_SYM_OR_USER_NUM_MASK,
>>
>>
>> How about fixing the root cause
>> in drivers/net/wireless/intel/iwlwifi/fw/api/rx.h ?
>>
>>
>> #define IWL_RX_HE_PHY_SIBG_SYM_OR_USER_NUM_MASK   0x1e00000000ULL
>>
>>
>> enum iwl_rx_he_phy looks really strange.
>
> Why? I don't think this is a problem, the enum is used here to get
> constants so that we can also have documentation for them. That's a
> common and accepted technique.


I do not see any variable declared as 'enum iwl_rx_he_phy'.

This is not legitimate usage of enum.


The mask macros must have a particular value,
hence

#define IWL_RX_HE_PHY_SIBG_SYM_OR_USER_NUM_MASK   0x1e00000000ULL

is a straightforward way.


>
>> Passing enum to FIELD_GET is odd,
>> so I prefer keeping this warned.
>
> What for?


If you pass enum to FIELD_GET,
it is very like to be _abuse_ of enum.




> I think we should go with Arend's patch, and I hope Andrew will pick it
> up, but otherwise I guess we can also put it through any other tree.
>
> johannes



-- 
Best Regards
Masahiro Yamada

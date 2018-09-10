Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E93BC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2616A204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PjiVXpco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2616A204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeIJHPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:15:50 -0400
Received: from condef-05.nifty.com ([202.248.20.70]:30428 "EHLO
        condef-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeIJHPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:15:49 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Sep 2018 03:15:47 EDT
Received: from conssluserg-01.nifty.com ([10.126.8.80])by condef-05.nifty.com with ESMTP id w8A1MhDD012837;
        Mon, 10 Sep 2018 10:22:43 +0900
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w8A1MNuB015036;
        Mon, 10 Sep 2018 10:22:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w8A1MNuB015036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536542544;
        bh=vcBNZMjqeXYNvcFuq4WI6tvwMsZLpSuzVBjtFRwU22g=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=PjiVXpco51aPoeJYx1NdVQc7zdkSnmudOMjTTfScg6Qsm1J9vT2ycaTJKRax/fJ7X
         w+Ll8MZKsKjFGscx0JsI1qhrx5PMwpRFw1MpjyneFRoehpFoLGXQHOQtKux9aJ4rl+
         criabO+/Y3rCEKpgZkECn+M8GVfbJ6pEl62iNyaPzJ/mkb5pO+fSXPvk5EcYG4qzwK
         Z+IRSDinbwJkfmEcj1Sn9/+jeYmeaQVFUE5jF8N6spChL1HEi/BOrsGPJTEJQjQolD
         ZCB6oED6kO1T0Lsd6YNWgZs3CociPkdGDEdUtuexMjqNT+1fDHXL+t6hXVso9hXM9S
         UYk9TbMg7iB9g==
X-Nifty-SrcIP: [209.85.221.171]
Received: by mail-vk1-f171.google.com with SMTP id l143-v6so2758480vke.1;
        Sun, 09 Sep 2018 18:22:24 -0700 (PDT)
X-Gm-Message-State: APzg51CjuPnC7EFF3EPQLkeQDn4r/4E4e1gET8c+uq8DakBbvTFCiUdU
        3TCop5e8nOifJRTruMpBbgyBCZTXZP7m2NrCTrU=
X-Google-Smtp-Source: ANB0VdbvtL9LE2gzwWitwphDcj9/llWmEZYGoIeWoDlOzJg60iBqKlmj8RUhPSfIPu/41SACQTX1DpbYLjNamwxST0E=
X-Received: by 2002:a1f:9004:: with SMTP id s4-v6mr5719595vkd.10.1536542543316;
 Sun, 09 Sep 2018 18:22:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Sun, 9 Sep 2018 18:21:42 -0700 (PDT)
In-Reply-To: <20180909191903.GA2344@ravnborg.org>
References: <1536516257-30871-1-git-send-email-s.mesoraca16@gmail.com> <20180909191903.GA2344@ravnborg.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 10 Sep 2018 10:21:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNATP_3K0KYyW51K3mqHs-WiReJWMeB82Uxikh+zUqDKQ6A@mail.gmail.com>
Message-ID: <CAK7LNATP_3K0KYyW51K3mqHs-WiReJWMeB82Uxikh+zUqDKQ6A@mail.gmail.com>
Subject: Re: [PATCH v2] kconfig: add hardened defconfig helpers
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-10 4:19 GMT+09:00 Sam Ravnborg <sam@ravnborg.org>:
> Hi Salvatore.
>
> On Sun, Sep 09, 2018 at 08:04:17PM +0200, Salvatore Mesoraca wrote:
>> Adds 4 new defconfig helpers (hardenedlowconfig, hardenedmediumconfig,
>> hardenedhighconfig, hardenedextremeconfig) to enable various hardening
>> features.
>> The list of config options to enable is based on KSPP's Recommended
>> Settings and on kconfig-hardened-check, with some modifications.
>> These options are divided into 4 levels (low, medium, high, extreme)
>> based on their negative side effects, not on their usefulness.
>> 'Low' level collects all those protections that have (almost) no
>> negative side effects.
>> 'Extreme' level collects those protections that may have so many
>> negative side effects that most people wouldn't want to enable them.
>> Every feature in each level is briefly documented in
>> Documentation/security/hardenedconfig.rst, this file also contain a
>> better explanation of what every level means.
>> To prevent this file from drifting from what the various defconfigs
>> actually do, it is used to dynamically generate the config fragments.
>
> In the above you nicely describes what is done.
> But there is nothing about the target group for this feature.
> Who will benefit from this?
>
> With respect to the actual implmentation we now
> have two ways to handle config fragments.
> Current solution is to save the config fragments in kernel/configs.
> And the new solution is to parse the config fragments from an rst file.
> The changelog fails to mentions why we need a new way to handle
> the config fragments.


I agree.

Another new way this patch added is,

 CONFIG options are now described in the ReST document,
 but our current way is to describe the detailed information
 in the 'help' section in Kconfig files.






> If we want to go the "parse from rst file" way - can it then
> be abstracted in a way so this is the only way to handle
> these in-kernel config fragments?
> And then move the current config fragment to the new way.
>
> It most be possible with a little careful design to make this
> a general solution and not a hardening thing only.
>
>         Sam


Indeed.  The file format is too specific for his purpose;
'Negative side effect level' is a key word
that must be placed 3 lines below the CONFIG entry.


-- 
Best Regards
Masahiro Yamada

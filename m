Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F53EC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 03:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52FD26876
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 03:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vvc7JKW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52FD26876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932164AbeF0Dw3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 23:52:29 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:27561 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932084AbeF0Dw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 23:52:28 -0400
Received: from mail-ua0-f170.google.com (mail-ua0-f170.google.com [209.85.217.170]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w5R3qOQC002271
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:52:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w5R3qOQC002271
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530071545;
        bh=+xbRgf4lyl15hVb1V53ueUm0d8RXJYXC5QqNADoz+lo=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=vvc7JKW+h/6hNcdlavhvcJco5LD51DG+ftVvN91UWqQXZNWa0gpdvEEaCw+2Qgica
         mcTlqHkKr2zAR8QTj77fEAEjH2LAiUrxuZ9MN5nhSDVnhJfPIEx3q15istRi43S4SB
         wPfePyknRDrZz1sV92MHOhT3uXk66Y5zV8W6JgOzVhLL/c5p4fcBd6CKaY5h0Gu7xX
         DiFkpfEnKc6lbLfvJVOFQJ8qE8hW0/s4aKslzp04CGTHWk0KQvZLToIIRD5hk9K7ex
         kpqXqwsQDID55g3Grvcpg36+a+8SXyc7O7PnIYQaplkVtJQYjUFv21DFccSx2RlE6r
         O2y+2wzatklNA==
X-Nifty-SrcIP: [209.85.217.170]
Received: by mail-ua0-f170.google.com with SMTP id g6-v6so385234uam.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 20:52:25 -0700 (PDT)
X-Gm-Message-State: APt69E31VqrYiOfPZmYRk0RjVdeq266zwtaa8lgfWSRzaTvaq2937dgq
        V0M0bdYcVhpa+bKorqKIo+UgHEseOwzD2TURYAs=
X-Google-Smtp-Source: AAOMgpcbqOpRwrdkcKjPXtnUawmYWDmoZCMvhFU2cwr22xY4l06SNqmMaRacfE7IpnkdXjJuosj7LfwysEStqesO0aA=
X-Received: by 2002:ab0:15ad:: with SMTP id i42-v6mr2649722uae.199.1530071544444;
 Tue, 26 Jun 2018 20:52:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 20:51:43
 -0700 (PDT)
In-Reply-To: <20180626174215.spnsyfqh5wk4tzep@localhost>
References: <CAK7LNARAMcUgV2K1_dDdkupaWdtLqGMz==+huurHJKyW=JVWxQ@mail.gmail.com>
 <20180626174215.spnsyfqh5wk4tzep@localhost>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 27 Jun 2018 12:51:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNATHQMSNV0HoHNm-Lnha3oz7z5fd=iUPcufC0L-AuK9BZg@mail.gmail.com>
Message-ID: <CAK7LNATHQMSNV0HoHNm-Lnha3oz7z5fd=iUPcufC0L-AuK9BZg@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: uniphier: fixes for v4.18
To:     Olof Johansson <olof@lixom.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm-soc <arm@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

2018-06-27 2:42 GMT+09:00 Olof Johansson <olof@lixom.net>:
> Hi,
>
> On Mon, Jun 25, 2018 at 11:13:04PM +0900, Masahiro Yamada wrote:
>> Hi Arnd, Olof,
>>
>> Please pull some fixes of ARM UniPhier platform.
>>
>>
>>
>> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>>
>>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
>> tags/uniphier-fixes-v4.18
>>
>> for you to fetch changes up to 4e62893c25bd3d5758058e15958364df3ca15fbc:
>>
>>   arm64: uniphier: select RESET_CONTROLLER (2018-06-25 23:00:31 +0900)
>>
>> ----------------------------------------------------------------
>> UniPhier ARM SoC fixes for v4.18
>>
>>  - add missing cooling device properties for CPUS
>>  - fix widget name of headphone
>>  - select RESET_CONTROLLER
>
> It's unclear to me what the severity of these fixes are. and I think the
> headphone widget name is the only bug that's causing problems for someone using
> this kernel, is that correct?

Right.
The others are on the boundary.
The criteria on those is different by maintainers
because some pull and some do not.


> If so, it would also be useful to get a "Fixes:" tag for it, seems like it
> should be:
>
> Fixes: fb21a0acaa2b7 ("arm64: dts: uniphier: add sound node")
> Care to resubmit with just the bugfix? Or, if it's easier, I can cherry-pick
> just that fix at this end and add the Fixes line. You should queue the other
> patches up for 4.19 and include in those pull requests.

If you care to cherry-pick with Fixes: tag,
that would be good.

Thanks.

>
> Thanks,
>
> -Olof



-- 
Best Regards
Masahiro Yamada

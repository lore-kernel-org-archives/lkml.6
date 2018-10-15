Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F50BC070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 03:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6F920842
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 03:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xXLAZvQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6F920842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbeJOK4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 06:56:32 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:20881 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbeJOK4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 06:56:32 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w9F3D6Z8018288;
        Mon, 15 Oct 2018 12:13:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w9F3D6Z8018288
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539573187;
        bh=rzTyOOswE74hzE0dC3h4YygbYNFTExlOYO8toOvmzS8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xXLAZvQoeAjWX9SVhlD2JgQOcq/2UeD2o8F0iA1+Pq4Bo9fGKQzIfXxzgv7CfA8Iv
         4dFTXjDVLTgnyAWfi0pwyEhKiUujwCDhZVAfaNQbCTZUVYoj9dI3aof/rwK30aZEbY
         N0esm6OlE/NViMsA350OAGpv2BRvPI7fn6t3YepSyqM4/1sjgUQanKzzoXqo+EIHlu
         tHs6/woLmeXtf2SwMiMt2bxONHuqS3GkJ4yUc4MqS7EB6EbVGJhTrLjZ7K71du4N35
         MoKax1AmSOtoiVQPFFmbEoS5QdEEaBMos9g8aFyL9lXImTfNyPEz7AzMkebuHwPrrv
         HCo0qG6svaPwA==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id m5so15410534vsk.6;
        Sun, 14 Oct 2018 20:13:06 -0700 (PDT)
X-Gm-Message-State: ABuFfoiDidNL4AA0Lz6mIqRXyfZ0sxjSFQGBpO8FuW0uv17NgouHOVnm
        bFFtFuFt6p63HRaL4hDX0qajMp7gUUlSINmthas=
X-Google-Smtp-Source: ACcGV61VWlxWZphzp51bRXUKRLNzM61L4tOVKBZnU49QZ24+x7k/q4tNCU/m/yA3X/W6sI8AY77wktj5Xlv4FtaccLc=
X-Received: by 2002:a67:3793:: with SMTP id j19mr5876916vsi.215.1539573185701;
 Sun, 14 Oct 2018 20:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com> <20181014223311.GE3260@kunai>
In-Reply-To: <20181014223311.GE3260@kunai>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 15 Oct 2018 12:12:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNATPf4mEdH16eZzLg4x3tP-jvXcTWqqY0DgCpmGjt9x9zg@mail.gmail.com>
Message-ID: <CAK7LNATPf4mEdH16eZzLg4x3tP-jvXcTWqqY0DgCpmGjt9x9zg@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: uniphier-sd: two bug-fixes
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 7:33 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
>
> > In further testing in uniphier-sd.c,
> > I found my stupid mistakes.
>
> I don't have the uniphier HW but I still had a look at these patches.
> You never know if there is something interesting for SDHI in there :)
>
> > Can you squash this series into
> > 3fd784f745dd
> > "mmc: uniphier-sd: add UniPhier SD/eMMC controller driver"
> > if you have a chance to do rebase?
>
> Please don't rebase!

Some sub-systems rebase, and some do not.
It is up to the sub-system maintainer.

I am not asking to rebase just for my two fixes.
I see linux-mmc regularly rebase anyway.

I'd prefer cleaner git history
if Ulf just happens to do one more rebase in this cycle.




> We actually develop on top of mmc/next and rebasing
> creates a lot of pain because we lose the base for that work.

I know what you are saying, but this is how we develop in linux-next.
You need to use "git rebase --onto".




--
Best Regards
Masahiro Yamada

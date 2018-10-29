Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82773C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3576420870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="vvwwfYqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3576420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeJ2XX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:23:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43439 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbeJ2XX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:23:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id g26-v6so6749655lja.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 07:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=50tCzGk33QavNAHVa5pq5xu3HWPefUFY96UsN7rzfmM=;
        b=vvwwfYqaBtANbLybUClVlSpmxv+NOkvZodAZzMOpnVHA8RsZ5UZPYJIcZ93HptxUjI
         uZ0BtPh2dlzjTUIcnlhdNG8PVcmCy0rYctsILuVuAnDfdlFzpkqIRfEB4Qtqqs6VhlgU
         Hp/ArvgPbR/4oTnyfyPLmv/o29m7JLJhcnX7RYGB+/uHLt9oxZDnOS0qud4kI3XSXp0k
         wz2wZZwVAv5MazHnY1sdPjnpaeOsBdmUhWsG+/RIgMoS0v8RabbkKWJvHW1VusQs0xeA
         9dWmvnqQPE47F9QFQIxw83iBTANRiB58V0S7kze44iTCSd6xOrzQO0n25DqZC8kyE58c
         2AFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=50tCzGk33QavNAHVa5pq5xu3HWPefUFY96UsN7rzfmM=;
        b=gW4k6uZSZUl2GmwhILnjJFjRWdH/kOZNNYK9m+E9XM7t62i4lH7xLoRi5BSAHPOdBh
         ZMohPLljQ5BHx5Gyr0YM4KR6SH1H0U3TK3HcZ6zlKMzNNTADLbQHmwNe/FSj0/efmp0U
         6KIGYUC3Wqs/nw5dsr1nLzzDjHlyifwRQzC/3b4mIH+6sOzMJ6V+aPOdpJ8jk2z7hIKy
         A/iRAPHfTNTflaf6j20ba1xebHVvD8Civ0pUkNKwgwLrMyg8O3DZWPFSHpdnui0h57Rk
         4ZpqkTGCqVuW5ETZucLBkGoMNznrgGwMtth0zKXKgjtB2kH53tAQCoRcnrRq5XJj9wau
         fVmg==
X-Gm-Message-State: AGRZ1gIvntFYpdxLmsqBWEVy31+wZs/95EiVaTGR7lXudArhT5CqP7tI
        HuP/Y6VF39Td/GwRCTlz/Qyl0e0qAA7+x2iiVme+3g==
X-Google-Smtp-Source: AJdET5fP6tgt2HZvp6m8TdkcO2w3uBAzRLWu0cJnQVVK8SOiFKqW0v82sO84dWdGi5X++IhWW2xcEuFmec8aeSHPdGg=
X-Received: by 2002:a2e:8eca:: with SMTP id e10-v6mr6439019ljl.109.1540823699845;
 Mon, 29 Oct 2018 07:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_JsqJKkPiHBbJWMF5=JzxZyO+UTN0qLFLnjvd9txkUQPdznw@mail.gmail.com>
 <CAOesGMh=iJ-LE25ooVmoSVD7Rw9AzrJhXbP2X4+OeeUwmV5HnQ@mail.gmail.com> <CAL_JsqLgbGDHPFp2kW2tRT3iQwV9dU+NRVB4YzoS-7p+9GZHnQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLgbGDHPFp2kW2tRT3iQwV9dU+NRVB4YzoS-7p+9GZHnQ@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 29 Oct 2018 07:34:47 -0700
Message-ID: <CAOesGMhViNYNh_mgHG6ew8ovUzByhZNwtY4vW8WroZS_RzUydA@mail.gmail.com>
Subject: Re: [GIT PULL] Devicetree updates for 4.20
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 5:44 AM Rob Herring <robherring2@gmail.com> wrote:
>
> On Mon, Oct 29, 2018 at 12:25 AM Olof Johansson <olof@lixom.net> wrote:
> >
> > Hi Rob,
> >
> > On Fri, Oct 26, 2018 at 9:07 AM Rob Herring <robherring2@gmail.com> wrote:
> > >
> > > Linus,
> > >
> > > Please pull DT updates for 4.20. A bit bigger than normal as I've been
> > > busy this cycle. There's a few things with dependencies and a few
> > > things subsystem maintainers didn't pick up, so I'm taking them thru
> > > my tree. The fixes from Johan didn't get into linux-next, but they've
> > > been waiting for some time now and they are what's left of what
> > > subsystem maintainers didn't pick up. There's no conflicts yet with
> > > your tree, but there are 2 conflicts I'm aware of. One is with the c6x
> > > tree and the other is in drivers/soc/qcom/apr.c. The correct
> > > resolutions are in linux-next.
> > >
> > [...]
> >
> > >       scripts/dtc: Update to upstream version v1.4.7-14-gc86da84d30e4
> >
> > This update made dtc spit out a large number of warnings on a regular
> > build, due to a new requirement that a SPI node is named "spi". Seems
> > like an arbitrary restriction, but either way can the warning please
> > be disabled by default until them cleaned up so we don't have a bunch
> > of noise in the logs?
>
> All the fixes are sitting in your tree. :)

Well, that clearly explains why I didn't see them with -next. I
thought I had missed it due to the builder being down for a while.
Thanks!


-Olof

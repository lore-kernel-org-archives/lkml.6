Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA5AECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C40620878
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYxIxTYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C40620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeGMKaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:30:12 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41036 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeGMKaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:30:12 -0400
Received: by mail-lf0-f66.google.com with SMTP id v22-v6so13256523lfe.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 03:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/XTGfPjQDAXCunLQCBDX36fWOI/BGQHfNkW6CjNlUpk=;
        b=uYxIxTYvP76PdSJ1JVgTSN+ieH6D2eZmpF8Jz7+4G2t+s0sBGKXiIwU0FntBZe8r6d
         MaYzpFcx2V/oWQWErmFD36/Pa7H5apfZNoozT+rcAlwknKYM1xEaPP5bIMyxDIMmZ4tT
         2pxKZN6oShk/SC8/JKZ1YlpHk7TqmYWqWa4HXFKB0TktP1UfzDyR73zzmzsYy2toLhZ2
         DnpclKnRPwzqbLGn8XWNHNHDdOfJvYF17NuIJfjGI8IlixpjnUf5zNrwSd+0whUYe2kZ
         fkPxOJoGZpglg1k5uWt31+7hxUxpf89nfGYzAgJJCX7Wk9y0nOyVMCGhqBcNikUD8XYL
         wt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/XTGfPjQDAXCunLQCBDX36fWOI/BGQHfNkW6CjNlUpk=;
        b=axCFfZ9XLthHb+whF0epe3J6z5dJ802Dmz7eN06GWFsK0vkg5M79VUJEP/2vuxdavf
         0IRVVUhPXUkCCid0NkE1ditWp4+oqhHpiuGIYq6cbE1irY6hlwZOXtCgSnSWs9vOU4EP
         Jubv7wmVXtlh+KYYdWGlj+sQ6IvaHWg9N+3nNXvssqIsRcb0Ytg3yH3e3Q9jZh/DzUOF
         RwHnV+maTLVI8d9RUB3bSOVCJ6G+J+6X1EpF4ZMiwKjviXlhnTTmxP4zKwXy6diaeY5h
         HLOMsadWyr7DZrZ0iX1PawYXkAFA8ZG7MJrf7kTfHh21W4Z7omxcxDeSAUJnZWq+QgRP
         MZqg==
X-Gm-Message-State: AOUpUlHSfPyiq6VOK0FTLJIoGWrQRCSS/ipXo+9hdVprIzVvo/AP3/fI
        SsPX2b4UvlGIkdy1nAfpcIlqV3k0R91zgPFjae8=
X-Google-Smtp-Source: AAOMgpd9gom4XChnAC1VqX7tG5zIarUXwSUqFtXLfpGUturYGTEEbZlCV12+Yq9E8qW+opdhgnX46ZVlJoZHvJOZCA8=
X-Received: by 2002:a19:ea5c:: with SMTP id i89-v6mr4448111lfh.19.1531476969906;
 Fri, 13 Jul 2018 03:16:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 03:16:09
 -0700 (PDT)
In-Reply-To: <0b4ee469-8c37-9002-9067-f37f8dde869e@microchip.com>
References: <20180709155730.2422841-1-arnd@arndb.de> <20180709155730.2422841-2-arnd@arndb.de>
 <0b4ee469-8c37-9002-9067-f37f8dde869e@microchip.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 Jul 2018 12:16:09 +0200
X-Google-Sender-Auth: 1h9o-dyJyOy65agmQdJjSHV3eT4
Message-ID: <CAK8P3a3NbrRVC-7HW8NiNQw+E3n_-r746AFTc2dftagTYLYDtw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mtd: atmel nand: fix build warning on 64-bit
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Richard Weinberger <richard@nod.at>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Josh Wu <rainyfeeling@outlook.com>,
        Romain Izard <romain.izard.pro@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Peter Rosin <peda@axentia.se>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 11:56 AM, Tudor Ambarus
<tudor.ambarus@microchip.com> wrote:
> Hi, Arnd,
>
> On 07/09/2018 06:57 PM, Arnd Bergmann wrote:
>> +     nc->ebi_csa_offs = (uintptr_t)match->data;
>
> I guess we should declare ebi_csa_offs as size_t, right?

Yes, that would make sense, though it doesn't change the behavior.

      Arnd

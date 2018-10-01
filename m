Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C752C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65492089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65492089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbeJATKH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:10:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55634 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729444AbeJATKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:10:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DCCB2207EB; Mon,  1 Oct 2018 14:32:28 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9AA4820AB9;
        Mon,  1 Oct 2018 14:32:18 +0200 (CEST)
Date:   Mon, 1 Oct 2018 14:32:19 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/8] mtd: maps: gpio-addr-flash: Replace array with
 an integer
Message-ID: <20181001143219.59423ad3@bbrezillon>
In-Reply-To: <CAPybu_18jdEWEbAbYd4k-GPD+77sCA_5na0RJznixPEXkcs+kQ@mail.gmail.com>
References: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
        <20180905143643.9871-6-ricardo.ribalda@gmail.com>
        <20180927134216.1952f668@bbrezillon>
        <CAPybu_18jdEWEbAbYd4k-GPD+77sCA_5na0RJznixPEXkcs+kQ@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2018 14:10:03 +0200
Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:

> > > +             return;
> > > +
> > > +     for (i = 0; i < state->gpio_count; i++) {
> > > +             if ((ofs & BIT(i)) == (state->gpio_values & BIT(i)))  
> >
> > Parens around the xx & BIT(i) operations are unneeded.  
> 
> If I remove it:
> 
> 
> ricardo@neopili:~/curro/kernel-upstream$ make drivers/mtd/maps/gpio-addr-flash.o
>   CALL    scripts/checksyscalls.sh
>   DESCEND  objtool
>   CC      drivers/mtd/maps/gpio-addr-flash.o
> drivers/mtd/maps/gpio-addr-flash.c: In function ‘gf_set_gpios’:
> drivers/mtd/maps/gpio-addr-flash.c:70:20: warning: suggest parentheses
> around comparison in operand of ‘&’ [-Wparentheses]
>    if (ofs & BIT(i) == (state->gpio_values & BIT(i)))

Hm, okay. I remember having a similar discussion on one of my patch and
people suggesting to drop it because of the == precedence on x & a.
Anyway, let's just keep it like that.

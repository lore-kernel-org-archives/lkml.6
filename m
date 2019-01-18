Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA4DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 06:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2402086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 06:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dpODoQra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfARGWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 01:22:53 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:19243 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfARGWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 01:22:53 -0500
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x0I6MaT6015228;
        Fri, 18 Jan 2019 15:22:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x0I6MaT6015228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547792557;
        bh=QK0uZ64YK14cCtWnVuSCI9akqYw9PJxLdNs+A9HvrDM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dpODoQrakdXpeBOA9vNE3Z+kPnBGOqZ/vHrPqpNQRfnxYKdOKphLREOK53o4ap+Dj
         Em9kbyOMe4MyNc6p6Gh6uzBbiY+lvnuf6aXBUMv4yJBcNpXjSNf176mxKqhIBwlRyD
         bokbVCCAgqCJsn8nXFvynHrcukdwCcRcKSh3kr6/W6QFvZ1bnjnZd8HpnrKbll6hiF
         6ff3CjZypGhkG2xOuUrARshe9Nszkj8/WyXbqvnNs1HgWr5ej+6pTakqYbgPqgcdOc
         AjVONO8Ykph23QJTWCRNo4yeMQubdQwmlakAMtHeoS854RkNLAuKjgkXe+MN1iEVcB
         xQMo7vY1WN3lw==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id n13so7813573vsk.4;
        Thu, 17 Jan 2019 22:22:36 -0800 (PST)
X-Gm-Message-State: AJcUukczhylxefaXnCjLF6Y5M0TMA8v3YD7c9CVIa/NQ6CkijtxkAVRf
        SvKyZaLN5I3L80DOXmjnRJtedlRDQczmATGFIFs=
X-Google-Smtp-Source: ALg8bN5RfcLfyfu4eFITK3YR8PY6iatuYhDILA1w9J5OgghGPUHknkfgV8bhpMwRgCrw1Bw+TkkMIsCV9s5JXajHYks=
X-Received: by 2002:a67:a858:: with SMTP id r85mr6812974vse.215.1547792555738;
 Thu, 17 Jan 2019 22:22:35 -0800 (PST)
MIME-Version: 1.0
References: <1547789438-11899-1-git-send-email-yamada.masahiro@socionext.com> <20190118071919.5c4015f6@bbrezillon>
In-Reply-To: <20190118071919.5c4015f6@bbrezillon>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 18 Jan 2019 15:21:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNASaXXO6nJemH5p+zE+xEXDN-QzajK=-KyfRB_+FBOd7ig@mail.gmail.com>
Message-ID: <CAK7LNASaXXO6nJemH5p+zE+xEXDN-QzajK=-KyfRB_+FBOd7ig@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: denali: get ->setup_data_interface()
 working again
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-stable # v4 . 20" <stable@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 3:19 PM Boris Brezillon <bbrezillon@kernel.org> wrote:
>
> On Fri, 18 Jan 2019 14:30:38 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
> > Commit 7a08dbaedd36 ("mtd: rawnand: Move ->setup_data_interface() to
> > nand_controller_ops") missed to invert the if-conditonal for denali.
> > Since then, the Denali NAND driver cannnot invoke setup_data_interface.
> >
> > Fixes: 7a08dbaedd36 ("mtd: rawnand: Move ->setup_data_interface() to nand_controller_ops")
> > Cc: linux-stable <stable@vger.kernel.org> # v4.20
>
> Commit 7a08dbaedd36 was merged in 5.0, I'll drop Cc stable when
> applying.


Ah, right. Thanks.




-- 
Best Regards
Masahiro Yamada

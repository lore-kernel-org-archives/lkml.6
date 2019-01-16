Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B190C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 01:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D8B2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 01:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Dr5nBvRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfAPB2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 20:28:04 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:29949 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbfAPB2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 20:28:04 -0500
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x0G1Rlg2003935
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 10:27:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x0G1Rlg2003935
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547602068;
        bh=9oey97/1ZpKBcnZnZ7Hx4IBSLCWMSSjGasy+/zVPy40=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dr5nBvRJ8YDatBWK2e/42u2yhr/lRzW5hk3vhJdGYu6eqAsTnkkbiP21V8rWl/dAu
         8gfgA0RF/0lIdobp9afqlgZ08SzaD7y+N3JdUl7P8vCe6ZtJbpxB0C5jf9JdW8Q1I+
         xCLqEn7T2h0StJN3cXy2U12BfD5WyH4QDKSdOJHLbMhHPxpRvngtYe1YQWgBclIW/M
         NnXbUiFPFK+KcdjgXzCLFtA0TQecQB1HMS/8abEM8Y538dmAwSP/M9+5seJZkcQFoB
         ZZw81ZYfbPuEhJltsoNGXnYl2BANaO1pu6aRT9ySTveX1nj1MRCjtB0QBgWxsz6Vry
         bWdwZtBNgGvIA==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id n13so2932598vsk.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 17:27:48 -0800 (PST)
X-Gm-Message-State: AJcUukerDjwDo5Db9qH0Oc159fiT1Kl1DDeJxQTkFVLLdqo0OOeNxsGs
        A98jITf8f4gJX2RI5zeZ2DwU4PXJOkqD7dZyc5U=
X-Google-Smtp-Source: ALg8bN7tXLpLuArrNhwLu0tMeiXfJsrcIM6BzmwlR1QwebVJ7DqgRTkGbPNWTVUwl0RlWSlgQsYZwzHyyrQm6nCqpZI=
X-Received: by 2002:a67:385a:: with SMTP id f87mr2704232vsa.179.1547602066980;
 Tue, 15 Jan 2019 17:27:46 -0800 (PST)
MIME-Version: 1.0
References: <1547539894-12898-1-git-send-email-yamada.masahiro@socionext.com> <20190115092229.59e09c2d@xps13>
In-Reply-To: <20190115092229.59e09c2d@xps13>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 16 Jan 2019 10:27:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNATnfTQXHrXJQp7732-e7hvd8ORcYubyDmz0KHaRXRMDqQ@mail.gmail.com>
Message-ID: <CAK7LNATnfTQXHrXJQp7732-e7hvd8ORcYubyDmz0KHaRXRMDqQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: denali_dt: remove single anonymous clock support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+CC Dinh Nguyen)

On Tue, Jan 15, 2019 at 5:22 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Masahiro,
>
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 15 Jan
> 2019 17:11:34 +0900:
>
> > Commit 6f1fe97bec34 ("mtd: rawnand: denali_dt: add more clocks based
> > on IP datasheet") introduced a more correct binding that requires
> > three named clocks.
> >
> > Now that all upstream DT files migrated over to it, remove the single
> > anonymous clock support.
>
> I would love to do that but I think this is against the "DT backward
> compatibility rule".

Yeah, I know this rule, but we break DT binding from time to time.



> Anyway, IIRC it is accepted that this kind of
> rule might be broken if decided per the arch-maintainer (in this
> case, you I suppose). So if this is really what you want, I'll queue
> it.

My platform is fine, but this driver is used by SOCFPGA boards as well.

I CCed the SOCFPGA maintainer, Dinh Nguyen.



-- 
Best Regards
Masahiro Yamada

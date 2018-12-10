Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0EDC6783B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B86208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GUD3XoA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B86208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeLJPxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:53:12 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:33329 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbeLJPxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:53:12 -0500
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wBAFqrKs014039;
        Tue, 11 Dec 2018 00:52:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wBAFqrKs014039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544457174;
        bh=w4tj8Uk4ZC16poCyIG1KABYmt0n/aTk1asq+Y8EcEaA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GUD3XoA+areXQdAyZkiFVoY6I47D5DbNsb9axwSo25z1jRbPCCVxbdM9Np2Ppq1qK
         qaXE1WdXrlnrPXbu8MAmzs6kK8ANGEpxZJwKYdxgo+JQNjy7nrOurqfWq1Yiq5WLHy
         pkQDrnL1q42sWpUmZicLjOhM2DGSNlfv3riwZCnXGND4NmrJwfZtAHasYEZU0bUA21
         jbZ1HttQdgUpIPyoDTPUzB9t2dXqM+qIqkLEjuUdynVHVd7V7X5YCuqAK7/SETJgpl
         l1QFyGh6jRt5QWvt5ERpAe6QIRyPHpYPt3Q1zguw0/IijUWtgUI5k2BhdQpl/E1H5w
         J2l8CsiqswNRQ==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id p9so3979148uaa.5;
        Mon, 10 Dec 2018 07:52:54 -0800 (PST)
X-Gm-Message-State: AA+aEWY0m3+NlgT7NQr/efMJOgnsYGcK9odH7W8g/XFhy9vwQWSOsX+N
        h4t8+MTEzhdQJIba7sJi1b6RgwmkGbDdtR10G1k=
X-Google-Smtp-Source: AFSGD/VSuYwEy5Tnutx4pEGQKNpklyoYoDUOAHksasJD3G0QZoidC3SBkw/i3eqyY6T/2Np3hQY07FhFjn6QEkuah7s=
X-Received: by 2002:ab0:849:: with SMTP id b9mr1720411uaf.93.1544457172926;
 Mon, 10 Dec 2018 07:52:52 -0800 (PST)
MIME-Version: 1.0
References: <20181204114731.48b18bfc@canb.auug.org.au> <20181204015247.GR12288@mellanox.com>
 <AM0PR05MB533192C82AA04E89004251A1C7A80@AM0PR05MB5331.eurprd05.prod.outlook.com>
 <20181206095815.6e814057@canb.auug.org.au>
In-Reply-To: <20181206095815.6e814057@canb.auug.org.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 11 Dec 2018 00:52:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQXEq3xaaZLKeJiSRAvM30vQGZyTbnj=BjXZMsMzyo02Q@mail.gmail.com>
Message-ID: <CAK7LNAQXEq3xaaZLKeJiSRAvM30vQGZyTbnj=BjXZMsMzyo02Q@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the rdma tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     guyle@mellanox.com, Jason Gunthorpe <jgg@mellanox.com>,
        dledford@redhat.com,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        majd@mellanox.com, Leon Romanovsky <leonro@mellanox.com>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 7:59 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Guy,
>
> On Wed, 5 Dec 2018 12:25:57 +0000 "Guy Levi(SW)" <guyle@mellanox.com> wrote:
> >
> > >
> > > Huh. So apparently every compiler that tested this patch (0-day, mine,
> > > the submitters) optimized this call away because is_atomic_response()
> > > always returns 0: meaning mlx5_get_atomic_laddr is never callable and
> > > can be deleted entirely, including the call to mlx5_get_send_wqe.
> > >
> > > Not sure what compiler setup will hit this, but it is clearly wrong
> > > code..
> >
> > Flag -o0  ?
>
> No, but the kbuild tree contains a change that allows turning off of
> gcc's autoinlining and the CONFIG option guarding that gets turned on
> for allmodconfig builds among others.
>
> Masahiro, should CONFIG_NO_AUTO_INLINE maybe need to be off unless
> explicitly enabled (like CONFIG_DEBUG_INFO and others)?


No.

If CONFIG_NO_AUTO_INLINE is turned off for compile-testing,
people will not even notice a breakage,
then the code will get broken here and there.

You will not be able to enable it
when you really want to use it.





In this case, the reason is obvious.

If you expect the compiler to optimize the code out,
you must use 'static inline' instead of 'static'.


static int is_atomic_response(struct mlx5_ib_qp *qp, uint16_t idx)
{
       /* TBD: waiting decision
        */
       return 0;
}





-- 
Best Regards
Masahiro Yamada

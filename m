Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C44C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E1A2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kS9qcsUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbeLQKNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:13:04 -0500
Received: from mail-yb1-f174.google.com ([209.85.219.174]:46154 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeLQKNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:13:01 -0500
Received: by mail-yb1-f174.google.com with SMTP id f9so4838860ybm.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 02:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hHYje4n6KxofNi9mlQsooXZ4wBBO/retiPR2c4W92ds=;
        b=kS9qcsUBreL3BXy/ZRmFibSUJCIu+BLCMnRsbum8cAFOfUX/UwGiKbx9QiL0PkVIKY
         WmYVtvDhYEYCob93eMUOcOYEhYzvNszdJH9EfeEk5vSa3Mt8fji9Js88ZBCddQ3Gm8Yo
         zfjndgYuIQbmpvYGNi+66jVuKljzPIfaqTZ5MehLKyB6P0DNL1USgSKyoeKsF0k1Cm/4
         yfzE9Ugn8zUin+gdltt0I2ry3e3uzViz6skcyJ3OEFgt/4QJVKVPUZ9qfqayPj52muu0
         qaW87E96sIyy3ChdbcI62mNXuMBCT8j2uA4/oxtblZCzWMRcH3Ph3gzFdBvsDJdYkxbq
         i9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hHYje4n6KxofNi9mlQsooXZ4wBBO/retiPR2c4W92ds=;
        b=hY/lOVFMwdJLnglC5RR88SETReq4ng8mDhhpA1ovpu+OiDyurBZlyGagFH29A0vJta
         c7BWmPPCS42y5pJdhaldgNyc4qbgJnb1/3TxZ48I0xWIrMLakaUrZFUioc+uSQWn53bQ
         0P0YMr45wsY24qY34Op9x/YFJ7N+6WKtQbxwXQgMGbxtq8K1DwdX6oLlAbAvJx6RJIXM
         Hj2wZYTqhGu3SXzplkLQNMNceGDS81koyV5tnZVoZoce5S/yRmV5vs5tJ8duGBGn76eQ
         zJdX2Cr4gpBD2tYEtDDRpGpeyXT2wAKKjxIdquyyNG1j+S8ua/sXLC3vHOT41fGHSSNS
         YQOQ==
X-Gm-Message-State: AA+aEWbUSuoYHFemdm7k4a5I3wp/+Iqs0WrY9YW+83aN/hw5dl8nwMoL
        qlvJb/xZvnuHf9VX1p543LLoZfDTk/Hma5xZqbzBsA==
X-Google-Smtp-Source: AFSGD/UH5NqP1camh8oSgb5IwjpNcu8MtdGx6T4cgOzY8HOR/sL/3vcJwiSyEn3qjKRvkKmLZhsgEBzUK3H7B43EehM=
X-Received: by 2002:a25:3042:: with SMTP id w63mr6155349ybw.461.1545041579439;
 Mon, 17 Dec 2018 02:12:59 -0800 (PST)
MIME-Version: 1.0
References: <20181217113106.32d98f30@canb.auug.org.au> <20181217100314.GA12765@splinter>
In-Reply-To: <20181217100314.GA12765@splinter>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 17 Dec 2018 02:12:47 -0800
Message-ID: <CANn89iJAED9AxeX6BjwvEo204-rHOr0QFFk6v7r3nCHb3_0OYA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
To:     Ido Schimmel <idosch@mellanox.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 2:03 AM Ido Schimmel <idosch@mellanox.com> wrote:
>
> On Mon, Dec 17, 2018 at 11:31:06AM +1100, Stephen Rothwell wrote:
> > Hi all,
> >
> > Today's linux-next merge of the net-next tree got a conflict in:
> >
> >   net/ipv6/ip6_output.c
> >
> > between commit:
> >
> >   8203e2d844d3 ("net: clear skb->tstamp in forwarding paths")
> >
> > from the net tree and commit:
> >
> >   f839a6c92504 ("net: Do not route unicast IP packets twice")
> >
> > from the net-next tree.
> >
> > I fixed it up (I was not quite sure of the correct ordering - see below)
> > and can carry the fix as necessary. This is now fixed as far as linux-next
> > is concerned, but any non trivial conflicts should be mentioned to your
> > upstream maintainer when your tree is submitted for merging.  You may
> > also want to consider cooperating with the maintainer of the conflicting
> > tree to minimise any particularly complex conflicts.
>
> Looks good to me. Eric?
>
> Thank you!


Yes, SGTM,  thanks.

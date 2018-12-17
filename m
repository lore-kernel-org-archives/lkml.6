Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCF9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265972133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dev-mellanox-co-il.20150623.gappssmtp.com header.i=@dev-mellanox-co-il.20150623.gappssmtp.com header.b="SDqHbH8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732675AbeLQVYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:24:16 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:41956 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbeLQVYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:24:16 -0500
Received: by mail-lf1-f45.google.com with SMTP id c16so10590190lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 13:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w8A3tgFcNoj9XA95ACM7aqam9wzzhgJlqyP12yWLZcs=;
        b=SDqHbH8gayQSVw8EpRvlddy7DUCnAHi05Y7Ix9/4Znsb9Jv6bPdprgf1WYTK+lYtGR
         N5Z51rD6xC/8u17x78+UFYBkkxO84/VyDkIEtMgCjJcc4BQaMBZE80pnCjALiPolfXk9
         wrzxHzizbMMe088xkFMBMp+aXQuO2fxWt3qEnjXp9MkROpu/ZMdJmyVCarXsl9TU9YXe
         6+QO2lV3zMkA4j4QAa11Ngum6FznKKQ7u9YJMJPz9XkfqOOB9u6ShaI6nS9LURjuSTBR
         OdeU85XS8eXMgf/Vga9r3pS1X/4QRY4qiTva2mseaDhCpNYzCqemjsRqe6oI0c9ZLmmo
         zwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w8A3tgFcNoj9XA95ACM7aqam9wzzhgJlqyP12yWLZcs=;
        b=mNYJzc0+/Efvvg5O7CIeLbFNlY3Q2vTcLyg1TS9wc58LzWNN2Rp6m2GfshRtRw4Ike
         awq7JXxJOV28b6wk9ktnr2nc5rBdHuyyvMURMs129iD4UWPh5gCZcoIamRXCuohkFdIU
         bKXy7Gfqahxw8isKb6lguu/pey8C8UNIoC06nUms6ehQqHU4jLh501Xeaq5xJmmk9Bq1
         b78uIMEUK4CciEAn3EQgi18p253NniXqOajv+BKS746D/k6pzDo9wf0f0nYiua5KW+fN
         m5clgD2kM2ic0zOA+GCfFBuv7Cj7jq2fbuQrgpAFl0dMGq0gljJQ88fVVBwC5bCUsxIK
         It8w==
X-Gm-Message-State: AA+aEWbsdJhpaVhnANONzbqXEYS45OEyeeaqeqEWjsnfuqjT+AfTTRMJ
        LarKMqnFRQs9+AxnWQyxanEBGymu7dLR7lr4u2GqlQ==
X-Google-Smtp-Source: AFSGD/WTiIuE7/huUlh4/E3OoLAjo/ouCp9gk4mPLE5Uzv8X7h8kvuYiZQQqvrjorCX7LR/iAcRbbySWzQYvOCBGeoA=
X-Received: by 2002:a19:d70f:: with SMTP id o15mr8764918lfg.134.1545081854313;
 Mon, 17 Dec 2018 13:24:14 -0800 (PST)
MIME-Version: 1.0
References: <20181217110810.64c69fb7@canb.auug.org.au>
In-Reply-To: <20181217110810.64c69fb7@canb.auug.org.au>
From:   Saeed Mahameed <saeedm@dev.mellanox.co.il>
Date:   Mon, 17 Dec 2018 13:24:03 -0800
Message-ID: <CALzJLG84yL5DQy20YdXa09WGFrR+5wYpO=YGmaoVGMueoJ-_pw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rdma tree with the net tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vu Pham <vu@mellanox.com>, Gal Pressman <pressmangal@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 4:08 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the rdma tree got a conflict in:
>
>   include/linux/mlx5/mlx5_ifc.h
>
> between commit:
>
>   663f146f2ecf ("net/mlx5: E-Switch, Fix fdb cap bits swap")
>
> from the net tree and commit:
>
>   c74d90c11c05 ("net/mlx5: Fix offsets of ifc reserved fields")
>
> from the rdma tree.
>
> I fixed it up (I just used the net tree version) and can carry the fix

Yes this is the correct resolution.

> as necessary. This is now fixed as far as linux-next is concerned, but
> any non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Dave was already notified about this merge conflict.
This conflict will go away once Dave merges net with net-next, and
linux-next of rdma merge with net-next
will not have this problem.

Thanks,
Saeed.

>
> --
> Cheers,
> Stephen Rothwell

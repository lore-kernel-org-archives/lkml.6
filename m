Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087CDECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD76D20644
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQhFDA8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD76D20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeJJCCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 22:02:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56311 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeJJCCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 22:02:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id 206-v6so2896669wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uK5VulfsT9+yXniUQT5pGNq2fzlt/5lofkAnlCR3XG0=;
        b=dQhFDA8jslIATG/TblQnDeI+r7bo/fHeV/8Ih7uW0KdBl7ngZpCReWUgv99kQiO10x
         36A9qxqGMoUbGAxNIrLsSUc8Nu6ZTAnZRCrxnivr0lSDhOzMeHAUziK//OBDXM5KtsXq
         NC85GvVpT8wQpL0foDBULlDpw43Fv5BpBv4jDTcwgVwkIjBhG5AbRgc9mb6UYnM5qjSA
         lKckICyKmYoI+RwxpLLLZ8CjcUZroz3AY4zd1BzCsPEbKTI1HbPlMDioXuU/GAo+xJ0P
         v3u8t5auMkamkZB8jstiORgsZIL104Lx98A8OsmWYksUUZj1tBcox4tDJKgXLGx/9ho/
         I8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uK5VulfsT9+yXniUQT5pGNq2fzlt/5lofkAnlCR3XG0=;
        b=RxOgleiWQBvjD5TLbCX11RHaPFUz2r2ZFP8oSFoX+KdmhP9eWgKvG3RKiAI/0Es8h4
         HTNqvcUSVWSSE5lgYemuu27yRRtmQvkwctLT/JZnPnL6N2TQ6YlfC15VFSmi40aKzUvj
         9hm2qdsUGl/IhN7PEt40FJoqzBvuC8jaLN/cUQn3C9JJ0BUnhejWXrmYRcycbSrNmmnG
         kvgCVcm9gayLe952e0EKt3wfVEpxEmUSvJHQlswTAUV2Vo0H4XPwJtu0kHNhW0D3Uun/
         qcVqzAdwpzVz80j7IAb7l6BYO0B9bdC/u7PeAhlZBs1RRuVBA7Eju8rcSraV0zSt8vSK
         nlug==
X-Gm-Message-State: ABuFfoj3G9F3glKz/Mp/5Jru8aASL4HCcEVvkRQo2/EWilHI7tKA+wTL
        /DyhFOzHEWzNms6byTq97AA=
X-Google-Smtp-Source: ACcGV61EAJp+1i2J6ssH2QdVAgJH6cpmhix6JU9rB+CTbNjk979Q5rQSd1n/3zBCarP3l2x9E1R0bw==
X-Received: by 2002:a1c:8fc5:: with SMTP id r188-v6mr2997585wmd.136.1539110649872;
        Tue, 09 Oct 2018 11:44:09 -0700 (PDT)
Received: from kheib-workstation (bzq-79-179-121-186.red.bezeqint.net. [79.179.121.186])
        by smtp.gmail.com with ESMTPSA id j6-v6sm16187130wru.20.2018.10.09.11.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 11:44:08 -0700 (PDT)
Date:   Tue, 9 Oct 2018 21:44:06 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 00/18] RDMA: Add support for ib_device_ops
Message-ID: <20181009184406.GA5235@kheib-workstation>
References: <20181009162817.4635-1-kamalheib1@gmail.com>
 <5e5e8b964bf9d6234af22f042f647a66868d0449.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e5e8b964bf9d6234af22f042f647a66868d0449.camel@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 02:31:27PM -0400, Doug Ledford wrote:
> On Tue, 2018-10-09 at 19:27 +0300, Kamal Heib wrote:
> > This patchset introduce a new structure that will contain all the
> > infiniband device operations, the structure will be used by the
> > providers to initialize their supported operations. This patchset also
> > includes the required changes in the core and ulps to start using it.
> > 
> > Thanks,
> > Kamal
> 
> Hi Kamal,
> 
> Please repost this to linux-rdma@vger.kernel.org as that's how this gets
> into patchworks.
>

Hi Doug,

Oops, My bad instead of picking the linux-rdma email from get_maintainer.pl output
I picked the linux-kernel email, I'll repost them soon and thanks for your reply.

Thanks,
Kamal
 
> -- 
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD



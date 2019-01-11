Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ECBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 04:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730792133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 04:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tglla91H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbfAKE0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 23:26:18 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39401 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbfAKE0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 23:26:18 -0500
Received: by mail-io1-f65.google.com with SMTP id k7so11231478iob.6;
        Thu, 10 Jan 2019 20:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKKW4KX0W8co6X3GdJtBCN6KWzvQnWbDVJp2nnG34FY=;
        b=tglla91H89i1R3gf4NQ42Mtm5RsepUvu1KFnb9iPSvJuQkPyw8m5RH8Y2uul8RxrOy
         U/AANR6s6dd79robnnULiXxXiAlypbwV7Vz45Qe1n9Oa6oLbFcaViMtIMQJeFaJN55ex
         GjXpEw7Eu4mSUWplWdFT6lyCKRDNOgybtYBqsniyLmzlpOvq1qNMEgR1+hcju/rTcq2Q
         aXiKf5sn23cFfnZrk4vi8p/DHstsNbKAJB4oc9tiBiUPZXwfxoZy/Ox4JoEYEBlXuuGN
         dpSNq9HI/mc30K4YmT+MxKi726D0hIRvuf9zCIfvzb1Tk9VpUmn11+TUfrMugzU6gbh5
         kfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKKW4KX0W8co6X3GdJtBCN6KWzvQnWbDVJp2nnG34FY=;
        b=PUrHpYskHH3TestB+W5GNyuftpZK0SDKh9BAJQKQVzMsaoiS1aCAeju7+Owvu77nvc
         uE8tBn8ybbMJq0MANceNJRCEOnN8z7+QogJfrzTS0ao4rQiMHh5p5uCB7fLFTpJ+Kskb
         VaDbC3NrzLtY+IYLl2h609cy4pl4HEYIpO/Rk+RzecHFC8/mP3ORib5X9QbAur32aKAw
         YK7sSeJ4vOBuufDLc0k3x71Wlu6NiZ+oDlXT07ZTgHafDnPGWIj7u2PvDpkQ2Nt8Gfu4
         zpCm7vMhA6TyHPoWCXUtcKvQGpPaaz61kqNM5gKMO7fdnF1u2hw4SD4A5EaiF016Jm6A
         Q0aQ==
X-Gm-Message-State: AJcUukcKlJlOlGUZnSHqvkYBBq//5vfpqKJ1oBP9nZ+i1jWSMnwn1p9N
        wxVmDIKRBw1KgTJaugt2ACpycCYwGcgfw5krVXJlVBRD
X-Google-Smtp-Source: ALg8bN7/h8ZGV1XbVqTyvQ30HXJWRsEL8jqvCZJebSp+XohTz6AJuEpLvZkZ6a55o1TPMxiOfQIG0zAn4Cw7ecn5ZYo=
X-Received: by 2002:a6b:3945:: with SMTP id g66mr8524731ioa.131.1547180776406;
 Thu, 10 Jan 2019 20:26:16 -0800 (PST)
MIME-Version: 1.0
References: <154693980088.104235.16222977463502002037.stgit@buzz> <CAM_iQpX1oiOiGFejO8yKNM_VT2BSMH9aFk-_1nPDjfO=jFmNgQ@mail.gmail.com>
In-Reply-To: <CAM_iQpX1oiOiGFejO8yKNM_VT2BSMH9aFk-_1nPDjfO=jFmNgQ@mail.gmail.com>
From:   Konstantin Khlebnikov <koct9i@gmail.com>
Date:   Fri, 11 Jan 2019 07:26:09 +0300
Message-ID: <CALYGNiOHu5gif7Kqgt_LCMBBOHq-LxffSFJGn6Joi6dccDfptQ@mail.gmail.com>
Subject: Re: [PATCH] net/core/neighbour: tell kmemleak about hash tables
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:45 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> On Tue, Jan 8, 2019 at 1:30 AM Konstantin Khlebnikov
> <khlebnikov@yandex-team.ru> wrote:
> > @@ -443,12 +444,14 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
> >         ret = kmalloc(sizeof(*ret), GFP_ATOMIC);
> >         if (!ret)
> >                 return NULL;
> > -       if (size <= PAGE_SIZE)
> > +       if (size <= PAGE_SIZE) {
> >                 buckets = kzalloc(size, GFP_ATOMIC);
> > -       else
> > +       } else {
> >                 buckets = (struct neighbour __rcu **)
> >                           __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
> >                                            get_order(size));
> > +               kmemleak_alloc(buckets, size, 0, GFP_ATOMIC);
>
> Why min_count is 0 rather than 1 here?

The api isn't clear and I've misread description.
So it should be 1 for reporting leak of hash table itself.
But 0 doesn't add any new issues.

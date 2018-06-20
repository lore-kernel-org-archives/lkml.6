Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642C5C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D2520874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsjSqb46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D2520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754297AbeFTOml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:42:41 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41647 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754259AbeFTOmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:42:38 -0400
Received: by mail-lf0-f66.google.com with SMTP id d24-v6so5360898lfa.8;
        Wed, 20 Jun 2018 07:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PVykCexUyLgIC3p9nZLGDDMb2oN7Ygwh+sKaCfUt5+Q=;
        b=jsjSqb46speKcHXeAuRfNHVk/hUr4bXYdZ5a4kgvA2ubglv5f1urd3VdFefoC1/J+g
         3sQZ3jbb3/Ftn7ZBFIYh9a5oKlmqyBFd6pVUfSDtVtO8u31PSlAG50LPybULcRSTBJeT
         MutROmORBLbHUUKjYvlhFsirgQnYev4wWwLzOur+7UR96VulCl6opfTxgZbRQ23R4Ny2
         OPWC1YoRUd8Qfd6O35z7bwmxMpUoTpHynCISurY8ehL5NvuvSmhIXUISUXItdUbSK7Bq
         j/AM35cI37N+fDigUGO7ItinWdVrdm+LfcpZiKwS/FUOru9MylxVlRqAQMPDpyZHJJDm
         QU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVykCexUyLgIC3p9nZLGDDMb2oN7Ygwh+sKaCfUt5+Q=;
        b=Ue3LJ3lce0buOMKVEmiTlWXhP3Q5qzT35H3xQUV4KecUdI9kdSa9tgjMdGKUXNTR7O
         vGo87jmlO5f0OeQpLa9bixcwlBSBhNrevuldXWxOnZYlxB/uIY8QYNGNAHP7pKpWttsj
         rkC7QhX96KuS14pItAwHs2PdaUJGt8uVN0AEIDwSNzNxSfPBcLbGIyTnCCUQ/oVk+62w
         +2wS/riRbGwIpmHGtZG6jUgwroOmu7JTjfSy7SKwyU4Yw5MBl9/JgS2BfGM2NIQtKeTZ
         nvpoudp0MsR1lQkReWjG5rvQti05v291Y2zvCXW8ZASzx1PlAupcI39X/omud7LqB6ja
         rpCQ==
X-Gm-Message-State: APt69E0OTpX19HoZ4p5IZlKFQ6uvTb1og3xfvH8ECiv/F//TMUakyzVV
        OzLtEu4LDbEYBOFaajMC6Ck9zeW5fpizKfjXHUw=
X-Google-Smtp-Source: ADUXVKICNZSu8RkEGPcySGvDscKFbkxvNf4XLHJls5vLr500IlqlT1wSguwgZGL38kO8UrRXOHJh/4WHHvK3skppswc=
X-Received: by 2002:a2e:2206:: with SMTP id i6-v6mr14145299lji.119.1529505757244;
 Wed, 20 Jun 2018 07:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <1529488801-22093-1-git-send-email-allen.lkml@gmail.com> <CAOi1vP9Aa9xb2RD7ahE=jOj8nvOX936oVyp6rkKHV8tknF_1Kg@mail.gmail.com>
In-Reply-To: <CAOi1vP9Aa9xb2RD7ahE=jOj8nvOX936oVyp6rkKHV8tknF_1Kg@mail.gmail.com>
From:   Allen <allen.lkml@gmail.com>
Date:   Wed, 20 Jun 2018 20:12:25 +0530
Message-ID: <CAOMdWS+BHKbRUJ91_S4dtv9ZYUEYdD3Yev+9drR+3nsiGu7f9A@mail.gmail.com>
Subject: Re: [PATCH] ceph: use ktime_get_real_seconds()
To:     idryomov@gmail.com
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        y2038@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Use ktime_get_real_seconds() as get_seconds() is deprecated.
> >
> > Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> > ---
> >  net/ceph/auth_x.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
> > index 2f4a1ba..99561c2 100644
> > --- a/net/ceph/auth_x.c
> > +++ b/net/ceph/auth_x.c
> > @@ -154,7 +154,7 @@ static int process_one_ticket(struct ceph_auth_client *ac,
> >         void **ptp;
> >         struct ceph_crypto_key new_session_key = { 0 };
> >         struct ceph_buffer *new_ticket_blob;
> > -       unsigned long new_expires, new_renew_after;
> > +       u32 new_expires, new_renew_after;
> >         u64 new_secret_id;
> >         int ret;
> >
> > @@ -191,9 +191,9 @@ static int process_one_ticket(struct ceph_auth_client *ac,
> >
> >         ceph_decode_timespec(&validity, dp);
> >         dp += sizeof(struct ceph_timespec);
> > -       new_expires = get_seconds() + validity.tv_sec;
> > +       new_expires = (u32)ktime_get_real_seconds() + validity.tv_sec;
>
> Why the change to u32 and this cast?  If the type has to change,
> wouldn't time64_t make more sense?  ktime_get_real_seconds() returns
> time64_t, after all.
>

 Right. I'll drop the cast and send out V2.

- Allen

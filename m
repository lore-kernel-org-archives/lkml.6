Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61739C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 14:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB3820664
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 14:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVvhIO3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB3820664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbeKZBae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 20:30:34 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35214 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeKZBad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 20:30:33 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so13707355edx.2;
        Sun, 25 Nov 2018 06:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qe3g+4oK5urf0C9OUamBYlRFG+yhIqOjwS7c1rUtW60=;
        b=UVvhIO3OtE36NR7EaldVBH0cjI7DckhnH8TLQVhcv2B1B/Gj5+AOV3MspIw3OlKphj
         XN2YDSNpLY2zkBbQfs2GCXYffBnFm0HlhGaPH7iz4C2Emb9bMrv0aTdROtvqschfdIcl
         l+HWx6xn/xvNeMIJNDWlgRnrHoFjnaNIWXQw/fUGdpCMKnEjLlQOUJFHgCqVvSyElLZP
         OXN0dlyf1e0ylz67t0NewK0HdSWEcVCSEJuY0wmklF1++SUmPS68B9fhi+hUzoQdqsPE
         qk3GK/Xzr7QaoCdAw+yCmywUX0LzhN2ZWx+LBLPcekZMtYWX2izhp46/gDeXfp3uAEyh
         9GiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qe3g+4oK5urf0C9OUamBYlRFG+yhIqOjwS7c1rUtW60=;
        b=P84uu8BbBSBSucz5VTYnBYbo56RK1jrj6Szxd5iPCUxck8lQhQOTAg/mLesMrCq0Q1
         DFYYghr59mdQ8bmFh0qY5YBOfZlk5owvFW3fjfJED8Vw0iVBGkKlN2ClikXSVJk3nBSq
         SwMiCOcKahUs9G3Vur+J/EZKzr2Mem8ZbI+OQOWQAlWZ8pI7E2RVAXNB5PlLSnlPGpUx
         3Ypd00jsVLitE8GlMN0YYcBkNggyNmP/t1tq+3LdLjVta4wXniyrSZWUJH0mMy7OYDBb
         XJxdGGutD6FSsdEXKbCxyEugT4ImVwmq3YqzRubOL2iiwjOYbPKyupxVHcf4v8T71OoJ
         +bEA==
X-Gm-Message-State: AA+aEWYJIhyvy+eAgKkLDevjBpuRDAx7Uo1ECVJw+IP+77LagaNiV1yW
        r85yKx/0BjzmnIzi3ztUXpvCfMtkO9nqteAhFX8=
X-Google-Smtp-Source: AFSGD/U/LkPppFlHFTz7CAE0T+Ke3D7zL5uaLIpr865a7GwILN1XgMUdNCb0b2hognUG2qgN2epog+6ChKTef8woxNc=
X-Received: by 2002:a50:ac81:: with SMTP id x1mr15103189edc.71.1543156758652;
 Sun, 25 Nov 2018 06:39:18 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-8-deepa.kernel@gmail.com> <CAF=yD-K=ZLZ_S=Y6YnhvvkfKQS=21ujwiGd7+JB9yDMtiX_9hg@mail.gmail.com>
 <CAF=yD-K3Ga8qojSh5Epa6m4EYn-Lvdo=e38MnFqOKch1128VHw@mail.gmail.com>
 <CABeXuvoDPvT45CCt2L0TReqtb1Q_-E8+toYu6qjiP0cxfdQNdA@mail.gmail.com> <CABeXuvr6fi9UPwMvuafx7MwEta-Sx1TLNN0KQ8HQHhn=vAne5Q@mail.gmail.com>
In-Reply-To: <CABeXuvr6fi9UPwMvuafx7MwEta-Sx1TLNN0KQ8HQHhn=vAne5Q@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sun, 25 Nov 2018 09:38:41 -0500
Message-ID: <CAF=yD-+ZiBR+VFzDnKOKPBCuNF_wbAe6goNO8KXYQH105Sg=0g@mail.gmail.com>
Subject: Re: [PATCH 7/8] socket: Add SO_TIMESTAMP[NS]_NEW
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        jejb@parisc-linux.org, ralf@linux-mips.org, rth@twiddle.net,
        linux-alpha@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Same for the tcp case above, really, and in the case of the next patch
> > > > for SO_TIMESTAMPING_NEW
> > >
> > > That naming convention, ..._2038, is not the nicest, of course. That
> > > is not the relevant bit in the above comment.
>
> it could be  __sock_recv_timestamp64().
> But, these timestamps should be doing exactly the same thing as the
> old ones and I thought it would be nicer to keep the same code path.
> I can change it to as per above.

Please minimize code changes. It breaks git blame and longer patches
are harder to review.

In this specific case, from a readability point of view, I find new functions
that map one-to-one onto the new interfaces also more readable than
deeper nested branches in place.

> > So we introduce new y2038 safe timestamp options for 32 bit ABIs. We
> > assume that 32 bit applications will switch to new ABIs at some point,
> > but leave the older timestamps as is.
> > I can update the commit text as per above.
>
> We have been avoiding adding timeval64 timestamps to discourage users
> from using these types in the interfaces.
> We want to keep all the uapi time interfaces to use __kernel_*
> interfaces. And, we already provide __kernel_timespec interface for
> such instances.
> But, in this case we do not have an option. So we introduce a type
> specific to sockets.

This structure just holds a timestamp. It does not seem socket specific.
I don't mean to bikeshed the naming point too much, but timeval_ll or
so may be more representative than tying it to a socket.

As for the general naming, xxx64 or xxx2038 are more descriptive than xxx_NEW.

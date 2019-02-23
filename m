Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EAFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644882084F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRZ2Kmnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfBWNRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:17:50 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39565 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfBWNRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:17:50 -0500
Received: by mail-io1-f68.google.com with SMTP id x3so4041444ior.6;
        Sat, 23 Feb 2019 05:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=1aAfqZjHxXsssZRn+4PHuxoy59COYe9T0gXkqPq5kys=;
        b=iRZ2KmnkpLNVCCOXcrkSkGi0IIgL4V1pbzS7IvHo20S9g2r10lID+TKhHZTV5MOFbB
         OpkgJ9B/0NAA/hRG2kujVMpW/yXu4X2I59msCSROJJJBnI2Ngma62R4qpPAUlSZHcrJz
         NiVRsQxXkFm5xju9p4TxeliS6fYk2ulNCuKOLdB9CtppzL5YKxT3ItgGwfAV+shgWo0Z
         /8tmmYeuHTaCAzCPKATYhcqDaicaogl6s0Zr0t8BBwS5Jxo6eRKVEU7JXDjwMhdFd68l
         GU8c9w3vcAVI30rrMgPuoLXho5LAHhQ5UONa4JtVQBgRs2DStuKsQOzhbfOA5WmyAD0B
         Rj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=1aAfqZjHxXsssZRn+4PHuxoy59COYe9T0gXkqPq5kys=;
        b=XRqyPpx1heEPOqoGbhUu18TPD61MJLrI7s9GSRVb8JDaAkzM58DQTytxDanxpuLSIH
         nfAdTa/qydMybfVm8KF3kzlmGv+8+xkigmhI7V7SkxC9UlDEptzz59Iu9VYKBxrLEZSU
         8jmDcwfevHu7VMU/Bon48mqTkfbOpJR/dKUpmvKl8wilXWVi7vTIfxq1ZO1RtpSh0v2s
         XJN11SaAw09nernOIfW9Qr5oZH57eW57WsxlQ7er5E2xLpVVXYCiJrzxO5l2XTu0tPRj
         ++On5sksDVJqB44oEtLo6c4YpDbWcECqmBh64klynT/lG0HNpSUHhlfkhlEiz0XkwWrV
         xMng==
X-Gm-Message-State: AHQUAuY/FGSwT1ZzqmpXGBEpd1u6ZNMGNf6zpcPENebPDE6az29D8lig
        xIdnI44PXoDSoUgqzQoAO7jq6x+7OZyC4DW1JX4=
X-Google-Smtp-Source: AHgI3IZ+yPJqH5XQg6ChodJB7/qfORnnxkD+VCRBHEZEam4jIFkJB1tZcBXVLpW3soAD27AtxfHXt3pxuirt+i9bl40=
X-Received: by 2002:a6b:398b:: with SMTP id g133mr5292719ioa.160.1550927869388;
 Sat, 23 Feb 2019 05:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20190223111751.14620-1-jbi.octave@gmail.com> <20190223125932.GC16686@kroah.com>
In-Reply-To: <20190223125932.GC16686@kroah.com>
From:   Ivan Ivanov <qmastery16@gmail.com>
Date:   Sat, 23 Feb 2019 16:17:36 +0300
Message-ID: <CAAaskFCUXvPjTZXY_k1zohpVc-ij6sUoB4EcrsYRKU+ortXf4Q@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] net: ax25: Fix multiple blank lines warning
To:     Jules Irenge <jbi.octave@gmail.com>, Greg KH <greg@kroah.com>,
        jreuter@yaina.de, linux-hams@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ralf@linux-mips.org, davem@davemloft.net, netdev@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

as usual, Outreachy is doing stiuupid almost-useless commits like
remove two blank lines or fix a tiny typo. They are trying hard to
pretend that they are useful by doing many lame patches like this,
while promoting their SJW madness, anti-male sieexism and anti-white
riaacism. But with the lame stuff like this patch, they are failing
miserably. Maybe hire a ghostwriter (from NSA) to write some drivers
for you?

P.S. and no I am not going to write them for you because I disagree
with your Ci0ck of Conduct and now have to write from anonymous
account

On Sat, Feb 23, 2019, Greg KH <greg@kroah.com> wrote:
>
> On Sat, Feb 23, 2019 at 11:17:51AM +0000, Jules Irenge wrote:
> > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> > ---
> >  net/ax25/af_ax25.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
> > index 5048790a75f6..2da349b7854a 100644
> > --- a/net/ax25/af_ax25.c
> > +++ b/net/ax25/af_ax25.c
> > @@ -49,8 +49,6 @@
> >  #include <net/ip.h>
> >  #include <net/arp.h>
> >
> > -
> > -
> >  HLIST_HEAD(ax25_list);
> >  DEFINE_SPINLOCK(ax25_list_lock);
>
> Why are you doing outreachy application patches in net/?  We only accept
> them in drivers/staging/  Always start there first.
>
> thanks,
>
> greg k-h

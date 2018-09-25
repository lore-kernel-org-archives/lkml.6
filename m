Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FFFC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB6520684
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="zqtpmUfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB6520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbeIZCLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:11:41 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:35167 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbeIZCLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:11:41 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 1672d3b6;
        Tue, 25 Sep 2018 19:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=PmEK7EcXRp29iDPblciKrkxZ3SA=; b=zqtpmU
        fIaPYJbEFqwWgmMm5gB0/ZdaXgGBSTZQKuz7369mF3Gp2DJA4cq+yuSUw+pNVNTH
        V8X8Czjo4zZFubo8RmRIVti5Gexe3Ty2yKW94lqyxyvemW9OZOQ5y8Dqv2tuVC1t
        QNhpFkvlPkT4kRXMxxj3YQRDe63CpP9oM+3xI3rTF7nZ4YdMrXR0ZKJ1s1JAa+wB
        Ti0L+kiMVaNQ9JaVgDVY4okBkNUfj7AjllDxYJ0M0dNmAKXQg32BOAqdpiGpAa9m
        dEARBV1cjpq2dqywMznqx8gKfFvPostln1hFVOzg77thzXqyXS1fzltQebLUYCwY
        q1L4ZO5E+TyWC4Bw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2f32156d (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 25 Sep 2018 19:43:58 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id j9-v6so25768232otl.2;
        Tue, 25 Sep 2018 13:02:26 -0700 (PDT)
X-Gm-Message-State: ABuFfohJT3tBPRj+v0bNbLuHj7rpIbvikYf+H7TkeA+9pz8ZYCFPXwV0
        nR3nUTvDgvABBrDXClB3bEPaCQ/8wULvltKiWMk=
X-Google-Smtp-Source: ACcGV60DdE3gYnAFjOt3X+7jYNxC4Cj/ZH9C2FLb0572npB2Dowt5Pf0S9CjJwvvKN2GaitTYxgejlaPpV+F5svmCAI=
X-Received: by 2002:a9d:48a8:: with SMTP id d37-v6mr1974084otf.384.1537905745415;
 Tue, 25 Sep 2018 13:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-3-Jason@zx2c4.com>
 <2b5f2df2f1278c118a913259a44efdf589719293.camel@perches.com>
 <CAHmME9qLzFHPm2aaEKOmjBA95-c3CZuT+kQiuksLRRWQ_ad2sw@mail.gmail.com> <1BA7DB23-7BB6-46BA-A3E2-D65BC3CAF11C@amacapital.net>
In-Reply-To: <1BA7DB23-7BB6-46BA-A3E2-D65BC3CAF11C@amacapital.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 25 Sep 2018 22:02:13 +0200
X-Gmail-Original-Message-ID: <CAHmME9paEYXKS176MK4VM+wobc0KfNGz3yuQUQhaVNtFBv2oRg@mail.gmail.com>
Message-ID: <CAHmME9paEYXKS176MK4VM+wobc0KfNGz3yuQUQhaVNtFBv2oRg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 02/23] zinc: introduce minimal cryptography library
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 10:00 PM Andy Lutomirski <luto@amacapital.net> wrote:
> > On Sep 25, 2018, at 12:43 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> >> On Tue, Sep 25, 2018 at 8:33 PM Joe Perches <joe@perches.com> wrote:
> >> I think the -Dpr_fmt is especially odd and not
> >> really acceptable as it not used anywhere else
> >> in the kernel.
> >
> > There are about 2000 cases in the kernel of the same '#define
> > pr_fmt...' being pasted into the top of the file, which seems a bit
> > cumbersome. Rather than having to paste that into each and every file
> > that I pr_err from, why can't I just do this from the makefile, since
> > I want that same pr_fmt to copy the whole directory?
>
> Because people like to be able to just read the C file to figure out what it does. Or we could adopt the Makefile approach kernel-wide, since this use of it seems reasonable.

It would indeed be nice to see this done tree-wide. I can recall
various random bugs over the year where some dmesg messages are
missing a prefix because the author forgot to copy and paste the thing
to /yet another file/ in the same directory.

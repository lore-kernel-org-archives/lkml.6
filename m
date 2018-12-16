Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9332C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 18:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9572086C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 18:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vax1bIsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbeLPSqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 13:46:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40372 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730593AbeLPSqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 13:46:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so10094518wrt.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 10:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xIKzofoqeGTPdDkQGq7dhoEjCUH4up0PCTOnDtQdS5s=;
        b=Vax1bIsKfjmR7QT/wusmMeIsgfO0k9dSYApOQUaoNmWdYqsUjSRR0iYeGG2dcSIad6
         imYwnZmo6k+7+uE+1IpfyRgXQHlT2fi1c1CUtbYcIHcMqsWY18TmTCvhX5ZCXk7q4uBP
         DvTJjrhN8vrpHkJoc8AMMZ9h75ISBCA2r679s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xIKzofoqeGTPdDkQGq7dhoEjCUH4up0PCTOnDtQdS5s=;
        b=uDmrczXql8bLFwaVYsx2A2+FWv2mNUKPMEHD0xpHwQj+jXrzM9JVQX5QfhVQYmlTq9
         omgdJb3Ajfi5zdWJvfcIcO4DtxnwUxAG+JdlNuxC5cNv5+Z4mKyT1zd3723EZ7aeqQbj
         WRSEzJwct5zKnpAqgTY/5up7BXBR5XSJ6b6zkcRnWLM8qZ/3cm5ZGlfotZjikRwXxuYq
         zqkd1t3BdesnrxmmlLGancXZ971CoMe/1XgmxiXvS0KnT+rfl8E0GaqT9ArXHHZV3hf1
         5FhUAJCnvaHc15klSs92IX8hdrbLLmV9CdL9Dyi3Zx6rlp+/CMdepyRcyCNbVZNfse/S
         kr3A==
X-Gm-Message-State: AA+aEWY+YyheFLpHcIxwDMJ5puE3ntiHzIE5Hool4B9vxHqLKRfoQOF5
        C/nA2JkX4NobGdtCdVxp45B+YhQ8bML7/7l3tm1z+Q==
X-Google-Smtp-Source: AFSGD/UTQSxX+46xmwNQL/qIQQNJSIMeiGVYR7gmrsb2+4kdj0ZYMRTX9NWY3XGd+zQMOtMn4JT68bnLP6W8pc6+VKs=
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr8931700wrr.67.1544985990117;
 Sun, 16 Dec 2018 10:46:30 -0800 (PST)
MIME-Version: 1.0
References: <20181214211242.9721-1-semen.protsenko@linaro.org>
 <20181214211242.9721-2-semen.protsenko@linaro.org> <20181216163059.i5nadsfzyvcwa4o6@kdev>
In-Reply-To: <20181216163059.i5nadsfzyvcwa4o6@kdev>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Sun, 16 Dec 2018 20:46:19 +0200
Message-ID: <CAKaJLVvj2Yv0hOXiRLvJ1Gnm3axOds21LHxmCW5K0YNpx+hk6w@mail.gmail.com>
Subject: Re: [PATCH 2/2] l2tp: Add Protocol field compression
To:     Guillaume Nault <g.nault@alphalink.fr>
Cc:     James Chapman <jchapman@katalix.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

On Sun, Dec 16, 2018 at 6:30 PM Guillaume Nault <g.nault@alphalink.fr> wrote:
>
> On Fri, Dec 14, 2018 at 11:12:42PM +0200, Sam Protsenko wrote:
> > When Protocol Field Compression (PFC) is enabled, the "Protocol" field
> > in PPP packet should be transmitted without leading 0x00. See section
> > 6.5 in RFC 1661 for details. Let's compress protocol field if needed,
> > the same way it's done in drivers/net/ppp/pptp.c.
> >
> > To actually enable PFC, one should issue corresponding ioctl to L2TP
> > driver from user-space, like this:
> >
> >     ioctl(fd, PPPIOCGFLAGS, &flags);
> >     flags |= SC_COMP_PROT;
> >     ioctl(fd, PPPIOCSFLAGS, &flags);
> >
> > It can be done e.g. from pppol2tp plugin (pppd), when pcomp option was
> > negotiated with peer.
> >
> > Of course, we don't compress Protocol field when sending LCP packets. As
> > stated in RFC 1661, section 6.5:
> >
> >     The Protocol field is never compressed when sending any LCP
> >     packet.  This rule guarantees unambiguous recognition of LCP
> >     packets.
> >
> Again, I'm sorry, but I must oppose this change. Although I'm lacking
> time to keep sanitising L2TP, at least I'd like to avoid making the
> situation worse.
>
> L2TP's uapi is already messy enough. Please don't add non-L2TP features
> there.
>
> Activating PFC should be done on PPP file descriptors, not no L2TP
> sockets. We certainly don't want L2TP to snoop on PPP data, much less
> modify them.

Makes sense. I thought about this, too, just found that it's done that
way in PPTP code and decided not to be too smart about this. Let me
try and re-work this one. Will send v2 soon.

Thanks.

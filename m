Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8C0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA23214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="m60hdUB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA23214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388241AbeKOWc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 17:32:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45557 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbeKOWc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 17:32:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id k15-v6so20967395wre.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 04:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cAnMfMxnQsyrtd5EB+OEuNhgtrQNwlqbyYN2nzIud+c=;
        b=m60hdUB3epw4dNEK6Ves6/K+FqXHxMoPn4Aa3e4nHe8edUFcj+D3Sqsw+hU3cuCmKO
         btBInJX73ERd8bfPBiFICDUFHNo8fcxaP1qX253rCgcqnaGMnDGRvbbQKadb2bh2NKQe
         oJkHcNeeTxSDy7VZ9HJW9/MyAo2odn2vr7177iaYhnmB2k3cJr2VsnljlntsV/n1Pbit
         K+c/HeYvCPD2pT5Ud4aiuvDaUFI/iCyBq29cRsXKeVmbaQ3YQFTEcfpTywRiN2N/qxXZ
         Z31DLw4DteKQhQncUclVNe92ZUcZgVh3LLaDB9b0H5p0KH2hRF8xwrJ8aDhNCK0NEEPh
         28+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cAnMfMxnQsyrtd5EB+OEuNhgtrQNwlqbyYN2nzIud+c=;
        b=qpuCVf0CKhSHOCu2kld4qkwsbBN/zo9canSiiT22yuU8m2dB9V+pxWXvBpA7jMQoSa
         caVGt+n+TJ0Xj1kkfzTuGVeaA9ogu6jW2yljgD2xj70t1q2XwCTjyxoH1i7rdJUs9DaT
         7yCnqPFwhci43MukkxmhyJdijM6PcK7QESzvDhJh9F+/+VkPi0pe4jE4sxhQm2NmZTXC
         5HlNK8Ba/MtOdX5dfFyIUHI1vMxBPg4gOqD2oCKmqHjRRJTWLgH7zv1rkSpyIj22YDH7
         EOQQjnsDDzuYDeXsNDWcL7PgS7ZZNhmQPtzepiitMMbSzZMcNDW+P7Zr6HgI3UBfI9Rd
         r0xQ==
X-Gm-Message-State: AGRZ1gIfrAnWhXxuyibdfUYBntP2Cn0X0o8v9us9Rwmdx/a1OsP/PIe3
        nXG+tcxRgqe/2MP1jgwQxRlf4g==
X-Google-Smtp-Source: AJdET5d8/UZZTXsaPAY+YK96ag6Gtyu/lMccxVwaA1udgd9XMqNdpCkepC5w9C+a/Wdbh5FYdpp7dQ==
X-Received: by 2002:adf:e6c4:: with SMTP id y4-v6mr5331319wrm.101.1542284689181;
        Thu, 15 Nov 2018 04:24:49 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id j129-v6sm21008489wmb.47.2018.11.15.04.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 04:24:48 -0800 (PST)
Date:   Thu, 15 Nov 2018 13:24:44 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
        airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, matthias.bgg@gmail.com,
        maxime.ripard@bootlin.com, michal.lkml@markovi.net,
        mpe@ellerman.id.au, mporter@kernel.crashing.org,
        narmstrong@baylibre.com, nicolas.palix@imag.fr, oss@buserror.net,
        paulus@samba.org, peppe.cavallaro@st.com, tj@kernel.org,
        vitb@kernel.crashing.org, wens@csie.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-ide@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/7] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64
Message-ID: <20181115122444.GA29281@Red>
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
 <20181024085700.GR30658@n2100.armlinux.org.uk>
 <20181115093034.GB23965@Red>
 <20181115093348.GV30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115093348.GV30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 09:33:48AM +0000, Russell King - ARM Linux wrote:
> On Thu, Nov 15, 2018 at 10:30:34AM +0100, LABBE Corentin wrote:
> > On Wed, Oct 24, 2018 at 09:57:00AM +0100, Russell King - ARM Linux wrote:
> > > On Wed, Oct 24, 2018 at 07:35:46AM +0000, Corentin Labbe wrote:
> > > > This patchset adds a new set of functions which are open-coded in lot of
> > > > place.
> > > > Basicly the pattern is always the same, "read, modify a bit, write"
> > > > some driver and the powerpc arch already have thoses pattern them as functions. (like ahci_sunxi.c or dwmac-meson8b)
> > > 
> > > The advantage of them being open-coded is that it's _obvious_ to the
> > > reviewer that there is a read-modify-write going on which, in a multi-
> > > threaded environment, may need some locking (so it should trigger a
> > > review of the locking around that code.)
> > > 
> > > With it hidden inside a helper which has no locking itself, it becomes
> > > much easier to pass over in review, which means that races are much
> > > more likely to go unspotted - and that is bad news.
> > > 
> > 
> > Hello
> > 
> > I understand your fear, but I think the benefit overhaul thoses.
> > Furthermore, drivers which I have converted does not need such locking.
> > 
> > If you want I can rename the header to linux/setbits-non-atomic.h for making obvious the lack of locking.
> 
> It'd probably be better in the function name - it then doesn't get
> "lost" that it's non-atomic when it's included via other headers.
> 

I proposed that way for doing like writeq have do it with io-64-nonatomic-hi-lo.h

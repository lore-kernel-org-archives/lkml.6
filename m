Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65ACC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DEC2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRXpoLls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DEC2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbeJ2T1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:27:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36197 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbeJ2T1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:27:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so8084268wrw.3;
        Mon, 29 Oct 2018 03:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XERfhrC5c9zy8JUz5OgiR9jeZ1lCNHITW7cJlRnxD0k=;
        b=IRXpoLlsxUsOhNLiX34VzBL1nB0e1QJ7bsLS2P+I34VhQwOH0DfMrwLiMZ/ymAV2CQ
         Mw8R8chKo+ZQhIQmreDJN3fUteSj5suxy8/g7VDzMzNeb6SWgc58xjErJjam4LnGKPbi
         A2XHWbtC7XJEmhoIJM98RIgKNmVCKUJjNx4mGcFAJ5tFQ9V+3W+nNCQaR0M7+EaGXDot
         RI+xuj35moUyRpeuBNXWhNEK8x8QxEYPB8rxKaLWcDNJaDXHD/p4jY8sdZEs4C3Jwdxx
         WCc+4wMAC+BIT+P6NREYV9oV1PbG7g8FUCgL8qXPMX+PuHie8VzZ5+RQRF8BXYK95JUd
         QBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XERfhrC5c9zy8JUz5OgiR9jeZ1lCNHITW7cJlRnxD0k=;
        b=meJp4me22G+ccWOy/oTkI9SZZgNsECsO0UKeXrnABcWvSb0esGvG+OpghjwlopJc3b
         69XRLmt95X4wlgk1MfwF6WYVJZalrzd6fKZ5AfvYMSQmwMYjh9tFuHUx/lgWmYS7fvG5
         5DzRa5ysQuZsc0T3upWkQvOFXyqhbS2ddMo85Q7InpKSuM1S+MztomLBThNta8S7liDi
         oKizs4N0bZK6xGoYleuV1dlDc+fKxyvtyvUWWUVvfIY8plb/55PJ/SUyHbGJrQtUCXRn
         4xxIA/vDAi7Y8ivHBR1iriV/j1AYwB76kpykiZs/Zt5KXWvko4rpUMT7sR9im2kr63i3
         D5mg==
X-Gm-Message-State: AGRZ1gJmdN5oUCj/6V1Qlcm3hsLkUz2tmvMWZ5+mURap/+HZy1Dzees0
        lWigV1dTYcCCwtHM1qwqR74=
X-Google-Smtp-Source: AJdET5fXZMSqDX/wps+5kXVdbdvcEkbf42WRFyOJwHz9cfrSr3ULBQAoRImDTZukk/H8KKLaqkE5lQ==
X-Received: by 2002:adf:9403:: with SMTP id 3-v6mr14022237wrq.54.1540809579534;
        Mon, 29 Oct 2018 03:39:39 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id i7-v6sm22018574wmd.41.2018.10.29.03.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 03:39:38 -0700 (PDT)
Date:   Mon, 29 Oct 2018 11:39:37 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Pekka Pessi <ppessi@nvidia.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Mika Liljeberg <mliljeberg@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] mailbox: tegra-hsp: Add support for shared mailboxes
Message-ID: <20181029103937.GB26393@ulmo>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
 <20181026111638.10759-5-thierry.reding@gmail.com>
 <bfc78c91-73f1-4f64-9196-5268a73b5c42@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <bfc78c91-73f1-4f64-9196-5268a73b5c42@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2018 at 12:04:22PM +0200, Pekka Pessi wrote:
> Hi Thierry,
>=20
> There is typically one entity (aux cpu or a VM running on CCPLEX) owning =
the
> "empty" or producer side of mailbox (iow, waking up on empty) and another
> entity owning the "full" or consumer side of mailbox (waking up on full).=
 An
> entity should not muck with the interrupts used by the opposite side.

Okay, that explains some of my observations. I was initially trying to
program interrupt enables for both FULL and EMPTY interrupts for all
mailboxes, but then I'd usually get timeouts because the consumer wasn't
responding (i.e. the SPE wasn't getting FULL interrupts for the CCPLEX's
TX mailbox).

If I understand correctly, you're saying that the CPU should only be
using the EMPTY interrupts for it's TX mailbox (while leaving the FULL
interrupts completely untouched) and only the FULL interrupt for it's
RX mailbox (while leaving the EMPTY interrupts untouched). This is a bit
of a problem because the mailbox driver doesn't really know anything
about the direction when it starts up, so how would it make the decision
about how to program the registers?

> One entity typically owns one shared interrupt only.=C2=A0 For the
> BPMP/SCE/RCE/SPE HSP blocks the shared interrupt 0 is owned by the auxili=
ary
> processor itself, the shared interrupts 1..4 are connected to LIC and are
> available to other entities. The convention is to go through the interrup=
ts
> 0..4 and then using the first available shared interrupt for both full and
> empty.

That partially matches another of my observations. It seems like we
can't use the shared interrupt 0 at all on at least the AON HSP. That's
fine because that HSP instance contains the TX mailbox for TCU and by
the current convention in the HSP driver, shared interrupt 0 would be
aggregating the FULL interrupts, which according to the above we don't
need for TX mailboxes.

What's somewhat surprising is that you're saying that both FULL and
EMPTY interrupts should be handled by the same shared interrupt. That's
the opposite of what the recommended programming sequence is that the
TRM specifies. Why is it better to handle both FULL and EMPTY interrupts
with the same shared interrupt?

> The interrupt functions should use a mask for mailboxes owned by kernel (=
in
> essence what the IE register should be for the HSP shared interrupt owned=
 by
> the kernel) and serve only those mailboxes owned by kernel. Note that the=
re
> is no reset for HSP in Xavier, and the IE register contents may be stale.

Would it be safe to clear all of the IE registers to 0 on driver probe?
I seem to remember trying to do that and getting similar behaviour to
what I describe above, namely that interrupts on the SPE weren't working
anymore. I concluded that the IE register must be shared between the
various processors, even though that's somewhat suprising given that
there is no way to synchronize accesses to those registers, so their
programming would be somewhat up to chance.

Do you know any more about these registers? If they are indeed separate
for each processor, it should be fairly easy to keep track of the
mailboxes used by the kernel and process only those. Again I don't know
how exactly to distinguish between TX and RX mailboxes because they all
start out the same and only their use defines which direction they go.
Currently this works because we program them as consumers by default.
That means we enable the FULL interrupts but keep EMPTY interrupts
disabled until a message in transmitted on the mailbox, at which point
we enable the EMPTY interrupt. I suppose at that point we should also
disable the FULL interrupt, given the above discussion.

> And lastly, if we want to support only Xavier and later, perhaps we should
> be more clear in the bindings? There are no mailbox-specific interrupt
> enable registers available on Parker and your design relies on them.

That was certainly not the intention. I thought I had seen the per-
mailbox interrupt enable registers also in Tegra186 documentation, but
after double-checking they're indeed not there. I don't think the driver
currently "relies" on them because it uses them in addition to the
HSP_IE registers. I suppose that accessing them might cause aborts on
Tegra186 if they don't exist, though.

I'm not entirely clear on what the advantages are of using the per-
mailbox registers, or how they are supposed to be used. The existing
documentation doesn't really explain how these are supposed to be used
either, so I was mostly just going by trial and error.

Do you know anything more on how to use these registers? I can easily
make them Tegra194 specific in the code, but if they're aren't any clear
advantages, it might just be easier to stick with HSP_IE programming
only.

Thierry

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvW42cACgkQ3SOs138+
s6GMSg//V9JSnSvkwYXoPaqltcrRTeKLru/LOlrDzBu1HKkOdgqiGtybCme1rMyH
enowJMU6gf7rg3uuikXqTAn3ZmKMw+1duAncnb9kkJFQw59zC7h/HjLlka2KX1ns
X75E/IOJ2ykYzJXTAA+5Xz/jMHafvZv0rBMOKnC7okf7I6zNw+YU/cBQI4rIDfYj
OoiL6mRqEUXSP/2TDjiYW+Lt0p1Kki6iVrKRbo2uWTbK2goY8hm4qI+FhOtSDWs4
+a7tlcjlSdemR3dVZz8KdZjubyzoMqppmpBBPhCAmN4rCO/o+8ryJMooskP8rnuF
XUz70KP/KZAfNlGy1ymzR89Kbm9Yn8OdlY3y2mLu/MtUQL7Zi+acUHwEXIe8OHPt
0Tu6HzAC0BrrAsQTAno/HbcKX/YmhiWr7omkrWiqovJ1R3bVjdDEq3pEp6a+MRpg
Ji4X/Hq5wJ2UNgwAEGfJ8lsNhsVCXCm0W/ztPPztAjA+8rrCnWWMEA8Ya/A3w8CH
Gfg+cxKgq1ekdMieOz1bTj1F5FlB3kNAr7/R3RQw9moFsLJ3BDGjRJEvmONpx7jc
ac5096zX5VBFSgAdfHwwfiukLQW1tl9zawDvm7tXdKD4VBnQLvOI2KiOQobkliD+
zebGwx8NC5pxtcg1agGp2cShOW8Ha5xPgvhSvM88HC0xjMOhxWs=
=C1I6
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--

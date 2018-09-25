Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D3FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD55206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE2UwKk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD55206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbeIYQHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:07:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35109 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbeIYQHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:07:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id o18-v6so12975670wmc.0;
        Tue, 25 Sep 2018 03:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zx3gUT9zqf5BPudUt/zg+sujy0Aro/CPMgj6k26BfmE=;
        b=YE2UwKk+xSxjxdvF4jt2vr6AN8sbRSP6DCc3cBnO1Lqkzcqw5lizzBDNakshpkX/zU
         n2vkcvxFp48+QM+lNi1aG4oPkppnl5sZAre6meSRogVWZR0IovFurElOHKhnfq0Zlwd6
         WziUCArPxPFZg37PHP1eWmrclGUQtXq7IKbsvMf/14P0Qvb02d9l+ImBYLpHzIMXgwk/
         pwgzsy+RMaxA1xyWmFi/hhPnJSKO3lkdlH2Ocx3Nmr9Ed0OZneISsbYAEOuacYcbpTxh
         ZZnosUv8REpRPbdakDavMmlpsrCuoY4ikG9qckAB5WhY7Mhg0Hh5pSVog8VjudwGTjAk
         VTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zx3gUT9zqf5BPudUt/zg+sujy0Aro/CPMgj6k26BfmE=;
        b=swFBo7N98H+ZOGcQ6GoIVFyisOoMk8a08rJ1otDM+CPMWUY4FTlyMeGxDs5kgcjefa
         Mt663yoa5Ps3sMmw6pZDFWa7Ku6xbOdW+4tGmohiPC5cIn0s0Q9DM8CF18msaHeB2ASo
         Dl6f9wZOuaRWgdAQZJzrpdIXY1YUZrcGyoM7zza/HhypCRZ2PL9VNHdS/3y4yj7Vp/ju
         ox9oVfzneOO/53Mamr6Ae7PL1xA1f5Iq70SCYqSsfWr3rgKq8syQlEpTWYUbva2WAx/W
         +yTmrNFoh1it4R+MPR7cg4z+u6MTsvWfymmge34EoaVllYR7w155qODqKE4z+URNuESu
         ovYA==
X-Gm-Message-State: ABuFfoiZLTTOw1JHSekgqELV3cNxNq3i1vrej9fBpeZcuO55bFK8L6KE
        CcEQDL1QEAvJjAzZOKZek+mxoYYA
X-Google-Smtp-Source: ACcGV62yqKtHHFga04btFc7vvLkfz1+bfWQEd2W/Xt7D9AWLQhnqPuFBp0jmdCyazkplN8Yto9YIjQ==
X-Received: by 2002:a1c:c44a:: with SMTP id u71-v6mr5809wmf.43.1537869648158;
        Tue, 25 Sep 2018 03:00:48 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id k34-v6sm2567741wre.18.2018.09.25.03.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 03:00:47 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:00:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/20] memory: tegra: Use of_device_get_match_data()
Message-ID: <20180925100046.GD7097@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-12-digetx@gmail.com>
 <20180924101354.GH21032@ulmo>
 <dcf439a0-249c-ff9f-292d-c807a736672a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline
In-Reply-To: <dcf439a0-249c-ff9f-292d-c807a736672a@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 09:39:43PM +0300, Dmitry Osipenko wrote:
> On 9/24/18 1:13 PM, Thierry Reding wrote:
> > On Mon, Sep 24, 2018 at 03:41:44AM +0300, Dmitry Osipenko wrote:
> >> There is no need to match device with the DT node since it was already
> >> matched, use of_device_get_match_data() helper to get the match-data.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/memory/tegra/mc.c | 10 ++--------
> >>  1 file changed, 2 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> >> index 5454ffe5b2e0..cdc33f93cf7c 100644
> >> --- a/drivers/memory/tegra/mc.c
> >> +++ b/drivers/memory/tegra/mc.c
> >> @@ -11,8 +11,7 @@
> >>  #include <linux/interrupt.h>
> >>  #include <linux/kernel.h>
> >>  #include <linux/module.h>
> >> -#include <linux/of.h>
> >> -#include <linux/platform_device.h>
> >=20
> > It's better not to remove these two because the code still uses
> > functions declared in them. If ever we were going to remove code using
> > linux/of_device.h and then remove the linux/of_device.h include, we'd
> > break the build and have to reintroduce the includes.
>=20
> That doesn't sound like a good argument. You're way too picky here ;)
>=20
> > The same would happen if linux/of_device.h were ever to stop including
> > linux/platform_device.h or linux/of.h. That may sound unlikely, but it
> > has happened in the past with other includes. It can also happen that
> > some restructuring takes place in some headers that is not so obvious
> > and then things can still start falling apart miles away.
>=20
> Restructuring will be somebody else problem. Not sure that we really
> should care about it, I think it is unnecessary. But since you're
> insisting..

It's actually a very common argument and I've seen patches in the past
that add includes just for the purpose of making sure the right
definitions get pulled in. This happens quite frequently as a preamble
to some major rework of some header files that would otherwise cause a
lot of breakage.

So I think it's best to be proactive about this and make sure we
explicitly pull in all the necessary headers in the first place,
irrespective of whether or not they may already get pulled in indirectly
by some other headers.

Thierry

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluqB04ACgkQ3SOs138+
s6Hyvg/9EeBObbdVirXsYp8DQaJ68XjG9k0VkZdp036X0ww9pWj9Kr+9A/6dVfBI
SlK/+mFR5/RAHF/b/STNONtdu1TJV+TeeAuaZLfvIsS/KRoTXLpT4eC1kaFAGoun
AH6rC68fNOSZoEmJbfSuAAbEhDLtNV4ITsW7ySwNB2Jn+TFAh3r/yd8WST769wY1
ZULruEX1spgzlK8+ksF0lW4YDIRsb/MdlXgFC02nU4BpnlgaaUDXM16SsTnmVRQs
jYC0WhFIXW+d9rebYDVdky/qQ7Eg5FtGDYXj6KBTGYVYenbB1HmXDm87rFUylIse
mHZkZ3IzIVIOCcERDIc22gL6V78BViU0wfhtmGzpL+YK3BqWJ4TuDYuVuBz5AdGm
NC7p4B+vNu7xULJpKrNgI1oGFmqE+NfyThmNMCoEEAbJ2ZRDrlTiPn6dQrM09irj
NhY7/aCX8XSF8L25GCmZ3KOOlq+/kJdol6or76ON1hKdplvUxWsh2v6XwBOelM7C
UhjbSvBZyTtUoWlly0dEB91Xrqbr4w4WH+Nu/Z2AQU/ue6itkTrwZK2RHF7uiBUI
9X8hu8hO7ZCHgY9k1k/3Wl3S9eJ6lyJ5NI7JpqQ+dVX94H90cO+/+/bRczTLPQNI
MBPx6I/hweSJ99xPdwgwIW1Uy2ce6VVFBclZI3LCpicXcgYKmyM=
=YEyv
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--

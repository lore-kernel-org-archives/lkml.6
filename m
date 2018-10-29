Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB93C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5938F2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbLIXviF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5938F2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbeJ2S7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:59:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37742 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbeJ2S7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:59:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id g9-v6so7984765wrq.4;
        Mon, 29 Oct 2018 03:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kgHZG9vtNBMOKMXgYo0AYmbAIOGaF85PoWqnNo+hD3Q=;
        b=nbLIXviFtMPbxowUItqU6RCb28Pz9iXHjdOXdSFCGd9STyTFpdGFlu3sC5yS1PoWUO
         +X4Gevr7X3AvujfHSJ67L9UTek/UTgVCQP7O9SdN6js+1MKkuCEn9iQ3fUHXQivGjoWV
         tQnsoIqmWvkm/FhjJct4aKNGmQgluhBu024gv8J4yAwfKDyNp8LRy/0DxapOuwV5tcOL
         IFriDEnc/0X5P4nehPZLhfAJTGL5y7QLk53hR32rpaEmH3h7rU51v5cv8qOr+vtN/RNY
         MdwzdrA08teMq0wET1FnIxE0WNxGFgPr51VPvbgF9RArY6Z9uE+JxrS5PRPiZfnwqntq
         UaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kgHZG9vtNBMOKMXgYo0AYmbAIOGaF85PoWqnNo+hD3Q=;
        b=d47MSEpRB1wvc59L09tYs/Y6PCzEkZ6qn2iUytXvOo5Hn5oaE89IIgxR6oIzpRaaPr
         TK6k34XRrzNplc4gk7ELrrqCKPt+AA4QNOXOT00fiUXEr02YivFlGfmDdCGHHvBoREZ4
         DecrEMfwwMujHA57uEcAhgsdVUaYYv1Bo3Xuq8V6Bm2KQ2hv3LMO84yGGhQszrrWAm9f
         Y9emakbMpBcmjT3dcAHjRQZzZzHSGi5tFQsV0IUxmPSQJivYqqH5q4xa1EqoC1DemFRZ
         lwjwg1XPVRVsN6OQi45TC/Vnh3KfGoMZqYy77jCyfGlHOWEe322e+NHcWCaz/u+Q2+wQ
         GKtQ==
X-Gm-Message-State: AGRZ1gK6DC8Fn4+vqByuhok4aCummoQsT+46RhUHqmZB7EMdedunlzv3
        gFVsfsAAvj1P3hG6vUb2br4=
X-Google-Smtp-Source: AJdET5faObUvrcSL0FeShbVBtHIF3MVkgW/7Af6tGIZt4tCDERrNNK7WmSP8Cyiyy1ra7pJAm9KR2Q==
X-Received: by 2002:adf:c00e:: with SMTP id z14-v6mr13989328wre.268.1540807865684;
        Mon, 29 Oct 2018 03:11:05 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id 21-v6sm93509wmv.5.2018.10.29.03.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 03:11:04 -0700 (PDT)
Date:   Mon, 29 Oct 2018 11:11:03 +0100
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
Subject: Re: [PATCH 0/9] serial: Add Tegra Combined UART driver
Message-ID: <20181029101103.GA26393@ulmo>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
 <85092b49-2b62-bd76-05a3-521415835b6e@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <85092b49-2b62-bd76-05a3-521415835b6e@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2018 at 11:04:06AM +0200, Pekka Pessi wrote:
> Hi Thierry,
>=20
> What is the use case for the mailbox driver? What kind of entity will be
> there consuming sent messages and sending messages to kernel?

This is currently only used for the TCU. I'm sure there could be other
cases, but we support none of the upstream at the moment. Are you aware
of any others that we need to take into account?

Thierry

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvW3LcACgkQ3SOs138+
s6FRIw/+Pw2StMAnCWis5xYWoEvtLTttWYsHVBudkqmZVjFV9kcIODJnsRQU49gr
7wF4DlLbvPiA0Z+PzYw9wPYLRYNCmURdzY/o8AovrV5Fh6gJ3duWMSTGOt1XvEt4
17UEFyQKHO27J+IIhLFcLwc+Q+U9CVWX1AFb94o/tFJTdBLp28lkgH+uWR7rkBm5
L7g0Km2x74VTywGUwiuVof6mRwny7V3OqpluT85Ot6i0PXGfGSAZk1RwU12Pi1dJ
CcNnRMx0/f2/bY/f4CJF5kg3vgoLpr45hi8mZS4RqTCOXACnehELzTW2tX63t/nt
o2pp09x//EwgsoXNNKa4FCdbfQw2VgOcl+MbWrmPNXy4XgRp9+N8UX63rNxp3/Nd
ebyeADdTocSv/1hP0khItpIHvWdvyLCCUgqa3jEVV7+qPv9svgFhJ2rXNEv6j6iC
jQR1R4BFwrHyHilDJ2v+yjV1iNGn5qqFaDkaqT+4C+KtgQV8VNrCZ3AFgWAeHznp
biBoVP/1W4vuk46Ssk3JpzQqqrPN29mYPsiU5yKqzrmkPQMLN4UU19q2nY0RPO/i
7vMMdinA2R9UdtWKfkdumNULkwUGN3hdZqMRMqKO+03wxgKPC2oQPMzxFj31T2Wy
mjpYgAPX4JOjlWDO15An5iRykhcz4+XcWmHMUHUqnfT3SURKbS8=
=yi2X
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

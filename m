Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F61C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1781223E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VESjWVeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1781223E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeHJGWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 02:22:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45109 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbeHJGWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 02:22:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id f1-v6so3728488pgq.12;
        Thu, 09 Aug 2018 20:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2aTtoZlwWx9A+faoslYsw8D85AmI5LHatjwTu9bsFo4=;
        b=VESjWVeS3WMUInNclLHNnVL8UGZFgAFG5CjBdcE5TNz8MEiO6HSkGl6m1blnTHT+ip
         3L7ksUypzp3w2TwdsxIIMlrY0Z+QlEHbw9slUi23zXF+pEUmxftNLUkZsd9cbajw61w/
         2I6cA8JD/EXIecoYWal8dk9RngfNOo6oWkEUXovtTGx3d555STbO7QiHUsMdI7t30Wc1
         tORCRwP1tK/y9uFlSUAjIZSw4tmVhvAlnLatjVCRq54jqOl39tUagg5baYRF1LSJ+Xc0
         LbslajXCcc7mr3+sRy0h2QtEtCOFuC3k2wPM3nr+hqa0gAcRP8BCSSG3fV8ysiyJY5dq
         w1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2aTtoZlwWx9A+faoslYsw8D85AmI5LHatjwTu9bsFo4=;
        b=fLz1QAHaTZlWLC5qrIVotDrD4QT4MCNmItugdit8Cbsjm6Ln6Hh0FI+kIP7jaUZCUe
         0om1zxnsCOu0BIaOwpNV2PykVY4Zb2oWNdWQpHRvbrtmMpLw4Mp4+zPSwetBxYGMdvIw
         ELImoqmSyrpVK75OYFrV+uychBBo+ImVKbyVHfdwLD0gJ2oVdgoKeBil/K9aj5dHpVBU
         R+djwWcrfWyGfPHxJvDPLdgbVimJ+ros83Ya+6CIHXUVVa4+CCRJ6exZkFCmrMFihgRv
         w5i5WeSx6ubEvlU+lb3VvcrRkUkao5PzvGWOg0ZmuxGSfdlVMLLhcwMNMRHg3QspUmGu
         zOXA==
X-Gm-Message-State: AOUpUlGvNbvD2EEHm9S3pIXSxQhbJ53EbIcvbtEiFte1nsrsxVtNiZf2
        Nb++hZgPhozaPln+/q4uGOI=
X-Google-Smtp-Source: AA+uWPyk38lg5JQhWjXkJWn0jtB7hWVBN45YApUO0Qb9CLXcI+x1sQ+mKz/cTcOwnJ+J5xGDPV7aJw==
X-Received: by 2002:a62:4808:: with SMTP id v8-v6mr5196134pfa.89.1533873245797;
        Thu, 09 Aug 2018 20:54:05 -0700 (PDT)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id 75-v6sm17077764pfr.115.2018.08.09.20.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 20:54:05 -0700 (PDT)
Date:   Thu, 9 Aug 2018 17:54:02 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Joey Pabalinas <joeypabalinas@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Daniel Martin <consume.noise@gmail.com>
Subject: Re: [PATCH RESEND 1/4] HID: multitouch: add
 MT_QUIRK_NOT_SEEN_MEANS_UP to MT_CLS_WIN_8 quirks
Message-ID: <20180810035402.eb4ljwfdw45jwj5t@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com>
 <958e450a066289c94ba03429166c972c54be6fb3.1530402641.git.joeypabalinas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dmdg6ru22etdixj3"
Content-Disposition: inline
In-Reply-To: <958e450a066289c94ba03429166c972c54be6fb3.1530402641.git.joeypabalinas@gmail.com>
User-Agent: NeoMutt/20180716-169-191348
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dmdg6ru22etdixj3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 01:39:16PM -1000, Joey Pabalinas wrote:
> The firmware found in the touch screen of the Surface Pro 3 is slightly
> buggy and occasionally doesn't send lift off reports for contacts; add
> MT_QUIRK_NOT_SEEN_MEANS_UP to .quirks to compensate for the missed
> reports.
>=20
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

Sorry, my mail filters are in need of some adjusting; I completely missed
the review of the first send of this patchset :(

Please disregard this resend, as I am going to revise it and submit a
v2, thanks.

--=20
Cheers,
Joey Pabalinas

--dmdg6ru22etdixj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlttDFkACgkQruvLfWhy
VBmmOBAAh1q4iN7U17bzBTD0s9+oSqAWnHacb3BHggUCmCLQEB/eCalXvRB+69YX
phzqynXD7Ti3A6mrD3KPgJrTVeMqOv5bHarTL4AUvfsYocQIJ5MDgoJfLQpm6j90
FQfiOIor2V8j4UixPRwfbGV3ArDT5dmwsJB5U2CC7TCg71alYuC2g19FYL+lc+1J
XkJTYUUuJBClVK9ufe/C/wRBGv0HkqX91g+yafB1S9Wsst+WbwItWPb+1k3JWNV4
MkFC89MlbwrvIejNpCR73gm3zfjsoTz8sshJWY/jA0jz+Cn+l46o6bKraWSsjD8S
Wg05WX5uYXEZndMlcdwjvWql0ttCaRlwFxAVIvM/fYt6tq4aiJ8bvqPlx3aKD5bl
GElpQ+iGSMKG1yYyukjthKWI1N4rLTeKz+88oqLNZfwtFuoZousoEc92i+rikpXc
AbDNCjf4xYsPMrDAyoqkROD+Rv+inJ956sbebT2eyuHbhZEdOlvplcpEjlnDa1T4
SDRYiLQ8rXJSmecIL+Z76InOzox35OBa052mjsRQ3oyt/fJ6JBJ95kAp6UmIGhnG
62HQrVL9nlUpEKz5T3tQas4pFz21TEfgPk07pxM3v0Y8K2WNWNJlQWlMCMkcxv6R
lfppJG7jc/HkDXNwEid3euQsBZrhrr0DQayCYxu9t86PKjfTq+k=
=/rvP
-----END PGP SIGNATURE-----

--dmdg6ru22etdixj3--

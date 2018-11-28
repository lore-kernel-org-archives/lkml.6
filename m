Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BC8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D332082F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6fUy9yr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D332082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeK1SDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:03:01 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:44998 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbeK1SDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 13:03:00 -0500
Received: by mail-pg1-f181.google.com with SMTP id t13so9061877pgr.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 23:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OuYkgNH7d+KeIf14OR5GPo6wKsnGRaZzP10vGX4sTh4=;
        b=d6fUy9yr7DnL5+BIl1DAomlOQG0EEXCAHib7Xwfi9MIRQMCnV/ToDTpjEx+4Nuq5F5
         EjJ8kaBk7bQKqaXXhJmJSx/QUcbxq6w4LBXPQZnNlVH+tpwDfYUeqZ0Qunm/B5tXsVE7
         iYWGyIp+ekE1dOvKgd7O7cf+IFxlcJGV3uDqUnJNGry2kxrK0AGiHo7xR1O0mfF0NbJS
         O+Pp5Ws6B0iaRXnjMcwMp9HMOJaErq+qCE8pdz2C34dzGBfDFN6E/QK2Bni0KhS1CV7n
         doKdPDiF0auzCysqE0FQihx/vKmSFqjJxePCA9pAtldhH0pmWjMP7P20IurHUlrOYnX/
         XYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=OuYkgNH7d+KeIf14OR5GPo6wKsnGRaZzP10vGX4sTh4=;
        b=MIqXoSntxJmD2NGc+b/rtBM502BBwfJdHkUSe2trNgahRaXF/wKo8D7upLR1jDas8X
         wdwLZIPblpyJfGcVwn8LzQ3k4+/JC3NvAAQsRJCqum1ocsFnTOj7jA0CDlwUE2v1cDxF
         uFGqNGWtHmrZhrcuOWv9HL3pI+2LjL/nGgwdIAM81NSXx54t1BzZgn1j2xVjLn3B5Uba
         DaOXCfGOshmc8jP0vd9eJOM0CDRBc608xVydrIhZFySF+Uq5XBJQKYHRJ+YB7nj/qDwX
         /0tXzg35rkGO8eKyMknjZi8H9p9zimNHjplGp5ahJr69sbO9p87ftMVSBrjMhQB0BW5j
         yYXA==
X-Gm-Message-State: AA+aEWbnxQuMP6vtpNIYNcbsbDxkuJnhrYcpXunfeL6cq2FGVpQW2LgZ
        EbfZylm1JuZ/yljAd07wx4pkHkOinoo=
X-Google-Smtp-Source: AFSGD/Vu0RFDXlu4iCdQpsu5Y3iT371Qs8GVkEwxouLBr6YUa2dxwWR6s0Wzu2k73/bM/7mafv1ACQ==
X-Received: by 2002:a62:5658:: with SMTP id k85mr25958495pfb.231.1543388543341;
        Tue, 27 Nov 2018 23:02:23 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id z13sm6601520pgf.84.2018.11.27.23.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 23:02:22 -0800 (PST)
Date:   Tue, 27 Nov 2018 21:02:20 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     David CARLIER <devnexen@gmail.com>
Cc:     alexander.shishkin@linux.intel.com,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Little memset_explicit optimisation
Message-ID: <20181128070220.zvjakjmgmt4l6nny@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        David CARLIER <devnexen@gmail.com>,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org
References: <CA+XhMqyP1=WCDGJXbLCpz44fKs0gWbc7a0Bfw2M815mSt4fAxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qsuc5pzhezrzecsa"
Content-Disposition: inline
In-Reply-To: <CA+XhMqyP1=WCDGJXbLCpz44fKs0gWbc7a0Bfw2M815mSt4fAxA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qsuc5pzhezrzecsa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 06:32:27AM +0000, David CARLIER wrote:
> Bad entrance with bad idea I m afraid :-) sorry for the noise.

We all start somewhere, no worries :)

--=20
Cheers,
Joey Pabalinas

--qsuc5pzhezrzecsa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlv+PXsACgkQ2rGdfm9D
tVJueRAAhBHzY0bOGl+xkVuZKe/0La9YiwMdRFwgD5stlIpIRsgkFTmtrIW1R117
oQ2C08fZkhNRxZ56Sy0LnGCY6wM1E2X9qrp0OyHP0c1q02wM0bCJnq6c7GtPZ8/n
m3BUcLyUlVZkXfc8sRo65w9dv8taFeqxe6IXPo4ISIdnpKjV7YHx1cl1Okin/pgo
cTxOxQrp6QjwRSAawelg1NTnC0ldJaDKAWTBUBcpoCojPpNaT9GOs3bjaDgrRn8b
ELGxoxiOeaQpeyBM+MAof+cM+aB/QAGOFriaqmCJYg/Tk1odHBDIpfxRCMVUzb2W
QFoTArJ3r3gud3yVdgfR6iOCCvIEh9sMYDbovC0dMnOPpVLxdyHjRqCFPxJtSyO5
D39DnhlCekC6qjgzC0Qa0rPkQkWo6zXzLqth02+K4k7aMGKhS1LXV1wDVPufuorj
8HF3nAnljVjlomiCwnTLJjh/DXColykMi4MbM6eNYHQQ+oyUsZ1rDZxcYXkVFInp
ZJa1PPQ3zqF4JrCv9bGMORR9FtJJpabGoA3dwGM/gKESynMMJsSwJgxLRBxGLSPx
IsK2Bq+OrKIEnXRfPF5OdYdm0o5fTRmwhj5+grVqb5n2gySUu+i/UTkncbt4SHi5
KuFRQD5wm8oJ8NzgWCXm5IcRVGMBJ90ooi4PxyuWWkVIM8e1RUM=
=2EHC
-----END PGP SIGNATURE-----

--qsuc5pzhezrzecsa--

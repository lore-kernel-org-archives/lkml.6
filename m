Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72303C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC1E2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="TZxRZvR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC1E2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeJEBEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:04:32 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:36791 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeJEBEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:04:32 -0400
Received: by mail-qt1-f180.google.com with SMTP id u34-v6so10927173qth.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 11:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version;
        bh=EvjraW5haBt9bwkn3LoFtF1ULHwmBuCqKJFogcd7zLg=;
        b=TZxRZvR/zP72h3aid6J6Qhpu+BrZ8IN7D8wKzqWLZ1ceq2WaokgsTY2Cm6HAN5NmF6
         a3m1XpLJ9K6klrt3ELLEfvssL3J76ysFF2j8Wf3Hc5vn/4s6dapJ4satZKtijW+eXXhQ
         GEj+QgqnlQW7o+3iF1NwxVBzpVs+0Ijw+pkRuZgR9Etm5Xhs3Ovr7nODIJLyp3952vKx
         PjI43AIHP9ZA2mmC9YO4I6q23MKFRGol+FQWiOlMBcNYv6rOxjQfZo+AuUKf7noHwLjG
         xXVZxQUosW5sRRAGneHc50YW5yiaQE2gKMR0sbqcDpvQZy4DoIvBQ/QCG4zOA7yb8wDB
         2UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version;
        bh=EvjraW5haBt9bwkn3LoFtF1ULHwmBuCqKJFogcd7zLg=;
        b=FT/6PXO/zChG0C/RPTC861C6c3Z3Y6bvJ8kXWyif1w5hP6t5p6SE3B5ATcumk2RcO9
         /rOHSW9f2kthvwP/TV1Ua4DWBtJxtwqoZ6hBO9BkvsoCLoaSYoA9+TPkdgI0sY5Le94H
         Oy5P7cpJGU63i4sqM81pJqlBys2PxBAbm9QRVdmaXTZ08LdKsdde1bkh4SBeaIUs/OqY
         +a0FCs/4AO4TaAig8G8d+G5c+KKDiFJP1ssTsy31iOcPXYkzTLwzMrg3QbOaYyilkNb3
         GGWhrnajInuOQtm/qeOnBHuAAxKBwXdH4Arz5LCKiOAMLeilsFZSDGV8T5AuEUAS85t9
         VwQQ==
X-Gm-Message-State: ABuFfoh5T/sSUu59TSA0cU8D7D6sUaR7GN6vAFDpei91NBc4igvskrVB
        vnppUdAIe81D5xr40XF4/fCHhw==
X-Google-Smtp-Source: ACcGV61egzGS+beCTzDloIhVr6HAex6uBXzXEfSYeycKsVRbG4UWHY/8EUSnAJrav3f4TYYpjU5v2Q==
X-Received: by 2002:a0c:fd8c:: with SMTP id p12-v6mr1488934qvr.198.1538676607488;
        Thu, 04 Oct 2018 11:10:07 -0700 (PDT)
Received: from tpx230-nicolas (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id t22-v6sm2801511qtt.1.2018.10.04.11.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 11:10:06 -0700 (PDT)
Message-ID: <5085f73bc44424b20f1bd0dc1332d9baabecb090.camel@ndufresne.ca>
Subject: Re: [RFC PATCH v2] media: docs-rst: Document m2m stateless video
 decoder interface
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Paul Kocialkowski <contact@paulk.fr>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 04 Oct 2018 14:10:04 -0400
In-Reply-To: <f1fa989b372b514f0a7534057de80b0c453cc8a3.camel@paulk.fr>
References: <20181004081119.102575-1-acourbot@chromium.org>
         <f1fa989b372b514f0a7534057de80b0c453cc8a3.camel@paulk.fr>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-WITFkROoIaAo+RDmdg+G"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WITFkROoIaAo+RDmdg+G
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 04 octobre 2018 =C3=A0 14:47 +0200, Paul Kocialkowski a =C3=A9crit=
 :
> > +    Instance of struct v4l2_ctrl_h264_scaling_matrix, containing the s=
caling
> > +    matrix to use when decoding the next queued frame. Applicable to t=
he H.264
> > +    stateless decoder.
> > +
> > +``V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAM``
>=20
> Ditto with "H264_SLICE_PARAMS".
>=20
> > +    Array of struct v4l2_ctrl_h264_slice_param, containing at least as=
 many
> > +    entries as there are slices in the corresponding ``OUTPUT`` buffer=
.
> > +    Applicable to the H.264 stateless decoder.
> > +
> > +``V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAM``
> > +    Instance of struct v4l2_ctrl_h264_decode_param, containing the hig=
h-level
> > +    decoding parameters for a H.264 frame. Applicable to the H.264 sta=
teless
> > +    decoder.
>=20
> Since we require all the macroblocks to decode one frame to be held in
> the same OUTPUT buffer, it probably doesn't make sense to keep
> DECODE_PARAM and SLICE_PARAM distinct.
>=20
> I would suggest merging both in "SLICE_PARAMS", similarly to what I
> have proposed for H.265: https://patchwork.kernel.org/patch/10578023/
>=20
> What do you think?

I don't understand why we add this arbitrary restriction of "all the
macroblocks to decode one frame". The bitstream may contain multiple
NALs per frame (e.g. slices), and stateless API shall pass each NAL
separately imho. The driver can then decide to combine them if needed,
or to keep them seperate. I would expect most decoder to decode each
slice independently from each other, even though they write into the
same frame.

Nicolas

--=-WITFkROoIaAo+RDmdg+G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCW7ZXfAAKCRBxUwItrAao
HN+lAJ9mLHnynjV7/5/fV/twzlfr93Ny3gCfQWLpOzVsima2HI6MxxdFSOCBSBE=
=qB0v
-----END PGP SIGNATURE-----

--=-WITFkROoIaAo+RDmdg+G--


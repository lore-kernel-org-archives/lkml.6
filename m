Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EFEECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF44A2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="UfAewaHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF44A2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbeISVcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:32:01 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39794 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732164AbeISVcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:32:01 -0400
Received: by mail-qt0-f194.google.com with SMTP id o15-v6so5544406qtk.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 08:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version;
        bh=PzdaszGHr6Pq2TIiOA10NDQddYPGriTL6ZHRWZqhFJc=;
        b=UfAewaHaPgQHMAF2hFGIXlZdgZK4Dj/5t8ZsB1ss3ACopyBrgjyO3tnAxEhQVLpVF5
         pEJbMnCSnH9pRmc3DpKxDk7CWLeTBuS3DvfK5+TrtIhfdpACyD2Q+qMkcknIsyqdZhCv
         RHHkPjRKZL1upz24t+dQl7diqqJUezRJX17pM/Y+GTlE9qI8uxanooONFQkWmpXasQ6R
         pa72kiO8Wfk1ef8GwQ6TlyiSGIGCsG+xB5s5Gy7Q7IJoqDM0vFpKsjuNB38k2IS1Kj1R
         s5QuO/SLJpxCrw2NNma81RgyBXTVwoEYx9xoWWTn55ocIZliZVFnrDt4xubPqdq7NcqM
         NHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version;
        bh=PzdaszGHr6Pq2TIiOA10NDQddYPGriTL6ZHRWZqhFJc=;
        b=pxodIITh18wfvKoARAX2QjyvKfHvoONNMpmYfHXxv55gAD/OBuom7HMzGTUuyQoZBo
         tI0JoUo/dYiYywzmoRahZC66c/VUPpg2o578j13dboqgX8KuOFHRhTMJeW4IbbXhEB0c
         mfEyvKYBPBDn7Qc3IVheRMSMHsv+w+ZtZ4EXn/LxWaGd0IDn0rVN/mpfk88hBeYxlgDY
         Y63/J2d4V8miYnoMk3HAYNoflZDgRwMVfw8F/TbpTe4UTaes+2c0L65Vs8uDoRUQKcN/
         1BcYXziWaM3irChBHEw9Uh6BhO8vWhUvBRWkdMGWK68gW2OQVS8HLE4oK06xRExpmDi9
         pqLA==
X-Gm-Message-State: APzg51DSQTD2lI77mr1LfP+QkV/XcRANzZdA7J6ztQp0elp2GmdS3Ohc
        2lWu66tulOWF+l6X+cRz8iAH6Q==
X-Google-Smtp-Source: ANB0VdYHSPCZWqpA7WLTYfSTbLqbQNmqYbK0plESUP2TboCLVIQG7NxXzUJ2T0Fzj7kiAL6D4aPxUg==
X-Received: by 2002:ac8:259d:: with SMTP id e29-v6mr25464887qte.233.1537372407840;
        Wed, 19 Sep 2018 08:53:27 -0700 (PDT)
Received: from tpx230-nicolas (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id r17-v6sm17111263qkr.78.2018.09.19.08.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 08:53:26 -0700 (PDT)
Message-ID: <bec2edfda26ecbac928871ad14d768790e3175a8.camel@ndufresne.ca>
Subject: Re: [PATCH] venus: vdec: fix decoded data size
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     vgarodia@codeaurora.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 19 Sep 2018 11:53:25 -0400
In-Reply-To: <6d65ac0d-80a0-88fe-ed19-4785f2675e36@linaro.org>
References: <1530517447-29296-1-git-send-email-vgarodia@codeaurora.org>
         <01451f8e-aea3-b276-cb01-b0666a837d62@linaro.org>
         <4ce55726d810e308a2cae3f84bca7140bed48c7d.camel@ndufresne.ca>
         <92f6f79a-02ae-d23e-1b97-fc41fd921c89@linaro.org>
         <33e8d8e3-138e-0031-5b75-4bef114ac75e@xs4all.nl>
         <36b42952-982c-9048-77fb-72ca45cc7476@linaro.org>
         <051af6fb-e0e8-4008-99c5-9685ac24e454@xs4all.nl>
         <CAPBb6MVupMsdhF6Rtk4fm8JeVurrK+ZsuxAQ-BwrTzdSP1xP0Q@mail.gmail.com>
         <6d65ac0d-80a0-88fe-ed19-4785f2675e36@linaro.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-RGb6Gp4tD6j4myXgFZQA"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RGb6Gp4tD6j4myXgFZQA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 19 septembre 2018 =C3=A0 18:02 +0300, Stanimir Varbanov a
=C3=A9crit :
> > --- a/drivers/media/platform/qcom/venus/vdec.c
> > +++ b/drivers/media/platform/qcom/venus/vdec.c
> > @@ -943,8 +943,7 @@ static void vdec_buf_done(struct venus_inst
> > *inst,
> > unsigned int buf_type,
> >                 unsigned int opb_sz =3D
> > venus_helper_get_opb_size(inst);
> >=20
> >                 vb =3D &vbuf->vb2_buf;
> > -               vb->planes[0].bytesused =3D
> > -                       max_t(unsigned int, opb_sz, bytesused);
> > +                vb2_set_plane_payload(vb, 0, bytesused ? :
> > opb_sz);
> >                 vb->planes[0].data_offset =3D data_offset;
> >                 vb->timestamp =3D timestamp_us * NSEC_PER_USEC;
> >                 vbuf->sequence =3D inst->sequence_cap++;
> >=20
> > It works fine for me, and should not return 0 more often than it
> > did
> > before (i.e. never). In practice I also never see the firmware
> > reporting a payload of zero on SDM845, but maybe older chips
> > differ?
>=20
> yes, it looks fine. Let me test it with older versions.

What about removing the allow_zero_bytesused flag on this specific
queue ? Then you can leave it to 0, and the framework will change it to
the buffer size.

Nicolas

--=-RGb6Gp4tD6j4myXgFZQA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCW6Jw9QAKCRBxUwItrAao
HFjZAKDRumEFmZk46/FnEsuGsQ6l9tC3ewCfeQOroYDAPOBtlLaONtwjkz7IAgo=
=7Xsu
-----END PGP SIGNATURE-----

--=-RGb6Gp4tD6j4myXgFZQA--


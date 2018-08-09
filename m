Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E649FC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9057620BED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjW9H4xO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9057620BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeHJCYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 22:24:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44653 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeHJCYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 22:24:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so3479778pgp.11;
        Thu, 09 Aug 2018 16:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F9/cSg/a76zyU458uUwqrFT6/n70D2cBl6ojxuv4GcA=;
        b=XjW9H4xOfmnSffmdIPc57uMMIxCCckSA60FnY0rIxyKq8ETx7gAyC8pY6TAug0XEQf
         sCQfbFyP2xgNP7fjCnUU4Jjx7G4pLh5Ne2Qa7NIsD30dNk8K1wl8+AIjWLum+OGY0o2G
         uqymtyg1YCxSKNIP70IIXgcNooMudieNm5w99sD6KWE7GdDVAqna0TSOZETdpXziOJFi
         s864OUY0EpIVc32elINRITZYwU2VW/TPoYiQPbNeEutJGCGf3HUf9Ch53inK97QOct1K
         oOPk3vFaJE3sYwVgndVHftiL3s71FcGvKIMEzeQW5a6592tb/f7Vq9jVumMr8bthhhGZ
         LvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F9/cSg/a76zyU458uUwqrFT6/n70D2cBl6ojxuv4GcA=;
        b=RCqxgNhtXCDZD2rLtnQtfKBS13jFINFFmI5qhs6bZEMcqD08Y27piYblerWz/2/kHq
         9VCJwzHYjX568kA3FfXKcSO7Sdc5tPIuvTLXGnQc2qw49HleqB2bqRxaA4C6y32jd+px
         ix5NdlXZsNLJ8Axl1UX6NFIodhcLOFWNNabDdFsAjcfz8hCyh4CxrRqtt/bJF3dBNB+l
         iWr1EGuO0y/PDKHfcfW4827LqpzreeBmSZ4Z1QY2cPnebekexLbNooxw1MuyGm3CTKHl
         yMnPnnm7RLdzQwygCNOkh4SFXSNWcALr7lJh9wEGGk9tHBHcHBSW7OKrZgfOWN18s+t4
         zoRg==
X-Gm-Message-State: AOUpUlG+tIPBX/vg1R1lk49y6WVyFZT733AU3j7H341Sda457LaZ2QIo
        CD4atsllXfs4+yfCpFptGBY=
X-Google-Smtp-Source: AA+uWPz/5gLQnG3vrL9l3qsnJcgAItVtQjgEbH/Qkq8DU3tE1N8Z1DnoTkFuST3QWFWHgpeH3BYUfw==
X-Received: by 2002:a62:5047:: with SMTP id e68-v6mr4492951pfb.157.1533859056991;
        Thu, 09 Aug 2018 16:57:36 -0700 (PDT)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id b195-v6sm16557926pfb.2.2018.08.09.16.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 16:57:36 -0700 (PDT)
Date:   Thu, 9 Aug 2018 13:57:33 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Joey Pabalinas <joeypabalinas@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Daniel Martin <consume.noise@gmail.com>
Subject: Re: [PATCH 1/4] HID: multitouch: add MT_QUIRK_NOT_SEEN_MEANS_UP to
 MT_CLS_WIN_8 quirks
Message-ID: <20180809235732.oecx4jfyzerjgsvu@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com>
 <958e450a066289c94ba03429166c972c54be6fb3.1530402641.git.joeypabalinas@gmail.com>
 <CAO-hwJ+1PEH7VJjQThoihqBUK0yVNvak78GEiAZ7VpDEQ5EFiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yhxhrwftljtjapwv"
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+1PEH7VJjQThoihqBUK0yVNvak78GEiAZ7VpDEQ5EFiQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-169-191348
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yhxhrwftljtjapwv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 09:53:19AM +0200, Benjamin Tissoires wrote:
> NACK on this.
> If the Surface has a buggy firmware, we should handle it as a special
> case, not as a common failure.
> Also, I am not sure this quirk is compatible with Win 8 specification.
> Last, we now have a timeout for unreleased touches, so I really don't
> think you need that in recent kernels.
>=20
> Cheers,
> Benjamin
>=20
> >         { .name =3D MT_CLS_EXPORT_ALL_INPUTS,
> >                 .quirks =3D MT_QUIRK_ALWAYS_VALID |
> >                         MT_QUIRK_CONTACT_CNT_ACCURATE,
> >                 .export_all_inputs =3D true },
> >         { .name =3D MT_CLS_WIN_8_DUAL,
> > --
> > 2.18.0
> >
Ah shoot, I had completely missed this reply to my earlier patchset, I
apologize. Now that you mention it, I think handling it as a special
case would be a better way to handle it, so I'll do a bit more research
on the quirk thing and then revise my patches (assuming they end up
as something still worth sending). Appreciate the comments, thanks.

--=20
Cheers,
Joey Pabalinas

--yhxhrwftljtjapwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlts1OoACgkQruvLfWhy
VBmoMQ//ZIPrFEFUd828MQXkNcaoq89nPWA2T8BYlTs6MHI0wcPoiCGUrXEp5Goi
FUpbPb9hB1Emq4sdhNbcKRf/g5S2uGcaHfIeJESCX/VWumODzf6pIKIjFyZTly/Z
loKL83bFWC+k3b/gnf0mShRGVmlbWzQsL/A4l0UaUuCkVDbMkKW7l45iUMOCGU4W
so9BkC2L3+1KRqjDUmizsvz/bUC6uGzL+LO0YFDtlHwxHCV9bp+9XfVhXbpOum1P
nepAkRYK41240P8Dtbg0GJ1RrHIdKdEkApkwjeqlUIZ4uAoDyiEGb2+NCpKKQ5Pp
OrE/OKkHgYbtw0FVK+y03koLP/Q+xWE5MrRnfgYHgnynOJRDEN3beknetf9MbcCP
OAigw5ufbWsn5MW5yjJ7CeAO9nnpMj0FbTMV+NZ1xyJRNBbBYMoG1vGKak8Z5D7c
h21Z115DW/Z1GwK3sJc7Zwllm4an+V6pKCmNz4W7JZCyxNt7NSUf1MbWy4T5sQhn
YNSKYI9jPbywXlOfvoE5USHOKRdQEep5oQKb7rXA6lxKCye60Em916U3AXpsH6bC
hfFeisrlM2l+Eg1yFCsX/CzxpChP1nF1OUk/wVG4lIlYYDLIQW/RAkHRJrMtXov/
Uq7dNSBK9CCS9H3pRn7eqq9abeAVxskRO+TFn3pupUkUm4ps9xI=
=g4uC
-----END PGP SIGNATURE-----

--yhxhrwftljtjapwv--

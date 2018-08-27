Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50C2C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B3A208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQS79Wcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B3A208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeH0N56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:57:58 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:44606 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeH0N55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:57:57 -0400
Received: by mail-wr1-f52.google.com with SMTP id v16-v6so13064229wro.11;
        Mon, 27 Aug 2018 03:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qPuVfga9AqN45CSMe68RdXFUYtDieoC9fvNgpnHKvHQ=;
        b=bQS79WclbFs7AjN5nMJgOo/DJ8abCcwEtgrEYvQiEQzmTkr5KPLneI5XFgiNSoYK8z
         zVqQnlNP7I799vgA4H7XNPVyUbIf81/Po5qWS66vLQlxzmATZ5aW+P1gVzFhJlymvwnL
         Bj1g19MK+lCsPvia+wAr9WoC9GoX470EAJsNxpHz6ejVATBwFsWhqwKGnJy+TcxHEHNb
         kElJR07ZpmG8oXPihmT+RaqaQMvvoe66OH3uED3harDIRNF3npL5rBgIUkd6B/YoP+yP
         v/kdvVgpVwAJlAss7b99eORw91EkpzzqdcKxzZals8XS92nKYST8UkBkh/Tw/a0g+Dev
         QxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qPuVfga9AqN45CSMe68RdXFUYtDieoC9fvNgpnHKvHQ=;
        b=PC1CGq3CqQxDKPu8C2KNaNewGnkHt58yiuT+es6mFnuUwtdVEAksBvIbezCrNRTupl
         5IyixSPIzC3N9RZX9PiBuFxZgk/UjRDFzFklJ6/G8Q4JiFO/ZYHXHuXr1tr/TXX6qhvo
         TEiEEpZs6FXCR8XgTnQ33KTG0td35+SFenWAUlbVr3fqsOEGh3Zk4s0QkDXNtDwh42Jx
         3SZ4puRZ5CmNSb03d9IvKnnvPEsMHyXQyBQAKjpeOrEz2Cia9Mirew4MqgFt41TtEwOi
         T1RrIkfPXjLxwgcpSxMP75K73e0/QhiYfV3I62QlR3064o8VKMdaMg7+jzvbkO+livzX
         yRvw==
X-Gm-Message-State: APzg51AXwE9uGIo72jU+j7s2drhn+WERYvh7sSP4mDMBPNMew43Ygrgr
        tk+AZYAxAM3YVUTiTuzDMmFoV7YF
X-Google-Smtp-Source: ANB0Vda0Uc54lK/zX4R/nUA+trGJ/X9n/uO1Ihrsv9hr9sZomag+yfpT4pxnYHAEZVdnm09BioSNuw==
X-Received: by 2002:adf:e486:: with SMTP id i6-v6mr8288463wrm.145.1535364714568;
        Mon, 27 Aug 2018 03:11:54 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id x125-v6sm10140301wmg.27.2018.08.27.03.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 03:11:53 -0700 (PDT)
Date:   Mon, 27 Aug 2018 12:11:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Aapo Vienamo <avienamo@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: Export sdhci_request()
Message-ID: <20180827101152.GA19520@ulmo>
References: <1534757013-4524-1-git-send-email-avienamo@nvidia.com>
 <1534757013-4524-2-git-send-email-avienamo@nvidia.com>
 <CAPDyKFrxMWBisB5uuhFjxosExJx5cqLnTLE5Eoxp5LVdFk_43g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <CAPDyKFrxMWBisB5uuhFjxosExJx5cqLnTLE5Eoxp5LVdFk_43g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2018 at 12:07:08PM +0200, Ulf Hansson wrote:
> On 20 August 2018 at 11:23, Aapo Vienamo <avienamo@nvidia.com> wrote:
> > Allow SDHCI drivers to hook code before and after sdhci_request() by
> > making it externally visible.
> >
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
>=20
> This one happens to be useful for other variants but Tegras, hence I
> have applied this one for next. Thanks!
>=20
> Thierry, you may thus drop this one from your PR. Also, you should
> probably base your pull request on top of my next branch, as I have
> already started to queue up some changes for sdhci.

Will do that, thanks.

Thierry

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluDzmgACgkQ3SOs138+
s6HJMBAArzWv4Ra35OlaCrF3Md8xwNK5WJhNrGaR/yk9G/UX6JcU9wuwSarV1DPc
WfuzF5iZzDqUdQTMGKugrNmDAzu+rtTdM0IaUcciayVh2tJk2DMreMiEpvembtT/
ta/6p69uKnxbyke/mN4nMIFfT2sQlEprb6LJf4YHn5DluQ8eylH8plXMDRLyjlgS
bzvvyAMZfTYNGJNSVFOmYOfOx1Z5QbevVp0+ksWnNiAO5TSr33LP+TyNoQOwGyao
vhT4o2DN1ZtVzwbx8WrNZFr5JBQijfw/9mqTroi9vJlK4eFnn8scZL+I9K1Cg1hw
qWnjSiwQAhayGV8eO7/OK0IZpaXTMKkPd44XftYBj5hUMoTbfUrnfh7Myka5zJeO
s2LM/LVqONPqaH1pjCg/UGwJY1EyzjOLtkoYdG4KRMWMq3Txwcwibff8LlMEk468
5ah5Libu4U/505eU4535F04Qfg8yzLcPn5JpzKVGwte2hNdekwJIDvqYWlxnSVcq
BH6gVOrRn5J8XLSd1LyxwZ0vALwX/GcfVEXllAVMywKRqDxpZZgq3bbLDO/tDtbK
1UTn0qEFGdlE/rdVkBZiOHZ6hxcE60wK/JCIhJhXi21vizUt4/qWj4EaUh08LDd/
wuXE0xtP5JteeL5XvUKzXKxZgebv3DdhriwwgSz6Rn6ZBYY56YM=
=R8vG
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

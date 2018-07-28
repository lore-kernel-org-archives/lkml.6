Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A97C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 18:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7117B20878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 18:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VLL3W1iP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Suh3RCea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7117B20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbeG1USR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 16:18:17 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60613 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730356AbeG1USQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 16:18:16 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 9D6B021BCD;
        Sat, 28 Jul 2018 14:50:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 28 Jul 2018 14:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=WSatdau3OCAiFUnwXJvK+tQrJMHPXjclAGIh+4ndfBA=; b=VLL3W1iP
        /gdxEA/cpf4LeFoMVKMFeQVO6TIEkY8Tq8k9vYG8Ytq+kSzi89yBm19OpFs6LaQv
        fC5xfbS8tPWnHcIuP0nGkH6JtX0KajkPN4oWlRBD66ynES6ZzEiISwEAShVVFdSe
        BtKvMqybcTSAwekhW+8Pt3rI8tCTXO66boPVcNElgVzeiYfH2ZGeq62BUnKEeKIH
        XxGKPhSyNtrnYbkzVWKoENmEc+NLCCs78cFuBf+xFSXuWTesN+AOIHYgLbnGHxkm
        1DaYcPUZs14VWu0QVezFF2TaIrfUrsMIn5HfaBv+HUc1KR/FQBCS300i23bEhZmU
        QMosKlYdIASOgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=WSatdau3OCAiFUnwXJvK+tQrJMHPX
        jclAGIh+4ndfBA=; b=Suh3RCeatnk9RIHWnz7b5Rs54AaEVgs/J2dwXtYpIulod
        LgM4tdVCCgfD6oqdAi3nu2g4tnmy9fR5kS/+uhiQOIyfZz9uBYY6ck5KZGNV7KBg
        8/jeNf8yQOKqBHw4Xy+xnUpash2x56MRL2LT+RdHrTJjxtRMiwO09x5gbxjJLDFi
        Zyu18ZHaLbBzO07qcXyKXZshRG2VbD74wkUPzhMoIRmgtKPmkTt1udIrvFreaajH
        MwsMwQ085WIRqGELbTom0GOU+anha9urFsRsLKriz3uiJUzzz/ejJ6ZMELDWeAwQ
        A2+T2l39fF1zZ1hAIcDPRGqkIMqGStYxrIN9PV6sw==
X-ME-Proxy: <xmx:C7tcW31bhaluzz0kOLGQUx3R0hyuY8l6nrMFfds6Bf5ObO1L1Xuhmw>
    <xmx:C7tcW2Q4f-_h4VrpifsOvAfBZVJeW6W1cfsT3hA2ggP5y0zJ4DN23Q>
    <xmx:C7tcW5sj3yGhxsBhvHvjyPu7SUpBv-xLEGweupLnz05COqKhifKHYQ>
    <xmx:C7tcW7boqQx61iZCVv9sjad1__mS2No10eaVzmALePBcAbGGUw21vg>
    <xmx:C7tcW-uEywSCIbQNnnRfuts_uN9XdZE3pC9M-whAZcqzHPCn-sXdbw>
    <xmx:C7tcW5Mxltl269Ey2iko-USpBobCbcw76hIxhU_mUcARoom66dFYKw>
X-ME-Sender: <xms:CrtcWxj8mxaQXDANLZQxG_yzf4lZkoMI84BSTXvsdN6HekQuAlB0zQ>
Received: from apu2.pks.im (x4db48333.dyn.telefonica.de [77.180.131.51])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1CC8B1026C;
        Sat, 28 Jul 2018 14:50:50 -0400 (EDT)
Received: from localhost (10.192.0.12 [10.192.0.12])
        by apu2.pks.im (OpenSMTPD) with ESMTPSA id d019219f (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Sat, 28 Jul 2018 18:50:48 +0000 (UTC)
Date:   Sat, 28 Jul 2018 20:50:49 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Message-ID: <20180728185049.GA1663@xps.pks.im>
References: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
 <fda284b59b2401d3d44a1343f809b98a8ae69be7.camel@wdc.com>
 <20180726083850.GB1674@ncase>
 <62ddc886d005b91bd6a1bd8775259bb0b5cbe2b2.camel@wdc.com>
 <20180727123533.GA1588@xps>
 <6f00aeea242c20be1e2709bb00d27d79a8a8facf.camel@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <6f00aeea242c20be1e2709bb00d27d79a8a8facf.camel@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2018 at 03:03:09PM +0000, Bart Van Assche wrote:
> On Fri, 2018-07-27 at 14:35 +-0200, Patrick Steinhardt wrote:
> +AD4- +ADw-1+AD4AWw-   53.411700+AF0- BUG: unable to handle kernel NULL p=
ointer dereference at 00000000000001a8
> +AD4- +ADw-4+AD4AWw-   53.411733+AF0- RIP: 0010:blk+AF8-set+AF8-runtime+A=
F8-active+-0x2d/0x50
>=20
> Are you sure commit 4fd41a8552af (+ACI-SCSI: Fix NULL pointer dereference=
 in
> runtime PM+ACIAOw- December 2015) is in your kernel tree?
>=20
> Bart.

Yes, I am:

$ git describe
v4.17.10
$ git tag --contains 4fd41a8552af v4.17.10
v4.17.10

I've also manually verified that all changes from 4fd41a8552af
are contained in the sources, which they are.

Patrick

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAltcuwkACgkQEXxntp6r
8SzWcxAAo63TnLCelq2Qiiq8IhRmVpxmleOBbyoIjQp3aDailcssYYHlZx+kboC6
Sp660kZM6cihgb+13vecYE1+8kkQB4J7LL8eTSKviMFNyvjmFC55/DgBgbhKSTz9
JU5eBc4XOvEoTNC5rc25XnT8PbsQ5RezcjrG+6JNQjdHwZQqe24uc88aUhtSWT6C
p3REL2qUR8FOhpM1qoDfML73sXFQMc0defJFAQOrW9gd412qB3TJuNkNa7p5ezp2
NPN7yQ38bMHb7SP30VfyodL0gIL7LedrwzZFGUEXdTdUEgFlth98+7MXcrLV5lNc
bImL6K/t4jJmsy4OY/odt4urte2o9YIUvgXi87J1W7n5dl5K9okFobiGjLvSrTcq
NWDihpUEC8el2bK6txcMiXyGip7B0nr77YYZxALbd1cgJHAhK3mTWnjLN3wvGYDy
3NNVlpeDQ0F72p2tldeXosUu+wFdN0kowLXQLfnmIRn6rbBOnQ9231Sjx0EYa62t
2vEAJV8y4QGjaOBXTh6WycqvjAZdxkIxkZK+57BM0fYGZFHApfVvS+FJ/j81mFJm
Iis2VJYhPXUw+4Abbswn4mURFzznKE8Krz/emfXt+r/58OTbXGxjLt8mtbASTwOy
HDmEELKXUktzqY5W6dOOfevqpHn0ZXSes5yR61cjWcVcyaFH5h8=
=luaM
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

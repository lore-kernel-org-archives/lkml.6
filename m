Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CCBC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB112064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vDrH73g5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vypk0GlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB112064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbeGZJym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:54:42 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51743 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727951AbeGZJyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:54:41 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2C58B21BC4;
        Thu, 26 Jul 2018 04:38:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 26 Jul 2018 04:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=4ekUqyLJStahilE68pMYFsFGMSSdqs15tdAM6z0/o4U=; b=vDrH73g5
        ufYbGYH8s0xoWKymY3RYVRKFpcNe88np2Rh8YCyf110FxjqY9ko0Rxx2U7yoaFU5
        sddF1FfCVrl62A47Rdg1uv81lRvvp2TvBviIx5hsIcb/axDEh/zBdC/VaVjS1Yt6
        mbjVKvNEGWXhnO49mToJqJKdIrM8tyxpSDSjjQvLUvEA2T4gl7tmc0TDvU3l5rje
        1br0ipcbIJlIK6XISwqyasgmHrHv2l6H1/E3+nmjRYoqZtewC4tkSfiEIbxVv5xm
        0rRkrVsVHpw10EW+a2EgTl8kly7J4O3Zwma5lE3qigZHzjAw4Kz5zKip0R6cNNlg
        0C7inKzAE0ut4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=4ekUqyLJStahilE68pMYFsFGMSSdq
        s15tdAM6z0/o4U=; b=Vypk0GlJ7HyiH2hgt2Nyyuu3+oOm1GA/v8rvUeCwksFiZ
        67uT6EcIA45k+lI/LcKh+KhHCiARTvBnkfzDy5180yglSM3aiZb0ooR9nR3Agzvn
        uzaATLXb+PbKwLLZ4ks8LtUiXOoNWmaUKV1wrvYzH6JmTOOfRRLfEX1WueyiOCx7
        A1a6AZvcAldDkzBULB3T7U+8MRMB0R4JhMqpXZZ+geHWe4rGCP1u5RCATTM6uEck
        MdsXF4rXe4/Xr9l2S8ZGPiv23+eYnhZ1dfHfxd2Mrr/eeiEKdo1ckvHIh59VTuPn
        TGhpt8r3fMzE15/rqSF6Yb2+wUy7OQXK2+sBCRMlg==
X-ME-Proxy: <xmx:nYhZW7nvyG7VQYcDPNkTMfQxQ362lCAMiOOXm2V-k6Efdrcc4qX0Ig>
    <xmx:nYhZWw5OK0x619wWbyJ2ioXPMaXzWLNXRKlxxqefk44S2IJgWYMO9w>
    <xmx:nYhZW7sX5OK9jtBhuRnQrDzG5OB_9lHx0x5BMXy577IgwOYVazehKw>
    <xmx:nYhZW-QHfZja3zrBuPZZS2erPjO6jNA8AB-k8zmmPFrTfJUe1blPYw>
    <xmx:nYhZWwhe6N4tPrRqPLmLMFKGhpuuZtvrsSjL61NLbUU7Epe7KHIPww>
    <xmx:nohZW0Ja8blA6L6OACh1H6Eb6bJXmn4Hr3ygi6gCynDlOVHyMRWvGQ>
X-ME-Sender: <xms:nYhZW1NSaJOG1n6eKzTABt-UnB2ghI8eeKE9W70bOO6X1PGXHkyuSg>
Received: from apu2 (x4db3c632.dyn.telefonica.de [77.179.198.50])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4AC46E491A;
        Thu, 26 Jul 2018 04:38:52 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by apu2 (OpenSMTPD) with ESMTPSA id fef725cd (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Thu, 26 Jul 2018 08:38:50 +0000 (UTC)
Date:   Thu, 26 Jul 2018 10:38:50 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Message-ID: <20180726083850.GB1674@ncase>
References: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
 <fda284b59b2401d3d44a1343f809b98a8ae69be7.camel@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <fda284b59b2401d3d44a1343f809b98a8ae69be7.camel@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 25, 2018 at 06:13:02PM +0000, Bart Van Assche wrote:
> On Fri, 2018-07-13 at 15:29 +-0200, Patrick Steinhardt wrote:
> +AD4- When power management for SCSI is enabled and if a device uses blk-=
mq,
> +AD4- it is possible to trigger a +AGA-NULL+AGA- pointer exception when r=
esuming that
> +AD4- device. The NPE is triggered when trying to dereference the +AGA-re=
quest+AF8-fn+AGA-
> +AD4- function pointer of the device's +AGA-request+AF8-queue+AGA-:
> +AD4-=20
> +AD4-     +AF8AXw-blk+AF8-run+AF8-queue+AF8-uncond:470
> +AD4-     +AF8AXw-blk+AF8-run+AF8-queue:490
> +AD4-     blk+AF8-post+AF8-runtime+AF8-resume:3889
> +AD4-     sdev+AF8-runtime+AF8-resume:263
> +AD4-     scsi+AF8-runtime+AF8-resume:275
> +AD4-=20
> +AD4- When the SCSI device is being allocated by +AGA-scsi+AF8-alloc+AF8-=
sdev+AGA-, the
> +AD4- device's request queue will either be initialized via
> +AD4- +AGA-scsi+AF8-mq+AF8-alloc+AF8-queue+AGA- or +AGA-scsi+AF8-old+AF8-=
alloc+AF8-queue+AGA-. But the +AGA-request+AF8-fn+AGA-
> +AD4- member of the request queue is in fact only being set in
> +AD4- +AGA-scsi+AF8-old+AF8-alloc+AF8-queue+AGA-, which will then later c=
ause the mentioned NPE.
> +AD4-=20
> +AD4- Fix the issue by checking whether the +AGA-request+AF8-fn+AGA- is s=
et in
> +AD4- +AGAAXwBf-blk+AF8-run+AF8-queue+AF8-uncond+AGA-. In case it is unse=
t, we'll silently return and
> +AD4- not try to invoke the callback, thus fixing the NPE.
>=20
> Which kernel version are you using? Can you check whether the following t=
wo
> commits are in your kernel tree?
>=20
> +ACo- 4fd41a8552af (+ACI-SCSI: Fix NULL pointer dereference in runtime PM=
+ACIAOw- December
>   2015).
> +ACo- 765e40b675a9 (+ACI-block: disable runtime-pm for blk-mq+ACIAOw- Jul=
y 2017).

Commit 765e40b675a9 (block: disable runtime-pm for blk-mq July
2017) was indeed not part of my kernel. Back when I upgraded to
v4.14, suspend to RAM on my laptop was broken, and a bisect
showed that this particular commit was the culprit. So I reverted
it and forgot until it bit me now -- so it's been my own
stupidity. Guess it serves me right for not checking my own
changes.

That still leaves the other problem of broken suspend. I've just
checked with v4.17.10, and it's still there: as soon as I resume
=66rom suspend, the kernel oopses and reboots the machine. I guess
I'll have to do another debugging session and see where it fails
exactly (and no, this time there are no more changes to the
kernel tree).

Anyway, thanks for pointing out my own mistakes.

Regards
Patrick

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAltZiJkACgkQEXxntp6r
8SxRLxAAkU9UD0v0U1ouRCJHoMGtpVRGWAn6pv6QpDIZnWbn8DsD8wgwnnRk2Mt+
2hiiqgLaSO21+gTYEefzV++cjUvkCpyTNHvCoPyRABNN18UUCUDlzhApZyaUWdKp
c/uGV+ihMYTFR6mzNpfWmhqKMdtZ8z+KyY1Mp8GeLco/oovF1x7yw0bn287s9WAO
GJI9K20ZBrrMPBMKKgvDJlKlshrTEkqKGAAqNuXtwz4FlsPsGBav53TveKP2ZC1g
V3rzTpRJTCf0MkUb5MyWB0mk92K7jfZSEY2ez3pPtuF+BTi2vCzk2lIK1aDeH6iO
CldlkO6pF8jI+vHAJyu9T7iQ+rVroEndFrHENLsgKYDgkuSanwaoNhQ4H8M0gqaK
B5E1ivQ8pX7h58qH76k7PNVsgZxkBPlpngYMLSjCIOa81UzhR3gjlQoAflebACKj
P2bghMWNGTQHibimQ3vYzvvUIZgu659TiB7hTE6Ro3stclm1sYrf57+dpNm9bZMi
HlVieiMCd8PhefMJwbpbdbwFvA22Yko9O4uHdFrnNKD5fMoKTFQqS+4uDO8xI9ns
DaGwwmJnqg8h0edZ8zYRX7fanq4B7dhO+tDhRTtnp1+a0Lzs9ztWwB8r/m4jCWx4
15fBeaH9S80Fq0qyXIAMemiz4dnjtxoZa5J5/VDQQmD4C4UzM1M=
=3P1z
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--

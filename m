Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1068EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B979621471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B979621471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeISDva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:51:30 -0400
Received: from sauhun.de ([88.99.104.3]:46150 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbeISDva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:51:30 -0400
Received: from localhost (mue-88-130-102-194.dsl.tropolys.de [88.130.102.194])
        by pokefinder.org (Postfix) with ESMTPSA id 50C862C0590;
        Wed, 19 Sep 2018 00:16:47 +0200 (CEST)
Date:   Wed, 19 Sep 2018 00:16:46 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
Subject: Re: [PATCH] i2c: i2c-qcom-geni: Properly handle DMA safe buffers
Message-ID: <20180918221646.GA970@kunai>
References: <20180918194126.138455-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20180918194126.138455-1-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> This fixes a problem where the kernel oopses cleaning pages for a buffer
> that's mapped into the vmalloc space. The pages are returned from
> request_firmware() and passed down directly to the i2c master to write
> to the i2c touchscreen device. Mapping vmalloc buffers with
> dma_map_single() won't work reliably, causing an oops like below:

Exactly the reason why I implemented I2C_M_DMA_SAFE. Did you also notice
the helper i2c_get_dma_safe_msg_buf() which you maybe could use for
len > 32?


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluheUoACgkQFA3kzBSg
KbY5lg/+O6lcx0uYmTjDHz7bfAO3QH49D9q7kDhqGBmwkQ1szR0WtXQCF9oOmIKS
8yytXNLqBhMyijpcBeQ62iNk/FW2f6A7+wYSjsElC7lWmqgGsNtotTJqRVAYDtlK
5u9BgG3lAC40c7boLNzQ+5/3ivbxP/B+0nmoHcOpE9eRRHobwF87jkvMZILKxiCM
UgWjpheCWALbYItbkPSiLJTpxq8VtJZAwHNwuKctiPCG6tpQquJ903tBZs7VfAwU
3AUPhwalNLaK3QaZVwM2RAGW0H0FcCz/TsgpkWFoirGdxvE/wGWXIDe6Uoeet+7U
e3ltKNKc830tu4V8Tm6YYb2SfYquNbgQmsP2TnOmrqGsyNRZbTZEwIXJ4i8UkuyK
0Xwyzc23b0uReUF7mztp1p76eWaHl9/Rohk7EFmK9C+jnzg4rhj9WdIrtdxdQ54K
jwewNdmdkE06YS3x90ngONaONBnEuF0IM5VlKTT53mnFwpQl6ILd8p42qY6LFey9
lwhRuyhgURHd5GCvCNiNAJa240W26FKZwT96aZQjubPTb45wpYeoJNo8JbPHLB4n
Juxscuv2/Cf+yXGT4nH8/G8uqQnZfW8gvftGSxDxqevWcb09fIovxnbJqrhqSTuO
Aw9i6yzFYg+s4tvkQ1fCn6iKHVsaH25J2O2xH57ZnxBxhvb1WAg=
=UwD6
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--

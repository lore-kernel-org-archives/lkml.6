Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6BEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E559121738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550618136;
	bh=oLkhpR1/Oq1gMP9GF+LNPy9ufSoq0wfyFcZC0x4jbFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VmLkkihbGxUHXNLUSABMO5mPghFA91ruqsfHapWgBpOA+Jjhdc+6QaiLewUV6zFRN
	 WyaD0hUbiRhjXBf1yz8YaKU2x2beZCwHqlxx1TzYCTdvk18gOch0SzscRJd/IJvbWT
	 gfVQdP0H+6FBlYGoXORSMZs4m/OodceaTXetuXDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbfBSXPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:15:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:59514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbfBSXPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:15:34 -0500
Received: from earth.universe (unknown [185.216.33.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89E8721736;
        Tue, 19 Feb 2019 23:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550618133;
        bh=oLkhpR1/Oq1gMP9GF+LNPy9ufSoq0wfyFcZC0x4jbFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLWFa6DSYOJOkfRS7mO0juqWeWOek4cJhg0NdO8gBaigWx0Id1S//yQt+S2O0tBUJ
         uSIuwRw+WkYRwbvrn0WQgx7xleLTLgdelAu6MYKpUriNWyRiSPi9fqfzshnlmTPlAb
         vKxiTio9dZ/Zg+1N2iazXbzsbwfhX2Fy75aNIw80=
Received: by earth.universe (Postfix, from userid 1000)
        id 0ACF23C08DD; Wed, 20 Feb 2019 00:15:31 +0100 (CET)
Date:   Wed, 20 Feb 2019 00:15:31 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 2/7] x86, olpc: Use a correct version when making up a
 battery node
Message-ID: <20190219231530.ndmpcitemcjzf5xc@earth.universe>
References: <20190110174005.1202564-1-lkundrak@v3.sk>
 <20190110174005.1202564-3-lkundrak@v3.sk>
 <20190123205627.nbddtfuy6qdo2bgb@earth.universe>
 <0adff00d4c4797fe1f9d593a7ba7c772ac3312c4.camel@v3.sk>
 <48f658a78ddcd6cc67f6eb280dc2c3aa3399c459.camel@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j4x3gsyaydkk6jd2"
Content-Disposition: inline
In-Reply-To: <48f658a78ddcd6cc67f6eb280dc2c3aa3399c459.camel@v3.sk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j4x3gsyaydkk6jd2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[+cc Darren Hart, Andy Shevchenko]

Hi Lubo,

On Mon, Feb 11, 2019 at 12:37:19PM +0100, Lubomir Rintel wrote:
> perhaps the message slipped through the cracks? I'm happy to do
> whatever is needed to get the patch set into 5.1, but it seems I
> need some help and clarifications.

The following patches should be merged through the power-supply
tree, which is maintained by me. This one is not for my subsystem,
so either I need an Acked-by from the x86 people (=they are ok
with me merging the patch through the power-supply tree) or they
merge it into the x86 platform tree. If it is merged through the
x86 tree I need a pull-request from them, so that I can merge the
other patches.

TLDR: This needs interaction from the x86 platform maintainers
(i.e. Darren Hart and Andy Shevchenko). Looks like you did not
Cc them?

https://patchwork.kernel.org/patch/10756459/

-- Sebastian

--j4x3gsyaydkk6jd2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxsjhAACgkQ2O7X88g7
+poXeg/9Fr3IwFdAmmBDYvdoaeAP5lLdEDe+W01Al2E7rjYyJ58Z48h5BqcTiaAf
jTKqu5JmTfRwHs7oVe8KKPOOga/7gR68JPNdptrkLeVm/TPfQ/ZjQGcvydQm1RAI
YgthK2/8hSTcheGFzHfJ5RuwpZYb8t/7wUQUGuNLqf0HXJ1eFCDmcOaRjs+kOngS
XuSQBrLxG110tyo4jr3uRIGFvLbVSzV5wgGdT05ewTuP3GBxqvGkmBQEv9JfqvK0
t5FMcuokwcXMsyA78RCpjYRJuRE3wpYz7SyM+ek5V57vRaX0kqr+Q6+NtACsc5EN
3QpD+LZ29pDmZY2Si270t2sMv7hAJOR1xtziQG/bqtL1Jh3+/uXDOYqw5+1xxT9R
03L8xUFdLdvygEtqIDSM+mhqlTpfApVrmhNY79ZWLV/eWnnLgEcjTCSf6iVhSZ+Q
itg0w5wxwwl6HTw54kDImS1KVzjzvByt2yDS6tQ1rsVy3LNkLUCTQJ2X9VNmmdiW
OGXgvGf/bv02K2KifZ5xiQK8YoN5vdXraN4W9v2rd/62lYsPiKPD5aKMDoqcc0/K
Wqwz0U99VkpYc3TQ88dk5miGvWaPs1a7Kx0uGOBLAX1Pr3948pyVPSaYDd5K+kx8
1xqjo6wMI5PRiyuGMrVaxwdssuBxDbDPOSrw7rEAROtDjZwD5Es=
=5pzH
-----END PGP SIGNATURE-----

--j4x3gsyaydkk6jd2--

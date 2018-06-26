Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE54C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448B226A39
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="vNlfd+Ic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448B226A39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935083AbeFZMEH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:04:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46238 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933658AbeFZMEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cM8ezF5vJt+sr8Jegx4IV9nmTr0ayFe68F8n3vJR9EA=; b=vNlfd+Ic4hu9HhYuG+k9a4X9p
        b7ou8nC5+t67mCpy5nkX2/WB8fhvebb0OTZocB98Lv1NbT1AeUxrG/ZtYafHvzGOKSMUk0+ccvLPY
        WArctIUGXw+zX8aBVFJ3wZMUGmXXTX/0+0ugEkCWkBEnOSMI/5w6RRI6kZ+gdE9A5pe2s=;
Received: from 188.29.165.85.threembb.co.uk ([188.29.165.85] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXmhS-0001DT-V3; Tue, 26 Jun 2018 12:03:59 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 0DBAA440070; Tue, 26 Jun 2018 12:55:26 +0100 (BST)
Date:   Tue, 26 Jun 2018 12:55:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     jiada_wang@mentor.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: soc-pcm: DPCM cares BE channel
 constraint
Message-ID: <20180626115526.GC1779@sirena.org.uk>
References: <20180620092520.14101-1-jiada_wang@mentor.com>
 <1530008318.2900.44.camel@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <1530008318.2900.44.camel@baylibre.com>
X-Cookie: PARDON me, am I speaking ENGLISH?
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 26, 2018 at 12:18:38PM +0200, Jerome Brunet wrote:
> On Wed, 2018-06-20 at 18:25 +0900, jiada_wang@mentor.com wrote:

> > +	/* DPCM used FE & BE merged channel */
> > +	unsigned int dpcm_merged_chan:1;

> Jiada, Mark,

> Do you think we could extend this flag to let the link choose whether the merge
> should be performed on the codec dais (as done here) or on the backend cpu dais
> ?

> I have more less the same need as Jiada but since my card uses multicodec links,
> merging on the codec dais does not work for me.

> Like in soc_pcm_init_runtime_hw(), we can't enforce channels min/max based on
> the codec when there is multiple codecs on the link.

Ugh, probably that'd work.  The ideal thing would be to remove DPCM but
we're stuck with it for the time being :(

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsyKa0ACgkQJNaLcl1U
h9B3ZQf/VDdH0OllOt1exYM3rc75dChu4BPa80cTKJP3QlUJEHbpn4Jzl8hdC4B9
dM6DDOQUlPcr8ak9WIbYX9JkYU8v04cSlEyJ5hC9g51Mosk9TvTZJE/yerq1dvYn
GRuN6eluPWnRo3fsDonNR0OjH/61LhDv32iRylqZl1nKqNXdeLYx1ftdcRJZGoSs
NTjImvM8Jt795nVMQ9hJMjfmv5kj6m7W01B2co75TEtGjkIk1Wl6zDWzf2USn6Cn
MMB7OS3qnTVQACCudOFDNqZJS8GKXx2gyiwQc+o+hzjhX7qKU2lF8vmPQnScYjgL
1hi7reNzeHQ00GovkyHlyViQnnsCfQ==
=9LN/
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--

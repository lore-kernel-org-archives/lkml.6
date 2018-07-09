Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9835DC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6082087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="vvKbCBzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6082087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933040AbeGILSM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:18:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49748 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933002AbeGILSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/XTzHCfMF2ijjZEnW5n8ELHqhDwSWQ01+Yb9xLJ35rw=; b=vvKbCBzbHO7+cvsyAymzMqeWc
        Zbuggy0/G1oMOaibGaGTTqeYUN8Fgh+NR5CZMB1rLeC0dH1QJl4ZnLv8jTyrOfoh6F9eAEbMRsalo
        Dz+wPPn9YkB15xb/w+2znhEMnMylBGLKtZKrqCzJac5ZoKqryz/EyVCRWVVlKE9KeXQGw=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcUAx-0003i9-Ay; Mon, 09 Jul 2018 11:17:51 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcUAw-0005m3-U5; Mon, 09 Jul 2018 12:17:50 +0100
Date:   Mon, 9 Jul 2018 12:17:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vinod <vkoul@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] dma: add support for reporting pause and resume
 separately
Message-ID: <20180709111750.GC16082@sirena.org.uk>
References: <CGME20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65@eucas1p2.samsung.com>
 <20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65~9jzNWZMqQ1216712167eucas1p27@eucas1p2.samsung.com>
 <20180704070033.GA22377@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
In-Reply-To: <20180704070033.GA22377@vkoul-mobl>
X-Cookie: Falling rock.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 04, 2018 at 12:30:33PM +0530, Vinod wrote:

> > Existing clients of dma_get_slave_caps() have been checked and the only
> > driver which rely on proper channel resuming is soc-generic-dmaengine-pcm
> > driver, which has been updated to check the newly added capability.
> > Existing 'cmd_pause' now only indicates that DMA engine support pausing
> > given DMA channel.

> The change looks fine to me. I was hoping that serial would also check
> this..

> Mark, Lars you okay with this?

Acked-by: Mark Brown <broonie@kernel.org>

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltDRF4ACgkQJNaLcl1U
h9ArzQgAghDGW9+/mOESfXsKVbjaF3dY+et4k6kzf9ku4hsV+M98UUK/PnGVBt8X
Sy7kVY0pcs8gL3Vr38U5MNCAciqUIU8cSpIFmlIklR09AH/vjo0iZV6Lvwx3og5Q
Ue7WsvB+I+JETEK/skTdtPQaobPsEU1eK4nDB1RmsxSy+49XfDtVKNuTHCXGt7OM
MOxVD1zQxMbWXg8YEmhA/YFteqBSDjP88CAL1z1G3UBGNEv00k1lPbLOLcEkYMUK
tLcnHbwshBaC1odwcn6GkhBkwHIJ43YnT2QY3+p/lum9ZCBdz8Njui6c/a1cKC31
01MNm6AnUNAGo74m1s8Ojo+vLyVpqg==
=//z2
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--

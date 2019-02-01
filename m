Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BA5C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F9520869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549027201;
	bh=usZo9+x3nqu7l3xViYWTJ3PNRluU3qbBmjby+Sxx4ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=AhxhzGwAWGGfz7viF/5wotwEhCWsRs202ObN7LwoLB6Ok1/TNnsPdUoScwbyhVrb6
	 W+O1TUqkguemL+eB3+/3ksXqFXAgkacwHyBFWik6gb2+1vIGXIqJkVx1AHh2AMQLVu
	 PwbJBtt1SVCYUQt3AbnF3LpCu/zZJidmMuqx5rD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfBANT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:19:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:1931 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfBANT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:19:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 05:19:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,548,1539673200"; 
   d="asc'?scan'208";a="135055770"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga001.jf.intel.com with ESMTP; 01 Feb 2019 05:19:53 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, John Crispin <john@phrozen.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     iommu@lists.linux-foundation.org
Subject: Re: [PATCH 12/18] fotg210-udc: remove a bogus dma_sync_single_for_device call
In-Reply-To: <20190201084801.10983-13-hch@lst.de>
References: <20190201084801.10983-1-hch@lst.de> <20190201084801.10983-13-hch@lst.de>
Date:   Fri, 01 Feb 2019 15:19:41 +0200
Message-ID: <87d0obodci.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@lst.de> writes:

> dma_map_single already transfers ownership to the device.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Do you want me to take the USB bits or will you take the entire series?
In case you're taking the entire series:

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

> ---
>  drivers/usb/gadget/udc/fotg210-udc.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/usb/gadget/udc/fotg210-udc.c b/drivers/usb/gadget/ud=
c/fotg210-udc.c
> index bc6abaea907d..fe9cf415f2f1 100644
> --- a/drivers/usb/gadget/udc/fotg210-udc.c
> +++ b/drivers/usb/gadget/udc/fotg210-udc.c
> @@ -356,10 +356,6 @@ static void fotg210_start_dma(struct fotg210_ep *ep,
>  		return;
>  	}
>=20=20
> -	dma_sync_single_for_device(NULL, d, length,
> -				   ep->dir_in ? DMA_TO_DEVICE :
> -					DMA_FROM_DEVICE);
> -
>  	fotg210_enable_dma(ep, d, length);
>=20=20
>  	/* check if dma is done */
> --=20
> 2.20.1
>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxUR24ACgkQzL64meEa
mQahHA//UqW4f00GsiqzttL+A0YT71T+D9qtJhSfF7M0knMpZzdyOqcirQVm3TRT
tpK0gC37IQGcT8NcrX75EtASdv/SBDJKhi5H1bCOEc5H00YxYUvujAdut+D25tJi
SzfffbgIDcmkdit869qdzHmH565AGYZY6RG0lPoIS+7o1EGlO4AMM7RfF0y84VmY
46M4Ch6WtjDVuFAEUhHdZi9Q4hXxT46Kz6gKyzB/aB5h1OGxeHpUl5HUkF0jZmts
E6m3SZb/vUrfQINJ69erIJH4qqap0TbQ509i0M1cx9X1TYiI/ou4C8bSk/8895K0
Js67kpVD/OXAyTmf/nVl4rtkhuDugyfEC+2bGUohpICCVd9ubg85B/1Yi/qQafYs
sOt7bISdGgLiiSAxw9FWtVlezCW/8xuyC4hn0knkoAd9iIOO1LhfdNvfz0PPaVeW
JnmCbx6syBAwlaEFem/M4uxp0Lq02WggiTNtTTUJw78N/MAl3CzDyyvRF0K1VpIR
eGT71Gcrge3Utw8G8Tm0rzlBJntsXh7PLD63ga6nwirPxtq3ScPh3yjjdODRjc62
T4dch1AT9BSKqqbFeQuMaeEV5ml3SJF3+DvIQ3LRz22lP65oSPHYvmdWHYOXW++W
FGuEo7SIciykLAFxBDq4MjuIqn5uMMERmOqGGElHqdZsQE+0SVg=
=byNX
-----END PGP SIGNATURE-----
--=-=-=--

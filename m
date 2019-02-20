Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B032C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621572070B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfBTJag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:30:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:11074 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfBTJaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:30:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 01:30:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,390,1544515200"; 
   d="asc'?scan'208";a="145749931"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by fmsmga004.fm.intel.com with ESMTP; 20 Feb 2019 01:30:32 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     oneukum@suse.com, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: add Immediate Data Transfer support
In-Reply-To: <20190219162945.22889-1-nsaenzjulienne@suse.de>
References: <20190219162945.22889-1-nsaenzjulienne@suse.de>
Date:   Wed, 20 Feb 2019 11:30:28 +0200
Message-ID: <87ftsidcy3.fsf@linux.intel.com>
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

Nicolas Saenz Julienne <nsaenzjulienne@suse.de> writes:

> Immediate data transfers (IDT) allow the HCD to copy small chunks of
> data (up to 8bytes) directly into its output transfer TRBs. This avoids
> the somewhat expensive DMA mappings that are performed by default on
> most URBs submissions.
>
> In the case an URB was suitable for IDT. The data is directly copied
> into the "Data Buffer Pointer" region of the TRB and the IDT flag is
> set. Instead of triggering memory accesses the HC will use the data
> directly.
>
> The implementation could cover all kind of output endpoints. Yet
> Isochronous endpoints are bypassed as I was unable to find one that
> matched IDT's constraints. As we try to bypass the default DMA mappings
> on URB buffers we'd need to find a Isochronous device with an
> urb->transfer_buffer_length <=3D 8 bytes.
>
> The implementation takes into account that the 8 byte buffers provided
> by the URB will never cross a 64KB boundary.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

This looks good to my eyes.

Reviewed-by: Felipe Balbi <felipe.balbi@linux.intel.com>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxtHjQACgkQzL64meEa
mQZV1w/+IWvj6mmAZihLtdfVlQUdk0NlgtBLeQhRjQY/p8hjFVukOqwxfxbwDD2b
0Ft0HQFq8kZ3RY7Y4jjlcv6ubnU/XC7ctl89r7ovbqohcOpkbBhVzqMUEfW5tWhD
+oNuaWjDUkxFo5fLB8HJo2d9wtrXRooXgdYBbYUiGXzkgt8Hjq7CJAIkqWgoKX0B
NaQNIfbhvRjrtV7ASmOlSGG7nrbyARUwySzOC2rJeQ1iuwPONJTTcd87nUf+1om9
0/2BI9p3tBZsXbcqD6blZzOKXuC/vChx6Hn9PhCnkOS7VaqUr5ZSecqwS2NlHWx7
kjpebnSEMKslEsbZwhlV1NcyphU5+g3mbQC36HtGvZaqVyE06TBJH1CzzDU/ZgRi
+OOfl9VRUI4aAhXQ5QgTV6N+qFLGK+v7XSYWcHZ0+ps8DMYTE4/Q5P8bYkodbt45
dz1VP1chJJGTCAKhxQfq+P1Pkr+5+pNdKaX+Y+FmZWm7CmVbndhh1VOO8uLBSn3G
dystvflcoTg2ZpLAqXRgQFWqWUFArQsreDNJqKQjjTX/+valPl+Mo5wTutg0QQ3i
fBRDa9fMqidDN2FDhWDBSyk8YEgQknykqiRBOWzLUKSoQduvOHqcX8TwQKMASaqk
kPpjj8Vc4roluTLZwXf2A8IQX+0CabvAXOB0VyzCdS+fWLPVcb4=
=Hceh
-----END PGP SIGNATURE-----
--=-=-=--

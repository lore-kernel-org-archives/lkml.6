Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF27C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB0720818
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfBGIps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 03:45:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:7501 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfBGIpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 03:45:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 00:45:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,342,1544515200"; 
   d="asc'?scan'208";a="317029373"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by fmsmga006.fm.intel.com with ESMTP; 07 Feb 2019 00:45:46 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-usb@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci: Convert xhci_handshake() to use readl_poll_timeout()
In-Reply-To: <63866354-48b8-5787-39de-5c23e7471f6f@linux.intel.com>
References: <20190207000308.7051-1-andrew.smirnov@gmail.com> <63866354-48b8-5787-39de-5c23e7471f6f@linux.intel.com>
Date:   Thu, 07 Feb 2019 10:45:34 +0200
Message-ID: <87sgx0kmvl.fsf@linux.intel.com>
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


Hi,

Mathias Nyman <mathias.nyman@linux.intel.com> writes:
> On 07.02.2019 02:03, Andrey Smirnov wrote:
>> Xhci_handshake() implements the algorithm already captured by
>> readl_poll_timeout(). Convert the former to use the latter to avoid
>> repetition.
>
> readl_poll_timeout() doesn't really work here as it might sleep.
>
> iopoll.h:
>
> /**
>   * readx_poll_timeout - Periodically poll an address until a condition i=
s met or a timeout occurs
>   *
> ...=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
>   * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
>   * case, the last read value at @addr is stored in @val. Must not
>   * be called from atomic context if sleep_us or timeout_us are used.

readl_poll_timeout_atomic()?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxb8DAACgkQzL64meEa
mQZ7Fw/8CGyZy9l31N4Ge7FJOLRFuGJhz+ZM17ypQ2CY8Sg/lP57/z3AykM7v24r
5TNBqjb3N7j0c3z3zDpCMGbZ8yKWkh3+/yWChu0sxyk7ROvd62mW786MmEmvu8+H
K01Y/BlMZFkjMCnPkvsXSlkB7R4mn2ZM9x8l1iyFy/x9cpHSSZGeJk7GSAP1/h4w
qAPHzXuWWBoxzOvF+1VabgSHU7MFrFexKHddiOXTdm7Q7xdOMurSk+v0vQRR/Nrq
45/epu0y4p1Cprea5NoTQS21ZvueIXVasQgBx4PddQdL9uFhftsvvqLRD90i2mM0
3HZssBG0WO31nE5aQ01VTCqxszRJjgbQQJJuK4nd55/buyOwiYkmClfNIhvSdwLR
J1XT2fgRolT1fXqs0fe13iUGVGKMYX0EYZXXt88TzpXVCCq+YA5nBQALhS/Kuq0n
vTmccZybF8RrpLRFQoRJ99d2y1GnTyuzyCNNxg2bDFslqETkBkxYbUV9ISPGkDNE
PDP2OJwHRs/sS/ZcQ79sM/19qVB1fIJfOC3vofnYY6ESDbfC3b0q+k00XO5yjiBJ
+qTFAxu+NE+ilvfixQDQnqUZM44wwShaew/ZqyaTR4BdR9X+It7tPPDs6AwIUQ/G
yYkYqXIxMsydphXu8z6i08kBMfjyvmHStF0kxWhP+NP5HdJ5w84=
=+8rt
-----END PGP SIGNATURE-----
--=-=-=--

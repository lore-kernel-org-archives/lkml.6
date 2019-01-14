Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45445C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1190620663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfANIND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:13:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:34159 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfANIND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:13:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 00:13:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,476,1539673200"; 
   d="asc'?scan'208";a="138022732"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jan 2019 00:13:00 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Zeng Tao <prime.zeng@hisilicon.com>
Cc:     Zeng Tao <prime.zeng@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: gadget: don't remove the request if bus-expired
In-Reply-To: <1545339230-10520-1-git-send-email-prime.zeng@hisilicon.com>
References: <1545339230-10520-1-git-send-email-prime.zeng@hisilicon.com>
Date:   Mon, 14 Jan 2019 10:12:56 +0200
Message-ID: <87won7mzcn.fsf@linux.intel.com>
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

Zeng Tao <prime.zeng@hisilicon.com> writes:
> We have already returned EAGAIN for bus-expiry, and it's designed to
> start with a future Frame number and start the transfer again. So we
> should not remove the request for that case.
>
> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>

Do we need a Fixes tag here? How about Cc stable? Can you share
tracepoints exposing the problem?


thanks

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlw8RIgACgkQzL64meEa
mQZWLxAAwgXG4dgFq4QKTlmWqvSQql6to9JscaTsA3U1NBplSLhRJlXcUEDjglQ4
f2s2Ljon6Tu97P0X1Flkqp3xv801CxrXKNv/NZFvJRq8/oZf0sOBOC5TKxGZU6QZ
RGyIbr6900u9929qMtUPZZ8roKxemCbF2wenuh+X9pu8u5RYWXkt4XBdTDOh+k8j
Oz30gvjKeqITJfZK1z3PPCD3TmcWy/fBQ7Pjzz38vf8hTkoL29PW6LgIeNrY+KeF
us8epOxC2lyheI6XX4maadGf5TZOJ5VbJ3sSnbDY/I3tskfBcme/e/57hApj48yM
c7rgiu1T2/PZ2XoLH6Z84zguSsMoOMSMdif6iNhmKWQrs69O4hLxIJCCyGDNPmXy
7DWpgSwvbGniQecEiVpRElekhyQq37UrRNFUCmViQD5YEvCD1rAZrPKWg1vwp/mF
Cn+zS8MUpih46lyHXX+ng4I1gRkEoKOPkKPIKmEUqT6P2RamPlSSb075+TbjvElO
QvrUQe7UGY7n713jiTypWbqXn9pqE1sDe62kSBFW/KrTqPN1d5KHhnx3GdAXKd0D
6IbCuGbnxcCo0ciuu/7WxbfRrwPvuvlB+3FZ0eIGudE1tQusSIF8i6P8z4jlMwY+
v8I/kj8GNx5WlHe6AI3YFxwXMpSlUV3KEb3EjqVsTCtl55X/sUU=
=aDw7
-----END PGP SIGNATURE-----
--=-=-=--

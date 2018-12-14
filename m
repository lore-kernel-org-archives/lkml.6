Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C990C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C9C2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544777522;
	bh=h+7ugyRd8MF00pmeqLw67L8yu+RAUO5sd7V6yGRQHgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=0VJTuzgAbjkPKbmuqPR7uV24jjw2PdX9gEerPy15U+bWKoWxQbnMerGJLl1rxghCE
	 pElUi7QHxpGrQhVNFgLUT8vM15eNVAqKLZ/x5XjXspFXa+8D4MPqzB3j7FHyR+JPzh
	 W2FHqJED/kER+ZmwhRIt5W4GcWYYMTJPIXmIQp6U=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C9C2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbeLNIwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:52:01 -0500
Received: from mga12.intel.com ([192.55.52.136]:61653 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbeLNIwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:52:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2018 00:52:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,352,1539673200"; 
   d="asc'?scan'208";a="303786998"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by fmsmga005.fm.intel.com with ESMTP; 14 Dec 2018 00:51:58 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Zeng Tao <prime.zeng@hisilicon.com>
Cc:     liangshengjun@hisilicon.com, Zeng Tao <prime.zeng@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: gadget: fix miss isoc issue introduced by IRQ latency
In-Reply-To: <1544805179-2248-1-git-send-email-prime.zeng@hisilicon.com>
References: <1544805179-2248-1-git-send-email-prime.zeng@hisilicon.com>
Date:   Fri, 14 Dec 2018 10:51:54 +0200
Message-ID: <87efaklcd1.fsf@linux.intel.com>
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

Zeng Tao <prime.zeng@hisilicon.com> writes:

> If it's a busy system, some times when we start an isoc transfer, the
> framenumber get from the event buffer may be already elasped, in this
>  case, we will get all the packets dropped due to miss isoc. And we turn
> into transfer nothing, to fix this issue, we need to fix the framenumber
> to make sure that it's not out of date.
>
> Signed-off-by: Liang Shengjun <liangshengjun@hisilicon.com>
> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>

There's a patch going upstream already doing this:

https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git/commit/?h=3Dn=
ext&id=3Dd53701067f048b8b11635e964b6d3bd9a248c622

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlwTbyoACgkQzL64meEa
mQZXrBAAqyKDTv2dVfXT1BlCoXwecJIHLEE4PzzviPt8rV88wmCekGpsjR54JAT7
TDbBt3QJRbhvAkCHvwLxzUdk6H6JFFfKZA73TksMv3zgPoGEYErbFZFJNpbKvq7Y
Q+6tsmVcDf7ucmy+37tDY7Am4ZnHyQAtdFQlBvXh/6bMfzfUqgIvgSN/nXtNb/Li
iByP/2p8TLq0MDh4FsP58k3OpOfokysePenprWSwLEXFRQx3hIs8OZslfsRoT745
7lDFL2RiLUmgLoYG2TcCqkcN7nTPS+MZuQIVHjMVo9TlXLbBScc5OtWQMvBOctHg
vYWhDRcmjqu1lS7z8iFyWlVyQJfxRuC6qo3Dq3+soeopv3TxfgkIYDMzmXYQFKUp
x4O4J2ws6K3ZgjQqW6qe/M21SmbnJUuTkpvxtDNdSSe/uATZ2kVmajn7n4z5ZEAb
0V8qhfMsNw5F/x88qbT6lQwQjspbeMxkWPiu6dFMdPNsn5nigpk6jwEWGD9hM+j4
Dv+3YMJhSOxr5xxLsT2Bl+XWp7G+lx09t7oLF45XfKjtNP/NNGyU62JXfEML5gQk
VEEOKeH4Mh3+PaM6rD+ENrCYavIcQbJCG0uOX6vFZgWK1pCRdEnGiMEGBtyF8qOq
2hLTaQ5u8u1buJRFIPYauaXTU6LkwqyURnTCPlWQQhR+xhcO640=
=ja3K
-----END PGP SIGNATURE-----
--=-=-=--

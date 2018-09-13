Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2455BC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED8520881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED8520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeIMQMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:12:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:31743 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbeIMQMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:12:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2018 04:03:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,368,1531810800"; 
   d="asc'?scan'208";a="89668473"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.128])
  by fmsmga001.fm.intel.com with ESMTP; 13 Sep 2018 04:03:22 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Haverkamp <haver@linux.vnet.ibm.com>,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 03/17] compat_ioctl: use correct compat_ptr() translation in drivers
In-Reply-To: <20180912150142.157913-3-arnd@arndb.de>
References: <20180912150142.157913-1-arnd@arndb.de> <20180912150142.157913-3-arnd@arndb.de>
Date:   Thu, 13 Sep 2018 14:03:18 +0300
Message-ID: <871s9x1wy1.fsf@linux.intel.com>
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

Arnd Bergmann <arnd@arndb.de> writes:

> A handful of drivers all have a trivial wrapper around their ioctl
> handler, but don't call the compat_ptr() conversion function at the
> moment. In practice this does not matter, since none of them are used
> on the s390 architecture and for all other architectures, compat_ptr()
> does not do anything, but using the new generic_compat_ioctl_ptrarg
> helper makes it more correct in theory, and simplifies the code.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAluaQ/YACgkQzL64meEa
mQa7Cw//SVIduyNkKUJWE/M6JNaHgPcjaKHvJmfwUbCJ4obLMil5YB5r4CXLcL6c
e+sSufRSpae7ea7GG3v7aKqOdA5QqwoK3Nuly7lJv7tfy29lQiXTIvVfW8f52SWM
AM4vjGT/TKyMrdFoXBr8KkFlCppAXShYUSayRg7ADNnvR+pZ5aNihNdb1BVb/gfT
4/A9PObPckHwj7v3RxYe1Nj6IOuI276oNXlLOWAbC4L3ijXxTD20K+sP/ZvzzO7V
/bTl1rEmyqcD5khWYw/MpJhbuDZN2FRa1lyYcp/zHOXCrkly8jaB94LlSiycajja
ylzBVqOSqC3al600dBsxAU2XFlDmVcWgQZCcyubLC1C0cZdo3sshhArgiXy/v8N2
D+3l9iWr8BpC44zbCEQgjNvaqJUF0mMg4Rs7LXVH+IH6KrcZbpOf/pcjLRvqf+zt
PXIyEJXDfXjOii/kSugM9EHAF8U9p+/JCxsum93vgv7E1UjZhz0X3pc3vWoIbGN6
yeKN7vkGxiue8ghzscuwJowIdv6wa9erbX0srRruxajFvnm92wp0ajHDOgaUaZAG
RhQSqq+JnE9zMWSUyc3rLD7WBiDntLu4DCYNjFqQbi34tbYDUnbiejsdnSywHa6p
8TAIXk+jnn/Em5zalyWoAX4lkpdGhAgQLMySWhnvw3NEpfeX6Gw=
=/6h3
-----END PGP SIGNATURE-----
--=-=-=--

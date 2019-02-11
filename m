Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE74CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF9921A80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549891852;
	bh=zd2/qdEIrVr0UdLku0R+8t5HRgW7hNoZ+e2qXE3O2kY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=sTR94rHUFcdQj59Cg9F/sE9a06ejV0DHbfg5kAPPhNtV/Zupq2g7TKUkqqdpie57I
	 CZeFXcof9Lz8BGZCwnxhz0vHuj61HvRrf9idrah+mRPyo1ClQK7K4rZ8IinlS5RPVV
	 eMBlAgUQNV9fxyEfJTnEaMAN77wnsT7i2a+URi5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfBKNav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:30:51 -0500
Received: from mga05.intel.com ([192.55.52.43]:32813 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727991AbfBKNau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:30:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 05:30:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="asc'?scan'208";a="274132445"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga004.jf.intel.com with ESMTP; 11 Feb 2019 05:30:44 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christoph Hellwig <hch@lst.de>, John Crispin <john@phrozen.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        alsa-devel@alsa-project.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 12/18] fotg210-udc: remove a bogus dma_sync_single_for_device call
In-Reply-To: <20190211131243.GA21917@lst.de>
References: <20190201084801.10983-1-hch@lst.de> <20190201084801.10983-13-hch@lst.de> <87d0obodci.fsf@linux.intel.com> <20190201161026.GE6532@lst.de> <20190211131243.GA21917@lst.de>
Date:   Mon, 11 Feb 2019 15:30:40 +0200
Message-ID: <87mun25u67.fsf@linux.intel.com>
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

Christoph Hellwig <hch@lst.de> writes:
> On Fri, Feb 01, 2019 at 05:10:26PM +0100, Christoph Hellwig wrote:
>> On Fri, Feb 01, 2019 at 03:19:41PM +0200, Felipe Balbi wrote:
>> > Christoph Hellwig <hch@lst.de> writes:
>> >=20
>> > > dma_map_single already transfers ownership to the device.
>> > >
>> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
>> >=20
>> > Do you want me to take the USB bits or will you take the entire series?
>> > In case you're taking the entire series:
>>=20
>> If you want to take the USB feel free.  I just want most of this in
>> this merge window if possible.
>
> I didn't see in the USB tree yet, so please let me know if you want to
> take it.

sorry for the delay, just took it to my tree.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxheQAACgkQzL64meEa
mQYzFg/4muRUpGlUEIEF7m9XPk3QIX8Pzn3aMhhLD7ucF6/5HvJqCFtSWHhlMFTm
rFr30ro355hllOJnoWLoNfJY3T3cu8PMJ5IQ2365YdA+4CsmjZXUrcRe5WXAw/9Y
lTgoKjRqyPgQ8pvDZcm5fWI738c74q/bdlaGmZEJ/Gnvx4V7J+VTwvZSWpzuWO+R
R5BlvRd9D/WRvJjijfSnxH8e8bHQdzvOZBp3w1/xFfq7R/1ETCj5WIbQShh+EmEm
32rDZZoXO5QM2vduoknOdvOxAaBYtmP98HIlpcZZad+cEmIzAIU/J73F7cNdDpFX
+9Uwan4LKbx39nimqGAGDFLKgm/RfTZ2f/kAnUroGbV9RB+cTcaFJD4jbLkFF0lt
fszk5GE9EmONRYNdVUrZKDN/vuC5nIfrFckYMoEvHhbYWesSK7xPX6ULy7FqLfmX
SVSfjhs4hyc4RC2M6ahpOEdiLmfioBX7fXWgN3wMQDS4wwt5Nu8tnuep/RZbfGDu
13d2LNqpjvAX5wpyflLRZUeHSN7mPQGyS1w3i1ecVFo0BN99YNbwL72p0F1nSti4
/bVCOR74cnliLlMOly3IExJCVTksMVLa/4rWpP3s/EF1OnCq7HhTcoyU9ctkaeFc
YwL+7FWJm932YAw8lv0o5P6Tahvbl1CH4h0aw4Lkyw5XWIBxXQ==
=9V6B
-----END PGP SIGNATURE-----
--=-=-=--

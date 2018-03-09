Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-66263-1520586622-2-16105208219882787061
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES daen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520586622; b=cyHVF0RFRxwBd7SonPUdi6xmoERzEeeifmca02pWOU9jxm3
    fYRrmc3sd+fAsJnLRNs+wZgTdPDYNW5JHmucWlQ5fGunKEnXOJQx9wKLcpLq93+Y
    jcH959UWfx0mMeJhaz7//5VKwXRbCETHvn2sySKibIb6vXGZL8dUIteaLbU2wOr7
    sBq4KyjtxRyGpjJk1RKy6pRdUQpcAGeRvz9M+u25vdZjTOy2iq+PSzhNqi2wmvLS
    3ux5+p+GnNhNfVOd68Ii8CvRSdpppaeovCxzFphYNnjkfdtDAITEtxREVmdmrqSE
    25AYh4HzgztemM/MefVnETK7l/DYVukmoxIDV7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1520586622; bh=RHVbOSmvZW/57AXlKMHbdfZ/JCzNIoHIYz2ygL
    MyqvE=; b=HUb0WvS6I/eEngm8SPEsydpQWQ+/s+jcHTx8owGx/dlTaGum91t6lc
    aq2QmkAcsXiIaRcjppaLgCbDLeKKt7Jbnnag1ZFP+2JySJJG/Pt3a4ryhXjvKiae
    wlc51VloAFxdvunbPHUcdXRxLpZlhI8ASWTaTr4OPdNDxKbun4fP6PB/4Cf365sz
    CCkkDc6Ul+GynRUCHR4Q74gjwTv77+yNurpfc/Jrjy5eZiCa1OdXHDmGcCroNEpJ
    gorEsOWCfsobNrUaf/asevDh37svnWn5pjvqPFu3nDcTCh3qaU7SO3dGvVapDApb
    ea/G/KRqLp0wwQWvN5thWcuQ5wjCVXWQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbeCIJKT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 04:10:19 -0500
Received: from mga03.intel.com ([134.134.136.65]:6372 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbeCIJKT (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 9 Mar 2018 04:10:19 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,444,1515484800";
   d="asc'?scan'208";a="22984688"
From: Felipe Balbi <balbi@kernel.org>
To: Stefan Wahren <stefan.wahren@i2se.com>,
        John Youn <johnyoun@synopsys.com>
Cc: Gevorg Sahakyan <gevorg.sahakyan@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <minas.harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc2: Print error if unable to set DMA coherent mask
In-Reply-To: <1893294987.392820.1520530314966@email.1und1.de>
References: <1518466808-30318-1-git-send-email-stefan.wahren@i2se.com> <1893294987.392820.1520530314966@email.1und1.de>
Date: Fri, 09 Mar 2018 11:10:08 +0200
Message-ID: <87sh99aa33.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stefan Wahren <stefan.wahren@i2se.com> writes:

>> Stefan Wahren <stefan.wahren@i2se.com> hat am 12. Februar 2018 um 21:20 =
geschrieben:
>>=20
>>=20
>> We better print an error in case probing of dwc2 fails on
>> setting the DMA coherent mask.
>>=20
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> ---
>>  drivers/usb/dwc2/platform.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
>> index 4703478..4ddbdbd 100644
>> --- a/drivers/usb/dwc2/platform.c
>> +++ b/drivers/usb/dwc2/platform.c
>> @@ -382,8 +382,10 @@ static int dwc2_driver_probe(struct platform_device=
 *dev)
>>  	if (!dev->dev.dma_mask)
>>  		dev->dev.dma_mask =3D &dev->dev.coherent_dma_mask;
>>  	retval =3D dma_set_coherent_mask(&dev->dev, DMA_BIT_MASK(32));
>> -	if (retval)
>> +	if (retval) {
>> +		dev_err(&dev->dev, "can't set coherent DMA mask: %d\n", retval);
>>  		return retval;
>> +	}
>>=20=20
>>  	res =3D platform_get_resource(dev, IORESOURCE_MEM, 0);
>>  	hsotg->regs =3D devm_ioremap_resource(&dev->dev, res);
>> --=20
>> 2.7.4
>>
>
> ping ...

https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git/commit/?h=3Dt=
esting/next&id=3D57b1d49d4b9c6cde9fbe95c1a211b6bbea61c6fc

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqiT3AACgkQzL64meEa
mQancxAAyKqleQdH70PWchNrWcIhDWtOVZMtrOLJqTipQQFgtXFwaK5WclovppdR
BOG4/OHRBWXwgDz1nwIDQju3fFyfjkJJQqpKAWrtlu1FwZRPaJmQaGzfMtqzyvnV
Yqa2FpT92dP+LnTITSkybiFTMWf+ZZ4mJ2Bv4ihYqTrPFa8MLKuEo11NZWzywRQ5
8J26w+BzGrR8B0CxEdkM8xDoibFQFuweVNzH6SlaR6zZS2RRBSxgQMRECNav7tC/
Ez+DSfPIfg/RQK00tgkUy+d8L79zj6lc+3w+MthV2E6KDbgz6zO8MqsdXfmxL8Wc
F0f8Aq6K28JLlJZcYneV7ALKeikJbb56Vg5aYjRotSHYsJrSH7u7WxGpzgZywLg7
BVu8uGlu62XhEDCg4V0cRlsQcFTlwKB1cnuKatGniNGdsIINBBnKsoYSTjtyT5Cf
vjXjq8JDXtFhyatGSM1KRv1IvXxyoXiZ73aRaFWZAlOiBeNdVOCYMrBAphnKS/EY
WIanUBo3L8s97YlS6X3V7hlp4c/7WKGLx2p5ESZi1cGJ+YqFKY66SXBBx3h1MuR3
9UqExFfW65S2u2mG/8jAblJm5iHyuMGf/M0cN75tT0nr91P17Mt5RHylaxrk0VVN
EEhBcu1Kk3X8p+8bmZnKs/KgLL8WE1VjMw60Fh1iET0qQwn1FIg=
=LeKs
-----END PGP SIGNATURE-----
--=-=-=--

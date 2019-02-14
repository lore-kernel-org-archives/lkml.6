Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF46BC10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB66222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eworm.de header.i=@eworm.de header.b="T9vbGtV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403994AbfBNO76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:59:58 -0500
Received: from mx.mylinuxtime.de ([195.201.174.144]:42512 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387737AbfBNO75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:59:57 -0500
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Feb 2019 09:59:55 EST
Received: from leda (unknown [87.190.244.126])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id DF605B84E5;
        Thu, 14 Feb 2019 15:53:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.mylinuxtime.de DF605B84E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
        t=1550156022; bh=IELbpAkMQeDpo9ICafWaIbA+Fchxu72eNctZXgMtD2k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=T9vbGtV6gfkcXRD2eQl8oTr08S6Du/BajfEYzRTSepF1KCBqIspU9LgRRR1QFQ2Ui
         EiE9nuBIJKmJ0advEGKF1POTblZUdRGsCbrjLF27kI5nI2M4vnTAMrRi2ZNxSl9ze/
         o32VhW4+yF7VciwBv8ZF5Oxke9XJlh6ixKXZxxp0=
Date:   Thu, 14 Feb 2019 15:53:35 +0100
From:   Christian Hesse <list@eworm.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Linux 4.20.8
Message-ID: <20190214155335.6112f334@leda>
In-Reply-To: <20190212201812.GB11553@kroah.com>
References: <20190212201812.GB11553@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PD/4NWemPiiplKw8pNBAdO_"; protocol="application/pgp-signature"
Authentication-Results: mx.mylinuxtime.de;
        auth=pass smtp.auth=mail@eworm.de smtp.mailfrom=list@eworm.de
X-Rspamd-Server: mx
X-Stat-Signature: ukqycochxkw8edmcpwqz57ckyjc8jrdy
X-Rspamd-Queue-Id: DF605B84E5
X-Spamd-Result: default: False [-4.65 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.20)[multipart/signed,text/plain];
         TO_DN_SOME(0.00)[];
         NEURAL_HAM(-2.95)[-0.985,0];
         SIGNED_PGP(-2.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         ASN(0.00)[asn:3320, ipnet:87.128.0.0/10, country:DE];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PD/4NWemPiiplKw8pNBAdO_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Greg KH <gregkh@linuxfoundation.org> on Tue, 2019/02/12 21:18:
> I'm announcing the release of the 4.20.8 kernel.

Versions 4.20.7 and 4.20.8 are missing signatures in git notes. Can you
please add (or push) them? Thanks!
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/PD/4NWemPiiplKw8pNBAdO_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlxlgO8ACgkQiUUh18yA
9HYr9wf9ENcFi5HCp9S9CJZ1kYkP2Gj/WcxLL/F5sXZKeMjzxn5a8H9YoytiXpX3
O77x//gRc/YdsiA+FJRoeMv7HREoxtPM8X6EPtGLQgy44CyGEY8sSJfl/LpRtle/
rYcbKDkt7mJfZ9Ttq5n2P89AEQrGSjc/iz8Z3+A01N8SeRJ+a3+BF6yTD/l0TtnC
VJ10DXj8LHq5p8CWxUpxNtMJtD0NNgzyBcLRRh7UPBlkEjvKvYb7pxEVU72MrpY2
9d9tAGCmPwjZv8DO05Gclq4pgt8Z8UvYSRi0qOQ4BAExVWIj6q3rqvmo9XLHtqfu
9m/8u9coU27uMeQbAQO99evM9HsZ9g==
=n5MI
-----END PGP SIGNATURE-----

--Sig_/PD/4NWemPiiplKw8pNBAdO_--

Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E478C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF74120895
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF74120895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeIZIjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 04:39:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:34496 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726321AbeIZIjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 04:39:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0DF6FB049;
        Wed, 26 Sep 2018 02:29:16 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed, 26 Sep 2018 12:29:06 +1000
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>, devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] staging: mt7621-mmc: Fix single statement macros in sd.c
In-Reply-To: <2f93ac5324ef3a229f2b8e855222a5fdd7b32f90.camel@perches.com>
References: <20180923093805.GA20870@nishad> <b0f415b5b9655571374ab30e37406b494d07bc45.camel@perches.com> <20180925184947.GC16455@kroah.com> <2f93ac5324ef3a229f2b8e855222a5fdd7b32f90.camel@perches.com>
Message-ID: <87bm8lhtzh.fsf@notabene.neil.brown.name>
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

On Tue, Sep 25 2018, Joe Perches wrote:

> On Tue, 2018-09-25 at 20:49 +0200, Greg Kroah-Hartman wrote:
>> On Sun, Sep 23, 2018 at 06:31:32AM -0700, Joe Perches wrote:
>> > On Sun, 2018-09-23 at 15:08 +0530, Nishad Kamdar wrote:
>> > > This patch fixes a few single statement macros in sd.c.
>> > > It converts two macros to inline functions. It removes
>> > > five other macros and replaces their usages with calls to
>> > > the function being called in the macro definition.
>> > > Issue found by checkpatch.
>> > >=20
>> > > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
>> > > ---
>> > > Changes in v2:
>> > >   - Convert msdc_gate_clk() and msdc_ungate_clk() to inline function=
s.
>> > >   - Delete msdc_irq_restore(), msdc_vcore_on(), msdc_vcore_off(),
>> > >     msdc_vdd_on() and msdc_vdd_off() and replace their usages direct=
ly
>> > >     with calls to the function being called by these macros.
>> >=20
>> > Nishad, do please look again for uses of these functions
>> > you are changing.
>> >=20
>> > Please try removing all the #if 0 blocks instead, and then
>> > see if there are also now unused functions from those removed
>> > blocks that could also be removed.
>> >=20
>> > And Greg, if you look at this, look at the odd license of
>> > these files.
>> >=20
>> > It's possible the license is incompatible with the GPL.
>>=20
>> It is odd, but the GPL at the bottom of the file kind of implies it is
>> ok.
>
> Implications are not licenses.
>
>> Given that it was published by mtk, I am assuming all is good, but
>> it would be a good idea to check with the authors to fix this up
>> properly.
>
> The initial patch was submitted by
> John Crispin <blogic@openwrt.org>

Actually it was submitted by me. I extracted it from libreCMC (I think -
it is in most of the various openWRT-like distros).
In libreCMC the patch has John listed as the Author, and I thought it
right to preserve that.

I believe the code comes from a code-dump made by Mediatek several years
ago.  It can be found at git://github.com/mqmaker/linux.git.
The code there contains (in drivers/mmc/host/mtk-mmc/sd.c) both the
copyright statement and the
 MODULE_LICENSE("GPL");
declaration.
I took this declaration as sufficient evidence that Mediatek
intentionally released it under the GPL.  The fact that the whole
code dump contains the GPL COPYING file is extra evidence.

NeilBrown


>
> I do not know John's relationship to mediatek.
>
> commit 8b634a9c7620b15691322cd53071122d2ab249a7
> Author: John Crispin <blogic@openwrt.org>
> Date:   Thu Mar 15 07:22:35 2018 +1100
>
> John?  Any idea of the providence of these files?
>
> I do not see anything like it in
> https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dtree;f=3Dtarget/linu=
x/mediatek;h=3Dad50ab7e407372a482aafb4183c4e49e25f93739;hb=3Drefs/tags/v18.=
06.1

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAluq7vIACgkQOeye3VZi
gblzaBAAkkcqsKncGkHdRphw33C4GUwFvqBrsRQ6WbhmtzYVKS3KCXMlDZYHKulD
GI2IsoFdBVj8GNCKBBneR9cxy6zDTAXMyW5FfUihjty55cDSi8ABbRbEfbfxhkwx
05VgU17whypKyS8BBcR0yu7lSjmBQ6EI+FwOmqo73m+LyNsXT9PDAXeXJsAfAMff
1Nt/+AgqtVPMAv1NVbWR9ZpJnm/9Yrp3dA/FP8ofIdIAuOBT8St3dAu9PFxijTNr
8ToCIYoqgwVxhoqYd0MIUfNovlJrkElL4XCImHxxul870oWXp21SpflpoR+i1903
dfACkV5R6jhRGDeiWtJa9EQms71qTtpMgeyp7bgg5z6V4ziVGYRetHtQYGGf2fWo
pITrJNDr3S/kCoS2A8oG79Tatn/qvGEaOBnek5HS3Fi1y1OCWA8FGTXZV/iliopP
6dN7pDJlPO1hd5Df1ifq5A+d6l+bC1qDQX8I5U1EoaDnt4Ip5xUblFUAhs+496Dc
r6lVp87G9QQRik4phSyKGJetJo1wbeh7qIK7Cky87w6DEfav5kG437aCQYbvpVpP
4A9Yfj1ktxTp1VblIqlDZ/ujiokr07AgasKRW4/vNXj0MQ474d8XP26J1IgN+ayz
Z4C+QLvDm3rJaSlhxDGrznZQYgrl4e0GhpkC/OhQxRLSUh6Moqg=
=9+h4
-----END PGP SIGNATURE-----
--=-=-=--

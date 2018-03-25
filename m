Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeCYWUN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:20:13 -0400
Received: from smtprelay0204.hostedemail.com ([216.40.44.204]:34484 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751177AbeCYWUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:20:06 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,shea@shealevy.com,:::::::::::::::::::::::::::,RULES_HIT:41:152:355:379:599:800:871:960:966:973:988:989:1000:1260:1313:1314:1345:1359:1437:1516:1518:1534:1541:1575:1594:1711:1730:1747:1777:1792:1978:1981:2194:2196:2199:2200:2393:2559:2562:3138:3139:3140:3141:3142:3352:3622:3865:3870:4321:4385:4605:5007:6119:6261:6506:6742:6747:7281:7909:9040:10004:10848:11026:11232:11473:11658:11914:12043:12296:12438:12555:12895:13255:14096:14180:14181:14721:21060:21080:21451:21627:30012:30054,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: pies90_3abd1722ad22b
X-Filterd-Recvd-Size: 3761
From: Shea Levy <shea@shealevy.com>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, openrisc@lists.librecores.org,
        nios2-dev@lists.rocketboards.org, linux-m68k@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-c6x-dev@linux-c6x.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org
Subject: Re: [PATCH 01/16] initrd: Add generic code path for common initrd unloading logic.
In-Reply-To: <20180325191740.Horde.Cymi0yr0xcQQV1s42wkNkg2@messagerie.si.c-s.fr>
References: <20180324174458.26423-1-shea@shealevy.com> <20180324174458.26423-2-shea@shealevy.com> <20180325191740.Horde.Cymi0yr0xcQQV1s42wkNkg2@messagerie.si.c-s.fr>
Date: Sun, 25 Mar 2018 18:20:02 -0400
Message-ID: <87r2o7u7al.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

LEROY Christophe <christophe.leroy@c-s.fr> writes:

> Shea Levy <shea@shealevy.com> a =C3=A9crit=C2=A0:
>
>> Signed-off-by: Shea Levy <shea@shealevy.com>
>> ---
>>  init/initramfs.c | 7 +++++++
>>  usr/Kconfig      | 4 ++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/init/initramfs.c b/init/initramfs.c
>> index 7e99a0038942..de5ce873eb5a 100644
>> --- a/init/initramfs.c
>> +++ b/init/initramfs.c
>> @@ -526,6 +526,13 @@ extern unsigned long __initramfs_size;
>>  #include <linux/initrd.h>
>>  #include <linux/kexec.h>
>>
>> +#ifdef CONFIG_INITRAMFS_GENERIC_UNLOAD
>> +void free_initrd_mem(unsigned long start, unsigned long end)
>> +{
>> +       free_reserved_area((void *)start, (void *)end, -1, "initrd");
>> +}
>> +#endif
>
> In powerpc this was an __init function. Why not also put the generic=20=20
> one in __init section ?
>

v2 series sent, thanks!

>
> Christophe
>
>
>> +
>>  static void __init free_initrd(void)
>>  {
>>  #ifdef CONFIG_KEXEC_CORE
>> diff --git a/usr/Kconfig b/usr/Kconfig
>> index 43658b8a975e..fd79d4d6fa26 100644
>> --- a/usr/Kconfig
>> +++ b/usr/Kconfig
>> @@ -233,3 +233,7 @@ config INITRAMFS_COMPRESSION
>>  	default ".lzma" if RD_LZMA
>>  	default ".bz2"  if RD_BZIP2
>>  	default ""
>> +
>> +# Arches can select this for a generic initrd unloading codepath
>> +config INITRAMFS_GENERIC_UNLOAD
>> +	bool
>> --
>> 2.16.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlq4IJIACgkQXAvWlX2G
/ie5Kg//WRsmE69HlU4LGgsmarn8fdi2QRuZ+l/ywz9000PwGi2Rf2prd6YfK03r
r/JSOgq3kCyGN2ifjCa++0IAvJT438Yzjxieqi5t28mm58I9VOfaWhGebd9gq4vV
xaFLnrTlbSYSPMlhm4gbjDv13na+i+qm6Gqje/TF5AILIHTXxfxg//SgKY0vaAPi
xBZJCaCEZJdO84/mVKeqO/Ape+/ibxtmjDtc/CIxyt8uSPeBqDqkxyQO8/1DFXea
UhYDdnzRyqzG4JGgC+CvrV6T6b8Z5yKFUx3w0CSfE69ypeYHNnzCRVOsPNGxFGQD
v1INTKVjedr9J9PvrtZZmRKHgmzwRgVWPp9uiNIcxxJcuywfeoI/sZwYRRfM2wnB
1pMZsQI1Z4a9GIZ/j9GORajQlKOGp0SDSEDFBLBQ5JS7X4CnFrN/6b/I+AMeBzLa
rK70FQwikNVuWXpOtRh0BEJClYE6HdjRqrkvnOt181vZOb8GPVabu69a7xI8fGCm
B7nn+GLpD3SUGNRaUfWk76hrt+Kz2Dlg/5ATDcEHlkw+ZQypwR18Wop2qcuVcpsp
XjiACAXCDtI5vyud3S0d9ucED0YV90VFdnFfSOs0OXnGPrOfj2Zo6sKPMHxpNzF4
ni7nW+ciXNm79Ex05TQdxB4Z6hZ5g6/NFkdbGrOEvjUvcFBNnEM=
=IIzv
-----END PGP SIGNATURE-----
--=-=-=--

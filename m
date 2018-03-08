Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935582AbeCHTY6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:24:58 -0500
Received: from smtprelay0182.hostedemail.com ([216.40.44.182]:55087 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752060AbeCHTY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:24:57 -0500
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,shea@shealevy.com,:::::,RULES_HIT:41:355:379:599:800:871:960:965:966:973:988:989:1000:1260:1313:1314:1345:1359:1437:1516:1518:1534:1541:1575:1711:1730:1747:1777:1792:1981:2194:2196:2199:2200:2393:2553:2559:2562:3138:3139:3140:3141:3142:3353:3622:3867:3868:3871:3872:4321:4362:4385:4390:4395:5007:6119:6261:6506:6747:7281:7903:7909:8603:10004:10848:11026:11232:11473:11658:11914:12296:12438:12555:12663:12740:12895:14096:14180:14181:14721:21060:21080:21627:30054:30090:30091,0,RBL:75.104.64.251:@shealevy.com:.lbl8.mailshell.net-62.4.0.190 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: bear67_48996b190cc16
X-Filterd-Recvd-Size: 3204
From: Shea Levy <shea@shealevy.com>
To: Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: Implement free_initrd_mem.
In-Reply-To: <mhng-96c45513-b898-42bc-af9e-f24d9909f489@palmer-si-x1c4>
References: <mhng-96c45513-b898-42bc-af9e-f24d9909f489@palmer-si-x1c4>
Date: Thu, 08 Mar 2018 14:14:52 -0500
Message-ID: <87efkuv0pf.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

Palmer Dabbelt <palmer@sifive.com> writes:

> On Tue, 20 Feb 2018 05:50:43 PST (-0800), shea@shealevy.com wrote:
>> Signed-off-by: Shea Levy <shea@shealevy.com>
>> ---
>>  arch/riscv/mm/init.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index c77df8142be2..1c832b541e95 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -66,5 +66,11 @@ void free_initmem(void)
>>  #ifdef CONFIG_BLK_DEV_INITRD
>>  void free_initrd_mem(unsigned long start, unsigned long end)
>>  {
>> +	if (start =3D=3D initrd_start)
>> +		start =3D round_down(start, PAGE_SIZE);
>> +	if (end =3D=3D initrd_end)
>> +		end =3D round_up(end, PAGE_SIZE);
>> +
>> +	free_reserved_area((void *)start, (void *)end, -1, "initrd");
>>  }
>>  #endif /* CONFIG_BLK_DEV_INITRD */
>
> It looks like everyone is doing something slightly different here:
>
> * arm64 doesn't round to a page size, and has keep_initrd.
> * arm calls poison_init_mem(), and has keep_initrd.
> * sparc64 doesn't round, and doesn't have a keep_initrd.
> * mips doesn't round, and doesn't have a keep_initrd.
> * x86 rounds end to a page size but not start, and doesn't have a keep_in=
itrd.
>
> It feels like this should be something generic.  I'm adding linux-kernel =
to see=20
> what people think.

Should I try to whip up something generic?

Thanks,
Shea

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlqhi6wACgkQXAvWlX2G
/iffVBAA4qtJpbFtTcIC6XNUw8OLEJswBW5JvCF++W4wn+A+b2M5CrfnRshamvz5
CYqvxYL4MbOhVEn7UysMfipsC3MMdnq4Nd9//6BgpXESVB0Ona6YauGYuqebkeMC
HmavSIh/TeirfJfjhAVKz5KlAd/OaKHCSsf/3EneNSdavw4+7nlBen9eXAOP83L0
bPNpKpBY74BvTJvyzPCDs+of4Cq5AkPLF3xaJxntcvDxH4LvUoFhNC3NrPAKJ/AJ
0suL3OqMF5sFf9Icvia1pHUCdJ9ADPmNU7Prv5HHwP/qHqppVFwnIABdwwc9hC0f
B+hRLhzjGsB0D7akYy77mxJLctwE1qglvC+KNnbGoCtHhX5fgc2ci4UDErjq10Qd
PykOk5vpwvWezEkQHD+/nhRrytA0EZ9wPaYBPLnZbHuS9hrjHQemoe9+7IGmo8xJ
HwY+bmAxemw1PA9IwNqQmUHI2HsQAHiJ+wrWNPhN97ONrPT9twC7ORuvTiaZDTQp
aP6/kLZ8dF/KCaEPSuRCGs6bjZPDApsElEf7Yy7B2074dYXrMwB+5zG5VBTcxHRV
UVjpXJlpVH4gUUCNs/i3Y19Ca7Xyir1soidEWlxtyWROsVpDCyA+NeU0aRSS9rjJ
KeqhRe0MG9dIL0AJ3WRmsVJRE8c80o8pHjjGc87MP1c5occ22CY=
=5mB5
-----END PGP SIGNATURE-----
--=-=-=--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbeCHTrR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:47:17 -0500
Received: from smtprelay0106.hostedemail.com ([216.40.44.106]:46688 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750713AbeCHTrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:47:16 -0500
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,shea@shealevy.com,:::::,RULES_HIT:41:355:379:599:800:871:960:965:966:973:988:989:1000:1260:1313:1314:1345:1359:1437:1516:1518:1534:1541:1575:1711:1730:1747:1777:1792:1981:2194:2196:2199:2200:2393:2553:2559:2562:2693:3138:3139:3140:3141:3142:3353:3867:3868:3871:3872:3874:4250:4321:4385:4390:4395:5007:6119:6261:6506:6747:7281:7903:7909:8603:9036:9108:10004:10848:11026:11232:11473:11658:11914:12296:12438:12555:12663:12740:12895:14096:14180:14181:14721:21060:21080:21627:30054:30079:30090:30091,0,RBL:75.104.64.251:@shealevy.com:.lbl8.mailshell.net-62.4.0.190 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: fly89_3f32d172fb71e
X-Filterd-Recvd-Size: 3666
From: Shea Levy <shea@shealevy.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: Implement free_initrd_mem.
In-Reply-To: <mhng-dd74e051-4ddc-4ca9-bfd6-d0c1ea5eb4f4@palmer-si-x1c4>
References: <mhng-dd74e051-4ddc-4ca9-bfd6-d0c1ea5eb4f4@palmer-si-x1c4>
Date: Thu, 08 Mar 2018 14:47:08 -0500
Message-ID: <874llquz7n.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Palmer Dabbelt <palmer@sifive.com> writes:

> On Thu, 08 Mar 2018 11:14:52 PST (-0800), shea@shealevy.com wrote:
>> Hi Palmer,
>>
>> Palmer Dabbelt <palmer@sifive.com> writes:
>>
>>> On Tue, 20 Feb 2018 05:50:43 PST (-0800), shea@shealevy.com wrote:
>>>> Signed-off-by: Shea Levy <shea@shealevy.com>
>>>> ---
>>>>  arch/riscv/mm/init.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>>>> index c77df8142be2..1c832b541e95 100644
>>>> --- a/arch/riscv/mm/init.c
>>>> +++ b/arch/riscv/mm/init.c
>>>> @@ -66,5 +66,11 @@ void free_initmem(void)
>>>>  #ifdef CONFIG_BLK_DEV_INITRD
>>>>  void free_initrd_mem(unsigned long start, unsigned long end)
>>>>  {
>>>> +	if (start =3D=3D initrd_start)
>>>> +		start =3D round_down(start, PAGE_SIZE);
>>>> +	if (end =3D=3D initrd_end)
>>>> +		end =3D round_up(end, PAGE_SIZE);
>>>> +
>>>> +	free_reserved_area((void *)start, (void *)end, -1, "initrd");
>>>>  }
>>>>  #endif /* CONFIG_BLK_DEV_INITRD */
>>>
>>> It looks like everyone is doing something slightly different here:
>>>
>>> * arm64 doesn't round to a page size, and has keep_initrd.
>>> * arm calls poison_init_mem(), and has keep_initrd.
>>> * sparc64 doesn't round, and doesn't have a keep_initrd.
>>> * mips doesn't round, and doesn't have a keep_initrd.
>>> * x86 rounds end to a page size but not start, and doesn't have a keep_=
initrd.
>>>
>>> It feels like this should be something generic.  I'm adding linux-kerne=
l to see=20
>>> what people think.
>>
>> Should I try to whip up something generic?
>
> I think that'd be best.  Nobody has said anything specific, but it's gene=
rally=20
> been suggested to take bits that we copy into our port and make them gene=
ric.=20=20
> If there's no clean way do to so then I'm OK taking this, though.

OK, will add it to my queue.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlqhkzwACgkQXAvWlX2G
/if5LhAAsb8OQS+3pTHqfAUa53/iZKK1agYZCoSoP20R3VZs32PQq3pK0pYb2lJd
5ITGHLhhXgamMI0KJAA31kZEW+EWDCxuPP+n8oU/6kxgOSQRI1gjWMOwVghUInql
CLYa2XqFtkBPvK4lAAvrSSlE7dzu4AeJTRTeVjiE3DhODlOq3JIh/9pphw0DKfAH
HcbFCIxcPsu4ksQ+d9szkFZSVfS+AWcXdZSYKuK4qhndx3DqyLX0eSwH7l+EXFkt
Macl3hNeZ+WTjoBBSoFhSOBjWt6M0wulNXPgDkUCQdrkaMRa82Z/CfowPTmCy0ov
JIH+hlv7BoliUXqZVXREFvVluEzOX2BaOB44izo/21vdUKmNQ94GIVopifB07c9h
Y356WWq2dTCUlhRQiNleS7z11bZOeLzTaUbygKtIczEVW+GGEx+ABGmCPlO/wI+Y
VMsDrDl+Rp7NFUmMt3SYPRHNaYgbl8MJVIn+Rpb2pl4LvqWoyzGSXS+HkunCEOs5
TAvu3ADrHAQW5JxzjEVB6ZAF6ZhafwMeVvCSjBel6HfbQt6GqGd0DJ//D6ZQMgD6
3kZEgR8lcjVwoI2lhqBomis30+6vtAHtq79cnMcsJ6nB5cnWLp5Wrmj9slhrkZGO
yVFmDmcP+Gx2g5c9MYNFgUsIbOucsssRpfMZztPF9yNXdWlzp5Y=
=k2X0
-----END PGP SIGNATURE-----
--=-=-=--

Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F70C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55AA2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="a20GanVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbfBRVlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 16:41:01 -0500
Received: from mout.web.de ([217.72.192.78]:60023 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbfBRVlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 16:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550526037;
        bh=vJSkVEKlrv/ssvxyfKzJB2RgCHOqNWKHXy7j7pXgT2A=;
        h=X-UI-Sender-Class:Subject:Cc:References:From:To:Date:In-Reply-To;
        b=a20GanVXjx1L5tuH2kvjKSkKVbyk/6KRnyhk/cxQ/v8x04X8juod1tL14kYUzEjVf
         xirKR6gEQzqZLsYoTGBaD4waWeOpR/5IO8huqjAHrp0WcteAiVlAA0fLrHToTF4grM
         Jxk1XzLYLRepxtIxCS+sg/Gw/Rg2vlo1HiSjoZ+A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.162.105]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MLPNm-1gvIQB2elG-000c6o; Mon, 18
 Feb 2019 22:40:37 +0100
Subject: Re: [v6] coccinelle: semantic code search for missing put_device()
Cc:     Wen Yang <yellowriver2010@hotmail.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
References: <201902181122502228026@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>
Message-ID: <730810ab-5bea-4a8d-54b9-37e1fe2d1498@web.de>
Date:   Mon, 18 Feb 2019 22:40:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <201902181122502228026@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BxI6O3w/BQhd0JdaZbCTgi9ZFlGDu+xa9c19YFzJWO+f2XbAES8
 k3Y6GqsaCyRuXQKSetrZS6pPrDSRnqc9cEdmjgw+VuKBQSCKhk8z0NPUprCGLp/+ZW0YrMf
 CVNRl2h4mvR6dhe6iquTka/jKsGZ7NuU0ASJCeEOAFago2LZPL8OHnGOUCKyYRrNpD9SyeL
 CHKUF6TYkn5Z4ZHu2LE0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Q/A4GdK0DI=:XTDjzgW1PRjew0HJ+xaUNd
 CVAsMRaXxEkYa1M1aY7Npm7atySDXD+VrHCVWLOFdTQ74Hh0stj5MBiVMBcMZ8xG+YrR7MA2n
 NHGilpO3/dYegBtWjAMRXEFltUfnoXLuHsI+ZaCyxxtVeQmybpKz5sf/R3frKIJVCJmsoma45
 9KHV4vC2LJwx8+1+URF8SY82Esnm5qOm3bpeRdQluWiORKYD+7DFo8lxQ5350wboR2GljsXRk
 6e3wFK+sT8edSnH+Ps2YPysBC5a0XXCNspwLV3KfA5uw1RD+hfKQ0NDNpm0xdEsn6rMjWcQRS
 FF4Nj9LlWm+Y7GSn1Og6IGSg5FVwiXWGK3aUCL6fm2kEzSnVS1gNZiLQ6BhUD6I4Cafh6yBb3
 7LAStY3mBOT2czMsrCv8PHS4y/qR7PAQSmaXGfs0pMWXu2g5jUKz7FCteQJnGbiidsc3jCSP4
 8XcdWESf0gHYfSoKp720WHfxNjPLi8Ui8YTzITchiBzQJHgJfaIdq7x+1ukEGP88iQEaJoTca
 pqz2ujYIHs0qiU4cTpr1AF5kQ0iESN8It51vbIUBtT9dXf43U3GgCVbCFPJaZA6ibJUCoeH7W
 j+2b535JQDDi4wQyYwKf2CkIyxSY3Hojjo7qa1MZR1RSTNaGZV/Hb99jV+8TP1sg1yC6JMi8a
 nXpUWSjMzb/Jv/k6kVmyzTau5HGeFnXT/oe1v/2ZzERZ8fct4YU2yFvlOcapYZ6LvkFIDT5ty
 t91ZOIEwwWA1pJz5Ocdn59JhPF3ck2Ooc4S/3rIQD9ZybASiokrLCr3w2LuHYysSa7dZT2YjD
 Affo9+l3x8G31Ip1FP7eYJkMLCEC3XWnwy/DZrkikpKhec8t4ucM26kHe2rPGyumahj5CiUAF
 LeuaxKsblvY3Z5198JpJNYQhiHDZQxWPvVrRLXfoN3nxI69+jK0pGI8Ei2/rFoKnFaGEz/FAQ
 0Q8WMMKTfyQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Which data element should not get reassigned here (before a correspondi=
ng
>> null pointer check)?
>>
>
> Thank you for your comments.
> We did some experiments:
> +id =3D of_find_device_by_node@p1(x)
> +... when !=3D e =3D id
> ...
> Or:
> ...
> + ... when !=3D id =3D e
>
> The number of issuses found by these two methods is the same.

Would you like to clarify the circumstances a bit more under which
you would notice corresponding differences?


> When !=3D e =3D id achieves this behavior.

I try another explanation approach for a potentially safer source code sea=
rch.


1. If you would look at the following SmPL code lines again,
   I imagine that you can determine also an useful constraint for this pla=
ce.

=E2=80=A6
+ id =3D of_find_device_by_node@p1(x)
+ ... when !=3D ?????? =3D ??????
+ if (!id || ...) { ... return ...; }
=E2=80=A6


2. Petr Strnad expressed the need for another constraint in the commit
   =E2=80=9Cscripts: Coccinelle script for pci_free_consistent()=E2=80=9D =
(from 2013-05-08).
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/scripts/coccinelle/free/pci_free_consistent.cocci?id=3Df7b167113753e95ae6=
1383e234f8d10142782ace#n12

   I find that there are additional software development challenges
   to consider around another desirable assignment exclusion from the plac=
e
   of the return value storage and the data processing possibilities
   behind the corresponding null pointer check.
   The previous approach worked with the metavariables types (or kinds)
   =E2=80=9Cexpression=E2=80=9D and =E2=80=9Clocal idexpression id=E2=80=
=9D to some degree so far.
   But it is expected that an undesirable missed reference release
   can be safely pointed out only if the received platform device pointer
   is used only within a found function implementation.

   I would interpret this data flow requirement in the way
   that the pointer should not be forwarded to a data structure
   with a scope from outside (global?) the found function implementation.
   How would you like to express such an aspect by the current (or future)
   means of the semantic patch language?

Regards,
Markus

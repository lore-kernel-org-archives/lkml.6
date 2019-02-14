Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA13C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2ED4222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="VHrh7Drv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438217AbfBNKBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:01:44 -0500
Received: from mout.web.de ([212.227.17.12]:42715 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391135AbfBNKBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550138472;
        bh=UpdSdcSNY9uqdPNT4Pb1MVMa0ay4aPEN4V3Qc6wkzwI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VHrh7DrvLVIwg53zZQ/3NgXBp7MTim8VPlkE+QEyck4kzlYv8eOGYFM7RXsxXlD5z
         ify//qLOucN1ccZOuu90+VkDqglEiG8vFiuLwA5EnPdmbrjdBncSTPnc96OegW3ET8
         p//j5DYXPkkJiLo6221UCu+6z/vhUTW+QGJgiqNE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.97.110]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MDgLi-1grPTK37oU-00H6Oo; Thu, 14
 Feb 2019 11:01:12 +0100
Subject: Re: [PATCH v4] coccinelle: semantic patch for missing put_device()
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <1550126293-27839-1-git-send-email-wen.yang99@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7c4e26a4-32b9-e1f8-beeb-bfa4fc9e6128@web.de>
Date:   Thu, 14 Feb 2019 11:01:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1550126293-27839-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uPbZOw1bAXbLPKvVSU+ApZVLQKFrw9CJUVK1AqhDPtu71KLmWva
 G8RQuwOZpq/+psJaSPq2+0/JUbshr0kxKQPRwOn3hCzsP1zQ4s+BkS9oRBSAm1f7B3Wz1WC
 ib0YZno0+jrETVvi4u/7lk7nGrNrMEzOGo7BZSVdUhPOTy/DX6/dcvgv6HZsXcHTAaUQ6dA
 3Kc50QjmSJ8pIxgLekXsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4RD1Khhb85E=:RqbvCBs6fo1ldhu0OhpeXe
 AKc7uBoZgJJSbejH/WaMxpCwysbK//4XNCzya+clHfft6hYsVNbK0JFX74aQrRhtFX+p9dNsg
 0uOXpXdqkiOYS8rzX1yyLqcqmGsoysAIlVZCc8F7PHvn214NJrB7ehWlvrEquqs3ZLPSS7IYu
 CsTST2uWBvtM3sFxJarILce7rujoRCKmtX3boh1cV2z0SZqLhZGqibF0UsAmSdByeF9mn4GwG
 VBMWO7+jIFEr8/ZcCKCz+l24bamqKBWQrcrjwjCnvVhi4QsICPBekvQrypLs+THHppzQIWiNf
 DYPl10qKmZmqDrlgeqDX9nW2Al8l/fTKTJw1SwBSSM9G6+5OvX+jRTY4nXTpeLaIczO/+Jpmy
 wE5J1hJ0p3VC6ibkG8xYIf6bojM9YCldWPSxn3ZASML4SXWshCSaZCXaRWRGYvoLwkwAvNnj8
 MH42vv9MfYxzEdcNlJVGOsSCdIGLUDi+Vz0oGhu4eofYGxtURe6zIqhUvv87KAOLz69wPNeaX
 wufzHqtnbfriA+C2U0FP/US1EfXovxD+2h8SW2khgkK3TSSNleY2cL3JiFtZZ6XHKaVUIfVaY
 2s4n1FTu20iRzxYLJDZvztKCxU/KDGjfPOxZntkDtsvJH11YdzGK9K+JIrc+sNxLmjSydRHfA
 hEsA08u6VW8i+5a4FOW5nHcOvqfuzs5hX31XBQZ9erBLnZi3qDdAv8Z1Trk+8cyQD6I6SCq9l
 H2UdWYyKYkLxT7nG1/owiaLGsElnpQElVuY8tgL0bureyp0oG2cleOJL9ursLaLRaAegBeMtI
 V16U4PXpFI3VezB8tbMFs5Um6aXNktuDFJOsAFrV98oA/gWQhLnA+FvlAgXq0oMCywJJabRDH
 o2Fmzeebh42rd6lQESa85ZunoWMR0Xih6HbwDk/0xYSEFXep0Va0dAD5K29veke4riC+6ryBq
 1FM1k/DcHeg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The implementation of this semantic patch is:

Thanks for your extension of such a commit message.


I would interpret the provided SmPL code in the way that it will not gener=
ate
adjusted (patched) C code so far.
Source code search results will be presented by the operation mode =E2=80=
=9Creport=E2=80=9D or =E2=80=9Corg=E2=80=9D.

How do you think about to exchange the word =E2=80=9Cpatch=E2=80=9D by =E2=
=80=9Ccode search=E2=80=9D
at affected places (and in the subject) then?


> In a function, for variables returned by calling of_find_device_by_node(=
),

Do variables really get returned?

The provided pointer should usually be stored somewhere.


> c, for the rest of the situation, the current function should release th=
e
>    reference by calling put_device, this patch will report the
>    corresponding error message.

* Do you expect that the desired object release should be performed only i=
n
  the same function implementation?

* Would you like to pick any software development challenges up around
  inter-procedural data flow (or even escape) analysis for the shown use c=
ase?


> Further, for the case of b, the object returned to other functions may a=
lso
> have a reference leak, we will continue to develop other cocci scripts t=
o
> further check the reference leak.

I am curious on how these approaches will evolve further.


> +// Copyright: (C) 2018-2019 Wen Yang, ZTE.  GPLv2.

Would you like to add a SPDX identifier?


> +coccilib.report.print_report(p2[0],

Thanks for a nicer indentation here.


> +			     "ERROR: missing put_device;"

Will change confidence considerations result in another fine-tuning for th=
is message?


> +			      + " call of_find_device_by_node on line "

I find that such a split string literal can be unwanted.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?id=3D1f947a7a011fcceb14cb912f5481a53b=
18f1879a#n94


> +			      + " and return without releasing.")

Possible rewording?

+			      + " but without a corresponding object release within this funct=
ion.")


Regards,
Markus

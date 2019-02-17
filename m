Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740C9C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 11:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D4A2192C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 11:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Wys8bPr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfBQLnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 06:43:31 -0500
Received: from mout.web.de ([212.227.15.3]:55287 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfBQLnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 06:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550403784;
        bh=uLrzBMyEsVLafbDmEBry/dMS/FwaEVrPyh9PeDPsqTI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Wys8bPr+RKxoKf4WpJtdFLC1xoCZSjLAtLxeHs7f1h71ZElex17qdbPdmJrCdAjwq
         bJvVWyT7Z0UDcLR0t2a67UaurMdz1x6YRBKg8MgzxI/eMM0KV3aQZhsVMAhV7nfYHl
         eXzG51rsREJCRFIcgqFyHaHM9awutD/+wxBGTqJ8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.167.97]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MSaea-1gW0Tc1tps-00RYlm; Sun, 17
 Feb 2019 12:43:04 +0100
Subject: Re: [PATCH v6] coccinelle: semantic code search for missing
 put_device()
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Wen Yang <yellowriver2010@hotmail.com>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>
References: <HK0PR02MB36344E2B29CEB195892F6420B2610@HK0PR02MB3634.apcprd02.prod.outlook.com>
 <8e7ba7c0-b7fe-a1f0-d28b-0c716ecbcfdb@web.de>
 <alpine.DEB.2.21.1902171235570.2444@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1c152067-0135-79d7-1285-4bb9925054c8@web.de>
Date:   Sun, 17 Feb 2019 12:42:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902171235570.2444@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QAs6cBfuHiFrpIdepJJUhXGBf2VFHpYaEtSoJ79Dd0SpPNn91nR
 dDDLgra1VnGDpQQOTwzJQ++bHqlJYxN8l7nTYLvBtfr5hkiNbCvQ8NYFl84AiPMr4kwsVhS
 S/tp2y3+HTmA21RdKOcGSjnw1U5e2nzzM4GUAOumlOWt/5/cfpu8fMxR8rcrWQ+cs/JE8FG
 QNtz0ut2YEHDlfzXNcHiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aRcCp9rdvUs=:7rGNuA0GrkB6qfCNyBkYJ4
 jjRF5FQ5fGHe/7HhNorRNztynf20kLyvyWbij7SNdeHRIG1QLFX7G39n6hjI5ALD7jJhQiqHI
 6qeoFQ3rgkoz4RhCa40+kaK2X6lIlrV6htxUse+n1jbzuaUIGiFprIhrdSeQvUNAjD3UzmO33
 Y4Bw0U9wZ/R4F0LO/8NaZ58zF5okm5lhXXNUS7sDvpGT7TmBBuYKRCR+f2m+4bmJogZZaLPeN
 QNoXK6WGvsY5q/bgeS7I3TdXK+JBbx6OSMsWWJOfdLYl7sgRakyqja/jdL/FDYFTNOixQOwzl
 fTix6gagE3GoqJORhIGXzr1mjOjI0RCKQ0liT6iN0qVYjN6k9Dyjn9k3vg71vT2fXALhmCwkS
 zmh7Xh7KB++G0PktvgBvoHRz8MP3h92cmu+s/3633yOXy0gavCurxXChapHXeFcuUWbFACKb3
 9bcD2nbVxjmq/0LgSOHi4Mjm6y62RdM8pZpl9nPrrTu1tFdUvHNw3GYY1ObqKqmeNHOqqpg6+
 DlyVAljiCgrivea/fxXRJ+dIHCyuF/mxLEQ48ivCmSag12mnV8ruZk4wbXfd/3r1CebgUj9yH
 +B5zOiJFu6zH3fLIM6khEzGr11VR4/GrsojdRwE8hndjMGZx4TFajm7cnkTa0BkyiU4uCfpm8
 SK3xGU9klwtgL8Hk96esdBe8nzXYZH76G7/MBI30d7YHGoZit0rnk2DsKgLN51Ujtq8dWWG2k
 FQfmtL9J6Vi+2qGZnvA5C7RGpinyO394xoA2TA5I3h9XgPbF7mZum9n0h1+bv7Dp29Ngsb97i
 FNP1g+LqhgXbShHbAR58z0s4jDot3KSsbJhbLd6aXO5K+sbrj+FNBhdkcibfQMeifM0g07UfM
 PgA/XjQURD/2dhs5BSZn9cJRcJZVdMCT+Q9igro/EulJY1R+Axjz8ng/V6dC7Nd436uAFhvU9
 m2tuNeKmHtA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +@search exists@
>>> +local idexpression id;
>>> +expression x,e,e1;
>>> +position p1,p2;
>>> +type T,T1,T2;
>>> +@@
>>> +
>>> +id =3D of_find_device_by_node@p1(x)
>>> +... when !=3D e =3D id
>>
>> I suggest to increase your software development attention also for
>> another implementation detail.
>> Source code analysis triggers challenges for safe data flow handling.
>> the semantic patch language supports search specifications for
>> the exclusion of specific assignments.
>>
>> Does this SmPL code contain a questionable order for the source
>> and target metavariables?
>> Can the following variant be more appropriate?
>>
>> + ... when !=3D id =3D e
>
> This is possible, but I think unlikely.

Would you dare to interpret my update suggestion (reordering of two identi=
fiers)
as a required SmPL script correction?

Regards,
Markus

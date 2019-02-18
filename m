Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB14C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C4D218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="i8aXmBBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfBRIUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:20:14 -0500
Received: from mout.web.de ([212.227.15.4]:46969 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfBRIUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550477987;
        bh=Gzozkklv+IHrtUVNGXYvPX4o1QM+OQ228VE0F162nxc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=i8aXmBBnKf73ERFLeGep9+fHFIyALksZYSXfy42o12NeV53tTxdM5zIvhHIio5XrC
         JZJ8H31M0cmk29B+jE8z/IsRg5FztL+eH2fLx83v46exDSupIGvMXh/OpBPEVGgWHt
         O+Go+F/2AeVtbyPuKxrH6saa+hwO4wwlbpI7Nc4s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.162.105]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LvB6w-1h3vai44OY-010KC0; Mon, 18
 Feb 2019 09:19:47 +0100
Subject: Re: [v6] coccinelle: semantic code search for missing put_device()
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Wen Yang <wen.yang99@zte.com.cn>
Cc:     Wen Yang <yellowriver2010@hotmail.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
References: <201902181122502228026@zte.com.cn>
 <alpine.DEB.2.21.1902180740550.3111@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ab463e94-287a-6188-6795-06eeb832e861@web.de>
Date:   Mon, 18 Feb 2019 09:19:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902180740550.3111@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s0Qmnm++jcdIjGkNjhKEHp/e/fkruH15Vk30MeSnGtIxaR+5ES2
 I+nhhcnV81gqKecXZaUUSfA5Y+t7+Vj+f0GiwwuibFwgtDahkC010SXnbtLTWFFKh/JE25r
 6BkZkzhf2+qyT4ApmHP5kw7y6BnWaPxdwrVmEzuQbEvAUxbkQSeyea+z6N+PeMo3Fq1pHXf
 PRNae7VG7AHnSbNbOxoiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rqHtMltt+Ks=:kbdKVSHjB9PASC/dWqG3Cp
 kSimnsKneM743zklCXJFnyoGdIMYaVV8f5hvCQFQQnlKF3mbhcpi+LTw0dxqYCj/UR0WHgvb+
 AP5aCj/JPLwNZDFNfmTIjLMuJNJIM+GvZH3uXJJK1KITPNUVIfUb+s+n/CSU6jtX8TKyBrch9
 ka7QKHcyf8hR3pe4N3YyBYEHmGbAZXWgfFm8J9+WhxeD254gnG27Vcdb5P+pt8zuYsr0SPVAE
 nqO2wRxjlQy9PTIYgLNDjfG++6k+N96eziaoJvCfEofLay83/Q4jzdIqUoXzZUrud2OcEblmx
 j0OsFyw7Zhf3IC3J09bFwmJ4Ih1QeMaG/HmctAru4XpO7k9ld4uzGUiGKSPixONMYUXQdYLxH
 nhGYVdVoUX3te75RGzI1RBuyTv2inAh+0KtjnFUtnuhzxl9tD3tkIKyv7eS6BTYYSfBstppW4
 QLyQtY6w9LkLybjNH6BVk3/+nj0lfBUZts6yzy/qHLzQzLiZYkVMAP5Vp1BAB6Vl/c1KUuugR
 UsRiWh7lg0mrizvi32BSHVJJir8BWBQkp8le6gYAOxt+dQVaGbgxX0UAHa81VGM50pgYRu25S
 fDv06X4pzNKOxE+Lz7tIVe6NT0Rh68y8J7FHqwbB3vYJ2xmbWzanbLn3FFda28kLmCN6FMxH9
 rcD537sCkcKLlH+n7g5mZItuYK0CPIX3F4ebaDjOfXNLVZKvRu2W5XPL9XvQwwPSnxCPRl1Lm
 M2QynyczVFcBPBUxRnd+NYHXd3FKQTeocP9jjQKtTB+djXZ+roYXJRkWJMGxO9ypmIMK5zzjE
 5WpTHxh3jLBPjXMj5fn8qn+3iGNSJG8i6om++v1Te5l26kIDxc37nUzhYVh097mypKC0Ko9Xf
 vE53cOfd3bQeZxjfom/9pVvG1fBuLWGHZ5rpbt0cLilPo15ty2ZZSmM2PTA0976U1Ipnnc8Sc
 y1kzLWHy8yQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Which data element should not get reassigned here (before a correspond=
ing
>>> null pointer check)?
>>>
>>
>> Thank you for your comments.
>> We did some experiments:
>> +id =3D of_find_device_by_node@p1(x)
>> +... when !=3D e =3D id
>> ...
>> Or:
>> ...
>> + ... when !=3D id =3D e
>>
>> The number of issuses found by these two methods is the same.

This can be because these SmPL specifications share some source code searc=
h functionality.


>> When !=3D e =3D id achieves this behavior.
>
> They are the same because neither issue arises.

You might not notice a difference from a specific source file selection so=
 far.


> I would have a hard time saying which one is more reasonable to test,

I suggest to reconsider the interpretation of this software situation once=
 more.


> since both are extremely unlikely.

I disagree to this view because two ellipses were intentionally specified
in published SmPL scripts.
So some software developers found these =E2=80=9Cspecial use cases=E2=80=
=9D important enough.


>> In addition, we feel that we should probably accept this patch first,

I disagree to this imagination because I would prefer to integrate a sourc=
e code variant
without a bug (which was copied from a version on 2013-05-08 by Petr Strna=
d).
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sc=
ripts/coccinelle/free/pci_free_consistent.cocci?id=3Df7b167113753e95ae6138=
3e234f8d10142782ace#n12

I hope that nicer run time behaviour can become also relevant here.


>> use it to find more memory leaks, and solve the actual problems in the =
kernel code.

Your are not hindered to achieve specific software improvements with evolv=
ing
development approaches while the clarification and the final integration
of useful scripts for the semantic patch language can take a bit longer.


>> As for the patch itself, we can continue to pursue perfect in the proce=
ss
>> of using it to solve practical problems.

I am curious on how your attention will evolve further for the correspondi=
ng
software correctness.

1. How much will you care for the order of identifiers within the applicat=
ion
   of SmPL assignment exclusions?

2. Would you like to take additional data type restrictions into account?

Regards,
Markus

Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CDFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42F22070C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="WipQdTun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389347AbfBOHLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:11:47 -0500
Received: from mout.web.de ([212.227.17.11]:34553 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731694AbfBOHLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550214682;
        bh=l020NQrCXuoRcZwtBtQtTsHgRdJNFOd/yK+lhRk3/2k=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WipQdTunGvsIy4e44N06/DJe87GfJUdS0K41OgZx4q0lOslRUGLpC9+NW3lL/y98O
         SezyG+KLzfTtxnWDDMZh0sW4Y5EcVEdx2mgcXOj3YRWKqAzqreM8O8oBP6qPxnW0Kp
         H0hkH3Q5HLmtKdYIi0+tnncgEyxmu5dmjtrtDY3Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.88.109]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWRzK-1ga77o0pyc-00XcKy; Fri, 15
 Feb 2019 08:11:22 +0100
Subject: Re: [v4] coccinelle: semantic patch for missing put_device()
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Wen Yang <wen.yang99@zte.com.cn>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <201902151422261425412@zte.com.cn>
 <alpine.DEB.2.21.1902150723110.2896@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c7fc1e2e-306f-9c2f-e271-0c8de9128720@web.de>
Date:   Fri, 15 Feb 2019 08:11:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902150723110.2896@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RZhYdniQIpuJv7iWvgBrtYLWinXOmyaTKDIV4g/9ChfdNwj1q4I
 PHmNmA+TzQjaSXN+tjKybgbmrfqQ3KlGLudgHL47KxbrtOf07A5Q4ve8W2svko+jldPybRx
 WMqatVzBL5KE3o0YR7/w1t8xFN/vLPJTHs5XMr4zlO0W8FB/XJdmbIKHHOVcXotWQmDePRT
 hp54uoBkYSG4LJLd45IBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u1k8Tfc1OyQ=:5AeQHIQk4Y5kUeHECA59YM
 oaIUcMmhgzqU89e0UPC8xMJ20A594QfIRTzDH/iJ4s1vuas/OOKSQYfKi81qfmHyWtVvfRuMw
 +oFGCm/vFsmdeuZfdKZ4MZrJtHGb/NM2Znu2wVhLTl6l3mH1n4amH1hEwNvR0DUN9FItfllOU
 8wfeI71aaluuJ1GENxx/7tPY+lQuySzLU7XvypvWyE7e3w76QmH7r0jahNT4kDG7PSL6eSyR+
 04xu7829GJXC1H3U2PU3fRfgammQI0YsXrlATB+7vyLTNyqHzGoTnTbUXhOfxFGweAY5Ner7U
 0Np8ngceTkW4t8EYH9PAVtxIVetT2p6AKOozMZNxrU84ORv60XdzqE+l27qNMwyXvZnDaWAgF
 eDpGDebEHKUv+OjJHiKfwWncRcO9AyI816fLQ0ufCRkFZyueF9GE0EQMOY1e/bbk8kPJxSQOs
 L3yo4OFRruYOtnN2PXu2vUvB+AMY3ZXWPwoDGaF7RnzDQSBBnjCT1LRIc8SDWnYdIH0I9sky3
 9bAYmBfS7gBXrhAovaLg2LypJW7p1Fz6onh2+Cjx67nwd5FfeMI3nTeFkvHN9ymKSuDsbazX3
 jsBvPLjd33rOtKg3VcTFFwnWVaHr0J0QMTF2TRA+IMTV+fQP8nG77DK1f5lVaHX6Mm3oXIpOw
 sPmbBOfky0X2m36U0gYXmPjorNnvkIRJIY6r3jwM0iuCOJp4PCJLFdn90Wn6zqGJsw3Y5Iy8P
 5+eA9FerenGmu/L2UaB34mc3p0m3/Jyg4Qp0AKLZLRoe9yI68bnXWSH4TW4S9kh5fS77ii8HP
 rEjF6sLTIn2jg7VNHaV5hTCnN2daKLdUQHV5cl9lN37Ogvgqo6lOOrF0Z8ASylHtpLJ6oajDV
 myZzQ1yqRt8RWi57GjIc2o94oM0f4ZvsR7MW8XrrTiE1Vlqi1ZydVtXk+DqRERUlaPjTW7MDj
 S2kv4levS1g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> In a function, for variables returned by calling of_find_device_by_no=
de(),
>>> Do variables really get returned?
>>> The provided pointer should usually be stored somewhere.
>>
>> Thank you very much, we will consider this situation and  submit a next=
 version to fix it.
>
> I don't know what Markus is talking about here,

I find that my feedback contained details for two items.

1. I suggested another adjustment for a wording in the evolving
   commit description.

2. Should any more case distinctions be taken into account for the data
   storage of function return values so that the shown source code search
   approach can become safer?


> so I'm not sure that a change is needed.

I am curious if there is a need for further clarifications then.


>>>> + "ERROR: missing put_device;"
>>> Will change confidence considerations result in another fine-tuning fo=
r this message?
>>
>> Thank you, we will change "ERROR" to "WARNING".
>
> I think ERROR is fine.

I have got a different software development view for the possible
severity information.


> If it is a real positive than it is a real problem.

I can agree to this information.

You specified also a precondition.
How should be achieved that the source code analysis will not point
false positives out?


> Warning is for things that look ugly,

I am also curious on how views will evolve around such ugliness.


> but don't have any impact on the execution.

I find such a restriction questionable.


Would you like to share any more ideas for safe data flow analysis
(eventually also together with your software)?

Regards,
Markus

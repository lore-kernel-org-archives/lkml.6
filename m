Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74511C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 12:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDDD2195D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 12:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="IMb+yrub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfBQMBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 07:01:11 -0500
Received: from mout.web.de ([212.227.15.3]:51301 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfBQMBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 07:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550404852;
        bh=juINOXX1rrAI7GjI1rH0eqw6Z58dI2T5NMNrAXEKIM8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IMb+yrubYr2pHJHNB/lMZ/yD/OqNsDjLFEV58rzDDv6GZA1LvAlwgXQhnnf65P2T5
         XufaJo98/eh2EkNAUpcKicQfzEOH0DeiOzN9qNuf7ycAVEBB1QQZqfc01Mqcy9oFkL
         G7F5DhUxAOdn3YbDXXRqzZ1vz5td2VjjPU4vHt8c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.167.97]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lcgkx-1hNHc30tJn-00kATP; Sun, 17
 Feb 2019 13:00:52 +0100
Subject: Re: [v6] coccinelle: semantic code search for missing put_device()
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Wen Yang <yellowriver2010@hotmail.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
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
 <1c152067-0135-79d7-1285-4bb9925054c8@web.de>
 <alpine.DEB.2.21.1902171246560.2444@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <782fd1c3-80ff-a296-b3a2-351257bb13b3@web.de>
Date:   Sun, 17 Feb 2019 13:00:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902171246560.2444@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VWUgrBwCqEIUW9iVRR05niGMbMxxeGuh7OrZauP2Rn0D2bIJ0/j
 PialSK4BN3A7ruNDvQnd6i90CThi4JWisoxK2hQ3Kanbz/UU5NjIWd9udPwoFnD/k0BxOQV
 D3PLVA14PRYAWOgpiCTuf2c0k0F1rwbdiEUFYaKXNTXQm2dgAe4pL3dBig/k9rdxmoz931o
 ExFTfl5e7sglaVkQkH+Hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1n1XggzoQ4c=:PQ9EHrmpt7dOBJ4NDBYhJw
 3g0kwJHcAuTv8wFowFowsNNwIjD27FbHP8F0/Dg37MbUgSCpR7SBQbE5wT/96ZKN7+guTAz91
 LzcDfn5h51mTQyGOj9jZPcUWWLTDfZ7Pgn3RIrP99wfHfkFj4/7NgDWAn8lvaPEQPh61svXWj
 oxxtplh3xYcTNI3Lu0ledNJEv2u7TOn8GPLP6nLkqpDb3kenIsR321Vz5cnmVsD4512bbQWrA
 gFVbAekT/m8g+aTKXXjcTdMLTH3VqDW6SwyermLiNI6LZ+ZHkpmNnVDkRGnuhSuO8L1WFmE30
 F3ETZUBZ+N/6GY+8UQMR7Sax0gB9smnHCI7VVfdkcfS7DtaA8uUws0/l/cGdJ8UgtcIJQdQge
 YO/6Mnth823S3EuYfU5lnsIdOpS0tLwwbYs8fTfYPYFutFYACycODsCxYcSk4E2oYjpLbXLgH
 +8ssEcAQttPjKJuD6ofSAkdl4JKR9rHYp8X3ANs6R1aKnV+EK/pLU2fjZyPQQOiWzQSfSxV0B
 6Jrlnw5WEIEnf6gzim8Wu5G6KTUTZlpXKsjeZ6zhsw9jXDg8nPW0qux4W506UQDpSayOUecFI
 HJVYjmPYupfqIMMECUK9JEinHi7gqzTqa3EooCqrSsGhzX82F0XwQYJy6NZMP76jWqnfjbPpp
 LUkf2Qz+oMjico9fetRj/NZ3hXrOJF4kmC8AzVeH1RUOoXgyFjPMEPjPo3UuWlvr/RHaodTx4
 oWW3m+gBhzT1ykZ1xX2lPa+OyfkyElhDtKHBq6hTXht/NK0KiLupPMK1nQLrAk0+EUmPW2idj
 q4Lf2YGeSrDu34NDIHHmqoP8owbVQt8i4s1hhvHCqZUdoUr4c94EMZ0Otd1mBhWNFrqgoTpm4
 S4KgJXGeCUql5j5HXn9ATppRM9hH/x77YsnQeiWsPRi14tPZQo6djW3WcW4hEnRkvqUANPmw3
 g3AoTK+uP1w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Would you dare to interpret my update suggestion (reordering of two ide=
ntifiers)
>> as a required SmPL script correction?
>
> I didn't suggest to reorder anything.

This is obvious according to your acknowledgement for the sixth version
of this evolving SmPL script.


> Both are needed.

If you would insist on the specification of such an assignment exclusion
for a SmPL ellipsis:
Can we agree on a correct order?


> And, no I don't consider it to be a required suggestion.

Have we got a different view about an implementation detail at this place?


> In practice, reassigning such a variable is very unlikely.

This can be.

Regards,
Markus

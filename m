Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D067C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB387222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="XnIS50Lo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbfBPIaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 03:30:09 -0500
Received: from mout.web.de ([212.227.17.12]:35465 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfBPIaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 03:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550305783;
        bh=f4CNECNiiFVjg7NwEFcBPe9doBN+LOHvMhPKbEKzzoU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XnIS50LodG45IWOplqRha8AqADEdheqOG0hzRJsutfmEn4SM+zme09jJrRm2GXl35
         ECY7QVwmYJwdSBH+ei16dV+Fpz7O8ViVx6J1j9dmqX4/29k0NS/igHo7Yacl1qJ1JP
         wAkkEa20VzYyLxju+d2st91dEW0sWj9WB+A7GLbw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.154.45]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9os0-1goLlu3ptY-00B3KU; Sat, 16
 Feb 2019 09:29:43 +0100
Subject: Re: [v5] Coccinelle: semantic code search for missing put_device()
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
References: <201902161529041506841@zte.com.cn>
 <alpine.DEB.2.21.1902160908150.3212@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6a07c337-533c-61c2-d033-575539309738@web.de>
Date:   Sat, 16 Feb 2019 09:29:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902160908150.3212@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yvZmJvnuZ+d3dYv95LuhjuWXeTIuhdxMxocJTUeL8ID3G0q5NmH
 fFtMkc2Ox2aZl5hHxI2F8tVBq8dhs2BRKepkmnk+1f6/kr5zOQZn9NdgJnx0GfIXLiKB+Xw
 TutnoQSrShdtDVrwEob3gbSSfuFllP2irvzdQRCqPTP0Fzfmo005H4IGRlvoT9O4JYNV6Y5
 yyMeorwsFHbVXAuk5OWgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eLyFMTPwaRk=:ZMhQW7Gty1XRhPcX4X551j
 atrhQxP6VpLYUHuc+COiojnIVRtJFNb/EQdVSmtnSMEghBT2gLlnD853C2c8FObP2ZOPzGJAw
 19AYbMaJvsy4yct6/VpcnJURVXXK3lxDBjNAg+jnFLVVPTP1w+B/RXP3OJT/2puy8vgZHbkI/
 tMasXEeuOd7bSCWYoYmUDxwP2BzSmpfgyq6OzkO8gesFRXs7y8BsLFau/LPYdGnjmfKs+updJ
 RF8sQ0pWZGyR82w9mF1ZVtNhjTwZpjeiMe3P6w/Ong7mDCPuZ8LYYk++8DAN+hvSoe7eR49Xx
 xRmolhyyb9q9fldw4kPgrq3aVngVm2rk49L2dos5dhyKqd9gfTJMQCcTUm5cW15dsndqlbJtN
 eHtTKa6KCfCuQlYezg+L6eY0tOqxFVvQ6Y7XA8MdHFDWgEbUzujn57X3eSCm3KBgBIypfNwtV
 3lMAG3hMzOwB4oXSxHhAjBD/Fuq3RFh7TMSkzqdcOTqHugPbe+eMaMZTa0dtf+F/KmL+tY4g0
 ew7qeu48OtOWNByVWEOhivoCt8MNUnEe2DmhwCKh77TPqelxYzWlZ5LvxuQs6T9sIjXwVsOIK
 VeIFBtJh/Tr3bNrFX0CI4NCOSHDGUBvW1e9TVM/SHvLZL34NekkW/4lW+sGW75LeoOgk51TxO
 z2PpMk/5i3O2GctUfOUIQVIFF9IQuASNQzqwmEAQNcwTtmdZw9D7F6OE/I0QgigC3EX/EkFlW
 Y7FAznkPyk+v1YAQoz/L3tI3moT6nu9xQ3zkIPCzIf2OjF+0goduJwSawiuw7Ujt87Ne+dWA9
 Y6rsgIkBbQ4rj9kkiyOUD3b602cn428WK9q1+1xB6JmcZdQBw8Erm9khg7WKaFuWuF0P+5q61
 cMvLu+d3xdjj6N8kG5M7WzlNPtVxY2R1wgvCr000ZOaFL+uJzGw37iDpYh5RUGRl6oA2LKMvQ
 LRwp/VQ1lQg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> We will modify the the if in the when code like this:
>>
>> @@ -22,7 +22,7 @@ if (id =3D=3D NULL || ...) { ... return ...; }
>>  ... when !=3D put_device(&id->dev)
=E2=80=A6
>> -    when !=3D if (id) { ... put_device(&id->dev) ... }
>> +    when !=3D if (...) { ... put_device(&id->dev) ... }
>
> This looks ok.

I have got another different software development opinion also for
such SmPL code in the adjusted line.
I find this specific source code search variant irrelevant
because the shown reference release function should be found
by the first SmPL when specification already.
Would you like to determine generally if the desired function call
is present at all?

Thus I do not see a need (or requirement) for a duplicate search attempt.

Regards,
Markus

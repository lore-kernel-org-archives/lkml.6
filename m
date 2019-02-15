Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC2CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BAF218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="QgEXDRUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437088AbfBONPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:15:53 -0500
Received: from mout.web.de ([212.227.15.14]:36263 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437038AbfBONPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550236531;
        bh=xqkyQ+YhG5IqJCO4gSCu7q1tZ2UIAef868u8p1HzH04=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QgEXDRUC1ZSgrbLYYKnMJDMzVPku2bDbA862MGzOfYxltzCTVYscvKymqSbUEnBDx
         /k+NKHjcEFqQcmgF4mTvDavlR7TBfY4tkyBzOpC8XQvgUCzkHpHQTgptSU0wjudyG2
         D4+ZgT9lNm7w0DRvXURRoqB348mpo6xsIX9VvaLY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.88.109]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ljron-1hW9ww0Fkf-00bu4L; Fri, 15
 Feb 2019 14:15:31 +0100
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
References: <1550217319-40418-1-git-send-email-wen.yang99@zte.com.cn>
 <94e4b3e6-87a4-aea2-dfef-44d308f0fb4f@web.de>
 <alpine.DEB.2.20.1902151400440.3617@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <712603d6-a2b8-4b00-10f5-879d915c0724@web.de>
Date:   Fri, 15 Feb 2019 14:15:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1902151400440.3617@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1wbr76Q3ZyxduPoTnEXrHwMSCWc7QSdioNy8zvHvAy6/R8qtABB
 Rn41vbFp5uWgF4c81J3K9/Rx1PUrmXviwPnaiDkzVScmiXWlTADGBi7kh6aUCs83Y2oRsLW
 8lQ9WXvVmuY+VvgQAondHk1AmR1OIOFOtJ2AOQT4Tt61KOdrp8Mzh5Q8zG8yXpt2q7lyw4F
 LWbG/KU5qPk1qjez4fvxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/YuL8FtS7bs=:ZC91KdV+R92wlwP8pJJZqm
 qn+e3Z2c3zk+h2LXxMdzGSrURJKUMhSl9+uBoxDMreSbgNvJjMU/JsREq6YiOm5NnR8Y1SAYm
 aepC63wDxxe1ZUHlozn7i6YLI2sSsHDCD0waTQj4XAR2NcTvyJOApDmABScNpSd6AC16N3v3C
 Isq1upOJywFZofLPv4jOY/WO29IDuZZ8TUa+V0Kk/vuQ7I/K7PzdV2xyMuWyUGdsxPuo78Hf+
 TbkLdnzgYWRzIhqWLhOFT0Y04rIi2fyORsCqeS7SWlA80Uda1iQpYC/br8qdFUM7MX7UENHx/
 rEYUHd47wNwBeOD0PKLm4x45iOOoPG7izPQNBCkkzhc3FGJn4QLlLCS5w3hf7OIaCgrXpmUuM
 zxOQANvVlJCLBeNWG66DiZPKjUQ4A/M+jTy++SsuVn11Z2at2s2IExLGNjo53CAvRFP1Acjuf
 MdErRRnQKc5RHCtjbO/w9PQLkxQr6dBeHET8Wr7ZLF/zHpdYZ+/D45QDS20HWbRO9jn8VCFDs
 X4RCEMwXFO16bv0oOuhdM3438pkhF9meQpPU5gjUpePeMaSLETpdPra8wRs1UAJ/cU8i5XG9a
 gaJB6GQmHzZZ773lrgRMshE/09LQnZkMB8Z/HZ1u90nwiZMvKM6vIIVfBZDBryIVFOpMp9+24
 baXFWA/I/pR7YflPQ0npFAnXmahWyCH4utKU+H/FnUxZLTy83WOhM+wDvXFMxEBckHltGuUos
 TWe1Of44QIDvOZNxSBHqraGnFD7BQ6Q7n1O2HMjsZKNlge1lrUs1t/rllfiD4Frj3IAtnHjoY
 ye6tizTxzeMJy2C/CYn6c73UcTRw18XCYdLgpapr9kewQ27kmE10BYInjolyPicsbtHSbh2WA
 9A7RvzaW+g6Xq964WCfYJoB4aCMLEgoBzMBPvPxAuGIUqw8e06udUSsWZ8ar0gDAXKDjuU2A4
 xEsq+86dIUg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +id =3D of_find_device_by_node@p1(x)
=E2=80=A6
>>> +if (id =3D=3D NULL || ...) { ... return ...; }
>>> +... when !=3D put_device(&id->dev)
>> =E2=80=A6
>>> +    when !=3D if (id) { ... put_device(&id->dev) ... }
>> =E2=80=A6
>>
>> I would interpret this SmPL code in the way that the if statement
>> for the pointer check is =E2=80=9Coptional=E2=80=9D in this line.
>> Is it an extra and redundant SmPL specification when the reference
>> release function could eventually be found just anywhere within
>> an implementation?
>
> The proposed when code is correct.

I agree that this SmPL code can work in the way it was designed.


> It is not redundant, because it checks for a particular control-flow pat=
tern.

It took another moment until I dared to express a different software
development opinion also on this implementation detail.

Does the first SmPL when specification include the case that a call
of the function =E2=80=9Cput_device=E2=80=9D can occur within a branch of =
an if statement?

Regards,
Markus

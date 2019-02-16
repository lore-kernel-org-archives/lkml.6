Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B72C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B2A222D7
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="jeQBJ0BK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfBPIKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 03:10:24 -0500
Received: from mout.web.de ([217.72.192.78]:41043 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfBPIKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 03:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550304600;
        bh=BiSN6dSP3KbZ5YsiQYARdh8zVCjWKmDnUoIFFDr3fbY=;
        h=X-UI-Sender-Class:Subject:Cc:References:From:To:Date:In-Reply-To;
        b=jeQBJ0BK9dsl8FuJo5GVgBDWEFlxoGLOOONurakY0llbMK60sTmpUWKyS21Wd9TH8
         +9E25ArleRztboqhrCivLl3s5PRhDbTfJAvTpACM8NwS8J0RfXMEeKakaOrpQ7Y+xz
         fIDjVtVf1f0REKSTTTCNWr111W3HbOS4yLkc3YXY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.154.45]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGzXS-1gq1V416sE-00DlGl; Sat, 16
 Feb 2019 09:10:00 +0100
Subject: Re: [v5] coccinelle: semantic code search for missingput_device()
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
References: <201902161504357846572@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Wen Yang <wen.yang99@zte.com.cn>
Message-ID: <10281c5d-8b32-0a02-17ae-20bf86f8dc65@web.de>
Date:   Sat, 16 Feb 2019 09:09:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <201902161504357846572@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h1zFECTwQtJeK3AkZwG2+EDZY8PhhJ10YFif2lpzNI5WXMmTDsx
 NvIZ2zTwgKB9fCVWFAtuj5W5gQMt0sSsEaXVEwlxUxslmHkkob005xFoWeCnpCGQt0rH75F
 9B5VB8oXt8iMS2cign4U1LezLBy37vgFrGEM29NeK0UcelL/JtriPp3JhxnxT4VLxmgsumz
 SoCkNd1idiDpH+mp9O/mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iXqp0O6xkpk=:4oMx46t3M/YhF2JhqtDFOL
 oqXJjuswMwREHunXIkEfJaRMwjYH8wO8XVrHpoGJFtewPB5h+doKu9klTH8HQQIDgEtXiQXJ7
 tkzoyRHc5tP+1RuYx3YEkolrImMmus6pdGrKo5TnZ2JK5hVed+omfjrh2Y0nzQvZtAUvjdDeX
 jiYxaORf7GA6EkHDK6nbR9kLEZaCkJSffvecfg3M+Rdc0e02ls1tPyFXCzgF1bPHvorLqk6xz
 vivW1hJUp7ENVJpJelB8K7dPXttS5c5cw+8c0vOE4p1bRd0znAbzOfIT+uMFRO8UAhnRqU+H/
 d5GMcY/Q1YMtd3RpbDSRtlWs4fwCZ2NMZJnXt/l1rx2+iJ8o+rb4E+iTKjNPpSExUJEOYixRm
 H2tBE7xbOPcKoCe3u/6bYsEv1anKehaQBEP6+FMN42UEDKTKQXV3YGCAlNHQSSurzaRfT34y2
 bFTRW15CjivkNAo6F+6CBHyIvQGG+qvLKOT3cbAgMqwQExq8DFhoGwT2zuvttqq3atoyPe9rv
 TX2tvzwrpWbSimTrbGVnPpI7la430J1Ak57C21kzvsksk8taAvV8+gAkVlIsauri1MhjR4fga
 p5tX+yA9yVpA136K3tze3YSCoWiOhz7KtU+RIK6TUSs9GAvg2KFBf6Lcpx9xMGcKUecsG2lkP
 eVG4MaZb3C/5bueDbgvo8NRoXNx3nfn7KFlFjFffKEABpxDjmhLN7xS7l4C+6Uv3hxAb7gXw+
 PkKijQhgy83tKV1ma9BmGORLzu2mzYVt2yC7HUvHT9S7ulGQqZ97F3XR0SICM0Q+i3KzflpCI
 jZaWBndhLbgiVtBBuv6d+LRBt1v7bRuny1ALb0+zToS+1cyCUVQLx4a/hP9MsYwon735+8ena
 5CEM+xeImMyVs0s7CebNBGx88xUs9JARx2sJhtjgLn7mXsW8QvNlHUc3rs6FCzVjB+CMmJz/T
 E9SY0vBrjlA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks, We will change it to something like this:
> In a function, for a local variable obtained by of_find_device_by_node()

How do you think about another wording approach?

1. Precondition:
   It will be checked where the return value is stored from
   a call of the function =E2=80=9Cof_find_device_by_node=E2=80=9D.

2. The source code search will be continued with =E2=80=A6


> Thank you, but a local variable is necessary.

Would you like to take additional storage possibilities for a safer
analysis approach into account?

Is the restriction =E2=80=9Clocal=E2=80=9D really sufficient when such a p=
ointer
could be copied to other variables?


>> Can it happen that on other function will perform the desired reference=
 release?
>
> Thanks.
> Because the information of this local variable is not passed to the exte=
rnal function,
> this situation does not exist.

Will copied pointers matter here?


> But it's over 80 characters.

Long string literals can be accepted because of error message search conce=
rns
around a tool like =E2=80=9Cgrep=E2=80=9D.


>> Will any more advanced error diagnostics be eventually developed?
>
> Hello, we are just doing the practical work in this field.

Are you aware of additional software design options from computer science
and existing analysis tools?


> We also hope that it can support cross-function/cross-file/data stream a=
nalysis
> and other functions.

This functionality will need further clarification.


> We are also analyzing the principle and code implementation of coccinell=
e,
> hoping to contribute a little.

I am curious on how this situation will evolve further.

Regards,
Markus

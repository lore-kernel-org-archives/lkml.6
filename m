Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C30C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8510C21925
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="C/IwIIl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392221AbfBOJKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:10:41 -0500
Received: from mout.web.de ([217.72.192.78]:55511 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387739AbfBOJKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550221815;
        bh=tpa24uNeIZdVTqFIDErsJqAXslQy0amY9YHKXz7tWAE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=C/IwIIl1n5WhnYSvzzYlUc9AUlyNegomQp+fRskzIsaCrQqCJmalAzYAVxwLdUagX
         5W1B26fJ8ced/8Y5mdeQW8lH2mt508PYYJLVMSSNJOICKJSdRJWwWJOV9hFFcqD61h
         EoQAnruJFlHjuYiNSiciaxR2nM57dJMeCrrJeUbk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.88.109]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MEEa4-1gsQpy3pZA-00FSBD; Fri, 15
 Feb 2019 10:10:15 +0100
Subject: Re: [PATCH v5] coccinelle: semantic code search for missing
 put_device()
To:     Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>
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
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c096c774-bb52-de01-7608-286b4d416cda@web.de>
Date:   Fri, 15 Feb 2019 10:10:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1550217319-40418-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ywipB2Awkf/FhwVzDNhJnz6+ni9zfWnccyTc0vRBfh1lkzV/0DU
 U4ioQqP2p0EpfPbUCJCGSBn2oFEFiFTW3w9LkFQBdV3Sky+HtVqH2QDT/l6ISB7+Tq7tZC/
 BQ7bUftYcZ/4Pt/xW+3IIgunHcxUjnlqa225S49kpWd1GVUAq9Y9CsP1EtbY5qxmjKNp9aS
 5ky543+noAwqb5/MQmITw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:40lqxceOduc=:QlEa9i80bATDqzi/AtNjz9
 ozJoP0g2leuH/Tox3785leY8A18vvQF3l9Oxt+j1M88pPf8iKBT74F2KZr9UZF6ysvvKaFgQ8
 KtIOATk3XYwl884/KmvhrBCfqaCPeiGfUlhglKjW9wb2/WacdRANLAqdgaPeK3tIdbvSr0El2
 //h1h0OUCNsL/QfPN7wyK6FTLS2QxYwV3vwHg40BzaS0+4kYgDBu6PqAVuHxg/+vqoZeq+6NG
 V0POwiGNRfbHMEdMto4zwgA0Jueyp8hPJfjps8lqz31CdxC6BpQ5bgLGxxNrjeW1pGW9NuCxp
 Xx84VmXZabZrajA2UceujI0EpMXEBxZG41McfpvwmrMrHAK11nUHkZD1J1pVQfIUUE79qyEVS
 p8liLKksNnnyRqz3IxrGJfG/0VBEvr9syMy6FXOVUUBFDjULcEI9LTHzNXmWH3c1uTVOVIDHN
 eaAMNO54b8bfkta8Oxikw3EmDM0y10nq94LI58pJcaukT8cKwF6ucU0Eaie7R51z3jpbWk3bv
 BWy256IDITqpknbVUJNOdQbs0ZSoS5K3pJPjYOGBD2FvGgzrjeeDnxpGeoTmpqrdvjmFCmsvD
 lQJW8La53duz7Gzr7Gkb+m/BkEjNnFmEDMmkmmGe+QfRvgifP431u1VEi07Y9E9Zt7C6vUCNy
 6gXq8tuRmUc2IKvDLic+9IN8CRskLL87iWr6gH2ZtM70TmlFFH42z3yj91ImBAlW4sEi1AvKT
 Fgzf0/UVeWdH2uk1ehWXtROCLtV+GRLpi+TjPdVX5gG1vmWnfZUIzvt6OZN/IEUFi6WlWfZzt
 yTCQ5FSGdRnC0LEWm1sMxOq0oFGFH0y3SghjCZc+pYvBBXEdyfZHhhoVRj8IiOGON2/W3ZrYi
 uMrP3LA5FS7beh6VaYuhXC5hbwPyxiwXpLA5mGJDlogeIayALrpQ0ocFOHLbC4+KzlOfzCCIY
 Rlt1RMUSipQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In a function, for a local variable returned by calling
> of_find_device_by_node(),

I suggest to reconsider this information once more.

1. Will an other wording be more appropriate for the storage of
   a function return value?

2. Can the restriction =E2=80=9Clocal=E2=80=9D be omitted?

3. Will any macros be involved eventually?


> c, for the rest of the situation, the current function should release th=
e
>    reference by calling put_device,

Can it happen that on other function will perform the desired reference re=
lease?


>                                     this code search will report the
>    corresponding error message.

Rewording?
A code search can report an error with a specific confidence.


> v5->v4:

Such version information would be sufficient also without arrows, wouldn't=
 it?


> - add a SPDX identifierfix

Would you like to fix a typo at the end?


> +@script:python depends on report@
> +p1 << search.p1;
> +p2 << search.p2;
> +@@
> +
> +coccilib.report.print_report(p2[0], "ERROR: missing put_device; "
> +			      + "call of_find_device_by_node on line "
> +			      + p1[0].line
> +			      + ", but without a corresponding object release "
> +			      + "within this function.")

I find your interpretation of my reminder for the preferred avoidance
of split string literals interesting somehow.

Can the following source code variant be more appropriate?

+coccilib.report.print_report(p2[0],
+			      "WARNING: missing put_device - of_find_device_by_node() call on =
line "
+			      + p1[0].line
+			      + ", but without a corresponding object release within this func=
tion.")


Will any more advanced error diagnostics be eventually developed?

Regards,
Markus

Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FFDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE312192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="gAG199gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394754AbfBOMxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:53:53 -0500
Received: from mout.web.de ([212.227.15.14]:48853 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394691AbfBOMxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 07:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550235173;
        bh=ltb5GgSmuS9I80LWiFYSWlJd/1jkMpG4yqkG+okXzP0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gAG199gcDuRFtvv+fAYHJakw5EYArykoDm6M021OpKZIUAl97TMcrni+EBgokDTUH
         +hKVHJRt9g7IKsJmCt1TGFLRr4FnOuIuOz3VyYUOsacGZLX5A4y+MQkiIh1eLMQQai
         hTWiYITiHPhS0NTT4nowxSfrzRwaf+FO3WfCPq70=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.88.109]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lhvko-1hOgXX2Zwg-00nCgB; Fri, 15
 Feb 2019 13:52:53 +0100
Subject: Re: [PATCH v5] Coccinelle: semantic code search for missing
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
Message-ID: <94e4b3e6-87a4-aea2-dfef-44d308f0fb4f@web.de>
Date:   Fri, 15 Feb 2019 13:52:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1550217319-40418-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dHpJs5P4WXfx+36nRxi/ipGQZpfYhX1+1dqkMVQ6cuGv+z6rVx/
 8EP2gQg+Y4GYkN0T50vpcIUGPvORztjT+liK2ywFLFfPIpiQsxXOWoqnwu4+WYAaNeKkM8A
 39vkq1d6rBlGz5Xi/fnvJTHXoy0spq4JP4rG5vAoXd/E6kbXfcw3jUVFM1V2H+wZzRj/odk
 0vElJ1kIc8kx52K98IqVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dulOuokDS4w=:JClDS6qxKXiO+Aqv5um/wY
 Wl2NLgqTfItbNYFXdAaxNNxk/b8BugNM1QwEM2Lg6JHLQSBWN+cqKMRKVT96sZbQ9JhoYLH/R
 SO8/D2AkFO9Z6DdqcRFttxq46UlacGH9oFssdsuvhlc0MW1dak38SyInLjGVWIZnoKeuchKPG
 8kJ2E2phUuN40vHfw9Uko7FxnD8MRkGnqgCn/IHqtWgf60cxqoP7mvMVbXSqbIPg46I8I6bZY
 nhEIzLrjOzGKMjzrT3rzeGZ2Jrcz06+bSjjlAevI7PW8wI2zm5nVqiuHAxsWQZQ4FlWehwuT6
 Co9/oVO0wX3/WPzmBDz6JtXSEkAdKpAQGEaX3AB3j51gEiOjTObuteNYOxfumY+gLcKxYvjgk
 85KoBu6mejwf4iTyeu2/O0BnN2W1ph0hSQ3iHmXA7qItjEH6hN5cmbr/OHBgfiNgkuQxWA9tS
 oIN/LgvQ1x1YnkmQ/JGvNqpxhLpOawHxSbB+QGSESxkPiyD0YQze3vUXHJ0gEdigJsz9x8jv5
 OefGP58zAmclygYyFbNzPAqSc0cuIywuxGmrd0tG2eTetX7uR8YgCe9JOW2/GSWTYLF1HxKG9
 H3tKLidV7oiEkpRLD150vFEGj4FHo4wvE/gucowM1xOoWDMH70FDP66N8LvPDTxiEUcCPEGZP
 wyq2nCi++Vx/vafQi1uxSwWpDhwlaK0jKbVq65OBY7ih/OJ2AUz3mGx4+UYL8ZOagnDJAp2Mw
 3qpMkqDNUzkDCbTholiuZ0ap280iNWVfjftKaAsAFn8uG5nRkDEZ0c6S6T1iFNduHoERJK2lQ
 7rlPylWvplxKml8DyYLP+EMoM4dWUAN0ukel6CK+58PUr9c7sh0s/jjU9oMV1OWnHRcE10pxP
 ulWWutPwhEXENKQ8PStAqMjhB1OdgO0EM5tDHCVpB1Qnjg54JFlh8q0VWwWZ6CNuC0fubkNzh
 tDmXb7MbtGg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +@search exists@
> +local idexpression id;
> +expression x,e,e1;
> +position p1,p2;
> +type T,T1,T2,T3;
> +@@
> +
> +id =3D of_find_device_by_node@p1(x)
> +... when !=3D e =3D id
> +if (id =3D=3D NULL || ...) { ... return ...; }
> +... when !=3D put_device(&id->dev)
=E2=80=A6
> +    when !=3D if (id) { ... put_device(&id->dev) ... }
=E2=80=A6

I would interpret this SmPL code in the way that the if statement
for the pointer check is =E2=80=9Coptional=E2=80=9D in this line.
Is it an extra and redundant SmPL specification when the reference
release function could eventually be found just anywhere within
an implementation?


Will a need evolve to develop a similar source code search approach
for safer resource management with other function combinations?

Regards,
Markus

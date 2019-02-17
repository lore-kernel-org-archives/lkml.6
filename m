Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF9AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235FD21900
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Zihcg8/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfBQJuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 04:50:44 -0500
Received: from mout.web.de ([212.227.15.3]:53105 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfBQJun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 04:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550397022;
        bh=NnFHWc46xO4wRrQf9pyAeZk2lvZ145DyvAqEoWG0vfI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Zihcg8/py1TxlRjp49hu9eHOeGTkDFfzI9MNWJmVF0WVLYVSi/4NSTxkhQmGw2kWk
         5SlFjZq6mABQ4K8Sqq/ZrIMZpGEcNOGXaH91DPRDIoPZEoZ71xwiCLEaaJPpPe1j4+
         DHzELlTTDYEKvigNBzzJuMYvMh6HPLa+CAemORTY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.167.97]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lzate-1h9F8u1IRe-014lvY; Sun, 17
 Feb 2019 10:50:22 +0100
Subject: Re: [PATCH v6] coccinelle: semantic code search for missing
 put_device()
To:     Wen Yang <yellowriver2010@hotmail.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>
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
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8e7ba7c0-b7fe-a1f0-d28b-0c716ecbcfdb@web.de>
Date:   Sun, 17 Feb 2019 10:50:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <HK0PR02MB36344E2B29CEB195892F6420B2610@HK0PR02MB3634.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:G9UZncC6hp4oiThDCCQ0913apgVr0GBhpA0TzqZKWxhKVwEdHm2
 UD0JuvhY93zjW9pYwwdqy1OzgRkabDiZ6DfCxRi+aVKwH9siqFcNOu5ox8jrqLrfOv3dv5s
 tM/vtS+o74BpIzNhHzIHiN+0CbkcW6ChI2FNKQtVaIjgKG7asrivCjLuSl77zuBXAEswROB
 lqJyzTBxccuq1Az4MFC8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cu1X4/S6Gz8=:MugTR25r23Xxd0nBOx2emT
 bxZoi4YNflxKQ88zvzPggFGibQof/Hxi5Yu5CujEN+9IYe7mHSt4/SRTIjXrjgO7MK0uBh2Qc
 PpFehWjuotUYmP9DC3LW+krz9bojVuc2z9QSS+pxAGYdQUy6Zwx/BXM7Mpo5stAwjSO8oa9fg
 GCBlQVrHxT/NwOfCQzsCY9OJY8u6Ta1ptnWrsCEOg/eCK9KKephbLizul/3MSZGrm/ilyvWkV
 5c5CDQy7qpeEm1wu3ZOEPnV0nrv2bFs1UxyMGepc/u6XzMJhQJ9W3/Y2Qz+Gm3tlaoNybJRtF
 xvbFlNmJkUfFK+LiGIGk3gD7oRp/duhpHhqe4KK5lrJWMfK/2VnENtJmGNMUB+m9Kzigo4oDf
 IdQKSlHlsUWm5UA9qXhXzWI4uVmFksyZh/t2PbJCG7scbXDuAPU6P9HmAxP4F3jFK0WD/qSg4
 BWKBumq61tHMmEo/va5lA71LrRlVLG+5aD/VOg9/dNouxsBYoPE96o4NR6c+XBGQFLKdsXMLz
 NREf7VuK+Jf9PtHFTnB8MoYkKIbhxZXETzlTq1D2eUHQERnGokxW8vL9+xGM2WNkOZKUkUUQj
 Ieplhha9w9gzCfYxzt0g1SJZi241r2Y3TsVEH1+VmNcmg78MW9HUX6W1OxwFGm4TlDZZgs2YN
 ATiTa1oaO/ERFS9moowYeHsrdK1PMmgj2vX0r57B3gA/AJJWIMKZ/JOAFQ087AOxRijQu93WN
 ceiKowoA+lTyqSNPUEepGlwlZ1XJBTNAF3LwmKJWzSZ7uuxMknqomBA4sdlNKc4iiT+gFpt4L
 STHmwCZ6kC2k/yfpB0XQwVe47LTTwnwxrggZuiatI5lcvXQ229YGz0KEZ/00dOn/XBVCqxO7x
 qlbUjsATb3IPxPu5LbA/pnc417JfOeKwHLKtKzY9BKNNtzuJUHuWbj6cOXdJWShxeZlkgV6Ay
 KP2PZWa+Jgw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +@search exists@
> +local idexpression id;
> +expression x,e,e1;
> +position p1,p2;
> +type T,T1,T2;
> +@@
> +
> +id = of_find_device_by_node@p1(x)
> +... when != e = id

I suggest to increase your software development attention also for
another implementation detail.
Source code analysis triggers challenges for safe data flow handling.
the semantic patch language supports search specifications for
the exclusion of specific assignments.

Does this SmPL code contain a questionable order for the source
and target metavariables?
Can the following variant be more appropriate?

+ ... when != id = e


> +if (id == NULL || ...) { ... return ...; }
> +... when != put_device(&id->dev)
> +    when != platform_device_put(id)
> +    when != of_dev_put(id)
> +    when != if (id) { ... put_device(&id->dev) ... }
> +    when != e1 = (T)id

Would you like to avoid that the return value from the shown function call
gets overwritten in the variable before it was used once at least
(when a bit of extra C code is tolerated before a null pointer check)?

Regards,
Markus

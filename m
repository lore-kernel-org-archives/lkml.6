Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6164EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 18:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A6B21925
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 18:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="iHqc7/I+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbfBPSkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 13:40:21 -0500
Received: from mout.web.de ([212.227.17.12]:57541 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbfBPSkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 13:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550342401;
        bh=w0/8ajHDOZCCLPrlED+z6Emy8jpOII7oE9JQKmvHw88=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iHqc7/I+QV5PeXyqI/zYK742m1SVZOx60ZPPrgd5rBL/gGL6oKQr+TtAt4RXNyBtT
         UiYCYfOxhieTD4hb4exmsnOkhYwv7OykF+O5nbXWNlWKyWXp6V7uODmdVnHZ8FChCd
         5efpgrhamavMDZ5Xddoe072QTX6T+Lli1HC2YwvQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.154.45]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MdLsF-1geEiZ3qAV-00IYij; Sat, 16
 Feb 2019 19:40:01 +0100
Subject: Re: [v6] coccinelle: semantic code search for missing put_device()
To:     Wen Yang <yellowriver2010@hotmail.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <HK0PR02MB36344E2B29CEB195892F6420B2610@HK0PR02MB3634.apcprd02.prod.outlook.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <52c3fdf6-0d04-eed5-da57-ef7d1008c291@web.de>
Date:   Sat, 16 Feb 2019 19:39:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <HK0PR02MB36344E2B29CEB195892F6420B2610@HK0PR02MB3634.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:WOvHj4F2Q4JawsmySRO5I27gnQdIB5lOM7+MfdZXJf+kxZ30A/P
 FN45hq9NjX4HD96UbTXQ34YqGR+Zn2xFdv2s9nUJt1fRqFsnR9+futg1u/Za6SqURq1sZh+
 at/wpYGrIthP/vbKeTSAVqe+MgTGspxIJ5QHUlzosnBYOMseiipHA29+1d9Wxf4z+h72Dap
 XLZTFggb3WJOwOEbHSIrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wRNvInyGI0c=:1yRBy45GYOhRh4JAwwfyXk
 TYqC+X+2vQQb5fIK2XUNEMcWKVpOecJDAJ8pPVDzu+AeuZRGf4AaGIzD4xD0yi79uh7o2Irhr
 iz1tQ33JJdRM6vqQ2wzzaE74yUypoD7nbQPyW1gOusH5d1VIpe3s9Cy/mi6B4zyHGCY5q8KJI
 lgulPwjSNFNlQkQXasggUlva3Mpvh+XZQzDO8Xv4ALOkVq+qqBMaAoG08wXjRlaHpmWEJAciO
 YK0CkvGAIelsTnJoqduU5wpwzAQvYkmLs2ELoAsV14mAU57uaYPjLOeUNcZO/dOb0+SMJh2eV
 ucgDKlgyqXC/Uwic+bYleBVSmso7+EvswkOdxYZzj7OdopzczPjtHfL9jQKRsp7E/PaImjQ6X
 0FoKwRraF918RRBV9jI8OP5zjnQ0YvW9fR0l8INDC+Fc9orVqU8N240pCUSjneobF8mO588cR
 MHwVsdt9uE/oeOMmxOT/F1B0kPJdpLNEi6MVNZD3+2s5BJmzfBD3/5QHdQBLbLUsrPWl4iPHH
 rGav9zaNkxfMUxaopPnvmx6VKHVtwu94Ehu78PozMmAPfugjFk6RnQF48Yei8/j6bVy1v4YZ/
 cAGQp5u8J3mObog7ZpA6MfP9y0WTTYmLKHof2GuvgF6xRV9dsFpeRySufvladr21YbzFDkLIY
 1QzKGC8otwgQEzJCk7MPDRe+db7XdeuFDg2fWPWx023RihAUrGJDciA3vAvIjm63cKqzuR206
 1i1OIt/bwPgfXZbSUeWzYIMmyGDxIdKz0cV86khV/ilHOUTN+OeDwggTwh4mWRmzZ38vyUZov
 nlrMZN7Dn9+WjNHd2/uSUQcv9xXq6/aj2vNjbkUT5SII/v0ZF9EE3pMBQDJi4hN33eLAp2Qyd
 ZctKfZ+drQ1ij13BxcBUuWUAL6DmmlMU6TJ3p29S359fQOuJ3XkQqNCCLMjFUfWSKJrQQP33y
 zEbjHh8I6Zg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In a function, for a local variable obtained by of_find_device_by_node(),

I got a software understanding where such a variable can not be obtained
from this function call.
The return value (like a pointer in this use case) can be stored there.


> v6:
> - to be double sure, replace &id->dev with (T)(&id->dev).

The support for data type casts is another interesting extension for
this source code analysis approach.
Further adjustments might become possible at other places of the presented SmPL script
after specific clarifications of previously mentioned implementation details.

Regards,
Markus

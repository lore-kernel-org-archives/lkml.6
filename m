Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB02C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 07:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521C92195D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 07:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="A3i61avV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfBQHnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 02:43:31 -0500
Received: from mout.web.de ([217.72.192.78]:53821 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbfBQHna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 02:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550389383;
        bh=48V7VEA3M0LfYKiBek91BGKqOHNDpu1S1HxwSU66KBg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=A3i61avVR+1qu7OwHDM8C6kMb4ktqQShal6+KnKtkL14jxo+WRxJLa9F3TrkM+Yxy
         nR/cF/kAXXr/Ewb99wFxnzaV7cYJOMK1VZ/HoY1Xvf8yvz12EgjrAmZghfcnqyLXLf
         VwBG0ARxAlnJikQlPgMfRZSnWXDJYY+f4F8p4bhI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.167.97]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MOArg-1h0lHe4Bng-005VsX; Sun, 17
 Feb 2019 08:43:03 +0100
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW3Y2XSBjb2NjaW5lbGxlOiBzZW1hbnRpYyBjb2Rl?=
 =?UTF-8?Q?_search_for_missing_put=5fdevice=28=29?=
To:     Wen Yang <yellowriver2010@hotmail.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
References: <HK0PR02MB36344E2B29CEB195892F6420B2610@HK0PR02MB3634.apcprd02.prod.outlook.com>
 <52c3fdf6-0d04-eed5-da57-ef7d1008c291@web.de>
 <HK0PR02MB3634E4B3441651D4F7737399B2620@HK0PR02MB3634.apcprd02.prod.outlook.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <766c87f0-fef2-0997-b0a4-3d3d26711b79@web.de>
Date:   Sun, 17 Feb 2019 08:42:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <HK0PR02MB3634E4B3441651D4F7737399B2620@HK0PR02MB3634.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R4gD/ztV8Kbk7EU+OhZFrlNEOLEmH+TW6pVga2w6mb8Ns+wbBNa
 q5gT6XG/IsHiygfDpGPm+iNxl/tavCOf1jyifddweR3/9OPMlnNimOlJ3Za1xrqHemW2sLJ
 Rop40pH/fyTlVVZRtZs+nY9R84szBrZWrSNvnLEAmEIOmbnYkA6YWbCSKJkxvbCI6i/3sY3
 JmnVFtHlKnbPTeDhDGUIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cPf5wyz9fn0=:/CjHVrdRO49uLdO/9TRv7m
 Ol9Ve+Owg/Vh/DZ/LGSPriGGNokBLPd/+eoi16sDSL/wMhmj9chuPCNpylR/OaNVyRn6XtqCz
 zeHFU2MK+p47yaH8n8uR3P2u7X7awcKYN5R9ueFopeQ8w/OSQ3d//M9OM3wxUjFV7+6ve+bne
 OYuqSajP1LzyYX9HtSi5Pjor+XQsnbycGcG6JFrc/vSYAtIyh0787gKZOcS8hzSS2uXkzxJ/N
 PJgzMYNunpXCE+TzusrrywNYSqbGNVi1kZanlf8QFLUJDeRoLG4ujQpC5MjufXxvroIwKfsA3
 2NqjV0fK0XFQ2hFowoydUl36E8dmqKSqtqYy4GTpBc57QoOzT4yOlFPKh7CL8d0ollrb+mpbH
 Ey/XeFDo7tqLyiO+wVqn3ote0Wzh0K5SQPogIWGFKmRXTE7gVpDCz+QHo5F86ZygKeaMAbm49
 FgAbhYlo8RAFN+qe3yZV4cBNvUqFtzcAvLn/LgizkkAPCIAVmtvk4MeZGUKINwO5zaU/cg5b5
 mxW/h5UiR4uMyPx9V0UF6K7cSx/rGYqnTdhKFmgP0EgQoBl+jXRLKx6DKyGSb6O7neKVwKaFv
 0ANF3qRmMGJPwtCTPzdhTxEkzPkI9Z/F+yGiKovJLpBhDFjmanFNFPrmlbuvrKYWxSPvnwaDF
 mJKqgnMSImBu+GrzP4OpD4fpYKTyR7mNJAhXkJKQFqSftTA8FbVfDPKQeRQjLghmwF+IxMlmo
 4Xkd+n4sOwRkbK97nNbRoSidHkUuFpzL/CnXXofj7wB1R6mviJpLqMa+yogtxGO0mo2NzlrCg
 b7JHkQuSRlrVpURorY6EFln8mJqJJ40NSjGjJtABbWnpozCSUnd7UdIZDk2MhmGi6C/t2QeHi
 yf8qFtg3vV7V0sB4XpwE1m2Z9m7hTU7+cNFUBy8XZieOGy7V2ZsBeHjXE2KqaFE3cRNswZ4uL
 LpAVCgxpozw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> But please also refer to the examples of coccinelle, such as:
> http://coccinelle.lip6.fr/rules/kmalloc.html
> and
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
scripts/coccinelle/free/pci_free_consistent.cocci

These scripts for the semantic patch language show some software design po=
ssibilities.
They contain implementation details which can be also worth for additional
development considerations.
Will systematic refactoring become more interesting?


> You will find that there are differences between coccinelle and c.

Would you like to discuss any of them further?

Regards,
Markus

Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED25FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDD723CBF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDD723CBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbeGBPNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:13:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:54701 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752288AbeGBPNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:13:40 -0400
Received: from [192.168.20.60] ([92.116.191.110]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLfH9-1fZjXK32Kx-000rRq; Mon, 02
 Jul 2018 17:13:33 +0200
Subject: Re: Build regressions/improvements in v4.18-rc3
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Parisc List <linux-parisc@vger.kernel.org>
References: <20180702140050.1660-1-geert@linux-m68k.org>
 <CAMuHMdUHkShW5dT41x06Jz9DUJHim6=Wg6pspgTBJpsoVNphwA@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=deller@gmx.de; prefer-encrypt=mutual; keydata=
 xsBNBFDPIPYBCAC6PdtagIE06GASPWQJtfXiIzvpBaaNbAGgmd3Iv7x+3g039EV7/zJ1do/a
 y9jNEDn29j0/jyd0A9zMzWEmNO4JRwkMd5Z0h6APvlm2D8XhI94r/8stwroXOQ8yBpBcP0yX
 +sqRm2UXgoYWL0KEGbL4XwzpDCCapt+kmarND12oFj30M1xhTjuFe0hkhyNHkLe8g6MC0xNg
 KW3x7B74Rk829TTAtj03KP7oA+dqsp5hPlt/hZO0Lr0kSAxf3kxtaNA7+Z0LLiBqZ1nUerBh
 OdiCasCF82vQ4/y8rUaKotXqdhGwD76YZry9AQ9p6ccqKaYEzWis078Wsj7p0UtHoYDbABEB
 AAHNHEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT7CwJIEEwECADwCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEE9M/0wAvkPPtRU6Boh8nBUbUeOGQFAlrHzIICGQEACgkQh8nB
 UbUeOGT1GAgAt+EeoHB4DbAx+pZoGbBYp6ZY8L6211n8fSi7wiwgM5VppucJ+C+wILoPkqiU
 +ZHKlcWRbttER2oBUvKOt0+yDfAGcoZwHS0P+iO3HtxR81h3bosOCwek+TofDXl+TH/WSQJa
 iaitof6iiPZLygzUmmW+aLSSeIAHBunpBetRpFiep1e5zujCglKagsW78Pq0DnzbWugGe26A
 288JcK2W939bT1lZc22D9NhXXRHfX2QdDdrCQY7UsI6g/dAm1d2ldeFlGleqPMdaaQMcv5+E
 vDOur20qjTlenjnR/TFm9tA1zV+K7ePh+JfwKc6BSbELK4EHv8J8WQJjfTphakYLVM7ATQRQ
 zyD2AQgA2SJJapaLvCKdz83MHiTMbyk8yj2AHsuuXdmB30LzEQXjT3JEqj1mpvcEjXrX1B3h
 +0nLUHPI2Q4XWRazrzsseNMGYqfVIhLsK6zT3URPkEAp7R1JxoSiLoh4qOBdJH6AJHex4CWu
 UaSXX5HLqxKl1sq1tO8rq2+hFxY63zbWINvgT0FUEME27Uik9A5t8l9/dmF0CdxKdmrOvGMw
 T770cTt76xUryzM3fAyjtOEVEglkFtVQNM/BN/dnq4jDE5fikLLs8eaJwsWG9k9wQUMtmLpL
 gRXeFPRRK+IT48xuG8rK0g2NOD8aW5ThTkF4apznZe74M7OWr/VbuZbYW443QQARAQABwsBf
 BBgBAgAJBQJQzyD2AhsMAAoJEIfJwVG1HjhkNTgH/idWz2WjLE8DvTi7LvfybzvnXyx6rWUs
 91tXUdCzLuOtjqWVsqBtSaZynfhAjlbqRlrFZQ8i8jRyJY1IwqgvHP6PO9s+rIxKlfFQtqhl
 kR1KUdhNGtiI90sTpi4aeXVsOyG3572KV3dKeFe47ALU6xE5ZL5U2LGhgQkbjr44I3EhPWc/
 lJ/MgLOPkfIUgjRXt0ZcZEN6pAMPU95+u1N52hmqAOQZvyoyUOJFH1siBMAFRbhgWyv+YE2Y
 ZkAyVDL2WxAedQgD/YCCJ+16yXlGYGNAKlvp07SimS6vBEIXk/3h5Vq4Hwgg0Z8+FRGtYZyD
 KrhlU0uMP9QTB5WAUvxvGy8=
Message-ID: <1fa6b973-33e7-53f8-75bb-92d1e8932813@gmx.de>
Date:   Mon, 2 Jul 2018 17:13:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUHkShW5dT41x06Jz9DUJHim6=Wg6pspgTBJpsoVNphwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:uzF3w9gWqcxQfp+zlSYXkUChTx6e98+07sCr2ydTAg2JyW9vxr5
 YVQSBnz2nu6Jwmo2jJfL8dph9xGLa8oT821I2+UGN2PUexkMx/Bov/TfKCbnMMQAsl7A+pv
 CLfFghbLijQEBBLTT0iy48mS1iATu8uCq8VAJRtVQagrICX9YAQOdt4qF1bXJ3NQHRj+aGc
 +IMw1YUnRFeqSG71aLLLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0qlGV5qn5so=:n7/Ex/DFgafeCksV8ZSG6a
 UTqcrferSSXP05J5q5pj9gXaxw61qFIgyKJf5ADS0cM8LcA+1kEiHLC5073haLVl2dAbJqbha
 ylSGXCKRUXzFOEYn6yuJVgGZ7vSSKc0k0T7onY2pcnCXSvFAjDMWpFo/W5TTHdTJix2uQNtNE
 taCb0LXRO3E8OmICb1ggkaEpujSspM1htH/qAhuK2jEO5VFF5buP0pI6hAhXk7ppKow84EPkL
 3tk6I4PKpVa7yktOwVDUmAYSMHb/PQWzMsv55LSe5CxNAODllREFjKkp5qwR40ZeOmVEBseaP
 OSizq12O2KKh78a5yeJhKjnuKeSOaDHwKt0lXCOHYNN5uO4iw65XiSeLn2ulBvuapbz5Q5liS
 1pUaRaCt+mAYerE0W9AjVF6q3yU9INMgV63054pZ/FFalnzr11qJNyuzvqaOwldelaGiT91qf
 9bL1mPaTViduOPsZqZkNmHqqi3givqW2/QDj2Jjz/mx0ugZcA+rnr0xYKxTVutvHuh8saLMHb
 7fFOidPnNWdROcWeWoZh6UZtkGxWlG+Y0GoSc7zIcmgbiS1KRQJoYUcaOtk+k2ztphMfUpWMR
 fPJkfSw1aRvZo6c5UYRlvOHFMc2ksc0WKjPy7nsY6GLg6BNq6YB1AfFAMNHR12oZso0zR1Kg3
 cQPotmCcdWCHWrkDjn1MfGWZxDVJ3PoYtHkDi/LEhywD2eHdX5UaIRHLTaiDkMlMTp3b/bkxt
 d+ovC3o5Hu0CTBPzrRPmUF4o/fjUG+srSFkQrFzqEh593FzAod7FkqQUUkEEwVBh22LDCZ/g2
 XvvPtzW
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.07.2018 16:09, Geert Uytterhoeven wrote:
> On Mon, Jul 2, 2018 at 4:01 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> JFYI, when comparing v4.18-rc3[1] to v4.18-rc2[3], the summaries are:
> ...

Both of the following are simply happening because of old compiler which is being used:

>> [Deleted 26903 lines about "warning: ... [-Wpointer-sign]" on parisc-allmodconfig]

?

>> [Deleted 19308 lines about "warning: -ffunction-sections disabled; it makes profiling impossible [enabled by default]" on parisc-allmodconfig]

I dropped function-sections:
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=24b6c22504a27210a8377e54d24d425ae414f2c1
Still need to see if this gives problems (haven't seen any yet).

Helge

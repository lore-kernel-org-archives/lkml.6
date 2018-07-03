Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B9EC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686B624B6A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686B624B6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933003AbeGCGT2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:19:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:59689 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932613AbeGCGT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:19:26 -0400
Received: from [192.168.20.60] ([92.116.180.62]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWk7n-1fbhpF1Fsp-00Xp85; Tue, 03
 Jul 2018 08:18:14 +0200
Subject: Re: Build regressions/improvements in v4.18-rc3
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Parisc List <linux-parisc@vger.kernel.org>
References: <20180702140050.1660-1-geert@linux-m68k.org>
 <CAMuHMdUHkShW5dT41x06Jz9DUJHim6=Wg6pspgTBJpsoVNphwA@mail.gmail.com>
 <1fa6b973-33e7-53f8-75bb-92d1e8932813@gmx.de>
 <87601xgm6a.fsf@concordia.ellerman.id.au>
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
Message-ID: <b7c41645-f694-4763-4cc3-f7abb0c2432b@gmx.de>
Date:   Tue, 3 Jul 2018 08:18:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87601xgm6a.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:j4YyVoSPh+McraZY6HVoaBSsKUa5i/srDSaort1aR1N7kldaZ9F
 /48jCHXmB+3Iuu5IAmcEVyGOoBf+tUGSllSzAPTwA2a+p95rosnjzxPlDGE/wvQFa9n7eIv
 rlw9rWXjcOVsXrtlSZ/op+IJV+lO1bPydZaCnU5rt3rJSW9fskWB1bGrUaZAGoJaMDTIBsO
 67ML93RUcAOCmmpKTRLTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uUx6lkWcamg=:EZfgSil0eC5JGP/uqwZNcW
 pncoqOdwGggWo9tHUw32XllP3DFitbHVrR9Rp+cYcXfILBrgEygFJBqrU0bq0bbXFmvXeJSzH
 jaVCueb1UOReV3syz4fRrGRohcfjIT6G5A0C6lwF+cXYCW1Eivy6DTkyioI+Acpx/eOJo/EPq
 3KKL3zaJmS52lW1SE1xAGCiv+8CnKtj4raJdn0kBysBKysnbuMiLb3fB/YqXcEWjRri3u0nbs
 iYdapZS4EC36moSQzI76Br949bBJ+x++9fKvnpPig8yXQijyQLjme/DAVFyCXR9RsBtl1xiSQ
 ohwQs86jscTGADGsMoVS/bNW3cG8Td4AMLtamUGivv7bm71fMf+vsif7cxWDsGNqoJbhBoHK9
 OqIM+b+js9QIOPkrWsG/WYXG0HngHP3njpajVv8n0hAqjS+XHfB1Ww3o9hOnDVKYheR2/z1Q1
 wzNsvTtVfbmPe0O3hCbA/JEsrvPicH/QS1eJX6bNMghiU7MrxpKUpU1uLLzfSz2lX6vyXp46B
 0DPxD0BE+t7SR9vDoCEgVrJHDAdqp8ijK7GW4o6rPbJkbl1EvJQD4/WFHaSwqqxec1q+1Bm2N
 xbCksRaJRFyBz5BpcK8Txk4h5BT1PAUNeGrK37Q28HVhhVhFzFkU9H2YTaRVhiX8EN/dsGU/x
 izKkC6bbhVsdWG3ZM/QdnipOzgol1gHZWjN7Emeup3pI3OSmd2ghHzlwCQ6arQMNX9d5Q7Dvg
 fi1zk0iINbhH0Cv8gJMzzA95hOsAyBVckmyNeVJgPkjLSlX0xe1v3XqD0k2Zq/4lmIMPFHDwL
 bU8xH4V
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.2018 03:09, Michael Ellerman wrote:
> Helge Deller <deller@gmx.de> writes:
> 
>> On 02.07.2018 16:09, Geert Uytterhoeven wrote:
>>> On Mon, Jul 2, 2018 at 4:01 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>> JFYI, when comparing v4.18-rc3[1] to v4.18-rc2[3], the summaries are:
>>> ...
>>
>> Both of the following are simply happening because of old compiler which is being used:
>>
>>>> [Deleted 26903 lines about "warning: ... [-Wpointer-sign]" on parisc-allmodconfig]
> 
> It's GCC 4.6.3. Are you saying that's not supported anymore?
> 
> I can update to 8.1.0 if that's more useful.

Yes, please.
Any version >= 7.2.1 should be better.

Helge

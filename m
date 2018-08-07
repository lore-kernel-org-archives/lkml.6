Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62CCC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6919B216ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6919B216ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbeHGWrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:47:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:59933 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725740AbeHGWrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:47:16 -0400
Received: from [192.168.43.192] ([80.187.96.219]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MV6PJ-1fQRnJ10dJ-00YQir; Tue, 07
 Aug 2018 22:30:56 +0200
Subject: Re: [PATCH] parisc: prefer _THIS_IP_ and _RET_IP_ statement
 expressions
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     dave.anglin@bell.net, jejb@parisc-linux.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-parisc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Alistair Strachan <astrachan@google.com>
References: <20180801182258.17834-1-ndesaulniers@google.com>
 <78c667f9-5c8b-3835-83eb-4b59e27e4f7e@bell.net>
 <CAKwvOdmdrA+UvAWyqe8sNJt5nxHXHsSwf5Yxih9HYgVL+kovxQ@mail.gmail.com>
 <fe7b57d8-b586-a390-31d2-2274f69db3c0@bell.net>
 <CAKwvOd=CLBFZRQ4HQb_+VCydDEvsbC2w2gD4hTwvp_jm1zqN9Q@mail.gmail.com>
 <54b2139b-53d2-01c5-f240-93a692cdbc59@bell.net>
 <CAKwvOdktvrZL8T_5K2VtQtgt_mscS7kzVXYVy0O7CSuGX53Y5A@mail.gmail.com>
 <536ef1b1-cfa2-f66d-4261-fb8405964632@bell.net>
 <CAKwvOdmwj76aESZNKhzfPmhfzGKvrfDut7oD5KAwA+VR-JukSg@mail.gmail.com>
 <80743c1c-2a8c-7bce-2068-24c63790eba7@bell.net>
 <CAKwvOdmDwO1U1sk=3-6zXFrVw6by1e_9VBx1WWMCx_rMqYSw-A@mail.gmail.com>
 <81a7e33a-0403-b6d4-fcba-c2168a608ba6@bell.net>
 <CAKwvOdmXi_EY5=sOO9tRqeoFrHjLsF9L988cGC2yjnFYBxac4w@mail.gmail.com>
 <1d577675-c337-d433-f235-1e46e5d56d4c@gmx.de>
 <CAKwvOdkABF9cxFxrtYo_mMWAunLL_ifM8+=H0On7WWcFmoN0Og@mail.gmail.com>
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
Message-ID: <74f19f24-fc6a-748d-3778-26ee0bfb2d40@gmx.de>
Date:   Tue, 7 Aug 2018 22:30:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkABF9cxFxrtYo_mMWAunLL_ifM8+=H0On7WWcFmoN0Og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:IDAD/mpQeWd2ZDgWu6mg3otvCVHlS0dpvJ1qsaK/Pjw3XV3pxTj
 bysp9Tn7LMLFBx9BPHiTKTRzWhrrYATysf24o1f7pcUjUFh5cPflKbq/AoKApM4LHW9C/i5
 XQkcSuJCaQfxpTj08hRwrrQpXdQUe8180p/Ii59fuhCQIq358OjIcKXFO5u9QuZs981DSPc
 4karmUGZ4e5qqiOfGJGXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LI9DoHClkUM=:aaTbW7BNUZU3IrdU9XeSGX
 aPT06Y738kyYmBFlrObBwbRUct13jcDd8A6WU33yRg++tOAZqPbvl2Bm3kHmwSYMi3kejIqDf
 4CErCdP3KuTzhzSK2s6H/6K8gNMMkvnsEoFC7xgnpFp8Ov9sAn4SC2GjlLaRGfkPC7lY0anTr
 +oFHlWUQCOtO9KG90KX6gGL0pa3NikPydplXQCvsVp6C9on9ajKmDHmw4U3dp+/RBmxnEIRiy
 05M5VSTpTfOCaEHbpx6IBgdzC5g0pzYIAib+eLr/ie/v3L/GlC/6mh+zKyZmCBnCwy1pZrNqG
 oEp5koQg2U6RXJ7JLbtKDb2RfWjgMMPssA0wg71pMglyoK/p5Tuy1nZkJsELZOf7qMu1mIigs
 gUVOuGmERDZi1yxioreLjXhhDGr6oJjVPeuxc25P9RM6QdRk3rCAFsb/qArqf0ntlnsZJ14aA
 U9G58xsJboeBD14iToI4xEULRhYGGc6lhKgC8rDnp8ahIrr5LNYBygteFStbS+JrqLsHJXoQ5
 U31DC8FvKo27k6BmlrRSol0i5M6hDWSg94odAynOtgSapc4DldpEzz0QbUn9MiCGX1Rrv3DBg
 utALR0l9ZwCf05Vo7bNBGXniszuGXeTjQa6luBO6Fga2c6hqcrUb/appxO56tLb+6xUsBJxnK
 NBAkExpDIMDpAEzOGX/anRcNla3ZKaCItqu1NWoqwEjqWcYQStw/chylc1MjQQk7LL963hFLN
 t/1B67O8Ym8Cr91jCOkOHo4kw2EmwVoI+sfZGxLYBI09o6dVN+Usq0379uzAvtqC05rlsqZS3
 gzbjPYE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.08.2018 20:11, Nick Desaulniers wrote:
> On Fri, Aug 3, 2018 at 3:34 PM Helge Deller <deller@gmx.de> wrote:
>> So, your patch is basically OK and doesn't break anything.
>> But I agree with Dave and Andrew, that THIS_IP is ugly.
> 
> I don't disagree, and other maintainers have remarked on _THIS_IP_
> being ugly, but renaming it en masse is a tree wide change, which I'm
> trying to avoid at the moment.

Understandable.

> It sounds like we have a working patch? Are there 64b parisc machines
> to test on, or can this get merged?

Go ahead and merge it.

In addition, somehow I'd prefer if there would be a way to add to include/linux/kernel.h:
+#if !defined(_THIS_IP_)
#define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
+#endif

That way it would somehow be possible to replace that label calulation by the
preferable inline assembly of current_text_address()...

Helge

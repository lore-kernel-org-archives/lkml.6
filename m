Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E52C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07D42082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07D42082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeJCVgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:36:24 -0400
Received: from mout.gmx.net ([212.227.17.22]:51705 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbeJCVgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:36:23 -0400
Received: from [192.168.20.60] ([92.116.174.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLj5z-1g8XW332Ch-000pSs; Wed, 03
 Oct 2018 16:47:32 +0200
Received: from [192.168.20.60] ([92.116.174.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLj5z-1g8XW332Ch-000pSs; Wed, 03
 Oct 2018 16:47:32 +0200
Subject: Re: [GIT PULL] parisc fixes for kernel v4.19
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
References: <20181002210213.GA17826@ls3530.fritz.box>
 <20181002211645.GA6454@kroah.com>
 <ad45f249-e064-d5a4-c658-eaa03bb3a04a@gmx.de>
 <20181002222452.GB11788@kroah.com>
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
Message-ID: <dbfa0162-8ed1-b16e-a418-da3b92c76230@gmx.de>
Date:   Wed, 3 Oct 2018 16:47:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181002222452.GB11788@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Sl3+6Vekrxjz2BvjMUk1W/1b/td8XfCS0C+QuTTWDFI0chw0rSn
 iuwK7INPy0wNvL6QXBHNZv7KHB5kL7AcagXHCyXfu8Unsdt1OM/WBQfwR+dZS067W/NsQGa
 tISw1E55yh1tlHyycEH9hs5lbvxsVgaxRt784KLJRV6VSVsqgsp8jsecPfNTL3aInFTVn7d
 0vnU8ECV+I7S23MPYIg+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Z22vGpOd+u4=:3+8+dL39WaZn3sB53pJBup
 Sy0Em7vAAPb1Z516y77gOL9Dcu4dfqa/avXwBURcXzVYh/o2hB/IMVhEadkhojXjbVbtROTtk
 elFAXSrG8sCSdQQZa+PxVfoDZrYVeF6yCCVsMQ1X988MH6Ffm6bOk2J+wFWkvVGqafufYHkob
 +EbEA5s2JG2INNNFsO9Wd6Vl4uukG12q2gZ0M2e15ibA6oE3ot8ve/vx2zkWvtS5rvUI5X1fZ
 zeTECqvTBAK2WquOlaAwYhphJ5x8MJvIguvOOeC+ETIXsCF9RPOjkSSxXywfqk0tBlZqXTpUP
 lOqPtMN9V6bx2rlM0foFE8M1a4nK04Ppe3MERtv+FnF6+UDF2/wtjdbPxI+iUsBpI1So3G33U
 3y9bYqoZpqWr6tVBtVNKMUs9/V9g+xTub0/yrQ49htMbDJaTfiPm1+FQ0DDW0+MX0pyPTM5Zr
 3bRhobUVq2gYdVd9+UG+d2DV1M224t+NwckMne8ack4WpwTezYfDDXYVYxZy7H8jes95dgK0n
 Y78ubEdqWPc8A58k4iDLl3XmfmG/HLgd9lNyF17SE5EJki0ECScrOXcKP31q03/IBvI+G8xE4
 LyIhq5o74x51Qh+Yl64hhWMJ+O/7v7nPDGN/+KC6l0rIF4bZ6DsgJd4CZzMhLzlq5jj1UsyH6
 5GQXz6L96AnzV0QEK5urFionxGwbN0xj+0TErItOsiirNUooldZwjHpb/qWyJEjoEkElSSfNi
 Uc5NV1aRrg5gMGyvcLtKkwhIPqUIfxXxqsycf+NFh4QHnOQQ4BNYHoxbZVhxNEfeYkqn/Dla8
 gMvRMkgYXfJG/cde4gpa5SnoiBw2lqIxKTj9NvEsrSOp95fOKs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.10.2018 00:24, Greg Kroah-Hartman wrote:
> On Tue, Oct 02, 2018 at 11:46:11PM +0200, Helge Deller wrote:
>> Hi Greg,
>>
>> On 02.10.2018 23:16, Greg Kroah-Hartman wrote:
>>> On Tue, Oct 02, 2018 at 11:02:13PM +0200, Helge Deller wrote:
>>>> please pull a last set of fixes for the parisc architecture for kernel 4.19 from:
>>>>
>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.19-3
>>>>
>>>> The major change is for parisc64 to use a 64-bit suseconds_t type to
>>>> match what glibc expects for 64-bit userspace. It's an ABI change, but
>>>> since we don't have a 64-bit userspace on parisc yet, it won't introduce
>>>> a breakage.
>>>
>>> Isn't it a bit "late" in the release cycle for such a change?  Why not
>>> do this on the -rc1 release?
>>
>> I've tagged it for stable release.
>> So, it can go in now, or just wait until -rc1 and go in later.
> 
> Why is a major API change a viable stable change?

Of course it's not.
Esp. not if an API has been used already.
IMHO, this case is really different though... 

> What bugfix does it provide?

It fixes that code in stable kernels which would return wrong
time values *if* someone would create a libc for 64-bit parisc
and would run it with those "stable" kernels.
Fixing it now has no side-effects, the change is a trivial
2-line-removal patch, would bring the code in sync with
newer kernel source code, and it really fixes existing code. 

I still believe that this justifies for a backport.

Nevertheless, if you really disagree, I'm fine dropping the 
backport to stable and will only push it in the next
merge window for v4.20.
 
>>>> Other than that we simply drop unused code and outdated gcc version
>>>> checks.
>>>
>>> Why are those needed now?
>>
>> The patch in there which is by me changes one line simply cleans up a patch which
>> went in during the 4.19 merge cycle. So it would be nice to have it
>> added now before v4.19 gets released.
>> The other two patches are trivial and just remove dead code.
>> I rate them all as non-critical, but nice-to-have-in-v4.19. 
>>
>> If you disagree I'm absolutely fine to wait with all of them 
>> for the next merge window.
> 
> Normally I only let "bugfixes" into my trees at this point in time.
> cleanups always wait for the next -rc1 merge window as that's what it is
> there for.  So I'd recommend waiting as well.

Ok.

Helge

Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2087C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2FD21471
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2FD21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeJCEbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:31:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:55713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbeJCEbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:31:47 -0400
Received: from [192.168.20.60] ([92.116.181.135]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lj1jy-1fasMi1hOQ-00dIoW; Tue, 02
 Oct 2018 23:46:14 +0200
Received: from [192.168.20.60] ([92.116.181.135]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lj1jy-1fasMi1hOQ-00dIoW; Tue, 02
 Oct 2018 23:46:14 +0200
Subject: Re: [GIT PULL] parisc fixes for kernel v4.19
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
References: <20181002210213.GA17826@ls3530.fritz.box>
 <20181002211645.GA6454@kroah.com>
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
Message-ID: <ad45f249-e064-d5a4-c658-eaa03bb3a04a@gmx.de>
Date:   Tue, 2 Oct 2018 23:46:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181002211645.GA6454@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:kcqWhRpU0EAVzPr+2ARJQ85Ym6YIyVsj7P6lo4ChYugRQZq/KY8
 iQjKZZ8AsNyLCGxSgdErv8Ln7Am7Kx0ezpziNoVvhVWutK0atcqYVhrpWi0YTyYW+lSiPMY
 Z9nLGnmy2cvNcEkIfVGSK2wOPabMnBGQCUQqbTH/yjnSTB9By/FfRcYbUcW8uFV1CurH+kY
 02We0j2O7ZWGgK3eAoruA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L2SZt/E/mSo=:gsAKhySfIfj3gil+DrrSGS
 bMA8+zZT0EAGUdOrTXDn+CNuheNF3+l0MKctvU+XwjzJRtsuw2PsWy3xwZch/ovClWh9eg2tD
 5PW2NLYwsvUruj5cCtkqWMtWh/fNVoiA10yDXigJJNevfsAFo6IpvycZ41W+ZqaBazFYVF2YV
 2dc+jKXfWtGqFf9J1ZmFPUaR6+weF+VpEwhSWP/EmrGAm47KGaTTZewzz66L1UhpNRR+VgcrL
 CGHoao9djtM2ca5o1l5vCXFvXsEznlqkyj5Yvy2uX8rK3NmycAXc77k+907mheK080B+JOe8D
 oBZOWANMj+CnsI3cURX/9cnfJJuYbWH371nM2oc+Bn7/P0J4lkJwjr9OGxLDwfx5evYil7wP4
 K+8sJDDXLfPLGPlET4vz/TO4VRz8dO/C4uvvh6HkXWN1bUkrBCaN0JFT2czA/VMz4XkJU57Zs
 dwxpPeTq5sMDyXq0FuCPjCmlepWeI3xmztRA52aguD7AzRN26rQkIL8d6kqHv0hUHMcyHO5K+
 4nXIJz7EDEUJHKDkFnzI1z5j4gz8lrVoaIhhQrAnbkDnjSDFWKgqulCggLpFmfdUdUozR5nFo
 BOPu8qfQxdMqAGiDpgsNZJogqgJkr37o6WH+tfDbV969IJeEAzb14YIxahSFDlYGaBraIYxD6
 w1HyfM/8vtk0f0wRrUZiA6SvMjhuf0BRgWQzXKk0u/7OlYPJkf6IFkmdO7bnTROLZbFg9V+1Z
 mh2aiwTQ3ORmKv7TmIJhHIQv8/85/VqqjoPdnq3xpjcGLKxQxYAKd4y9YJJo9C3A3YAAOv7kr
 Jo6isz9XAyJEzGmj83TdSRNoUE+NRxPfEu+MAavQLaRY3yjfMY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 02.10.2018 23:16, Greg Kroah-Hartman wrote:
> On Tue, Oct 02, 2018 at 11:02:13PM +0200, Helge Deller wrote:
>> please pull a last set of fixes for the parisc architecture for kernel 4.19 from:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.19-3
>>
>> The major change is for parisc64 to use a 64-bit suseconds_t type to
>> match what glibc expects for 64-bit userspace. It's an ABI change, but
>> since we don't have a 64-bit userspace on parisc yet, it won't introduce
>> a breakage.
> 
> Isn't it a bit "late" in the release cycle for such a change?  Why not
> do this on the -rc1 release?

I've tagged it for stable release.
So, it can go in now, or just wait until -rc1 and go in later.
 
>> Other than that we simply drop unused code and outdated gcc version
>> checks.
> 
> Why are those needed now?

The patch in there which is by me changes one line simply cleans up a patch which
went in during the 4.19 merge cycle. So it would be nice to have it
added now before v4.19 gets released.
The other two patches are trivial and just remove dead code.
I rate them all as non-critical, but nice-to-have-in-v4.19. 

If you disagree I'm absolutely fine to wait with all of them 
for the next merge window.

Thanks!
Helge

Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16C5C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DC92089D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DC92089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeIZACF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:02:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:59217 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbeIZACF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:02:05 -0400
Received: from [192.168.20.60] ([92.116.170.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M4CB5-1fn3ad0pKV-00rouK; Tue, 25
 Sep 2018 19:53:20 +0200
Received: from [192.168.20.60] ([92.116.170.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M4CB5-1fn3ad0pKV-00rouK; Tue, 25
 Sep 2018 19:53:20 +0200
Subject: Re: [RFC] parisc64: change __kernel_suseconds_t to match glibc
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "James E.J. Bottomley" <jejb@parisc-linux.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180913160010.905798-1-arnd@arndb.de>
 <de79d285-7cbc-e547-547b-cf3e0627950d@gmx.de>
 <CAK8P3a1WT87CFyz7457R_cx=ueVjG+xUWXAA6SSw+C4ZnaZHVw@mail.gmail.com>
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
Message-ID: <7fdae639-6871-df29-ffbb-1096822ebb34@gmx.de>
Date:   Tue, 25 Sep 2018 19:53:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1WT87CFyz7457R_cx=ueVjG+xUWXAA6SSw+C4ZnaZHVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OTmFiy9cLutHMWuVH2OrLX/+P94p7PLLo1V8cZQGTo834X2gbQi
 M34aXGBMM/G9GO6bwzKE8OK1o7RpRaJo/tqnCnDt9aQH7jV2hMQNRBjd5a9mv9UC0rqisyV
 CJuaDg4rbnd/XNs+AQD6zWvqyQ4zTtbog1Vfl/Sv1mGibgluG/iWDHe4udmRaHziTdpn85d
 AylEE2cGYZJeM3PpOe1Hw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6YZdoWaQRMw=:U7tOZpnWeu0Bq4ytF/TXU5
 dg/xzz2OLBjZBnyPcovR//XlQKIOKFQGDq+3iIkB3YtrVltFozGUtT8v8xjdNSu5pxFfXnd8t
 FcU1nvsH9R5rk6uU5R7I9fIoxvMHKicE7ZOGOs3U14d631sp6bhl7IaFcYWjRAfmbAuaz0kls
 cvpQl9MH75gSvVXJG0q9eLNOyf2z2a6qLi3a0oDfrixCQDCf6GIyN4SJTWzpLOO2SRoAjwyQp
 xEEuPpZDYcnf+zgIK8GazZqAdnOXpZrZKN1B3HDzKHKBUr+ZkMfDWjM4rEqTCTn9qDoreDpnW
 Ohhjnoy5GkY3xRLo5DnFfSc2nNjREd9YmFlj9FhY4iJFVytER6BBYj5dE/SsXvGRqMgNCUjgD
 ORS3gFqSV2+INMPaoVVsJsCgc4trzBKSBdxySjz+OUFRowt909HUF08Q8C1ZrP45b/YrZrfNg
 DK7n4yRlse26xJ5j+Cre2MX/4Uiq8mGWUX63rbbaDBhy/jxlCXRIx2gMheic2KVcHaFMi0WDv
 D7Nmc5QgZDomlkE+UBMmk+/2p6d+xN3bH+hvIdFuUm8IFqjwogvEMGi6xw6YhFXqGfisjiUB5
 MIaJ0rjZK16uBkNdeTTVkiZia5o9pQQMhYBzjePX3a9Yn3mCShoVPs7imRbGxHoNCRHE1RYGu
 ok7Yv6ipaBw1HXPkETWKEMdAkd2gREnHWBHVL3YwwPZHs2zUXoP00Xi9bs9N+44ZvC0OUTNEw
 uj52L1NE8//SV6PYAz6bdu/jPojzctybPnUE0Jeh9BlAgb7FIubBa7CfuhzsZ3rXqd0YtsjJv
 J1f0OTQOa4bojfGE9YFJuARjIZ3HlXA8lrWU1TVoNT58/DGtRQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.09.2018 12:53, Arnd Bergmann wrote:
> On Mon, Sep 17, 2018 at 9:46 PM Helge Deller <deller@gmx.de> wrote:
>> On 13.09.2018 17:59, Arnd Bergmann wrote:
>>> There are only two 64-bit architecture ports that have a 32-bit
>>> suseconds_t: sparc64 and parisc64. I've encountered a number of problems
>>> with this, while trying to get a proper 64-bit time_t working on 32-bit
>>> architectures. Having a 32-bit suseconds_t combined with a 64-bit time_t
>>> means that we get extra padding in data structures that may leak kernel
>>> stack data to user space, and it breaks all code that assumes that
>>> timespec and timeval have the same layout.
>>>
>>> While we can't change sparc64, it seems that glibc on parisc64 has always
>>> set suseconds_t to 'long', and the current version would give incorrect
>>> results for gettimeofday() and many other interfaces: timestamps passed
>>> from user space into the kernel result in tv_usec being always zero
>>> (the lower bits contain the intended value but are ignored) while data
>>> passed from the kernel to user space contains either zeroes or random
>>> data in tv_usec.
> 
> [back from traveling now, sorry for the delay in replying]
> 
>> Should this wrong behavior be visible with 32-bit userspace or
>> with 64-bit userspace (or both)?
>> I didn't noticed such wrong behavior yet.
> 
> Only 64-bit user space.
> 
...
> A simple 64-bit gettimeofday() should report incorrect
> nanoseconds using the upstream glibc implementation.

Yes, you are right.
Since we don't have any 64-bit userspace yet, it's safe to fix it now as you suggested.
I've added your patch as is to my for-next tree and tagged it for stable-tree.

Thanks for catching this!

Helge

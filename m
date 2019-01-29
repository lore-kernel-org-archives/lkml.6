Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91A6C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9068D21873
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfA2SG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:06:27 -0500
Received: from mout.gmx.net ([212.227.17.22]:51903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728622AbfA2SGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:06:25 -0500
Received: from [192.168.20.60] ([92.116.166.204]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLelb-1gpMr228rT-000qQ8; Tue, 29
 Jan 2019 19:06:19 +0100
Subject: Re: DMA-related cleanups for parisc
To:     Christoph Hellwig <hch@lst.de>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190114112353.30616-1-hch@lst.de>
 <20190126171124.GA8151@ls3530.dellerweb.de> <20190128073437.GA3287@lst.de>
From:   Helge Deller <deller@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=deller@gmx.de; keydata=
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
Message-ID: <fece406f-c6b4-a8bc-43b6-4f44fc5d548b@gmx.de>
Date:   Tue, 29 Jan 2019 19:06:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128073437.GA3287@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qHDy6Rj3tvrz6eFypq8dy6XWdlxUtFp9atFSSg0g3zUSfNlSKjl
 Cy4kxN5KVhfsLN4X4jt2KCvcaj9HE6C1jbywEwmY4M0P7XwtNnhiG7reInju2oQII5VzKHS
 H7XbLQG8ulpMplrRfJdfIaC/HeOKHGtFTJlJaitiWmnLuByfvnt/sSa70lVGNE8DurAldRT
 xj3tOSClxpwlXXtJkIDRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B5VQ3fJPXEY=:EWaKYWXAxlEH/ACb0v3SQX
 7ADq7GtoUkCuLpMfeqOKmZY7xgqsLeuJggRPh7Z7hh9oYu3sUuMonbDwvjUa44semM8JRSFgY
 kNLJRxWGpm7RUVzYjDrYxel91Jes82QDcksmWr0oWHpatReIrNX4iu+Nxdcjcai8vgJn8VrqI
 iNK6o/K/mqgsVtVWxZ1CDF4UakWnWBTAgPbiVQA7j9zN2t1v8sRbtTxcVrSw6OErBVmY0KbcH
 2rWGqgZ2E9KrB0levjRLK1y0+ZPcbTT0qUMTfDmWQJsAQYe1ktahzPf5T9uaZEv+5JYch9DkB
 yDOESZap4szFVaRI3bTfXEHHYGFTeDWGfE0BMi5mAS2QgHQ0mP7Kuq9w+G2NIh85pXqMKyXEQ
 3YhcI9gkgVSKZU4bMuq/jjIodZdDzuKndX/eqG4JCRwSFsi8L/pcBWmRXQdj80zs0ukKvkymY
 nVKQFiyvfHmHoBgEhaVAIKMJhqqQrlnGIxO1YZyPdexV601yFrz5NRHLkf4oYjX7jWIXv7WG0
 md6m1vEAo3bU2T6PtG2umCtOHig6bARNLrRzqCtoEt+rDoeUcyPP/YuAcY1eWsa1d2higUt/I
 z6Z/zg0furYh80+bgaujVbk8Wh1ONRY3PweNjI3mAX6fuyjv7bBRnSU5PADTbe4GGdZ4iD4yJ
 7WVfHot+GD3oItEAIgOmCWcbD30o2VCWfHkU5LVwiakdoa3gDoSHEd/r8aOttxthtU7kDOyZg
 5m9TtvwxNL6LniOkRlMpestyNbq9Pqw46wk+EsWXshynjFQ0k/vf7ONZliq04ESVQKte+ESmI
 N4r/1CDkWIIVzcWdMe8Pa6LK6B2/cQDuF+drlr4oF8ubrnSe5iMxGygCxYcFOu+xQWd2h9ooF
 gDLIOyoWymViSX6LREwm1hN9wGGXTRjaFIs0uAcSXrlyVbZEH+8l2iM8WAWkvD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.01.19 08:34, Christoph Hellwig wrote:
> On Sat, Jan 26, 2019 at 06:11:24PM +0100, Helge Deller wrote:
>> Thanks for doing that!
>> I tested it. Your patches work, but you need the fixup below (0-day
>> testing complained as well).
> 
> I actually sent a v2 series since then which makes sure the new iommu.h
> includes <linux/pci.h>, so that we don't rely on header ordering.

I don't see a v2 series. At least it wasn't sent to the parisc mailing list.
Can you point me to this series?
 
>> With the one below, you may add
>> Tested-by: Helge Deller <deller@gmx.de>
> 
> While this series prepares for DMA layerer work it isn't urgent, so
> if you want to pick it up through the parisc tree that is perfectly
> fine with me.

Yes, I can take it through the parisc tree then.

Helge

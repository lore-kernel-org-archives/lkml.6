Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD81C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF9120882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfA2TVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:21:23 -0500
Received: from mout.gmx.net ([212.227.17.20]:37435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbfA2TVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:21:22 -0500
Received: from [192.168.20.60] ([92.116.166.204]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ltqmn-1hGE8I0PIb-011EXL; Tue, 29
 Jan 2019 20:21:19 +0100
Subject: Re: DMA-related cleanups for parisc v2
To:     Christoph Hellwig <hch@lst.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190129181310.5557-1-hch@lst.de>
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
Message-ID: <fa6735f0-8241-e7e3-db93-3e6b16080c0f@gmx.de>
Date:   Tue, 29 Jan 2019 20:21:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129181310.5557-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FHPcOzXCQNSC6cSB3qQYHmUzrnJC1wjdY5rIF5nuh79xHzg516T
 ChV3mUXYPDhVOK8QISNE0J+uSvbQUvAQbwjHc+zXfVDT+477gNX8NA0xA8kD758S7AhgTyQ
 a3NheAA9efUHxPE10IG10Lc/LBvyID1IhiMWt064BuNAva5B9/uaUtkIATvc7gaSdTUsVsH
 BGLkhot5dfM06SLzb9KgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8EniY1QTUz8=:SNOCNYDVcgfwQvoLcEjMny
 r4mCzCjuETOENe5x9FkFJsQAzZe0/fbXZnRY12tuatZGphc/O6+FE8S+WnzZhdUzgJooS4q0W
 +ip/03oGWUiLg/z3MNjKPSfha6NeH+PHdUxmAhvYXw/TTn+Wqx2v6IOQR3pS7w8XPnWYH5YW5
 emgDDS36FPyDJUew3CeE5R2DDwGPil4aV32ED8irLGcqP+oAlIGPOIDHJo0Qpt/aTSfA5tnH2
 6+zItznw3mxqfKlJUmzW/NMys44v3IAQtaIQBhU25JZIhekXsybqJ3ZYXjXwFOeIkTGrKX2lR
 US0vE5oT6AeGiABLdsb5gysTJrBi3lKh/jJVtfPji8hVRu11RijaYFt7XiGLQHO1VG8RYyVYu
 8j/ujb4+Y4lDdsG4wWAcM9ceCl2t6EbwDzhrbPpdk06qtYMTkwS74/BPkmFYzPxUF4/1xLl/i
 dHjYgc9KoUjlDGhRAU2HlyZ/TANztRVnFm/TGCCwBdKAR+r2bqzVnlHycynwN7WUHRr5d1TSC
 Qf3Fc5ZqFcxmHOqSgWHHESSfERaanRo4C1EcYEuU4CqffRbnqE0M2oAS560/N9OZowsei2NcV
 H3Uy+dQR4+OqsjKUn0iOy+LTcTWe9DG2bHdhyJvaiz/xyxFWwdZfNixynuGvkJFp4dd10Rx/w
 SDTGMAS9gI4RflEUa4xp75n8xbUrbKG5xMim47SgT7RW6xj94Njh1GRfoYI4jTLPcU8vpU9N5
 rcZiuwuVtV6pVzO1gt3WJXee7a41KA8Yxb5WLb2FjxSxYcFKp8ZW1Fg9npD70x6fz/Ii40nY/
 QvhKSSbW7gzacv1U6CY6GNr/SnKhyQxW+5r/e9tNu3imOJ/FSUmy8VJU3qmcl/5XxoORWe0wq
 X/hAUOWJli943faAs8dsFD/fgj4coCS2o4H+w6qB/LqmhDu/JKvU5X2fFG/5cvOWpjVm8Cpaq
 mSraYmkVHH1cx9Omz12/xHDIPskgxnz/gBmUnulTQmrRWsuLht3sOcruZerbKLdyW7LRBLThD
 uQwdONwWc87z45IMfYkhxVo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.01.19 19:13, Christoph Hellwig wrote:
> this series has a couple DMA-related cleanups for parisc.  The main aim
> is to move anything not required by drivers out of <asm/dma-mapping.h>,
> but I noticed a few related bits and cleaned them up as well.
> 
> Changes since v1:
>  - include <linux/pci.h> in drivers/parisc/iommu.h to avoid build
>    failures with some configs

Thanks!
I've added it to the parisc linux-next tree.

Helge

Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BB7C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4422070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbfAIHQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:16:59 -0500
Received: from mout.gmx.net ([212.227.15.18]:55989 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfAIHQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:16:57 -0500
Received: from [192.168.20.60] ([92.116.138.157]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBFgr-1gWz5S0OJh-00ACYN; Wed, 09
 Jan 2019 08:16:51 +0100
Subject: Re: [PATCH] parisc: replace oops_in_progress manipulation with
 bust_spinlocks()
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     "James E . J . Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <20190107095612.7086-1-sergey.senozhatsky@gmail.com>
 <d09f4a9a-f966-80d7-01e1-5d92401b5d7e@gmx.de>
 <20190109053941.GA28834@jagdpanzerIV>
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
Message-ID: <3c7c981b-d99f-5230-c3af-2df7d59fafff@gmx.de>
Date:   Wed, 9 Jan 2019 08:16:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190109053941.GA28834@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:atsCIK8CMX5ME4Mtlv6F8sA46QAk/oXvdFOdAhlhwMuyj8ICcQr
 E0UEDchdCgeiqp2WNvCjD4ATJYUSsIwtVhv2I+a3xULKrqHY5T0TQPCDhwzuA456GG+csPn
 Yz5BU48jwXDQ6/mJ4RgqlZJuHfm8U8OJWn5OHMAagZFiCCs69k3rkLGBl7S3DlE+oggGbRY
 GzfYy2zWNryJJNccWK92w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2RRD9kuiaN0=:hXywl+SaK2rTsDZkoeEvL4
 WrgBqol1bnCfykqV/Mtl3AutN7hVXZnC5e18h2rXvDdLTVA0csOKH4/W86RA0aMw+DytHK/b6
 K0fte5WcFzkemEcwNltZcCw9I3bA+g5sW4ApF8OPK44nULY5+nvTzP8QunXMmY0XRadNwji3P
 EumqmzDyVe1eb81iPQm6WUn6WqMo13BpzvHK8LIl8Y7VNrosm6S04hr4ZEXHFH52TkeFwU1n0
 1GWAZKMXRd3/2b6UKi+AWYZnbaZ2MGSfnwwDDnPKV5oJMgsnZFpdShHaupt4OYQ+9zMZEvliK
 CbXRyvZ4EgSMtQZaAZqum3IoG6RdabM9V46ZIQPFycNnUyE379OEBD65354AYlb2J7jjZvUaC
 9YlU9flHjXuf6GoIjF17jU5uDL88rZ96ebIRYSTSP+75dCwYQvLIAK/I4eoc4oCpOr2nrtYJm
 8Au84xQmoKEKGwvaJjUjA9FCZ5ocK1+ZgiAlMgzZgHdVIKAhW/1Hs+JBiqB7WnNG+KhzLsPG1
 uVMyi+OQj2cmaSzVKWOCgpk4BmAm487/AXCOd2r/Bda0+oi2N0LLu0o3seIygZpjrgxk1vWpD
 ctH4JSRZAWjFgYOT6nLecr9M0Wuoz9CWpyB5pUOmawRJ2BZc/BXU1hcUS7f4y8cWC1cVJsa4n
 IJvpWv/SDj+V1ZowqDi6Jg0R8J1ZlFVDdk8NRN/nWy7f91MCOX8D8jfr6XnaKV5AKHs3ufvq9
 JPgWQUt4ib2K2UvKf541NtJPutgSEmyEjioiW6+OA1JtqgQHG94ds7PjNqQ0JUk159UEoSikl
 x7SGYVIAXhbaZnn8gN1q+VpjwUbV6q631scuOaBKmwxiOKZ3CV8fc7wo9O3N7btuipL2uaGpE
 u9YdXhoWMVFsYZmFWptYOCDe9MUPqoyZ/qDXV4iFeHJVmsewZlHIUDWrOVnikg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.01.19 06:39, Sergey Senozhatsky wrote:
> On (01/08/19 08:44), Helge Deller wrote:
>> Date: Tue, 8 Jan 2019 08:44:19 +0100
>> From: Helge Deller <deller@gmx.de>
>> To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, "James E . J .
>>  Bottomley" <jejb@parisc-linux.org>
>> Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey
>>  Senozhatsky <sergey.senozhatsky@gmail.com>
>> Subject: Re: [PATCH] parisc: replace oops_in_progress manipulation with
>>  bust_spinlocks()
>> Message-ID: <d09f4a9a-f966-80d7-01e1-5d92401b5d7e@gmx.de>
>> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
>>  Thunderbird/60.4.0
>>
>> On 07.01.19 10:56, Sergey Senozhatsky wrote:
>>> Use bust_spinlocks() function to set oops_in_progress.
>>>
>>> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>>
>> I've added this patch to the parisc for-next tree.
> 
> Thanks.
> 
> BTW,
>     jejb at parisc-linux.org bounces. Shall it be replaced with
> HansenPartnership.com email address?
> 
> ---
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7fc7813cd9c2..86b174dbe506 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11511,7 +11511,7 @@ F:	Documentation/blockdev/paride.txt
>  F:	drivers/block/paride/
>  
>  PARISC ARCHITECTURE
> -M:	"James E.J. Bottomley" <jejb@parisc-linux.org>
> +M:	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
>  M:	Helge Deller <deller@gmx.de>
>  L:	linux-parisc@vger.kernel.org
>  W:	http://www.parisc-linux.org/
> 

I prefer that change.
In my role as admin of the parisc-linux.org domain I plan to retire
all @parisc-linux.org email addresses soon anyway.

Helge

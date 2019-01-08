Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83615C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D08B20700
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfAHHoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:44:22 -0500
Received: from mout.gmx.net ([212.227.17.22]:52705 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfAHHoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:44:21 -0500
Received: from [10.16.37.249] ([155.56.44.137]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LaJWs-1h904z3aLW-00m2DX; Tue, 08
 Jan 2019 08:44:19 +0100
Subject: Re: [PATCH] parisc: replace oops_in_progress manipulation with
 bust_spinlocks()
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <20190107095612.7086-1-sergey.senozhatsky@gmail.com>
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
Message-ID: <d09f4a9a-f966-80d7-01e1-5d92401b5d7e@gmx.de>
Date:   Tue, 8 Jan 2019 08:44:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190107095612.7086-1-sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6yHQLIN7zbmZ5mfrHhiu/A+vw/g2wpOdmYPEwF5ofzrOOGVAjLC
 s0RlZCFg30Q0j9fUG2GkmEAn11XUb2XJmXGQE/ZwyJ2m7uLQp3x5vN9kXC1lT/1QXtGpl0K
 uLr1DtRdTg0bqTN7jg059UmPj5zkGHft0Ef05erf2dyX/m8MdJnqCVuOjmSzeh6j9gf1yC8
 kl+rfRFTpYQw0OI3NlQtw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qKrvxApiw6s=:C0wWQ1n7lOqlnRWoYc1KFh
 0SQOAiEr6WGMgih3UKU894xDjiV8EyR9qL9Y9IHvydzcR1SId0A9RXYuLo13b9WNWTROZ8ig8
 sjGvjn6s9jPyH9avVsa1yHf80PYbc9kVjSAbrhZHb3ljmVGFx5Bqb+F8j4/CnBO9f42tGTOS8
 blB2o2pnSnoTfxW0ZH6NYYQWuBS9O86NcrGRWbFMC3ck0XNz2eRQS2bH+PHHtDmaLvBu4jk1C
 cNdgGcXxr4bPahydOXLcZgnpEixyzrmcddGLUJhc8XVXx99BfqiCaTc5aWbGCNWm6WDEqKNTB
 Ekb2EyJ7xNhfZ1tT1TvVS4ehaKWhNpF9iDjfj5RTY8k3ivUC8AxasIWKG+tQWK3KFRiEYiMSN
 7qy3eMFmDnpP6swGhKX6yl6PrwHCWAAABEbZWgW6ozbml2qCWmYzKmAg3S8L+UkajbUSoIBd+
 f+zXW/Ad4zh4DOy5aF/+kFI5jcV+KWeA9ClFEbTWVVIUbdooT0pGerMPRw3pjJosY9MqjQpO+
 5hbBV1YPyNcp3Nb1uxCiC5dIrfkpK87GfldhCHHzOZYYchWFkq7V7o3g7RP64zxO4tZ+LlnkL
 6LYXOfhlcJPMToOT+i/Q/WZ35qvxi4zJ4hwj3EPOD0E4sZzg8wNraJL02E0JRab8tuzIr0DnP
 cVQ3+6pm/yU573ihAUcBcQA3zmuraHkNzTXhnXZyETqpm+QlTqLBdfaIJsGiDfvpcuAdidWFb
 z1mbMId1DmvW/8JG53PEjSi1MfqfH1sgLE3JnnjRtP4hUrnyBhu0OckKZG9cDoXnyROnTltDa
 njB3xR01JMHXXBzS/CDeRlFXEcBMMHjuJ1IQu5jkdbnSxUUjdtzGBWhLAk9/pIyY6pxWgn2os
 0E4aIDSyaKlTYtdEVDoQBGcK/ic26SJG3Lcv7dqEk5bCaULaQMSfEYjQpOauaV
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.01.19 10:56, Sergey Senozhatsky wrote:
> Use bust_spinlocks() function to set oops_in_progress.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

I've added this patch to the parisc for-next tree.

Thanks,
Helge


> ---
>  arch/parisc/kernel/traps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
> index 472a818e8c17..7e1ccafadf57 100644
> --- a/arch/parisc/kernel/traps.c
> +++ b/arch/parisc/kernel/traps.c
> @@ -218,7 +218,7 @@ void die_if_kernel(char *str, struct pt_regs *regs, long err)
>  		return;
>  	}
>  
> -	oops_in_progress = 1;
> +	bust_spinlocks(1);
>  
>  	oops_enter();
>  
> @@ -396,7 +396,7 @@ void parisc_terminate(char *msg, struct pt_regs *regs, int code, unsigned long o
>  {
>  	static DEFINE_SPINLOCK(terminate_lock);
>  
> -	oops_in_progress = 1;
> +	bust_spinlocks(1);
>  
>  	set_eiem(0);
>  	local_irq_disable();
> 


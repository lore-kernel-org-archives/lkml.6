Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FCCC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECDA2582B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECDA2582B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030401AbeGASBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:01:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:60075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030264AbeGAQaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:30:00 -0400
Received: from [192.168.20.60] ([92.116.163.159]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhRUQ-1fnVA10hhy-00ManT; Sun, 01
 Jul 2018 18:29:55 +0200
Subject: Re: [PATCH 3.18 35/85] parisc: Move setup_profiling_timer() out of
 init section
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Sasha Levin <alexander.levin@microsoft.com>
References: <20180701153122.365061142@linuxfoundation.org>
 <20180701153123.756542422@linuxfoundation.org>
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
Message-ID: <18c43f1b-fb29-97a0-883a-d71fd2de80c5@gmx.de>
Date:   Sun, 1 Jul 2018 18:29:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180701153123.756542422@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tNFAALgeZyIp5PUXGcXeM28ELmarYwJ5V9q9IRsvEyotQd2Uv7Z
 Hr/CZh7O/BAYTfR27Xrge/UcDu+BHe18O6G+zKneL+5iEZLSW6QclOEUEB3sTIJji3gH8SA
 1D/iwv2XBfl8/JoHOXB4cpqD0sh2MwLsdcgfZKXnYFS5/zFYLvwc6uCkE2HGDrXv0F5Ei61
 lSiCfDO0mKhll58Iz2SIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BnKvwrR8L4Q=:3lWvXK73FUZrAugFIvzONk
 G2g1MIiaUT1jDM7vTl8Dhya5lK+8LNaDl9B1iEe2odyRCvkjGmaYlPS+ROKxJQ8OAdrmVcVBM
 qNIMn8MOqTP69aJhMM4qV//at7ZBYYQ7nJaAPCUb7deMctDVzwLpl2JqJLvlHiRExMCVXFmdB
 zC6wKj7IGUVK2bXAKcnOUZzmgv6PHlXxGhtwNhfDJN8atmywlD+CIl2tDVtt4drrniWKQI7uc
 pSs7eFzLVe3AR9FFZmclPSLquEPArm5TPkQi6aPEiUWEOyj+3xkap3AcP+qgczAgzXniTfK8z
 Ad5ibjl/E/VRD6hZH8Qh1aIVOCijT+h81vevMJjACW9px6XqwvhVDbcsJOEFisMFaYcDX9cOZ
 FcMtjch+COhFgNYAf5UKW6yZHSlkn/HVK9Fexej7zQSpYzwWovFtzPwc98JFvpJmk2CMsUXfq
 OdeFcUrDqnHubRxYvrUfLy3lf7YF7vdj2U4NBhw+lKaF4hQaef6gDHIahO3vFtpDITA3IxkBN
 l364RsiRaOiP8Ul2r7y3ZEf78G4x5fcd+WCjt/1LwFNNJnnDTzDGFgu733zPdM0C4gwaAfgQc
 8/hSfWzz/1YdMe0nLQGNunWcADY3D60OBbltoicRPeul72+RkM8QQciK4Iy/6rNTCg32BBQ+H
 PnTxygqQwB9SkM2p//pEZPRkS8p6ihotILS42+MKPnSUiEihX4Gkmz6SC2fSqXjiVSgipvz5Q
 1n5yDoJDlCzvIae8tLJOoLG1+IUD61AzrxA1hj4YUQS9b+mf29gJEoUJ5Y/JMbwh2MwO1q5rj
 C4T3lb3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 01.07.2018 18:01, Greg Kroah-Hartman wrote:
> 3.18-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Helge Deller <deller@gmx.de>
> 
> [ Upstream commit 01f56832cfb6fcc204e7203f46841b6185ebd574 ]

I wonder how this patch and patch #22 ([PATCH 3.18 22/85] parisc: drivers.c: Fix section mismatches)
reached the stable trees?
I haven't tagged upstream commit 01f56832cfb6fcc204e7203f46841b6185ebd574 or 
b819439fea305a0bfd6ca23a7994fd1a8847c0d8 for backport.

Anyway, I'd suggest not to apply both.
I haven't tested them in those old kernels....

Helge

 
> No other architecture has setup_profiling_timer() in the init section,
> thus on parisc we face this section mismatch warning:
>  Reference from the function devm_device_add_group() to the function .init.text:setup_profiling_timer()
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/parisc/kernel/smp.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/arch/parisc/kernel/smp.c
> +++ b/arch/parisc/kernel/smp.c
> @@ -422,8 +422,7 @@ int __cpu_up(unsigned int cpu, struct ta
>  }
>  
>  #ifdef CONFIG_PROC_FS
> -int __init
> -setup_profiling_timer(unsigned int multiplier)
> +int setup_profiling_timer(unsigned int multiplier)
>  {
>  	return -EINVAL;
>  }
> 
> 


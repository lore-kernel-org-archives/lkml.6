Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754019AbeCFVUb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 16:20:31 -0500
Received: from mout.gmx.net ([212.227.15.15]:38807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753656AbeCFVU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 16:20:29 -0500
Subject: Re: [PATCH] parisc: time: stop validating rtc_time in .read_time
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "James E . J . Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180221214023.1045-1-alexandre.belloni@bootlin.com>
From: Helge Deller <deller@gmx.de>
Message-ID: <c80cb9e7-6a07-bc12-5758-d2b642a315dc@gmx.de>
Date: Tue, 6 Mar 2018 22:20:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180221214023.1045-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:vfLZkAkxbuUOMmmTzrPHiHEQMAAg978caa/IaqG4e9nZ9ovLFRc
 9jbBZ2b6CRT5GItoX9teh5tSB+HtrwzdsYiN/mYPsimozSxDpEsb6gbX6GNMVuy2XRDRaTB
 LP99bABEHgrdIge1kYdiAw611tDtJmfqsjyDT11lDpnKYsgW2TOfV60Z9usfg1owS5YAK7R
 4SMctX+l+aXAoJEcXhMxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g3a2UlaiH8Y=:Q1u9Hsb9Z0pY6/ZtUYvOXV
 cPbkb+lmk68anQrdPwctox6nQPSDyx/Mcp3ursoMb/WSUjWlYPjtkNCmRICtP0ImIeABO7UMC
 Ne+aXBITNSD2+LwcPwKSq2rOd/26RiVfFzM122ai96TZ6vwC1T94/v0y3inTKYKRC+J5ipwhu
 GSZ6Wdz1ep2kLhF3rDebIguQL9unKkwG7gtMt/qStdVeqzE+NwvARrxW2G2uUXKhApw0ZBfFA
 pDtHnXliY2mBcp4+fkXoY0TjBmYWifJuphK7YmLGTfssrx6SRSogkU2RwQgb/H4v8NE3roOBP
 fkvDm5hudaAJi3G8jLKqJSvzWaxL9ZaIPt+XKWeBxHyx5Gv1Leoxmm8Ay7v0S3JekIQx7uYx8
 9gfsg8sR9NpYJso09kkMTVbwRNrPdw/EFwXap7ErXbzl+eoZAL4bkdf9jMEGJ9bFxfdQxHrF6
 VhVrrH7l1u9bFVSfi8pTRssOuDIq5/kiHaCcNlPwFs9ShG9U93GuT8CrRF8hu2iVzO0FlcXPH
 BvWcwt+N0HZXHsUdbXXV1Of0k3v0phpP5cz75ODYucpq/PhoxQGk7bvGqFg/iaWNGYyX4YuV0
 ICf17o/33eAfm/y+rzUj7C2tkMSbwHZU/+ee/5AR6hdeZVXMj1e8YbOBQayXpN0iJ07qV/4K9
 gg9pGjorP/cCTkQed+Ue8WnOljG3KPsFyl9bKAxh0QaacDvHAf1EjRNybEyaTMRGiUOYI5l4s
 4ATXCNzL8Zggdc1br0T8yKW3zmWKp0qAYxqzcD51+Iw6TakOF6yTRjqBNPTJR3/ZfzEV4xoE3
 u84pEMo8+iF/fLWwlf/NFZ9lFtuvx39id5ZqLNDWGZRcnSvehA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.02.2018 22:40, Alexandre Belloni wrote:
> The RTC core is always calling rtc_valid_tm after the read_time callback.
> It is not necessary to call it just before returning from the callback.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Helge Deller <deller@gmx.de>

Thanks!
Helge


> ---
>  arch/parisc/kernel/time.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/parisc/kernel/time.c b/arch/parisc/kernel/time.c
> index 4b8fd6dc22da..f2890bd240f8 100644
> --- a/arch/parisc/kernel/time.c
> +++ b/arch/parisc/kernel/time.c
> @@ -173,7 +173,7 @@ static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
>  
>  	/* we treat tod_sec as unsigned, so this can work until year 2106 */
>  	rtc_time64_to_tm(tod_data.tod_sec, tm);
> -	return rtc_valid_tm(tm);
> +	return 0;
>  }
>  
>  static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
> 

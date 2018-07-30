Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B338FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C144C20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTanRUU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C144C20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbeG3SfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:35:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36319 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeG3SfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:35:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id s14-v6so149143wmc.1;
        Mon, 30 Jul 2018 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C0tiThOjIlM20CFnF6WsWioNfbJKwp8Y8323w2+s50A=;
        b=XTanRUU+JSATBuGHthZgNlcWQn8gnSti1HWYH4gtIdnmcaC2d1ql14QN7GQuxa4E0M
         1HdL4P7k6f/srJj+uRXfgLu/ew9bqFr0ZEvD63oRqTa+wnARonwn+W77cw9UAu/13whI
         CHa5J4SHjaZBLk04/1hq7PtIlz8wBMsj2WUy2rftJdB6rP7pnTntD+ydUug93B2zDbPL
         4p6w1NIE9XboAyZNOBbY3Xd6eCCYumgYpglh58uJ4//UdMfR4nbhrNxk6bwVYs0TbOTO
         33Uf672mZKcuTBWQ1+rWyLBybn/yTS9RDXAYyEY+jSTQFkPkREM+maykEFo0Wg3BUztP
         f9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=C0tiThOjIlM20CFnF6WsWioNfbJKwp8Y8323w2+s50A=;
        b=VCceWpB8/5gTxk6MOHYnI5hPRJD53GxxHtTqEwwWm7cVu/ttmgM4x8VrTWTKNo1ba0
         BOC5FzSZsGByf/fuEr2X6eiWIWWJz2I1dev+C6xzTP8KbwysGV+Wp8IFtJEoutdLlchW
         SprhX4eIzwv0/XoPTrh9xfE3wHRzyCExecJtfwjxOHWwuVkqefZ3i36wrxqWDeM0ReiT
         IvahUFIHWA2/YGK7se4s2W+Q4oicYasZUHfK6DNOAtyxLHDr1gi3EMB/UKcMVDU0rxan
         l3hHgzJpj65D9oYRk+OI31Ee7a+itfeyoCC0lTniHA+n2SZ+Tz6pQ37CRr2Msb+Jwro2
         aDQA==
X-Gm-Message-State: AOUpUlHLze+61I/uT5g/JFyOIt0E7KIwAJNJ5yPaRsN9yEg4TapeliAP
        1MB8LoRKW5KbXyrg52RF6c0=
X-Google-Smtp-Source: AAOMgpfLSGrHIqMmqPVxp61QK5/+BV9+TkPPyr/HJf4F6OVDL7t1yH/Q/EnO0uuCfM8C8D8PLVXRUQ==
X-Received: by 2002:a1c:c289:: with SMTP id s131-v6mr64610wmf.65.1532969620763;
        Mon, 30 Jul 2018 09:53:40 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id v10-v6sm20226998wrm.18.2018.07.30.09.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 09:53:39 -0700 (PDT)
Subject: Re: [PATCH net-next] net: phy: mscc: the extended page access
 register is 16 bits
To:     Quentin Schulz <quentin.schulz@bootlin.com>, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <20180730125313.3405-1-quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJw==
Message-ID: <4dd7d451-a1e3-cab8-dc5a-6666c5d29089@gmail.com>
Date:   Mon, 30 Jul 2018 09:53:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730125313.3405-1-quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2018 05:53 AM, Quentin Schulz wrote:
> The Extended Page Access is a 16-bit register, so change the page
> parameter of vsc85xx_phy_page_set to a u16.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Since you targeted net-next for this patch, I am assuming this is not
yet a problem, but would soon be one with the changes you plan on
introducing?

> ---
>  drivers/net/phy/mscc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
> index 650c2667d523..84ca9ff40ae0 100644
> --- a/drivers/net/phy/mscc.c
> +++ b/drivers/net/phy/mscc.c
> @@ -123,7 +123,7 @@ static const struct vsc8531_edge_rate_table edge_table[] = {
>  };
>  #endif /* CONFIG_OF_MDIO */
>  
> -static int vsc85xx_phy_page_set(struct phy_device *phydev, u8 page)
> +static int vsc85xx_phy_page_set(struct phy_device *phydev, u16 page)
>  {
>  	int rc;
>  
> 


-- 
Florian

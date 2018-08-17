Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA62C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 23:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E182188F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 23:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y375QGXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E182188F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeHRCyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 22:54:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35937 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeHRCyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 22:54:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id w24-v6so8686488wmc.1;
        Fri, 17 Aug 2018 16:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W+M/LhFZ2cVZXi75XG9T9EiaaK8CrMhuh7AQnTEPUUo=;
        b=Y375QGXXb70KgOWSjfwZncNzo2uad0aS7lVRh/IYgGL0F7afwRiPQ10VBbYCRICxv0
         t40exfG3HJnq9+XXImuf+AZEOAzzzqJ5HkNfgSOCNAg/AOmZo6NSXrN3lb5r8LEYrMfT
         kIya2O1lzMCvd0hFxx/BQh37J47Skb2ysgDnazJbkM+MWsyWCu0YT8bP5vXCXB1D4P8M
         3VsCg0FU1fAzGd1uTdnrRDiFjN979CXHoxkx7ILquRi2ao+EcayenUz+Umtjq98dzGoB
         J0wOs0z3VcSyTBKiyn0+Z/lstQIV6YdkEi3AkzjAOZ4UE9JTyKrwZU4WypsCEL2uFqIc
         0CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=W+M/LhFZ2cVZXi75XG9T9EiaaK8CrMhuh7AQnTEPUUo=;
        b=nnjEe3hZq3SGMhgJnbgBjke5dUJwfsmRDCRxyp81O/IKfKWjrj2cY893B8DwameyWp
         TIIcG3CQaxfxK/nB2rNmUTAL3N9+KyOBXiKUNHPqur0pY6Boz6x0h9opXBUoV4VZwEsK
         BgcFqIGPixucXWHH1TjgTOIzn9KHLj61FYBV4grfkrpXrOnnfs2qjqEudi9lwN+HLteo
         1yCfSKUne3htyBSzNoiVaP+Zi1vXw2Vyt0dmtqIEow+t8mWUu0PLMArSYkACPeKeRbc+
         x0EBETtFO4ksc7zEz7PFDpz/vXXZYb/V81Ou4OG5ECxkSFyRWhihzO5KG4C5E+4XO30R
         AY1g==
X-Gm-Message-State: AOUpUlHcOVbHT93Y+cVMhBDN38/HLPnqfP7rDmmt+RrKlA6y57oHgHwU
        QQgys2BcNEUIxydu+TQcDXDZiZi0
X-Google-Smtp-Source: AA+uWPzZabM0l2ztUoBLrVqbXMjfSwgh2UgSNdhxCJtBTvJa/0A7zFwy0nM2gwOKY/Bs/jOBcEb3fQ==
X-Received: by 2002:a1c:e54:: with SMTP id 81-v6mr21197884wmo.84.1534549753974;
        Fri, 17 Aug 2018 16:49:13 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id g2-v6sm8467833wrd.71.2018.08.17.16.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 16:49:12 -0700 (PDT)
Subject: Re: [PATCH v2] gpio: brcmstb: allow 0 width GPIO banks
To:     justinpopo6@gmail.com, linux-gpio@vger.kernel.org
Cc:     gregory.0xf0@gmail.com, linus.walleij@linaro.org,
        computersforpeace@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1534549659-15883-1-git-send-email-justinpopo6@gmail.com>
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
Message-ID: <a395c600-6d52-a3fb-208c-22c84004a77f@gmail.com>
Date:   Fri, 17 Aug 2018 16:49:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534549659-15883-1-git-send-email-justinpopo6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17/2018 04:47 PM, justinpopo6@gmail.com wrote:
> From: Justin Chen <justinpopo6@gmail.com>
> 
> Sometimes we have empty banks within the GPIO block. This commit allows
> proper handling of 0 width GPIO banks. We handle 0 width GPIO banks by
> incrementing the bank and number of GPIOs, but not initializing them.
> This will mean a call into the non-existent GPIOs will return an error.
> 
> Also remove "GPIO registered" dev print. This information is misleading
> since the incremented banks and gpio_base do not reflect the actual GPIOs
> that get initialized. We leave this information out since it is already
> printed with dev_dbg.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks Justin!
--
Florian

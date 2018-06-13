Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EEA18C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2DB208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyMM9W5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2DB208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935619AbeFMTt6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:49:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35054 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935381AbeFMTtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:49:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id j15-v6so7686303wme.0;
        Wed, 13 Jun 2018 12:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=356Z+xQ8sE8vs+GkjoziscL6snRJaDWTX+MkHE42enY=;
        b=jyMM9W5EBfmHdPQr/rB9/X4J6oueep3kS+p3eQ8T5/58IG8jq5l/ribDcHFDbJQOue
         0D1XOTd5o4RF5gd5yIDMhXWi0+nLXBO4JmWZ/sfnqQpqYlG+P0Xa9fB6cFrLfcnNN+q3
         vX8O2fmVpBmff9lpyTaYUiX+hbxkjQCICnvTlDB4+Wog269c1h5AgcApIg2omKpvxcmN
         hDkZhjH4Br9l3n58ixtTDYn7DHKKUS6fSZMy4EbcqKZNJ5vsOHv6NdOE7KdMneKUVxCs
         LC34jSQ6kzFOKDvr+RMwrSy5PAMbcyJuK9kjOdD5KFOzpm+K6Kxbx6HyJCbefXCDoKsE
         1bHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=356Z+xQ8sE8vs+GkjoziscL6snRJaDWTX+MkHE42enY=;
        b=JlPxDVyHTYqXJK53JwVoG0Iz8c3VnbSyQPS1HLS8VWeMfrA89UDrTLPaMT0Am+RHk2
         dygggMlKkuD1cu73vq9j6JU3MPObZ+6Ks6CWG0fQOsgHhhgurSnOs5lt2pq26ue/Vh32
         5L1g8JLNcxpufJwjoHhan3/rYHs7GjBBlTUKuMI6qLOv6vatWCw1ZmdqlrKAiFad58Bs
         OwbjB6mLnekBGLYiEeir/WkjOxNwOWo49f8tppMNNFINiqRVBZDpZEvyCe8sIw7nnr6F
         AxH3FOJtrwkslscyC8YRH1AcMhBqYGRvNHQQB+6MHhUtHKyvG7cUeajRtpv8U5AExLUw
         IuGQ==
X-Gm-Message-State: APt69E3X32awQz0IBq5ob/8ydl1BciHW/V0c+PQwlM0GcrKN0wxq9XJa
        fmk2SLUo1SAvI0hUw2nzWDzbnVz/
X-Google-Smtp-Source: ADUXVKKnRZLc/LbbSH+0H27IaG8oArqQICIxt+sqZYfdz7uGmsm3nAgVtM/+Mp/VGT8v0osR2Zbqxg==
X-Received: by 2002:a50:f294:: with SMTP id f20-v6mr5504455edm.68.1528919394207;
        Wed, 13 Jun 2018 12:49:54 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id x2-v6sm1574742edr.24.2018.06.13.12.49.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 12:49:53 -0700 (PDT)
Subject: Re: [PATCH 1/5] ARM: dts: cygnus: Fix I2C controller interrupt type
To:     Ray Jui <ray.jui@broadcom.com>,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
 <1528834891-17807-2-git-send-email-ray.jui@broadcom.com>
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
Message-ID: <8c368dbc-f654-ec52-0786-1f318156b8b5@gmail.com>
Date:   Wed, 13 Jun 2018 12:49:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528834891-17807-2-git-send-email-ray.jui@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 01:21 PM, Ray Jui wrote:
> Fix I2C controller interrupt to use IRQ_TYPE_LEVEL_HIGH for Broadcom
> Cygnus SoC
> 
> Fixes: b51c05a331ff ("ARM: dts: add I2C device nodes for Broadcom Cygnus")

This appears to be the only one that is truly needed here, the two
others below probably just moved things around but the offending commit
was already introduced in the above commit.

> Fixes: 0f0b21a83ad2 ("ARM: dts: Move all Cygnus peripherals into axi bus")
> Fixes: 9c5101f7a253 ("ARM: dts: Reorder Cygnus peripherals")
> 

There is no need for an extra line between the last Fixes: tag and your
Signed-off-by tag.

> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  arch/arm/boot/dts/bcm-cygnus.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 9fe4f5a..835a6f7 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -216,7 +216,7 @@
>  			reg = <0x18008000 0x100>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -			interrupts = <GIC_SPI 85 IRQ_TYPE_NONE>;
> +			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-frequency = <100000>;
>  			status = "disabled";
>  		};
> @@ -245,7 +245,7 @@
>  			reg = <0x1800b000 0x100>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -			interrupts = <GIC_SPI 86 IRQ_TYPE_NONE>;
> +			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-frequency = <100000>;
>  			status = "disabled";
>  		};
> 


-- 
Florian

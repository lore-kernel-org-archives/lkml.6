Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF2DC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47F92146F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYTRVXhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfBJUow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:44:52 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40907 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfBJUov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:44:51 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so14285372oth.7;
        Sun, 10 Feb 2019 12:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pHyluQCGFGfnCES0zIu1o3Vs58aE39GUgQSyodXIYxg=;
        b=NYTRVXhOPlT84MYQje8wiFlZyW9NIv3blUpO1aN7KhI3/Mw+i6W61heVi9CY0j58xq
         HLzoyC8j2KedN7hWqciXZOYXcJD6ABTo8fqNMEwESHyzzBz8fp/V4stJNPYNQtjd1AOb
         gTalVNZOmoDsHn/o20lAqviH6KmuZCdpdQCc7AKgp0Kdfe1yUvJJ48QvO40yQWKVZ1Fj
         VRlSbZUI20/W1GJkNXRw/yHeyuddBGHZpD6ZAKlimV3hldoGhLs1DpfSnrnfzatGIQCO
         QsOZcI+JlwyGJ4Ifcn+4GDN+6fZdFAuO4Gszckk5oZKlt6tpHILR4mhU0dwlClGA9FaC
         HHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pHyluQCGFGfnCES0zIu1o3Vs58aE39GUgQSyodXIYxg=;
        b=ddpx5HuEL5TTXvbeg60R29Bd5NPAdbTMGKW+27CAeV9kIZvabKTp84niOmq1vgIAth
         hEnfDyS8DdyQ2Av0ObpJWDWBh2tgEnYyapIcHYQDgOvKyyMlVsTtiVrG79DS3KLxezHc
         gfev4zr81qj1PGWhsvaDkMIrHpbI+HmnkLkPi1EEEF6CNvzxh9XY5WU6BcDDe6Er6HBx
         8V/HLI89l+iy4vGAtAc5GUAEdw3QbuqF/lzFsGC0kgX7JjgRGa1w2xn62s9QA3E6TQ69
         x7C84zIBJq8If5Ws6/JugvSjoiwRjE+2tzfwrPXm+NzLOJuBt9/Zn+/iX7gRHyanF8o5
         aG3A==
X-Gm-Message-State: AHQUAuYC2BsZMLcw3rcGzrDpjjyaqh8CndTraEjXu1DuBCINiZiEnGkE
        quxsSf/U/4pyvzfKOcS8mTA=
X-Google-Smtp-Source: AHgI3IYDVdop1sbAjTrxIRrkKyOS6AT12V/XSjp1FzuzF5ICBrGcSYvAYQ+qq0uG3joU3cZNvd0YiA==
X-Received: by 2002:a9d:53cb:: with SMTP id i11mr10212690oth.79.1549831490197;
        Sun, 10 Feb 2019 12:44:50 -0800 (PST)
Received: from [192.168.1.2] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.googlemail.com with ESMTPSA id g138sm5019846oib.26.2019.02.10.12.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 12:44:49 -0800 (PST)
To:     netdev@vger.kernel.org
Cc:     idosch@mellanox.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, bridge@lists.linux-foundation.org,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
References: <20190210175105.31629-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 mQGiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz7QnRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+iGYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSC5BA0ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
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
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU4hPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJ7kCDQRXG8fwARAA6q/pqBi5PjHcOAUgk2/2LR5LjjesK50bCaD4JuNc
 YDhFR7Vs108diBtsho3w8WRd9viOqDrhLJTroVckkk74OY8r+3t1E0Dd4wHWHQZsAeUvOwDM
 PQMqTUBFuMi6ydzTZpFA2wBR9x6ofl8Ax+zaGBcFrRlQnhsuXLnM1uuvS39+pmzIjasZBP2H
 UPk5ifigXcpelKmj6iskP3c8QN6x6GjUSmYx+xUfs/GNVSU1XOZn61wgPDbgINJd/THGdqiO
 iJxCLuTMqlSsmh1+E1dSdfYkCb93R/0ZHvMKWlAx7MnaFgBfsG8FqNtZu3PCLfizyVYYjXbV
 WO1A23riZKqwrSJAATo5iTS65BuYxrFsFNPrf7TitM8E76BEBZk0OZBvZxMuOs6Z1qI8YKVK
 UrHVGFq3NbuPWCdRul9SX3VfOunr9Gv0GABnJ0ET+K7nspax0xqq7zgnM71QEaiaH17IFYGS
 sG34V7Wo3vyQzsk7qLf9Ajno0DhJ+VX43g8+AjxOMNVrGCt9RNXSBVpyv2AMTlWCdJ5KI6V4
 KEzWM4HJm7QlNKE6RPoBxJVbSQLPd9St3h7mxLcne4l7NK9eNgNnneT7QZL8fL//s9K8Ns1W
 t60uQNYvbhKDG7+/yLcmJgjF74XkGvxCmTA1rW2bsUriM533nG9gAOUFQjURkwI8jvMAEQEA
 AYkCaAQYEQIACQUCVxvH8AIbAgIpCRBhV5kVtWN2DsFdIAQZAQIABgUCVxvH8AAKCRCH0Jac
 RAcHBIkHD/9nmfog7X2ZXMzL9ktT++7x+W/QBrSTCTmq8PK+69+INN1ZDOrY8uz6htfTLV9+
 e2W6G8/7zIvODuHk7r+yQ585XbplgP0V5Xc8iBHdBgXbqnY5zBrcH+Q/oQ2STalEvaGHqNoD
 UGyLQ/fiKoLZTPMur57Fy1c9rTuKiSdMgnT0FPfWVDfpR2Ds0gpqWePlRuRGOoCln5GnREA/
 2MW2rWf+CO9kbIR+66j8b4RUJqIK3dWn9xbENh/aqxfonGTCZQ2zC4sLd25DQA4w1itPo+f5
 V/SQxuhnlQkTOCdJ7b/mby/pNRz1lsLkjnXueLILj7gNjwTabZXYtL16z24qkDTI1x3g98R/
 xunb3/fQwR8FY5/zRvXJq5us/nLvIvOmVwZFkwXc+AF+LSIajqQz9XbXeIP/BDjlBNXRZNdo
 dVuSU51ENcMcilPr2EUnqEAqeczsCGpnvRCLfVQeSZr2L9N4svNhhfPOEscYhhpHTh0VPyxI
 pPBNKq+byuYPMyk3nj814NKhImK0O4gTyCK9b+gZAVvQcYAXvSouCnTZeJRrNHJFTgTgu6E0
 caxTGgc5zzQHeX67eMzrGomG3ZnIxmd1sAbgvJUDaD2GrYlulfwGWwWyTNbWRvMighVdPkSF
 6XFgQaosWxkV0OELLy2N485YrTr2Uq64VKyxpncLh50e2RnyAJ9qfUATKC9NgZjRvBztfqy4
 a9BQwACgnzGuH1BVeT2J0Ra+ZYgkx7DaPR0=
Subject: Re: [PATCH net-next v2 00/16] net: Remove switchdev_ops
Message-ID: <746bce08-5b5f-70c9-efb7-33b067929198@gmail.com>
Date:   Sun, 10 Feb 2019 12:44:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 2/10/19 à 9:50 AM, Florian Fainelli a écrit :
> Hi all,
> 
> This patch series finishes by the removal of switchdev_ops. To get there
> we need to do a few things:
> 
> - get rid of the one and only call to switchdev_port_attr_get() which is
>   used to fetch the device's bridge port flags capabilities, instead we
>   can just check what flags are being programmed during the prepare
>   phase
> 
> - once we get rid of getting switchdev port attributes we convert the
>   setting of such attributes using a blocking notifier
> 
> And then remove switchdev_ops completely.
> 
> Please review and let me know what you think!

I am going to submit a v3 which moves the port_attr_{get,set} to a
switchdev notifier, but does not yet get rid of
switchdev_port_attr_get() entirely since there is not a clear path yet
to split the setting between non-sleeping and sleeping context.

> 
> Changes in v2:
> - fixed bisectability issues in patch #15
> - added Acked-by from Jiri where necessary
> - fixed a few minor issues according to Jiri's feedback:
> 	- rename port_attr_event -> port_attr_set_event
> 	- moved SWITCHDEV_PORT_ATTR_SET closer to other blocking events
> 
> Florian Fainelli (16):
>   Documentation: networking: switchdev: Update port parent ID section
>   mlxsw: spectrum: Check bridge flags during prepare phase
>   staging: fsl-dpaa2: ethsw: Check bridge port flags during set
>   net: dsa: Add setter for SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
>   rocker: Check bridge flags during prepare phase
>   net: bridge: Stop calling switchdev_port_attr_get()
>   net: Remove SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
>   net: Get rid of switchdev_port_attr_get()
>   switchdev: Add SWITCHDEV_PORT_ATTR_SET
>   rocker: Handle SWITCHDEV_PORT_ATTR_SET
>   net: dsa: Handle SWITCHDEV_PORT_ATTR_SET
>   mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_SET
>   net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_SET
>   staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_SET
>   net: switchdev: Replace port attr set SDO with a notification
>   net: Remove switchdev_ops
> 
>  Documentation/networking/switchdev.txt        | 15 ++-
>  .../net/ethernet/mellanox/mlxsw/spectrum.c    | 12 ---
>  .../net/ethernet/mellanox/mlxsw/spectrum.h    |  2 -
>  .../mellanox/mlxsw/spectrum_switchdev.c       | 69 ++++----------
>  drivers/net/ethernet/mscc/ocelot.c            | 21 +++-
>  drivers/net/ethernet/rocker/rocker_main.c     | 95 ++++++++-----------
>  drivers/staging/fsl-dpaa2/ethsw/ethsw.c       | 48 ++++------
>  include/linux/netdevice.h                     |  3 -
>  include/net/switchdev.h                       | 36 ++-----
>  net/bridge/br_switchdev.c                     | 20 +---
>  net/dsa/dsa_priv.h                            |  3 +
>  net/dsa/port.c                                | 10 ++
>  net/dsa/slave.c                               | 40 ++++----
>  net/switchdev/switchdev.c                     | 92 +++++-------------
>  14 files changed, 170 insertions(+), 296 deletions(-)
> 


-- 
Florian

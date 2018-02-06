Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752258AbeBFAGc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 19:06:32 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:44569 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbeBFAGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 19:06:24 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180206000622epoutp037e50e294fd5a28e9d009d026676bdc86~Qk8zetAnA2590025900epoutp036
X-AuditID: b6c32a45-403ff70000001023-2f-5a78f17dd692
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5A78F17D.1010400@samsung.com>
Date: Tue, 06 Feb 2018 09:06:21 +0900
From: Inki Dae <inki.dae@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        linux-renesas-soc@vger.kernel.org,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 2/4] drm/exynos: fix comparison to bitshift when dealing
 with a mask
In-reply-to: <20180205201002.23621-3-wsa+renesas@sang-engineering.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGczvT6UAsjAX0BqPiqA9gqHQs7aDgBsIk8kBCDFpUHOnYEuli
        p0XQRAkxCLghhIggm0iUigtlETAxEVDUpBBXojGgYRFF0Qb3vWUw8nLznXv+c+85fw6OyMqx
        QDzNaOUsRjadxLzR1q5gVegBV6YmrOELRh/rvSuix3+fQulHn95j9NjAfZQ+MTSO0H19VyW0
        M+ethHYMPRHTDzvOYHTL6wkRXdp3w30Uv8bo471xa6WMw56PMdc+vxAzg0d6REzTuYOMa+QZ
        yhxvtgNmtOYKykw6FiTgGi5Sz7FazhLEGVNN2jSjLorcmJgSnRKuClOEKiJoNRlkZA1cFBkT
        nxAam5bu7pgMymDTbe6rBJbnyeWrIy0mm5UL0pt4axSZrFBQckWYWk5RlFy5YttKKtwt2cHp
        +4rvSMw38My2ixVYNviJFQAch4QSurrNBcAblxFtAHaVPAdC8AXAH5Nv0ALgNSX6MJwjEhLX
        ASy5WoF4ElJiNvxaPIB6XkKIhbD7wW7PNUIEw7GPRaigHwBwqKccFfQhsOZ65RSjxFLYX9Qq
        9jDm5pMXBjEPBxCbYXvVZ4mH/YlE2H/vNhAerUfg4EtvD/sRGviocULkYS8iFjpzP041B4k/
        GCw/U4UIXcfAQ02d0xP4wTc9zRKB58FReyMQCg4D2OHsx4TgKIDna89Oq1bA0ZoCkfC1D8zr
        +iURDJPCvFyZIGHgu8vdYoHXwZGO/OmRHwNYPnwLKQTzy2a4VPbfpbIZLlUDxA7mcGbeoON4
        yqyQ86yBtxl18lSTwQGmFjNkQxso7Y3vBAQOyFlSQp+pkYnZDD7L0AkgjpD+0vX9ezUyqZbN
        2sdZTCkWWzrHd4Jwt8knkcCAVJN7zY3WFIUyIkypUlFqFe3eqrnS3IQYjYzQsVZuN8eZOcu/
        OhHuFZgNIr8nRVUsqG2hWiq2VloX3aRaFl3yaSd+u3SgpO7bmsvPkrUTqiT/TT2PLXHi2C0B
        uqSY7QO75qH5uufKXa6G/erkyerGjeBp/fiqdhjZ7kzO+npicc5Rnwnf1LwNSd/qnNmk9J72
        tGuJUl0YXRLcZrPHF9GvHDV7lvsO71x28CaJ8npWEYJYePYvhZ8Aaq4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsVy+t9jAd3ajxVRBrvWKlv0njvJZPH633QW
        iytf37NZvLh3kcWi//FrZovz5zewW5xtesNusenxNVaLy7vmsFlsffmOyWLG+X1AYvJLNou+
        c+4OvB6bVnWyeWz/9oDV4373cSaPzUvqPT4+vcXi0bdlFaPHs4XrWTw+b5IL4IjisklJzcks
        Sy3St0vgyjg/+QR7wT6Oih2r57I1MP5h62Lk5JAQMJH48KSJqYuRi0NIYCejxJ35l5lBErwC
        ghI/Jt9j6WLk4GAWkJc4cikbwlSXmDIlF6L8AaPEx6Y5TBDlWhILd89jAbFZBFQlrk/axgpi
        swHZE1fcZwPpFRWIkOg+UQkSFhEIlnjW2cQKModZYCWzxK43h8DmCAtESVzZ+A7qnquMEn8P
        fmUESXAKuEmcbfvCNIGRfxaS82YhnDcL4bwFjMyrGCVTC4pz03OLjQqM8lLL9YoTc4tL89L1
        kvNzNzEC42TbYa3+HYyPl8QfYhTgYFTi4RXIqIgSYk0sK67MPcQowcGsJMLrdL08Sog3JbGy
        KrUoP76oNCe1+BCjNAeLkjgvf/6xSCGB9MSS1OzU1ILUIpgsEwenVAPj/Arh9cri9s1NPy4e
        du6TFtS/+2u+19FNrlP6erfNMayObkq2TGpq62I7M62nWPPw0SkeScf5elW5HgZmqocJqHq8
        evliZYRix84L2g5vFjw8yZn9X+HF3SVqNrty5u6VuJjmyDRxr9e3Y/YztyzJtuw+HZDXrMfg
        kPVkqem8lVvEz4ZVG8crsRRnJBpqMRcVJwIAUy3pZY8CAAA=
X-CMS-MailID: 20180206000621epcas2p2ead248a6b34711bd4fe546314b5b2e5a
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180205201026epcas5p214598aead48b3d8118b8f1fe114da8ec
X-RootMTR: 20180205201026epcas5p214598aead48b3d8118b8f1fe114da8ec
References: <20180205201002.23621-1-wsa+renesas@sang-engineering.com>
        <CGME20180205201026epcas5p214598aead48b3d8118b8f1fe114da8ec@epcas5p2.samsung.com>
        <20180205201002.23621-3-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



2018년 02월 06일 05:09에 Wolfram Sang 이(가) 쓴 글:
> Due to a typo, the mask was destroyed by a comparison instead of a bit
> shift.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> Only build tested. To be applied individually per subsystem.
> 
>  drivers/gpu/drm/exynos/regs-fimc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/exynos/regs-fimc.h b/drivers/gpu/drm/exynos/regs-fimc.h
> index 30496134a3d072..d7cbe53c4c01f4 100644
> --- a/drivers/gpu/drm/exynos/regs-fimc.h
> +++ b/drivers/gpu/drm/exynos/regs-fimc.h
> @@ -569,7 +569,7 @@
>  #define EXYNOS_CIIMGEFF_FIN_EMBOSSING		(4 << 26)
>  #define EXYNOS_CIIMGEFF_FIN_SILHOUETTE		(5 << 26)
>  #define EXYNOS_CIIMGEFF_FIN_MASK			(7 << 26)
> -#define EXYNOS_CIIMGEFF_PAT_CBCR_MASK		((0xff < 13) | (0xff < 0))
> +#define EXYNOS_CIIMGEFF_PAT_CBCR_MASK		((0xff << 13) | (0xff << 0))
>  

Oops. Picked it up.

Thanks,
Inki Dae

>  /* Real input DMA size register */
>  #define EXYNOS_CIREAL_ISIZE_AUTOLOAD_ENABLE	(1 << 31)
> 

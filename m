Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7312C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6866D204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6866D204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbeH3ReZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:34:25 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:37903 "EHLO
        6.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbeH3ReY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:34:24 -0400
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Aug 2018 13:34:24 EDT
Received: from player157.ha.ovh.net (unknown [10.109.160.143])
        by mo2.mail-out.ovh.net (Postfix) with ESMTP id 117B6155D10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:13:25 +0200 (CEST)
Received: from [192.168.0.230] (22.220.201.77.rev.sfr.net [77.201.220.22])
        (Authenticated sender: sebastien.szymanski@armadeus.com)
        by player157.ha.ovh.net (Postfix) with ESMTPSA id E2BEF10008B;
        Thu, 30 Aug 2018 15:13:10 +0200 (CEST)
To:     Heiko Schocher <hs@denx.de>, linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Peter Chen <peter.chen@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20180830124702.12572-1-hs@denx.de>
From:   =?UTF-8?Q?S=c3=a9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>
Openpgp: preference=signencrypt
Autocrypt: addr=sebastien.szymanski@armadeus.com; prefer-encrypt=mutual;
 keydata=
 xsBNBFNfZLEBCACv1lqSePHJNpRgcnER+3emy+Arjz84zFax3XkogjY/e3ZneihIgWrVKe5M
 ql16pX4KTkzNgMUKz4bG/XwT3kjcrXshxFLlg7KrHMl287C+W+QOUjnjVeRi/su+SPmjz8VD
 yr11h+ZkVLAWhS+uQJ93jy1NwG8M4t1kBLAVHHD5Vw4FJ+3ouaVYIp1X1Cr8bVKQw33Q1aTd
 ro0kMBb96B9vNu7ciJZ3gvlaBzUEKOgNnq9KaywuLnqrqr4HUIn5JuxZjCjJzt9kTAKcTfp2
 cJM8qpp+2FF5qtbkse9fZ6M64qozgOPr9Tk4Amf9fZEUQ6UNw14mmBZuXSzoHe75gI7TABEB
 AAHNN1PDqWJhc3RpZW4gU1pZTUFOU0tJIDxzZWJhc3RpZW4uc3p5bWFuc2tpQGFybWFkZXVz
 LmNvbT7CwH8EEwECACkFAlNfZLECGyMFCQlmAYAHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIX
 gAAKCRCwminogTJk4ss0CACpxtvYO1rCYNtc/j/6fkDsuKKwGtijixHU+C3N+EAJVoHSCdRM
 /PMtyN1fa+94XbW4LHQpZthkXd4kBpcf0aNtrS51193/YZHK5jLpJlUMKLGgU5VHXguakOOF
 ZWptlUCEqZaQ4gR8CUxPZi4urNAg/ORxCiVW2oMO/8GRhoZ+r14QNDGFVphbdlk/4YyY3wr7
 scDKTrRdkGw7kJElAp61I/B2KSbhnvF7U6H646a12/7bm6IEOAWbntoPcBg1h6irlCiNqfxs
 Zfy3r6rVRy840Dl7ldoUzOs7Eon8lUQilr9UorOHBF4NaBTpyD75DtvjRQsF2qV+R1RGS/Em
 IvrjzsBNBFNfZLEBCAC6O44V3Xa1wU0buUgI3pVed48hwSU1/7zeJy/1W21v7GnGvjSYw0sc
 eQwZqLWW0HViMmYkiI1P8Z00RL7Q65emXkrClne2aoromOH0kc8LkKfa3dMqkbsXrK1nsiQd
 cwknRLy8igEhEbfp8ZDgPiMyeMtai7b51q/ki9QF4EzMPk5MsCiAwkVh0yGGrNdZXRo/NoDi
 KWHl52qXjSx30+BEMINDXlmB8pycQEFol+Wj5cNLkqQEErAV0BSHt36aL3jEp1yvjxtgQTs3
 sWL+6+Eu9GurBfbIE0z6XyqlGqqgvrtfm1F+mpUwCoRiicsGhelYqi5YGPD38KIUsgJapU0T
 ABEBAAHCwGUEGAECAA8FAlNfZLECGwwFCQlmAYAACgkQsJop6IEyZOKWTgf/RbOvtKW77EXW
 XBzh04rfkW6prOlbJaIMUjVKZZ1D2OOpAxJbq80whJqCoJ+oVh7uAteozgX3U5TnL7fRx6HP
 zhyidiwKCOXEeTsFrRHEpTOCJYbPz8MTsK14ogz/aUlImt0HbxTaVHz5m65wWM8doCqOj2J9
 Vf12NNpfTxkotmM0QJQAIcEg10RfT3DLG1a68sdghM5rlz/b8mr/wjtOVxYX1TWKMvilCdQy
 YT8NNFcBwMEy5Jt2SXpeASY0CIXGwqqCBLqmQMhh3VcmibIbBBB0hIg4f56Vfn7v8ouFmbYS
 G0Q3TMIWXxYn91KiMXeox+Wsic2Ocw/KpZ/tus0JXQ==
Subject: Re: [PATCH] ARM: dts: imx6ull: fix pinmux input_val for uart5 rx pin
Message-ID: <218369fa-8ec1-fd3c-dd2e-b4821e11cb62@armadeus.com>
Date:   Thu, 30 Aug 2018 15:25:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830124702.12572-1-hs@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17110300887725921532
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtjedrgeekgdehlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/30/2018 02:47 PM, Heiko Schocher wrote:
> on the imx6ull the input_val for uart5 rx function
> of pin MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX
> is 7 and not 5 as on the imx6ul. With this
> patch, console on an imx6ull based board works
> with uart5.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>

This is already fixed on v4.19-rc1 and also on a few others PADs that
have similar issue.
Moreover signals common for both i.MX6UL and i.MX6ULL should have
IMX6UL_ as prefix:

https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?h=for-next&id=387301d5b88e2fe91de9baf4ca25f771cc633f70

Regards,

> 
> ---
> 
>  arch/arm/boot/dts/imx6ull-pinfunc.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ull-pinfunc.h b/arch/arm/boot/dts/imx6ull-pinfunc.h
> index fdc46bb09cc1a..d835aeae5485b 100644
> --- a/arch/arm/boot/dts/imx6ull-pinfunc.h
> +++ b/arch/arm/boot/dts/imx6ull-pinfunc.h
> @@ -61,5 +61,6 @@
>  #define MX6ULL_PAD_CSI_DATA05__ESAI_TX_CLK                        0x01F8 0x0484 0x0000 0x9 0x0
>  #define MX6ULL_PAD_CSI_DATA06__ESAI_TX5_RX0                       0x01FC 0x0488 0x0000 0x9 0x0
>  #define MX6ULL_PAD_CSI_DATA07__ESAI_T0                            0x0200 0x048C 0x0000 0x9 0x0
> +#define MX6ULL_PAD_UART5_RX_DATA__UART5_DCE_RX		0x00C0 0x034C 0x0644 0 7
>  
>  #endif /* __DTS_IMX6ULL_PINFUNC_H */
> 


-- 
Sébastien Szymanski
Software engineer, Armadeus Systems
Tel: +33 (0)9 72 29 41 44
Fax: +33 (0)9 72 28 79 26

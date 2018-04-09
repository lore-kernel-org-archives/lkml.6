Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbeDIGzT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 02:55:19 -0400
Received: from mail-eopbgr30069.outbound.protection.outlook.com ([40.107.3.69]:61088
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751291AbeDIGzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 02:55:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mika.penttila@nextfour.com;
Subject: Re: [PATCH] ASoC: fsl_ssi: Fix mode setting when changing channel
 number
To: Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz,
        lgirdwood@gmail.com, fabio.estevam@nxp.com, timur@tabi.org
References: <1523162421-26400-1-git-send-email-nicoleotsuka@gmail.com>
From: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <757bf30b-60fc-5ff8-e9b3-7978bae2264d@nextfour.com>
Date: Mon, 9 Apr 2018 09:55:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523162421-26400-1-git-send-email-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [194.157.170.35]
X-ClientProxiedBy: HE1PR0701CA0081.eurprd07.prod.outlook.com
 (2603:10a6:3:64::25) To DB6PR07MB3334.eurprd07.prod.outlook.com
 (2603:10a6:6:22::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cadc18d8-9c51-430a-edad-08d59de6d8a1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR07MB3334;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3334;3:GHTOJJxvYCAjLmmGfhE7Kag9Lk2rsHuvmuH0Zkeh7dgx3SR3GOpUtOwNH5qiFVGgVSP6siz7sHfTCLgH/epPqVpSsTUzM4oD6TxYZE/fieCby+aid/gzhrZmCYpZoXgV/afi26w0R64wy/kDKqP+SexjdGK+wuYiaVQZ1n8SCiW/Xu4WVd3ukWTmoItOdvVnr159btUv1rOWLlozCUowDCV0ssCvA03nHiYfZtz1qwEuyd2lc/Ho95EtMrmqwnEO;25:ut1v/RwRlzVd9fp/LjhAJIRl6db9J+aIiziixe/Ao6Z8pCE4EBwZq+ZL9pZerbr13GixtW3nDabneBS7WNRugf9ESGvnCRuuVNZ28K74b+ckqPpdWKlcnE0VF2BxfuvMRrPQMDcHAnUgxxPw/MPR7FFpKYZFq6d2CwUj+JW4jv2Z6iBkVBcc3LPWZau7gcBrKJROcJVOiaXjqZ+MKos2OgMvE+yFENfzmI0LW08CngDuDL8E6btKFxE2frbYyRa6XoZYXNMKYyud12KFCHR0mczW6YSIaxo4WXgRimMwgcHhFm1nZRlTrlOT0iams1DHdly8L7yoh+NL8QbQcf6jIw==;31:S4xFNRowyqUwaY0uzQjKssyJaZqSEFk7G2QWvZ4Fh2Cdw3ToK6wsbPSvcH3MZayOhwHGWF4eEzptfzF08sSyDTcsjElLHxuTavIBM6s4eswzSOVWm5mzQqdrVtcnDZK1ZAdjEYa8tRlAA12Ud9MYOBTmfrjfEy/OHY5GFxI4OmuOtef2AepV5uDv5FUMfyS6477Aun75YzOVFjBchVbBn7xZcCM+HdDsccTS2vZOzag=
X-MS-TrafficTypeDiagnostic: DB6PR07MB3334:
X-Microsoft-Antispam-PRVS: <DB6PR07MB3334C4CB5C4A6747B2E6E9E783BF0@DB6PR07MB3334.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:DB6PR07MB3334;BCL:0;PCL:0;RULEID:;SRVR:DB6PR07MB3334;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3334;4:WzQaBEaDuWkiv/Q6jaBolBijEjmX+6e+U/aMGTv+1HoLPfO3uc4zUc9D4gJqYD4zNkoOiUDHZjgi14pNWgHwj8VSPCTci6+1TdYpKLn+yMeXPZZjbPVA8S7IpzHWFjnVqVjjR1Sv+3qz8/6BR5mD6VAj6YWCqD9aOzAJsZiw7UWaABW0epmTeeazEP1rh+11feYd5GuGLnIX+89Q7N6cEnn6ujUJiOatzqPSNtys+PbaPosWU4pkwij3iI9D2YNhIJ776VeM1QRRxOOBIPTKQlHGeeYuFctsCBSe5UpxgQOcGDrBLE+l8cu1pSgVcc6Z
X-Forefront-PRVS: 0637FCE711
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39830400003)(376002)(396003)(39380400002)(346002)(199004)(189003)(106356001)(31696002)(81166006)(81156014)(8676002)(47776003)(5660300001)(229853002)(36756003)(2486003)(50466002)(52116002)(64126003)(68736007)(4326008)(386003)(53546011)(446003)(7736002)(2906002)(8936002)(105586002)(486006)(476003)(2616005)(86362001)(2870700001)(956004)(58126008)(31686004)(305945005)(16576012)(316002)(11346002)(6486002)(39060400002)(25786009)(6116002)(3846002)(7416002)(478600001)(53936002)(97736004)(8656006)(6246003)(186003)(65806001)(16526019)(23676004)(59450400001)(26005)(52146003)(65826007)(76176011)(77096007)(65956001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR07MB3334;H:[10.10.10.110];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA3TUIzMzM0OzIzOkE1a216R25uMkF2SE5pOUZxSGZ5cnlBK3F6?=
 =?utf-8?B?U1g3WGhBTUw4RllGdHZkQzV3dWtTT0VxeVhtQTc4VUxJWVhLbXQ0K3dVZ1RM?=
 =?utf-8?B?RGh0Sk5NT25ycFMrdGlOd3hHWE1rVGhSNU96QzFrNFpyN0s4ZzBXRGZ6Nm1R?=
 =?utf-8?B?OU9mUGd4VlFHT2tCMWUvaDlNandLVGFTdHI1ZUZsOGhrbTV0MHR3MVJNMnVD?=
 =?utf-8?B?UG9JOGJCZFZEN2gwNkpCZWo5YmVLNzk0YmI1Vnl4NElFYVJOZVZld091ZWFO?=
 =?utf-8?B?djZYZm5HbkhRZlAvR3AybTJObmM1SGFiNzE1dWRpSm94dldTbXc0eERqa1F1?=
 =?utf-8?B?STlXeFdITVhsRnBKTVFRWTJkWnNMaXZvdVZHM1QxRXVUMmlnQ1g4RDd5NnUr?=
 =?utf-8?B?MVY2Mnd5VEJNYy8xMTlSb1I4K3BvNXhQNVNZc3V4Qng2RlorcFBncXdaNG01?=
 =?utf-8?B?eVdyMTVHOEdnNlcrZm5pamZRQmZSMnZkRzhPdHdlWGlkTVN6Q1JlQnZXZTJi?=
 =?utf-8?B?V3R4SUMwbkpRRllMdzE2Y0tianoxYjJTUzNLSXdWRUhPRThVY3FDOXlLN2dh?=
 =?utf-8?B?UVNCMUJhZU9RL1FaLy8wU0FlVzV3VkJOeVdtU3Y0UUM0N2RsOHZkMzRjdG1j?=
 =?utf-8?B?QXZzZ1kzZ0x5VW5iYUZwYUxmSm9EUThuazNqeldxUjhMaWtyY2ttY20rWlBW?=
 =?utf-8?B?WVJJcUNGRExBU3M4R3FJWGdQSUgvQnZEdjlTQmkrYmNnZDNMbnhMcHhIN0ZB?=
 =?utf-8?B?ajd5WEx0a1FRU2pzWnZWMEtiL3lUQkdVaVFIbXRreVZ3eDVNSng3L0Q2YU9C?=
 =?utf-8?B?Z3U5MVh3ZlVDQm9YTS84NGpwK3hBdFRJVExoTUxtdERDRm5kbDBvc0RDTUtR?=
 =?utf-8?B?U0FtazB2ZjB5emFTY3l1VTFla3dxSllTUVpxbitoQlRQL2czZXZ5RUd3Mkw5?=
 =?utf-8?B?encvYjZQWC9ZQ1lHWTZ5eWFyYXZrN05hUDZBYjRDcGlnckQ3b2ZhVGRNem9a?=
 =?utf-8?B?NlRRQ2NhODFTUnp3N2dMOGx4bXF2QWVHVjNDNWswWnNEdzlUcG5PbVBQL3di?=
 =?utf-8?B?L09sS1hFaHlRU05iYThMaXo3V05BTWVSYnh0NGg4QWdUMXVnUFdsQUFmbUxW?=
 =?utf-8?B?M1ZmQ0M1NTJsZDMzcEx4VFNSWnNqSEd5VlJIT1pKaEphNFZNN3RHcHpFTThz?=
 =?utf-8?B?VGlnNFpvM0RPbHhzV3RGSEdkOXdHeWpCSjRoZXR5enFoNWNsaDdmVElZdWM0?=
 =?utf-8?B?eHE5RDBMSHJPeEdqaWp0SldsVjVCQzVTT2J2cllvV0tSY3pVZjFORW9tUnlm?=
 =?utf-8?B?eDV5MHlDUkxHanBJdm1yektWNHF2d3ROc0hMWE9lRXY0dWd5R2VQdysrdE5K?=
 =?utf-8?B?b0lDNGpueVJUbjFIYVVRbXZzMGExQlhLS0tPOEVmVDRFd0czaTBsT0pwU3Jo?=
 =?utf-8?B?cHErc1VLY1k5Z2VqN096WlFYbW02V3NKd09YWVpQNE5BUzByUnRiZk9pN29j?=
 =?utf-8?B?M1RLNFZBTklnc1lacm9JVFkzS3RpU1U0NTlBNGNpMHhEOGpOL0RPVzJ6K2hC?=
 =?utf-8?B?QmZ3K2tLVXZNMTFwRFFIdndTajJDSDdoSWthbGh0SmRIR0YrK1ZMSTJrUFJP?=
 =?utf-8?B?SUU1ZktCaklhclBWQldJejVuYnVaUFVGQ1hxL3FQeFhBems1ZTFjR3Qxd1dT?=
 =?utf-8?B?Tis2bVMxU1NiY1dONFBaMUhGSERVSkJWdXdOUkVVcE9nRGYrVjVFdUR1YnMx?=
 =?utf-8?B?UnBna3B1YlIvTmZJMFRpdURDTWoySStyMlZOMzYyc0tsb0dBU2ZaNHBaek1u?=
 =?utf-8?B?aitGcnAxY0kzLzNxMnlwYkNMQk9pNVpqT0hVWG1HT1N4M2tzejBOemRSMEVC?=
 =?utf-8?B?MmVhamREL2l5dk9uQk5QcFVRWWtaWGVwOVNkMk9zcm8zQnowQlZ1OEpaYi9N?=
 =?utf-8?B?cHVCYWlHalRRUWRZbFUrS0d1UGdma084QmJwTXBnc3RUbytVaDVyUi9uQk5D?=
 =?utf-8?Q?ob+D6a?=
X-Microsoft-Antispam-Message-Info: WdFt0ljHiINo4aL3dUFRr1VCl7AxsEXlCb+5+2mJjh9aPO0RhJPX9KVPUzx/xwT8yAmI5HJwPW7SMoRFqqoJcfcs9CmeEi1UIlDKu2hVgsRL83tZGzYBUI4yAv36w3Z7obGzQUeb/05gV1mU1zYCw6Swxo3tOmEE2gWFKKqPhR+YBj3WDbHHQZntP/Uog89f
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3334;6:eIyK5lzLJU5YosNF/wBmIlL309k2eiXQYYe9+Tp/enbAkIARY6Fs24gBKA+3rellfF/x7VAd7TKA7XuJw5MoqxSHQ1dy0Tu3BwsiLWFroZ/ttqml/pScFnzjepKCzOlX9oiiF7esTOh86PpXqoZ+I9P/7cIEMdqwXuCwp7eIhmLu3Uq1SQB3KQ1tLPCk51b8k/dFjh+QbR1uFDWRG1ZimYwR1KF2A2ALVl8NOF427+FfeRnaXNLQZMR11ApzgdA/2uuMlkzqdi7ss9o4zzuGusfKRIHPDpeafllmwDNf4PAODYM/PIMdZivY99BP0f3Jrx+P+HEkIbPUBs2lQIlQEDeU/GzKxQtZUZikkNCDuAAwAvHaF4rzBJZ1bSzYei5N76P8hwKb1s9pgLZQpAonOu86Qf7I5UrU1cFN3kTrZkztosl75ghLrBoseg7IzDmROne1oiHJGNQaIkdAuqFLgg==;5:Cc3rh2XSJd8C7v1lutUsnhHHO9hw8A4660y8P87NQf/dqhKVyzEkbwWPJBw22Hkdc2tORrJZVHe2I198Ckn0krJdqdrfJoExWecw5/PeBNZ1kVbUqSDfwe9fbVlCYh6LerFaMmu4SaqmE0RPslPQPxthMHJgclRCssA78Eh2qW8=;24:O/Xa3oGZeKLBES327JRKvpPPWZO/sV/WZBq2yyp4/Xqiy0+wWYImYKyG/nQtyDFE8fnorljSVQmwwRadbQFiW3WLdPE09Q+cZehuLxU2zQ4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3334;7:c2VfcZDyydj8StXN2UagvQD+CNnv4YEfTKmHFPNBhkC1mmD7omZn16FcQDD5seIKOPEk/oW3d6nosbJqa8ntQ/e44XkTem91oRnBjnOQp9ir8Kknl6MP7e1E/6KfPthyIZSd42teebtJuDtoAmcM9/uUAUsKuUJii78jEcWmsxNOIdWDZTKW6l+Kv0VSvNQmigUMR79n45hNPZOSTs8BmDednF2udwIqTy0PK9YIn6ITfq5a86elbFJY8gy/4eq4
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2018 06:55:13.8604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cadc18d8-9c51-430a-edad-08d59de6d8a1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB3334
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2018 07:40 AM, Nicolin Chen wrote:
> This is a partial revert (in a cleaner way) of commit ebf08ae3bc90
> ("ASoC: fsl_ssi: Keep ssi->i2s_net updated") to fix a regression
> at test cases when switching between mono and stereo audio.
> 
> The problem is that ssi->i2s_net is initialized in set_dai_fmt()
> only, while this set_dai_fmt() is only called during the dai-link
> probe(). The original patch assumed set_dai_fmt() would be called
> during every playback instance, so it failed at the overriding use
> cases.
> 
> This patch adds the local variable i2s_net back to let regular use
> cases still follow the mode settings from the set_dai_fmt().
> 
> Meanwhile, the original commit of keeping ssi->i2s_net updated was
> to make set_tdm_slot() clean by checking the ssi->i2s_net directly
> instead of reading SCR register. However, the change itself is not
> necessary (or even harmful) because the set_tdm_slot() might fail
> to check the slot number for Normal-Mode-None-Net settings while
> mono audio cases still need 2 slots. So this patch can also fix it.
> And it adds an extra line of comments to declare ssi->i2s_net does
> not reflect the register value but merely the initial setting from
> the set_dai_fmt().
> 
> Reported-by: Mika Penttilä <mika.penttila@nextfour.com>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Cc: Mika Penttilä <mika.penttila@nextfour.com>
> ---
>  sound/soc/fsl/fsl_ssi.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 0823b08..89df2d9 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -217,6 +217,7 @@ struct fsl_ssi_soc_data {
>   * @dai_fmt: DAI configuration this device is currently used with
>   * @streams: Mask of current active streams: BIT(TX) and BIT(RX)
>   * @i2s_net: I2S and Network mode configurations of SCR register
> + *           (this is the initial settings based on the DAI format)
>   * @synchronous: Use synchronous mode - both of TX and RX use STCK and SFCK
>   * @use_dma: DMA is used or FIQ with stream filter
>   * @use_dual_fifo: DMA with support for dual FIFO mode
> @@ -829,16 +830,23 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
>  	}
>  
>  	if (!fsl_ssi_is_ac97(ssi)) {
> +		/*
> +		 * Keep the ssi->i2s_net intact while having a local variable
> +		 * to override settings for special use cases. Otherwise, the
> +		 * ssi->i2s_net will lose the settings for regular use cases.
> +		 */
> +		u8 i2s_net = ssi->i2s_net;
> +
>  		/* Normal + Network mode to send 16-bit data in 32-bit frames */
>  		if (fsl_ssi_is_i2s_cbm_cfs(ssi) && sample_size == 16)
> -			ssi->i2s_net = SSI_SCR_I2S_MODE_NORMAL | SSI_SCR_NET;
> +			i2s_net = SSI_SCR_I2S_MODE_NORMAL | SSI_SCR_NET;
>  
>  		/* Use Normal mode to send mono data at 1st slot of 2 slots */
>  		if (channels == 1)
> -			ssi->i2s_net = SSI_SCR_I2S_MODE_NORMAL;
> +			i2s_net = SSI_SCR_I2S_MODE_NORMAL;
>  
>  		regmap_update_bits(regs, REG_SSI_SCR,
> -				   SSI_SCR_I2S_NET_MASK, ssi->i2s_net);
> +				   SSI_SCR_I2S_NET_MASK, i2s_net);
>  	}
>  
>  	/* In synchronous mode, the SSI uses STCCR for capture */
> 

This patch fixes my problems, so: 

Tested-by: Mika Penttilä <mika.penttila@nextfour.com>


--Mika

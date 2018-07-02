Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9FAC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F2423FD3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="N3lGDY4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F2423FD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753163AbeGBFqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 01:46:02 -0400
Received: from mail-eopbgr730070.outbound.protection.outlook.com ([40.107.73.70]:15983
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752684AbeGBFp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 01:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SF5TPNL8R/X1mDUmkFmIwi3uuoL/xmFfSzAu/HaAVc=;
 b=N3lGDY4vGJxM7R6bEWVHb2ddNGobD0AkJ8CerZq7uKLNIxokkiQFV6vpVfkwxd4q1AVRgPQlCx8w33JqG0/8GgALKJSmcMeK0nWqd3RfEjMJ+QszXvu6ibiYaTz7xHzXwMpUwLbKApqvkAxoplDAdvBYL3FHTADoyXuoJbqBDeg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com; 
Received: from hc (82.212.12.226) by BYAPR07MB4600.namprd07.prod.outlook.com
 (2603:10b6:a02:f2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.23; Mon, 2 Jul
 2018 05:45:52 +0000
Date:   Mon, 2 Jul 2018 07:45:40 +0200
From:   Jan Glauber <jan.glauber@cavium.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Robert Richter <rrichter@cavium.com>,
        linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: zip: make several functions static
Message-ID: <20180702054540.GA14359@hc>
References: <20180630113049.4402-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180630113049.4402-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [82.212.12.226]
X-ClientProxiedBy: VI1PR08CA0182.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::12) To BYAPR07MB4600.namprd07.prod.outlook.com
 (2603:10b6:a02:f2::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b678440c-be8f-42f9-ebff-08d5dfdf13bd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4600;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4600;3:73A6W6actSJ1CfeKpbTYuArHfTGzDDSicyOafEWbfXTUbvOmOVWg4mmxJ9Xznb2YjX0ekGnl5Su4StcsThrJtoYAD52dwLGI06NGaXAl5FC8QJbKBem3ypR0D/F3RM5Aj0fO9WGwQtcUybjC3hEVqIyTlvA7rPfAtRgLcIs/6PUsGPdqAPMSD3nWIRdVEPwJSAoIvVhG8gEYTz/D9GOgD83ofLYucNY1EGz/eZeuDBuLTuwpT+ySFNoWuFMgSNYx;25:lfqxOp9ry7LEpD3//w+v4werC1oq+OfBy7AbVXrF9thZmd0YYayUnqJEwRvdJ8tzysm+mNRJuqOFW/evHmTg44Fze3fFZSDjH7tF2jAaAA44s922TuZR461VEFXxgdMfBAQfsizihCkFPlNGOOSQTulfwjcsX7Qd805CaUSbaSvNbphPU1EmxtksKFSO2Qg/pNPsKy6TgjDJjGd/8wXlf+elNrLV+sdavbEn0UIhfal8WlddN+PbzBDTvbeAJSd3XYLDmW9R4vIJQ+MrumTIcZGImJwea2sAG+vhz2E7oLxrnhCPgEb0fVfgs7ykpH5uSBsCTNoLdERbDdZbor8gXg==;31:bdOsF4Og5oASOMaBeJfIVCpdn1/kAW/8JQHqvaAlwkOfV3xSztoYQFiEqznUKuuy3GQ4pOkcKUN4htk6sqz1t7jOLsFX9YLyRHf73QucL4ycBF3g6luapgO7KrvGtArJShQiFMXHz1vPJkDSLyQs09SqHliXm0n+SnN5j51CxZJ+w4+X0lkopt6SGMIdwUf++2EjZz6n3MBrH6mi2iCUGQOmut+2NleRs7joGcaYjrY=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4600:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4600;20:mlBjL3LjWL09/rL3ogWA9FlJXXPya2Mz9mHqdIlU95+H6iNsNtrr0iQa2gWAjHeO1ycCWX5TswXcgJS+r+8HG3GfWCVKVs6TEIdPV+lE16GrBZM1aa8cQqWP8wC1tq1TkKeYqCXUO4lCabA3K7rnxYETAG7ITZsXK5qOTJO8bXjchmgDTH7V5dGAhp9y+Q75OqtApQ5Kpo8E6oYdxF2qwgIrQ1DMuoWbTMrwzFILpgN9pubkmZOFFTwxi8BVKyrADgtKm8XhjoUjYQqt48bSy1x5ZZ8mEKicIhnrpYTt9YaK8Wrwwqd0HkcxweFUfvORakvp+ep1FXYud5NSbEHzS9Hts20w7dIR8AtUNiO7sfxmvA3z3NVZS/o2onejBSGxI/ne77zVSPUiYK+ot20NPrmIrJfWSoUg0gjNrZhys+u3imNQZHfStFnG8R12P6h0s0TPGKryZfQ6RgDpf6zxChiQ1tC6fjBGwP1Fged8Y8vpbJG9iL9QUAXlw0dzyraM;4:xNeQ8iWNnG1aDrV9bO4BplXCgICv+h/cYhB6HQ5wI7NkW5I6ZzGFpoxHQpeUmOHeBqtiymC2GiQ3Znhti1AA3ZTKIOL+yFxYstrtlwPolcpmOGdQtDK+lDVS0bohr0pZSSGtTPokzeK2bNuii+f549UIHsKaAqYWYe1rU3p37sBk8VJNcYL6ubihxD4hOAhL8mYlnGZHZ6oJ0RnRo+J1gWsRCBTRvVBN3VPaGzDoxUHDM+rAR3NJoOHWKoVNO9JtsNk3nbpNV9YIlUj/zCjAfMgbQhooZ+9o4ej0O8JzN2sb9BBRg5Dvdx+SdsqvlXrX
X-Microsoft-Antispam-PRVS: <BYAPR07MB4600E93CE6F33E87DBABC7DE91430@BYAPR07MB4600.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(198206253151910);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4600;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4600;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(136003)(346002)(189003)(199004)(33716001)(229853002)(86362001)(6666003)(6916009)(966005)(2906002)(68736007)(956004)(72206003)(186003)(97736004)(11346002)(16526019)(55016002)(26005)(50466002)(52116002)(6496006)(6306002)(76176011)(386003)(9686003)(33896004)(1076002)(33656002)(5660300001)(316002)(16586007)(23726003)(476003)(3846002)(7736002)(6116002)(305945005)(58126008)(54906003)(47776003)(6246003)(486006)(25786009)(478600001)(8936002)(8676002)(81156014)(81166006)(106356001)(53936002)(66066001)(446003)(105586002)(44832011)(4326008)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4600;H:hc;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4600;23:u2f9TxN+rd/N8iA5nZGp2kiohv6P/bd2ZEBHLgwAk?=
 =?us-ascii?Q?NjMUoQUf9qJleqdReWnS2LBPH86Dmg6LBYPyMcP/ueRWlsC9SAX9S+MS32cG?=
 =?us-ascii?Q?VIFX0enwI7/2S73Fp78LSdhR4CoStIX4n1Si4sLi1vt/3NbOanM7gUXOQra8?=
 =?us-ascii?Q?I9juEkWpR+DGSVpaw/7vqhHMT6jbFRhPobcYiDhPvky5IN1UQ5/RX0gKkvdF?=
 =?us-ascii?Q?WjaazFmEK+hTfwAxcUEzT7BIYj8z+ezcTEYm4lOHEHrB3w3dxSArhS+S/BB8?=
 =?us-ascii?Q?Ax6DRebP72P6nuodZT3Qxq4fb5mwHxPtYqQscD4xDrc2YgH9TXW+QWI1braT?=
 =?us-ascii?Q?3MbHZXS0MP1MhlJUJScKBc3C1AxY8Ryv6ar6zdre2fXqvN2pm5QqTInG+vma?=
 =?us-ascii?Q?ANUBjhd+ER21+5Fj/znBx9C79AbulhNE/QwtP+3T7fx1FpKcb1AHyZ+6dRac?=
 =?us-ascii?Q?+4ByH1rFUNGvkEG0JAivJSzEwHDuCWshY4sFVNLto6Vp+K5zbdqzHie7g79D?=
 =?us-ascii?Q?isvrdFRhJfAb+65wgruX3O68MGfEAMyueW9xZS5fCqieLe9iV6RnpauQXRx0?=
 =?us-ascii?Q?nBs68A5HePEYY+JWBvjti5AZ5qvD/gbnNzbxkVzXERt+yAPBvOifzrXRk+DP?=
 =?us-ascii?Q?EVuZy4+yUqsA4pY2RcHDMepRZUixyCIo7JD8U3SELOkD4W+USCqhq7pB2/OV?=
 =?us-ascii?Q?MhCKTZxxL7oUjClQOAYZGhXPr9LYq+nCOaybUixn1GRMC6nqDV7K9daTnxfR?=
 =?us-ascii?Q?cyW7bLMmpSWJ5pcsjjpVwLBqRiKK+N9zmzeEr/A3HCyx5DSnbEO13+snUN77?=
 =?us-ascii?Q?gPb8KuKCIduicooL0j4mWG6gWEdQFwXNS6QeciM5VDeVLO7kt44ixq2XhjDz?=
 =?us-ascii?Q?CN6ud3L46PCN7o8Iib9muglaAj62uN0LsciM51xIEmtklUE/2PCOGGGRAQQo?=
 =?us-ascii?Q?ePvcqJLhW9KOls2EkEf6QX8wNb+1fP9xsisMw/Rj1eBcVRXvkRVdU6+emIB6?=
 =?us-ascii?Q?fsHgsat9Q337HA5r+8ou2aCzVbHOCraPL8kQTRUTRwupEjsfKabwmMktpzkh?=
 =?us-ascii?Q?PmgcLiMSkT7Fxd9RqmI/10hJYGvabjsPuZ3Bi0cYfhASAeY+CCVcJZ7GSIgw?=
 =?us-ascii?Q?/EVMb8sQP6T1JzCddFJLIEWvyEmT8Ry+gdd4wXCmEEZ5rWtHlnUT2wZpsULj?=
 =?us-ascii?Q?2lSIdcHW9p07mJc04fXrqgf6NiprDli9X78/G9B/ufv1cvVLgUVpBa7f47hw?=
 =?us-ascii?Q?KYhT1pdi6eb8gZvkuFwqXsbq6bRSC+fyFTCCFv+VQnxvFTwaCYl4W3Wm5s2I?=
 =?us-ascii?Q?BS1kfCqcEBmfxSZyclMaEg+j6Xo63/eYCQvfeNiqG5wHNK2tn0PoaYbtam0F?=
 =?us-ascii?Q?hJnXw=3D=3D?=
X-Microsoft-Antispam-Message-Info: ZIR9ubtcTmlOzeuGSrORjuBu4RWzLp75xAJY2b0g8MUzdfCvDM4tA43XB//FJx1pAkOpYqfjwzfmi8Dplxx6KPBT90m7eOauVLemBK++5JDmzVNzwQo6Av8GWMc64QeI0SzYDY9pstOlrUbUTaLGihlIuCZmjO9DwaOyJQyBsuB34yWdOsnAy62BjqpQYSRhXuYr702fe+fCeY6r22pn214KjPj0zlZXEg7DpEiB3A6OUfLJfvvEA4SjxrNgeYADEEFsiHkOvcaHS1rclAhN8QlDlwB1SfOlSRukb83frmEYa6m53UiaiK/xBsfDE1sv6YHj8tgPh6DOCaPHMBrm3m7T3Lt8ERoNbcbzNAX2K0c=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4600;6:cwah+mjmKbKMpof/kVwTQkP8K2YIZvOoCZE5zjRLo0P1fEKygN9wPremmecZqFAOvGsm/377o3W8O2JmI1xhVo6bBWQxULbvVSKZqGRui3AWW1+SiThWF8+lDy9zEy35az/0VkM7K8XHqoQNw0H/druyUzvdI/9+WJm1uCiP6eOcg3o0zvIDxNTJQwcyuTEAxDX56k7pofoKa3IwQDsRFAvxgUGDE1fxEd3FEzQf/rSCvgoUD3wL7TvjUNtZIfBZ04xeoIeYhM/vCiQXoGzeA5qwBrHhMHAp/b1qo+YXEH18zSZQxOHORs5sDMnlvOcyXI6bWsupMeLagXVjoKKTYrhSniFLAVQU/+Uw54tv3wJYItP92E+dsfaqSxlUy/MV9RIuPh1o866HjRscxwTEaj48smJ0tHYfK0o701/ZTsiNuDyrOhp3861nLPjSjHVqMhWqoy3C41AyFkwH8Oz8Jg==;5:/KRv/i/ZMym+TerQdORtsuVSaYiYZC2fyYLNUYnzHi3yE9X7Iznx5uVWzOQniqvVb/wtSozGJsCrOfXkSSoeR27kyiLn/MYo07/r5F71XH8VyY5FK1DkyR9Ct0x0QusquC0wYMDb5s82ok3I/UhQPmgSRgZjMsmu4GjPNReQ41k=;24:tx8/R3sr4qYp0YQ+Y5Tzvq6bRkCaBdk+f5vHvUneFPKCIczA/LP1NApIAzEJe32rAPJyqTp2rN6d9Zjko0jiIE48mw+TzKyyvGaWu4tqgHw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4600;7:sR4x0azKPiCcqkeXCV+8MWjkM0fXA3LEaSm2LDbPsZSgfId92Zu0h+2UHe0GK8U/AmFTmEkNyZ1WCdt8nVyigYcfoPCJcG+VDJENtHFkdVZmqet3M0ulIvTHPux9gaN8UwICJv7RxDCgYqX+05yb02r+sI0CeyukWFf3ZA324TNcKRmA8ojihrvF1VA+ThjlrVoJQMgNEO72hTap0AnAjW137fASNl75h9Al89BkltH8oVTsYpluFGKSrDeRr779
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 05:45:52.6875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b678440c-be8f-42f9-ebff-08d5dfdf13bd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4600
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

I've already posted a similar patch:
https://patchwork.kernel.org/patch/10482283/

--Jan

On Sat, Jun 30, 2018 at 12:30:49PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The functions zip_ctx_exit, zip_compress, zip_decompress and zip_ctx_init
> are local to the source and do not need to be in global scope, so make
> them static.
> 
> Cleans up sparse warnings:
> symbol 'zip_ctx_exit' was not declared. Should it be static?
> symbol 'zip_compress' was not declared. Should it be static?
> symbol 'zip_decompress' was not declared. Should it be static?
> symbol 'zip_ctx_init' was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/crypto/cavium/zip/zip_crypto.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/crypto/cavium/zip/zip_crypto.c b/drivers/crypto/cavium/zip/zip_crypto.c
> index b92b6e7e100f..f9e99a15d2a0 100644
> --- a/drivers/crypto/cavium/zip/zip_crypto.c
> +++ b/drivers/crypto/cavium/zip/zip_crypto.c
> @@ -69,7 +69,7 @@ static void zip_static_init_zip_ops(struct zip_operation *zip_ops,
>         zip_ops->csum         = 1; /* Adler checksum desired */
>  }
> 
> -int zip_ctx_init(struct zip_kernel_ctx *zip_ctx, int lzs_flag)
> +static int zip_ctx_init(struct zip_kernel_ctx *zip_ctx, int lzs_flag)
>  {
>         struct zip_operation  *comp_ctx   = &zip_ctx->zip_comp;
>         struct zip_operation  *decomp_ctx = &zip_ctx->zip_decomp;
> @@ -107,7 +107,7 @@ int zip_ctx_init(struct zip_kernel_ctx *zip_ctx, int lzs_flag)
>         return -ENOMEM;
>  }
> 
> -void zip_ctx_exit(struct zip_kernel_ctx *zip_ctx)
> +static void zip_ctx_exit(struct zip_kernel_ctx *zip_ctx)
>  {
>         struct zip_operation  *comp_ctx   = &zip_ctx->zip_comp;
>         struct zip_operation  *dec_ctx = &zip_ctx->zip_decomp;
> @@ -119,9 +119,9 @@ void zip_ctx_exit(struct zip_kernel_ctx *zip_ctx)
>         zip_data_buf_free(dec_ctx->output, MAX_OUTPUT_BUFFER_SIZE);
>  }
> 
> -int zip_compress(const u8 *src, unsigned int slen,
> -                u8 *dst, unsigned int *dlen,
> -                struct zip_kernel_ctx *zip_ctx)
> +static int zip_compress(const u8 *src, unsigned int slen,
> +                       u8 *dst, unsigned int *dlen,
> +                       struct zip_kernel_ctx *zip_ctx)
>  {
>         struct zip_operation  *zip_ops   = NULL;
>         struct zip_state      *zip_state;
> @@ -155,9 +155,9 @@ int zip_compress(const u8 *src, unsigned int slen,
>         return ret;
>  }
> 
> -int zip_decompress(const u8 *src, unsigned int slen,
> -                  u8 *dst, unsigned int *dlen,
> -                  struct zip_kernel_ctx *zip_ctx)
> +static int zip_decompress(const u8 *src, unsigned int slen,
> +                         u8 *dst, unsigned int *dlen,
> +                         struct zip_kernel_ctx *zip_ctx)
>  {
>         struct zip_operation  *zip_ops   = NULL;
>         struct zip_state      *zip_state;
> --
> 2.17.1

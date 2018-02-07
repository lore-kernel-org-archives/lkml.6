Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932079AbeBGOj7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:39:59 -0500
Received: from mail-he1eur01on0079.outbound.protection.outlook.com ([104.47.0.79]:45969
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753983AbeBGOjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:39:55 -0500
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 16/18] crypto: talitos - do hw_context DMA mapping outside
 the requests
Thread-Topic: [PATCH 16/18] crypto: talitos - do hw_context DMA mapping
 outside the requests
Thread-Index: AQHTPqPqvsZq/NPBh0+2ewavIdT74g==
Date: Wed, 7 Feb 2018 14:39:52 +0000
Message-ID: <VI1PR0402MB3342A0A8530F74D408CA2F0298FC0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
References: <cover.1507284818.git.christophe.leroy@c-s.fr>
 <e47bf94ae44f23230b1647e31c9623f1075d3b79.1507284818.git.christophe.leroy@c-s.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3710;7:fqXGRjkAvrBfth1tHgpqa+K82kbohkEsVMqZs6YKSl7b0OJ44uhfrEMwGLfdvKIsSTk5hSz5benvRMgAK/9RRc+Tm8TAhShwC8+Rh3R4K0SiFH2ZAKuHRMrPMlJxZ7gAgeq3LnA0wfVONHSuwn42u/K7O5q8NirZMvVxMi8tniVVKgdnHtGoeABw4a13yAoLsvkJc1cHyC0lrhvK86J9pkQt8o4ydLGhXMzm1qSx3Pqq3w2jFawQMLJQpQd6SPzL
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61ae774f-2a54-44b0-e913-08d56e38a63c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:VI1PR0402MB3710;
x-ms-traffictypediagnostic: VI1PR0402MB3710:
x-microsoft-antispam-prvs: <VI1PR0402MB371026E6D9B7B9D1C7FF794498FC0@VI1PR0402MB3710.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(3002001)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0402MB3710;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3710;
x-forefront-prvs: 0576145E86
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(39860400002)(39380400002)(199004)(189003)(53936002)(5660300001)(229853002)(186003)(68736007)(7696005)(2906002)(86362001)(99286004)(8936002)(76176011)(97736004)(478600001)(55016002)(2900100001)(9686003)(8676002)(81166006)(81156014)(6436002)(316002)(14454004)(66066001)(25786009)(33656002)(54906003)(110136005)(105586002)(26005)(7736002)(6246003)(6506007)(74316002)(6116002)(3846002)(3280700002)(59450400001)(305945005)(53546011)(4326008)(5250100002)(102836004)(106356001)(3660700001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3710;H:VI1PR0402MB3342.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: wxRIftlvI1Pc4aPNUaukOVIr2tHYJtk8vt6LlsJ9vz6AIlpEpsjCELH1Iiof9W0UXzj+U9UawnPsQwpRQraDgw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ae774f-2a54-44b0-e913-08d56e38a63c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2018 14:39:52.7933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3710
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w17Ee4H0019720

On 10/6/2017 4:06 PM, Christophe Leroy wrote:
> At every request, we map and unmap the same hash hw_context.
> 
> This patch moves the dma mapping/unmapping in functions ahash_init()
> and ahash_import().
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  drivers/crypto/talitos.c | 80 ++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 57 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
> index ebfd6d982ed6..d495649d5267 100644
> --- a/drivers/crypto/talitos.c
> +++ b/drivers/crypto/talitos.c
> @@ -819,6 +819,7 @@ struct talitos_ctx {
>  	unsigned int keylen;
>  	unsigned int enckeylen;
>  	unsigned int authkeylen;
> +	dma_addr_t dma_hw_context;
This doesn't look correct.

talitos_ctx structure is the tfm context.
dma_hw_context is the IOVA of hw_context, located in talitos_ahash_req_ctx
structure (request context).

If there are multiple requests in flight for the same tfm, dma_hw_context will
be overwritten.

dma_hw_context needs to be moved in request context (talitos_ahash_req_ctx struct).

Thanks,
Horia

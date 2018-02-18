Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751497AbeBRROI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 12:14:08 -0500
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]:24406
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751259AbeBRROG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 12:14:06 -0500
From: =?windows-1258?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
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
Date: Sun, 18 Feb 2018 17:14:03 +0000
Message-ID: <VI1PR0402MB3342D90D574C8829701882BE98C90@VI1PR0402MB3342.eurprd04.prod.outlook.com>
References: <cover.1507284818.git.christophe.leroy@c-s.fr>
 <e47bf94ae44f23230b1647e31c9623f1075d3b79.1507284818.git.christophe.leroy@c-s.fr>
 <VI1PR0402MB3342A0A8530F74D408CA2F0298FC0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <2338eb8d-a26a-9722-d667-5a9785b32977@c-s.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com;
x-originating-ip: [89.136.137.18]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2718;7:U+gyU6y2zJ0xtk0HdoviFOBHnfab+VpCdEdIZGxFBU8hb6gPBNxTlpoczeCufmps47EwHZ4OMwGnkqwV9QTeWPgWM8MXe/hTlAZ987eLJBdTJvafkiLeupkkhIL0HzeVwEF1GUzXgBR3jXBKBAGuPYaYVfuM1RwjyIt4qo8qkrGU/hkZdG7sJpL4NWYGnm5EP4q19j5awBILIShOPqDamKAt+WE1XFqPYphRTNrXTU+qeDGceDjVt+BVlZ49R99A
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65ae4d04-cb30-465b-5072-08d576f30284
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:VI1PR0402MB2718;
x-ms-traffictypediagnostic: VI1PR0402MB2718:
x-microsoft-antispam-prvs: <VI1PR0402MB2718C7C2134B23345C44954498C90@VI1PR0402MB2718.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231101)(944501161)(6055026)(6041288)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0402MB2718;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2718;
x-forefront-prvs: 058707456E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(39380400002)(346002)(376002)(366004)(199004)(189003)(129404003)(53936002)(7736002)(74316002)(305945005)(6246003)(76176011)(3280700002)(186003)(26005)(102836004)(59450400001)(53546011)(6116002)(6506007)(3846002)(110136005)(2906002)(316002)(81156014)(54906003)(106356001)(25786009)(66066001)(5250100002)(81166006)(8676002)(8936002)(9686003)(33656002)(55016002)(6306002)(68736007)(6436002)(3660700001)(4326008)(105586002)(2900100001)(229853002)(5660300001)(99286004)(93886005)(966005)(86362001)(97736004)(14454004)(7696005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2718;H:VI1PR0402MB3342.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: MomoQqBF9xdymOnjB4b4Zx3W5ZOJMDtlK5rE+BIzLtsfRgokWa8cGUzbifTK44GxHToQVnn3JfdUInAolFXiqHrSsuAjxtJrcwuIB8bXIbhr7f0lDbLWQhQ/IAomavhJyc6YQEWvTj7JQK5c92dYDjbQqmSoQhdonqeJoPTcGLQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="windows-1258"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ae4d04-cb30-465b-5072-08d576f30284
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2018 17:14:03.3055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2718
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1IHED48020666

On 2/17/2018 6:32 PM, Christophe LEROY wrote:
> 
> 
> Le 07/02/2018 à 15:39, Horia Geantã a écrit :
>> On 10/6/2017 4:06 PM, Christophe Leroy wrote:
>>> At every request, we map and unmap the same hash hw_context.
>>>
>>> This patch moves the dma mapping/unmapping in functions ahash_init()
>>> and ahash_import().
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>>   drivers/crypto/talitos.c | 80 ++++++++++++++++++++++++++++++++++--------------
>>>   1 file changed, 57 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
>>> index ebfd6d982ed6..d495649d5267 100644
>>> --- a/drivers/crypto/talitos.c
>>> +++ b/drivers/crypto/talitos.c
>>> @@ -819,6 +819,7 @@ struct talitos_ctx {
>>>   	unsigned int keylen;
>>>   	unsigned int enckeylen;
>>>   	unsigned int authkeylen;
>>> +	dma_addr_t dma_hw_context;
>> This doesn't look correct.
>>
>> talitos_ctx structure is the tfm context.
>> dma_hw_context is the IOVA of hw_context, located in talitos_ahash_req_ctx
>> structure (request context).
> 
> Yes but I have now found how I can know that the request context is 
> being released in order to unmap() dma at that time.
> It is tricky to use the tmf context I agree, but at least I know when 
> tmf context get destroyed, ie in talitos_cra_exit_ahash()
> The request context is created by ahash_request_alloc() and released by
> ahash_request_free(). I have not found the way to call dma_unmap() 
> before ahash_request_free() gets called.
> 
>>
>> If there are multiple requests in flight for the same tfm, dma_hw_context will
>> be overwritten.
> 
> Before overwritting dma_hw_context, it is always released, see 
> talitos_cra_exit_ahash(), ahash_init(), ahash_import()
> 
The problem is not the unmapping.
If there are two requests for the same tfm, then given the following sequence
1. tfm->ahash_init(req1)
	tfm_ctx->dma_hw_context points to req1_ctx->hw_context
2. tfm->ahash_init(req2)
	tfm_ctx->dma_hw_context [unmapped, then] points to req2_ctx->hw_context
i.e. req1 will use the hw_context of req2.

>>
>> dma_hw_context needs to be moved in request context (talitos_ahash_req_ctx struct).
> 
> Any suggestion then on how to handle the issue explained above ?
> 
There is no ahash_exit() callback mirroring ahash_init().

The clean-up of request ctx should be done in the last states of the hash flows
described here:
https://www.kernel.org/doc/html/latest/crypto/devel-algos.html#cipher-definition-with-struct-shash-alg-and-ahash-alg
for e.g. in the final() callback.

Hope this helps,
Horia

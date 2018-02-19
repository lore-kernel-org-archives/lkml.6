Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbeBSNQj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 08:16:39 -0500
Received: from mail-ve1eur01on0049.outbound.protection.outlook.com ([104.47.1.49]:39200
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752666AbeBSNQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 08:16:38 -0500
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
Date: Mon, 19 Feb 2018 13:16:30 +0000
Message-ID: <VI1PR0402MB334299B37F17771BFA9AFDDA98C80@VI1PR0402MB3342.eurprd04.prod.outlook.com>
References: <cover.1507284818.git.christophe.leroy@c-s.fr>
 <e47bf94ae44f23230b1647e31c9623f1075d3b79.1507284818.git.christophe.leroy@c-s.fr>
 <VI1PR0402MB3342A0A8530F74D408CA2F0298FC0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <2338eb8d-a26a-9722-d667-5a9785b32977@c-s.fr>
 <VI1PR0402MB3342D90D574C8829701882BE98C90@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <630c313c-5eca-224d-a5ac-fb3f2783573a@c-s.fr>
 <VI1PR0402MB334256E1706A4E1AED09F4A598C80@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <d5809df9-fc17-03da-b7f4-038d973dbd1f@c-s.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3629;7:+J3e+16GGO7SXstx8BUilgyvSWmw9dYCHuEGR07JhI1qQtVjcpukU5KS8+LR9pKeUDR2vRSCpgl81QpvmP1biKsCE6mx9XEjn7VSUCnH6GdAGD5zzBHtm7tvGe9Cl4fNUHq8pZvZgahhEaHbUI0REm+RlZTjQvMHeAWXgFqBFiTlybCu/jdY9rDi5ga7w6Qba8vfEpvfmsU9p0qaMkPzefNBERGbhqDKEbkHnXwV6aUJ8n00u3Iiq/VNdCVBVGVV
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bfb46123-910c-4f73-2bde-08d5779afdb1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:VI1PR0402MB3629;
x-ms-traffictypediagnostic: VI1PR0402MB3629:
x-microsoft-antispam-prvs: <VI1PR0402MB3629ABE05FE478843802767998C80@VI1PR0402MB3629.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR0402MB3629;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3629;
x-forefront-prvs: 0588B2BD96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(396003)(39860400002)(366004)(346002)(189003)(199004)(7696005)(7736002)(3660700001)(3280700002)(25786009)(4326008)(105586002)(66066001)(110136005)(76176011)(316002)(26005)(54906003)(33656002)(99286004)(5250100002)(102836004)(186003)(59450400001)(106356001)(74316002)(55016002)(478600001)(966005)(14454004)(5660300001)(6506007)(8676002)(81156014)(53936002)(81166006)(6116002)(229853002)(2900100001)(6306002)(9686003)(97736004)(93886005)(6246003)(6436002)(3846002)(8936002)(2906002)(68736007)(53546011)(86362001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3629;H:VI1PR0402MB3342.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: sgarTHd1LxwdcKI4Wg+fdl91JFMfq3wtzLHiG4xwzR2y8PFo3FA1ga94gpPBt2N+Lcff4DHo9yRtXVj/q03vLYDMvyp/vDpsqNNk70Cr4WrK6NhCg7zuK5UZc5mX9LWPkde8WTs4Z3YWqLBsTtTCcQ7yCQ0Q0gucMS0uKxnE3e8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="windows-1258"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb46123-910c-4f73-2bde-08d5779afdb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2018 13:16:30.6458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3629
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1JDGi3e019058

On 2/19/2018 11:14 AM, Christophe LEROY wrote:
> Le 19/02/2018 à 09:30, Horia Geantã a écrit :
>> On 2/19/2018 9:58 AM, Christophe LEROY wrote:
>>> Le 18/02/2018 à 18:14, Horia Geantã a écrit :
>>>> There is no ahash_exit() callback mirroring ahash_init().
>>>>
>>>> The clean-up of request ctx should be done in the last states of the hash flows
>>>> described here:
>>>> https://www.kernel.org/doc/html/latest/crypto/devel-algos.html#cipher-definition-with-struct-shash-alg-and-ahash-alg
>>>> for e.g. in the final() callback.
>>>
>>> Unfortunatly it seems that we can't rely on those finalising functions
>>> being called all the time.
>>> If you look into test_ahash_jiffies() for instance, in case of error the
>>> call of crypto_hash_final() is skipped.
>>
>> If test_ahash_jiffies() errors before calling crypto_ahash_final(req), this
>> means a previous callback failed.
>> Accordingly, DMA unmapping should be performed also on the corresponding errors
>> paths in the driver.
>>
> 
> And what about ALGIF path from user space ?
> What if the user never calls the last sendmsg() which will call 
> hash_finup() ?
> 
User is expected to follow the rules of the crypto API.
Of course, kernel won't (or at least shouldn't) crash in case of misuse.
However, in these cases some resources might not be freed - it's unavoidable.

Horia

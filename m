Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeBSIaz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 03:30:55 -0500
Received: from mail-db5eur01on0046.outbound.protection.outlook.com ([104.47.2.46]:38448
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751628AbeBSIax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 03:30:53 -0500
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
Date: Mon, 19 Feb 2018 08:30:49 +0000
Message-ID: <VI1PR0402MB334256E1706A4E1AED09F4A598C80@VI1PR0402MB3342.eurprd04.prod.outlook.com>
References: <cover.1507284818.git.christophe.leroy@c-s.fr>
 <e47bf94ae44f23230b1647e31c9623f1075d3b79.1507284818.git.christophe.leroy@c-s.fr>
 <VI1PR0402MB3342A0A8530F74D408CA2F0298FC0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <2338eb8d-a26a-9722-d667-5a9785b32977@c-s.fr>
 <VI1PR0402MB3342D90D574C8829701882BE98C90@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <630c313c-5eca-224d-a5ac-fb3f2783573a@c-s.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3710;7:+M2OWdv/v7c+wsh1SDzee9dqwX3LL+ImaGbIlzXcysiPP/xGD865AWmh27+X4a9TvuLM4UTTSiqnxX2tLDCp1cQ5HFbCvmGmNoO/dZLxp8IHW7OXYJGhI7UlB9sRmvgAe3tB8rsRE+2+GOqEtARXTsI/H8EwAt3K8bqVUrX+1bPaC2pjXl7FApJFGc5ogS+f7HZmgypReDyTuds8skKNgPIGzW1sNUFjg9tPPn0TYPnmOh8vIcAQvLK9fqEY/BAC
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51df2dfe-a13b-4d75-ac97-08d57773150f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:VI1PR0402MB3710;
x-ms-traffictypediagnostic: VI1PR0402MB3710:
x-microsoft-antispam-prvs: <VI1PR0402MB3710FE53FCE025F760EFB7CB98C80@VI1PR0402MB3710.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231101)(944501161)(10201501046)(6055026)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR0402MB3710;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3710;
x-forefront-prvs: 0588B2BD96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(396003)(39380400002)(189003)(199004)(9686003)(81166006)(6116002)(305945005)(53546011)(25786009)(6506007)(55016002)(26005)(6306002)(14454004)(53936002)(81156014)(966005)(8676002)(3846002)(5660300001)(8936002)(4326008)(6436002)(186003)(97736004)(59450400001)(229853002)(66066001)(102836004)(74316002)(6246003)(76176011)(7696005)(5250100002)(7736002)(478600001)(2900100001)(316002)(110136005)(68736007)(3280700002)(86362001)(105586002)(3660700001)(54906003)(106356001)(93886005)(99286004)(2906002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3710;H:VI1PR0402MB3342.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: w1wvou1LXYDm2btxD9ZwcHiHi+qC6KL8YmaIu3FRm3ZhPYS8WKb8PvaVkSJoaGYSw0YvzpoZOreZ+3w9onY8RpLlYHsAUOv0Ke8sbPkL/MgwGzcrvMtTASfPrIvBgtBUxs61eTN2yg0Fh+rcgCZlFEIL8QQwAIIkKY3vWsZ6+Ig=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="windows-1258"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51df2dfe-a13b-4d75-ac97-08d57773150f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2018 08:30:49.9836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3710
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1J8Ux37005080

On 2/19/2018 9:58 AM, Christophe LEROY wrote:
> Le 18/02/2018 à 18:14, Horia Geantã a écrit :
>> There is no ahash_exit() callback mirroring ahash_init().
>>
>> The clean-up of request ctx should be done in the last states of the hash flows
>> described here:
>> https://www.kernel.org/doc/html/latest/crypto/devel-algos.html#cipher-definition-with-struct-shash-alg-and-ahash-alg
>> for e.g. in the final() callback.
> 
> Unfortunatly it seems that we can't rely on those finalising functions 
> being called all the time.
> If you look into test_ahash_jiffies() for instance, in case of error the 
> call of crypto_hash_final() is skipped.

If test_ahash_jiffies() errors before calling crypto_ahash_final(req), this
means a previous callback failed.
Accordingly, DMA unmapping should be performed also on the corresponding errors
paths in the driver.

Horia

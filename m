Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeCTK3w (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 06:29:52 -0400
Received: from mail-eopbgr00057.outbound.protection.outlook.com ([40.107.0.57]:55232
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752244AbeCTK3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 06:29:49 -0400
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
CC: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2] crypto: doc - clarify hash callbacks state machine
Thread-Topic: [PATCH v2] crypto: doc - clarify hash callbacks state machine
Thread-Index: AQHTwCh9gcjc1z/CcUO3XGrj5FBtzw==
Date: Tue, 20 Mar 2018 10:29:45 +0000
Message-ID: <DBXPR04MB463D8753202F6587C526B1E98AB0@DBXPR04MB463.eurprd04.prod.outlook.com>
References: <20180305103945.3517-1-horia.geanta@nxp.com>
 <CGME20180320075741epcas5p3a7c026ba8644e54478955afcb6091023@epcas5p3.samsung.com>
 <20180320075612.22719-1-horia.geanta@nxp.com>
 <d036a7ef-d900-4858-b821-05c50b2b739e@partner.samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DBXPR04MB144;7:d3vXZPyL+NiYhfBo4ysyNb7BGntV1qMF91E8d+iOQ0jWrkjTHNhDA+9fcdGfMzwxDubbq/cQcUfF8duTPwfq8WWyXaG+/gi/YvNNoCo/oaK0UG2XdOREiun4A0nkpKNjkHmIqCr6G0P4TbvkUlIo7T9UCiPXnQRD4PA7hLjEJjPE/aad+YileIUJLvGNLlXMD9zDITocgL7vKTmQ3RMP301Hwa1oJ2Won/yjwvXS5Ycg/PbB2JR7qGU4i1I/rwVb
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9adcbf24-b583-44a3-1b59-08d58e4d802f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DBXPR04MB144;
x-ms-traffictypediagnostic: DBXPR04MB144:
x-microsoft-antispam-prvs: <DBXPR04MB1442E90D04E3791B8A5F52898AB0@DBXPR04MB144.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501309)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DBXPR04MB144;BCL:0;PCL:0;RULEID:;SRVR:DBXPR04MB144;
x-forefront-prvs: 061725F016
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(39380400002)(366004)(199004)(189003)(25786009)(81166006)(81156014)(76176011)(53936002)(99286004)(316002)(2906002)(5250100002)(55016002)(561944003)(7696005)(33656002)(8676002)(6306002)(9686003)(3846002)(6116002)(66066001)(8936002)(6436002)(106356001)(2900100001)(93886005)(6246003)(59450400001)(3280700002)(305945005)(26005)(186003)(110136005)(3660700001)(102836004)(53546011)(229853002)(6506007)(478600001)(5660300001)(68736007)(7736002)(74316002)(966005)(14454004)(4326008)(97736004)(54906003)(105586002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBXPR04MB144;H:DBXPR04MB463.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: azIiUS25C6s+PdrO14cGGWZz+q31INEoGRiPveIvgbAvoi2Zs3VCuaezuglR2JAJ/tpWwhFZ/zSjto/3oeXpmp7ihtXPExd6bHOQYJdhe2DQzbXLf6feDR8vyiHbTqGOgfbTqaOrQHZLOBGrTHzbtgPO6onZL/+I9qZUbM7ChIjLVuZTrrXCut2Teqy+O1h1UPYeCCIs+y5j5qiLMA7ta4UN9GcRp4o0Eb4z6vQzpoFXGguWarKl/GwVMCXX7PG6QjtuESwNQIDX/UujNDjhLYXuR+7jFLm67ijDByWc+U+tAmlLleuJNsEvS5PY5Ol0XDum61JZqfctp1m88frtYw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9adcbf24-b583-44a3-1b59-08d58e4d802f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2018 10:29:45.6052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBXPR04MB144
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2KATuRL032671

On 3/20/2018 10:50 AM, Kamil Konieczny wrote:
> On 20.03.2018 08:56, Horia Geantã wrote:
>> Add a note that it is perfectly legal to "abandon" a request object:
>> - call .init() and then (as many times) .update()
>> - _not_ call any of .final(), .finup() or .export() at any point in
>>   future
>>
>> Link: https://lkml.kernel.org/r/20180222114741.ga27...@gondor.apana.org.au
>> Signed-off-by: Horia Geantã <horia.geanta@nxp.com>
>> ---
>>  Documentation/crypto/devel-algos.rst | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/crypto/devel-algos.rst b/Documentation/crypto/devel-algos.rst
>> index 66f50d32dcec..c45c6f400dbd 100644
>> --- a/Documentation/crypto/devel-algos.rst
>> +++ b/Documentation/crypto/devel-algos.rst
>> @@ -236,6 +236,14 @@ when used from another part of the kernel.
>>                                 |
>>                                 '---------------> HASH2
>>  
>> +Note that it is perfectly legal to "abandon" a request object:
>> +- call .init() and then (as many times) .update()
>> +- _not_ call any of .final(), .finup() or .export() at any point in future
>> +
>> +In other words implementations should mind the resource allocation and clean-up.
>> +No resources related to request objects should remain allocated after a call
> -- ^^^^^^^^^^^^
>> +to .init() or .update(), since there might be no chance to free them.
> 
> is it for crypto api  users or for drivers ?
> 
For drivers / providers (below crypto API).

> the creator of request context is responsible for alloc and destroy,
> so why there are no chance of free ?
> 
Hash request object (including request context) is allocated by the user /
client by means of ahash_request_alloc(), and later on freed using
ahash_request_free().
I don't see a problem with this.

However, besides the memory allocated for the request context, other resources
(related to the request) might be needed by the driver.
I provided an example of needing to DMA map a buffer (to load/store HW state
from/to crypto engine), and I am not happy with either solutions:
-DMA map & unmap after each .update()
-Herbert's proposal to use a convoluted DMA mapping scheme

Another example: dynamic memory allocation might be needed beyond what's
available in request context, i.e. driver might not have apriori all the
information needed to inform the tfm about required memory using
crypto_ahash_set_reqsize().

This happens due to the semantics of the crypto API, which allows the user to
initialize a request object and drop it without getting a result (final or
partial hash).
I don't see what below use case is good for, maybe just for benchmarking:
req = ahash_request_alloc();
[...]
crypto_ahash_init(req);
crypto_ahash_update(req);
ahash_request_free(req);

Horia

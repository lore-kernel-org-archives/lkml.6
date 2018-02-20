Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbeBTLcb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 06:32:31 -0500
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:49184
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751348AbeBTLc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 06:32:29 -0500
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Christophe LEROY <christophe.leroy@c-s.fr>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 16/18] crypto: talitos - do hw_context DMA mapping outside
 the requests
Thread-Topic: [PATCH 16/18] crypto: talitos - do hw_context DMA mapping
 outside the requests
Thread-Index: AQHTPqPqvsZq/NPBh0+2ewavIdT74g==
Date: Tue, 20 Feb 2018 11:32:25 +0000
Message-ID: <VI1PR0402MB3342B99A1BEA5622F29F79EF98CF0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
References: <cover.1507284818.git.christophe.leroy@c-s.fr>
 <e47bf94ae44f23230b1647e31c9623f1075d3b79.1507284818.git.christophe.leroy@c-s.fr>
 <VI1PR0402MB3342A0A8530F74D408CA2F0298FC0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <2338eb8d-a26a-9722-d667-5a9785b32977@c-s.fr>
 <VI1PR0402MB3342D90D574C8829701882BE98C90@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <630c313c-5eca-224d-a5ac-fb3f2783573a@c-s.fr>
 <VI1PR0402MB334256E1706A4E1AED09F4A598C80@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <d5809df9-fc17-03da-b7f4-038d973dbd1f@c-s.fr>
 <VI1PR0402MB334299B37F17771BFA9AFDDA98C80@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <20180220103436.GA20571@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3838;7:jrpTG0HCBk5dFMHBrTK/wz2uYbfU9Ig9SMYE9I1lLuSqgznkoagBYvqACYy1tN6xqO3dSnYZ6J2dCd5MVqj841S9Y9oOwKEMbeNA+BGk9EHPjbfmUnmaTJCxJfi0tb0fr2Mp7D3rVL59zw4Ri81PYLqV+CTqPqD7Z/rqN08DHSolctwkoOF7I5uMqp6/xsOkQngAbybDwpD8K8jvGoVruNmuDZRVVKEPuHuu+VixKIjJoQ+50OqehvHMA41gxX8p
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9744d063-f165-4627-4f08-08d578559de5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:VI1PR0402MB3838;
x-ms-traffictypediagnostic: VI1PR0402MB3838:
x-microsoft-antispam-prvs: <VI1PR0402MB3838E33202D03CDD860F348A98CF0@VI1PR0402MB3838.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0402MB3838;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3838;
x-forefront-prvs: 05891FB07F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(396003)(39860400002)(366004)(376002)(189003)(199004)(8936002)(2900100001)(105586002)(97736004)(68736007)(66066001)(8676002)(14454004)(93886005)(74316002)(3660700001)(3280700002)(106356001)(4326008)(6116002)(26005)(186003)(478600001)(59450400001)(53546011)(102836004)(6506007)(5250100002)(5660300001)(76176011)(7696005)(305945005)(86362001)(7736002)(6916009)(54906003)(229853002)(6246003)(9686003)(55016002)(99286004)(6436002)(316002)(25786009)(2906002)(81166006)(81156014)(3846002)(53936002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3838;H:VI1PR0402MB3342.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 61AcFkg6nNZX5Fc88q3+hfu0c+moPsas3UWLD9mkLhFBctPtGkk/qk0kIEih16N4e5WS4qeUFLgF0qiKA4Y9MZLOwCbm+RsxlXpPL7QjlkyO6neCDQNiHssIIC4ZoJ2ZwPtJ6tSRrxFb/SDUPMpfBoUW7wS2lkzRBDE87LBaYOg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9744d063-f165-4627-4f08-08d578559de5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2018 11:32:25.8147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3838
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1KBWchu004609

On 2/20/2018 12:34 PM, Herbert Xu wrote:
> On Mon, Feb 19, 2018 at 01:16:30PM +0000, Horia Geantã wrote:
>>
>>> And what about ALGIF path from user space ?
>>> What if the user never calls the last sendmsg() which will call 
>>> hash_finup() ?
>>>
>> User is expected to follow the rules of the crypto API.
>> Of course, kernel won't (or at least shouldn't) crash in case of misuse.
>> However, in these cases some resources might not be freed - it's unavoidable.
> 
> the crypto API does not require the presence of a finalisation.
> It is entirely optional.  So leaving resources pinned down until
> final/finup occurs is unacceptable, both from user-space and the
> kernel.
> 
If final/finup is optional, how is the final hash supposed to be retrieved?

According to documentation, these are the accepted flows (with the option to
export/import a partial hash b/w update and final/finup):

.init() -> .update() -> .final()
            ^    |         |
            '----'         '---> HASH

.init() -> .update() -> .finup()
            ^    |         |
            '----'         '---> HASH

           .digest()
               |
               '---------------> HASH

Note that digest() is not an issue in the case we are discussing, since resource
allocation happens only in init().

Thanks,
Horia

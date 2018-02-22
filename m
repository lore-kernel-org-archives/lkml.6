Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932085AbeBVM3d (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:29:33 -0500
Received: from mail-db5eur01on0088.outbound.protection.outlook.com ([104.47.2.88]:31968
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753702AbeBVM3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:29:31 -0500
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        Christophe LEROY <christophe.leroy@c-s.fr>
CC: "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 16/18] crypto: talitos - do hw_context DMA mapping outside
 the requests
Thread-Topic: [PATCH 16/18] crypto: talitos - do hw_context DMA mapping
 outside the requests
Thread-Index: AQHTPqPqvsZq/NPBh0+2ewavIdT74g==
Date: Thu, 22 Feb 2018 12:29:28 +0000
Message-ID: <AM0PR0402MB3329F899D4777EE356BBE2B698CD0@AM0PR0402MB3329.eurprd04.prod.outlook.com>
References: <e47bf94ae44f23230b1647e31c9623f1075d3b79.1507284818.git.christophe.leroy@c-s.fr>
 <VI1PR0402MB3342A0A8530F74D408CA2F0298FC0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <2338eb8d-a26a-9722-d667-5a9785b32977@c-s.fr>
 <VI1PR0402MB3342D90D574C8829701882BE98C90@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <630c313c-5eca-224d-a5ac-fb3f2783573a@c-s.fr>
 <VI1PR0402MB334256E1706A4E1AED09F4A598C80@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <d5809df9-fc17-03da-b7f4-038d973dbd1f@c-s.fr>
 <VI1PR0402MB334299B37F17771BFA9AFDDA98C80@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <20180220103436.GA20571@gondor.apana.org.au>
 <VI1PR0402MB3342B99A1BEA5622F29F79EF98CF0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <20180222114741.GA27631@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3777;7:5okzAK7pLsoYtnu9rZmo/NGn1zaYKPoqutpO7RSwtdyRxh27RhfWGEepuo6ic7QtG1oRy1TgS45zxfrDytDAeQmhtPTiZO2LTp+B+THy6/4Gthgy16pgZadAhlPFxs7Mb/o0s1E8NYadmvnhSCIi0p1ywBTtXF1YMOjht0u+RyIkvvibsdiFnAW15eyOZkDWy6lVIfcaLW7DbH18eJvzhzr+5cMuTYpunXjn4vakwOf2NIQVNw96I3QJmPD6OA5k
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 473e2c38-de98-4ef4-e4d8-08d579efeb08
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:AM0PR0402MB3777;
x-ms-traffictypediagnostic: AM0PR0402MB3777:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com;
x-microsoft-antispam-prvs: <AM0PR0402MB3777E0407E015368E03D1D3C98CD0@AM0PR0402MB3777.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001079)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231162)(944501161)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:AM0PR0402MB3777;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3777;
x-forefront-prvs: 059185FE08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(39860400002)(346002)(39380400002)(51914003)(199004)(189003)(99286004)(68736007)(6436002)(186003)(3280700002)(316002)(8936002)(33656002)(53546011)(54906003)(26005)(86362001)(102836004)(97736004)(6506007)(7696005)(6116002)(229853002)(3846002)(93886005)(55016002)(5250100002)(53936002)(110136005)(74316002)(9686003)(305945005)(76176011)(6246003)(59450400001)(8676002)(14454004)(25786009)(7736002)(106356001)(4326008)(478600001)(3660700001)(66066001)(5660300001)(81156014)(105586002)(81166006)(2906002)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3777;H:AM0PR0402MB3329.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Gtuh/tupU4tbI5RWMNx0GOc5cV2Gr72CZxOmV1DGZOqXmYtVyg0y0K+yJgNHBRHkRCC11r9hEchiVIPi22hrkXDAaKyVHmsKxdr05X/KPuAe9H5ht/05doexRPS7qOsVV5wB3F7tTtNI9F5ObwwvJCCekAGpsn7K7aXlp8l/UAg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 473e2c38-de98-4ef4-e4d8-08d579efeb08
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2018 12:29:28.9072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3777
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1MCTdDC006111

On 2/22/2018 1:47 PM, Herbert Xu wrote:
> On Tue, Feb 20, 2018 at 11:32:25AM +0000, Horia Geantã wrote:
>>
>> If final/finup is optional, how is the final hash supposed to be retrieved?
> 
> Sometimes the computation ends with a partial hash, that's what
> export is for.  Also it is completely legal to abandon the hash
> state entirely.
> 
Thanks for the explanation.
It's unintuitive to call .init() -> .update() and then not to call any of
.final(), .finup(), .export().

Christophe,

IIUC this means that there is no room for improvement.
This patch needs to be reverted, to restore previous behaviour when the
hw_context was mapped / unmapped for every request.

Thanks,
Horia

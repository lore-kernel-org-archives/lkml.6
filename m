Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755335AbeCSGj4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 02:39:56 -0400
Received: from mail-db5eur01on0072.outbound.protection.outlook.com ([104.47.2.72]:54720
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755169AbeCSGjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 02:39:52 -0400
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: doc - clarify hash callbacks state machine
Thread-Topic: [PATCH] crypto: doc - clarify hash callbacks state machine
Thread-Index: AQHTvTnS8kcR1bt5RUucTQuU3LKxuQ==
Date: Mon, 19 Mar 2018 06:39:50 +0000
Message-ID: <AM3PR04MB45284A83B66E00785872DE698D40@AM3PR04MB452.eurprd04.prod.outlook.com>
References: <20180305103945.3517-1-horia.geanta@nxp.com>
 <20180316151642.GA6606@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1233;7:Jz14F1wBmg5NmHW2V2AGfGy2RO0yNHPEgdULdCyH+uGxLmqSdcY98aqSI96zIcPBISloDg85w4i0XLUR6PDnCnxTtQ3kIDMaK4A9FnAqNcTLPSmDDq2O3aCYVuQCAYrgENtQcoZEaac7Wn6EAUYnl4z6T5lWXbKVATeu2jPURQ2PB+lI8l8bjgpX/CgBVl8ysN8A/lvkfqY0JNE5cL/hOU2UnO8U9CVgi1VRyd6uGq27CkPj2FVelzHDQxna89Su
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb205a07-f7c5-435b-33a7-08d58d643715
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1233;
x-ms-traffictypediagnostic: AM3PR04MB1233:
x-microsoft-antispam-prvs: <AM3PR04MB12331ED61DCD90B70296F1FA98D40@AM3PR04MB1233.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM3PR04MB1233;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1233;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(376002)(366004)(346002)(199004)(189003)(76176011)(102836004)(53936002)(6116002)(316002)(2900100001)(81156014)(7696005)(4326008)(6506007)(54906003)(97736004)(81166006)(55016002)(6246003)(33656002)(3846002)(229853002)(8936002)(9686003)(7736002)(86362001)(53546011)(5250100002)(5660300001)(74316002)(478600001)(8676002)(106356001)(66066001)(14454004)(3660700001)(59450400001)(186003)(25786009)(26005)(6916009)(6436002)(99286004)(3280700002)(68736007)(105586002)(2906002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1233;H:AM3PR04MB452.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 29TpFIFqb2QKjWOvzN3xqZ4hliU5v/Wi03Thb6MG4xgrnUEk74XYEfspwlF8bfM4P9HSG/oK/sJkIUHgqQUs6wUnZp5xV4Oiktywc6UHAttzjNENhEE/ehkkAVh1RHFOBdZAJT8m0K/vb2LmiQCHd+gGc6A+RQ8FVvuW++LahNaFvZqQ6YyjzV6dt9KJaNQborNFNN5WyYC4tV2w3NpUcYhx3/6ZfLYI1TRjJtCNm5akLNNIF4qtz086xJ/pTG3ACDvATUWDRT7QO1T+wK8sm19VCyW0s3D02dA2TLVva3ZENo8cWh8YdY0ZETr2jqfDUxAvqQGsHDnjCsDGYYUU/w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb205a07-f7c5-435b-33a7-08d58d643715
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 06:39:50.1769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1233
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2J6dx41005133

On 3/16/2018 5:16 PM, Herbert Xu wrote:
> On Mon, Mar 05, 2018 at 12:39:45PM +0200, Horia Geantã wrote:
>> Even though it doesn't make too much sense, it is perfectly legal to:
>> - call .init() and then (as many times) .update()
>> - subseqently _not_ call any of .final(), .finup() or .export()
> 
> Actually it makes perfect sense, because there can be an arbitrary
> number of requests for a given tfm.  There is no requirement that
> you must finalise the first request before submitting new ones.
> 
> IOW there can be an arbitrary number of outstanding requests even
> without the user intentionally abandoning any hash request.
> 
The fact that there can be multiple requests in parallel (for a given tfm) is a
different topic.
Each request object has its state in its own state machine, independent from the
other request objects.
I assume this is clear enough.

Why I wanted to underline is that "abandoning" a hash request is allowed (even
though doing this is at least questionable), thus implementations must take
special care not to leak resources in this case.

If you think the commit message should be updated, then probably so should the
documentation update.

Thanks,
Horia

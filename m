Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbeBEIqO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 03:46:14 -0500
Received: from mail-ve1eur01on0051.outbound.protection.outlook.com ([104.47.1.51]:61547
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752195AbeBEIqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 03:46:04 -0500
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: "Auer, Lukas" <lukas.auer@aisec.fraunhofer.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "pure.logic@nexus-software.ie" <pure.logic@nexus-software.ie>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC: Peng Fan <peng.fan@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ryan.harkin@linaro.org" <ryan.harkin@linaro.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "rui.silva@linaro.org" <rui.silva@linaro.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v3 2/5] crypto: caam: Fix endless loop when RNG is already
 initialized
Thread-Topic: [PATCH v3 2/5] crypto: caam: Fix endless loop when RNG is
 already initialized
Thread-Index: AQHTmjdOwMiIynBKwEGhPiBJHBZpZw==
Date: Mon, 5 Feb 2018 08:45:59 +0000
Message-ID: <VI1PR0402MB3342899B009D1A6CC0569CFE98FE0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
References: <1517364040-27607-1-git-send-email-pure.logic@nexus-software.ie>
 <1517364040-27607-3-git-send-email-pure.logic@nexus-software.ie>
 <VI1PR0402MB334297558BB1984131546B1D98FA0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <78ad6a62-190c-e4fe-dd23-e1d058f9bbb2@nexus-software.ie>
 <1517576063.2002.19.camel@aisec.fraunhofer.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3534;7:OB5AzkmhJxX+gR69h/15pbBPiJoTmEPld4rSCAHpyyMykRwoL3D0rjVpObLoezrpGuQkX8wXZ7VmEWgt+fbrJJxakiQ39TQz3+9P82nofsTVRrqrwRDyqOJmeXUzZhOAeAz8lxFRwQYy8CWnwaTicBQquN/FaAkV/SQAHbaAFDa87GF2ve6AwYIyPovfQzTX3qYHCVGrBtc6wBRZMRdhb+42KNhMJ7DmnzWRm8QY/v4N9ovWzXw95T0kqJba9vFH
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39380400002)(39860400002)(366004)(377424004)(189003)(199004)(966005)(5660300001)(14454004)(6506007)(53546011)(66066001)(26005)(102836004)(55016002)(9686003)(6306002)(99286004)(106356001)(110136005)(2906002)(54906003)(186003)(478600001)(7696005)(6246003)(76176011)(3280700002)(53936002)(6436002)(3660700001)(2201001)(25786009)(81166006)(81156014)(8676002)(8936002)(575784001)(59450400001)(5250100002)(2501003)(86362001)(316002)(4326008)(97736004)(6116002)(229853002)(3846002)(105586002)(305945005)(74316002)(2900100001)(33656002)(7736002)(68736007)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3534;H:VI1PR0402MB3342.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 62e465dc-b8aa-4694-8d59-08d56c74e14f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:VI1PR0402MB3534;
x-ms-traffictypediagnostic: VI1PR0402MB3534:
x-microsoft-antispam-prvs: <VI1PR0402MB3534D23CE4FC40111B3D88BC98FE0@VI1PR0402MB3534.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0402MB3534;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3534;
x-forefront-prvs: 0574D4712B
x-microsoft-antispam-message-info: rL8S72nzA7b9/jljGoZb46Tc2DtM05mG7i7EdzotV9tnJyFY0lxLcNAOAZkifoU04hlQmONkbw27nFHmrW6Jyg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e465dc-b8aa-4694-8d59-08d56c74e14f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2018 08:45:59.3480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3534
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w158kI16007295

On 2/2/2018 2:54 PM, Auer, Lukas wrote:
> On Fri, 2018-02-02 at 11:20 +0000, Bryan O'Donoghue wrote:
>> On 01/02/18 12:16, Horia Geantã wrote:
>>> If the loop cannot exit based on value of "ret" != -EAGAIN, then it
>>> means
>>> caam_probe() will eventually fail due to ret == -EAGAIN:
>>> 	if (ret) {
>>> 		dev_err(dev, "failed to instantiate RNG");
>>> 		goto caam_remove;
>>> 	}
>>
>> For me it's an endless loop applying the first two
>>
>> https://patchwork.ozlabs.org/patch/866460/
>> https://patchwork.ozlabs.org/patch/866462/
>>
>> but not this one
>>
>> https://patchwork.ozlabs.org/patch/865890/
>>
[snip]
> 
> I think the problem lies in the instantiate_rng() function. If the
> driver is unable to acquire DEC0 it'll return -ENODEV. This should
> terminate the while loop in the probe function. However, the return
> value is never checked and is instead overwritten with -EAGAIN, causing
> the endless loop.
> 
> This problem only occurs if u-boot instantiates only one of the state
> handles (ent_delay doesn't get incremented) and the kernel runs in non-
> secure mode (DEC0 can't get acquired). Instantiating all state handles
> in u-boot therefore fixes this problem. In addition, the return value
> in instantiate_rng() should be handled correctly by including
> 
> if (ret)
> 	break;
> 
> right after "ret = run_descriptor_deco0(ctrldev, desc, &status);".
> 
Indeed, the error path is incorrect and should be fixed as you mentioned.
I will send a patch replacing this one.
Note that this fixes only the error path, meaning caam_probe() won't go into an
endless loop and instead will return -ENODEV, due to being unable to acquire
control of DECO0.

There are still a few hurdles to cross for CAAM to work in a TZ environment.

For e.g. could you please check / confirm whether DECO0MIDR (DECO0 MID registers
@0xA0, @0xA4) are set such that Linux kernel is allowed to r/w DECO0-related
registers?

Thanks,
Horia

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751768AbeCWIRf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 04:17:35 -0400
Received: from mail-db5eur01on0055.outbound.protection.outlook.com ([104.47.2.55]:11009
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751632AbeCWIRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 04:17:33 -0400
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2] crypto: talitos - fix IPsec cipher in length
Thread-Topic: [PATCH v2] crypto: talitos - fix IPsec cipher in length
Thread-Index: AQHTwcQig/PW1mhiHk6gSxecWtEN7Q==
Date: Fri, 23 Mar 2018 08:17:30 +0000
Message-ID: <AM3PR04MB4524FABE12B33113FF4C2D598A80@AM3PR04MB452.eurprd04.prod.outlook.com>
References: <20180322095701.4563E6F352@po15720vm.idsi0.si.c-s.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1380;7:h7KTLwWQ+fWIkNVVDaaE2bY2ZFLJrnwe8I+O1QW5F9czmjeETGx9G/E65pfw+KrKf5+z3RL2ruqpb4bT4zjgt0FpjCT2yT9jdO/DFKBY57ksH4q6/igK6M6wxtak7Q73H6OaUnTiGNKsgMTtjPLJRUrN/qyMoLSNcvFO/CvDvAxI07T5vHfez7MrT6eiYW6AE6iHxVgemRphNIOZnpDoybvRee/B3ujoB+AISrn2Hh4UsOnw4fBFLGe/Stt3RPur
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 677a6c2e-30fc-421f-a0e4-08d5909685ca
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1380;
x-ms-traffictypediagnostic: AM3PR04MB1380:
x-microsoft-antispam-prvs: <AM3PR04MB13801231315829B926A2D7EB98A80@AM3PR04MB1380.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:AM3PR04MB1380;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1380;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(346002)(39380400002)(39860400002)(189003)(199004)(53546011)(105586002)(446003)(6436002)(66066001)(5250100002)(68736007)(53936002)(6506007)(7696005)(55016002)(9686003)(76176011)(6246003)(106356001)(3660700001)(3280700002)(2906002)(110136005)(54906003)(316002)(33656002)(3846002)(229853002)(99286004)(6116002)(25786009)(186003)(8676002)(97736004)(2900100001)(86362001)(8936002)(102836004)(81166006)(4326008)(81156014)(7736002)(26005)(74316002)(478600001)(305945005)(5660300001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1380;H:AM3PR04MB452.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: sNo3nnpDL7tsJt+Nvv2aqfSELIxNal0PYFMn81p8HAqTM+HOpGvXOV5lpXKBlnlSvnZ0i86tfQR2+6I4US4Td89P+2pfGmiLvoubLxzXIi7GDHn/K3ActMHhlh1orZE3f+RR1X/5RITlq7Yv+32hjQk/+tNr17MfAnsac8dzUx/cD5ilhQjn/d22dJmUMzx8su94tP3jD+qo+hDdOEeiRUOzR4idLHt3oBDBZobjPnr9bg3D4Zkv4ocPaJt3HImmUiwnfN4sa02TLdvhwx4JpoEbhWYQNgfqY2DsXI9bAixnZ/22MIbXrHLfYpumTOuHA3jnhtkKWpXBpJKg3qZebQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677a6c2e-30fc-421f-a0e4-08d5909685ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 08:17:30.5999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1380
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2N8HeNG032549

On 3/22/2018 11:57 AM, Christophe Leroy wrote:
> For SEC 2.x+, cipher in length must contain only the ciphertext length.
          ^^^^ turns out this should be 3.x+

> In case of using hardware ICV checking, the ICV length is provided via
> the "extent" field of the descriptor pointer.
> 
> Cc: <stable@vger.kernel.org> # 4.8+
> Fixes: 549bd8bc5987 ("crypto: talitos - Implement AEAD for SEC1 using HMAC_SNOOP_NO_AFEU")
> Reported-by: Horia Geantã <horia.geanta@nxp.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Tested-by: Horia Geantã <horia.geanta@nxp.com>

Thanks,
Horia

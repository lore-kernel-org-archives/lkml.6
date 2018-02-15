Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755001AbeBOIDk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 03:03:40 -0500
Received: from mail-eopbgr10057.outbound.protection.outlook.com ([40.107.1.57]:11919
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754864AbeBOID3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 03:03:29 -0500
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC: LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH 2/2] crypto: caam: Use common error handling code in four
 functions
Thread-Topic: [PATCH 2/2] crypto: caam: Use common error handling code in four
 functions
Thread-Index: AQHTpcI0b4HOP9UH+0eRDkH/e5usGw==
Date: Thu, 15 Feb 2018 08:03:24 +0000
Message-ID: <VI1PR0402MB3342F9E0700AA3A7CC20D8DC98F40@VI1PR0402MB3342.eurprd04.prod.outlook.com>
References: <9a9a602d-93da-457d-c37d-2acbb4b7b5d5@users.sourceforge.net>
 <3c2905a1-b3a4-be87-618e-8562d3a5d8b4@users.sourceforge.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com;
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3486;7:WftbtBPkZWnSO1QL64hD5JE++emBT9pxu/8JfOCRSDhjE/ZQIf2r0kxUEcZl+Gk134Hkkw8tvSulacg/uRd8d74FyDTmyrEZfdD5tCq9rcxHZoiyM67+2anVamehm+nvTtJ5Ad5hQfcLZD/HDx3gn1DXP31qnNmcg4yHUVRlodtRusvcSTgXaV96GgVU6d+koVnXalZ/f4bQ/zbTpsEVEIarY3qospgo5y/RvlQ5jnMp5Ievv4nrrCvusUgVKQOe
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(81166006)(8676002)(74316002)(8936002)(99286004)(54906003)(76176011)(81156014)(105586002)(3846002)(6246003)(2900100001)(7696005)(106356001)(110136005)(4326008)(53936002)(86362001)(66066001)(9686003)(5660300001)(68736007)(53546011)(478600001)(305945005)(3280700002)(33656002)(6116002)(59450400001)(229853002)(6506007)(6436002)(3660700001)(7736002)(102836004)(2906002)(5250100002)(186003)(55016002)(316002)(97736004)(26005)(2501003)(25786009)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3486;H:VI1PR0402MB3342.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac49cadb-3cbb-4d18-46d9-08d5744a96db
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:VI1PR0402MB3486;
x-ms-traffictypediagnostic: VI1PR0402MB3486:
x-microsoft-antispam-prvs: <VI1PR0402MB34866D5958241041B1063D5198F40@VI1PR0402MB3486.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42262312472803);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231101)(944501161)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0402MB3486;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3486;
x-forefront-prvs: 058441C12A
x-microsoft-antispam-message-info: UocwO443bHnqcLPLPhJ/pJCCv3+m0SbDjSg4NA8Jl2myYvv08PecqhR/A+CsG5H/Zf3wawnOO0d7SckSli6Q6g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac49cadb-3cbb-4d18-46d9-08d5744a96db
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2018 08:03:24.8585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3486
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1F83m55004971

On 2/14/2018 8:32 PM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 14 Feb 2018 19:14:49 +0100
> 
> Add jump targets so that a bit of exception handling can be better reused
> at the end of these functions.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
[snip]
> @@ -1096,6 +1092,7 @@ static int ahash_digest(struct ahash_request *req)
>  	if (!ret) {
>  		ret = -EINPROGRESS;
>  	} else {
> +unmap_hash:
>  		ahash_unmap(jrdev, edesc, req, digestsize);
>  		kfree(edesc);
>  	}
> 
I understand jumps are a necessary evil for dealing with shortcomings of C,
however please avoid jumping in an if/else branch.

Code could be rewritten as:

  	if (!ret)
  		return -EINPROGRESS;

unmap_hash:
  	ahash_unmap(jrdev, edesc, req, digestsize);
  	kfree(edesc);

Thanks,
Horia

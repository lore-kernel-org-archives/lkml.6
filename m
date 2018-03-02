Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428591AbeCBSTa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:19:30 -0500
Received: from mail-ve1eur01on0079.outbound.protection.outlook.com ([104.47.1.79]:10435
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1947147AbeCBST0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:19:26 -0500
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/2] crypto: talitos - don't persistently map
 req_ctx->hw_context and req_ctx->buf
Thread-Topic: [PATCH 1/2] crypto: talitos - don't persistently map
 req_ctx->hw_context and req_ctx->buf
Thread-Index: AQHTslL9KWYftXGUpkyRMe+xwyPmNA==
Date: Fri, 2 Mar 2018 18:19:23 +0000
Message-ID: <VI1PR0402MB3342DC809DACC396FAA21A4698C50@VI1PR0402MB3342.eurprd04.prod.outlook.com>
References: <7c934f0788d60bd82fb1cb51d712c9ab1ea7fcb4.1519660621.git.christophe.leroy@c-s.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1SPR01MB022;6:/0hNuM899pbzpjSeAs4TE0FgPUx//7f/dSf02eV9SVAuw32ZQ3CQxl2MnlDwYW6hcQ0W/cw5cNMxB0J8FweBwcJCfYucw/hmzyoiLA4gJ4fyrkJ5WGIpkVsb5G0azxghaU2RMMuK5NvzgyrmyU+xIlvC8hxWG9BsV+o87ZzuV0IGPbt5lHjuLb9Hv3DiEhtupT7cgUH6lPriuoSBF/7ikmocauppC7/Eamzjm0c/AFnzrB+rS7mXV6MmyurRGYcCAENqF40G4LG4APu16SkhJJUrqu4nEIXrTCrpRgr5v7BzT7jqJrUvUYeBlDEYcP2S3+yQ5FJFwo2Jtrr9miWQQrEO9GT519DagRn1zahwT+gmC4Ez1i+rFt9TAYrN753K;5:WCtUxcreklS8l6UxlhvrstS/i5b221Tv9ceezZZTtj2u10GOSXMSUu7WXhLns6R6+CGdtBqfbz61lnQp5vAn9INgAxyOU3eiA22T1mysLDNKpPoXdDEaAXGqrmuEg8L3mfl3yF8yQAzsZ3XqKfXK8GHAYxlrufwm8V63Qfwt8x0=;24:NrQb+vHm1CavLosUVKOXY4Vn6X8T1gTvrrTjyWmJha7fZekB3Cub2NhzS9aovWF00i1sWAgbV/fO/bKtALU5IAn+Qs3J+ADFFiXX40i4m7s=;7:i2j6gE0q8RbWmRn39o4ZWNUkC5Dy4e3InURwCxXo3BoWQ+KNWyqYI0r/suFvFvqvMajkl6q6bUcw4zqcrQqbCmTgOQv4mCyqaUHlljAniGVfT7oZ4nvqMFCG/+S0+sAO99HjhF9B6Z/CfN6yWWbFv424CUlZbgXdNo7C+6I83mISJ1kkYD/2krNpk4mSnM6I43QV9wLXR19fjfl9b5LxIIwnps2fzRrIyjMaSWRu2qkv81xED/CSM6Vz+4diAFaP
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 891d12cf-44e7-4a61-6d44-08d5806a200d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:VI1SPR01MB022;
x-ms-traffictypediagnostic: VI1SPR01MB022:
x-microsoft-antispam-prvs: <VI1SPR01MB022A6E59122D18D85EEA89298C50@VI1SPR01MB022.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231220)(944501242)(52105095)(6055026)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:VI1SPR01MB022;BCL:0;PCL:0;RULEID:;SRVR:VI1SPR01MB022;
x-forefront-prvs: 05991796DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(199004)(189003)(3846002)(3660700001)(8936002)(2900100001)(5250100002)(105586002)(3280700002)(7696005)(2906002)(99286004)(110136005)(14454004)(33656002)(4326008)(25786009)(6246003)(6436002)(54906003)(229853002)(76176011)(5660300001)(59450400001)(316002)(9686003)(55016002)(6116002)(68736007)(186003)(106356001)(97736004)(53546011)(66066001)(6506007)(81166006)(478600001)(102836004)(26005)(575784001)(8676002)(53936002)(81156014)(305945005)(86362001)(74316002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1SPR01MB022;H:VI1PR0402MB3342.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: cM5+tFYEeyoQO1NsPZmAsp+VfPmwDJpHRtJHIKVh4JnjaPDrJUHAyuiObne//0oXZWhRvKDjr3yWeCwaOWiKMXShvMMUYqLtPDWW2siSI6Zi1gtFk5Le8tkOz9J5VaprP2INAYC8TDZyk/KzC2CEjME3Jj6DCYZ+Rxq5xZtXiqk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891d12cf-44e7-4a61-6d44-08d5806a200d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2018 18:19:23.3870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR01MB022
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w22IJciS012970

On 2/26/2018 6:40 PM, Christophe Leroy wrote:
> Commit 49f9783b0cea ("crypto: talitos - do hw_context DMA mapping
> outside the requests") introduced a persistent dma mapping of
> req_ctx->hw_context
> Commit 37b5e8897eb5 ("crypto: talitos - chain in buffered data for ahash
> on SEC1") introduced a persistent dma mapping of req_ctx->buf
> 
> As there is no destructor for req_ctx (the request context), the
> associated dma handlers where set in ctx (the tfm context). This is
> wrong as several hash operations can run with the same ctx.
> 
> This patch removes this persistent mapping.
> 
> Reported-by: Horia Geanta <horia.geanta@nxp.com>
> Fixes: 49f9783b0cea ("crypto: talitos - do hw_context DMA mapping outside the requests")
> Fixes: 37b5e8897eb5 ("crypto: talitos - chain in buffered data for ahash on SEC1")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Tested-by: Horia Geantã <horia.geanta@nxp.com>

Please add this to 4.15.y -stable tree.

Thanks,
Horia

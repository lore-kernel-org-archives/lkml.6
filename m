Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427611AbeCBR1q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 12:27:46 -0500
Received: from mail-he1eur01on0087.outbound.protection.outlook.com ([104.47.0.87]:5726
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1424524AbeCBR1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 12:27:44 -0500
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 17/18] crypto: talitos - chain in buffered data for ahash
 on SEC1
Thread-Topic: [PATCH 17/18] crypto: talitos - chain in buffered data for ahash
 on SEC1
Thread-Index: AQHTPqPaMzkS6mzIAEu82t8t4tq38A==
Date: Fri, 2 Mar 2018 17:27:41 +0000
Message-ID: <VI1PR0402MB3342BDF9D4E389B4E296A53298C50@VI1PR0402MB3342.eurprd04.prod.outlook.com>
References: <cover.1507284818.git.christophe.leroy@c-s.fr>
 <28d351a973d31d140239c7e7e64999d95a011e8c.1507284818.git.christophe.leroy@c-s.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3822;7:AtsM7o2v2TbihoEs9Po2LkVSLTrirHVTmvHJvTngGp39+T8+1J93w6R0It3GgoQIg30MrioxwpUA85d4CKfAq5VsBXCBGFgsNQAwo6ILe+9vXDl/GZ5UWPqNk1tujj4tVXDYXCOAcUysdyPCfCRj7IDHX3g0S1CqDa0IkX68PlxAV6tVB6fr8B15e7WhEI9A17gdYQl9var+KHT9Go1Xhi/N4x2Dy2VAAis0WEN6xUdM+4jDF5YjxzPqnRt46NSC
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aafc39db-ec50-4fde-4496-08d58062e703
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:VI1PR0402MB3822;
x-ms-traffictypediagnostic: VI1PR0402MB3822:
x-microsoft-antispam-prvs: <VI1PR0402MB3822ACAF4F20A51CA82742D798C50@VI1PR0402MB3822.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501241)(52105095)(10201501046)(3002001)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0402MB3822;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3822;
x-forefront-prvs: 05991796DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(366004)(376002)(346002)(39860400002)(199004)(189003)(110136005)(6436002)(6506007)(68736007)(229853002)(53546011)(8936002)(186003)(97736004)(99286004)(7736002)(14454004)(478600001)(305945005)(8676002)(6246003)(81156014)(81166006)(74316002)(102836004)(53936002)(76176011)(7696005)(106356001)(6116002)(26005)(55016002)(3280700002)(5660300001)(33656002)(3846002)(9686003)(86362001)(105586002)(25786009)(3660700001)(316002)(4326008)(2906002)(66066001)(54906003)(2900100001)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3822;H:VI1PR0402MB3342.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 8+PN+vFxchYaTtAPvfzy4kVxMBqM7x+ZHbkgs7/OizZalUMBRJQCYa+FGPV/ZA2lQX4R9xOvjsCgEpMmAJGxbEl2wnDEzd4MsYUFC8lnXHW2wnuhkY50fHJbIzgUTmDEQ5x2x88KiFRirFn3SwIK+nW7I6sro23n94sbHArlbwM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aafc39db-ec50-4fde-4496-08d58062e703
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2018 17:27:41.2600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3822
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w22HRruP026272

On 10/6/2017 4:05 PM, Christophe Leroy wrote:
[...]
> @@ -1778,6 +1814,36 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
>  	if (is_sec1 && from_talitos_ptr_len(&desc->ptr[3], true) == 0)
>  		talitos_handle_buggy_hash(ctx, edesc, &desc->ptr[3]);
>  
> +	if (is_sec1 && req_ctx->nbuf && length) {
> +		struct talitos_desc *desc2 = desc + 1;
> +		dma_addr_t next_desc;
[...]
> +		next_desc = dma_map_single(dev, &desc2->hdr1, TALITOS_DESC_SIZE,
> +					   DMA_BIDIRECTIONAL);
> +		desc->next_desc = cpu_to_be32(next_desc);
Where is desc->next_desc initialized for the !is_sec1 case?
Memory allocation is done using kmalloc(), and since desc->next_desc is checked
in some cases also for SEC 2.x+, it should be initialized to 0.

Thanks,
Horia

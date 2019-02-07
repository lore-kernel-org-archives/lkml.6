Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4381C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCEC21721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="ke139kK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfBGX3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:29:19 -0500
Received: from mail-eopbgr790135.outbound.protection.outlook.com ([40.107.79.135]:11840
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726650AbfBGX3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7yMLOirbZ4azbEgHr/QWXCxuqufeAiL2J6o5MjcnFI=;
 b=ke139kK4PsLhOm3CZpg6x0kf3h1X9EGUoWy5xXyyydNPZsOyrUyRfENN3mOjy6ex4g7TvCrrVnxTcCi+Usw6si1heIvx82noRGqijjc1oPnbkmPgE0eHDZ17cJbxAX+IySvHi7OynTOGHTOaz5nbmnzW6Vid8qoraIfSP7LWDZs=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1344.namprd22.prod.outlook.com (10.174.162.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Thu, 7 Feb 2019 23:29:14 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Thu, 7 Feb 2019
 23:29:14 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH 01/18] MIPS: lantiq: pass struct device to DMA API
 functions
Thread-Topic: [PATCH 01/18] MIPS: lantiq: pass struct device to DMA API
 functions
Thread-Index: AQHUugtMSEi4XkuS4UKpOJkg4WEy1aXVBcYA
Date:   Thu, 7 Feb 2019 23:29:14 +0000
Message-ID: <20190207232912.wfgejc5c6d6lk5so@pburton-laptop>
References: <20190201084801.10983-1-hch@lst.de>
 <20190201084801.10983-2-hch@lst.de>
In-Reply-To: <20190201084801.10983-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:a03:60::23) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1344;6:2tEPk8CH6CCZnRiICVfwsbDHjsM87Gj8RuRsDc+gx6lIm+EpaF9nPayQvUHoOFQcEfvxtbXxET+QMkBz6lHEWEO1lO+FaMmXUEXu/+lloQFTs3KHhx6FxRiyjKt1oO2Eu2W2f80lTQDn9r8LUDop6eW5v8VTf/p0l+KL3jJWmTWU6tPPSMB5VrZzyhPG9u064uandmLkHs8BQgqy5YkzJovhT1eEKWYeFJ+12WmacMJHW4Sd0FOrNnNVyd9/Ev64iPoljOFRPLVlmy8QMajL7LMJlYbNKnQYz6Q8bVBlK4xDU51kKza3xaclULhcH+lB1j8l6S6rd9BJ+9iPtSYtUaNau+oPqRKlp4a8j+hb7AFdKsmaGSC2p38qtYaMu45PHto3Xh2mGEiUDLiVnoHnSRWJvF0Qdg1BdDJmhWz8HE5Ku3kzSxr6RscRqU4ziYb+wH785GZ12oAvRzJUhRn2kg==;5:oIw+5MdFbZ7zN2qvnobIF5ZpE228FXXB5Lm5LYM32fSxKQtAbkkCUfYjPn0NxAtro4kKhhO00c+g9Aqr1oJ8zlA0tI/yF8jdTo1GbEDe3LFtQlDL8A1sAroctjZ1gv6ipH3FtqNGtoaDQMJLydY6DC71lSy8MlDWr63H3XGLyxNtT6epaKRrqxVB38LgBxPCWZ02A6h0xHZt0uZgHU1tww==;7:JRQrMZyD5Ov54ssBhtT8QHiv3C9uQ8QNmSGKF+3qsKTz9UY/8+8xvwdOY5fpcDWWqh0b84FEVmBwAV5sXwfYAfnxs8AcwJcnz/S+IfeLWrPYpyrINsRBD57VnHxcDUx+IzWvkH0wX3kAIo9rFMcBRQ==
x-ms-office365-filtering-correlation-id: 183ea2fd-112b-44a2-4539-08d68d541209
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1344;
x-ms-traffictypediagnostic: MWHPR2201MB1344:
x-microsoft-antispam-prvs: <MWHPR2201MB13446C0ADABEFF536D011F6EC1680@MWHPR2201MB1344.namprd22.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(376002)(39840400004)(396003)(136003)(346002)(189003)(199004)(33716001)(76176011)(33896004)(217873002)(229853002)(6506007)(4326008)(66066001)(305945005)(6246003)(25786009)(6916009)(386003)(256004)(58126008)(97736004)(68736007)(52116002)(7736002)(102836004)(53936002)(14444005)(99286004)(7416002)(26005)(6486002)(54906003)(6436002)(71200400001)(6116002)(478600001)(316002)(186003)(8936002)(11346002)(8676002)(3846002)(81156014)(81166006)(1076003)(44832011)(4744005)(106356001)(486006)(105586002)(2906002)(14454004)(476003)(42882007)(6512007)(9686003)(446003)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1344;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cAxehm9nKuJ7hjORvPLUtCOvB4hTBatXq7mpzogMexY2Cd/YqG3vOWG/g8JjXgabqdLwb9CP057ZzyN6xyZBC2Wd2P0bfzVd2eNP2JqB9hP969iRl9S8KDQMRC4UfdnGRWKAk7vz8rEklce9NRxaAo4zg0w+EE6K2z/JS4FywIo2RxivqJ2lEPueFXlgGtlubEDaBWxFDucOSGjCncD4oEvrR5m+TSTBJIhZKprkZyHhq89eHMyFeAr+ciceTBfcJjVd9YkC5aUvKGoUO5C8FAhA8ubz4n5U/4ujb0trvdrJT0JBsqiDzolIkyUtQ0Xl9FEQQQSlnZOj0bdlmzAQ8fB3TjOkuMyIznvLKSuEQJOeL+UcgRU+0gAqbzWThgaguY3k5FtchwdKEyM6Y15YRc04g5ALJGujnX6ABblrKLM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F505CEADCDCA13409DACF1CBCB28A5C3@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183ea2fd-112b-44a2-4539-08d68d541209
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 23:29:13.8300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Fri, Feb 01, 2019 at 09:47:44AM +0100, Christoph Hellwig wrote:
> The DMA API generally relies on a struct device to work properly, and
> only barely works without one for legacy reasons.  Pass the easily
> available struct device from the platform_device to remedy this.
>=20
> Also use GFP_KERNEL instead of GFP_ATOMIC as the gfp_t for the memory
> allocation, as we aren't in interrupt context or under a lock.
>=20
> Note that this whole function looks somewhat bogus given that we never
> even look at the returned dma address, and the CPHYSADDR magic on
> a returned noncached mapping looks "interesting".  But I'll leave
> that to people more familiar with the code to sort out.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/mips/lantiq/xway/vmmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Would you like this to go through the MIPS tree or elsewhere? If the
latter:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72986C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E602175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="lcxcW2Ww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfBEXfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:35:37 -0500
Received: from mail-eopbgr810111.outbound.protection.outlook.com ([40.107.81.111]:8291
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727262AbfBEXfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTZ7th25TGUXJ9KGiYCydXeFQHWu5LN+zOVZmmTExzk=;
 b=lcxcW2WwtgSu8sFZGY3uHXXW7czP7LcbtL8zYFM0G5x2l8WNgvyfXjP+CCAqhB5UOUqQSuKvF260g+i+PdIi0imPIsErSOJAasqRvhrkyfoT0ew7iglcN5Ftmmi138iIMXGeWH9IHzhVzS7qoMlN+a3OoCAQdeCDQcjcGkg3TcE=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1757.namprd22.prod.outlook.com (10.164.133.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 5 Feb 2019 23:35:32 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 23:35:32 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Huang Pei <huangpei@loongson.cn>
Subject: Re: linux-next: manual merge of the mips tree with the mips-fixes
 tree
Thread-Topic: linux-next: manual merge of the mips tree with the mips-fixes
 tree
Thread-Index: AQHUvaCmXS9PVv7ALES6ge/1g3lCPqXR27QA
Date:   Tue, 5 Feb 2019 23:35:31 +0000
Message-ID: <20190205233530.tnk6boxzxm7okgcr@pburton-laptop>
References: <20190206091736.73bd95ec@canb.auug.org.au>
In-Reply-To: <20190206091736.73bd95ec@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0042.namprd02.prod.outlook.com
 (2603:10b6:a03:54::19) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1757;6:7oUt+recdYtf+x0S4dKawVCblEz8cfdf7oT678/qggztVGi6nNMEo3Jg1bM4b6385X8QqLK/ZTMSnONTP8um0dmEGYqlaDboJ011S0kAsTjVubvexZJ33+TY9tDSxfwgrTm5oe+DXRVgJnF9d6Gju7ypAPQr/qn0jCvhqhAn/dm294TgbtwZe6Bx9EizJXMPShh5+qAcPw51Q+wCikt6xRLeBICezyFPdBz4RmojqfFy6xar9bVZS3PkoIFApBVx0MxTTqdjryhSgiCtaCGlQg1t4rHAdm4E5fcoHM5rrvwi5wWpMwGfmybfqI16vN8SUsueh5nHi8XCxkizwIcr4dmbaSWocFbDhwNdX2/fvdSwSjEv9xml8cCTQmILfw9LrjMOf2pfAuVWTkhnzQJuM44AEsXWkR8Kt7nr4lY/pSvzL775lcKynWFDFZfIvw75HFFvJpJwWNwUDB7wRmxBwQ==;5:2VEkAciKp0AlMm3fZaTt9qYPIcy5AbQ0ab6ULISuf1kYwPVLdNUbO39/faV3w+1suyV0W2HCdv80cGAue1LyzhYoriKi9ztyEd0DHBgGEoBW5W52WxXuhUajoemLW/AnZ6bEF1uVW6MUtN458Nyqa4yfPKPIkXLJSqVJYq7Hl+EUoGQujaZs8x240akE9C0FmoUj9QFF+0e/deUoWLhWcg==;7:2EDv2rq35zJ6p6Sn10/n8d2jU50gDeo53mwk4SbiIyKCyp6VLTfvUJKmoHxQlaj+n+U2Xd0BNzJgkL7gi/AX9dhLO/OqiJZZt/KalnJWpMtHhfqzXRB08RGmt1fkWTOJ/l658K7yZcPvSbdb5QtJgQ==
x-ms-office365-filtering-correlation-id: 405b2fd5-e7e2-403f-64f5-08d68bc29e3b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1757;
x-ms-traffictypediagnostic: MWHPR2201MB1757:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-microsoft-antispam-prvs: <MWHPR2201MB1757993A4837AD9307B4B9F0C16E0@MWHPR2201MB1757.namprd22.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(7916004)(396003)(39840400004)(366004)(376002)(346002)(136003)(53754006)(189003)(199004)(186003)(99286004)(105586002)(6916009)(6506007)(97736004)(386003)(106356001)(25786009)(52116002)(102836004)(66066001)(33896004)(53936002)(9686003)(26005)(4326008)(68736007)(3846002)(478600001)(6116002)(6512007)(76176011)(14454004)(6246003)(4744005)(6486002)(33716001)(1076003)(229853002)(54906003)(476003)(58126008)(11346002)(2906002)(44832011)(316002)(305945005)(6436002)(7736002)(256004)(71200400001)(446003)(71190400001)(81166006)(81156014)(8676002)(8936002)(42882007)(486006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1757;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dqFRGzPyn0hW3MPGXoHlmrZo7PGP+5H9AwuHMMkrHvnlRbcwKo30xlZ4cf08MJC6o3OsX/lm+UAxK/gpUqIzoTfu/PceGTmzPW3OV/poDbxl4fPByLc08tMGqic5cDjuIauMQwnK/iwJh1ykKWmwCqtvmjurhBiAFPpONwefdKEjAFO2EdjlFU94knBSHwyrW0I505JEGA1MH1CaEd8T8jbStSJeoh05VpDDgbZ5rFjHxyyWIQxBx9RAuZlK0dpe0E4RHulmPnmtXopvgIrhSyfF+TvVzQUCVVxxJkFYunFoVQqkeRJxZoVork7hq4Eb4CjHzsLtHseYPnxEzn8+r89Zvv6Wc/oDamxDDKCVeiocLQnyyq1nO/9g3VnERVKaljxFOmzcFieGrmfIPJCrxhQN2EJJzSbzuUNDj2+T4CI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9799C4E23CC3D34CA24B1F6B8C38B25B@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405b2fd5-e7e2-403f-64f5-08d68bc29e3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 23:35:31.3552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed, Feb 06, 2019 at 09:17:36AM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the mips tree got conflicts in:
>=20
>   arch/mips/include/asm/barrier.h
>   arch/mips/include/asm/pgtable.h
>=20
> between commit:
>=20
>   e02e07e3127d ("MIPS: Loongson: Introduce and use loongson_llsc_mb()")
>=20
> from the mips-fixes tree and commits:
>=20
>   535113896e80 ("MIPS: Add GINVT instruction helpers")
>   82f4f66ddf11 ("MIPS: Remove open-coded cmpxchg() in set_pte()")
>=20
> from the mips tree.
>=20
> I fixed it up (see below and for the latter file, I used the mips tree
> version but wondered if cmpxchg() needs the fixups from the mips-fixes
> tree commit)

Thanks - that looks good.

cmpxchg() doesn't need the added loongson_llsc_mb() barrier that
set_pte() has in mips-fixes because for the affected Loongson 3
configurations the smp_mb__before_llsc() that cmpxchg() already contains
is equivalent (both will emit a "sync 0" instruction).

Thanks,
    Paul

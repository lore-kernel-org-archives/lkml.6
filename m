Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3C1C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D95B20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Zu5XTTQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D95B20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeKHULF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:11:05 -0500
Received: from mail-he1eur01on0072.outbound.protection.outlook.com ([104.47.0.72]:30448
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbeKHULF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0VNTL4NQ6hJoVN+d9PW6vF4xDoIpxgBgN7i+1yQ2UE=;
 b=Zu5XTTQHD3Tmi4H6Yly5XCzgdBbUmkmMILYBjLeKH/iVefOvEueLzFbFjTKzHipmgZTB0Edejcm0IDwh5LdZT22nHYY+3DsEsbLbEHNmSDWDn6F+Ac7xFyfFdZtIDByf0r6o4XiSwNteq8J2S+DLBje0RiaKH42/cCVF/kbSgVs=
Received: from AM6PR08MB3397.eurprd08.prod.outlook.com (20.177.112.222) by
 AM6PR08MB3559.eurprd08.prod.outlook.com (20.177.114.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Thu, 8 Nov 2018 10:35:29 +0000
Received: from AM6PR08MB3397.eurprd08.prod.outlook.com
 ([fe80::19c8:4ac3:f079:622c]) by AM6PR08MB3397.eurprd08.prod.outlook.com
 ([fe80::19c8:4ac3:f079:622c%2]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 10:35:29 +0000
From:   Steve Capper <Steve.Capper@arm.com>
To:     Anshuman Khandual <Anshuman.Khandual@arm.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Punit Agrawal <Punit.Agrawal@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Steven Price <Steven.Price@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH V3 3/5] mm/hugetlb: Enable arch specific huge page size
 support for migration
Thread-Topic: [PATCH V3 3/5] mm/hugetlb: Enable arch specific huge page size
 support for migration
Thread-Index: AQHUatCyEpYRqwMxa0KrvSn2l+Iw4aVFx9mA
Date:   Thu, 8 Nov 2018 10:35:28 +0000
Message-ID: <20181108103517.7uy3rktr4gyrsh6q@capper-debian.cambridge.arm.com>
References: <1540299721-26484-1-git-send-email-anshuman.khandual@arm.com>
 <1540299721-26484-4-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1540299721-26484-4-git-send-email-anshuman.khandual@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20170113 (1.7.2)
x-originating-ip: [217.140.96.140]
x-clientproxiedby: DM5PR18CA0063.namprd18.prod.outlook.com
 (2603:10b6:3:22::25) To AM6PR08MB3397.eurprd08.prod.outlook.com
 (2603:10a6:20b:43::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR08MB3559;6:l6/Wfocgs9g4F/VcxCjFSrqw/Wvk/czh2ivmdMeA9QRammqJ7EknAUKQl9QMXLr15bdVUoHDYPK210PTpcIDmt5FGO1e3mDUUvCawJ9GYn92aWzcrYsAxdcvX7VY8Wnp9okY7KHu/sCWT6mul9k6iRzZ8X3IdOzr4d/3vbERyCZiix+jVSnLe1ORMf5iBAV3OhMoZ0GPVugpe+7rwux3wP+7Md+Ogwax+NQd76Sy4J4YM07cKBzj4O/QDk4iuT8cPUeYBlfvbkr+I+k2fqChMaSuDypHqODMhwWpzBDR39PydcHOSv3QWuByNCdSrQeeUpay288dwN4+TKExKqwiJcbCYHX+6QZXZgFMZmxFg1UfiLFDCN7mDTm0X3RqSou6WFt71hvXFDDu8Aws3Sa9SIco4a4kSv2UxGxxE3NISG3A6uiGxn6jNt/k27s+Q6eV7SLSbhI9qFpGqZfEZs34Gg==;5:vC0Juu/+r0rB6L9OI930TARDfPRklku1OMxR5nI4J7/IjPHPyrxINZl0LgYPU1+EzgEpN2+wS0NAkJnKzJZlDN/a/CUt6kVoBS6ZBKR9H7MrJ+1HBtnnbbx8UDyJqdN3YRZ1MKG27Kic+UV4zKA42EMdP3yWzfwCbrdmzngCyJ4=;7:gxsz9neqIuM7PhW//G1d+rZbMC6kC6KYyUKFeTrIrz9jSxHe69kjYrLcnJAS4VZ+sqPiP335ooXyeyiJ4Ix3pWx2Gd+6gDv9pojuOQxoCOFLj4Ta7KAoKJEs4SV4UMCxTpnk/dzJ2dkeUZgX2CykwA==
x-ms-office365-filtering-correlation-id: 736b94a4-4459-46a0-ed15-08d64565e6d7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3559;
x-ms-traffictypediagnostic: AM6PR08MB3559:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM6PR08MB35598834BAC5881BBBB2807E81C50@AM6PR08MB3559.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231382)(944501410)(52105095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR08MB3559;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3559;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(72206003)(6246003)(256004)(478600001)(14444005)(7736002)(102836004)(6862004)(6436002)(186003)(66066001)(86362001)(68736007)(71190400001)(6512007)(14454004)(386003)(71200400001)(6506007)(316002)(4326008)(26005)(53936002)(52116002)(99286004)(76176011)(2900100001)(305945005)(54906003)(58126008)(3846002)(6116002)(2906002)(6486002)(229853002)(97736004)(5660300001)(1076002)(6636002)(106356001)(81166006)(81156014)(44832011)(25786009)(8936002)(446003)(11346002)(476003)(486006)(105586002)(8676002)(14583001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3559;H:AM6PR08MB3397.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: C2U06gJxWNhdT/9kXs9F6tmyIbquM9DQWKifZgM5lCKIeVfPZeVDOUYK5dvA65hGdCEc1g6+sS6nAahSnilzK2Dctz9HDOr7NJH9/xPVbiEq9FLQfXW8Nj8VKfgnjPB43HgxsBibYYoXoV74s3sxND0fw96TTUT8YKVVy7ND+pDHKHLogGP6uCSmw1v/M+nqTEfVbFBVl0kMBtYGlyoFNcX/JF+ymW7VAA9QV6CDYxR1HAtSmcnuCI97DBAnT+ljuw/xTOKK6pg2GJ0/pjkQ3tmeSldAQgp5wbS2/h4CoJEPqQ67r6sVDMCudFhtHjoRsDke8aombQPdCt5dYZYzk6LbtXNDGp4nMMNqtIjrqb4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D92419021B13244BD11F631F95A7F24@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736b94a4-4459-46a0-ed15-08d64565e6d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 10:35:28.9520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3559
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 06:31:59PM +0530, Anshuman Khandual wrote:
> Architectures like arm64 have HugeTLB page sizes which are different than
> generic sizes at PMD, PUD, PGD level and implemented via contiguous bits.
> At present these special size HugeTLB pages cannot be identified through
> macros like (PMD|PUD|PGDIR)_SHIFT and hence chosen not be migrated.
>=20
> Enabling migration support for these special HugeTLB page sizes along wit=
h
> the generic ones (PMD|PUD|PGD) would require identifying all of them on a
> given platform. A platform specific hook can precisely enumerate all huge
> page sizes supported for migration. Instead of comparing against standard
> huge page orders let hugetlb_migration_support() function call a platform
> hook arch_hugetlb_migration_support(). Default definition for the platfor=
m
> hook maintains existing semantics which checks standard huge page order.
> But an architecture can choose to override the default and provide suppor=
t
> for a comprehensive set of huge page sizes.
>=20
> Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Steve Capper <steve.capper@arm.com>

> ---
>  include/linux/hugetlb.h | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 70bcd89..4cc3871 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -493,18 +493,29 @@ static inline pgoff_t basepage_index(struct page *p=
age)
>  extern int dissolve_free_huge_page(struct page *page);
>  extern int dissolve_free_huge_pages(unsigned long start_pfn,
>  				    unsigned long end_pfn);
> -static inline bool hugepage_migration_supported(struct hstate *h)
> -{
> +
>  #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
> +#ifndef arch_hugetlb_migration_supported
> +static inline bool arch_hugetlb_migration_supported(struct hstate *h)
> +{
>  	if ((huge_page_shift(h) =3D=3D PMD_SHIFT) ||
>  		(huge_page_shift(h) =3D=3D PUD_SHIFT) ||
>  			(huge_page_shift(h) =3D=3D PGDIR_SHIFT))
>  		return true;
>  	else
>  		return false;
> +}
> +#endif
>  #else
> +static inline bool arch_hugetlb_migration_supported(struct hstate *h)
> +{
>  	return false;
> +}
>  #endif
> +
> +static inline bool hugepage_migration_supported(struct hstate *h)
> +{
> +	return arch_hugetlb_migration_supported(h);
>  }
> =20
>  /*
> --=20
> 2.7.4
>=20

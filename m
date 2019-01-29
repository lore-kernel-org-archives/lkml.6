Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94468C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5818E2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LBhnw5Gm";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="c499BOrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfA2HKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:10:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60984 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbfA2HKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:10:42 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0T77dnW010037;
        Mon, 28 Jan 2019 23:10:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=C9+kWoO/O7Z2rw0loZZ2uZECN2U3Wtz9Zgpy7xtargI=;
 b=LBhnw5Gmh8OdQAbSuM9o/EiPXZDCW9qvaHqxZRIUNp1uKmC7uoS1RSsdnHpS1IQw3s48
 qFdmz7413SoZt2/I2GXPtQ30n6zdLx5Fb5maE/q0YEQMe8poNEreLPxtI0yRAQLsV0RM
 w0ZMbNyooklHfrjL0N6E/cGjtr5ahPAXN34= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qaeajgkay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 28 Jan 2019 23:10:18 -0800
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 28 Jan 2019 23:10:18 -0800
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 28 Jan 2019 23:10:17 -0800
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 28 Jan 2019 23:10:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9+kWoO/O7Z2rw0loZZ2uZECN2U3Wtz9Zgpy7xtargI=;
 b=c499BOrC2f0zEHPV3QA8O0/2Slvs56WI2W22tdapFc2SNyAKiF+Lymb/FBVVugjQ7ZU279OeXtV7TfOkyYWSDE5RhivsyEaD9GLZKeVd1NDnNZ0tlg7cG7tZlXZRFWMmfy4mr/9uelmdsJ9KqDgCaWHsecvyLb4WVzgUoJOuEpc=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1136.namprd15.prod.outlook.com (10.175.2.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.19; Tue, 29 Jan 2019 07:10:16 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9%4]) with mapi id 15.20.1558.021; Tue, 29 Jan 2019
 07:10:16 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] perf/x86/intel/uncore: Add Node ID mask
Thread-Topic: [PATCH] perf/x86/intel/uncore: Add Node ID mask
Thread-Index: AQHUtlAjfHCCMp8byUSt+modqZ78eqXF1r2A
Date:   Tue, 29 Jan 2019 07:10:16 +0000
Message-ID: <CDEC00B0-AF34-4F97-AABD-A7FE0E8B7E5F@fb.com>
References: <1548600794-33162-1-git-send-email-kan.liang@linux.intel.com>
In-Reply-To: <1548600794-33162-1-git-send-email-kan.liang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::1:ec49]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1136;20:26kmtLEfgOIvHQl7BRST3SYFfMw+z74+qPmBCgm0uQLUM9ZUpc1y1L1w0OjQjf3IBgTKi1rPapBLWbUdZoFErmlLqs7YGjNkImfrB3AmaBMjgOOEFTp0IZgw1IxdIqwPGaeUfJCSDAjNh8uXkhtsS7Lv6GWAzsRA8EWnwdOYL90=
x-ms-office365-filtering-correlation-id: e232c72d-3ffd-4bef-5ae4-08d685b8d23d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1136;
x-ms-traffictypediagnostic: MWHPR15MB1136:
x-microsoft-antispam-prvs: <MWHPR15MB11367A5D323A5F0D9E828C47B3970@MWHPR15MB1136.namprd15.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(136003)(199004)(189003)(446003)(99286004)(8676002)(11346002)(81166006)(186003)(5640700003)(81156014)(2616005)(82746002)(476003)(71190400001)(71200400001)(46003)(86362001)(102836004)(256004)(486006)(8936002)(76176011)(6116002)(14444005)(54906003)(7736002)(83716004)(6506007)(53546011)(316002)(305945005)(33656002)(2351001)(105586002)(4326008)(6436002)(106356001)(50226002)(57306001)(229853002)(97736004)(68736007)(14454004)(53936002)(36756003)(6512007)(2906002)(2501003)(25786009)(6486002)(478600001)(6246003)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1136;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ToRA5kkS4PnogFB+SyjSWMPEWq2Vi8IALns+lTLiYuug5/+hZVQfNeFST6w4Ymslilnwqb1n5hiKhsxjj5TMsaL2UwK42xUhZyzA1v3JGQU3zDo0Q55pGPs95MkLNnirZTcOCYWAFWqEJ4wv8qf46BDWtMcU/lGirEQF65Ha04RtxUoEfco76mHNMjUuLKoSuX2zZ7fNAU+LgNviIVGhvdOs8gpyv2/8wbpSSNUL/7hzkT9g0uGgj7PDXrOdYWfwL6oXBW59fDPDgFGI2cqyrAIP28KNRypR1k4MLx6Ohiket3ls06NanMuUkiZiIECwJ5JHcfCfIB2CAjhrYIk8fMKREFPvOBusMCRAJvm841Rn+EoNk20r5dZzUyZWH+AkbSs9LnbgIvoFnLCPb8mfpSvJh/cBj06E8x/sezKRuR4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <165A4476D539284E9455C2A990309FC2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e232c72d-3ffd-4bef-5ae4-08d685b8d23d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 07:10:16.5865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1136
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 27, 2019, at 6:53 AM, kan.liang@linux.intel.com wrote:
>=20
> From: Kan Liang <kan.liang@linux.intel.com>
>=20
> Some PCI uncore PMUs cannot be registered on a 8-socket system (HPE
> Superdome Flex).
>=20
> To understand which Socket the PCI uncore PMUs belong to, perf retrieves
> the local Node ID of the uncore device from CPUNODEID(0xC0) of the PCI
> configuration space, and the mapping between Socket ID and Node ID from
> GIDNIDMAP(0xD4). The Socket ID can be calculated accordingly.
> The local Node ID is only available at bit 2:0, but current code doesn't
> mask it. If a BIOS doesn't clear the rest of the bits, a wrong Node ID
> will be fetched.
>=20
> Filter the Node ID by adding a mask.
>=20
> Fixes: 7c94ee2e0917 ("perf/x86: Add Intel Nehalem and Sandy Bridge-EP unc=
ore support")
> Reported-by: Song Liu <songliubraving@fb.com>
> Tested-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: stable@vger.kernel.org

Thanks Kan!

Acked-by: Song Liu <songliubraving@fb.com>


> ---
> arch/x86/events/intel/uncore_snbep.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel=
/uncore_snbep.c
> index c07bee3..b10e043 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -1222,6 +1222,8 @@ static struct pci_driver snbep_uncore_pci_driver =
=3D {
> 	.id_table	=3D snbep_uncore_pci_ids,
> };
>=20
> +#define NODE_ID_MASK	0x7
> +
> /*
>  * build pci bus to socket mapping
>  */
> @@ -1243,7 +1245,7 @@ static int snbep_pci2phy_map_init(int devid, int no=
deid_loc, int idmap_loc, bool
> 		err =3D pci_read_config_dword(ubox_dev, nodeid_loc, &config);
> 		if (err)
> 			break;
> -		nodeid =3D config;
> +		nodeid =3D config & NODE_ID_MASK;
> 		/* get the Node ID mapping */
> 		err =3D pci_read_config_dword(ubox_dev, idmap_loc, &config);
> 		if (err)
> --=20
> 2.7.4
>=20


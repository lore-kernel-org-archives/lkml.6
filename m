Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19147C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1035223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="O5DL7lX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1035223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbeKNIWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:22:33 -0500
Received: from mail-eopbgr770137.outbound.protection.outlook.com ([40.107.77.137]:26271
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbeKNIWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 03:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbUv+UUE1uZ4ABSJq706ynfLG9sIM9VL4/Y2WK3yAeQ=;
 b=O5DL7lX1u21a/Y5kuvMKfRI82vdc3E4d0biev3dLEAYU7JpvCbpur3T29ymogN8eOOh/JlKT9VRhWQmfWNrVtSbOoElxCsXBBawN+tql+lYarGyHxaRZx2DTyoq7ZiszfoPm7sftfTEcvdnFGjnr2AbkoACmKc/Voxi3FUGs8WY=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1350.namprd22.prod.outlook.com (10.171.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Tue, 13 Nov 2018 22:22:17 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23%9]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 22:22:17 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Maksym Kokhan <maksym.kokhan@globallogic.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        Andrii Bordunov <andrew.bordunov@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maksym Kokhan <maksym.kokhan@globallogic.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 1/2] mips: delete duplicated BUILTIN_DTB and LIBFDT
 configs
Thread-Topic: [PATCH v2 1/2] mips: delete duplicated BUILTIN_DTB and LIBFDT
 configs
Thread-Index: AQHUeqlP2hPOmPyUV0i5VQdXZqZRrqVOSVaA
Date:   Tue, 13 Nov 2018 22:22:16 +0000
Message-ID: <CY4PR2201MB12725B9145E49B80801D4AC5C1C20@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <20181112170059.7199-1-maksym.kokhan@globallogic.com>
In-Reply-To: <20181112170059.7199-1-maksym.kokhan@globallogic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:300:115::13) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1350;6:bhet4MK4nnwRbB8z3QACuDngAAxQ4sS9pDFCiJ+e/pHSG5MIaP0k0/SggUQ+TRvklcJd6akmUHMFxkvhlAYLXLmAWgiFTHgrhDzELmN9A35mNGQnudinXtn+p3dRpZrNL9lxNs0dY8TO+hEWpo2t2v84PWd7/55Y46+9VVXDRSyodd9Yjxmqn6xKUG+8QbkpIPU+K9NydunWIst6E+EQUfsRltvQW3fdT8t0Fx9yOgoYweHYLPIXuXJtRoJjv5AnqMDYmWXLPs8lunT68hOLagbm0sENvipW8wakyFsUll59ojMPMe7IV7XlhkBw3Ly5UdTN7c/+2GsKSEqppbb2APJhHNXJxvly6D4bnUBGDJm6B+bCVFZaJGK4FyQrvo0or66T78b2UNzBv9o3JX+Dh+yvt0NSSLccF/TQS6axuJ9GYP5vwIn1OxdPT2oC/aIiO/fncMbdo55Zou2zoW3BJg==;5:0IVikwJ7yBlutKbV5BJGtura1VGaiQ83jkdjAEkX6LoypolqXCbBNj1HDp/jvwN3LYUoLR2uhDfk4pEFkLlYB4Fg4ODRTyupGAE4kPwwvk/5KYyhAi3jLrgL2QU0+td07Kfzg5V8Vwupw46Tmx6brn4Oqi8DLx9V82QdQoXf1o8=;7:gQkVKwojRo92fiH3WlI2JUD5vO4yUY7XoYjlnRRuw5td0XZWOXe+kdvSZdmNHrSmOIJLz0CYAZlb1zaVpdqE6pnDMUaSvCAmOjmB06lDuAg8T1CyOH5ocBCj9FLEAvDOG+/tj8UhdWK4rlhk9pJQtQ==
x-ms-office365-filtering-correlation-id: 05417cc9-930c-4169-97a9-08d649b6780c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1350;
x-ms-traffictypediagnostic: CY4PR2201MB1350:
x-microsoft-antispam-prvs: <CY4PR2201MB13507EAA1F8173E782CB641CC1C20@CY4PR2201MB1350.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(3231382)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:CY4PR2201MB1350;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1350;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39840400004)(366004)(396003)(189003)(199004)(476003)(486006)(446003)(11346002)(42882007)(33656002)(2900100001)(97736004)(25786009)(6246003)(3846002)(6116002)(44832011)(54906003)(316002)(71200400001)(71190400001)(6506007)(102836004)(105586002)(66066001)(106356001)(386003)(186003)(39060400002)(9686003)(7696005)(52116002)(76176011)(508600001)(4326008)(26005)(99286004)(14454004)(55016002)(5660300001)(7736002)(305945005)(81166006)(6436002)(8676002)(8936002)(74316002)(81156014)(68736007)(6916009)(256004)(2906002)(229853002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1350;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eLiHTS1UdFGqsK84D5iup8ln2OiSAuIVbPhl5rD84Q5+X0rb5kNmGyFUc30udIIi+tr9Y/BFSxMZJfQzDFQPw+lvfKbtDpBXk05U5VvGr5rbwj4CGkBoROLGVEoHrq5VXgSRktwMNwjGUCUo3tcb9Mjp6BXpgv31kBoXQwHoaDYoh815Wpg0uF7AqZUzKuMZerFCmI77iN6qw+GrM7zyihehVtPprIC9WujbOY33015OPIV1vgmYna4z2M709Usw7GprIXPXBm5eglTzKr1c7ZPBPcAtRUGbzyjGhmqPWM5UGXcf0PxGq8QhDYCfPy3oayO7JdZWLcoBYD3HyG4ErIYTaSQBAhitTvhhb9vzNm0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05417cc9-930c-4169-97a9-08d649b6780c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 22:22:17.0073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1350
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Maksym Kokhan wrote:
> CONFIG_BUILTIN_DTB and CONFIG_LIBFDT selection is duplicated
> in menu "Machine selection" under MIPS_MALTA.
>=20
> Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
> Signed-off-by: Andrii Bordunov <andrew.bordunov@gmail.com>

Series applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]

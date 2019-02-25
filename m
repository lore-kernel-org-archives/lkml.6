Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89978C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CF32084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="lz53TbDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbfBYTIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:08:35 -0500
Received: from mail-eopbgr720117.outbound.protection.outlook.com ([40.107.72.117]:46832
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726481AbfBYTIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:08:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuPt+8MzAsXQ3ZI/LFXRVgatNJ2EAwOMZtVwVUiy+Q4=;
 b=lz53TbDayeaurX/qh/KX8NqmJbF2MdI6Syu9mOqpEajIOQXL+AFB3p+T/UM3JszeOZILcIEoksX/R/TzoOC2NORNnqujpvgOq+ZLJpkX2Aj+1i1qfPAh6WyRdwT0gQ6RnLqd7V8jzGgk5InXQMOQXDjj7jw37OHFt+h1IGsh7g8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1343.namprd22.prod.outlook.com (10.174.162.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Mon, 25 Feb 2019 19:08:33 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 19:08:33 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2 02/10] MIPS: SGI-IP27: clean up bridge access and
 header  files
Thread-Topic: [PATCH v2 02/10] MIPS: SGI-IP27: clean up bridge access and
 header  files
Thread-Index: AQHUzT2A6xeJyMHFkEigdWkuAMdUaw==
Date:   Mon, 25 Feb 2019 19:08:32 +0000
Message-ID: <MWHPR2201MB12770899534FEE63D4A5A238C17A0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190219155728.19163-3-tbogendoerfer@suse.de>
In-Reply-To: <20190219155728.19163-3-tbogendoerfer@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:40::17) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f33d12d8-cc4b-4db5-7477-08d69b54a28f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1343;
x-ms-traffictypediagnostic: MWHPR2201MB1343:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR2201MB1343;23:iGtrrZgm80atd/RTaxW/qZKzdleOVWml6GAXv?=
 =?iso-8859-1?Q?ZMOq3f0PlvqG06kCyWr6RrsthCFGYEYcO7QLUOzmQAFXRzydVK0A5j0CYz?=
 =?iso-8859-1?Q?lGO4ETlusPUGK8wuIqDNpZvrRN6r6IOrycT/oEBlSlj3t4+v+gxhJ+1iwr?=
 =?iso-8859-1?Q?e02lR3AyC8mahS6+cjJSR3H0fJbh5Ck2z8N69wu7PTMLtlctV888yH9/z0?=
 =?iso-8859-1?Q?XyCjp5d4EWbkOnga/tym9QxCfpXlHEttCvI0JprtcRDETm7fTgLnNZa2dw?=
 =?iso-8859-1?Q?GYG/x8ywNEllP6uLzvYmBw4AvhhluO+DzU2HyUiFpG5dzYB0aO3Xb0fn/N?=
 =?iso-8859-1?Q?gdFms16KmUq1tny2d2srwgrPeRvHZ9DCHemEyP2I+hKfzwy1NOmkeESZfq?=
 =?iso-8859-1?Q?Cw5O38TKfbdqZOhA45Bg+061xNzP1Ve9qjuHZY7UluG08s8wbUbWXhXBhi?=
 =?iso-8859-1?Q?vn7N/5Qx2VOnqinMM8nsZ+gFFSGeht6EjisJT2JukmqsICuJ6urqp7LeoC?=
 =?iso-8859-1?Q?+Km+vlTy1Oz9+NTNyD5UmHLtKem/+LtPmnW+UvkTfGbe2eOG/cFCcHEzop?=
 =?iso-8859-1?Q?2JkdZOapEMXK2lWXrVFdyg7LYEEkP/NU0AzvpDsUB3N/5hG0VcJJE7O17+?=
 =?iso-8859-1?Q?6kKYeIUP2Y1n3JWcHt00hnQHn6shR3lknHxj1+drUqJqJbsCMznrs+cPCx?=
 =?iso-8859-1?Q?/13LufBFj5QR7BAQLlla0q41dIZu94N7sHqA9aHMen+mESEfAiIvLJia9N?=
 =?iso-8859-1?Q?Uw7h721PsZANcYernmbZ6A27yaPP3w+SXFW2IrwQQvJcvzi6DIK3qDliUg?=
 =?iso-8859-1?Q?ZIVv1HHqSEVda1k1ZS9VLn/OVD89Q9rA8FYcxUVdZjInbFfJ2mMaW3AFFf?=
 =?iso-8859-1?Q?d+auxdcmB8ZRBybxBQY1O7MthQt9YXAjhPirEV3fEhWtaTQSUSXMGOrCM1?=
 =?iso-8859-1?Q?ECE4+Xn8mxNi5PQibfdjxVeJm2w954cN/Z37x4bOMEvcNvow1FOeBvc3Nm?=
 =?iso-8859-1?Q?El4lWUFm/S+eDWnhM4Ay3qVF3RIAbOyh+UkAmA28sHoD5TMYSUp4xGz2Zk?=
 =?iso-8859-1?Q?XsrJ0C8nNVyF/nC+cP0e8zgazNvFhiXorZF+Wi187CMdS2uo2bcznFH2Yg?=
 =?iso-8859-1?Q?DdSaOoVbxiPU6mYxy5XNBzK3yOH2LtXeytNkhEZPulhFVSMRr+n3mZ7aKw?=
 =?iso-8859-1?Q?bT3WtNWu7Jn2xCEzsnoO0deAUEsyr1GgJIFo9lVop8jisTNcSEWZh4/V6a?=
 =?iso-8859-1?Q?ivdudwX+D7FJwRQ8/QOkiDi/te7Uas96PWiJdG9LOxpgUYNGX0dupuxa7o?=
 =?iso-8859-1?Q?Qk1zsG26QkogPBDa2dYZKsmG2M1U2LpD/c/ABmRUuuJngpg=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB1343990DF95DFE86FE06FC7FC17A0@MWHPR2201MB1343.namprd22.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(136003)(346002)(39840400004)(199004)(189003)(316002)(33656002)(26005)(6916009)(71190400001)(71200400001)(52116002)(256004)(42882007)(54906003)(55016002)(2906002)(76176011)(99286004)(7696005)(9686003)(6116002)(3846002)(186003)(7736002)(305945005)(102836004)(44832011)(386003)(6506007)(74316002)(486006)(11346002)(476003)(53936002)(446003)(8676002)(106356001)(8936002)(81156014)(81166006)(6246003)(105586002)(66066001)(4744005)(68736007)(25786009)(4326008)(97736004)(229853002)(14454004)(5660300002)(478600001)(52536013)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1343;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CChW4HLFMEevFM83tkUcv8CF19t8ZV9KbW1t7jbScQ/6TCmj6E6dcrell2FcIBf2n8SM2boaxZdbE7LBFueypsFjUjQMmnK04RE+Vqgdt4IhLTAIQDOoAqEHAYRnqCy0HGfuUQjp9inNkW6XP0v8pdQYIBA0eYgvWTWjExEhZFadF7Ugsalx2W1Ex2mrekZldR8+zzwaThse4j6Jt/o0JrgkI/U/6IdBwusmyobGeKkS1rIR8m8c5s3sCaAQFGv9dXpqjU8486ueXWNksciM59Q0IesMpWizn0ulwyECEaGM5eTjXMb4/uA695YCnxZwtqmjCwkCjRCNi9MyTdegXsx0lprwqnbwzIjNO7QfIuMixh1seiSBB0WzHkMzHaMPMC3av0OMk22sOGw+CEAf8WmJW4Sbp53N5xt8DUdUFiY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33d12d8-cc4b-4db5-7477-08d69b54a28f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 19:08:32.5201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thomas Bogendoerfer wrote:
> Introduced bridge_read/bridge_write/bridge_set/bridge_clr for accessing
> bridge register and get rid of volatile declarations. Also removed
> all typedefs from arch/mips/include/asm/pci/bridge.h and cleaned up
> language in arch/mips/pci/ops-bridge.c
>=20
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]

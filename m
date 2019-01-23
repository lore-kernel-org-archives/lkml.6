Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C41C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7D921872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="MrHFzgQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfAWRvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:51:53 -0500
Received: from mail-eopbgr690137.outbound.protection.outlook.com ([40.107.69.137]:35920
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725896AbfAWRvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udE79O/knlfPMo8jYPTXjrL+BPiVCf1qVriiOz7o0Lg=;
 b=MrHFzgQRkRRPCXt17qYs5qBj1PKOwht7+cT/BS6fDE/Iq79nZnZCGvKb9v3gpgEWt2HTYGoiLGxeLxYOFwoavZuaT9rOv9DRbW3bxtK4B+epcwHclU+iSNN/+IL3Eb5TNzuIi9ZFnFfwDr5wBGdwMeTpdgz5S9AgiUS89O5hoZQ=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1710.namprd22.prod.outlook.com (10.164.206.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Wed, 23 Jan 2019 17:51:49 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1558.016; Wed, 23 Jan 2019
 17:51:49 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: remove meaningless generic-(CONFIG_GENERIC_CSUM) +=
  checksum.h
Thread-Topic: [PATCH] MIPS: remove meaningless generic-(CONFIG_GENERIC_CSUM)
 +=  checksum.h
Thread-Index: AQHUs0RQT/WRIwkZS0K0Th09gxIkig==
Date:   Wed, 23 Jan 2019 17:51:49 +0000
Message-ID: <MWHPR2201MB12770174A3C123570B461E79C1990@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <1548038929-11814-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1548038929-11814-1-git-send-email-yamada.masahiro@socionext.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::22) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1710;6:PnLVlv5jMjidBUwC2zRiCzacSKlxwdVuhVLXf70HDUeF2qsPLU9I7lST2V93z+RhX6n1lA92jy7PfWBBewyLcm1pRp3e/0FhPTSzLJI2WakAJr0kTx0+KfDsTN0RSONLErPsLWwH6v/JrYgZHXMqF0mft1S+42jm4ueBhuinQ6l6K96222vGZZ0zUkFOdzVw+EvytKkTaJBd912SJ6QO21LhAZ+eDNNvYtJNqxoPAPJiizQX+3FHUkAIna8C17MRVbOPfWbLVAaWy9oaqxgTSyDlDnzh7Tcy8zJrOPvK6cih1ri6VZUGPG33ASaJyG1zRzxfMQaIqJOb1emjid9ouMQlJKHcVz4ZGDgJE7LHyf1G06ekeOJ9FW3gNY8r+9v5B43o6JvnD/NpuMIWPxari5v+7gW41iUnqv3kDAGWnxypU77oVTgqqD6OvHi8jelamP0sXOoW7ESNx0BQqKDuRg==;5:NTSQnBG6ZZamL+LHYuyVsIOtlA6M/QNVMXXqNj1CiZP5TMXCYs1lol5w0gkkR6zGrHbBtOF2L6egsKxEPL28OmW3l1usWyeQij9oaXWjj2uouKL1YnqUh1jcKgXw7EJ9zoyIy7iJgBGljdnA05zapzeF5wgya4zKvmo3ZU71CEHhqjd5oM+LNaW+2V3NOIEZeS/YV0MYq7pl/bNMAtaCNQ==;7:ygqko/yRZi/E5j9yaeGnqIM69XCQC25XdMbKBFiMl921OiUb+5s9AD8w+6ElPsERjyyWOo0yOIQVc0RdfkRTK5/zYdVJB9XmdCsGlJ9RILqEZSaVBelvjbeN6XHOvjSdb5K1Nc6Q+XMovzXUVJ9hSQ==
x-ms-office365-filtering-correlation-id: b30a9180-dcaf-47a9-9c70-08d6815b733b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1710;
x-ms-traffictypediagnostic: MWHPR2201MB1710:
x-microsoft-antispam-prvs: <MWHPR2201MB17104942C07B0C38C6E19CACC1990@MWHPR2201MB1710.namprd22.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(396003)(366004)(376002)(136003)(189003)(199004)(33656002)(8936002)(68736007)(106356001)(102836004)(386003)(6506007)(54906003)(97736004)(4326008)(6246003)(53936002)(105586002)(486006)(316002)(55016002)(44832011)(478600001)(6436002)(66066001)(71190400001)(71200400001)(6916009)(476003)(52116002)(74316002)(6116002)(446003)(11346002)(229853002)(25786009)(3846002)(2906002)(76176011)(186003)(256004)(9686003)(26005)(81166006)(99286004)(81156014)(305945005)(7736002)(8676002)(7696005)(14454004)(42882007)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1710;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oY5cWeZLHwm5lxJ2d3ZNuORqptdxTAftSFBOvA5nw8w3x+t0L53JEvMKYG9TlQUS+QxaTa0dwlLT3qaQVzkjGMhjrS9eUXQx0VY2VxLscXWpAf9O2sEDaCs47CFVy6fSz9QJh8q6dUJp9zStYL4eu4sKk8S5D3+NPrSEhwSgYvwuk88eLYD7kBhem8fSQ4WGeCX9Uj1Ye3XQBm1w4St/IJSORCqirS69w5YDAftO3hvjpHtPUTkqFlJRt7X+H6HGkuT8w+qfc8LAG9ORMia+76WH4h5W4W2/Vhvyl/QaPS7wiZnltdTh0DPP2EEmt6Xbsd/aXncSxIn5K1nj70rLXDf2AHhZtmzZ6VAGDHDr9QnPZjkcD8R1GAJfn9cs7X5PA/KbbbtkevKV2hlBJK2N6+nxAcUf0EJIDb7WjKgNZI8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30a9180-dcaf-47a9-9c70-08d6815b733b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 17:51:49.4328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1710
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Masahiro Yamada wrote:
> This line is weird in multiple ways.
>=20
> (CONFIG_GENERIC_CSUM) might be a typo of $(CONFIG_GENERIC_CSUM).
>=20
> Even if you add '$' to it, $(CONFIG_GENERIC_CSUM) is never evaluated
> to 'y' because scripts/Makefile.asm-generic does not include
> include/config/auto.conf. So, the asm-generic wrapper of checksum.h
> is never generated.
>=20
> Even if you manage to generate it, it is never included by anyone
> because MIPS has the checkin header with the same file name:
>=20
> arch/mips/include/asm/checksum.h
>=20
> As you see in the top Makefile, the checkin headers are included before
> generated ones.
>=20
> LINUXINCLUDE    :=3D                   -I$(srctree)/arch/$(SRCARCH)/inclu=
de                   -I$(objtree)/arch/$(SRCARCH)/include/generated        =
           ...
>=20
> Commit 4e0748f5beb9 ("MIPS: Use generic checksum functions for MIPS R6")
> already added the asm-generic fallback code in the checkin header:
>=20
> #ifdef CONFIG_GENERIC_CSUM
> #include <asm/generic/checksum.h>
> #else
> ...
> #endif
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]

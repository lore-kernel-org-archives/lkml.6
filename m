Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6647C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6412089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="TvTjAyCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfAURlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:41:12 -0500
Received: from mail-eopbgr810105.outbound.protection.outlook.com ([40.107.81.105]:63994
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726020AbfAURlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A50WbKhjDtu2p+6NUqQLuyv7ZFG0Rd+Fwj77A0tmMwc=;
 b=TvTjAyCybiqVMN57UEUJuz+S7RxXKvaxs7q8DWPzN2p5/9Tc3LoJAO4sTQlHDGinnvwsl8W5SOWBs/lRRhwq6WgWCTHzo+XKJJeBIAwua0ho61DmMoY7V5kJgBLJJKULaMFynhaz5bOFFpmQHjep07HV3k0ULf1akeQX6VMfZes=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1342.namprd22.prod.outlook.com (10.174.162.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Mon, 21 Jan 2019 17:41:08 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 17:41:08 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: remove meaningless generic-(CONFIG_GENERIC_CSUM) +=
 checksum.h
Thread-Topic: [PATCH] MIPS: remove meaningless generic-(CONFIG_GENERIC_CSUM)
 += checksum.h
Thread-Index: AQHUsTPzBeyheRw78kmwimq8c2pb3KW5/pAA
Date:   Mon, 21 Jan 2019 17:41:08 +0000
Message-ID: <20190121174106.6tgokdtlo5f72hdx@pburton-laptop>
References: <1548038929-11814-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1548038929-11814-1-git-send-email-yamada.masahiro@socionext.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::15) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1342;6:pddHqMQYfkotPQa/XgwIENhzho08FaMKGw7l8WlcEYQR4Fh4Y5RF73fGvTii6lRRW5lZAXpnZSkbAnalz9WeNmBUsJiKDgvuhrU65TRyqBtSx742pAvImlKFN5c/nohkMMQAEPFiM9Szhrzslo23KCCGt8pvjFrfyEEytAEvYa0uuqqelCFzZwaLUFq+shfw/JDP7la9ciQwlCgZ+j4LB6E0AE95yvyW9NZXCAp1I6P4iqitzGqqNKc+L3nXTj0VIRru1+IafkQgzaq/gHf1eXB7lf2rlc2Ll3HCJt6jhn0zibW1xXzWscr5Yu7VbXPs6aF/Z8Ayph0tc0vARowXf8w2Y9EB/DLefY138S5OdarW4YLxXVtfbk56svjPcm5Or+4fVaDlnzxeIq0cWAl+iHk2IoTTDe2bp/OO0B8vLSggQqljLXJqqhWiGvxuBU8AArKP4e1CfRQdA+22rLkpWg==;5:izu7K7LSsvMftFHBgF6W7x0XhItnpoq2Dewg91avVXH7zaoGWr1yrwzU+nMYm57qDLxlvsb+9KiIN8uv6ZSvPH1v9JOPcvK5svRLn8cPTYaJLZMses+TK39S8eU3rOHydp2YryANJM5jkK44aJ5KiqmA03w/9a0hmJxnBC1zdWQhHBSZfzHRmYkdhk7iI7o2JhdJIv6XORT8v4iH8J/cFA==;7:sPsNqZLw+lGjMKQrR8mhrId9TWrkMvKhB9UlZJSnXc6iAekZp92xbmnjFJqe47JRRn+oQubcvW81L2/34vFaANh1WjIU8dMiCphGLOBpJ5KOfo62WFmuDI/MWYuySQTeYZ3XRRNsacS9R7LQSjUDeQ==
x-ms-office365-filtering-correlation-id: e34ef511-84db-4871-b80f-08d67fc79ff7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1342;
x-ms-traffictypediagnostic: MWHPR2201MB1342:
x-microsoft-antispam-prvs: <MWHPR2201MB1342AD5A1C0682FD2288CE67C19F0@MWHPR2201MB1342.namprd22.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(376002)(346002)(366004)(136003)(39840400004)(199004)(189003)(66066001)(106356001)(71200400001)(6916009)(71190400001)(7736002)(305945005)(81156014)(81166006)(97736004)(229853002)(8676002)(6486002)(476003)(68736007)(6436002)(42882007)(8936002)(105586002)(14454004)(256004)(99286004)(6512007)(9686003)(2906002)(11346002)(486006)(386003)(6506007)(446003)(33896004)(33716001)(4326008)(44832011)(54906003)(53936002)(76176011)(102836004)(186003)(316002)(478600001)(6116002)(3846002)(26005)(1076003)(58126008)(6246003)(52116002)(25786009)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1342;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gklPA3ML3GTGnJ5tEFbfObIupij/yI3HYeaAXrDp+uQxSNkIgjoYdyyamaKG5EA6QPNK+Cp6a4Tht7AsIq2p4NhgYItxoz7pe2KdbfhML5kJWcD7hEpuC4nOil/oHHYlhk5m8YL1wdJq93rNz6cIpqmeSmtRUrN4rRYklEtsnLNaoaiRzNq+zeiJvrDgCxpTgaOaa+7uDcBVv0PLiusMfGgUCq4GXOmuuSFiIB8AFAPaOOxnUsqLtuIlcBKYOMSQ7m35XSO/LIm2Myt25kMIs5XSCU78/04c9Cg7HQDENUR2MIPGQ2JOv24aL4PzT8PeZBqjauHMtuHJRMPEWGidDuCrKUbNTu02Ui56Xq0F73RNnnDO1WUEArGXhBq2WU9tjzHsZnALOm+DaCPhGbbiC9RmDd0o3nNZS3/JUH10ce4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8A4B56CD14441446ACD2BC76E5F8EE43@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34ef511-84db-4871-b80f-08d67fc79ff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 17:41:07.7984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1342
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Mon, Jan 21, 2019 at 11:48:49AM +0900, Masahiro Yamada wrote:
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
>   arch/mips/include/asm/checksum.h
>=20
> As you see in the top Makefile, the checkin headers are included before
> generated ones.
>=20
>   LINUXINCLUDE    :=3D \
>                   -I$(srctree)/arch/$(SRCARCH)/include \
>                   -I$(objtree)/arch/$(SRCARCH)/include/generated \
>                   ...
>=20
> Commit 4e0748f5beb9 ("MIPS: Use generic checksum functions for MIPS R6")
> already added the asm-generic fallback code in the checkin header:
>=20
>   #ifdef CONFIG_GENERIC_CSUM
>   #include <asm/generic/checksum.h>
>   #else
>     ...
>   #endif
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Good catch. Would you prefer to take this through your kbuild tree or
that I take it through the MIPS tree?

If the former:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

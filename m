Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CD3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F3C20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="kHRZNonG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F3C20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbeK0XbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:31:24 -0500
Received: from mail-eopbgr690089.outbound.protection.outlook.com ([40.107.69.89]:44974
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726407AbeK0XbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOUjouaVuEsqndhoBmp0ceEi5I9hPgcVxNruh258w08=;
 b=kHRZNonGXMxgjGjXN7DblIz4ah4ciCL5AMLbiZpiIWsYnwclXdFETFjia+B7/fyECi0JNqmguOG/pqo3gJKaPH12YbT6TlxAtD0hgE3K1wtnxfE3OA9d+UXbqczoh4xqvmBv1hvUMhPFqptw3O/2peQKuHQG7dSe0JMNzj0uMMY=
Received: from BYAPR07MB4373.namprd07.prod.outlook.com (52.135.224.16) by
 BYAPR07MB4215.namprd07.prod.outlook.com (52.135.223.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.18; Tue, 27 Nov 2018 12:33:30 +0000
Received: from BYAPR07MB4373.namprd07.prod.outlook.com
 ([fe80::db8:4dba:8bb:3f5]) by BYAPR07MB4373.namprd07.prod.outlook.com
 ([fe80::db8:4dba:8bb:3f5%3]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 12:33:30 +0000
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     James Morse <james.morse@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>,
        "Norov, Yuri" <Yuri.Norov@cavium.com>
Subject: Re: [RFC PATCH 00/20] x86/intel_rdt: Start abstraction for a second
 arch
Thread-Topic: [RFC PATCH 00/20] x86/intel_rdt: Start abstraction for a second
 arch
Thread-Index: AQHUhk1nREjU0MREIUChHeEoeu+3Qg==
Date:   Tue, 27 Nov 2018 12:33:30 +0000
Message-ID: <20181127123319.GA24166@yury-thinkpad>
References: <20180824104519.11203-1-james.morse@arm.com>
In-Reply-To: <20180824104519.11203-1-james.morse@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0036.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::49) To BYAPR07MB4373.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [50.233.148.155]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4215;6:ZLXS6TSS7qF76VS6BRR59kEiGsiXlpQdCbGkEIqVctpbXkex2BVfwp78sYD5tBwKovcq4Y1U0FkqsNipsOYrOPm2fVGCEoaSNgLKV8WA8G6zAZvjaU6POh2Ydge0ejRV0OJnMO3pDY9nyoOKqd2Ws1idp/zE6/uPSBt728VojSykKRUw9nPEx93q0jbz8BfJQ8CX+qBk6OZKyGNQ4E8pzph7uixg/ikQoNKnULx/vrVsZzpn8ISUXXWyybpz4AZrajKzeO7zxVLDoBSP+vFMVlweDA8I3l1rZufHTpwiUqAVyh8ef3F7xUm5mDLJ9fsOhUTQbTuWtp+EUzH7Mo9w3LCgf3PhBNbvNWYoYEWpiE3oQCv5rc6U4EbUHS6ogb4nIcs6bD/dNHbBhP5xODKTiQz3JKW2eV/LSSBfXpQmuzvVVPgbfYdhxJ98IZBEfxwOWeb1MnMreI/NCZvXtF0fCg==;5:w4RUqh50uUytlOIPg2mgWPsFMwzRTMNjW4raz7QfSYTzs7Z6ptJ78wW2J5mMQhJH+2n/i+xPWsR9bTC/SLe8RpeD4Y+1F+cnb5nKL7YEP0OugiWnJfEI6q6x/jJlpd9Q+1MD+5yCQ+FawNRHfF550i/vKaYBes4YTS6WmEKnVHA=;7:X2OzwlhEas46qBLdMk30qkB343uieH8slM3eZ/xFh9TOGc9DDw4uw8nSEzbEqBFD3oHb4Fh+Ow4nklt0a/pyEVY7zdsHzjSQn0qOZmo6TZMLOh5mLc1OEZmu/Y6UIBXjLqaVuwI1EXBMvwLT228JyQ==
x-ms-office365-filtering-correlation-id: 24f642b2-cdf1-4188-1a41-08d654648991
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4215;
x-ms-traffictypediagnostic: BYAPR07MB4215:
x-microsoft-antispam-prvs: <BYAPR07MB42156042442BCA687E51CCB1E3D00@BYAPR07MB4215.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(3231443)(944501410)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4215;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4215;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(396003)(39860400002)(346002)(376002)(136003)(199004)(189003)(51874003)(42882007)(11346002)(476003)(217873002)(446003)(26005)(186003)(6436002)(316002)(102836004)(486006)(6116002)(3846002)(386003)(6506007)(305945005)(106356001)(105586002)(14454004)(7416002)(256004)(7736002)(71200400001)(71190400001)(5660300001)(66066001)(72206003)(25786009)(6512007)(52116002)(6246003)(68736007)(99286004)(4326008)(9686003)(76176011)(33896004)(1076002)(53936002)(6916009)(81156014)(229853002)(6486002)(33716001)(8676002)(107886003)(2906002)(97736004)(33656002)(54906003)(81166006)(8936002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4215;H:BYAPR07MB4373.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: D1E0pKjB0BKbXqc2/FFUMfLmveUItiiVp0HxPoL/b/WO4LYy0adN4GciDOcrv5PprN0Pe76bkuEuYYz7ALa3iZYdndoRvW/448+TanaIC+vXBRomN18MMUdPzcYfnKIx2sthwny7F3hr0UBgGHQE7Vys2NZ5pg90jHfTp4Fip6t3KYvGLv5xyXAjAtyq1Wj6E59IotBVKqLiS3494a/T6GZ6h97qwzntnJR0elxgabbJmQvyuy6G1mleupgmnEZ14oqxP+fQLl0mk5XcmgjQRCzX33SefgtGk5BPaNfe1Sljw7vZdZS+RJ9AdNqVgOogFmozFnsFGfoI1dd8dCGN137s3B9R1v4u1esfUk8V00o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D709D149588D604A89AD80DF001889CD@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f642b2-cdf1-4188-1a41-08d654648991
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 12:33:30.6579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, Aug 24, 2018 at 11:44:59AM +0100, James Morse wrote:
> Hi folks,
>=20
> ARM have some upcoming CPU features that are similar to Intel RDT. Resctr=
l
> is the defacto ABI for this sort of thing, but it lives under arch/x86.
>=20
> To get existing software working, we need to make resctrl work with arm64=
.
> This series is the first chunk of that. The aim is to move the filesystem=
/ABI
> parts into /fs/resctrl, and implement a second arch backend.
>=20
>=20
> What are the ARM features?
> Future ARM SoCs may have a feature called MPAM: Memory Partitioning and
> Monitoring. This is an umbrella term like RDT, and covers a range of cont=
rols
> (like CAT) and monitors (like MBM, CMT).
>=20
> This series is almost all about CDP. MPAM has equivalent functionality, b=
ut
> it doesn't need enabling, and doesn't affect the available closids. (I'll
> try and use Intel terms). MPAM expects the equivalent to IA32_PRQ_MSR to
> be configured with an Instruction closid and a Data closid. These are the
> same for no-CDP, and different otherwise. There is no need for them to be
> adjacent.
>=20
> To avoid emulating CDP in arm64's arch code, this series moves all the AB=
I
> parts of the CDP behaviour, (half the closid-space, each having two
> configurations) into the filesystem parts of resctrl. These will eventual=
ly
> be moved to /fs/.
>=20
> MPAMs control and monitor configuration is all memory mapped, the base
> addresses are discovered via firmware tables, so we won't have a table of
> possible resources that just need alloc_enabling.
>=20
> Is this it? No... there are another two series of a similar size that
> abstract the MBM/CMT overflow threads and avoid 'fs' code accessing thing=
s
> that have moved into the 'hw' arch specific struct.
>=20
>=20
> I'm after feedback on the general approach taken here, bugs, as there are
> certainly subtleties I've missed, and any strong-opinions on what should =
be
> arch-specific, and what shouldn't.
>=20
> This series is based on v4.18, and can be retrieved from:
> git://linux-arm.org/linux-jm.git -b mpam/resctrl_rework/rfc_1

Thank you a lot for this work on cache allocation.

We are very interested in enabling CAT on Cavium / Marvell devices.
Could you please share another two series you mentioned above?

Do you have a working ARM64 CAT driver? It will much help us in our
experimenting.

Thanks in advance,
Yury

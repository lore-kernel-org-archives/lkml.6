Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB42C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB022089F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="DmMqDKJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB022089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbeKTHyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:54:43 -0500
Received: from mail-eopbgr690086.outbound.protection.outlook.com ([40.107.69.86]:21728
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725898AbeKTHym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We/UZnoEdNrbMnxHzF7mhcVr7PbIlHuhygAezvTmSUo=;
 b=DmMqDKJ8n6FDy44VycO+/mT8UB5SxKGMHHkuT8LhORvShkfPJem4xyXsbpfIvBcgzuYWiJAFfs6PHYpbWlb00PUWtZVJ4NpRJhtMU1FL5bOq3D2vUrCs4ZQOD4AMl8YLCRXTerZ1nNn0p3zRr2UNs2dRurH4O6nKU5vA8HwxUtI=
Received: from BYAPR07MB4373.namprd07.prod.outlook.com (52.135.224.16) by
 BYAPR07MB5271.namprd07.prod.outlook.com (20.177.124.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Mon, 19 Nov 2018 21:29:01 +0000
Received: from BYAPR07MB4373.namprd07.prod.outlook.com
 ([fe80::98fe:75f8:e8ca:f46d]) by BYAPR07MB4373.namprd07.prod.outlook.com
 ([fe80::98fe:75f8:e8ca:f46d%2]) with mapi id 15.20.1294.048; Mon, 19 Nov 2018
 21:29:01 +0000
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
CC:     Adam Borowski <kilobyte@angband.pl>,
        Alexander Graf <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        "Kapoor, Prasun" <Prasun.Kapoor@cavium.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        "Ellcey, Steve" <Steve.Ellcey@cavium.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
Thread-Topic: [PATCH v9 00/24] ILP32 for ARM64
Thread-Index: AQHT7O6apmdUMTjqyEuLxJG41cI5NKVYw94A
Date:   Mon, 19 Nov 2018 21:29:01 +0000
Message-ID: <20181119212852.GA16961@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0110.eurprd02.prod.outlook.com
 (2603:10a6:7:29::39) To BYAPR07MB4373.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.58.114.41]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5271;6:LfLUi5Zcz8FnI7wXZMrho6xOXhdjCEn+8kM+RJhJY82y11sewoDsg0/ghgzoUlJMwFP1tRaDsI0Y6iPjikgyxyho002c00xC+URChULm13cyDrU01+tYNi4OyfquQlskl7uNnbJH7aBrD0YrBNJ6ijNSU6eyLqyg0VY8QSnJH9QvDiJhw7f0GbKBB5INdLJxABPrYrFK5/67i+tWU0hGA80GGualZd6lfzHW5z6ZX1yWWYxNOAnPxfCQPgDgpNBtbxgzKjVoxedHe5YJGPcOPZdao4BEAaA8ZxdN0lj79CE6rIKMTOPqwFZ8le7y+UCuwbCo7KhEmHe85qsQR9+WuRRhkjxqcUUtO/S9iHPYBR2RT6Aithj4z0hng/gAcatLPY+1NRcROEAkGdCaYBV+RM2zDodY3rVwtfB08PYi6tHhMVnhkfgf6G7tN0QyWF3AZJRponU62V3AQ97GiiNCEg==;5:2TGrGa9Oi9jIScR+ih+T59PcHnTDognBnblmQAImx+kP7GfYblL0HY0MR/HG7D0DtNmwn1ehTZnOZgPmDJh1WxixPtrEw51ZKXDwTuuGI71ibQGgSx7oVVej9rpMKBpFc+rYwUbc1E/Kt5aE7PtSzJxxLPdQzZoNkkLruDbxPRY=;7:DtQ/pOVuqyRiY1wDk6fmfLe8dURBEbI/QYisWAqkzlQdusSRGIDWqP6pbxBerq6Uqnw7SQJipJMfo1sdA3zxBonP/JttOfQp8T6lmrNIk0uW7zznWjVQJJSJD0m/OBcwDWoFzlgqoXaP51sKsUy/rw==
x-ms-office365-filtering-correlation-id: 5fabf606-618d-4a34-0393-08d64e6605aa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5271;
x-ms-traffictypediagnostic: BYAPR07MB5271:
x-microsoft-antispam-prvs: <BYAPR07MB5271AE81520F4B67CC274CEEE3D80@BYAPR07MB5271.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(3231439)(944501410)(4982022)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5271;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5271;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(7916004)(396003)(346002)(376002)(136003)(366004)(39860400002)(53754006)(199004)(189003)(11346002)(446003)(33716001)(6116002)(3846002)(33896004)(386003)(42882007)(6506007)(6306002)(9686003)(106356001)(6512007)(5660300001)(33656002)(486006)(186003)(76176011)(1076002)(2900100001)(26005)(52116002)(14454004)(6246003)(99286004)(6436002)(476003)(102836004)(2906002)(2501003)(8936002)(81156014)(105586002)(478600001)(305945005)(966005)(7736002)(8676002)(256004)(14444005)(81166006)(2201001)(97736004)(53936002)(229853002)(316002)(39060400002)(71200400001)(25786009)(6486002)(7406005)(7416002)(71190400001)(66066001)(72206003)(68736007)(54906003)(110136005)(4326008)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5271;H:BYAPR07MB4373.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hLqx4jO5vZg5ltqHKHCUy03p0HIHcvkNqU2A1eKBNmLLT/bUAHY3MEWUXli+MDzRusdJ5lp93ECW4HQWVeQRVNnxpUyMB54+vDY3wXyIzU6xN9rq6nncozETWKWJ+sCiQFj49t4bM+DeWXVW2ErbRuc6RnQLybPm0j/nOttmVX2he/s5v2SN2k12BdeyL+gecx7o6UudlnhrXGSLEI1l24t/OzAIKx7D7Gv87TyWrzQV9+8NVNzsejgUi7UZdlwzmJ8BlNoVDnXb+chEemJQnNq5naUTU8C9ECXpfKpFaVuWmm48eDVENabGGQlo0EWnGnwA0r98tvAmjDEDrCGgNi2mlR2CcJ7X4DdD8Cy4x54=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EDA80B37E563BB4FBA8648C4DC453712@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fabf606-618d-4a34-0393-08d64e6605aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 21:29:01.5663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Wed, May 16, 2018 at 11:18:45AM +0300, Yury Norov wrote:
> This series enables AARCH64 with ILP32 mode.
>=20
> As supporting work, it introduces ARCH_32BIT_OFF_T configuration
> option that is enabled for existing 32-bit architectures but disabled
> for new arches (so 64-bit off_t userspace type is used by new userspace).
> Also it deprecates getrlimit and setrlimit syscalls prior to prlimit64.
>=20
> Based on kernel v4.16. Tested with LTP, glibc testsuite, trinity, lmbench=
,
> CPUSpec.
>=20
> This series on github:=20
> https://github.com/norov/linux/tree/ilp32-4.16
> Linaro toolchain:
> http://snapshots.linaro.org/components/toolchain/binaries/7.3-2018.04-rc1=
/aarch64-linux-gnu_ilp32/
> Debian repo:
> http://people.linaro.org/~wookey/ilp32/
> OpenSUSE repo:
> https://build.opensuse.org/project/show/devel:ARM:Factory:Contrib:ILP32
>=20
> Changes:
> v3: https://lkml.org/lkml/2014/9/3/704
> v4: https://lkml.org/lkml/2015/4/13/691
> v5: https://lkml.org/lkml/2015/9/29/911
> v6: https://lkml.org/lkml/2016/5/23/661
> v7: https://lkml.org/lkml/2017/1/9/213
> v8: https://lkml.org/lkml/2017/6/19/624
> v9: - rebased on top of v4.16;
>     - signal subsystem reworked to avoid code duplication, as requested
>       by Dave Martin (patches 18 and 20);
>     - new files introduced in series use SPDX notation for license;
>     - linux-api and linux-arch CCed as the series changes kernel ABI;
>     - checkpatch and other minor fixes.
>     - Zhou Chengming's reported-by for patch 2 and signed-off-by for
>       patch 21 removed because his email became invalid. Zhou, please
>       share your new email.

This is the 4.19-based update:
https://github.com/norov/linux/tree/ilp32-4.19

Syscall machinery is rewritten in C in mainline kernel, ILP32 is aligned
with it. The following patches are mostly affected:

arm64: ilp32: introduce ilp32-specific sigframe and ucontext
arm64: signal32: move ilp32 and aarch32 common code to separated file
arm64: signal: share lp64 signal structures and routines to ilp32
arm64: ilp32: introduce syscall table for ILP32
arm64: ilp32: share aarch32 syscall handlers

4.18 branch from Catalin is here:
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=3Dst=
aging/ilp32-4.18

Yury

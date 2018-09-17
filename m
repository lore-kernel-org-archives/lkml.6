Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2832ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A0620867
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="qtym/Rh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A0620867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeIQWp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:45:58 -0400
Received: from mail-eopbgr720105.outbound.protection.outlook.com ([40.107.72.105]:62080
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726795AbeIQWp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vOhViUDDqZ7J903qqO1iW0U960vlS6rfenVKuzoaGs=;
 b=qtym/Rh5GIz5fplI2PzT0tW4h9Rpw9CAsIsrT7ZADCTGlxIlULiO4qHGlICpUGzPtKZu+JiTqDBwaHyQgqSORRkl9IFpPoL3wsp/YQQi82vyJV0Bz7Ee/20StzkbJFd+NMDoBvUxEcF4VcjA1mcRLz/NjZvYvzcAltk+N+5EUdE=
Received: from BYAPR08MB4934.namprd08.prod.outlook.com (20.176.255.143) by
 BYAPR08MB4952.namprd08.prod.outlook.com (20.176.255.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Mon, 17 Sep 2018 17:17:24 +0000
Received: from BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981]) by BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981%5]) with mapi id 15.20.1143.017; Mon, 17 Sep 2018
 17:17:24 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Firoz Khan <firoz.khan@linaro.org>
CC:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?iso-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH 0/3] System call table generation support
Thread-Topic: [PATCH 0/3] System call table generation support
Thread-Index: AQHUTAZndJ66Nr5INkGiO2D9iPvZmKT0vIcA
Date:   Mon, 17 Sep 2018 17:17:23 +0000
Message-ID: <20180917171720.wda5qrl7hyyacmwl@pburton-laptop>
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:404:23::29) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4952;6:caE0P+ERJZc/nLirQzwrkjaBiLnDSM2y4M3T0g9s4FipxF9++GJKcYGDol/dV85WffY3P7co8o3kgDmoqhsqe3FKR+l5LEKLPO7Dnija2gcyvduXnUZPOz7vgY3V8g/W9aKwdUPwsxc/q89QTWoKLE0mK7h813GZb9KjMq2rac6OXH3fqLLFyAdXCPW0mHjFqGz//joamQM4lXXQZStKZYZ1nlipW0pOjWFcPGs2FWjmRky3TGDlCITIM4C4CKhcqzb1kdLmcr0SqjT3s9v8rjKpvoObaCiOCMx4lHjqriKW8b/3nzijQ++yVqZ7rWpbvLwFsoun2HIo3MRUszK/1XwUoGfCz3iHqkwjowgl/crITju2pT1XU8FP4V8tLkITxkC5Mva2INnIvgqiyxjFALanrT8jQkwLF8ZC23hC+yko3SfkWHeVn8nujRrXipPzNT3aRQtdhG/KXWkiu3Xywg==;5:xlzDj7JLvHFzK/hWz9EpFeDgt3iOwBIN6CTQz5IBqDiYk2rlUIdogTHzt1WbQbjv7MuQcsEene8zQd2xwfC5sLs2ALXC6Hkiq5zd/6wdGTRzEts7kB1TUy0KQ9XTfU/1PWNAsef6xlHQ61rR33tRky/tCYVvvCa1TklmQHG+AGw=;7:qM5YxSvZL0zGlRXv30KWEYPjtPafSX08QSsANxyhUTouQrBf7VPOAue3L3r25rKi+xIPzf5N2x9esBY971dBW/k9WzFDG0kIWvpesDGNmIgZjequS79yLsxaLJjzuDhWfha8+gMcnnqbRdvnWo9BUZbUtPDQMcfjflrrwc1w0KzRdVDWCdMlooZ7Tr357Jo/bRXdorA3Ov4fGQT0e5lOBE4HsUXRScszWw7tDk8hFdPJ/Q48booCTp7nJ3YtICww
x-ms-office365-filtering-correlation-id: 27c7ab09-452f-45fe-eb80-08d61cc16eae
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4952;
x-ms-traffictypediagnostic: BYAPR08MB4952:
x-microsoft-antispam-prvs: <BYAPR08MB4952B325C77D5364DFC055F3C11E0@BYAPR08MB4952.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:BYAPR08MB4952;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4952;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(346002)(366004)(396003)(376002)(39830400003)(189003)(199004)(44832011)(5250100002)(486006)(8676002)(58126008)(99286004)(5660300001)(106356001)(42882007)(81166006)(39060400002)(68736007)(54906003)(33716001)(105586002)(476003)(11346002)(2900100001)(446003)(25786009)(6506007)(102836004)(386003)(4326008)(6246003)(2906002)(6916009)(97736004)(53936002)(66066001)(52116002)(6306002)(76176011)(256004)(478600001)(14454004)(305945005)(33896004)(14444005)(8936002)(7416002)(26005)(229853002)(1076002)(3846002)(9686003)(6486002)(6116002)(81156014)(6436002)(6512007)(316002)(7736002)(186003)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4952;H:BYAPR08MB4934.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Wkm9XnrlP5iM7pm0CZpn03L7aSjevjAsf3V10pVwVTN0SKYWMuNO6o9BOUA1xqFDK9EkgKANwMcHMD1GAfiOPr0woUEyo2QqsEJuO1Wouvw1Nwg3+dyUtXCNuqHaH864C/W958R783ZGTKS6VmcAkFNKJbGC7BPHeWNT6hE8EI+FcPecc+8w+3MPDRHG+WnV7gul3K+GVBYz90/rcQJEM7a1p5Wx7HqxsmYI/+LhLECZG4J9G3mQvjkhXWZ8Us+aOjKH/9H6D4bLYxjjxLWi5oNQX4QmV10dV3pjqt22qfS4E/sPTVPitRHA7IbXfeyLAWxu0ODMe/clkmdwD9n9nuhbbCKpH5gQP9q4qqND/0U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <E013BB721669064EBAB7919B20DB00F1@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c7ab09-452f-45fe-eb80-08d61cc16eae
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 17:17:23.9002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4952
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

On Fri, Sep 14, 2018 at 02:08:31PM +0530, Firoz Khan wrote:
> The purpose of this patch series is:
> 1. We can easily add/modify/delete system call by changing entry=20
> in syscall.tbl file. No need to manually edit many files.
>=20
> 2. It is easy to unify the system call implementation across all=20
> the architectures.=20
>=20
> The system call tables are in different format in all architecture=20
> and it will be difficult to manually add or modify the system calls
> in the respective files manually. To make it easy by keeping a script=20
> and which'll generate the header file and syscall table file so this=20
> change will unify them across all architectures.

Interesting :)

I actually started on something similar recently with the goals of
reducing the need to adjust both asm/unistd.h & the syscall entry tables
when adding syscalls, clean up asm/unistd.h a bit & make it
easier/cleaner to add support for nanoMIPS & the P32 ABI.

My branch still needed some work but it's here if you're interested:

    git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git wip-mips-s=
yscalls

    https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/?h=
=3Dwip-mips-syscalls

There are some differences:

  - I'd placed syscall numbers the 3 current MIPS ABIs in one table,
    rather than splitting it up. I can see pros & cons to both though so
    I'm not tied to having a single all-encompassing table.

  - I'd mostly inferred the entry point names from the syscall names,
    only specifying them where they differ. Again I'm not particularly
    tied to this.

  - I'd made asm/unistd.h behave like asm-generic/unistd.h with the
    __SYSCALL() macro, where you generate separate syscall_table_*
    headers. I'm fine with that too.

So I'm pretty happy to go with your series, though I agree with Arnd on
the ABI/file naming & the missing syscalls that were added in the 4.18
cycle. We probably need to provide mipsmt_sys_sched_[gs]etaffinity as
aliases to sys_sched_[gs]etaffinity when CONFIG_MIPS_MT_FPAFF isn't
enabled in order to fix the issue the kbuild test robot reported.

But I'm looking forward to v2 :)

Thanks,
    Paul

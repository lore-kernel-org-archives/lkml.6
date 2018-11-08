Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EB2C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241DC2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="pm0pqHH3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241DC2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeKHPwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 10:52:30 -0500
Received: from mail-co1nam03on0082.outbound.protection.outlook.com ([104.47.40.82]:26879
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbeKHPw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 10:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaHtmJUbQ5/Z909yHGYqu9hS2tgXzox9Rw94yG4rf9Q=;
 b=pm0pqHH34AqXQOgA6QNlmQZeEtqHHSMNxpBdyLN3SVD/OVpfBwRe/zEVUxI04iA2J4CHE+LXa8ZPA8UaK7iJxoJ2TPdeSX+jorh3JJeYYgbMOdD4wBCEmjQFYsh/83UZFTAy593nbtSYkBkHlZlx/avdsH8+tFCoxMDrCATqYi8=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5575.namprd05.prod.outlook.com (20.177.186.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.11; Thu, 8 Nov 2018 06:18:34 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1339.009; Thu, 8 Nov 2018
 06:18:33 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "hpa@zytor.com" <hpa@zytor.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ingo Molnar <mingo@redhat.com>
CC:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v9 02/10] Makefile: Prepare for using macros for inline
 asm
Thread-Topic: [PATCH v9 02/10] Makefile: Prepare for using macros for inline
 asm
Thread-Index: AQHUW2CZ0dZfAolPxUG9hT8O5ZUp5qVDToGAgAAFpACAAAwfgIABcMKAgAAOcACAAAERgIAALpuAgAAB5wCAAI3zgA==
Date:   Thu, 8 Nov 2018 06:18:33 +0000
Message-ID: <3B824A03-AB76-4B34-B1CA-F27C0F1B0575@vmware.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-3-namit@vmware.com>
 <89262174-6f15-6116-e67f-436f7c1bfe99@deltatee.com>
 <6651971B-E3AB-4CDD-868C-2338593F7D83@vmware.com>
 <d0812681-4a8f-8cc4-24ce-d02002ee34d2@deltatee.com>
 <DC1EA50F-FAC3-4750-BCF7-0622D1FB4756@vmware.com>
 <a3902c4c-64b1-9c49-02fb-d5e4c9b04314@deltatee.com>
 <192946CF-8543-4CF5-B2A3-93674FCD07E2@vmware.com>
 <7bc80811-8ab3-d26a-6fb3-b7aeebcfce43@deltatee.com>
 <85B77A64-5FF3-4B82-8A07-E045E259C985@zytor.com>
In-Reply-To: <85B77A64-5FF3-4B82-8A07-E045E259C985@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:647:4580:b719:6043:1dbf:f824:9c37]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5575;20:MyrNDg8Zhl2vKlfNwATkCk+aBEQkwSfzEdTcSMpgUdpM5a8mgScE1vu/BwYi3BbyfxYtJJOdtxyla/P0tIBStUef2COhiJlRYAWWl48qVIETdzLP/NLk7okQaHWMadBKvkfTpSUdKbJgrmavwkpUCr9l7GuDZdr7X4vnETl5FkE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5fb5afad-3304-4620-b533-08d6454202f0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5575;
x-ms-traffictypediagnostic: BYAPR05MB5575:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB5575599920276BB89AC3A30AD0C50@BYAPR05MB5575.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5575;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5575;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(366004)(346002)(189003)(199004)(7736002)(14444005)(33656002)(6486002)(36756003)(6116002)(93886005)(6306002)(7416002)(99286004)(966005)(2501003)(25786009)(6512007)(186003)(305945005)(53936002)(46003)(2906002)(256004)(6246003)(2900100001)(229853002)(97736004)(71190400001)(476003)(446003)(53546011)(478600001)(86362001)(71200400001)(82746002)(6506007)(575784001)(2616005)(45080400002)(6436002)(102836004)(4326008)(83716004)(316002)(76176011)(5660300001)(110136005)(14454004)(54906003)(486006)(8676002)(8936002)(81166006)(68736007)(81156014)(105586002)(11346002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5575;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: adOkQz3pDWRCYoJgAtD905YUkJaSz5h4jkaTxvk4xJhb0/8aiZXuo+s0YeRAAeEpFLnXf+jiGMMU0hHbhAtZJuDfSXH0slRMXCgVF0TEhkDmP39E5/X7awUpS69dvvX1gPDBl27ZTgMbN2cLgtOOOU0EYA1KGv1n3IPUpLkX49rPxu4+IhRcG4xRYzr3JKhNXKIz2cX/sOFlYCWpQtMdI+fW+NKtac5gP0TvbbEW0d6Vfga2keGqtgosTXtieVinXaHLo9oB43qFDD7CtSKH85Sgu1jhr73MhF7GW1/CeB9c5Ms+cbLbn2GphjpOP2ambJ3I0qqq3Rjl5EvkDIyKPqKryHCAK3MKByVOKbQPlPc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0CC1A880DE192E4F8367B16E11070D19@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb5afad-3304-4620-b533-08d6454202f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 06:18:33.3053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5575
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: hpa@zytor.com
Sent: November 7, 2018 at 9:50:28 PM GMT
> To: Logan Gunthorpe <logang@deltatee.com>, Nadav Amit <namit@vmware.com>,=
 Ingo Molnar <mingo@redhat.com>
> Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Sam Rav=
nborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Thomas Gl=
eixner <tglx@linutronix.de>, Linux Kbuild mailing list <linux-kbuild@vger.k=
ernel.org>, Stephen Bates <sbates@raithlin.com>
> Subject: Re: [PATCH v9 02/10] Makefile: Prepare for using macros for inli=
ne asm
>=20
>=20
> On November 7, 2018 1:43:39 PM PST, Logan Gunthorpe <logang@deltatee.com>=
 wrote:
>> On 2018-11-07 11:56 a.m., Nadav Amit wrote:
>>> HPA indicated more than once that this is wrong (and that was indeed
>> my
>>> initial solution), since it is not guaranteed that the compiler would
>> put
>>> the macro assembly before its use.
>>=20
>> Hmm, that's very unfortunate. I don't really understand why the
>> compiler
>> would not put the macro assembly in the same order as it appears in the
>> code and it would be in the correct order there.
>>=20
>> In any case, I've submitted a couple of issues to icecc[1] and
>> distcc[2]
>> to see if they have any ideas about supporting this on their sides.
>>=20
>> Thanks,
>>=20
>> Logan
>>=20
>> [1] https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
ithub.com%2Ficecc%2Ficecream%2Fissues%2F428&amp;data=3D02%7C01%7Cnamit%40vm=
ware.com%7C30ab3751343b49f869ab08d644fb1d8c%7Cb39138ca3cee4b4aa4d6cd83d9dd6=
2f0%7C1%7C0%7C636772242666772528&amp;sdata=3DdXKTR79LkFDQ9IXxYw9XYt0VPFa4MX=
rMUcc86w5uy%2Fk%3D&amp;reserved=3D0
>> [2] https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
ithub.com%2Fdistcc%2Fdistcc%2Fissues%2F312&amp;data=3D02%7C01%7Cnamit%40vmw=
are.com%7C30ab3751343b49f869ab08d644fb1d8c%7Cb39138ca3cee4b4aa4d6cd83d9dd62=
f0%7C1%7C0%7C636772242666772528&amp;sdata=3DXynZ1bFbKAb8V2eoPQbXudEJ%2B%2Bu=
8QA3mM4Sr4E%2FTzWs%3D&amp;reserved=3D0
>=20
> Apparently gcc will treat them like basic blocks and possibly move them a=
round.

Maybe it is possible to break the compilation of each object into two
stages: first, compile the source without assembly, and then take the
generated .s file and assemble it with the .s file of the macros.

Does it sounds as something that may work? I guess it should only be done
when distcc is used.


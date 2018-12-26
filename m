Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEA9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB332171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JUlEx5oz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeLZRPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 12:15:22 -0500
Received: from mail-eopbgr810083.outbound.protection.outlook.com ([40.107.81.83]:12265
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726930AbeLZRPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 12:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4IrV9ztFjcQ/Uei9PBUsRnFyQR+/yhl5tJBcEUGYRU=;
 b=JUlEx5ozQAT8spxUEe1CZ6Tbhl5jXTCeUhlz0zR5CtLaBeEebaf8Fm90GIoza2h4iTBf8q9tN3dEgwTi4NMNuCqNRFQRgaoqVFmiHsAyhsPJMjBO1zP0++t21txYMKbKIDL2cJCZvdjR99R8yKuN8rhr6r+blxW9Dv8K8w+/Qn0=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1242.namprd12.prod.outlook.com (10.168.237.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Wed, 26 Dec 2018 17:14:37 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d834:acdd:3c8c:42ad]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d834:acdd:3c8c:42ad%6]) with mapi id 15.20.1471.019; Wed, 26 Dec 2018
 17:14:37 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Jan Engelhardt <jengelh@inai.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v9 00/13] arch/resctrl: AMD QoS support
Thread-Topic: [PATCH v9 00/13] arch/resctrl: AMD QoS support
Thread-Index: AQHUmu0t+YNKxJRPgUK0jeaapDvMZ6WRRxWA
Date:   Wed, 26 Dec 2018 17:14:37 +0000
Message-ID: <6f3fa819-b126-258b-96c4-44cccb80febd@amd.com>
References: <20181121202811.4492-2-babu.moger@amd.com>
 <nycvar.YFH.7.76.1812231909320.1726@n3.vanv.qr>
In-Reply-To: <nycvar.YFH.7.76.1812231909320.1726@n3.vanv.qr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0016.namprd02.prod.outlook.com
 (2603:10b6:803:2b::26) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1242;20:GYWj2vL+itV2fL9BgIEJg6npq6VVoGx1Iq+siajjhHeEUFvxoGC4XI00PyD7TshV5159YM7E+WPpItQvD4z3TghHo1Y0Uh/l/87UOztTmrzvD02XD2R0Jb9IrtKG/UiAsLXcWoh/RpmHJkq8TYS914OWnVfAfW37nIONpCEGrHuC7VR7b2kiOjnkKk+sYX0NKZ3wutCJ16B5RdG8f8IjlgT3P3R+3R30A9BItmsk/yTbfvqou3ZNhwgrVJe95Psw
x-ms-office365-filtering-correlation-id: 5274e626-1949-4999-e2c6-08d66b559d07
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1242;
x-ms-traffictypediagnostic: DM5PR12MB1242:
x-microsoft-antispam-prvs: <DM5PR12MB12425DAB599D87CF2754DF0095B50@DM5PR12MB1242.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1242;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1242;
x-forefront-prvs: 0898A6E028
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(366004)(13464003)(189003)(199004)(6916009)(71200400001)(256004)(71190400001)(446003)(66066001)(8676002)(81156014)(14454004)(486006)(81166006)(11346002)(478600001)(72206003)(476003)(68736007)(316002)(2616005)(54906003)(31696002)(86362001)(8936002)(229853002)(305945005)(99286004)(97736004)(2906002)(3846002)(26005)(6116002)(102836004)(6506007)(386003)(53546011)(31686004)(186003)(6486002)(36756003)(52116002)(76176011)(53936002)(25786009)(7736002)(7416002)(7406005)(5660300001)(105586002)(6246003)(6512007)(6436002)(4326008)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1242;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eAf1VnA/AgzTD1ZqdpHjDJycy8r2K0w17iOn/E9grBwizkSmrXOIjM0MyDGpl1q+cCM13hlrn6pBPaPFoCRjM8TiflfKVrdaE2Y5CpAKvsbARtWWDp1QLU2bQnXgOMC0Vhs812toVyUddKXGeEr51xZb5gx0obs5/WvcYzAwSwsjtuu2DJMDvC9edpk5PZI+5WipKS+FB8TiDg1fD9KKPzecnqQQnHI3qxpw30jl7CAV+BNqt4Ntgf2bwUus8zVM917i4pOgTKkbaqZZZakjQoJ39iX7tTapNkaaXoYjODdfKQTT2zh174U7gSZdNZhl
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <A669A9218BBF7E4A80820B8A5CFA825A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5274e626-1949-4999-e2c6-08d66b559d07
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2018 17:14:37.3888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1242
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

> -----Original Message-----
> From: Jan Engelhardt <jengelh@inai.de>
> Sent: Sunday, December 23, 2018 12:27 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; corbet@lwn.net;
> fenghua.yu@intel.com; reinette.chatre@intel.com; peterz@infradead.org;
> gregkh@linuxfoundation.org; davem@davemloft.net; akpm@linux-
> foundation.org; hpa@zytor.com; x86@kernel.org;
> mchehab+samsung@kernel.org; arnd@arndb.de;
> kstewart@linuxfoundation.org; pombredanne@nexb.com;
> rafael@kernel.org; kirill.shutemov@linux.intel.com; tony.luck@intel.com;
> qianyue.zj@alibaba-inc.com; xiaochen.shen@intel.com;
> pbonzini@redhat.com; Singh, Brijesh <brijesh.singh@amd.com>; Hurwitz,
> Sherry <sherry.hurwitz@amd.com>; dwmw2@infradead.org; Lendacky,
> Thomas <Thomas.Lendacky@amd.com>; luto@kernel.org; joro@8bytes.org;
> jannh@google.com; vkuznets@redhat.com; rian@alum.mit.edu;
> jpoimboe@redhat.com; linux-kernel@vger.kernel.org; linux-
> doc@vger.kernel.org
> Subject: Re: [PATCH v9 00/13] arch/resctrl: AMD QoS support
>=20
>=20
> On Nov 21 2018 20:28:23, Moger, Babu wrote:
> >
> >This series adds support for AMD64 architectural extensions for
> >Platform Quality of Service.
>=20
> The term "QoS" is already used for net/sched/. It will be bad naming to
> have QoS - and then an AMD QoS / Platform QoS as well. Preexisting,
> decade-old howtos may speak of enabling "QoS", and with the ambiguity,
> the unsuspecting kernel builder apprentice may enable the wrong thing in
> his config.
>=20
> So either the QoS from networking gets correspondingly renamed ("packet
> QoS"?.. or something), or else AMD QoS should be changed.

The QoS name is not visible to the user. This feature is referred as QoS
in AMD documents. But for the kernel user it is called as RESCTRL which we
agreed upon in our earlier discussions. So there is no ambiguity  or
confusion here. Let me know if you have any questions.



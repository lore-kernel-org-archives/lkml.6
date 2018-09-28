Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25243C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70FB21708
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LxSJzfDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70FB21708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbeI1ITB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:19:01 -0400
Received: from mail-cys01nam02on0082.outbound.protection.outlook.com ([104.47.37.82]:23472
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726118AbeI1ITA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTIvRigovthya1mBa79XcbKBZ2+2f/Fy14rHYyzauqE=;
 b=LxSJzfDOpaKDGB3dmNhTS5WAExY9fySiwC1UanagVLdHof7cOem/9HoluH5/IS89nvVQAm+nvZJTMgwx1xip9X7XkqnJlhwsvvQWhQl6zOrOd4zEkBAuwxaAOrsB02rA//GcrWfDxGPejJujm+vX362U/s5iKBZRBK4+WnXMNkA=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1675.namprd12.prod.outlook.com (10.172.40.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.20; Fri, 28 Sep 2018 01:57:38 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::5c18:7df5:fd4b:9de]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::5c18:7df5:fd4b:9de%5]) with mapi id 15.20.1164.024; Fri, 28 Sep 2018
 01:57:38 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "bp@suse.de" <bp@suse.de>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "luto@kernel.org" <luto@kernel.org>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "jannh@google.com" <jannh@google.com>,
        "dima@arista.com" <dima@arista.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 00/10] arch/x86: AMD QoS support
Thread-Topic: [RFC PATCH 00/10] arch/x86: AMD QoS support
Thread-Index: AQHUVDtunpE+5D/HD063flof44uaLaUElN0AgABe+SA=
Date:   Fri, 28 Sep 2018 01:57:38 +0000
Message-ID: <DM5PR12MB24719940B13119E05738DB3495EC0@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <20180924191841.29111-1-babu.moger@amd.com>
 <alpine.DEB.2.21.1809272209160.8118@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809272209160.8118@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-originating-ip: [2600:1700:270:e9d0:f131:5afe:4c22:fe7e]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1675;20:IpHgKyxDdsWaZwQatj94snCWT/ij+d/BGrOeTjpIeLY3VI3elhK1vUX/Cm2lXUYnTOtWBkg+RpFzAKELrUcquXQbKEcApll5HuH8K6Kj2nsTPNUwsTNcWrAuQRT++UIvuTB6nQ3rg21aygejuY+lxijFQ/CMG9OQMVmTf4YoGTzKdCnuxLIzqk4am8HWCbcU9gaV34AclUsBBy4GH/7Tpl3vfVF0pPJ5bGm7F7EEqswIT18OQgZh1niLT30VhvFM
x-ms-office365-filtering-correlation-id: ee6cd22b-e645-44eb-dfdf-08d624e5c4c1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1675;
x-ms-traffictypediagnostic: DM5PR12MB1675:
x-microsoft-antispam-prvs: <DM5PR12MB16758B3FF73BCE06C0D03CD195EC0@DM5PR12MB1675.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(198206253151910)(146755900322472)(211936372134217)(9452136761055)(72170088055959)(269456686620040)(42068640409301)(180628864354917)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:DM5PR12MB1675;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1675;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(366004)(52054003)(199004)(189003)(13464003)(256004)(966005)(2906002)(217873002)(14454004)(53936002)(6246003)(106356001)(4326008)(6116002)(7736002)(7416002)(478600001)(68736007)(305945005)(74316002)(25786009)(54906003)(110136005)(33656002)(316002)(72206003)(105586002)(46003)(99286004)(186003)(6436002)(5660300001)(102836004)(7696005)(6506007)(86362001)(76176011)(55016002)(6306002)(34290500001)(71190400001)(81156014)(2900100001)(11346002)(476003)(8936002)(81166006)(53546011)(5250100002)(229853002)(446003)(8676002)(71200400001)(9686003)(486006)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1675;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: z6SOHysfG9dR/1U+iBj1TUUQ7rrqRnIjP9FstiKcn9CmSfTi6ixyPl2sUTstMwHr/OwIPX+n62Vq2CWkzXeJd/qbcx39iVbP8VXP8BufiK2YNOe0AUt4VzsKEDm72DYKQavqDcEcvqHTTmohd4kQ8clNuHDDb3D5hS6pymvJIPhr5O9+wh9TIHNZicbn2zsSWxBbrx2E/DYKVCorV3I0d2UM6zj1VPkbOkuPdUJtlnXDpaz/XIeal/2FTqlxNC52onf6dH7A+9Wl5cZHgkF5VfUvb9fQ1Bn6ym8AVRNEsJWZFdO5Ro/3SozOyjMHuHRgPoomeW51GgaHgiDLhPeigySU4XTqa0T5blfk/Olsmbo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6cd22b-e645-44eb-dfdf-08d624e5c4c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 01:57:38.5403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,=20

> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Thursday, September 27, 2018 3:14 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mingo@redhat.com; hpa@zytor.com; fenghua.yu@intel.com;
> reinette.chatre@intel.com; vikas.shivappa@linux.intel.com;
> tony.luck@intel.com; x86@kernel.org; peterz@infradead.org;
> pombredanne@nexb.com; gregkh@linuxfoundation.org;
> kstewart@linuxfoundation.org; bp@suse.de; rafael.j.wysocki@intel.com;
> ak@linux.intel.com; kirill.shutemov@linux.intel.com;
> xiaochen.shen@intel.com; colin.king@canonical.com; Hurwitz, Sherry
> <sherry.hurwitz@amd.com>; Lendacky, Thomas
> <Thomas.Lendacky@amd.com>; pbonzini@redhat.com;
> dwmw@amazon.co.uk; luto@kernel.org; jroedel@suse.de;
> jannh@google.com; dima@arista.com; jpoimboe@redhat.com;
> vkuznets@redhat.com; linux-kernel@vger.kernel.org; James Morse
> <james.morse@arm.com>
> Subject: Re: [RFC PATCH 00/10] arch/x86: AMD QoS support
>=20
> Babu,
>=20
> On Mon, 24 Sep 2018, Moger, Babu wrote:
>=20
> > This series adds support for AMD64 architectural extensions for Platfor=
m
> > Quality of Service. These extensions are intended to provide for the
> > monitoring of the usage of certain system resources by one or more
> > processors and for the separate allocation and enforcement of limits on
> > the use of certain system resources by one or more processors.
> >
> > The monitoring and enforcement are not necessarily applied across the
> > entire system, but in general apply to a QOS domain which corresponds t=
o
> > some shared system resource.  The set of resources which are monitored
> and
> > the set for which the enforcement of limits is provided are implementat=
ion
> > dependent. Platform QOS features are implemented on a logical processor
> basis.
> > Therefore, multiple hardware threads of a single physical CPU core may
> have
> > independent resource monitoring and enforcement configurations.
> >
> > AMD's next generation of processors support following QoS sub-features.
> > - L3 Cache allocation enforcement
> > - L3 Cache occupancy monitoring
> > - L3 Code-Data Prioritization support
> > - Memory Bandwidth Enforcement(Allocation)
> >
> > The public specification is still in works. Will add the link when it i=
s
> > available.
> >
> > Obviously, there are multiple ways we can go about these changes. We fe=
lt
> > it is appropriate to rename and re-organize the code little bit before
> > making the functional changes. The first few patches(1-6) renames and
> > re-organizes the sources in preparation. Rest of the patches(7-10) adds
> > support for AMD QoS features.
>=20
> On the first glance this all looks sensible, but there is work in progres=
s
> by James Morse (Cc'ed), who wants to generalize the resctrl filesystem so
> it can be reused by ARM. I just want to make sure that your reorganizatio=
n
> is not colliding or creating duplicate effort.
>=20
> https://lkml.kernel.org/r/20180824104519.11203-1-james.morse@arm.com

Thanks for pointing this out. I have looked thru James patches. It appears =
this series is only a small part of his much bigger change. Don't know the =
timeframe of his overall changes.
I will let him speak on that.  That being said, I don't consider our effort=
s as duplicate. He is touching the resource structures, and trying to separ=
ate arch, non-arch components.
My changes are mostly inside the resource structures(mostly resource handle=
rs) and trying to accommodate minor differences within the architecture.  I=
t will be mostly involve rebase
effort on either side in the end whoever goes first.

James, What are your thoughts?=20

>=20
> Thanks,
>=20
> 	tglx

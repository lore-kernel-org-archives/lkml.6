Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33315C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD6922360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PXYe5925"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD6922360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387407AbeKOCng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:43:36 -0500
Received: from mail-eopbgr730089.outbound.protection.outlook.com ([40.107.73.89]:10320
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727576AbeKOCnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QN18o+ZNUX+qRfb7faYkYIAgETs1z8xou2cxM1+IBs=;
 b=PXYe5925PvyFwFXw6vpFa2PLgJ5SwawNAw67veeL+QaPrt73j2t7DyY/9UvxvdYq5c7rHLlwl7fReOg2536SUCE8HgKAE/jFixxUiRGsGdswZEyEdnQouYul+536+r6+j88afuXxXHMi9m77cP1nxJQoz7DvKqCBs3byl1+s5bo=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1500.namprd12.prod.outlook.com (10.172.39.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.25; Wed, 14 Nov 2018 16:38:57 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 16:38:57 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "Shen, Xiaochen" <xiaochen.shen@intel.com>,
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
Subject: RE: [PATCH v7 11/13] arch/x86: Introduce QOS feature for AMD
Thread-Topic: [PATCH v7 11/13] arch/x86: Introduce QOS feature for AMD
Thread-Index: AQHUeG4qy036y75SdUqlKSLDpRVWZKVORLIAgAE4oVA=
Date:   Wed, 14 Nov 2018 16:38:56 +0000
Message-ID: <DM5PR12MB2471AB9EFDE9E8D7C65C58A295C30@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <20181109205153.14811-1-babu.moger@amd.com>
 <20181109205153.14811-12-babu.moger@amd.com>
 <3E5A0FA7E9CA944F9D5414FEC6C71220985A6664@ORSMSX105.amr.corp.intel.com>
In-Reply-To: <3E5A0FA7E9CA944F9D5414FEC6C71220985A6664@ORSMSX105.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1500;20:AsTh1MTXShlc0Akhi8e36NcOZnDD8l40Qp/CBKRjY617tjqj10u0ZfxMuTGykX9Nhkb0sP9ikZwAG7rfscF2pMnSJA3AyMARA3Pj/GrDD2Tk0hl1oCfWzZpg4n3/juat/xjffUn32edl/jgUkW+XS6jQdD25lhOqegYp+F3ob6ioQfpgwZjfUuLpuj/rHXvBBNszk0e6RWAqcLTGFxoJkFwFlf/p9pPfuH/jQ1zmkES7+zKRo8sVP7HTgTQM5XF8
x-ms-office365-filtering-correlation-id: c8e90261-1ead-4d4d-f48a-08d64a4fac25
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1500;
x-ms-traffictypediagnostic: DM5PR12MB1500:
x-microsoft-antispam-prvs: <DM5PR12MB1500DBBBA737E5044ADAC04395C30@DM5PR12MB1500.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(228905959029699)(211936372134217)(240460790083961)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231410)(944501410)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1500;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1500;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39860400002)(376002)(346002)(13464003)(199004)(189003)(105586002)(6436002)(966005)(53546011)(478600001)(229853002)(33656002)(14454004)(2501003)(72206003)(446003)(81166006)(7696005)(99286004)(81156014)(8676002)(8936002)(6506007)(106356001)(2906002)(2201001)(97736004)(68736007)(476003)(86362001)(5660300001)(54906003)(110136005)(11346002)(76176011)(55016002)(7416002)(66066001)(25786009)(7406005)(4326008)(53936002)(256004)(14444005)(486006)(2900100001)(102836004)(26005)(6306002)(9686003)(305945005)(71190400001)(71200400001)(186003)(3846002)(74316002)(6116002)(316002)(6246003)(7736002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1500;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fWcr4/QWfyCd+nTDjwbXhEuPa8aJZe5CyOQP1sd6hrFqerAS4JVXVataV1To04YMTh2Wj5Dn9Mz6YL4C9vmbKJ/gQUhujX0RD5wP4l6EiM8QVQsL+iMAWTrOwZaOhozFgawNf/L/vCNzoywhTGA3DPmcwHgTkV4bZlkU6FkaKg2rQd0nx7t7eyZ2q7jLXWnF5xAkCNrPywAjoTONWJ2Hk3aRC6bluZ9uh9Ba5PGzc+erxniM3KWrHnNrmvKmOxZmxGTgVbYIMdBsuaB+wEHIqeUT5mCilAp7vxgYo4uMqGv7HI6ozMzBftuzIR/xabJ6a+igRxF6Nm6g1pNW2ZyPJUvuixfh4Nc+zDJ9tE1CW0s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e90261-1ead-4d4d-f48a-08d64a4fac25
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 16:38:56.9203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1500
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fenghua,

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf Of Yu, Fenghua
> Sent: Tuesday, November 13, 2018 3:50 PM
> To: Moger, Babu <Babu.Moger@amd.com>; tglx@linutronix.de;
> mingo@redhat.com; bp@alien8.de; corbet@lwn.net; Chatre, Reinette
> <reinette.chatre@intel.com>; peterz@infradead.org;
> gregkh@linuxfoundation.org; davem@davemloft.net; akpm@linux-
> foundation.org
> Cc: hpa@zytor.com; x86@kernel.org; mchehab+samsung@kernel.org;
> arnd@arndb.de; kstewart@linuxfoundation.org; pombredanne@nexb.com;
> rafael@kernel.org; kirill.shutemov@linux.intel.com; Luck, Tony
> <tony.luck@intel.com>; qianyue.zj@alibaba-inc.com; Shen, Xiaochen
> <xiaochen.shen@intel.com>; pbonzini@redhat.com; Singh, Brijesh
> <brijesh.singh@amd.com>; Hurwitz, Sherry <sherry.hurwitz@amd.com>;
> dwmw2@infradead.org; Lendacky, Thomas <Thomas.Lendacky@amd.com>;
> luto@kernel.org; joro@8bytes.org; jannh@google.com;
> vkuznets@redhat.com; rian@alum.mit.edu; jpoimboe@redhat.com; linux-
> kernel@vger.kernel.org; linux-doc@vger.kernel.org; Yu, Fenghua
> <fenghua.yu@intel.com>
> Subject: RE: [PATCH v7 11/13] arch/x86: Introduce QOS feature for AMD
>=20
> > From: Moger, Babu [mailto:Babu.Moger@amd.com]
> > Subject: [PATCH v7 11/13] arch/x86: Introduce QOS feature for AMD
> > The specification for this feature is available at
> > https://developer.amd.com/wp-content/resources/56375.pdf
>=20
> > +bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r) {
> > +	if (val > r->default_ctrl) {
> > +		rdt_last_cmd_puts("mask out of range\n");
> > +		return false;
> > +	}
>=20
> If val is zero, then this closid cannot allocate any cache line.
>=20
> I'm wondering: does that mean the tasks running with this closid directly
> access memory without cache? Is there any usage for this situation?

I would think any memory access has to happen via cache only.  But
I am not sure about the usage of this situation. Will check on that.
Will post if I get any more information. But I can say that it is
allowed to have mask as zero. Looking at the specs
https://developer.amd.com/wp-content/resources/56375.pdf

The bits which are set in the various L3_MASK_n registers do not have to be
contiguous and may overlap in any desired combination. If an L3_MASK_n
register is programmed with all 0's, that COS will be prevented from alloca=
ting
any lines in the L3 cache. At reset, all L3_MASK_n registers are initialize=
d to all
1's, allowing all processors to use the entire L3 cache accessible to them.

>=20
> Thanks.
>=20
> -Fenghua

Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB014C6787D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 01:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB3F2088F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 01:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gdmtGmS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB3F2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbeJHIba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 04:31:30 -0400
Received: from mail-by2nam01on0047.outbound.protection.outlook.com ([104.47.34.47]:32822
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725760AbeJHIba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 04:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyV+13prC1rJpPjIO9+JHML9ieXIJV3MFVwE4elQMCI=;
 b=gdmtGmS2eke58vfYN7SJp8ScMmkLAY3NtPkI39xeaRBtr6X6E6vWeiH7tRsClB92WGqZ2HzRWVfvARRy8cv6m7cxxD4CV5ve/f6uq9r+TBxKt4fhZBA8lP4bIuMzxHN4SxK7rzDvREI4zX3pioHMRzTEjZOPS4hHEkqpCaUA1n0=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1178.namprd12.prod.outlook.com (10.168.236.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Mon, 8 Oct 2018 01:22:12 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%2]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 01:22:12 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
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
Subject: RE: [PATCH v2 05/11] arch/x86: Introduce a new config parameter
 PLATFORM_QOS
Thread-Topic: [PATCH v2 05/11] arch/x86: Introduce a new config parameter
 PLATFORM_QOS
Thread-Index: AQHUXO3NYiuml7rHkUCNdHQ4oovnFKURT04AgANAvyA=
Date:   Mon, 8 Oct 2018 01:22:12 +0000
Message-ID: <DM5PR12MB2471108DA79E7DFF8E206E3F95E60@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <20181005205512.29545-1-babu.moger@amd.com>
 <20181005205512.29545-6-babu.moger@amd.com>
 <20181005233856.GB107301@romley-ivt3.sc.intel.com>
In-Reply-To: <20181005233856.GB107301@romley-ivt3.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-originating-ip: [::]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1178;20:t8tNs8BrzO9cYA0B9FPEJd01E824u7fcKmDpqUEmeWvZJZJ7wwLaGmeJO81x74Oie0YYiAfQOIiY8og4THvvQXSuNIPlegYQ6CzZlLTWB4S6SfGt8MBHf/hyr9LO9f1j3Lz1D2WmA3kgWBkjruQIBtbr75A411SZTB6z2dvBqBhxlRRS/aZUx5x4NTGew2fb8Ka6H7691NG7Hm82rBWArrOfum+kILAhzIKdfKxd6C3oSHbiAZm8Wf63Q7wFL108
x-ms-office365-filtering-correlation-id: ca3cb839-cf87-4b60-ebea-08d62cbc7971
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1178;
x-ms-traffictypediagnostic: DM5PR12MB1178:
x-microsoft-antispam-prvs: <DM5PR12MB11784DD42200FB5726F83C0795E60@DM5PR12MB1178.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(180628864354917)(198206253151910)(146755900322472)(211936372134217)(9452136761055)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051);SRVR:DM5PR12MB1178;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1178;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(366004)(346002)(39860400002)(13464003)(199004)(189003)(74316002)(316002)(53936002)(81166006)(81156014)(8676002)(76176011)(2906002)(55016002)(33656002)(106356001)(105586002)(7736002)(305945005)(9686003)(478600001)(6116002)(72206003)(7696005)(7416002)(6246003)(71190400001)(14444005)(71200400001)(256004)(14454004)(229853002)(476003)(25786009)(5250100002)(2900100001)(186003)(6916009)(53546011)(11346002)(446003)(6506007)(99286004)(4326008)(54906003)(102836004)(97736004)(6436002)(8936002)(5660300001)(486006)(68736007)(575784001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1178;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AUem3STPVQksoQbAxuBprTDtK6M7/e3eSdnLkjC33dsUHoNa0vrJXTCvp2j9aJ7XtSz6p0cPFyBZh616pK2NjXj4lNxC71N/cSvSkBqYehtl2fmynxPG3yZVsGTksUmsSkF25M37yZomS1zFcjzV9ZDkFmjMI9QjPGc0XxUqRLwW+r12p2r8+81WiOez+d0tsX3XtPcLQ+57NFkzwtGW60gHfL2lBC5UbTjnjC5+yOD0WbTcVOFJJ1nKgCEwzAfDjr0WH0HSVKNglHV9go5YtMUsnin3mLAMCQ3DjZO7D712Ac3DPpfeldiSa1yM8jtq/K3Uk2BQbW55kFK8VrcpDV2JHPXQHDOgZufneC9S2P4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3cb839-cf87-4b60-ebea-08d62cbc7971
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 01:22:12.0924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

> -----Original Message-----
> From: Fenghua Yu <fenghua.yu@intel.com>
> Sent: Friday, October 5, 2018 6:39 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com;
> reinette.chatre@intel.com; fenghua.yu@intel.com; james.morse@arm.com;
> vikas.shivappa@linux.intel.com; tony.luck@intel.com; x86@kernel.org;
> peterz@infradead.org; pombredanne@nexb.com;
> gregkh@linuxfoundation.org; kstewart@linuxfoundation.org; bp@suse.de;
> rafael.j.wysocki@intel.com; ak@linux.intel.com;
> kirill.shutemov@linux.intel.com; xiaochen.shen@intel.com;
> colin.king@canonical.com; Hurwitz, Sherry <sherry.hurwitz@amd.com>;
> Lendacky, Thomas <Thomas.Lendacky@amd.com>; pbonzini@redhat.com;
> dwmw@amazon.co.uk; luto@kernel.org; jroedel@suse.de;
> jannh@google.com; dima@arista.com; jpoimboe@redhat.com;
> vkuznets@redhat.com; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 05/11] arch/x86: Introduce a new config parameter
> PLATFORM_QOS
>=20
> On Fri, Oct 05, 2018 at 08:55:52PM +0000, Moger, Babu wrote:
> > Introduces a new config parameter PLATFORM_QOS.
> >
> > This will be used as a common config parameter for both Intel and AMD.
> > Each vendor will have their own config parameter to enable RDT feature.
> > One for Intel(INTEL_RDT) and one for AMD(AMD_QOS). It can be enabled
> or
> > disabled separately. The new parameter PLATFORM_QOS will be
> dependent
> > on INTEL_RDT or AMD_QOS.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  arch/x86/Kconfig | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 1a0be022f91d..7f2da780a327 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -458,6 +458,10 @@ config INTEL_RDT
> >
> >  	  Say N if unsure.
> >
> > +config PLATFORM_QOS
> > +	def_bool y
> > +	depends on X86 && INTEL_RDT
> > +
>=20
> Can change "PLATFORM_QOS" to a more neutral name "RESCTRL"?

Yes. Will change it.
>=20
> Thanks.
>=20
> -Fenghua

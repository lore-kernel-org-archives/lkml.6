Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770BEC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1098E20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ssI7eQiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1098E20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeKAX7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:59:01 -0400
Received: from mail-eopbgr820075.outbound.protection.outlook.com ([40.107.82.75]:63843
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728264AbeKAX7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhEssFhzouYVPLnEBOuginI/jozcK1sLoafArqM8Mpg=;
 b=ssI7eQiPQvpPc/1LDnCnyM4i+7CVYOtgZBNCByUd9Zn4r6sLhj2TDE4L9XbiepEEjd2I06zUvmXCb44PXBcygATNJaQbze0wUqVTDT1ytc6taSv667kJPnZEDIudjvVAnptmFD3NMezTfgSJbq2t1gTUyiuDoMZGlVxtBFSnVpQ=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2549.namprd12.prod.outlook.com (52.132.141.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.25; Thu, 1 Nov 2018 14:55:36 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%3]) with mapi id 15.20.1273.027; Thu, 1 Nov 2018
 14:55:36 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
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
Subject: RE: [PATCH v5 00/13] arch/x86: AMD QoS support
Thread-Topic: [PATCH v5 00/13] arch/x86: AMD QoS support
Thread-Index: AQHUZzUuNvwvLZwExEq0GgZvZL3+EKU5+mgAgAEdDoA=
Date:   Thu, 1 Nov 2018 14:55:36 +0000
Message-ID: <f04c1409-dd6c-15c0-4fea-e448e614aab9@amd.com>
References: <20181018225124.23043-1-babu.moger@amd.com>
 <20181031215517.GA173982@romley-ivt3.sc.intel.com>
In-Reply-To: <20181031215517.GA173982@romley-ivt3.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0106.namprd12.prod.outlook.com
 (2603:10b6:802:21::41) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2549;20:Kg5Yiof+faQhj4rWVE8AtZBqA7Kk1HtHF6KILc8dLEoi5LEsqNwYs4OYd1LiGEh9E96tlxGMxvuaj47ZaJC7B6K6VIaiOFIb8F5JhWirMDN66E/kB0MOfWeJXoN6GHAqbjQXJ6Ia0O8+MXjdma8gASGyfGIY0NgU2Q9PgV5X33jySYOUb89zM72giJvIoGcTccX3utcc+yHPp0zKvzOxDAdzhfCMtvO9G05Rfv9mm2Z7JeXAvIy3Nk9MkwATwHCf
x-ms-office365-filtering-correlation-id: b26e580a-5cc2-4464-9f66-08d6400a14e7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2549;
x-ms-traffictypediagnostic: DM5PR12MB2549:
x-microsoft-antispam-prvs: <DM5PR12MB2549EE734D712BAA6A38C60D95CE0@DM5PR12MB2549.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(228905959029699)(211936372134217)(240460790083961)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB2549;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2549;
x-forefront-prvs: 0843C17679
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(366004)(13464003)(199004)(189003)(53546011)(86362001)(6512007)(36756003)(102836004)(6506007)(6916009)(31696002)(6116002)(186003)(2906002)(3846002)(71190400001)(71200400001)(97736004)(81166006)(66066001)(229853002)(26005)(386003)(6436002)(53936002)(52116002)(316002)(25786009)(99286004)(76176011)(305945005)(54906003)(6246003)(7736002)(4326008)(6486002)(5250100002)(8676002)(2616005)(476003)(486006)(256004)(14444005)(7416002)(72206003)(7406005)(478600001)(68736007)(14454004)(5660300001)(81156014)(8936002)(31686004)(106356001)(446003)(11346002)(2900100001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2549;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OvQl4ftanTIq2qshK1To2WrAq+j64IP1x0qQHQfLHUnBL8YqTIKY4v2wUZJZGHQVii+7x26XQeEiOCSW0g6HwFXI8Nob/Xk4k8cGVbp/1sRlxklcWfP2ns6M1E7l8tzIIWWIDm7vdN+hAWUCyjiaHsSoFPzgwhNNxEtBgoP7ekYxLwME+VnlfEGRGcVjvQft56pND50K6YWmTOCQpWQtR/DxLLSVWX86UasM94X+zP2i3Zk7hJcLft3OTqts/W41H+eioQeBeeaeIapcmenzNAb0DNDSiwt/e/8ska87JZTi0kt0izCelvOBiNvT5Oo3qfJPrfRJFOgMgZHCRtsWhWhuY/kRMPC/ziSzOJ8uCkw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <8861E278F88C17408079011BFE4B745A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26e580a-5cc2-4464-9f66-08d6400a14e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2018 14:55:36.8297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2549
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fenghua,

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf Of Fenghua Yu
> Sent: Wednesday, October 31, 2018 4:55 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; corbet@lwn.net;
> reinette.chatre@intel.com; peterz@infradead.org;
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
> Subject: Re: [PATCH v5 00/13] arch/x86: AMD QoS support
>=20
> On Thu, Oct 18, 2018 at 10:52:00PM +0000, Moger, Babu wrote:
> > Changes from v4 -> v5:
> >  b. The functions update_mba_bw and set_mba_sc is not required for
> AMD.
> >     Removed all the changes related to these functions.
>=20
> Hi, Babu,
>=20
> In v4, you says AMD won't support MBA software controller.
>=20
> In v5, does AMD support MBA software controller or not? The v5 patches

No, AMD does not support MBA software controller. set_mba_sc will always
return -EINVAL on AMD(because delay_linear is set false). That is the
reason, I did not add this check. I will add this check in next refresh.
Will add Suggested-by you. Thanks

> show the feature is supported now. If that's a code bug, you may need
> the following patch?
>=20
> x86/resctrl: Only Intel RDT supports MBA software controller
>=20
> AMD doesn't support the feature.
>=20
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl_rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl_rdtgroup.c
> index 8b6b4a8bb7ca..89dd9b7c9dd7 100644
> --- a/arch/x86/kernel/cpu/resctrl_rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl_rdtgroup.c
> @@ -1878,9 +1878,11 @@ static int parse_rdtgroupfs_options(char *data)
>  			if (ret)
>  				goto out;
>  		} else if (!strcmp(token, "mba_MBps")) {
> -			ret =3D set_mba_sc(true);
> -			if (ret)
> -				goto out;
> +			if (boot_cpu_data.x86_vendor =3D=3D
> X86_VENDOR_INTEL) {
> +				ret =3D set_mba_sc(true);
> +				if (ret)
> +					goto out;
> +			}
>  		} else {
>  			ret =3D -EINVAL;
>  			goto out;


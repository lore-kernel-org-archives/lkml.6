Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C803C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FAF2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MBNa5JZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FAF2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeJCA3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 20:29:24 -0400
Received: from mail-by2nam03on0062.outbound.protection.outlook.com ([104.47.42.62]:26304
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726819AbeJCA3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 20:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2rJ/mAxiS2DtAap16ZfRBYjTYML6upCM/68emiODzQ=;
 b=MBNa5JZ4+rwo3aFwoKeD9r0r6hlR8LFDBgml1IWMAgjLuPvJtBfVQYtNpDnsbsMJ/NJPkdxeVKL+pBoHi/eQvtFxrwkskMr/fsJoxLzmGZdjI734prcC9eXdeVS7VsO8QV2y/EiOIopNbjJoZ/LlouAPGcpXLMXKbnhrgsTmlfI=
Received: from BL0PR12MB2468.namprd12.prod.outlook.com (52.132.11.143) by
 BL0PR12MB2337.namprd12.prod.outlook.com (52.132.10.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Tue, 2 Oct 2018 17:44:47 +0000
Received: from BL0PR12MB2468.namprd12.prod.outlook.com
 ([fe80::3cba:94d7:dccc:510d]) by BL0PR12MB2468.namprd12.prod.outlook.com
 ([fe80::3cba:94d7:dccc:510d%5]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 17:44:47 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: RE: [RFC PATCH 00/10] arch/x86: AMD QoS support
Thread-Topic: [RFC PATCH 00/10] arch/x86: AMD QoS support
Thread-Index: AQHUVDtunpE+5D/HD063flof44uaLaUMPC4AgAAI7GA=
Date:   Tue, 2 Oct 2018 17:44:47 +0000
Message-ID: <BL0PR12MB2468F1F6EA31332657802C7595E80@BL0PR12MB2468.namprd12.prod.outlook.com>
References: <20180924191841.29111-1-babu.moger@amd.com>
 <20181002170655.GA92941@romley-ivt3.sc.intel.com>
In-Reply-To: <20181002170655.GA92941@romley-ivt3.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR12MB2337;20:zMrB5Hw7dtqZFrIG0HKIubohm5uq3he1gzhc5WL9q5iG0YmEhTM9RHQ3x819lGAhA6eAA2Of9fEFFCP5DMlyq6/oxbCAZlQDlSTbRV7g/XDz+EuE+QSeR+GQTh7+TH/NaZujzKvy8foMmm/kpOicu2HN+A60YQwE5Uo7LfVRHbRs+Jp0vtAMd1MxGnCHygun55n4h8IZNKTcoRSkibEYIul5AiV7dvFN5xsASzl89mVw9xXS32UZilQlECu2wuLI
x-ms-office365-filtering-correlation-id: 99217f39-6b4a-4b49-69ee-08d6288ebf11
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2337;
x-ms-traffictypediagnostic: BL0PR12MB2337:
x-microsoft-antispam-prvs: <BL0PR12MB23373A4CBAFEBBB191DC6F8495E80@BL0PR12MB2337.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(198206253151910)(146755900322472)(211936372134217)(9452136761055)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:BL0PR12MB2337;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2337;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(366004)(346002)(13464003)(189003)(199004)(446003)(99286004)(7736002)(5660300001)(217873002)(476003)(11346002)(486006)(97736004)(7416002)(53546011)(2900100001)(26005)(186003)(72206003)(14454004)(478600001)(86362001)(54906003)(55016002)(966005)(6506007)(6916009)(53936002)(102836004)(305945005)(6306002)(256004)(7696005)(76176011)(229853002)(6436002)(2906002)(9686003)(71200400001)(3846002)(68736007)(6116002)(25786009)(8936002)(81156014)(8676002)(4326008)(74316002)(71190400001)(6246003)(33656002)(106356001)(105586002)(66066001)(81166006)(5250100002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2337;H:BL0PR12MB2468.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ognqWzDndApIz8JenDJH33MsZNlyYbvPK4df8g2pdahbqT4P6Y3X71Bl4ZWsBpDmwtuPyCznnPXVHmzCVsr5k/xuDVnGejCJcMmcL8O3dO+9cp2ZcNsGHrtBkxsdmFdi5HMkaHHCiQvmP+qg9iWU2q7RqkJyow+9NTRV4LXM5tsecRly8yLPPnJbH6IgGsQjwjePx1gdDEeqCqMVC5M01HnNSVr3cht+N3wU0RZy1ujQ+0myIorQQyBwCLwuKETWVpT758Zs709VjhZXI53g/qK7ydQ2fNlzHk+PiFvWw5FfXynXukJpULGBg/JF1feU1DLdLksGrCWyi0TuFhr2WIU3zdCUyS42gDTFgByTo+A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99217f39-6b4a-4b49-69ee-08d6288ebf11
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 17:44:47.2122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

> -----Original Message-----
> From: Fenghua Yu <fenghua.yu@intel.com>
> Sent: Tuesday, October 2, 2018 12:07 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com;
> fenghua.yu@intel.com; reinette.chatre@intel.com;
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
> Subject: Re: [RFC PATCH 00/10] arch/x86: AMD QoS support
>=20
> On Mon, Sep 24, 2018 at 07:18:54PM +0000, Moger, Babu wrote:
> > The public specification is still in works. Will add the link when it i=
s
> > available.
>=20
> Is this the public AMD QoS spec?
> https://support.amd.com/TechDocs/56375_Quality_of_Service_Extensions.
> pdf
>=20

Yes. That is the one.=20
I was going to send the link after refreshing the patches on 4-19-rc5.  You=
 already got it. Please let know if you have any feedback on the patches.=20

> Thanks.
>=20
> -Fenghua


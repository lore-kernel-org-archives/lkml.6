Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FA1C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 17:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B5120837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 17:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LRSzORbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B5120837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbeLIRpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 12:45:30 -0500
Received: from mail-eopbgr750114.outbound.protection.outlook.com ([40.107.75.114]:21024
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbeLIRp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 12:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgrHrmSNXn8Qc2rnC6vVUQ8YPmqTPkfIuGVlStFlae0=;
 b=LRSzORboR6E0Zb7IGB7Ys8BO53Tebx7FQWcqrJW/1txlmtgk0u+vF23+2WDPzlLIJHs1Bld+EKlc773lId48IOolG8ubsyhjrLi2XCoLQm8U93fWc358GJ0qDu1bwixx9PacHMrlpG/m2zz/xmsrtXr6hx8PKympbP0LfkvOpqE=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.4; Sun, 9 Dec 2018 17:45:26 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::f597:e00a:584b:fd8c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::f597:e00a:584b:fd8c%2]) with mapi id 15.20.1446.004; Sun, 9 Dec 2018
 17:45:26 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Roman Kagan <rkagan@virtuozzo.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Eduardo Habkost <ehabkost@redhat.com>
Subject: RE: [PATCH 2/6] x86/hyper-v: Drop HV_X64_CONFIGURE_PROFILER
 definition
Thread-Topic: [PATCH 2/6] x86/hyper-v: Drop HV_X64_CONFIGURE_PROFILER
 definition
Thread-Index: AQHUjYTwPU5TZw43q0iXUm2Jo7HFWKV2shfQ
Date:   Sun, 9 Dec 2018 17:45:26 +0000
Message-ID: <CY4PR21MB0773ABDAF630143F6B37B1E0D7A40@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181206165825.1832-1-vkuznets@redhat.com>
 <20181206165825.1832-3-vkuznets@redhat.com>
In-Reply-To: <20181206165825.1832-3-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-12-09T17:45:24.5177027Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:FvvrpeQuRG30ZwRs2RZ59/drHWSmLPGo1rGBVjJXCYx6j1rpdRDDZuhl+aGb3J6zmaCB8Q8kuk5tMzQHCR1uNEACtL4BoAWgkRGJOaDUNvv2s7zTqhzjZWEJOODF1adAaWlwf5xLw2xx0eY1xZVLpMTN2WyoNXpEVstDOn8wDJVkdzZ8rLqFYjm4qs76s9yI2YOwnAOl2NPi5cCSSkVw2BoGsvhpuFPnQxKwuYQ8qid7UzAf6FhMtjFsLs1HMd0+LSrMfkA64GQTCzRhWKklObHLC1q1GJRsR2B3fI+czDol/FsjB780zvDCns7KxbtUBx4r9GDxsTuM3K2bQMQpklMXSTQfboeESWdzpHLGDGtERJ6yh07dygGeccX9l4OZTpTQzR7aF14elLBa+0rzCD5AKTySACYXmqT5eYC4U9IB5kXfm8aDrl+X0x1qHTRv+/yDPW8GjOOIK6QcOSM2Ow==;5:0mVWYAUUJA9ZPn5vOwd6ZaTXg5H+5Pxz/wge7VhHOanFYcwnwsyZIrAqQASA1gp92GAGDm7hMhhobV5b0r9CQPoFmU9nSbJJ+6HztUCqqY7auQd52zpM45dBQB6CkJChcLgLJHeTMPhKTjtn6p+WnwZQ3l8Na5mBIcmFQzx9c2U=;7:K4psaNAnyG79THvwJTqBrXzDzPn6Nn8ZM3xr63wOrDQDzIhrF7//nRK+lvTIuGSdHA3dEWx1whj0ToX2NWrc1RVoV+TBstO4fUHHm9DD45+mgkIqoYCRK/jlXYENnvmsCWju0DFVNQGvU3oPtMsSug==
x-ms-office365-filtering-correlation-id: 6672141b-600a-4bca-cc04-08d65dfe1a4c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB04706F48CB4D91D4F1BA0007D7A40@CY4PR21MB0470.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(8220035)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231472)(944501520)(2018427008)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0881A7A935
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(346002)(366004)(396003)(189003)(199004)(486006)(10090500001)(66066001)(9686003)(256004)(106356001)(105586002)(8990500004)(55016002)(6436002)(6506007)(4326008)(74316002)(97736004)(7696005)(6246003)(5660300001)(305945005)(476003)(86362001)(229853002)(53936002)(7736002)(76176011)(446003)(11346002)(68736007)(102836004)(186003)(8936002)(81166006)(81156014)(26005)(86612001)(2501003)(3846002)(33656002)(8676002)(10290500003)(6116002)(14454004)(22452003)(71190400001)(478600001)(71200400001)(54906003)(110136005)(99286004)(316002)(25786009)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Jkm12JGz6n+XUN3Zc9Pc8BHCG1FqM7A+nlW67mg9sZoWHjoNnltF36pmxSEAVXOXfM2Xbm1goRg+JhJmM48HCS68P5k+nTYbBqNoiBal8znfuFJQ7KRdSw2UXh6p9hdLBeOjXhg1ZJEWL0HrA2AZyF6lgXBN0kJIKqQf614H41XufKftghD6uHk0j2dpZVMXvH40i3Pr8rQOmdpK7x6eqAY1WN8cVOExbpOH9IJy4QUdliT6mE8CjgLunoB7VUT9IhRT4AinryewJYmjw8L+3Mn1PwGOe5dCFtjFVb2soM8lqWhVBtVTQwv2SYU1RgDmv0SdDeYLRZKfbjc17g/f+uK596m2i3sxpbMn29IOOGo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6672141b-600a-4bca-cc04-08d65dfe1a4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2018 17:45:26.3390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Thursday, December 6, 20=
18 8:58 AM
>=20
> BIT(13) in HYPERV_CPUID_FEATURES.EBX is described as "ConfigureProfiler" =
in
> TLFS v4.0 but starting 5.0 it is replaced with 'Reserved'. As we don't
> currently us it in kernel it can just be dropped.
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

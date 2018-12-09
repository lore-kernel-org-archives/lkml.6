Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B609C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 17:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D9220837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 17:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AzPySA4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D9220837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbeLIRmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 12:42:35 -0500
Received: from mail-eopbgr720137.outbound.protection.outlook.com ([40.107.72.137]:47311
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726128AbeLIRme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 12:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s35BQZSr956LiAaAkQ+jeXNgXVtSzdIqLVV+FmtVzBY=;
 b=AzPySA4MlgGUtCloexhWzNhKs8/pGIefd3i0HaBQbgQfxzNFbdng1ZdGrOJiqOJsMVagaBngJu6fxjdlnxeGHyYH8oL9uXCcaAIJ0nkHEkTzEsFCf5pdA8kX2jjm1nyT9MdMTpvl9kUmlqRRaCKkPVl/DKRI4Diudlt5g5AsxPA=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.4; Sun, 9 Dec 2018 17:42:31 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::f597:e00a:584b:fd8c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::f597:e00a:584b:fd8c%2]) with mapi id 15.20.1446.004; Sun, 9 Dec 2018
 17:42:31 +0000
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
Subject: RE: [PATCH 1/6] x86/hyper-v: Do some housekeeping in hyperv-tlfs.h
Thread-Topic: [PATCH 1/6] x86/hyper-v: Do some housekeeping in hyperv-tlfs.h
Thread-Index: AQHUjYTtNa2Zd1ZXoE2ie3GkBL6k8aV2sc7A
Date:   Sun, 9 Dec 2018 17:42:31 +0000
Message-ID: <CY4PR21MB0773E549086C5846821154E0D7A40@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181206165825.1832-1-vkuznets@redhat.com>
 <20181206165825.1832-2-vkuznets@redhat.com>
In-Reply-To: <20181206165825.1832-2-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-12-09T17:42:29.6501605Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:Z6NFz5L0yyUoezpYpysKLbO8SaRWF6/3HW/Q2sJ+oW4cN4ns23avpDoymBHyC2I5LT+wYTByM8DiTtt9rP/WKFXujxiiUtNp09A4G51O7qLvguSI5/Szv3z3Djm029fEjO55mbYHcVdN1v74VvQmHvmDyPb/NuAzs2g6cOgf36AmhQP0QnKMPg3LX1YbHy3f2KKWHksr6MRxdZYVyPQ8caQ+JkyZwBQMNMdfT7nzCTL3hfDItPQIGcD6EI7Vl/LO+L+O5GN5C8Z/piokbkkwtq4oT0jrqK5Ilo6Ym3bw80VrIW9jjvCFh6BvTSy/74eBr3J7b9Jeoac/xSlSAWtF9wLNEmg5RNruUUMVfdG8423ccUrE5PU05zMIkKMwwzu+9JTunKRwAGiVIRFejEm3+zgWqGAwyzmwPgQtLa1b9+T9BL/iV2MX8mqbzQDu/jNAzoh1U1aEP+6rrFQ9guuD8Q==;5:uS2VQuuPFqH2yxnkOpJeK3fCZJt05W0zrUP7YOQThFVw867e47u2Ojdd62iQYLN0l5NGWGmMoggR7r2mDIlhm0de1hMRkvu7OWlJlVvfeg3CizWU5/7FyDQW/fZvGe+pt/XQtb43nzlq/iGBzdHhuC/a2c/tW6PSglXmwQ/PvpQ=;7:0EDHYzIdB539Jxz85IYWw1u9EBo82Zf1r5a25UQZHds5et5Ue7RIAEbWB4OxOBA41Lq7khaD7mt2xW9VgSu/MrEIriHWcoBmSQb8CKiiWI5otQaUp6FaYGo6t8tcGrDstag/3IbEBGRms2j7dMYYyA==
x-ms-office365-filtering-correlation-id: 6b0ac8f5-159d-4bba-85e4-08d65dfdb20f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB04701CD8EBB42A6189111FFCD7A40@CY4PR21MB0470.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(8220035)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231472)(944501520)(2018427008)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0881A7A935
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(366004)(346002)(136003)(39860400002)(376002)(199004)(189003)(6116002)(14454004)(81166006)(81156014)(8936002)(86612001)(26005)(102836004)(186003)(10290500003)(8676002)(2501003)(33656002)(3846002)(316002)(99286004)(25786009)(110136005)(2906002)(22452003)(71200400001)(54906003)(71190400001)(478600001)(105586002)(8990500004)(106356001)(6506007)(6436002)(55016002)(66066001)(10090500001)(486006)(9686003)(256004)(76176011)(7736002)(446003)(11346002)(68736007)(7696005)(5660300001)(6246003)(74316002)(97736004)(4326008)(229853002)(53936002)(86362001)(476003)(305945005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QYIMFqyUFxjGfMMleSK+BbiJqh+5koN/Z+aLqeccvXddRoQ9qIVZe6Dxg7bbffBlfgD7DeocdgxPBQ7zAmiO87Rp9uZP9f3jdUK+ILZqnUXnb3d7fRtfVpzesmCnlVBDNlRMCw5PtxrCitPP8sUmiP5T4kB46pLqSzrF2+ialbqa6FkiaaUQs2F8YQv4slGRf0wGShz0D0snqPGE6Rd3J0OZyMV+XCphZPfoXWpz9m54VFJE/rfGEHUu6Pxyi1h/uZ3dVPUVgQ1QzeWC4CTGhYAQmWC5lK8+PRyrZxx+98lRuJTOA2Lzu/QFUK2xiJAxn2s4FZ3oF/urdqmLYOicdcOWuXo593IvtEVS9k3T5Tw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0ac8f5-159d-4bba-85e4-08d65dfdb20f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2018 17:42:31.3963
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
> hyperv-tlfs.h is a bit messy: CPUID feature bits are not always sorted,
> it's hard to get which CPUID they belong to, some items are duplicated
> (e.g. HV_X64_MSR_CRASH_CTL_NOTIFY/HV_CRASH_CTL_CRASH_NOTIFY).
>=20
> Do some housekeeping work. While on it, replace all (1 << X) with BIT(X)
> macro.
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

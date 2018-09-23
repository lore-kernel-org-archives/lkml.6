Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93DBECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 14:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131032148D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 14:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DY4OY/Pj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131032148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbeIWU44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 16:56:56 -0400
Received: from mail-co1nam03on0090.outbound.protection.outlook.com ([104.47.40.90]:39712
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbeIWU44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 16:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwkV0U6xOPn/zkfGy3V1p/utOprfSxQK0YwlVsn3jIQ=;
 b=DY4OY/PjZCdw7uZNjwDt19buNez5oGIIkbrI3t5Dn6boFP7YCPtlt7UIdhSvG675J+mAFcQjxKn5d7IjA8GisCZa82eebaiYdpuJxYyWxMpZwH3Q7LENPfCqF7Uk1hS6cf5FzENm8hayEz9nx6LRPdAZYKt3/kVoSezroEJwTtI=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Sun, 23 Sep 2018 14:59:08 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c%5]) with mapi id 15.20.1207.003; Sun, 23 Sep 2018
 14:59:08 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH -next] x86/hyper-v: Remove unused including
 <linux/version.h>
Thread-Topic: [PATCH -next] x86/hyper-v: Remove unused including
 <linux/version.h>
Thread-Index: AQHUUxUCKebjgTumikqYgSLHPOfEi6T99UiQ
Date:   Sun, 23 Sep 2018 14:59:08 +0000
Message-ID: <CY4PR21MB0773E37E25D664DB57D079E4DC100@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <1537690822-97455-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1537690822-97455-1-git-send-email-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-09-23T14:59:06.6468679Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:BKqDQQuVqhPH9yD7K2WCAj7ZmNRAyW+rawrMXnmpZhxFs2xODpBM+xpbVNhAE3ro/zIGToFwcM/TD7fNapWONQj49uZHUwpT4uqbRcZ1/AkLrP6ZbcSrCdzI0Ifhvr1i+vM11NQWMg90jAXm5B3GxlRV4LstaktZnIhJV8kHHr3Q3j88FDY3x+jIbkTabXG2zbzTyahpkSYHSHrFWR4cZwqCMm5spi7OEjyPMF4sBQ5gIHXvVHO5lCBCIVyGjugyZSH1NbrfkB7hDNDHvzn57QGm7wKeHveBVTsWt5i+fE3h4O3TVpjQqj4jjaWWqN87DuD21pN1FEvqXw73ZEXPucUlVuC/8j97gfxLggb7ddq+AxLMqvWnhSgWnr14qrGNXkTvtwGlgiInSNFkfC1HiZSi57odBKJ/PVMJVTma0VZotjXMb9I36alr1fc+p7u1nocZZWzlhxcTh2td1oes3w==;5:rfNH5G3Qav5zp36wZTQW2SSzgQ/oS/ceDLfTXbE8XNZT9OiAchLKMRFsYxZQsnPA2DZjnLYlNeFowZIIWTrY2tLY1anTbox+ODgBYCTcFwlvOGrbm4D6rlUHBYaJIhRrE70qhVJbW2XqewWSfMQOby0DBZT0Ou7acOGMRLg+CJA=;7:8sLiyEEjD00e1IGQ0f42UGirLfu3Hcr2pAM75O9QmXSFwaDaVeBRqaGF5GV2Ks0CcgrdUIvXWwjOjdi3xMwC25kr/D6vuhzHuFWMOT8yXd9W5H6sacch0sAW97Aav77tJ9ooyfgzXhbxzoztFfrVQDfXV97XdIhS5Tqrk6MU36R6pVXAvNgO9ca+tsZdnhPOaGIA1f2v1K/+zGnlqMv0DJ3oxhRZZ+GTk2Iqef1U6SpCcdvkm5e8aEGLyNqTDDix
x-ms-office365-filtering-correlation-id: 8ff81302-3622-43f1-b8ba-08d621651d67
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB077634C5A7A56F2C8632F900DC100@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149051)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 08041D247D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(366004)(396003)(136003)(199004)(189003)(72206003)(26005)(256004)(14444005)(33656002)(186003)(106356001)(105586002)(102836004)(1511001)(66066001)(558084003)(4326008)(25786009)(6346003)(8936002)(7736002)(229853002)(305945005)(6436002)(74316002)(5660300001)(7696005)(22452003)(316002)(97736004)(6246003)(8990500004)(68736007)(99286004)(110136005)(55016002)(54906003)(53936002)(9686003)(2900100001)(3846002)(6116002)(10290500003)(2906002)(81166006)(81156014)(8676002)(76176011)(10090500001)(14454004)(6506007)(86362001)(5250100002)(86612001)(486006)(476003)(11346002)(478600001)(446003)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-message-info: MXoKTEOBgQyCo7J5/sih7/p6dYzHO+L1XE5/rRrea+lk8Rq76AsV7ioxRne9b/6C5gfI+mDxAp1NKoGMirlwB0fvHPLiaDttUOAEH7E63iY7BLYcyDp8zSXPIBeAHHPNoYU6Dq1v9AKI9up9a86jsldZvmZJovNRBz7UsGxEaY8iLMJHb87b6mVzWzUo5cUOAeMVO9peSEQms1fq1jAgjsXs+nz7/yNlqKuxdnLdPHflgf4Z8r3kZaECBaM2A6Ktp5mE1Dy/OZEkwSb+ftI83RPE1P4iHGDZx7h6+2oe2/M1LuIfBr/7LMI+mfF7as1eGOxXq2PF9yMRMeQEXzAwX/KqLWm0U/yZ1qi3sMefJ+M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff81302-3622-43f1-b8ba-08d621651d67
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2018 14:59:08.6092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>  Sent: Sunday, September 23, 2018 =
1:20 AM

> Remove including <linux/version.h> that don't need it.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  arch/x86/hyperv/hv_apic.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
Reviewed-by:  Michael Kelley <mikelley@microsoft.com>

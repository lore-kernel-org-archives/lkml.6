Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9201CC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1E32087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Nhdgp1RV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1E32087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeLCQ0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:26:06 -0500
Received: from mail-eopbgr730139.outbound.protection.outlook.com ([40.107.73.139]:54337
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726560AbeLCQ0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9JgjmpF2BlSHgK1P5ZbZO0kDbzsaa7UXqte1ajQe30=;
 b=Nhdgp1RVAJThWmU+TmAb20gvVkJjofHe0Ngx0AutwBuaUfyEuvP/i6bo2gQH7fS6yMuMNJJ9oAHFafBM0VYU274TMwUvRsJb8PF372iZ1b0UZmhiqoJlplBslazhfqyh1MEgZpuRAJEoW2xQ4c104VVHTUtaSLf241/ZraT7AtM=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.3; Mon, 3 Dec 2018 16:26:03 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::f597:e00a:584b:fd8c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::f597:e00a:584b:fd8c%2]) with mapi id 15.20.1425.004; Mon, 3 Dec 2018
 16:26:03 +0000
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
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v3] x86/hyper-v: Mark TLFS structures packed
Thread-Topic: [PATCH v3] x86/hyper-v: Mark TLFS structures packed
Thread-Index: AQHUixFtfKI2BiaJ9EG3TRCud33IRaVtM0iw
Date:   Mon, 3 Dec 2018 16:26:02 +0000
Message-ID: <CY4PR21MB07731E29CA0BAEE1697690BBD7AE0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181203140636.21912-1-vkuznets@redhat.com>
In-Reply-To: <20181203140636.21912-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-12-03T16:26:01.2803629Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:1:90ee:107e:27be:a69]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:/nSrhgl2CervIElhLcHTZQYQOYdbgkunOMY6J+w0UHRb3eTCkHdbr+VOcRdmhcmb+jFKx9rDrMMgCMgh10mvvSwhjOy5XAp3sNpSmTMNlF2hy03FUjDA8odcfIxDdw28bKYKBqyr+fhy+VpqjV2xB3njIKVvUs8HqijY7GnVQh3D84j22cN4qxABbEDzMXB5aopXWXWKimU6L1uLiliy+Sb9BMiYLc14g1P+UlmOBnnI2B4xYARUz36CzEzV2FoCfIvG3ApqNZGxExILdqBzlG1XQaOG5zARVK8jhXYGqkhGcfnpbTDvL5SNbLFlx5mQKwGQ5eSIMJzusnYd8LImHvcPhYzd54UjJiZrOE1bpbBOmKZ6SGQiqFhrOFqu3dMgm3XmqwpPyJOyH9LqZpTHHfRDIgPieVH6pJOppN4YO1MYpSCovmukMlGUtVDetUYzwsauYV0KrsFfiABtWlPJaw==;5:Wqk6xGLiIKYurCBdxRxAII7Zy4XWhUpPSnm7qsY3Ft8rcbryaG5ih1ZIo2Q5q112yFUWDQ4+lrqjPKRDyoqBYEyprFhudHq/+IeDxp9lRdLlQVJOEaVUJMgiS/d21+1GhXFYMXLuLed6VKSGqNQ12FOclXiZBstv7aZUqYNu52E=;7:Ekznu/5teejGy+bJt5WJarH/mpXp/hJCcwiUDSzg8HU+LmM7sddykGR2X/fYa3tO2QtlwuZpGPAFquuS1b+W3aAno9/LYQWrEt+u5seQn/1XdgTqXdTcNdwujwgc0QbVn6zUucXJ5QW4p+BfDYV53Q==
x-ms-office365-filtering-correlation-id: 19b3c7c3-77ce-4d27-8110-08d6593c04b5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB01207A953210521A08ED282BD7AE0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231455)(999002)(944501493)(2018427008)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(189003)(199004)(316002)(5660300001)(102836004)(6246003)(186003)(2501003)(55016002)(86612001)(76176011)(7696005)(6506007)(9686003)(86362001)(74316002)(105586002)(8936002)(14454004)(106356001)(6116002)(7736002)(4326008)(8676002)(305945005)(33656002)(81166006)(81156014)(68736007)(99286004)(25786009)(10290500003)(229853002)(486006)(53936002)(2906002)(39060400002)(478600001)(46003)(10090500001)(256004)(476003)(446003)(11346002)(8990500004)(97736004)(6436002)(71200400001)(71190400001)(110136005)(54906003)(22452003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gutj1F+wHGpbtIyRWNgSt0PX3+hDdYOgqJAERo8kMkyVSRtNREBMNnXAcCpjZmzrfa6cEmHLmZKgpaGGi5c02mWRhzvzX/2JQ6GJkrNJiEb5EKmUu0PByb8XsoostpEtScBof4rOm3vM40DpiTohDwVKcg1ZEPEWSEP6OWlpyKg2JPjppM+m1AdVZkY/Fo2WrPf+q1oaJp9q/zFNNO/8NfdT2xDHO0wbI8yMAYQUs0n1U3m0lZTm7y03gQyZmn1K/1sYJQfY07mDs2l4cbNfNcX6VGQWeGxkQT7kDsdPREJIRqlKbHb7rPQFg1zBu5NZg3CtBGuancHWAa/OZiZRPv1tRZRESEl8JF+HUqMI2rk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b3c7c3-77ce-4d27-8110-08d6593c04b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 16:26:02.9085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>  Sent: Monday, December 3, 201=
8 6:07 AM
>
> The TLFS structures are used for hypervisor-guest communication and must
> exactly meet the specification.
>=20
> Compilers can add alignment padding to structures or reorder struct membe=
rs
> for randomization and optimization, which would break the hypervisor ABI.
>=20
> Mark the structures as packed to prevent this.
>=20
> Suggested-by: Nadav Amit <nadav.amit@gmail.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Nadav Amit <nadav.amit@gmail.com>
> ---
> - Changes since v2:
>  - add __packed to struct 'u' defined within union 'hv_port_id'
>    [Michael Kelley]
>=20
> - This is a follow-up to my "[PATCH v2 0/4] x86/kvm/hyper-v: Implement
>  Direct Mode for synthetic timers" series, as suggested by Thomas I'm
>  routing it to KVM tree to avoid merge conflicts.
> ---

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

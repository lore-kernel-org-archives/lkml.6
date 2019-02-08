Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F83C282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0CC2077B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MicronCorp.onmicrosoft.com header.i=@MicronCorp.onmicrosoft.com header.b="tTeSs34T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfBHS5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:57:34 -0500
Received: from mailout.micron.com ([137.201.242.129]:40940 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfBHS5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:57:34 -0500
Received: from mail.micron.com (bowex36e.micron.com [137.201.85.221])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id x18IvMnq024597;
        Fri, 8 Feb 2019 11:57:22 -0700
Received: from bowex36a.micron.com (137.201.85.222) by bowex36e.micron.com
 (137.201.85.221) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Fri, 8 Feb
 2019 11:57:21 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (137.201.84.23)
 by bowex36a.micron.com (137.201.85.222) with Microsoft SMTP Server (TLS) id
 15.0.1365.1 via Frontend Transport; Fri, 8 Feb 2019 11:57:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicronCorp.onmicrosoft.com; s=selector1-micron-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+i9GxSy7Ol96e0+h9TUTrvzJwHqcj6bWkVgqvee1Okk=;
 b=tTeSs34T4Ekv5AYQMEi6GaXZlQ7xE02zNtypMyRrkRN0zeFrIfTwms1XbgojiGP3PCQdrOQOj06/9LW7kbr1FrmmT+CPY8SyaMUDa9o5H9C4wIPqLJQJI0RBLPJKfSZAtawd/SLDAE4Ie7Op+VEY+MAX+FDbkbhStLL0YsFRUu0=
Received: from BYAPR08MB4533.namprd08.prod.outlook.com (52.135.234.15) by
 BYAPR08MB4789.namprd08.prod.outlook.com (20.176.255.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Fri, 8 Feb 2019 18:57:18 +0000
Received: from BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669]) by BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669%3]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 18:57:18 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     Marek Vasut <marek.vasut@gmail.com>
CC:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: RE: [EXT] Re: [PATCH v2] mtd: spi-nor: Fix wrong abbreviation HWCPAS
Thread-Topic: [EXT] Re: [PATCH v2] mtd: spi-nor: Fix wrong abbreviation HWCPAS
Thread-Index: AdS/uVD1jG3UvCBSRuC2oJ8LRRcc4gAA03cAAAFVpvAAAQltAAACntYgAAFvxgAAAWkB8AAAp7EAAABTneA=
Date:   Fri, 8 Feb 2019 18:57:18 +0000
Message-ID: <BYAPR08MB453343DF172ED508C736C94CDB690@BYAPR08MB4533.namprd08.prod.outlook.com>
References: <BYAPR08MB4533C8EA6B775C7514FA7F82DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
 <298d18cf-094b-d5d0-45d1-39c7b75ba309@microchip.com>
 <BYAPR08MB45335415CC3690816C1FD603DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
 <a83a9655-0ce7-da15-ec17-80ef88764e21@microchip.com>
 <BYAPR08MB4533DB0A7F4E30543750C83FDB690@BYAPR08MB4533.namprd08.prod.outlook.com>
 <20190208184718.3c488d0d@kernel.org>
 <BYAPR08MB453327FB53F7DFE50C55C1B4DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
 <7278fa87-bfe4-3d95-9a9a-5ef4c0277d78@gmail.com>
In-Reply-To: <7278fa87-bfe4-3d95-9a9a-5ef4c0277d78@gmail.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.81.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4789;6:Ot7ruJDqIJqOPvw9SI7kdpaOPsLH+A+0LgeuBLSreeP9tZEvULTlVI5pbHH2mQu2FwDE0r3WLoMW3Vt1IW0RzQDqS5DZQGLucAzflECulwhCILfDFBp1o0kChm8czB3knKjBxi2K3yaKaqbBtIwSvUfIeEanBXtQIqV4Ahmo9BLiwU0uqOEjHUUbtocMd1PTggoAg+mZ+LGcpDZVlOAmekpL6UVvQFXsBYnpuGB/y5U8BYpFoStxZrsFdwVWx+CAh17fuKCpo331Gl3G1y11hZR6xKF3vkGx1w1OlcPMA7xj9acy5KFO4vKrdE5zuG46rRyBlMWf3/38MigjsWLfiXmZfCKp/vKECpc6feHOLCI7Ldz4+YZpYRhR6CCp3e3SYpvtJvRJONZOoc2Qq/fQ+BOwFftxyuGaekZoz6Fov5l0mf1MvpOO/JAPCH3tn3pYl/M8EHWnxi3vzJpuUmcdJg==;5:bprCyfjDu/tHcmnNHpAW+TaAa6gbFvOmINGvZ8JhnLXHU/X2kDeTviiOHGrDRueyFK29EK6XxQUyNXC0RantN/5dgHVLmRfCPQRgTvorCa3Pi0Y/fpx/Mp0OIfLXmuL7vw8GQs9ziMehndOmwlZCOfQOvoz/2vsdmtvswt6wL+XRKDHkoUIpkMMol70+Z0YjYc4Uta8reF9uLMHi0qnadA==;7:mBZKwKLFEvfu9Bp0JHX7sbUoesESEolM117GA9A8dJIU0D7RIpmhk60F17n8qv6FSylPAfax8v71Ua3MGhOv7J9C5kHOQsbmxJjgPtfPpJ6bV6c+fYG2soyMePYaf64H0jU7H+pcAy+lnoRbQZ+XPg==
x-ms-office365-filtering-correlation-id: 4a84c007-5f58-4ecf-40e7-08d68df73fe9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4789;
x-ms-traffictypediagnostic: BYAPR08MB4789:|BYAPR08MB4789:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR08MB47899719C4279BAC55420E5FDB690@BYAPR08MB4789.namprd08.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(136003)(346002)(199004)(189003)(81166006)(6306002)(53936002)(74316002)(478600001)(7736002)(2906002)(93886005)(305945005)(55016002)(229853002)(8676002)(4326008)(6246003)(9686003)(81156014)(86362001)(6916009)(66066001)(256004)(316002)(14454004)(68736007)(97736004)(76176011)(7696005)(71190400001)(71200400001)(11346002)(486006)(106356001)(476003)(105586002)(446003)(54906003)(102836004)(33656002)(99286004)(3846002)(25786009)(6116002)(4744005)(6436002)(8936002)(186003)(6506007)(55236004)(6346003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR08MB4789;H:BYAPR08MB4533.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 74ClbcDFb5Z52ZQHa3k9zPf6/mWAFcy5lYJqisngMQRn7HxaSrXASiMz/uNJFvJN6Rv9kKChw71NEr1gI9k1SD4WC1Fs8lKCFn56IYp8h0+YAGMfHgRO8Gw4IC3n9SwgVosey/oH3/2G+DgWqm12Q9i5fA0iuAhUel0ZhnWmJi2GzzV8CO8bJWhJsdnIvmn4txIkSl3zGikGapNawRwWshAZf6RUUOmwhiGp33lWH6pndlDL8ExcihijOXG3Fx1wd2hsuR+fPVytcUDEg9WepLmRiAT1FSmPdpWO9fq9rpARzI4PTJCZyCGwUbcNAKUjnoOUkfdt7vUYyoO6KRvFfHbKJuMN+i48zdKOsp78dz/MM9nUsFKkVRjKSCXeDkNdoyVxNzZE8NYhPRVa8PQgrHop6h7/ZpTnHtsoidN8t/k=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a84c007-5f58-4ecf-40e7-08d68df73fe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 18:57:18.7573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4789
X-OriginatorOrg: micron.com
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24416.005
X-TM-AS-Result: No--4.862000-0.000000-31
X-TM-AS-MatchedID: 150567-139010-780014-705178-703283-188019-702020-121574-7
        00107-700648-710970-701249-139704-700047-148004-148007-148020-148050-10018-
        20020-41000-42000-42003-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-CheckInternalSenderRule: True
X-Scanned-By: MIMEDefang 2.78 on 137.201.130.65
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> git send-email 0001-mtd-spi-nor-Fix-wrong-abbreviation-HWCPAS.patch
>> 0001-mtd-spi-nor-Fix-wrong-abbreviation-HWCPAS.patch
>
>git send-email --annotate --to=3D... --cc=3D... --cc=3D... 000*patch
>
>This will likely make your life easier, rather than having to paste variou=
s email
>addresses to git send-email queries.
>
Yes, thanks.

>[...]
>
>--
>Best regards,
>Marek Vasut
>
>______________________________________________________
>Linux MTD discussion mailing list
>http://lists.infradead.org/mailman/listinfo/linux-mtd/

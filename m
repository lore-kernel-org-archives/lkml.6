Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EE8C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D030205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=raithlin.onmicrosoft.com header.i=@raithlin.onmicrosoft.com header.b="cUkZgqnq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D030205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=raithlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbeKBBwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:52:33 -0400
Received: from mail-eopbgr670117.outbound.protection.outlook.com ([40.107.67.117]:46246
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbeKBBwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raithlin.onmicrosoft.com; s=selector1-raithlin-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ErZhwsL0ec+G3mXNwr8RrU8NEwmKhDxeg+ivpFAKYo=;
 b=cUkZgqnqIyJIMzaQ3AnIDhC8ystSQZXP1ImvE6crA/+J7PwiE/ptglUceJzaSzJHbK3cBbXwm/Qm+ARvAO0B4JGEBGtZajYah/YQtS8PiJofXSJiucank5zaGIGyIAj0OaV51ky9vXh9mCYpBUBH9dxkMWkr/kBeL/vjOOuFYmk=
Received: from YQXPR0101MB0728.CANPRD01.PROD.OUTLOOK.COM (52.132.75.145) by
 YQXPR0101MB1478.CANPRD01.PROD.OUTLOOK.COM (52.132.81.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Thu, 1 Nov 2018 16:48:45 +0000
Received: from YQXPR0101MB0728.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c11b:dc57:9ee6:5fd]) by YQXPR0101MB0728.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c11b:dc57:9ee6:5fd%4]) with mapi id 15.20.1294.021; Thu, 1 Nov 2018
 16:48:45 +0000
From:   "Stephen  Bates" <sbates@raithlin.com>
To:     Alexey Skidanov <alexey.skidanov@intel.com>,
        "danielmentz@google.com" <danielmentz@google.com>,
        "mathieu.desnoyers@efficios.co" <mathieu.desnoyers@efficios.co>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>
Subject: Re: lib/genalloc
Thread-Topic: lib/genalloc
Thread-Index: AQHUcgHgz+DjXH5b20mPLBIp3KnEDqU6vOiA
Date:   Thu, 1 Nov 2018 16:48:45 +0000
Message-ID: <4DECD467-AD45-419D-8F0F-1456863274FD@raithlin.com>
References: <a170cf65-6884-3592-1de9-4c235888cc8a@intel.com>
In-Reply-To: <a170cf65-6884-3592-1de9-4c235888cc8a@intel.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.12.0.181014
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com; 
x-originating-ip: [70.65.250.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YQXPR0101MB1478;6:yWgghuWQL8Tx9By3K9uvEMDZdHYEIQkdmO0IY1BMTX89XQRZzO/9NgEr90b2pO0wTZVuP76aN8H8P4j4FqEZCzkJdLYkgEKvjYyltMAC8B1dwPKygK0HGvgxvUc+lohFkWA1g40+srHyKitfdm+cUgSxMeU9nSECaMfNc0AyIZuYMGnmsjVlBVp8Np6nGUGMKOIL7HQfj/cVIQhmxLGAVZsHSVbXBrv9QfAM+RpDgtNk2DN1UmWt66gozbU/qNydsaEA0zCC0zyoG6QUFD+bFq4RCFuYSDHKRaEPRf+wPTdTSVtaaQG1U2V2mOoJzf9PF93LYXQAVgCr0+egEY1NWO4uwQiBR4DVnw7FF7kBmxdwBkantWcSFBAIkPXf1XSdosW/P3KFlP+xRzGl6sSVDeuPjy48ufjucGkLebLmnBuDEIpYfaHQAUN3mrAKaDd8JvmAdSDfl85qgjI6CidC5Q==;5:DkQigZzWPAGv4PP5hw4TF0iFb0/Vxs4h92/bLzAuCHfJryt60EI/mNJc4dqFooRYyUnKyFufSrf73+J2k1vqHF4rxCAuTCVwfYvqRSHl/b00TL+GaKA9yr+FpU9nTZWb7X2Hpj28bGYm7KhyZAMhMntWso4I9ixdwqYXmr3K584=;7:RasYZLALAKUpS/Smv6VV5/BkKSR6mDsGGgj7v1Ri2+TaT3qfaps068oSY9nDUp0qMTTm1osVOhdHo6/94/mHibNLvQbTJ4MM8HA1e6II6IdbMnErz6A/ipkRe/VlJYE2k0BjP6FBKBOrZX0jitP/9A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 50fb55d8-a86e-47f4-3f6c-08d64019e3b7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:YQXPR0101MB1478;
x-ms-traffictypediagnostic: YQXPR0101MB1478:
x-microsoft-antispam-prvs: <YQXPR0101MB1478287EBAC2E52090A4D3F0AACE0@YQXPR0101MB1478.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:YQXPR0101MB1478;BCL:0;PCL:0;RULEID:;SRVR:YQXPR0101MB1478;
x-forefront-prvs: 0843C17679
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39830400003)(396003)(346002)(376002)(199004)(189003)(36756003)(4326008)(33656002)(2906002)(186003)(25786009)(66066001)(2501003)(5250100002)(6116002)(3846002)(102836004)(229853002)(26005)(83716004)(71200400001)(71190400001)(99286004)(82746002)(5660300001)(6512007)(6436002)(6486002)(76176011)(14454004)(508600001)(58126008)(110136005)(54906003)(6506007)(316002)(8936002)(105586002)(8676002)(106356001)(6246003)(81166006)(81156014)(68736007)(53936002)(2616005)(97736004)(486006)(476003)(2201001)(11346002)(446003)(7736002)(14444005)(256004)(86362001)(305945005)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:YQXPR0101MB1478;H:YQXPR0101MB0728.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: raithlin.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MIuGO0JLDQsP4DJ6ye7JgVOVL2bYe+sPUA7lH3oTXnZydG+euLdDFiELKd8UR3twyU530aCZWkmRaBqLBVaCYJ7PbgKteTE9A9yILzKbWRu9wHLkZhp5PXokwTbqTOBFV307C0XPskJirABusAs5jnpc73Q/C2nq5KkKdopxEH3RUGsClc8THm8YwWq9T3CeD+0/9tkrCELYi62vUZx9s1HWADkUSNze316qO0uH9N/3bFxjJbH1qJRRkE+7T5IwCC2YC8ACYe6JKpA0rTnz/ddMJ4XZM20g2PzDjeq4l3STx4jK/F3vye4eopukcyauPPvSIt/pYlFqEQbXJ2R7Cbt/0TNDgHbul6d6JFchYeo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CCE403BA2BB1D4EB43A5CB60653040B@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fb55d8-a86e-47f4-3f6c-08d64019e3b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2018 16:48:45.7720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR0101MB1478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAgICBJIHVzZSBnZW5fcG9vbF9maXJzdF9maXRfYWxpZ24oKSBhcyBwb29sIGFsbG9jYXRpb24g
YWxnb3JpdGhtIGFsbG9jYXRpbmcNCj4gICAgYnVmZmVycyB3aXRoIHJlcXVlc3RlZCBhbGlnbm1l
bnQuIEJ1dCBpZiBhIGNodW5rIGJhc2UgYWRkcmVzcyBpcyBub3QNCj4gICAgYWxpZ25lZCB0byB0
aGUgcmVxdWVzdGVkIGFsaWdubWVudChmcm9tIHNvbWUgcmVhc29uKSwgdGhlIHJldHVybmVkDQo+
ICAgIGFkZHJlc3MgaXMgbm90IGFsaWduZWQgdG9vLg0KICAgIA0KQWxleGV5DQoNCkNhbiB5b3Ug
dHJ5IHVzaW5nIGdlbl9wb29sX2ZpcnN0X2ZpdF9vcmRlcl9hbGlnbigpPyBXaWxsIHRoYXQgZ2l2
ZSB5b3UgdGhlIGFsaWdubWVudCB5b3UgbmVlZD8NCg0KU3RlcGhlbg0KICAgIA0KDQo=

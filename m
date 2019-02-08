Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0145AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09172177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MicronCorp.onmicrosoft.com header.i=@MicronCorp.onmicrosoft.com header.b="MxibuHe9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfBHPIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:08:02 -0500
Received: from mailout.micron.com ([137.201.242.129]:53775 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfBHPIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:08:01 -0500
Received: from mail.micron.com (bowex17d.micron.com [137.201.21.212])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id x18F7oWI011213;
        Fri, 8 Feb 2019 08:07:50 -0700
Received: from BOWEX17G.micron.com (137.201.20.31) by bowex17d.micron.com
 (137.201.21.212) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Fri, 8 Feb
 2019 08:07:50 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (137.201.20.7) by
 BOWEX17G.micron.com (137.201.20.31) with Microsoft SMTP Server (TLS) id
 15.0.1365.1 via Frontend Transport; Fri, 8 Feb 2019 08:07:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicronCorp.onmicrosoft.com; s=selector1-micron-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAn2kUel33oSx2NIO3/e2HhGmh8vmuMvi933uFct184=;
 b=MxibuHe9KKYzq0XI6zAapA4A7Nmq9v6CRLO06sDcMeaNZML1Pyxc9zaCWbe/J2Xl2nzT+qwz8Sry09+UEkM8xfEZsL+dS8vcJxO184hfqOhB5ay8Q/Xd+qPGU/0dpmy5twdkSVQkJQ0E0NmX0KPlb14CADfnNU4kFgKJ+3/BiNE=
Received: from BYAPR08MB4533.namprd08.prod.outlook.com (52.135.234.15) by
 BYAPR08MB4341.namprd08.prod.outlook.com (52.135.211.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Fri, 8 Feb 2019 15:07:47 +0000
Received: from BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669]) by BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669%3]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 15:07:47 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "richard@nod.at" <richard@nod.at>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>
Subject: RE: [EXT] Re: [PATCH v2] mtd: spi-nor: Fix wrong abbreviation HWCPAS
Thread-Topic: [EXT] Re: [PATCH v2] mtd: spi-nor: Fix wrong abbreviation HWCPAS
Thread-Index: AdS/uVD1jG3UvCBSRuC2oJ8LRRcc4gAA03cAAAC603A=
Date:   Fri, 8 Feb 2019 15:07:46 +0000
Message-ID: <BYAPR08MB45337F022B1E38B34EE1202FDB690@BYAPR08MB4533.namprd08.prod.outlook.com>
References: <BYAPR08MB4533C8EA6B775C7514FA7F82DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
 <298d18cf-094b-d5d0-45d1-39c7b75ba309@microchip.com>
In-Reply-To: <298d18cf-094b-d5d0-45d1-39c7b75ba309@microchip.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-originating-ip: [165.225.81.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4341;6:8V5qaRQ49i9Rk2ph/Bkd3JKk2ORT+wOIPp7A2DSj4SgvbpMzxCayZF90FyaT1oxCzhztKCjaHLx60vhBosNCVwBbMSkh53nRC8t00ywXvahBFHRL2pO5RaeENtHQ9MYVne0VNiKgCK5wR9uIK/2cbNdyHpJShCBEpz5MLjxKcXjSmsGwWTKm0WxGbi1SnvTTc9FixJoVHI+uCqVK1dwIffto7zJLLRpptmI+d7CrLFFDjvXQZaNec9YBMqW6FykZNelAoCbdr+gCKrGo9+WJjgCI9imC+yg6wvtksWCXCytLJffaLr+TmipLU9YUgSppgFy7w18bFxPWHK2i1SFZFuCIh2mu84RzsteSQvCInpPpdCw87j428op072VkEymfyoxYkNNncE9utVEXaVAsIxZ2X40Tp7+GloMpRiZu9a/ffOzauYv1am8or0RkIy6QhuyMmyVqKN1y6ZOaJBKmnQ==;5:xvWvm6GnspIRQdHg0K0oFzf4aSHs76Sd7Ti+mJ+oj1p09TepGMv9a5d2QE/ZZIQTJEyVqARz9evViwUTT1MAL39LmUSs5LdylXA4GhHTACG42mDIn0EtCZ7dcEbbLNINi4xjsBLODXn0H0WxwPrNNk+ESJRSJm5zczMZ4gbMJ036QGjwas3tHL0J4ge1wHFjVwXA/tyJbSR6beKgwR6L2A==;7:e07F/C3Ipv16MQjF46EkynOWKbuo+OzVmyKkZKv88UWaxprZroSTcOJkhzkMHt4A15Pd5q7k9aJ+7RRtAGHaj6XR36l49w4RFafmhpSIEyJkDjLZt9/5DEsNCe6wRoZ+4bVVC1+Qa4mDwSi72RvT4w==
x-ms-office365-filtering-correlation-id: 45cea562-212e-4a9b-4db9-08d68dd72f46
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4341;
x-ms-traffictypediagnostic: BYAPR08MB4341:|BYAPR08MB4341:
x-microsoft-antispam-prvs: <BYAPR08MB4341186FC75D373DECA472A6DB690@BYAPR08MB4341.namprd08.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(396003)(136003)(346002)(199004)(189003)(446003)(9686003)(14444005)(2501003)(102836004)(81156014)(81166006)(8676002)(55016002)(305945005)(4326008)(256004)(186003)(7736002)(478600001)(71190400001)(110136005)(71200400001)(8936002)(74316002)(6436002)(2201001)(11346002)(476003)(14454004)(486006)(25786009)(4744005)(26005)(53936002)(6246003)(68736007)(316002)(86362001)(97736004)(54906003)(33656002)(229853002)(7696005)(106356001)(105586002)(66066001)(2906002)(76176011)(3846002)(6116002)(6506007)(55236004)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR08MB4341;H:BYAPR08MB4533.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8+QoKhBoYC0iq39027CSD1dtseAWl6sdf5x9I3f4X13Dus2kxrSF3u2WPUdxNgziv93UYrYrXmjV9ajL6aUwRwpN/Di2V1NbTPtWD284C7YJD0Iytjxx8A5M5Vm9jYkei4ZAGfrSiyGG4dFgbfnDX+bKShG4ASLKMvgB+jXqgXcb0l9q7Iinrbyu7b/gKjct0qdB88Qn9olD6cMip3ajTp2ZYHkf9zZcfYCMt8w7c8yQ0Nz9A9JxXoUfgq/KxisIeEayXt8MFt16FLoqOnUIACYfo+ouOJAbNVLbCxJl0H4luMzuRILP58f3FAsj14Jm8M1kXJJVCXLie3KbLP6loLqDrR4Miexczzv0K5RbIGaJGNBZ+ZQsOwNbig7iWMHSmAyeNKQYu8NPhHHWxCbRexW9H0SAECVFEeCm4Ct70mk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cea562-212e-4a9b-4db9-08d68dd72f46
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 15:07:46.9615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4341
X-OriginatorOrg: micron.com
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24416.005
X-TM-AS-Result: No--3.691000-0.000000-31
X-TM-AS-MatchedID: 150567-706159-705178-703283-703440-701670-705718-701177-1
        39010-851106-700075-701236-703179-703969-704034-106230-148004-148007-148020
        -148050-10019-41000-42000-42003-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-CheckInternalSenderRule: True
X-Scanned-By: MIMEDefang 2.78 on 137.201.82.98
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tudor

./scripts/checkpatch.pl --strict 0001-mtd-spi-nor-Fix-wrong-abbreviation-HW=
CPAS.patch=20
total: 0 errors, 0 warnings, 0 checks, 8 lines checked

0001-mtd-spi-nor-Fix-wrong-abbreviation-HWCPAS.patch has no obvious style p=
roblems and is ready for submission.

>
>On 02/08/2019 04:23 PM, Bean Huo (beanhuo) wrote:
>> Change SNOR_HWCPAS_READ_OCTAL to SNOR_HWCAPS_READ_OCTAL.
>>
>> Signed-off-by: Bean Huo <beanhuo@micron.com>
>
>$ ./scripts/checkpatch.pl --strict
>v2-mtd-spi-nor-Fix-wrong-abbreviation-HWCPAS.patch
>WARNING: Missing Signed-off-by: line by nominal patch author 'Bean Huo
>(beanhuo) <beanhuo@micron.com>'
>=20
'Bean Huo (beanhuo) <beanhuo@micron.com>' is wrong.
 If you prefer to 'Bean Huo (beanhuo) <beanhuo@micron.com>, would you pleas=
e change that.

//Bean

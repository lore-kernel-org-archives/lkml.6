Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548C5C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0CB21B24
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="epj4N+1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbfBKSJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:09:30 -0500
Received: from mail-eopbgr1310099.outbound.protection.outlook.com ([40.107.131.99]:24123
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727007AbfBKSJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez/0OYxRn7GpMjevm6Eno1VnfKSnvNq8jg5Tscd8Qmg=;
 b=epj4N+1vwpmnpa5V+v+grGhE/mAGIGsKvfINEzxn+/ffiKnWxVDXAiJvk/NQEtin2ahtu+6OskO330AYpLnA6Q9XyzbMCIdLElWkF3sdlVcYLfczvkEMElAPmU+HA0f/7JljB3WLsEc65kjcaGxuSTmraxvHqzxhRoUr7Klsjv4=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0155.APCP153.PROD.OUTLOOK.COM (10.170.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.1; Mon, 11 Feb 2019 18:09:09 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1643.004; Mon, 11 Feb 2019
 18:09:09 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Add hv_pci_remove_slots() when we unload the
 driver
Thread-Topic: [PATCH] PCI: hv: Add hv_pci_remove_slots() when we unload the
 driver
Thread-Index: AdS/JKy4gHBOTZqYQrqpJy5ySOaIggDCjMYAAAE5viA=
Date:   Mon, 11 Feb 2019 18:09:08 +0000
Message-ID: <PU1P153MB0169377DB326432229381E95BF640@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169F06340FC519C2802C5CFBF680@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190211172608.E873D2229F@mail.kernel.org>
In-Reply-To: <20190211172608.E873D2229F@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-11T18:09:06.9374675Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ee53a6f0-00f3-4af0-ba31-31c50060a84f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2601:600:a280:1760:5896:cf8a:cefe:fd7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0155;6:9gREU8nn65fygcmZBPbZx9FR0PxUWmZupLFdsiZMxcQebCUvPnY4YQsuaN1GgqB0/eAknyTboxdRnmPJ4JawjzSPd22gctsYDNEENmvH1n3V7N+76FBjYUrrl/KtQqSChIQFasxHyKrwDK6IBlAzQS2r9GMxwsoNMS1y3BuZgA41vUGIqP93mEmFEV71MS0sOR9LhNwir1pgtuFKUZCctWSTr43wNer/xxQFEMlVYrgXboVQ+iwVE5/VM8YrhcYLquvYWvstkLwWLZ4XKc4txVk+swoVsX/GLBaU4P8xQYn+eVEOp61FnB+wZtVEG/nsVkFmxeRZuItb8qo/4cMrHVBtzxIXhtrdhB7euVp78UXwDwLsKbHH1Cekqd+RAHt7Tje4uBUV/FO7CU1xiUO8Fg0sUPwD7QBt7zpkIShOxcHgBredaq4LCPiOMWx68STU0zaKblAHEqIp90JwBQSZbg==;5:+bQ17ddgd0Lp8OMrJ4StleLUly0eGvVryb6Qx7d/eLZ+G+EysamWX+0AgFCrK1PawWRxV0+8zHQTOFYV2RoKQ2jva6uzcu5s8B7sFNo5a+nBPsGo6Q4WDaM80/AWcNOUmYuARnASKP+IWskLpvYyqIBAYrEt87mz5mxFDdL7CE4t6FvryzO36rj35MyDSrgWbNaFMQm9D+GvtMIc9zxNfg==;7:5zDgm7b3j8VlJsin4nnWr6QZm+EMqvvxp2SxTazwe+LO9ZB9VdU/oul+ZJWJ+HqrUesizOk1RSR67P3bBrIxsQgdVyFT+G5a2SVOQSe86JieKT6ihz4+fuqR8/nLmtpUx803MdhgLOWgrnfG2aukgw==
x-ms-office365-filtering-correlation-id: 0fa626cd-69dc-4c5b-5348-08d6904c04b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0155;
x-ms-traffictypediagnostic: PU1P153MB0155:
x-microsoft-antispam-prvs: <PU1P153MB0155F05E52F24E3CB2E8568BBF640@PU1P153MB0155.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(40224003)(305945005)(7736002)(8936002)(86362001)(76176011)(106356001)(105586002)(2906002)(33656002)(6116002)(110136005)(4744005)(86612001)(53936002)(71190400001)(71200400001)(10090500001)(316002)(229853002)(14454004)(8990500004)(97736004)(99286004)(6436002)(7696005)(6246003)(478600001)(4326008)(186003)(68736007)(6346003)(11346002)(74316002)(486006)(54906003)(25786009)(53546011)(81156014)(81166006)(55016002)(8676002)(9686003)(102836004)(22452003)(46003)(256004)(6506007)(446003)(476003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0155;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NYsQSKjKIGb7YYAJMX7JKn/uzjb96rb7+p/vZnmuwj/YqqwE5tu+AwRPkR/NHvZNNyfwqntdMY+0IO23ZfbFH6IWt6ZePtFymvAKIP+YC0Q81NqAOtJsJ0X9LqK2xrWKWfCo2XcuL1GYXLS/ZASktrSgGUT1Y9zqoAHqTwuUWJ27peVbJMaIYb5TCOqwNrjP1vICwF95jN1eg2cwCkTfkeRD5YB5EsNopEMTv7Xr633Yv7OjhETyyRtSnSFy+a7jfNm7xn3d82kT/3Ue4Std9D0O/dgXtrxhGDwwI+S0/CNoCTqd+gIbe8vcVWEbbhyNOmG9l7soSvzXfgeodgb9TSDOkPMSOo3B4fHDI5A2/arpvt9bQNnwzdPHNTNeuwborsXhH+hFoPzE3g9q2z8qluI4aiPbBi3JVQQC7MQKDVA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa626cd-69dc-4c5b-5348-08d6904c04b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 18:09:08.6780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Sasha Levin <sashal@kernel.org>
> Sent: Monday, February 11, 2019 9:26 AM
> To: Sasha Levin <sashal@kernel.org>; Dexuan Cui <decui@microsoft.com>;
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org; Stephen Hemming=
er
> <sthemmin@microsoft.com>; stable@vger.kernel.org
> Subject: Re: [PATCH] PCI: hv: Add hv_pci_remove_slots() when we unload th=
e
> driver
>=20
> Hi,
>=20
> [This is an automated email]
>=20
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: a15f2c08c708 PCI: hv: support reporting serial number as s=
lot
> information.
>=20
> The bot has tested the following trees: v4.20.7, v4.19.20, v4.14.98.
>=20
> v4.20.7: Build OK!
> v4.19.20: Build OK!
> v4.14.98: Failed to apply! Possible dependencies:
>     Unable to calculate
> How should we proceed with this patch?
> Sasha

In v4.14.y, the file name is drivers/pci/host/pci-hyperv.c rather than
drivers/pci/controller/pci-hyperv.c. After I changed the folder name in the=
 patch,
I could "git am" it cleanly on v4.14.98.

Thanks,
-- Dexuan

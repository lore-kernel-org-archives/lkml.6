Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B2AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0A52080A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Z+A9WUqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfBHUFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 15:05:54 -0500
Received: from mail-eopbgr690086.outbound.protection.outlook.com ([40.107.69.86]:21861
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbfBHUFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 15:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=115jSkwRME9ke9gcjGGs3tkFGMC7OzyYVh2r/EWPaGE=;
 b=Z+A9WUqD+V3pe9r2XOobtIQ30XvUOSmtv4g7e89huJvnFWkC6WytLER/aOlNH72uBftGb3VHk8SmXL9MainS7RqTlh+uJ136U7ZYiITEiEVwN52meCsNkj/f4moBxsbhbypUP38XQ/Fk/p0Nn5hGfo1A98KhHn5XXsS9do+C9cw=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5925.namprd05.prod.outlook.com (20.178.50.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.16; Fri, 8 Feb 2019 20:05:50 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::99ab:18fb:f393:df31]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::99ab:18fb:f393:df31%3]) with mapi id 15.20.1622.010; Fri, 8 Feb 2019
 20:05:50 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
        Julien Freche <jfreche@vmware.com>
Subject: Re: [PATCH 2/6] vmw_balloon: support 64-bit memory limit
Thread-Topic: [PATCH 2/6] vmw_balloon: support 64-bit memory limit
Thread-Index: AQHUvneykVD8LBCmaUCO4sjydkV71qXVwbqAgACUtYA=
Date:   Fri, 8 Feb 2019 20:05:50 +0000
Message-ID: <5C8E9F70-0403-433E-8644-E6505FBE7DEF@vmware.com>
References: <20190206235706.4851-1-namit@vmware.com>
 <20190206235706.4851-3-namit@vmware.com> <20190208111335.GA3632@kroah.com>
In-Reply-To: <20190208111335.GA3632@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5925;20:auIpgBYEAx7vs9cujoD/NqwCtlRYM1AfkV0BQxt/ytuXzbLMGf2LJnGZI9e0ldu0B7XSG5ZdhSxMfuU7gbAl6hnsonael+sEwtSRTFWs4u3F9T/CfJYS8CQCHyr10GUXZh9GRxBPsAuZCwPQ8AbYE/kbH4skmnZqYSb2zC0iPLA=
x-ms-office365-filtering-correlation-id: 27e6aa4f-42d1-4c00-55b3-08d68e00d2d6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5925;
x-ms-traffictypediagnostic: BYAPR05MB5925:
x-microsoft-antispam-prvs: <BYAPR05MB5925AC92591F7D76F2D9459CD0690@BYAPR05MB5925.namprd05.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(136003)(346002)(199004)(189003)(99286004)(26005)(97736004)(8936002)(66066001)(6116002)(54906003)(6506007)(81166006)(6346003)(53546011)(8676002)(446003)(316002)(6512007)(81156014)(102836004)(3846002)(33656002)(186003)(14454004)(76176011)(478600001)(105586002)(106356001)(68736007)(6436002)(86362001)(25786009)(229853002)(6486002)(107886003)(6916009)(4326008)(7736002)(486006)(6246003)(82746002)(71190400001)(71200400001)(2616005)(2906002)(476003)(53936002)(83716004)(11346002)(256004)(36756003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5925;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /vUn7eZeV7yuWhI1FUyBraryXAvYNuA81d+CjSWdvSazxGHxxDseKeyaPRg1oF9SMaS1Kn1FM1hzTHZjN+lQTRXeq3Jf1aW0yyF5Kv42OrndMXGfQ5pKj0xyMXlzciAPBSCHOFTqktfA/1DxH4Yt2AoAgVFpXAAtc4oS1rWxPuzVKd0EzJkrkmwm2ob5M0VqUBo9dMw/5m0AjaybSl0rEqKRmvW2e2xGWVoHdf4qhGhzHe1LvaKo4rbKidYTh3BdJi1TG7pClkZSAVgAFXolJWD6HiryxbGq/QhF76N2Jflb1SeSGjNgQpZboivZHBw2z9Tf74ENT4/QZTTAwLKl5HYrYz463jFgOrJZEMi8LH71JeE0LO5grGPaW69y31jaNhT3fclmZWy9k1uyZK0IcM6UoAFJ+n/IbUC0+Q3jBB0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D72132A915F9CE4EA0283458949D5D46@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e6aa4f-42d1-4c00-55b3-08d68e00d2d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 20:05:50.5638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5925
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 8, 2019, at 3:13 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.or=
g> wrote:
>=20
> On Wed, Feb 06, 2019 at 03:57:02PM -0800, Nadav Amit wrote:
>> From: Xavier Deguillard <xdeguillard@vmware.com>
>>=20
>> Currently, the balloon driver would fail to run if memory is greater
>> than 16TB of vRAM. Previous patches have already converted the balloon
>> target and size to 64-bit, so all that is left to do add is to avoid
>> asserting memory is smaller than 16TB if the hypervisor supports 64-bits
>> target.
>>=20
>> The driver advertises a new capability VMW_BALLOON_64_BITS_TARGET.
>> Hypervisors that support 16TB of memory or more will report that this
>> capability is enabled.
>>=20
>> Signed-off-by: Xavier Deguillard <xdeguillard@vmware.com>
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> ---
>> drivers/misc/vmw_balloon.c | 18 +++++++++++++++---
>> 1 file changed, 15 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
>> index c4371ec132d3..f96dc3690ade 100644
>> --- a/drivers/misc/vmw_balloon.c
>> +++ b/drivers/misc/vmw_balloon.c
>> @@ -72,15 +72,26 @@ enum vmwballoon_capabilities {
>> 	VMW_BALLOON_BATCHED_CMDS		=3D (1 << 2),
>> 	VMW_BALLOON_BATCHED_2M_CMDS		=3D (1 << 3),
>> 	VMW_BALLOON_SIGNALLED_WAKEUP_CMD	=3D (1 << 4),
>> +	VMW_BALLOON_64_BIT_TARGET		=3D (1 << 5)
>=20
> Nit, this should be BIT(5), right?
>=20
> You can change that in a later patch...

Will do.


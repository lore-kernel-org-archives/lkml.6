Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E219C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EE7218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="pcOyrRnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfAXQox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:44:53 -0500
Received: from mail-eopbgr30086.outbound.protection.outlook.com ([40.107.3.86]:16197
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbfAXQow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:44:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATU242sXFMzXLd35PPDkjLLOoXouunIWXxLVaTaOBec=;
 b=pcOyrRnZ06jtTC683cyZ7H/6rIsghp/G0ei9YjXbZYrv2mFFPaOrg2o/2s8d7Wu0ooUNh/8J3CiqNolQieGxbg+0nKWLgY+cEeG8/EFuovM1v2rryq4TavTeh9ip3QVnq4laLzx4J5LjNGxaFHGi3AK55fmUH/2fBHIG6rX+hmk=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0PR08MB3156.eurprd08.prod.outlook.com (52.134.93.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 24 Jan 2019 16:44:48 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18%3]) with mapi id 15.20.1558.016; Thu, 24 Jan 2019
 16:44:48 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "Andrew F. Davis" <afd@ti.com>
CC:     Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on
 map/unmap
Thread-Topic: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on
 map/unmap
Thread-Index: AQHUrQGAzRpl+6N4dEWaN50+01WrkqWwqYAAgAFaUACAAB1/AIAAYa0AgAElgYCAAJLkAIABDbeAgARUHICAAKdjgIABUooAgAGGmwCAAAW5gIABf5QAgAALL4A=
Date:   Thu, 24 Jan 2019 16:44:48 +0000
Message-ID: <20190124164447.3dwwampprzofwbyr@DESKTOP-E1NTVVP.localdomain>
References: <alpine.DEB.2.10.1901161450470.10666@lmark-linux.qualcomm.com>
 <3bf4bfce-aee6-9c52-c2f7-783dc63bfc3a@ti.com>
 <alpine.DEB.2.10.1901171704270.12287@lmark-linux.qualcomm.com>
 <b8b16d71-e09b-6bf9-259e-79c1de7fd15b@ti.com>
 <20190121112235.g36qqptpv6wjuj7w@DESKTOP-E1NTVVP.localdomain>
 <b89df12e-00bc-5484-6458-f7c85a362b42@ti.com>
 <CAO_48GEYPW0u6uWkkFgqjmmabLcBm69OD34QihSNGewqz_AqSQ@mail.gmail.com>
 <d24949d2-3736-0e6f-99ae-b8550d53a828@ti.com>
 <20190123171153.ql25gyg6sma4fpqb@DESKTOP-E1NTVVP.localdomain>
 <af5c22b2-0d9e-4bd1-6fdd-1a3880890916@ti.com>
In-Reply-To: <af5c22b2-0d9e-4bd1-6fdd-1a3880890916@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0059.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::23) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3156;6:t3Y2zCYCZupu7eEFcp01El7HSHVaP1x0070VYDQCybioXU11WphwZdMIYNLnsVK0QpJh6pCjBC3tROVEPDWeUa7rLI6D0Lv8Y6SsSeHIKcLINjpqWJ7sjIFHbaYHf0bDPb7dZBoLwqO+IYFVvIkqOxE2nx6cqC0l9+FySfEIzp5mIRHcB3whsxVdnVf1f35OtDx+ICkf0T2qg02zW787zomwV6Zewg14QJJPWoLgPcbiSek99TShBNBMKIlzIOFIbfMBlKra21+TntI5sCAzic/lODEOcXcZHgo50ofWEPOhFrLHDJE5kB2HAL5f2lG+hpuavAS2s0vghlW7oP7ExwFNvGuaJWbHUMEzho6to1xKcvgq3N1O9x6duqp0K+TxgRcEpKwqSOh5fQLUAO+bkbHx4WuzlgcWZBLhqyiFFmITY0ojhRj8MceeiY9yrhHhPzmUlVkU4IMpNyQO2f66ww==;5:ELUf2ve3SvDsJYQgZdk9dcy2XO0vOSnkRALU5LFi2QFHbhQFqRDZDKVtabrvbI5BK6AfhP+JouLEm1gpORXUhELloAz1QDzEdVtVW16dp5X4oV3pSrVzOrvkMuxkVApG1VrVjnkMidwDC4p05WcIAJmhd8z3g9MgQAs+rcCHmBA9CeEPSv4RHTEgNQwya7lrnRz+OHTx888AGW44qWN2EA==;7:XY8g+RUdoGvCDMaWTs+jJDASS6dEpt1DMePFJdBUPKfrjOXAqhuCyXAYt6AlxDydwTS7vDY+v1CqQQICxR3EeeBZN+HRVzZHJT5WQtoVoTYOsn0HqYQZDs2IRVub5/wFNrS84+pAAAUSObV2ucbYLg==
x-ms-office365-filtering-correlation-id: df3fa195-b821-472f-87d4-08d6821b40ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3156;
x-ms-traffictypediagnostic: AM0PR08MB3156:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3156E746D07F46E95939E247F09A0@AM0PR08MB3156.eurprd08.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(11346002)(486006)(25786009)(476003)(58126008)(316002)(6916009)(44832011)(54906003)(86362001)(6306002)(102836004)(6512007)(186003)(9686003)(6116002)(3846002)(2906002)(53936002)(81156014)(81166006)(6486002)(8676002)(6506007)(8936002)(53546011)(26005)(386003)(52116002)(71200400001)(99286004)(68736007)(446003)(71190400001)(6246003)(33896004)(7736002)(305945005)(6436002)(106356001)(4744005)(66066001)(7416002)(478600001)(256004)(1076003)(72206003)(14454004)(4326008)(105586002)(97736004)(229853002)(966005)(93886005)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3156;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pfQ6cB2ymdPDqckcz3PShnKHjMk+eRrqzJkIp1xaVAOoHLYArotjwH2JHWJEPcNmza3wr3OElpEe/nUeb30HXl5ugi9sTe0BOXSmFKXgvk2jiedue46FLoCDzTTaXvrEdBPAu2qlBl8veae1uxEdwwsIE+JMqXlfOlfDioLWALAVTGiqlHivdfAJUZMPBT7TwkjOxsD2FZz/efFQEHccoCZ8GpInrb2ZbxaCs0Ogrofm9f2bQAETcv4DipEVx/amfMyf5edVUSGDDRMVq+x+YjYHviRO+UV3CU3EiqE6PpThYaD8Mkc5EEZgGn8cZ8Richo4oKKkZE1jPylpdjec3HCCVGzqrTCRbC25NEk6WroD/hNltPqZbknlhBqys4HN2C0uV9ctb3LbyaLg2U2QBF+CHXyGsDUDHxbpaFzDH7A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <F8AA73A0E4E6BD49B4AF2C2AA83CDC74@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3fa195-b821-472f-87d4-08d6821b40ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 16:44:48.0105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 10:04:46AM -0600, Andrew F. Davis wrote:
> On 1/23/19 11:11 AM, Brian Starkey wrote:

[snip]

>=20
> I'm very new to all this, so any pointers to history in this area are
> appreciated.
>=20

[snip]

>=20
> > In case you didn't come across it already, the effort which seems to
> > have gained the most "air-time" recently is
> > https://github.com/cubanismo/allocator, which is still a userspace
> > module (perhaps some concepts from there could go into the kernel?),
> > but makes some attempts at generic constraint solving. It's also not
> > really moving anywhere at the moment.
> >=20
>=20
> Very interesting, I'm going to have to stare at this for a bit.

In which case, some reading material that might be of interest :-)

https://www.x.org/wiki/Events/XDC2016/Program/Unix_Device_Memory_Allocation=
.pdf
https://www.x.org/wiki/Events/XDC2017/jones_allocator.pdf
https://lists.freedesktop.org/archives/mesa-dev/2017-November/177632.html

-Brian


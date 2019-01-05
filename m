Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E134FC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 21:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4F3222EB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 21:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FIuHnl07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfAEVBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 16:01:18 -0500
Received: from mail-eopbgr680120.outbound.protection.outlook.com ([40.107.68.120]:52653
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726267AbfAEVBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 16:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cHhzS2bjd1JhUoJqB5Llg2Ww2EvelFgyT0041VSbTo=;
 b=FIuHnl07YhDRRl+uZMP1IYT/WuvEwVHwSP5m1vjridPzJ5sU35ve1mA41mlniEBi+9pbIvC8hyYVqNc/2/3CMoy8KUJSkZGcvKBoCFTUrLZr57kJp30vx9TeWOA4m6zh7vxmNySjWWKdKD8oWtFaC8yufTDuUoazDEdpICk84CA=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.4; Sat, 5 Jan 2019 21:01:08 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::704f:14f3:5d34:cf6]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::704f:14f3:5d34:cf6%3]) with mapi id 15.20.1516.000; Sat, 5 Jan 2019
 21:01:07 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kimbrownkd <kimbrownkd@gmail.com>, Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] Drivers: hv: vmbus: Expose counters for interrupts and
 full conditions
Thread-Topic: [PATCH v2] Drivers: hv: vmbus: Expose counters for interrupts
 and full conditions
Thread-Index: AQHUpLAU1Q/2YfEbRkGAkXaUeYtNvqWhJZ5Q
Date:   Sat, 5 Jan 2019 21:01:07 +0000
Message-ID: <CY4PR21MB07733E3D30FD5FCB7A945CA6D78F0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <0181213190901.GA3843@ubu-Virtual-Machine>
 <20190105043518.GA4072@ubu-Virtual-Machine>
In-Reply-To: <20190105043518.GA4072@ubu-Virtual-Machine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-05T21:01:04.8619684Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2605:e000:ccc4:8800:dcbf:42e7:5afa:6bf3]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:sOSOo32hPLBJFg4Bz/YcdXvVOjdv283J6onDPsNw6HaJfAcHnXIEzZEYkhklZzt4REZZrZCIyUYDevywh3GoPC1lG1pab/lkd1YbmkWMcxGqNAgz7UDbwflv0A2dYWBKmRGAIQ03D9Xo+2fOR2Z7DP9/4txABwnQQxB93dqkgwoTEA78ohuGzxcCHsPy6MnlaoxAyV6mC5qM3dm6Fev8tdH2hkhZkKj2MvNprdDg5HZy5kbJpBejvk7fNxz4Kns99UXP6QWPcg0Ez2YyLN/HQ1KEdXuS2z21qG+mLWfv3EXAxq0Cw7vrp7Qm5MHxhImu3kP0B65LRnsZrYIqAD2jdk/S1UdQZ+hIrqI9GTyQxteCsQMnNGXugrnJG8nMPfkTouvjbFvW1VhSd8zx5mUMusX4q2WFa9yUvsnEtzBRs7CuiC+FJb9vVFbwDJgvn4h/0NNKlgbPvUyD69CFLJ+IjA==;5:jdQVVFt/Kt/K2O4ofq4YP+kmgIXPNiGsPeAEWFLJBCM66AiYbxGPK93mxlc0CwO+3AHPKj5rc98ZXVcCvsa6O9Gq4trNuYWJW3j7Jukqg5YEmACbELpBngydP+KCrFvOgLvF9+jC8YF/5qjEjGGSfIWC/vlclZIb6BnTppQAomDYoo/tfxH6/sXVQHfSzzvIqSFHwe7RBQG8TRdLRDUvPA==;7:S4q4vmaVRYqqqKwVf81hPVeM6jYbqYByrnIQbpYjwc3wqHlOcavXK/sTjmzX8qEoDQ/yAvMNn/kjgm5Dl/29hYuLQrpS90a8M3Wym30RFfpsqKQH0uxU3d6AHnEQUGiv9nA7ljEMjBKw+ZFWGGRv4w==
x-ms-office365-filtering-correlation-id: 7abfefba-dd77-4b8a-d4fe-08d67350e9f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-ms-exchange-purlcount: -3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB012089CB20477FDC754B51DBD78F0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(2018427008)(3002001)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 09086FB5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(396003)(39860400002)(346002)(199004)(189003)(55016002)(4326008)(14454004)(25786009)(9686003)(53936002)(33656002)(11346002)(99286004)(10290500003)(478600001)(476003)(105586002)(39060400002)(7736002)(81156014)(8676002)(81166006)(6246003)(71190400001)(446003)(71200400001)(68736007)(2906002)(10090500001)(305945005)(106356001)(6636002)(6116002)(46003)(186003)(6436002)(86612001)(86362001)(6346003)(7696005)(102836004)(76176011)(6506007)(8936002)(54906003)(8990500004)(1511001)(486006)(22452003)(74316002)(5660300001)(316002)(110136005)(229853002)(256004)(14444005)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: de3oMGfVuZnQo0ej8NYSehUmCrNlhlp8IcLqK4NkHIpJBQ18aNuFPhAhi98MpK5KGqnrhMCdtLz4LeSbEqX8OqBu4+4CFgece4IsIYcvNir6woIPrWmI/P+f30JhFAiIXf8lEWaKhOD+mrdPam7fWTYVYGV3lwUwHVQsSB0wsqD5AZ3AeclliTnrjeMJDZq/40p8aHMX+NbwJwg+uhxxT30mGTTrDFCMOGgx5wAwboGKjZli+/QWCUG6EGHQdXzQkQRbihXhta0DYd0ZOkFlqMYK/HA5dQTDunJi9Nek/6hJOnjM/cWq2FlUpilsLYls
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abfefba-dd77-4b8a-d4fe-08d67350e9f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2019 21:01:07.8305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kimberly Brown <kimbrownkd@gmail.com>  Sent: Friday, January 4, 2019 =
8:35 PM

>  static inline void set_channel_pending_send_size(struct vmbus_channel *c=
,
>  						 u32 size)
>  {
> +	if (size) {
> +		++c->out_full_total;
> +
> +		if (!c->out_full_flag) {
> +			++c->out_full_first;
> +			c->out_full_flag =3D true;
> +		}
> +	} else {
> +		c->out_full_flag =3D false;
> +	}
> +
>  	c->outbound.ring_buffer->pending_send_sz =3D size;
>  }
>=20

I think there may be an atomicity problem with the above code.  I looked
in the hv_sock code, and didn't see any locks being held when
set_channel_pending_send_size() is called.   The original code doesn't need
a lock because it is just storing a single value into pending_send_sz.

In the similar code in hv_ringbuffer_write(), the ring buffer spin lock is =
held
while the counts are incremented and the out_full_flag is maintained, so al=
l is
good there.  But some locking may be needed here.  Dexuan knows the hv_sock
code best and can comment on whether there is any higher level synchronizat=
ion
that prevents multiple threads from running the above code on the same chan=
nel.
Even if there is such higher level synchronization, this code probably shou=
ldn't
depend on it for correctness.

Michael

Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70268ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DF7208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="fJGK8Kbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DF7208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbeGLTbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:31:52 -0400
Received: from mail-eopbgr680056.outbound.protection.outlook.com ([40.107.68.56]:59008
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726962AbeGLTbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWqID7rFkX802BzB32D+1VdcITA3D6db5nQPnfGEE/w=;
 b=fJGK8KbrTsbo4l1fizBcd0QONxXg8j3i89yY2RQTJgyxPQT4qONstKJSSaP/H1r/2dEgPL2wJxIDqZQYaa28xP2AmkGZhtfXL08Tkjyvt86ns6g1fi2Xh0nV3mIdb0/bdI+220oucelGe+wNxb71YSfkRP7In+99wg0TkV8TLk4=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5189.namprd07.prod.outlook.com (20.176.254.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Thu, 12 Jul 2018 19:20:56 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::39ca:4bef:3be8:fdf5]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::39ca:4bef:3be8:fdf5%3]) with mapi id 15.20.0952.017; Thu, 12 Jul 2018
 19:20:54 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: RE: [PATCH 01/31] usb: usbssp: Defined register maps and other useful
 structures.
Thread-Topic: [PATCH 01/31] usb: usbssp: Defined register maps and other
 useful structures.
Thread-Index: AQHUGaPfTNlOUM3Lak6bmBJPFm47N6SLGpMAgADaiWA=
Date:   Thu, 12 Jul 2018 19:20:54 +0000
Message-ID: <BYAPR07MB470937899F3E630677B21B2EDD590@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
 <1531374448-26532-2-git-send-email-pawell@cadence.com>
 <20180712060944.GA20905@kroah.com>
In-Reply-To: <20180712060944.GA20905@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYjk0OGY3MzMtODYwOC0xMWU4LTg3MTAtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGI5NDhmNzM0LTg2MDgtMTFlOC04NzEwLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTI2MCIgdD0iMTMxNzU4OTY4NjcxNTQwMzc0IiBoPSJRelNReERHbXB1d2owVTl5VjlzdVhjbUsyM0k9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pawell@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5189;7:bJ3legx6Ty/Li62ZfWHBcZGcSEH9ofixZg0Yh8U6BNo7Elprb1NK0V8DWK6jVGk6MB1nXfynQik2cwgaCvi6qUvszOJldLM9SK8mCcQM5aE8iRYZSYIiYWkVKHq987y2zKvodbFjYMiMcWdEqP8L7PjC9+50XsdJ+tFIh/zzQAE8P2+xcEGLErtXxBy5e8EM4jI/JPquxpA0AMPK+kjLqxgO0oQ/9nACrw1nKmL2+fjZFfpyaQpai83sXgxNGS3t;20:YwfCyuwCj5XdD7fmWHMi8+idTFrspKt4xIukRaw8c86pWsgeckKti9MIPqqNA/YKT7wbK+sGiqV9mfTFW8UicFWRDoKe77OXUALbZC6CHOy7MrdWrNxTPpfPdKzmW+8B7Sdqld/6uCkJ8gXTtWLleOHBZWB990d8SisnFNuBMouhGr3Fq/oXWoLjku2TApQUwDY5lk1yIZLoihZ2i/UbiyTbzfSOUlRpXRpzuqu4CL/ntev33UyQJ0xOGsmx5cCL
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(376002)(396003)(346002)(36092001)(199004)(189003)(2906002)(97736004)(6116002)(316002)(3846002)(102836004)(26005)(6916009)(229853002)(54906003)(53936002)(33656002)(446003)(486006)(476003)(6246003)(107886003)(4326008)(6506007)(5250100002)(8936002)(256004)(7736002)(68736007)(2900100001)(478600001)(305945005)(7696005)(25786009)(105586002)(76176011)(9686003)(11346002)(55016002)(14454004)(86362001)(99286004)(8676002)(81166006)(74316002)(106356001)(6436002)(66066001)(81156014)(5660300001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5189;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: e49b975b-a184-4617-6e17-08d5e82c96d5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5189;
x-ms-traffictypediagnostic: BYAPR07MB5189:
x-microsoft-antispam-prvs: <BYAPR07MB5189E14BC50E1EB2CC965C1BDD590@BYAPR07MB5189.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB5189;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5189;
x-forefront-prvs: 0731AA2DE6
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kPuLLJ7iDve8e3F9qOUppV0tibpXlsqYEHDYc8w5v+NIpFVkmVs0pvlP9Ld/Q2q+rGuXs2UBZ5LF7zULQ9/7U0IvInCTvlv+iEdYgAvgixl+pYqDghsaU1F5b4GRZEwIgARRbO0WZ0hXp1clQb9SwUA09NbRN1rgXKSpdbJvkeGZbW7a9rM5EojvTrBvMP11ISNCKDj5VqLh8Co6v+33i0bqZSrBJFKoFf8+Dno+aQfQx2kDXO+1YwhFpYAZWNAFPU0gsZ5PSLu1wIfidFwbq1WVSaGj3qfCwnRyombdmNUsrKz/D8f+0+ayzN5Kv0S6TtvEm6rwnOOGQt8uN4FTg6fj4QjpcVCRXHRt566r4hg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49b975b-a184-4617-6e17-08d5e82c96d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2018 19:20:54.8647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +/**
> > + * struct usbssp_cap_regs - USBSSP Registers.
> > + * @hc_capbase:		length of the capabilities register and DC
> version number
> > + * @hcs_params1:	HCSPARAMS1 - Structural Parameters 1
> > + * @hcs_params2:	HCSPARAMS2 - Structural Parameters 2
> > + * @hcs_params3:	HCSPARAMS3 - Structural Parameters 3
> > + * @hcc_params:		HCCPARAMS - Capability Parameters
> > + * @db_off:		DBOFF - Doorbell array offset
> > + * @run_regs_off:	RTSOFF - Runtime register space offset
> > + * @hcc_params2:	HCCPARAMS2 Capability Parameters 2,
> > + */
> > +struct usbssp_cap_regs {
> > +	__le32	hc_capbase;
> > +	__le32	hcs_params1;
> > +	__le32	hcs_params2;
> > +	__le32	hcs_params3;
> > +	__le32	hcc_params;
> > +	__le32	db_off;
> > +	__le32	run_regs_off;
> > +	__le32	hcc_params2;
> > +	/* Reserved up to (CAPLENGTH - 0x1C) */ };
>=20
> Does this, and your other structures that map to hardware, need to be
> __packed?

These structures don't need to be __packed. All fields in structures=20
that map to hardware are 32 and 64 bits.=20
It has been working this way in XHCI driver for years.=20

thanks,

Pawel Laszczak


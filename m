Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B10C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583E921884
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="WAEJ3err"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583E921884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753780AbeGEKPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:15:09 -0400
Received: from mail-cys01nam02on0053.outbound.protection.outlook.com ([104.47.37.53]:37520
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753342AbeGEKPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcTWIUzBFEgyWzWZwkH6ZN5/aea4tULFH6Khb7jdRHE=;
 b=WAEJ3err7gs05OI9tKSOuhedmGrn6dnv8yeZwYnL0zjEK++NCmGWZEKXPPdoMM4oVFjAPwNTRNmHAfK/S62oaoaiXwnrPFK1rpcAXlfEKlmxoYL57bzFzWQenGsi6i3s8QGaqAi2T4XiSm3fneOXd5K0ZTqoB9fZeG27y/P6NDE=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4567.namprd07.prod.outlook.com (52.135.226.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Thu, 5 Jul 2018 10:15:05 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8caa:8afb:e029:8035]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8caa:8afb:e029:8035%4]) with mapi id 15.20.0906.027; Thu, 5 Jul 2018
 10:15:04 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>
Subject: RE: [PATCH 01/15] Introduce Cadence USBSSP DRD Driver - added
 gadget.c file.
Thread-Topic: [PATCH 01/15] Introduce Cadence USBSSP DRD Driver - added
 gadget.c file.
Thread-Index: AQHUEwg0mjam0NDH6E2HxFsEVCnkgKR+yIoAgAGggUA=
Date:   Thu, 5 Jul 2018 10:15:04 +0000
Message-ID: <BYAPR07MB4709E76774739A793CACE0D7DD400@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1530647879-10007-1-git-send-email-pawell@cadence.com>
 <1530647879-10007-2-git-send-email-pawell@cadence.com>
 <20180704091342.GA25518@kroah.com>
In-Reply-To: <20180704091342.GA25518@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNTA5MWFjMWYtODAzYy0xMWU4LTg3MGYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDUwOTFhYzIxLTgwM2MtMTFlOC04NzBmLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTI4MCIgdD0iMTMxNzUyNTkzMTgzMTE1NTcxIiBoPSJqTWhIT0ZvcUlpeTlXK1RPNU4yMHVFdU1BWHc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pawell@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4567;7:xXEicaLjxE1Lfk/G1IWZwKoV+y3bJ1ufBPfnkPDTBpZiypBY0BOhEm6eI2UZSpO560kwyxQnnPc2IzQV3xx4syA9PexuiqIsVD67+ps/USD299HYA2RS5Gcm2EZQ21JSFIPKdVzbfm9vlQ6b4HRpVLSjoyxxzgk6WtC01XjbUtbMGIGcckVtgR2mAPrSW9Mdl+24uwjjaS19NKvhDgdFfOxsPoXGpIN/L4sKYH4RllwSg4AoMftCWoTcwbP4e1Vv;20:zuB4jbU3th9+MB1CWq+s7I6Cov0ytKYrk8S8Yl81X9DaQURpxjF26157WELBT/Tx3a12POpPRIxZWNPMaFtrD9ctvY9GrTgV9VYuY4PQRMllQ1Izef8t+4YFn93spMm7onwVLY7ycUY89h3c0fStypB2KX7/BB1yxQU8I4g0gQgQePHmz1LgeaAxHpl1AEB3893qOdortpdBLbU9NT0bhZbMYsTLQtbbI73ssve9k7oZvQYaF3EXnFYdh+nsDy2R
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(36092001)(54534003)(478600001)(6246003)(54906003)(105586002)(102836004)(7696005)(26005)(99286004)(486006)(33656002)(446003)(6506007)(106356001)(76176011)(476003)(11346002)(316002)(3846002)(74316002)(186003)(14454004)(6116002)(8936002)(6436002)(81156014)(7736002)(97736004)(8676002)(81166006)(55016002)(305945005)(2906002)(5660300001)(53936002)(68736007)(9686003)(6916009)(2900100001)(229853002)(107886003)(66066001)(86362001)(4326008)(25786009)(256004)(5250100002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4567;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 84f72bec-243b-498d-2061-08d5e2602d35
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4567;
x-ms-traffictypediagnostic: BYAPR07MB4567:
x-microsoft-antispam-prvs: <BYAPR07MB4567837B999587EF290F6C14DD400@BYAPR07MB4567.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4567;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4567;
x-forefront-prvs: 0724FCD4CD
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ar57R9zK3CO52AicV+yH8cmrZX9Si8UivXG1bfq23nDeU8HHdhy3IVBirKjvwuOJd3/GJ/ZAfiZDaOwD1YEU8KIweqKfzl8RPrE5bKNXcK3fTLFLaPMaQ4tlmHyO1h9eCdee8V2f6jN+9POiGD1ariVYsLA1bU3zha4yySsivT0GZ7fBCyzHfvXY3uDlIPVxZKGgXR2d37dswT+hzkO045RDJFR/R+KppHqi/yV+w9wqiiSPJ81Ee/oBb3QmwKUIho/myhqSMgT25xL3C+ObGBVlsQF0M//iKUug7oj+fgqeHZxjSbhUrWOfXGTmAJS6JAMmC8JTUt8JmIehqsZiduRB2c6BfO0eS8A+gN5d/BU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f72bec-243b-498d-2061-08d5e2602d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2018 10:15:04.4696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4567
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jul 03, 2018 at 08:57:45PM +0100, Pawel Laszczak wrote:
> > From: Laszczak Pawel <pawell.cadence.com>
> >
> > Signed-off-by: Laszczak Pawel <pawell@cadence.com>
> > ---
>=20
> I can't take patches without any changelog text at all, sorry.
>=20
> Also, your subject lines need work, look at how all other usb patches are
> written, your long prefix is not really helping out here.
>=20
> >  drivers/usb/usbssp/gadget.c | 2082
> > +++++++++++++++++++++++++++++++++++
> >  1 file changed, 2082 insertions(+)
> >  create mode 100644 drivers/usb/usbssp/gadget.c
>=20
>=20
> Just splitting the driver up by file is hard to review, as you are just d=
umping
> individual files on us, not functionality, and we can not review anything=
 until
> all of them are added.  Can you break this up into logical chunks?  Make
> these in a way that is easy to review, would you want to review this patc=
h
> series in this way?

It's quite large driver and I thought that this form will be better and fas=
ter to review.=20
I didn't want to prepare too much patches.=20

I will prepare new patch set and I will tray to split it into logical chunk=
.=20

Thanks,
Pawel Laszczak

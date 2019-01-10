Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB59C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC5420879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LTyeJnpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfAJD6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 22:58:43 -0500
Received: from mail-eopbgr1300138.outbound.protection.outlook.com ([40.107.130.138]:6077
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726637AbfAJD6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 22:58:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1X8H4w0qefib1D67jF3YAgy1Uc6+qGYUJsO/eqr55s=;
 b=LTyeJnpT2pq5dUECUzrGctyr3rZFoZ2kKZo0N1MuwQkU98IHqXO7Mux3+l/Gv7pYJna9srZk71Bn0xHxeirjmqA6DSemH+e8kQAA+0I5juXr2qREdGdDMErSB8T+/V7m6mxlY9xw7CYNMN4+j3m7fEeMiFJS+zXHHw6b4sldlPY=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0139.APCP153.PROD.OUTLOOK.COM (10.170.188.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.4; Thu, 10 Jan 2019 03:58:34 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::99da:e3db:6b66:c8d4]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::99da:e3db:6b66:c8d4%6]) with mapi id 15.20.1537.005; Thu, 10 Jan 2019
 03:58:34 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        kimbrownkd <kimbrownkd@gmail.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] Drivers: hv: vmbus: Expose counters for interrupts and
 full conditions
Thread-Topic: [PATCH v2] Drivers: hv: vmbus: Expose counters for interrupts
 and full conditions
Thread-Index: AQHUpLAXsstUN2kOgUOyNPgAu50eB6WhKi2AgAa6v7A=
Date:   Thu, 10 Jan 2019 03:58:34 +0000
Message-ID: <PU1P153MB01695102421655A3DEB4F98EBF840@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <0181213190901.GA3843@ubu-Virtual-Machine>
 <20190105043518.GA4072@ubu-Virtual-Machine>
 <CY4PR21MB07733E3D30FD5FCB7A945CA6D78F0@CY4PR21MB0773.namprd21.prod.outlook.com>
In-Reply-To: <CY4PR21MB07733E3D30FD5FCB7A945CA6D78F0@CY4PR21MB0773.namprd21.prod.outlook.com>
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
x-originating-ip: [2601:600:a280:1760:d0e9:4c08:1777:c6a3]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0139;6:yxLd+3DLZPzsfhN5tjYeU39oFTqxZA7H98KLEhEu0TCUPOjSXF7r8CL57oxUZ4FWbQnhel1xNBV8gAxIS3MpbKfsdm/6CYIH1oqOlVZlDDVo+x3bv995PbEoPuLK+89hrF7DrfRJ/BmPWGjoCZh3vpzwwv/qDNf5e6ZwTOJPcgnEhQrUFynrliS0vWHTaNpwIw7uvq3zH487ro4N0nUH4M5emAjZgcP8lPrHaq9yruh0GnoBud4vMxIRbViEeC4jwsAyCaIDHYNKkNuC8e51du3C0vaRPFvdv0UCi5wR1digX5OFfDsgyYfVzsgbUU5DgM0aSFd7YR0qx89is9KyIFwjLM6nOmIWWoKf+99WsQb6oa6Tlw2vAiH5ngBOsMyCPnfZqA5xU0qbl4wajyLVnKg29D78Ee+jJLebxNc77R3eJgY5cBFb9Zl7JeNdE36Kt5mTa0SjPE6R9/06IosgrA==;5:Gbg19XnUpIHwpyyYNoHHDIBfoYl2Tiq70nl/4fYgQTx/ikYJdnL6O+NiBQub5Yn+YMc086hATd545DGN5wGHA7XbzgwoZ22Ms8ZZ96+eeJXoyVu37SD4Cj4lGvs9ONm2RODhi187otoCpQe/4uZkeWipSKcdSZAezvbvqrloWB0cm4AROAhAK6Ykz9dA3zexMnv2S8Ll3hEX9mE4qf6J/w==;7:6/vN/0pOEH6KcIvva+s3eOA52O7VTtakoTCKsowP0CD0LABUer61S+TYT9tWsCcPGcyAAtSlDIkkfENAZyAprJkLo8wUQi6eyzVfN+GgHtMstFUJcrhHGPVj/y3J3jXd8IKtazf3kS/N1X9Fbofh5w==
x-ms-office365-filtering-correlation-id: 54c9b8f8-411c-49ed-f97b-08d676afe49a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0139;
x-ms-traffictypediagnostic: PU1P153MB0139:
x-ms-exchange-purlcount: -3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB01390EAE9D3872E2FB4D6953BF840@PU1P153MB0139.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(93006095)(93001095)(3231475)(944501520)(2018427008)(10201501046)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0139;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0139;
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(346002)(396003)(39860400002)(199004)(189003)(6436002)(86612001)(10290500003)(478600001)(86362001)(229853002)(14454004)(97736004)(8990500004)(6246003)(74316002)(53936002)(4326008)(81166006)(39060400002)(9686003)(305945005)(8676002)(6636002)(33656002)(55016002)(68736007)(25786009)(5660300001)(8936002)(10090500001)(7736002)(2906002)(81156014)(186003)(46003)(6506007)(6346003)(102836004)(71200400001)(1511001)(256004)(14444005)(476003)(71190400001)(486006)(54906003)(11346002)(446003)(22452003)(316002)(6116002)(105586002)(110136005)(106356001)(7696005)(99286004)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0139;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fLTc86fQgN1tc7HsQlUrN94fUCZYeLKCCjkNyKoNELf1+T7U5sy2fwFsm6EPEsCj+nWy2p+rFgipQ5cdrmLTrGgHE6C8lCsP56c4LloPwhg/I879q1VIC6k22Zr/PqbvRLW1j4AiLdr6JiyKX/28dhptNK2s6u/q/363+UNn7MGnuEtQA6aEsYPa11obA7R6Ohj+g4mPb4yUutv0G3UoYE79WDs8zlmxqzbu1o+LY98SLuBQW+MP3MhjibBtgh78bnOL8PKashkvJ4Gay7dEaRmEpk2oN0acgH0x0DFXd4hinhqTVtaveNw40Yzw688t
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c9b8f8-411c-49ed-f97b-08d676afe49a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 03:58:34.2497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Saturday, January 5, 2019 1:01 PM
> > From: Kimberly Brown <kimbrownkd@gmail.com>  Sent: Friday, January 4,
>  > 2019 8:35 PM
> >
> >  static inline void set_channel_pending_send_size(struct vmbus_channel =
*c,
> >  						 u32 size)
> >  {
> > +	if (size) {
> > +		++c->out_full_total;
> > +
> > +		if (!c->out_full_flag) {
> > +			++c->out_full_first;
> > +			c->out_full_flag =3D true;
> > +		}
> > +	} else {
> > +		c->out_full_flag =3D false;
> > +	}
> > +
> >  	c->outbound.ring_buffer->pending_send_sz =3D size;
> >  }
> >
>=20
> I think there may be an atomicity problem with the above code.  I looked
> in the hv_sock code, and didn't see any locks being held when
> set_channel_pending_send_size() is called.   The original code doesn't ne=
ed
> a lock because it is just storing a single value into pending_send_sz.
>
> In the similar code in hv_ringbuffer_write(), the ring buffer spin lock i=
s held
> while the counts are incremented and the out_full_flag is maintained, so =
all is
> good there.  But some locking may be needed here.  Dexuan knows the
> hv_sock
> code best and can comment on whether there is any higher level
> synchronization
> that prevents multiple threads from running the above code on the same
> channel.
> Even if there is such higher level synchronization, this code probably sh=
ouldn't
> depend on it for correctness.
>=20
> Michael

Yes, there is indeed a higher level per-"sock" lock, e.g. in the code path
vsock_stream_sendmsg() -> vsock_stream_has_space() ->=20
transport->stream_has_space() -> hvs_stream_has_space() ->=20
hvs_set_channel_pending_send_size(), we acquire the lock by
lock_sock(sk) at the beginning of vsock_stream_sendmsg(), and call
release_sock(sk) at the end of the function.

So we don't have an atomicity issue here for hv_sock, which is the only use=
r
of set_channel_pending_send_size(), so far.

Thanks,
-- Dexuan

Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5518C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD9C2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NKWzykvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD9C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbeK1CvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:51:15 -0500
Received: from mail-eopbgr730091.outbound.protection.outlook.com ([40.107.73.91]:52589
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726624AbeK1CvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:51:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9Us2dXXr02c5qAWo0pIZwz5R4grGaBhUchznPJBnC0=;
 b=NKWzykvyxFiM0THCF4FB41QFlGCfRmbAtLfNlNQi9955aAQ1MM4hLXtpXt0pulo/rle3/CcStboF5hfeDsQt45KxSb/43/L9gX1N/NY4Dp3odvw7QnC3fwysYFWrtKFc1QywyvDx8AUZKaSVGG8R35Q9FKGVMalfEREMc0MOWe0=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.3; Tue, 27 Nov 2018 15:52:51 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::f597:e00a:584b:fd8c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::f597:e00a:584b:fd8c%2]) with mapi id 15.20.1404.002; Tue, 27 Nov 2018
 15:52:51 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 1/4] x86/hyper-v: move synic/stimer control structures
 definitions to hyperv-tlfs.h
Thread-Topic: [PATCH v2 1/4] x86/hyper-v: move synic/stimer control structures
 definitions to hyperv-tlfs.h
Thread-Index: AQHUhZ9h2g9Agw1QXEObN9QIHGEpQ6Viey2AgAEez4CAACvYsA==
Date:   Tue, 27 Nov 2018 15:52:51 +0000
Message-ID: <CY4PR21MB0773225F986528897624BAA6D7D00@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181126154732.23025-1-vkuznets@redhat.com>
 <20181126154732.23025-2-vkuznets@redhat.com>
 <20181126200413.GA7852@rkaganb.sw.ru> <87wooyk6na.fsf@vitty.brq.redhat.com>
In-Reply-To: <87wooyk6na.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-11-27T15:52:49.4908195Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:GNg0Oj3UUBUHANjwVbhQtDmZBfrQmqY/F3W504UzHtnnttzL+vl8D8POOUATpuZDN2syRFfB1HmQXQQzRk/PB5t/8qw4VcDj8C/haReUbei6dSz4GzGaFZI7AJocAs4qQ1M5y2ikaokaRTHYRUrlPmfY8hKYciiRmxCX2fU32FOkYnND/0O9rCKB1XNry1tK8wAjB2dsZb3/PSQemtfWnvhMdteWfyBxpt1oEqO5m6k7Ep+JcOPz7wZot5qcdwOjSzFR41HrNmJ/MLucK0it7Y6vJh5YSQdEavm4B8F3xLJrD/hZalx0sbqZ92hOmxVlS/TBH8fm8sTAeizeIrD34J1yUbbJGJA6T1XMpo0QxTugQzmaE4JdYLnmF1amxuIvqf7wqqfza4DTGYFFUFrWEqHyekjUjluxR0HzEPm5Lqk/667Msb/f06dTepjeLuwB0CoX4k9dz71n4rakzgQpfg==;5:cCOYrvC91FWhoniLSbon225miStGLl6paO3riKJAQ9nXdRtBZxPAmBne6kzzbY+9bSYaMfgki9hQgAnRAyL1ZSZicm+30PfElIOc3Vqu6D1T+k99TJ5Mh/8oqKe6/LSxwaVBPOqsV+G7/HXAGsFjr1yHo2DYib8Td0FxZrevM54=;7:qgZxWaJaXi3H/79vewrfaBCZrdT0edAh5r8JKGb9kYt6c0wDbU59yjrmiZ7omCj6sflUJA7ZWHLKIdVCrT53s4eiVvFW58PQaHIO5nQRtARwyVYQ03lZuz7w+XKVOun7lp74BUPSaWOJQypQWIwetA==
x-ms-office365-filtering-correlation-id: 5e39543f-225a-4148-aebb-08d654806351
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0470457FF0E241311D470F5FD7D00@CY4PR21MB0470.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231443)(944501430)(2018427008)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(8676002)(106356001)(25786009)(105586002)(86612001)(6116002)(229853002)(3846002)(4326008)(86362001)(6436002)(76176011)(305945005)(110136005)(8990500004)(2906002)(54906003)(74316002)(256004)(97736004)(10290500003)(7736002)(6246003)(93886005)(22452003)(446003)(9686003)(14454004)(53936002)(476003)(33656002)(11346002)(68736007)(99286004)(6636002)(55016002)(8936002)(478600001)(81156014)(81166006)(10090500001)(186003)(316002)(26005)(66066001)(486006)(71200400001)(7696005)(71190400001)(6506007)(1511001)(102836004)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aHmGsmoHyZH5AOvnXG3TIw1XslfpgnEAdaLE3ip065ra4ZPt9x2FFLZCwFWOVttghturYhuwtpi/xutMsy57MXdAF/qde/ojivYDh9d6MAYuBzAQytjwkpSZ1J/p6b5JAdsqWgX5zzR9hL1T8l2t25GfJGcWr9J9yWUHKtZ8UPWBoM5d4yRr3zTjpvh+sVAiUrzij9bELCwtq81s621/I8nMedcKFP6pXkXQHCYWvnIlEBZ3D278q5LtFmz8aUCLEke++/+Qn9qrI6l2bM2et/X5LpPLdufX6vl1IUc0ordLIQv3a1kRwdQgEur2nq73l6z2ROLjJCYGCc5+b1gj6vBLnKvU2FSU/rUGgTzf0e4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e39543f-225a-4148-aebb-08d654806351
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 15:52:51.6947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Tuesday, November 27, 2018 5:1=
1 AM

> > I personally tend to prefer masks over bitfields, so I'd rather do the
> > consolidation in the opposite direction: use the definitions in
> > hyperv-tlfs.h and replace those unions/bitfields elsewhere.  (I vaguely
> > remember posting such a patchset a couple of years ago but I lacked the
> > motivation to complete it).
>=20
> Are there any known advantages of using masks over bitfields or the
> resulting binary code is the same? Assuming there are no I'd personally
> prefer bitfields - not sure why but to me e.g.
>  (stimer->config.enabled && !stimer->config.direct_mode)
>  looks nicer than
>  (stimer->config & HV_STIMER_ENABLED && !(stimer->config & HV_STIMER_DIRE=
CT))
>=20
> + there's no need to do shifts, e.g.
>=20
>  vector =3D stimer->config.apic_vector
>=20
>  looks cleaner that
>=20
>  vector =3D (stimer->config & HV_STIMER_APICVECTOR_MASK) >>
> HV_STIMER_APICVECTOR_SHIFT
>=20
> ... and we already use a few in hyperv-tlfs.h. I'm, however, flexible :-)
>=20
> K. Y., Michael, Haiyang, Stephen - would you prefer to get rid of all
> bitfields from hyperv-tlfs.h? If so I can work on a patchset. As to this
> series, my understanding is that Paolo already queued it so in any case
> this is going to be a separate effort (unless there are strong
> objections of course).
>=20

I prefer to keep the bit fields.  I concur think it makes the code more
readable.   Even if there is a modest performance benefit, at least
within a Linux guest most of the manipulation of the fields is during
initialization when performance doesn't matter.  But I can't speak to
KVM's implementation of the hypervisor side.

Michael

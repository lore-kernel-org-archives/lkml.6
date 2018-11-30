Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD110C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9142082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9142082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeLABfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:35:51 -0500
Received: from mail-bgr052101130098.outbound.protection.outlook.com ([52.101.130.98]:20454
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726988AbeLABfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq58JlRJYA1DCtVPCLkFTeAeAkjobz4LFMLfRLyjdb4=;
 b=BHlAO3t0zJOXHCRVD+XYl3OdEHdMFhY9/czRTp+aFEfC4NYGzYhULZaNSp3Zr5ODfWuPEk/tuqRLA1K4wPnnxZ921IKrJJXEqgM4C9+qq8CIV/SWhqozIhvQ0oosJcDzymHq5JBnJiJfBdZ9jMZVA37JFsf4qPgt4cUylJU7ARI=
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com (20.177.61.74) by
 VI1PR08MB3374.eurprd08.prod.outlook.com (20.177.58.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 14:26:07 +0000
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::5d2c:980a:d77e:34e2]) by VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::5d2c:980a:d77e:34e2%3]) with mapi id 15.20.1361.019; Fri, 30 Nov 2018
 14:26:07 +0000
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/hyper-v: define structures from TLFS as packed
Thread-Topic: [PATCH] x86/hyper-v: define structures from TLFS as packed
Thread-Index: AQHUiKZd3jLH2BBgGUSaUQtypGqxhKVofV4A///XFACAAAuAgA==
Date:   Fri, 30 Nov 2018 14:26:07 +0000
Message-ID: <20181130142603.GB2358@rkaganb.sw.ru>
References: <20181130121511.12331-1-vkuznets@redhat.com>
 <20181130131122.GA2358@rkaganb.sw.ru> <87va4ewug9.fsf@vitty.brq.redhat.com>
In-Reply-To: <87va4ewug9.fsf@vitty.brq.redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
mail-followup-to: =?iso-8859-2?Q?Roman_Kagan_<rkagan@virtuozzo.com>,=09Vitaly_Kuznetsov_<vk?=
 =?iso-8859-2?Q?uznets@redhat.com>,=09"kvm@vger.kernel.org"_<kvm@vger.kern?=
 =?iso-8859-2?Q?el.org>,=09Paolo_Bonzini_<pbonzini@redhat.com>,=09Radim_Kr?=
 =?iso-8859-2?Q?=E8m=E1=F8_<rkrcmar@redhat.com>,=09"linux-kernel@vger.kern?=
 =?iso-8859-2?Q?el.org"_<linux-kernel@vger.kernel.org>,=09"K._Y._Srinivasa?=
 =?iso-8859-2?Q?n"_<kys@microsoft.com>,=09Haiyang_Zhang_<haiyangz@microsof?=
 =?iso-8859-2?Q?t.com>,=09Stephen_Hemminger_<sthemmin@microsoft.com>,=09"x?=
 =?iso-8859-2?Q?86@kernel.org"_<x86@kernel.org>,=09"Michael_Kelley_(EOSG)"?=
 =?iso-8859-2?Q?_<Michael.H.Kelley@microsoft.com>,=09Nadav_Amit_<nadav.ami?=
 =?iso-8859-2?Q?t@gmail.com>,=09Thomas_Gleixner_<tglx@linutronix.de>?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1P18901CA0008.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::18) To VI1PR08MB3599.eurprd08.prod.outlook.com
 (2603:10a6:803:85::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB3374;7:uUlAc9hILTnX9jiMG9RcweX3WIsmOJM8zXCyk4gXgSBp1PEMTOpFyCCo6lti1/e8KJFZR85Kdai4OiMTBeW2IaUISkMRm8zZy9kPEult+13Wlb/je7ZYQz30yocPJkeJu326lLs8We9RhvRXZKbNFA==;20:shcHGsl5XElIJFfYR3JtgBFKaWqq+W0ZgPsrcTGHMx9f2xskNj3PTnreJMXtZEhE5D8Mo/db2zngoFXnYnuD7RI0JvF+GQoJSJxKHLiNdTmNlyB7iqLYOm4O3OVDGsZYfOEE2OC/RI2NhRA83cvRyPWAivC+q7rphBlTjnB8SkU=
x-ms-office365-filtering-correlation-id: 356d328b-6a1f-4152-dcff-08d656cfc468
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3374;
x-ms-traffictypediagnostic: VI1PR08MB3374:|VI1PR08MB3374:
x-microsoft-antispam-prvs: <VI1PR08MB3374FC1B14A4F5E2BC0CF6B2C9D30@VI1PR08MB3374.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231453)(999002)(944501466)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB3374;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3374;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(136003)(346002)(376002)(396003)(366004)(39850400004)(189003)(199004)(6916009)(6486002)(6116002)(1076002)(229853002)(81156014)(3846002)(25786009)(2906002)(8676002)(66066001)(8936002)(81166006)(6436002)(486006)(71190400001)(71200400001)(476003)(11346002)(446003)(58126008)(316002)(97736004)(6512007)(9686003)(68736007)(478600001)(7736002)(305945005)(86362001)(53936002)(33656002)(105586002)(54906003)(14454004)(106356001)(5660300001)(256004)(7416002)(26005)(52116002)(4326008)(39060400002)(186003)(33896004)(14444005)(102836004)(386003)(6506007)(76176011)(99286004)(36756003)(6246003)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR08MB3374;H:VI1PR08MB3599.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9elumrtCNpfrk+XTia+SIXIlOObfy6mBFB7CcWCTJ9tnUPT0yorflHluZ03kCI3Ywm8Z7qJw6KTer7VMejMwms34WZZoYO52TAFg6g1H14xvndJxpB3UYjM+ipwCBlFNUj0ZPH5705uI/Rm20HpkYY5ZNm0H4S0XU0flmx3p/0XD7+XjJ90J4O+iU6NUbSVUNFn51eDZPP8gb4uNXMFc04boh4zE1+uHXlLFPlYKxZrloWj7AIzqxuSJIaVP4ULRlcjW4pS7iCzB2QEYDY9EKJBECnBOTprALSxEE3FRZbiBT7+sK2LEcfP9g2wqDfYDTqXzx6MZg3vNUPsokGzYXUPjN3gXGY/wpFR7Cx3CX0QKyuZitlYRoZlNB907PAdtK9r4PIWy3eMGPh+xUNEwF2+v0DPmyRc6AvcLfDvtBSHFLQZRz4lawM/otInsZ6974er5fCX/32RBkB6G56tYgjHMAAqynJFvC7/NuhV42NPSXXtSkuUWaV+0uQOEJzLqH897RcA9eQ+E6xR4S1Kh8BjtHBB/Ra51jW3qOaXCKOQ=
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <6FEEFBF866AF5747881DCC47ABA50CE2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356d328b-6a1f-4152-dcff-08d656cfc468
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 14:26:07.6562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3374
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 02:44:54PM +0100, Vitaly Kuznetsov wrote:
> Roman Kagan <rkagan@virtuozzo.com> writes:
>=20
> > On Fri, Nov 30, 2018 at 01:15:11PM +0100, Vitaly Kuznetsov wrote:
> >> Without 'packed' compiler is free to add optimization paddings and re-=
order
> >> structure fields for randomization/optimization. And structures from
> >> hyperv-tlfs.h are used for hypervisor-guest communication, we need to
> >> ultimately forbid such practices.
> >
> > Note that __packed also reduces the structure alignment to 1, which is
> > not necessarily what you want.
> >
> > E.g. some of these structures are passed by pointer to the hypercall,
> > which requires its arguments to be 8byte-aligned.
>=20
> Hm,
>=20
> I thought we always take precautions for Hyper-V hypercall arguments, in
> particular
>=20
> PV IPI/TLB flush use pre-allocated hyperv_pcpu_input_arg,
> hv_post_message() uses pre-allocated message page, other call sites use
> fast hypercalls where we use registers.

Looks so indeed.

> I also checked this patch before sending out, WS2016 guest boots without
> issues. Any particular places you're worried about?

It's Linux guests on Hyper-V that need to be checked.

> >  I'm also not sure
> > that passing unaligned argument to [rw]msr is ok, need to
> > double-check.
>=20
> My understanding is that rdmsr/wrmsr instuctions are registers-only.

Indeed.

> We can, of course, just add __aligned(8) to some structures but I'd like
> to find the reason first.

I guess you're right, in the current code the relevant structures are
made sufficiently aligned by other means.  False alarm, sorry.

Roman.

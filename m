Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDC4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7E42081B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PiszQE3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7E42081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbeK1Frf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:47:35 -0500
Received: from mail-eopbgr00112.outbound.protection.outlook.com ([40.107.0.112]:38816
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726461AbeK1Fre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLPO1DWX0/xwK3XFhk9CQEESVSp9yPMiCuNlqtWzb6I=;
 b=PiszQE3vXJ/PStqe5XDPJa8W8bLwOvWgrQaE4q3BqKPOVKUfhzxPR4WvjXGTWrpVI4/06+EJP2XJN+cAf5Nxh4qkfneGcA1GhENfQ8i326RqvXBfsgZfkXjMJ1cuheOampmZJHYeV3ncJO6xI/QaX3C64mM2BDYUFV/HAZTzezc=
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com (20.177.61.74) by
 VI1PR08MB4096.eurprd08.prod.outlook.com (20.178.127.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Tue, 27 Nov 2018 18:48:42 +0000
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::5d2c:980a:d77e:34e2]) by VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::5d2c:980a:d77e:34e2%3]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 18:48:42 +0000
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 1/4] x86/hyper-v: move synic/stimer control structures
 definitions to hyperv-tlfs.h
Thread-Topic: [PATCH v2 1/4] x86/hyper-v: move synic/stimer control structures
 definitions to hyperv-tlfs.h
Thread-Index: AQHUhZ9iirF501eLF0yD2vJWccWjqaVirXKAgADsioCAAF5gAA==
Date:   Tue, 27 Nov 2018 18:48:42 +0000
Message-ID: <20181127184835.GA5147@rkaganip.lan>
References: <20181126154732.23025-1-vkuznets@redhat.com>
 <20181126154732.23025-2-vkuznets@redhat.com>
 <20181126200413.GA7852@rkaganb.sw.ru> <87wooyk6na.fsf@vitty.brq.redhat.com>
In-Reply-To: <87wooyk6na.fsf@vitty.brq.redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
mail-followup-to: =?iso-8859-2?Q?Roman_Kagan_<rkagan@virtuozzo.com>,=09Vitaly_Kuznetsov_<vk?=
 =?iso-8859-2?Q?uznets@redhat.com>,=09"K._Y._Srinivasan"_<kys@microsoft.co?=
 =?iso-8859-2?Q?m>,=09Haiyang_Zhang_<haiyangz@microsoft.com>,=09Stephen_He?=
 =?iso-8859-2?Q?mminger_<sthemmin@microsoft.com>,=09"Michael_Kelley_(EOSG)?=
 =?iso-8859-2?Q?"_<Michael.H.Kelley@microsoft.com>,=09"kvm@vger.kernel.org?=
 =?iso-8859-2?Q?"_<kvm@vger.kernel.org>,=09Paolo_Bonzini_<pbonzini@redhat.?=
 =?iso-8859-2?Q?com>,=09Radim_Kr=E8m=E1=F8_<rkrcmar@redhat.com>,=09"linux-?=
 =?iso-8859-2?Q?kernel@vger.kernel.org"_<linux-kernel@vger.kernel.org>,=09?=
 =?iso-8859-2?Q?"x86@kernel.org"_<x86@kernel.org>?=
x-originating-ip: [2a02:2168:904c:fe00:cfed:f2f6:11c1:3d78]
x-clientproxiedby: HE1PR05CA0358.eurprd05.prod.outlook.com
 (2603:10a6:7:94::17) To VI1PR08MB3599.eurprd08.prod.outlook.com
 (2603:10a6:803:85::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB4096;20:MDhWGkV73jS4Zpj2L4L3MobHfM1jbZ4n6jvuA2y4wAD1wK6BHDj0lMNx+9UR97d/uYuzBXru/wZ07CHFCFd95JDKGMzgdhLLch7yaKMqOOqjxCkoxpKHiFYPn5HQtEr3GqYpmzY5yIGZMIZqeA7c1r54/+7iGSvJREXlhQ9F3VM=
x-ms-office365-filtering-correlation-id: ab9acdeb-f77f-454f-eb52-08d65498f38b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB4096;
x-ms-traffictypediagnostic: VI1PR08MB4096:
x-microsoft-antispam-prvs: <VI1PR08MB409609D585E8A017A59773D8C9D00@VI1PR08MB4096.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231443)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB4096;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB4096;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(396003)(366004)(39850400004)(189003)(199004)(58126008)(54906003)(8936002)(99286004)(316002)(486006)(2906002)(33656002)(8676002)(305945005)(7736002)(81166006)(86362001)(52116002)(6116002)(1076002)(81156014)(7416002)(68736007)(93886005)(5660300001)(25786009)(9686003)(53936002)(33896004)(71200400001)(4326008)(76176011)(6512007)(106356001)(6506007)(386003)(105586002)(102836004)(478600001)(186003)(6486002)(11346002)(6246003)(6916009)(476003)(256004)(14454004)(46003)(71190400001)(97736004)(446003)(36756003)(229853002)(6436002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB4096;H:VI1PR08MB3599.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PlhabHBmDB4NE+KSaN1sqAbv/hp50p5YZIRb2sLsAJnc0ompHKJKOU+fzzWM7AnAsjuMlLhGxGoE1sUzYWOLycxQOHpyPON3iPEU/AZIRDXfmFHrgFJQKUBvQJOMNLa1mnz3SKa/X8VgtNLQgyIDJisPiPaGlV0Y04HSdvn/4ZC4ruV3dBS6PXF0rMsmMCesCgcc1czvaIwMuVpPz8P498KaRtk7X0L4DBPQ/80nK3JJDgFJaqJ/gq9R5igzDGkRQ2G4SadoFbCTiz4B/a7F91Hc0/U9kfQB6/ngwTKnYVcSJtTpPCrnXybQ2LaAMswFfSo9mw7Dg9q1Xy0ACX8lxFsB84Oy44IPkbfGiwrmdKM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <5CFF279CD76D4F4DA35F4C1CA4A265B1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9acdeb-f77f-454f-eb52-08d65498f38b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 18:48:42.1192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 02:10:49PM +0100, Vitaly Kuznetsov wrote:
> Roman Kagan <rkagan@virtuozzo.com> writes:
> > On Mon, Nov 26, 2018 at 04:47:29PM +0100, Vitaly Kuznetsov wrote:
> > I personally tend to prefer masks over bitfields, so I'd rather do the
> > consolidation in the opposite direction: use the definitions in
> > hyperv-tlfs.h and replace those unions/bitfields elsewhere.  (I vaguely
> > remember posting such a patchset a couple of years ago but I lacked the
> > motivation to complete it).
>=20
> Are there any known advantages of using masks over bitfields or the
> resulting binary code is the same?

Strictly speaking bitwise ops are portable while bitfields are not, but
I guess this is not much of an issue with gcc which is dependable to
produce the right thing.

I came to dislike the bitfields for the false feeling of atomicity of
assignment while most of the time they are read-modify-write operations.

And no, I don't feel strong about it, so if nobody backs me on this I
give up :)

Roman.

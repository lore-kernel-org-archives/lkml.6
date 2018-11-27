Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BD5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382502086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Q90bvNdN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382502086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbeK0ODV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 09:03:21 -0500
Received: from mail-eopbgr790115.outbound.protection.outlook.com ([40.107.79.115]:34250
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727689AbeK0ODV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 09:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEua2sQ+SPLSIcyTTnOyg9b1ZmrwOp9ZrF8eETr+YRk=;
 b=Q90bvNdNLt9S96KT/bkdAJXtp8gzOQ40XElKZ3lIhj7fM90OK6RapGN5vUSb5OVdR292Qk1xREBdxKxImPKdwllzPqPreUGB85gVhbvKTEaiS1ZvA8dvggcRli7GL7yRbWxQALs6iq8ceyjx40fadUxp3D8GFz36mngEAWyYZX4=
Received: from CY4PR2101MB0804.namprd21.prod.outlook.com (52.132.100.38) by
 CY4PR2101MB0723.namprd21.prod.outlook.com (52.132.100.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.4; Tue, 27 Nov 2018 03:06:55 +0000
Received: from CY4PR2101MB0804.namprd21.prod.outlook.com
 ([fe80::b922:44e9:332d:aab5]) by CY4PR2101MB0804.namprd21.prod.outlook.com
 ([fe80::b922:44e9:332d:aab5%6]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 03:06:55 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@armm.com" <catalin.marinas@armm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH 1/4] arm64: hyperv: Add core Hyper-V include files
Thread-Topic: [PATCH 1/4] arm64: hyperv: Add core Hyper-V include files
Thread-Index: AQHUghEmGtozXdsAg0mq7x1LwGXwL6VidWkAgACC2fA=
Date:   Tue, 27 Nov 2018 03:06:55 +0000
Message-ID: <CY4PR2101MB080498D01F0DC5A90C1E4F8FA0D00@CY4PR2101MB0804.namprd21.prod.outlook.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
 <20181126191812.GA32208@kroah.com>
In-Reply-To: <20181126191812.GA32208@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:744e:9865:5066:c4c8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2101MB0723;6:rfg47ClJIJax/e3GtMvkTZlNhl7ug5LJMeS7Nm+p+dX7ZD0Huij4ObJ7bSvihelWQFMfxWbeYldZW2vZDpMZgsxMZXRYmzp8KqN2xhkOZQY8cqk7J7JGtE0lV6HDDhih8AAbGSemcMENYgSv5OKMvoj7AuMgW+ve1lYS4BGR0DocEnHDftfEsmLRWW7edh0yq30BH9OFWackQqN6wRde3bYPnDeciTgQywvR8TdnQzpJMRUxfrkmHv+EiNWHmrZQzZxQTWwF+4pdzu4al1g/0R5tHIbNcDG0l6kkBm6OoNniilU5sGDSSy1Ebm2EFSikXrjMDFC7/EuhhvJsILOW+EHOIO/htp5Bkhy9BAstnWTy8arDUkYdM8O/OyUFblBVUxXjjlmXh+OKouUIo9H9/K9s+P1FvTySK5hpZrxFpPZPYMEItPRuMwwB66x/lNFZ7Td7JCxhMrvBEy/MyNUqPQ==;5:FniK63Agq4SKn5hVYBhq6+hFIEd1UJIXHa2KTTxBWQV302Ow53uAoyKOOziP0fhWSE2pru+71FeM1NWATcxmMpxCNZKdfkgcz2DW1qjQxUCxgQstouUZEKleq512PbKps5LKjS9a1sUwd51FPeQwoKvBnpd1+DtHjFyfDjVhy3c=;7:FtiOjAA7247nu9m4cK5naj4xH96nTh/Viy4kVYXMnrOU8oMjrTXba5L+GYfmxOilQmgnH9EcNEVUUzEACvTqU1HLkXESn5Jk5kW+iOnL3xpeejyJhmYJ6pzcHJoCBzdHuX1trQvveS+gINptS3VXew==
x-ms-office365-filtering-correlation-id: 2fdd09b3-5aa0-44f3-2498-08d654156358
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR2101MB0723;
x-ms-traffictypediagnostic: CY4PR2101MB0723:
x-ms-exchange-purlcount: 1
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR2101MB07239FBD3CC339B466137E14A0D00@CY4PR2101MB0723.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(10201501046)(3231443)(944501430)(2018427008)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:CY4PR2101MB0723;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2101MB0723;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(136003)(376002)(39860400002)(13464003)(189003)(199004)(106356001)(8676002)(305945005)(46003)(7416002)(6916009)(256004)(107886003)(6306002)(9686003)(966005)(478600001)(10290500003)(33656002)(74316002)(68736007)(53936002)(5660300001)(105586002)(6246003)(14454004)(81156014)(81166006)(7736002)(8936002)(229853002)(4326008)(6436002)(86612001)(25786009)(2906002)(54906003)(97736004)(10090500001)(6116002)(316002)(22452003)(8990500004)(55016002)(11346002)(76176011)(102836004)(53546011)(186003)(6506007)(446003)(6346003)(99286004)(71200400001)(476003)(7696005)(86362001)(71190400001)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2101MB0723;H:CY4PR2101MB0804.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-microsoft-antispam-message-info: WS9G9zlDeBmwdW4GXQqPi1PBfKsu6GwKNyZSg9CMwe4KfsOsDS1E58cujHddYE/xMatwj8WL/fMp8Uy3NT00ZXuDrwXGLcGIo6A+J0RYAI2OE8QRePMHTF3+RmJBA4l7HzRkvaiAeXVdT3mcG0r6Y7B0U9zbUvxlTNCiMqlFyg/tlLft1bToYp97jw5CgnmommND3dZbcA5qDa4i2fa9v7hh4RL9vgZ2CBnx6gNqWHl+DwRQFm6FoW+7FwSZxDpY/msDxVxl4G5oU8mw5pSmsLAA9huQx7RYDg1HDdBZDFkh3X9150C63pQ1mvK4LFyQzGgcAUmd6vybLtUk2nb8eVLfauFp/sQzuDpmrDOV26c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fdd09b3-5aa0-44f3-2498-08d654156358
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 03:06:55.5620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2101MB0723
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Monday, November 26, 2018 11:18 AM
> To: KY Srinivasan <kys@microsoft.com>
> Cc: will.deacon@arm.com; catalin.marinas@armm.com;
> mark.rutland@arm.com; marc.zyngier@arm.com; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> jasowang@redhat.com; Stephen Hemminger <sthemmin@microsoft.com>;
> Michael Kelley <mikelley@microsoft.com>; vkuznets
> <vkuznets@redhat.com>; Michael Kelley <mikelley@microsoft.com>
> Subject: Re: [PATCH 1/4] arm64: hyperv: Add core Hyper-V include files
>=20
> On Thu, Nov 22, 2018 at 03:10:56AM +0000, kys@linuxonhyperv.com wrote:
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/hyperv-tlfs.h
> > @@ -0,0 +1,338 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * This file contains definitions from the Hyper-V Hypervisor Top-Leve=
l
> > + * Functional Specification (TLFS):
> > + *
> https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdocs.
> microsoft.com%2Fen-us%2Fvirtualization%2Fhyper-v-on-
> windows%2Freference%2Ftlfs&amp;data=3D02%7C01%7Ckys%40microsoft.co
> m%7Cce3a8662cbbc4afe157508d653d3eadf%7C72f988bf86f141af91ab2d7cd0
> 11db47%7C1%7C0%7C636788566988323167&amp;sdata=3DVJHHMNbpOdAANd
> DNUD3UMuR8SkbBGOew7uy%2B%2BUCS2sE%3D&amp;reserved=3D0
>=20
> "interesting" url :(
>=20
> Care to use a real one?

Will fix and resend.

K. Y
>=20
> thanks,
>=20
> greg k-h

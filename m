Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44483C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708E220672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iIUXppwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708E220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbeLCHQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:16:22 -0500
Received: from mail-bgr052101135076.outbound.protection.outlook.com ([52.101.135.76]:15328
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbeLCHQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 02:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRJ6sELGbk9WrqVaOhEplvTcvuNigPWcB7xFdte3Q9g=;
 b=iIUXppwa0VPcgPGH8Y5h5KS7lae7HEuNYU/QXbA9VKDyLMEjH8Sf5IX0RGE1gKSdqnXbD/ukUqCfCG80ekHAujp4RCrNkaPVgwmaQ9OztRJbuueO+ZuJ8+FqkajKZ+RXXw5uDZI0sdAgSzvWgs2sGXJAdCWCjqv1mGyk6OvRoXQ=
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com (20.177.61.74) by
 VI1PR08MB2880.eurprd08.prod.outlook.com (10.170.239.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Mon, 3 Dec 2018 07:15:25 +0000
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::5d2c:980a:d77e:34e2]) by VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::5d2c:980a:d77e:34e2%3]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 07:15:25 +0000
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     Nadav Amit <nadav.amit@gmail.com>, kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] x86/hyper-v: Mark TLFS structures packed
Thread-Topic: [PATCH v2] x86/hyper-v: Mark TLFS structures packed
Thread-Index: AQHUiKvVUGSDM9tHKkmr+QCmZQuk9KVpauCAgAKzOoCAAIB1gA==
Date:   Mon, 3 Dec 2018 07:15:25 +0000
Message-ID: <20181203071520.GA17278@rkaganb.sw.ru>
References: <20181130125422.21494-1-vkuznets@redhat.com>
 <DC5975C2-6517-4D20-9DC9-574C5439C426@gmail.com>
 <87k1krh588.fsf@vitty.brq.redhat.com>
In-Reply-To: <87k1krh588.fsf@vitty.brq.redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
mail-followup-to: =?iso-8859-2?Q?Roman_Kagan_<rkagan@virtuozzo.com>,=09Vitaly_Kuznetsov_<vk?=
 =?iso-8859-2?Q?uznets@redhat.com>,=09Nadav_Amit_<nadav.amit@gmail.com>,_k?=
 =?iso-8859-2?Q?vm_list_<kvm@vger.kernel.org>,=09Paolo_Bonzini_<pbonzini@r?=
 =?iso-8859-2?Q?edhat.com>,=09Radim_Kr=E8m=E1=F8_<rkrcmar@redhat.com>,=09L?=
 =?iso-8859-2?Q?KML_<linux-kernel@vger.kernel.org>,=09"K._Y._Srinivasan"_<?=
 =?iso-8859-2?Q?kys@microsoft.com>,=09Haiyang_Zhang_<haiyangz@microsoft.co?=
 =?iso-8859-2?Q?m>,=09Stephen_Hemminger_<sthemmin@microsoft.com>,_x86@kern?=
 =?iso-8859-2?Q?el.org,=09"Michael_Kelley_(EOSG)"_<Michael.H.Kelley@micros?=
 =?iso-8859-2?Q?oft.com>,=09Thomas_Gleixner_<tglx@linutronix.de>?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR05CA0225.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::25) To VI1PR08MB3599.eurprd08.prod.outlook.com
 (2603:10a6:803:85::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB2880;7:yVFGoABRfBkHtnboEQK0+4VpMwWyoTbwEnqjRDpbuQ73fKaFgjx0Y8lEeDSsgDdhYJoCkCi1hvwYwgVg5WxPT+yWct+TPCiRUFDdPhS69IK+9EizpNgLW8BFejftGJitCoEot+UueEJpvOd9EJlXdw==;20:Qju6+r2U4Js77cxEQDKyZbSYWnbVE9CfuJu3pGaUXMsHORaM3diuBZKKqaOfLOF5EUItU/wH6ADOOSjtBZzEYBpGWA4DJrf3hJ7E4DvM2gLrwL66tdhTTqenqgoo+l1LS1QO+TBiOCnqyyowDfipQUeiziK2vYKyY8VloX7pkE0=
x-ms-office365-filtering-correlation-id: d0282ec7-e20c-4f74-fc43-08d658ef1866
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB2880;
x-ms-traffictypediagnostic: VI1PR08MB2880:|VI1PR08MB2880:
x-microsoft-antispam-prvs: <VI1PR08MB28803D8BE3D7144C03128885C9AE0@VI1PR08MB2880.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231455)(999002)(944501493)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB2880;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB2880;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(39840400004)(396003)(376002)(346002)(366004)(136003)(199004)(189003)(97736004)(66066001)(478600001)(105586002)(106356001)(26005)(6916009)(7416002)(1076002)(6436002)(6116002)(39060400002)(14454004)(3846002)(6486002)(33656002)(229853002)(4326008)(186003)(2906002)(25786009)(5660300001)(54906003)(476003)(9686003)(58126008)(99286004)(6512007)(53936002)(256004)(52116002)(81156014)(81166006)(11346002)(7736002)(305945005)(36756003)(8676002)(71190400001)(8936002)(71200400001)(6246003)(68736007)(386003)(6506007)(102836004)(33896004)(446003)(486006)(76176011)(316002)(86362001)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR08MB2880;H:VI1PR08MB3599.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zdAolYZIPE9a9IGVPjIKMOWBz7hsfNvPzYofooXl6XaqgwQdWLyPKeMkx3qG04eLm2Z79oyfmle9xTQ/BvinTlK3EgIYZIdkfbJgvVpiVHHFRGYzeM314VDidklqmHCIVHyiKmXN+ygltcsnMOuRptXZJA2hWF0NTMG1nXW2e055B2o1WkDlciO5pIqJEvRtVey0DyVDDn9dVYS5K8WuVWCoOdJ6EGURl04dN1bdt28LqpoNPKjsijpiIwFNAueOELk3hV+cpM/8GuO6vZGmxr94MTWPk66AniJedoLXpz0ZkgcziEO03jqRmHP+v9FWvNEP+tQGi6dwKnPVdl/cnJfg5ZEfMXm0Ns3eDi3svYm5NxmAgJqhDdaUYy7fw9SloRL7/LHfCMAcr3+AJ0Gz3tmCIekqgf5fDhq0EwvEGVptCE6mQKZ3FKwCZUgSM3gg00To50KHwg3+Dh0cboJGAOCxowxco67OaTuvKse/CO2T9ccOFMSMQNxpaQB6Vv7wf0whochzenSy1KqLWGeJ1ytFP9lC920818euqFYjre0=
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <F12BC3B5BD5DB349AEC85F5CDC6D541E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0282ec7-e20c-4f74-fc43-08d658ef1866
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 07:15:25.4017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2880
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 12:35:35AM +0100, Vitaly Kuznetsov wrote:
> Nadav Amit <nadav.amit@gmail.com> writes:
>=20
> [skip]
>=20
> >
> > Having said that, something else is sort of strange in the TLFS definit=
ions,
> > I think (I really know little about this whole protocol). Look at the
> > following definitions from hyperv-tlfs.h:
> >
> >> struct hv_vpset {
> >>         u64 format;
> >>         u64 valid_bank_mask;
> >>         u64 bank_contents[];
> >> };
> >>=20
> >> struct hv_tlb_flush_ex {
> >>         u64 address_space;
> >>         u64 flags;
> >>         struct hv_vpset hv_vp_set;
> >>         u64 gva_list[];
> >> };
> >
> > It seems you have two flexible array members at the end of hv_tlb_flush=
_ex.
> > This causes bank_contents[x] and gva_list[x] to overlap. So unless they=
 have
> > the same meaning, this asks for trouble IMHO.
> >
>=20
> This is weird but intentional :-) We're just following Hyper-V spec
> here.
>=20
> E.g. HvFlushVirtualAddressListEx hypercall has the following input ABI:
>=20
> [Fixed len head][[Fixed len VP set spec]Var len VP set][Var len addr List=
]
>=20
> "Fixed len VP set spec" defines the true length of "Var len VP set" and
> "Address List" starts right after that. The length of the whole
> structure is also known.
>=20
> So bank_contents[] and gva_list[] do overlap (and have different
> meaning). We take special precautions when forming the structure
> (e.g. fill_gva_list() takes 'offset').

This basically means that the argument of this hypercall can't be
represented by a C struct.  gva_list just can't be used.  So I'd rather
remove it from the struct (but leave a comment to that end perhaps), and
construct the message in place (as is done now anyway).

Roman.

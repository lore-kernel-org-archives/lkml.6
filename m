Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F4CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29CF2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DiSulGKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29CF2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeLKODI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:03:08 -0500
Received: from mail-bgr052101131027.outbound.protection.outlook.com ([52.101.131.27]:49888
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726732AbeLKODI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QslHw6GWkclbe+2CFm1Nezqo+B3zkOhE/j5udv4eU2s=;
 b=DiSulGKRXdlWBLjuDZWHLAQbq4WUhGq1GP0tFyc3kZ/gK0Mpnn8Is8Q09Bliy+0wmti5m+WvgvJY1BItcnNNwYNpyWnLotyTW0HATk12t1nOpIojH507qlRR/SW+xO7H16K637EMBMRayzxG++1UWy/8Fn49w6wBQ5R7Cx3KGhM=
Received: from DB8PR08MB4092.eurprd08.prod.outlook.com (20.179.10.210) by
 DB8PR08MB4009.eurprd08.prod.outlook.com (20.179.9.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 14:02:52 +0000
Received: from DB8PR08MB4092.eurprd08.prod.outlook.com
 ([fe80::d41:d012:1944:5810]) by DB8PR08MB4092.eurprd08.prod.outlook.com
 ([fe80::d41:d012:1944:5810%6]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 14:02:52 +0000
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
        Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v2 4/7] x86/kvm/hyper-v: Introduce
 KVM_GET_SUPPORTED_HV_CPUID
Thread-Topic: [PATCH v2 4/7] x86/kvm/hyper-v: Introduce
 KVM_GET_SUPPORTED_HV_CPUID
Thread-Index: AQHUkKznsqV3L84bk0eamd/uIlqfEKV5sPkA///YaQCAAAmpAA==
Date:   Tue, 11 Dec 2018 14:02:52 +0000
Message-ID: <20181211140247.GC2378@rkaganb.sw.ru>
References: <20181210172159.410-1-vkuznets@redhat.com>
 <20181210172159.410-5-vkuznets@redhat.com>
 <20181211124956.GA2378@rkaganb.sw.ru> <87bm5sp501.fsf@vitty.brq.redhat.com>
In-Reply-To: <87bm5sp501.fsf@vitty.brq.redhat.com>
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
 =?iso-8859-2?Q?_<Michael.H.Kelley@microsoft.com>,=09Eduardo_Habkost_<ehab?=
 =?iso-8859-2?Q?kost@redhat.com>?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1P190CA0012.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::22)
 To DB8PR08MB4092.eurprd08.prod.outlook.com (2603:10a6:10:ab::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB8PR08MB4009;7:JwDypHk9qo2JTLaqRhHlwxHCHCLnEa0fCtcn00MoncytP+1dA4AOxi3VwnoKeO76FwcDulNdVvjLCkCbFQ+pnb/FRsi/U2IAWmTOmNfKfc8Ykd6ZF8p4J7Ytmze336niommsOfZOB2scTs2oUqdUwA==;20:Emwr9YZ6Fwt7F8SUfDNUNqEA64qhBQJvGL9yss85zqbZl9Tmc47RPXL47cM0ToigyH6+KVQTTWshdmhugWXqxYo2LKxIeRsBuoYqPPyfp4osf08F/m9ZmokVr4W7qrQByOZwAcaUSJVXxtm2tZSUH1d/951wcs9rIxu3EnG8F+M=
x-ms-office365-filtering-correlation-id: c5dd3aa3-0c3e-4418-fdd5-08d65f715705
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB8PR08MB4009;
x-ms-traffictypediagnostic: DB8PR08MB4009:|DB8PR08MB4009:
x-microsoft-antispam-prvs: <DB8PR08MB4009D39C892A785FB07A91FFC9A60@DB8PR08MB4009.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB8PR08MB4009;BCL:0;PCL:0;RULEID:;SRVR:DB8PR08MB4009;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(396003)(346002)(39850400004)(376002)(366004)(136003)(189003)(199004)(54094003)(1076002)(33656002)(305945005)(66066001)(9686003)(486006)(2906002)(6116002)(7736002)(14454004)(3846002)(478600001)(71200400001)(68736007)(97736004)(25786009)(446003)(36756003)(476003)(71190400001)(11346002)(256004)(4326008)(386003)(6246003)(6486002)(81156014)(186003)(26005)(316002)(106356001)(86362001)(105586002)(102836004)(6436002)(54906003)(6916009)(6506007)(8676002)(229853002)(99286004)(93886005)(33896004)(5660300001)(76176011)(6512007)(52116002)(58126008)(53936002)(81166006)(8936002)(7416002)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:DB8PR08MB4009;H:DB8PR08MB4092.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GPpKt4jZmOzGaD0DsQmZJdEPZiCZG0Mkol/LU+sXlb15aD3tOxDnVFCc/OWDqcL4vVekMIsJiLIf9EcadfiQhcOCLlHsGBd6B6ttaBBRYwf/jEmGxCQb0BPBe9NFq+RkmiRg6gKvvxohTizMU1irl4yYHzZw955zWOU2BDAyp4NIzQXcEkh7AgiWiV64xXKzsO5oip/ifz9xZA9SsncqtWlkQwCSFwyujhvuufsw7zVz0nnaACRhQuR6REudXu7OxvMF7oVTeSqgZx6ds0MMS1WXRuzM88mBThqh/kXu8Zq2UaqqaPyW64Qox2HrMXaeV/1NEgI/8+ws+xqQ2DZQgk1cyb2DlFVumwsOTEtOgl181ghjKhjByytwEwrnGSS/w8CTF0tuwZ5XYcJ4yXvwL9JRa+SEvTd6cv0ejrUgKx58CuvF8mF/cQDWurmMIQgc3vjLwdDvh0a4JhZbheaxJgMQtvh5Rb4H6ZdOgMcsqKr6Tc/3OViiyBVg1vp/8wuW
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <8253547EC0A35049BAC975F8D6FF5C48@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5dd3aa3-0c3e-4418-fdd5-08d65f715705
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 14:02:52.3813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 02:28:14PM +0100, Vitaly Kuznetsov wrote:
> Roman Kagan <rkagan@virtuozzo.com> writes:
>=20
> > On Mon, Dec 10, 2018 at 06:21:56PM +0100, Vitaly Kuznetsov wrote:
>=20
> >> +
> >> +Currently, the following list of CPUID leaves are returned:
> >> + HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS
> >> + HYPERV_CPUID_INTERFACE
> >> + HYPERV_CPUID_VERSION
> >> + HYPERV_CPUID_FEATURES
> >> + HYPERV_CPUID_ENLIGHTMENT_INFO
> >> + HYPERV_CPUID_IMPLEMENT_LIMITS
> >> + HYPERV_CPUID_NESTED_FEATURES
> >> +
> >> +HYPERV_CPUID_NESTED_FEATURES leaf is only exposed when Enlightened VM=
CS was
> >> +enabled on the corresponding vCPU (KVM_CAP_HYPERV_ENLIGHTENED_VMCS).
> >
> > IOW the output of ioctl(KVM_GET_SUPPORTED_HV_CPUID) depends on
> > whether ioctl(KVM_ENABLE_CAP, KVM_CAP_HYPERV_ENLIGHTENED_VMCS) has
> > already been called on that vcpu?  I wonder if this fits the intended
> > usage?
>=20
> I added HYPERV_CPUID_NESTED_FEATURES in the list (and made the new ioctl
> per-cpu and not per-vm) for consistency. *In theory*
> KVM_CAP_HYPERV_ENLIGHTENED_VMCS is also enabled per-vcpu so some
> hypothetical userspace can later check enabled eVMCS versions (which can
> differ across vCPUs!) with KVM_GET_SUPPORTED_HV_CPUID. We will also have
> direct tlb flush and other nested features there so to avoid addning new
> KVM_CAP_* for them we need the CPUID.

This is different from how KVM_GET_SUPPORTED_CPUID is used: QEMU assumes
that its output doesn't change between calls, and even caches the result
calling the ioctl only once.

> Another thing I'm thinking about is something like 'hv_all' cpu flag for
> Qemu which would enable everything by setting guest CPUIDs to what
> KVM_GET_SUPPORTED_HV_CPUID returns. In that case it would also be
> convenient to have HYPERV_CPUID_NESTED_FEATURES properly filled (or not
> filled when eVMCS was not enabled).

I think this is orthogonal to the way you obtain capability info from
the kernel.

Roman.

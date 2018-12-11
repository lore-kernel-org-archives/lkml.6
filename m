Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD93C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD2C2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="azhMmdK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD2C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeLKPKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:10:19 -0500
Received: from mail-bgr052101131033.outbound.protection.outlook.com ([52.101.131.33]:61472
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbeLKPKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:10:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYZwletayheEMg50Fjd90gDl8SDU7SoVqDLkjyNXzlU=;
 b=azhMmdK4gij+iK7hXuFeHsyqrwMF/OY/yEmRdxA6Pm7fqOMsRxWrTnKmfm1XALod39hPd59o92ZgAL21YnCInZZKYraL+KzGbogGx5Efxa3dnHl2NmxBtbXyqWr0SjEeUaCurPPKKwv2LEozEmqU1lanSXT81ckMhLP3wHhMl3g=
Received: from DB8PR08MB4092.eurprd08.prod.outlook.com (20.179.10.210) by
 DB8PR08MB3945.eurprd08.prod.outlook.com (20.179.8.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 15:10:08 +0000
Received: from DB8PR08MB4092.eurprd08.prod.outlook.com
 ([fe80::d41:d012:1944:5810]) by DB8PR08MB4092.eurprd08.prod.outlook.com
 ([fe80::d41:d012:1944:5810%6]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 15:10:08 +0000
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
Thread-Index: AQHUkKznsqV3L84bk0eamd/uIlqfEKV5sPkA///YaQCAADvygP//3tGAgAABsQA=
Date:   Tue, 11 Dec 2018 15:10:08 +0000
Message-ID: <20181211151003.GD2378@rkaganb.sw.ru>
References: <20181210172159.410-1-vkuznets@redhat.com>
 <20181210172159.410-5-vkuznets@redhat.com>
 <20181211124956.GA2378@rkaganb.sw.ru> <87bm5sp501.fsf@vitty.brq.redhat.com>
 <20181211140247.GC2378@rkaganb.sw.ru> <87woognlzy.fsf@vitty.brq.redhat.com>
In-Reply-To: <87woognlzy.fsf@vitty.brq.redhat.com>
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
x-clientproxiedby: HE1PR05CA0247.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::23) To DB8PR08MB4092.eurprd08.prod.outlook.com
 (2603:10a6:10:ab::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB8PR08MB3945;7:lBM73UN1ZkpWY46QBVqftDmsWYBUDZbv2FoEh8CtYO7mRzwoldAq/b9EiIIPs0jLbEfk77cEYSYkAoBDt5ab7niz0l5bEF+eTEbpLnhEFW0oBUsMY3GVD0iJAiiUR/vepFq/v7t8CmZwb0owFR9Xew==;20:wV/OF5L1YdyMzZJ9aBPkF28tBfcfCKRaGl+Veqx684LKrs1sRXJhwKwh7JRV6icvL/SFhykOS5goU2Uy1KtEkbCF+fYMIaNCieI7IuuUExwglZ2lPVcoBXkuqKZtvsBj4m1oGizBIIHJq7mV5InuwKEByfU9OkZtx/h6WBYhMxs=
x-ms-office365-filtering-correlation-id: 11c59bb0-78cf-4677-97fa-08d65f7abcb4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB8PR08MB3945;
x-ms-traffictypediagnostic: DB8PR08MB3945:|DB8PR08MB3945:
x-microsoft-antispam-prvs: <DB8PR08MB39458AF961EC5E2D3FED3B4EC9A60@DB8PR08MB3945.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231472)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB8PR08MB3945;BCL:0;PCL:0;RULEID:;SRVR:DB8PR08MB3945;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(366004)(376002)(39850400004)(136003)(346002)(396003)(199004)(189003)(54094003)(71190400001)(68736007)(99286004)(7416002)(53936002)(476003)(6436002)(3846002)(6506007)(386003)(71200400001)(1076002)(6512007)(76176011)(97736004)(9686003)(33896004)(58126008)(6116002)(2906002)(316002)(14454004)(52116002)(6246003)(4326008)(54906003)(66066001)(93886005)(86362001)(478600001)(36756003)(81156014)(8936002)(5660300001)(81166006)(7736002)(33656002)(25786009)(305945005)(102836004)(446003)(229853002)(256004)(26005)(106356001)(105586002)(486006)(186003)(6916009)(8676002)(11346002)(6486002)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:DB8PR08MB3945;H:DB8PR08MB4092.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: p3hIQomUsiWUZZDzX6oi+1ZJi3PyPSkNbMv/qyyN4KgVT9e4faqNb5QuCFrXRtBd7xn862gFHxARmjzMt0oMrZeopqe5AEngHn7v2CjNqAVMvM8tsCD2KYtKsnlbk2y0DlLux1BWyP6g3gY+8PRVEsjKIpAmIzEfTbQrz4LZasQ7tiCuAGtWMVJcV50ArsHTaDpvJuhGaRJ3fVhciuNpUBab+Sr2e2icHeLMakJ722yWrrdbx+9mnuAETfp+S/yPJeq7+iud6btjfVzKwX0iPE3mlmtHj+nUEpUmfVQqBNeog4lQYEZOKaYYRC79XzPrqnA8FKjzTHq+Emxd7Ia2N2s+lktcbxaSU6tU0vbRLZ7fQ9gvYcKy3eZsPsDnu/NDBFcz9YDn9+IlAdJgpCNNQaY+XNw4RMGBpCvD2qLQKCAoWHkGssVeco54CYzfa7zVCwnOhQ1WcWYaUFPayDxoHESZT8CVowT9coBMGmFQk1Xr00AU3aUODNfzwYqV/qjL
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <FEB59CF4EBAE2F41A17F41BE001A669A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c59bb0-78cf-4677-97fa-08d65f7abcb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 15:10:08.1798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3945
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 04:04:01PM +0100, Vitaly Kuznetsov wrote:
> Roman Kagan <rkagan@virtuozzo.com> writes:
>=20
> > On Tue, Dec 11, 2018 at 02:28:14PM +0100, Vitaly Kuznetsov wrote:
> >> Roman Kagan <rkagan@virtuozzo.com> writes:
> >>=20
> >> > On Mon, Dec 10, 2018 at 06:21:56PM +0100, Vitaly Kuznetsov wrote:
> >>=20
> >> >> +
> >> >> +Currently, the following list of CPUID leaves are returned:
> >> >> + HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS
> >> >> + HYPERV_CPUID_INTERFACE
> >> >> + HYPERV_CPUID_VERSION
> >> >> + HYPERV_CPUID_FEATURES
> >> >> + HYPERV_CPUID_ENLIGHTMENT_INFO
> >> >> + HYPERV_CPUID_IMPLEMENT_LIMITS
> >> >> + HYPERV_CPUID_NESTED_FEATURES
> >> >> +
> >> >> +HYPERV_CPUID_NESTED_FEATURES leaf is only exposed when Enlightened=
 VMCS was
> >> >> +enabled on the corresponding vCPU (KVM_CAP_HYPERV_ENLIGHTENED_VMCS=
).
> >> >
> >> > IOW the output of ioctl(KVM_GET_SUPPORTED_HV_CPUID) depends on
> >> > whether ioctl(KVM_ENABLE_CAP, KVM_CAP_HYPERV_ENLIGHTENED_VMCS) has
> >> > already been called on that vcpu?  I wonder if this fits the intende=
d
> >> > usage?
> >>=20
> >> I added HYPERV_CPUID_NESTED_FEATURES in the list (and made the new ioc=
tl
> >> per-cpu and not per-vm) for consistency. *In theory*
> >> KVM_CAP_HYPERV_ENLIGHTENED_VMCS is also enabled per-vcpu so some
> >> hypothetical userspace can later check enabled eVMCS versions (which c=
an
> >> differ across vCPUs!) with KVM_GET_SUPPORTED_HV_CPUID. We will also ha=
ve
> >> direct tlb flush and other nested features there so to avoid addning n=
ew
> >> KVM_CAP_* for them we need the CPUID.
> >
> > This is different from how KVM_GET_SUPPORTED_CPUID is used: QEMU assume=
s
> > that its output doesn't change between calls, and even caches the resul=
t
> > calling the ioctl only once.
> >
>=20
> Yes, I'm not sure if we have to have full consistency between
> KVM_GET_SUPPORTED_CPUID and KVM_GET_SUPPORTED_HV_CPUID.

Neither do I.  I just noticed the difference and thought it might
matter.

> >> Another thing I'm thinking about is something like 'hv_all' cpu flag f=
or
> >> Qemu which would enable everything by setting guest CPUIDs to what
> >> KVM_GET_SUPPORTED_HV_CPUID returns. In that case it would also be
> >> convenient to have HYPERV_CPUID_NESTED_FEATURES properly filled (or no=
t
> >> filled when eVMCS was not enabled).
> >
> > I think this is orthogonal to the way you obtain capability info from
> > the kernel.
>=20
> Not necessarily. If very dumb userspace does 'host passthrough' for
> Hyper-V features without doing anything (e.g. not enabling Enlightened
> VMCS) it will just put the result of KVM_GET_SUPPORTED_HV_CPUID in guest
> facing CPUIDs and it will all work. In case eVMCS was previously enabled
> it again just copies everything and this still works.
>=20
> We don't probably need this for Qemu though. If you think it would be
> better to have HYPERV_CPUID_NESTED_FEATURES returned regardless of eVMCS
> enablement I'm ready to budge)

I have no opinion on this.  I hope Paolo, who requested the feature, can
explain the desired semantics :)

Roman.

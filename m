Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF7CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A8920672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UNPQr2YA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A8920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeK0G7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:59:44 -0500
Received: from mail-bgr052101130017.outbound.protection.outlook.com ([52.101.130.17]:54553
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726363AbeK0G7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+il45PmpiXoZhBPzryTu5/kHbMjr8WkxVf7X4sZyaxs=;
 b=UNPQr2YA9KVGb2FB8/Zx1Lm8HmCZZhzE3Z9riM2XZ0KEHoNy5YHYGTyGcIEBismHn99acDKGcS9lrMLzOgHv8yXrfc3qdQn5PoQMIqgpEUlqxEMZ68i+iz4cHiiP2GQ5UlwfyiCvghgNaYXs2N09oReUnLsPHIPAoYBPx2AcQPc=
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com (20.177.61.74) by
 VI1PR08MB3903.eurprd08.prod.outlook.com (20.178.81.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Mon, 26 Nov 2018 20:04:17 +0000
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::5d2c:980a:d77e:34e2]) by VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::5d2c:980a:d77e:34e2%3]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 20:04:17 +0000
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
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: Re: [PATCH v2 1/4] x86/hyper-v: move synic/stimer control structures
 definitions to hyperv-tlfs.h
Thread-Topic: [PATCH v2 1/4] x86/hyper-v: move synic/stimer control structures
 definitions to hyperv-tlfs.h
Thread-Index: AQHUhZ9iirF501eLF0yD2vJWccWjqaVieyiA
Date:   Mon, 26 Nov 2018 20:04:17 +0000
Message-ID: <20181126200413.GA7852@rkaganb.sw.ru>
References: <20181126154732.23025-1-vkuznets@redhat.com>
 <20181126154732.23025-2-vkuznets@redhat.com>
In-Reply-To: <20181126154732.23025-2-vkuznets@redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
mail-followup-to: =?iso-8859-2?Q?Roman_Kagan_<rkagan@virtuozzo.com>,=09Vitaly_Kuznetsov_<vk?=
 =?iso-8859-2?Q?uznets@redhat.com>,_kvm@vger.kernel.org,=09Paolo_Bonzini_<?=
 =?iso-8859-2?Q?pbonzini@redhat.com>,=09Radim_Kr=E8m=E1=F8_<rkrcmar@redhat?=
 =?iso-8859-2?Q?.com>,=09linux-kernel@vger.kernel.org,=09"K._Y._Srinivasan?=
 =?iso-8859-2?Q?"_<kys@microsoft.com>,=09Haiyang_Zhang_<haiyangz@microsoft?=
 =?iso-8859-2?Q?.com>,=09Stephen_Hemminger_<sthemmin@microsoft.com>,_x86@k?=
 =?iso-8859-2?Q?ernel.org,=09"Michael_Kelley_(EOSG)"_<Michael.H.Kelley@mic?=
 =?iso-8859-2?Q?rosoft.com>?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR0501CA0042.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::52) To VI1PR08MB3599.eurprd08.prod.outlook.com
 (2603:10a6:803:85::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB3903;7:hwmsaLRhArd5TqV6o39ulTLdiURVCK8pP/bKtP5yPSP1IRN7ek1NhSub/tzv6YgbnSXefJ+Tx5FENrho7sG3AckVL4wIxxOV/oH9eG36lejh/v5XeVMPtVw/TjYjGNJYfk8Xa2MT4tkzYiWFwQfhlg==;20:2X293c58EPS/cSy2hX1pz8a2I8wpRsnnp9SBVwTP5trndfm4fTyH9yihTIbVFCcUNcyYPyvs/fML2c4L/N2OqBh28q4G0OWmpTtKKRxLab3Ubee5SYJ+1HyX3+A4RP5JbP100ngs82622KXNhgq1IFH7W7xDSvXknSMlYPJhhIg=
x-ms-office365-filtering-correlation-id: 0b3ab5d3-8ae3-4433-5de3-08d653da5850
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3903;
x-ms-traffictypediagnostic: VI1PR08MB3903:|VI1PR08MB3903:
x-microsoft-antispam-prvs: <VI1PR08MB39037BA50937F7C889D67C33C9D70@VI1PR08MB3903.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231443)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB3903;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3903;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(346002)(366004)(396003)(39850400004)(376002)(136003)(199004)(189003)(25786009)(7416002)(316002)(68736007)(256004)(6512007)(81156014)(6506007)(9686003)(86362001)(575784001)(81166006)(54906003)(58126008)(8676002)(5660300001)(8936002)(26005)(33656002)(3846002)(386003)(476003)(71200400001)(71190400001)(11346002)(4326008)(446003)(229853002)(6436002)(478600001)(305945005)(1076002)(99286004)(7736002)(14454004)(36756003)(6486002)(66066001)(486006)(33896004)(6246003)(97736004)(6116002)(52116002)(106356001)(76176011)(102836004)(2906002)(186003)(53936002)(6916009)(105586002)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR08MB3903;H:VI1PR08MB3599.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HE0aZrrxl8AzXxV0coqOXPWf24t3z8D86OKVtUfgKz86ordVIc0fLhC6AnE65YPaC6cgdI2PRumnZJQan/4bsTfhnDNr/3+ni/ahTbFETz70QgbQldYAotWgi4EM+hkSrjtyXQ0W72ol+Ol5nvqfa28NO4uEW8k+Na59o3NEmlB2zYPuIsqubore823WJpXz/r1BomSilirEm2Yqp34M+L+DgVa4WEp/CGoT36Q6lP77Y2SsR8njlJJRlYpAMijTZRj5WjrlX2XoE9hMnGo/Tzhma6loBL/68ilPOtdZSCL7hqEclSX4vtPwKckpi44ETs79WssjtSh+RXFCxzp6n0rMQgxo7PxqBJJ/8kW5Sj0aN16RJXC/FeL1Rv5/HpEleFXln1MWlxd1MdvAqwOSrqkOqLtgXRa2P1MAGW4a4T29nLRhVo0rISvVIs90WyyL4ckbxIHzvnGb8GHCB0rwLzvY3ohpF3PLJNRpEWlQSGVSe7t57P19UOGVAKYZ91X/VnRc7M6btzKJzXfrdASBjMvPph58RZf7lRvfrFnbAQI=
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <1CA0C52D14A2684D877F2BE9F068C0A0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3ab5d3-8ae3-4433-5de3-08d653da5850
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 20:04:17.2804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3903
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Sorry for having missed v1 ]

On Mon, Nov 26, 2018 at 04:47:29PM +0100, Vitaly Kuznetsov wrote:
> We implement Hyper-V SynIC and synthetic timers in KVM too so there's som=
e
> room for code sharing.
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 69 ++++++++++++++++++++++++++++++
>  drivers/hv/hv.c                    |  2 +-
>  drivers/hv/hyperv_vmbus.h          | 68 -----------------------------
>  3 files changed, 70 insertions(+), 69 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index 4139f7650fe5..b032c05cd3ee 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -731,6 +731,75 @@ struct hv_enlightened_vmcs {
>  #define HV_STIMER_AUTOENABLE		(1ULL << 3)
>  #define HV_STIMER_SINT(config)		(__u8)(((config) >> 16) & 0x0F)
> =20
> +/* Define synthetic interrupt controller flag constants. */
> +#define HV_EVENT_FLAGS_COUNT		(256 * 8)
> +#define HV_EVENT_FLAGS_LONG_COUNT	(256 / sizeof(unsigned long))
> +
> +/*
> + * Synthetic timer configuration.
> + */
> +union hv_stimer_config {
> +	u64 as_uint64;
> +	struct {
> +		u64 enable:1;
> +		u64 periodic:1;
> +		u64 lazy:1;
> +		u64 auto_enable:1;
> +		u64 apic_vector:8;
> +		u64 direct_mode:1;
> +		u64 reserved_z0:3;
> +		u64 sintx:4;
> +		u64 reserved_z1:44;
> +	};
> +};
> +
> +
> +/* Define the synthetic interrupt controller event flags format. */
> +union hv_synic_event_flags {
> +	unsigned long flags[HV_EVENT_FLAGS_LONG_COUNT];
> +};
> +
> +/* Define SynIC control register. */
> +union hv_synic_scontrol {
> +	u64 as_uint64;
> +	struct {
> +		u64 enable:1;
> +		u64 reserved:63;
> +	};
> +};
> +
> +/* Define synthetic interrupt source. */
> +union hv_synic_sint {
> +	u64 as_uint64;
> +	struct {
> +		u64 vector:8;
> +		u64 reserved1:8;
> +		u64 masked:1;
> +		u64 auto_eoi:1;
> +		u64 reserved2:46;
> +	};
> +};
> +
> +/* Define the format of the SIMP register */
> +union hv_synic_simp {
> +	u64 as_uint64;
> +	struct {
> +		u64 simp_enabled:1;
> +		u64 preserved:11;
> +		u64 base_simp_gpa:52;
> +	};
> +};
> +
> +/* Define the format of the SIEFP register */
> +union hv_synic_siefp {
> +	u64 as_uint64;
> +	struct {
> +		u64 siefp_enabled:1;
> +		u64 preserved:11;
> +		u64 base_siefp_gpa:52;
> +	};
> +};
> +
>  struct hv_vpset {
>  	u64 format;
>  	u64 valid_bank_mask;

I personally tend to prefer masks over bitfields, so I'd rather do the
consolidation in the opposite direction: use the definitions in
hyperv-tlfs.h and replace those unions/bitfields elsewhere.  (I vaguely
remember posting such a patchset a couple of years ago but I lacked the
motivation to complete it).

Roman.

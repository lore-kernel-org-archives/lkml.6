Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FA0C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8234920867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eMB0OHeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8234920867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeLAA0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:26:05 -0500
Received: from mail-db3eur04hn0211.outbound.protection.outlook.com ([104.47.12.211]:50942
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726070AbeLAA0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6R5bQX/YZlRqRSztV0hqdUfZiF7nrUq8Adsbdxv3zc=;
 b=eMB0OHeZKSG/wsuNInRuQ8cndSrRsINBDpHFGS+ws2evLS9v4wdmTfYZic7Fj+w6TJ2nzXFQp9HNJkkfLBsr/NwD1WM/gAY96/s5ldnR1WB5BmXMHligVaf63iw3Ut/5q8m7zJlQn7FiqPyE8Pg7dG41t5kQzxp/PLtFMaQHdEI=
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com (20.177.61.74) by
 VI1PR08MB4191.eurprd08.prod.outlook.com (20.178.204.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Fri, 30 Nov 2018 13:11:27 +0000
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::5d2c:980a:d77e:34e2]) by VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::5d2c:980a:d77e:34e2%3]) with mapi id 15.20.1361.019; Fri, 30 Nov 2018
 13:11:27 +0000
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
Thread-Index: AQHUiKZd3jLH2BBgGUSaUQtypGqxhKVoSxWA
Date:   Fri, 30 Nov 2018 13:11:27 +0000
Message-ID: <20181130131122.GA2358@rkaganb.sw.ru>
References: <20181130121511.12331-1-vkuznets@redhat.com>
In-Reply-To: <20181130121511.12331-1-vkuznets@redhat.com>
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
 =?iso-8859-2?Q?rosoft.com>,=09Nadav_Amit_<nadav.amit@gmail.com>,=09Thomas?=
 =?iso-8859-2?Q?_Gleixner_<tglx@linutronix.de>?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR0102CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::14) To VI1PR08MB3599.eurprd08.prod.outlook.com
 (2603:10a6:803:85::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB4191;7:JRtABqK9ZZelqpUdVdejEHIkeKdTpEizMuirLhh/6gAtMoSRHTCBBTWSBvfrKQfsuwapI0R1M3E1IwJ4wMv11iJ8cNPIQQicAw2/rkfjHthkAScKT8KCE0yyjBX4/WBj4LHSKZKDCXV3Fw20izRFOg==;20:dvP1f8+nYi55Tl4Vv+sitXZvQsyh2+mKGnvy0iEj4sT9vlQW/bg5f6yc/s0V280JdIZEIvzGrHhP0EtMphV3ycFplNIF6oOIeQhLcny2RbFaF7BgWTLdCQomBUz5fjzDjnLoS7y7UP/OwACxyVt9MN0zNl0pWuDExPlTm1w6fQI=
x-ms-office365-filtering-correlation-id: 7b132f68-fc4a-4fbd-b32e-08d656c55614
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB4191;
x-ms-traffictypediagnostic: VI1PR08MB4191:|VI1PR08MB4191:
x-microsoft-antispam-prvs: <VI1PR08MB419126EB1E41A2F0F671332BC9D30@VI1PR08MB4191.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231453)(999002)(944501466)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB4191;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB4191;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(346002)(39850400004)(396003)(376002)(366004)(136003)(189003)(199004)(8936002)(53936002)(9686003)(36756003)(99286004)(86362001)(6512007)(256004)(14444005)(58126008)(33896004)(6916009)(54906003)(7736002)(305945005)(66066001)(76176011)(316002)(575784001)(71190400001)(71200400001)(6246003)(68736007)(6506007)(5660300001)(102836004)(52116002)(105586002)(106356001)(97736004)(7416002)(386003)(39060400002)(26005)(6436002)(486006)(14454004)(1076002)(81156014)(478600001)(6486002)(81166006)(2906002)(446003)(25786009)(186003)(33656002)(3846002)(6116002)(8676002)(476003)(11346002)(4326008)(229853002)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR08MB4191;H:VI1PR08MB3599.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cXgTaPn1gzVd6paKxsizd+TDJy362Yf4+YjmPyNZRm163ok4GubMyqmfbvkWQhGOxOXL39+BHNYLGZfZ7y0Fjv3esw2u+8sx04lr9NCIMmV55VaZYto/DC1mRMCVbzLE+KfwBYnb02AJWvT/z0vtSItD8g63OWi1dcUbCtngvLzkZN0mh8Idk0/tijQqunPm6x03NHuXT2t/txA9mz3Xb7iU8dGMWpu/dzSolmih3ny334Xg29y4fWIx9t3RVwWbHdwrywLEXilxp5FQAekrRxfYuTB2VGK87/xjAFO+MA8i5hNLUqQmJ1ZV0/oZJJuYW+daMbZ8MPJYTlDsGXUF/V5D4+gOrUtDpYIdkd6De7GjHS5mQSO600vlu5pAGVOaMGP1WWfOVB+ghm/k3LGMSpaY5vW1/e7LVO/5pI6OtZQgC1DfHtSUTOezsRD+yIDG1408MDIr+zF+D6KZ6fcySrG2EKF8VrA5d7z21q+LIT8rYeRG09cPmPODf4pMjKzwHrkHhkb+C/23Yk2vcypT4qMfTOHoYXPkwgRqLXE1ZYQ=
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <E8E72165D3A64645BBCD82CC4B6B04E2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b132f68-fc4a-4fbd-b32e-08d656c55614
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 13:11:27.7931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 01:15:11PM +0100, Vitaly Kuznetsov wrote:
> Without 'packed' compiler is free to add optimization paddings and re-ord=
er
> structure fields for randomization/optimization. And structures from
> hyperv-tlfs.h are used for hypervisor-guest communication, we need to
> ultimately forbid such practices.

Note that __packed also reduces the structure alignment to 1, which is
not necessarily what you want.

E.g. some of these structures are passed by pointer to the hypercall,
which requires its arguments to be 8byte-aligned.  I'm also not sure
that passing unaligned argument to [rw]msr is ok, need to double-check.

Roman.

> Suggested-by: Nadav Amit <nadav.amit@gmail.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> - This is a follow-up to my "[PATCH v2 0/4] x86/kvm/hyper-v: Implement
>  Direct Mode for synthetic timers" series, as suggested by Thomas I'm
>  routing it to KVM tree to avoid merge conflicts.
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 50 +++++++++++++++---------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index ebfed56976d2..6a60fa17f6f2 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -271,7 +271,7 @@ union hv_x64_msr_hypercall_contents {
>  		u64 enable:1;
>  		u64 reserved:11;
>  		u64 guest_physical_address:52;
> -	};
> +	} __packed;
>  };
> =20
>  /*
> @@ -283,7 +283,7 @@ struct ms_hyperv_tsc_page {
>  	volatile u64 tsc_scale;
>  	volatile s64 tsc_offset;
>  	u64 reserved2[509];
> -};
> +}  __packed;
> =20
>  /*
>   * The guest OS needs to register the guest ID with the hypervisor.
> @@ -324,7 +324,7 @@ struct hv_reenlightenment_control {
>  	__u64 enabled:1;
>  	__u64 reserved2:15;
>  	__u64 target_vp:32;
> -};
> +}  __packed;
> =20
>  #define HV_X64_MSR_TSC_EMULATION_CONTROL	0x40000107
>  #define HV_X64_MSR_TSC_EMULATION_STATUS		0x40000108
> @@ -332,12 +332,12 @@ struct hv_reenlightenment_control {
>  struct hv_tsc_emulation_control {
>  	__u64 enabled:1;
>  	__u64 reserved:63;
> -};
> +} __packed;
> =20
>  struct hv_tsc_emulation_status {
>  	__u64 inprogress:1;
>  	__u64 reserved:63;
> -};
> +} __packed;
> =20
>  #define HV_X64_MSR_HYPERCALL_ENABLE		0x00000001
>  #define HV_X64_MSR_HYPERCALL_PAGE_ADDRESS_SHIFT	12
> @@ -409,7 +409,7 @@ typedef struct _HV_REFERENCE_TSC_PAGE {
>  	__u32 res1;
>  	__u64 tsc_scale;
>  	__s64 tsc_offset;
> -} HV_REFERENCE_TSC_PAGE, *PHV_REFERENCE_TSC_PAGE;
> +}  __packed HV_REFERENCE_TSC_PAGE, *PHV_REFERENCE_TSC_PAGE;
> =20
>  /* Define the number of synthetic interrupt sources. */
>  #define HV_SYNIC_SINT_COUNT		(16)
> @@ -466,7 +466,7 @@ union hv_message_flags {
>  	struct {
>  		__u8 msg_pending:1;
>  		__u8 reserved:7;
> -	};
> +	} __packed;
>  };
> =20
>  /* Define port identifier type. */
> @@ -488,7 +488,7 @@ struct hv_message_header {
>  		__u64 sender;
>  		union hv_port_id port;
>  	};
> -};
> +} __packed;
> =20
>  /* Define synthetic interrupt controller message format. */
>  struct hv_message {
> @@ -496,12 +496,12 @@ struct hv_message {
>  	union {
>  		__u64 payload[HV_MESSAGE_PAYLOAD_QWORD_COUNT];
>  	} u;
> -};
> +} __packed;
> =20
>  /* Define the synthetic interrupt message page layout. */
>  struct hv_message_page {
>  	struct hv_message sint_message[HV_SYNIC_SINT_COUNT];
> -};
> +} __packed;
> =20
>  /* Define timer message payload structure. */
>  struct hv_timer_message_payload {
> @@ -509,7 +509,7 @@ struct hv_timer_message_payload {
>  	__u32 reserved;
>  	__u64 expiration_time;	/* When the timer expired */
>  	__u64 delivery_time;	/* When the message was delivered */
> -};
> +} __packed;
> =20
>  /* Define virtual processor assist page structure. */
>  struct hv_vp_assist_page {
> @@ -519,7 +519,7 @@ struct hv_vp_assist_page {
>  	__u64 nested_enlightenments_control[2];
>  	__u32 enlighten_vmentry;
>  	__u64 current_nested_vmcs;
> -};
> +} __packed;
> =20
>  struct hv_enlightened_vmcs {
>  	u32 revision_id;
> @@ -693,7 +693,7 @@ struct hv_enlightened_vmcs {
>  		u32 nested_flush_hypercall:1;
>  		u32 msr_bitmap:1;
>  		u32 reserved:30;
> -	} hv_enlightenments_control;
> +	}  __packed hv_enlightenments_control;
>  	u32 hv_vp_id;
> =20
>  	u64 hv_vm_id;
> @@ -703,7 +703,7 @@ struct hv_enlightened_vmcs {
>  	u64 padding64_5[7];
>  	u64 xss_exit_bitmap;
>  	u64 padding64_6[7];
> -};
> +} __packed;
> =20
>  #define HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE			0
>  #define HV_VMX_ENLIGHTENED_CLEAN_FIELD_IO_BITMAP		BIT(0)
> @@ -744,7 +744,7 @@ union hv_stimer_config {
>  		u64 reserved_z0:3;
>  		u64 sintx:4;
>  		u64 reserved_z1:44;
> -	};
> +	} __packed;
>  };
> =20
> =20
> @@ -759,7 +759,7 @@ union hv_synic_scontrol {
>  	struct {
>  		u64 enable:1;
>  		u64 reserved:63;
> -	};
> +	} __packed;
>  };
> =20
>  /* Define synthetic interrupt source. */
> @@ -771,7 +771,7 @@ union hv_synic_sint {
>  		u64 masked:1;
>  		u64 auto_eoi:1;
>  		u64 reserved2:46;
> -	};
> +	} __packed;
>  };
> =20
>  /* Define the format of the SIMP register */
> @@ -781,7 +781,7 @@ union hv_synic_simp {
>  		u64 simp_enabled:1;
>  		u64 preserved:11;
>  		u64 base_simp_gpa:52;
> -	};
> +	} __packed;
>  };
> =20
>  /* Define the format of the SIEFP register */
> @@ -791,34 +791,34 @@ union hv_synic_siefp {
>  		u64 siefp_enabled:1;
>  		u64 preserved:11;
>  		u64 base_siefp_gpa:52;
> -	};
> +	} __packed;
>  };
> =20
>  struct hv_vpset {
>  	u64 format;
>  	u64 valid_bank_mask;
>  	u64 bank_contents[];
> -};
> +} __packed;
> =20
>  /* HvCallSendSyntheticClusterIpi hypercall */
>  struct hv_send_ipi {
>  	u32 vector;
>  	u32 reserved;
>  	u64 cpu_mask;
> -};
> +} __packed;
> =20
>  /* HvCallSendSyntheticClusterIpiEx hypercall */
>  struct hv_send_ipi_ex {
>  	u32 vector;
>  	u32 reserved;
>  	struct hv_vpset vp_set;
> -};
> +} __packed;
> =20
>  /* HvFlushGuestPhysicalAddressSpace hypercalls */
>  struct hv_guest_mapping_flush {
>  	u64 address_space;
>  	u64 flags;
> -};
> +} __packed;
> =20
>  /* HvFlushVirtualAddressSpace, HvFlushVirtualAddressList hypercalls */
>  struct hv_tlb_flush {
> @@ -826,7 +826,7 @@ struct hv_tlb_flush {
>  	u64 flags;
>  	u64 processor_mask;
>  	u64 gva_list[];
> -};
> +} __packed;
> =20
>  /* HvFlushVirtualAddressSpaceEx, HvFlushVirtualAddressListEx hypercalls =
*/
>  struct hv_tlb_flush_ex {
> @@ -834,6 +834,6 @@ struct hv_tlb_flush_ex {
>  	u64 flags;
>  	struct hv_vpset hv_vp_set;
>  	u64 gva_list[];
> -};
> +} __packed;
> =20
>  #endif
> --=20
> 2.19.2
>=20

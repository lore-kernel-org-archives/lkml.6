Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAF4ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3724D20870
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="FYAotS7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3724D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeGMKqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:46:34 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:52206 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727147AbeGMKqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:46:34 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie3.idc.renesas.com with ESMTP; 13 Jul 2018 19:32:28 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id 14E0B7B98D;
        Fri, 13 Jul 2018 19:32:28 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,347,1526310000"; 
   d="scan'208";a="286798421"
Received: from mail-ty1jpn01lp0177.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.177])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2018 19:32:28 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WClkPDRMi0ijRYK+FhonINEsoutK6b/TMfTsg5xfFDM=;
 b=FYAotS7JSSOGk1lw6HMQaiHynLIZ8KqYnvSVidSYSI4XLzGr69dyDf2a8rg62PLDNplxnI+cHMh7iRK7P7V+amdrMcjtkabFkvQXuDNdVsBvs7lwKhKt+MQdci5PxoQ0rSNZavAm23oO+/3wgTUaXPA21sg3reuEmCAt0ml6U7k=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1072.jpnprd01.prod.outlook.com (10.174.225.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Fri, 13 Jul 2018 10:32:24 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::7df1:2cfe:4c9d:738f]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::7df1:2cfe:4c9d:738f%2]) with mapi id 15.20.0952.017; Fri, 13 Jul 2018
 10:32:23 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Russell King <linux@armlinux.org.uk>
CC:     =?iso-8859-2?Q?=A3ukasz_Stelmach?= <l.stelmach@samsung.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nico@linaro.org" <nico@linaro.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "cdall@linaro.org" <cdall@linaro.org>
Subject: RE: [RFC PATCH] ARM: Debug kernel copy by printing
Thread-Topic: [RFC PATCH] ARM: Debug kernel copy by printing
Thread-Index: AQHUDVhP3BDImVXdyUOu+9yOi2yPYKSNDKNQ
Date:   Fri, 13 Jul 2018 10:32:23 +0000
Message-ID: <TY1PR01MB177010920A6FC7FC1B61358BC0580@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1530022595-6806-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1530022595-6806-1-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1072;7:riVq7ty9b6J7bO7UYAhQz3oy0Gk9/MV3fMShuTi2gC52TD46mDSlNNdJ1uku81YsxQTQ5yZDzbjpB8gt4oyiCxFJxityWHIgvYAYPL+hSZzgwH/M7BSlitBn1tcKKL+fjqVuN+EhHzbWi0a+gMNtjy/8TErr6mvRyyPoJCeCzReQ8SvFQeFB7+ggRCf456wKjPleNyx7jBSc1ofANStFZ8jAxo0R0Og67DRJJdRi02ZaGdIRmvSGykOLWZTmn9+S;20:Xsl4cBfmLlHt5awbgx9rGsXbtXooO8B+MVK3q6DwajCUCt2dWnCpPsg3gNUx8qKKaTLej4wLP4k9KE84XcnERAnnqlbjgOK1WDnEMPG71/37sTPxyUjbSFawmZGdY8gXpJPfm2o7wMfOB2YPhjfpOERASnElye8qcezBb3knoIM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 9d24b804-d47c-4b9e-df9f-08d5e8abebee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1072;
x-ms-traffictypediagnostic: TY1PR01MB1072:
x-microsoft-antispam-prvs: <TY1PR01MB10729F8A24336074E9244986C0580@TY1PR01MB1072.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB1072;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1072;
x-forefront-prvs: 07326CFBC4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(136003)(366004)(199004)(189003)(186003)(26005)(229853002)(53936002)(66066001)(33656002)(99286004)(256004)(305945005)(76176011)(7696005)(105586002)(3846002)(7736002)(74316002)(6116002)(478600001)(14454004)(413944005)(106356001)(14444005)(6506007)(2906002)(6916009)(316002)(54906003)(55016002)(102836004)(81156014)(8676002)(5250100002)(5660300001)(8936002)(68736007)(97736004)(6436002)(81166006)(575784001)(4326008)(25786009)(476003)(11346002)(446003)(86362001)(7416002)(2900100001)(486006)(9686003)(44832011)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1072;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Kkpl8Zjp+3V60eLmVDL2CGnd4ZLVXv9KYX/isSTlcxS0bQql2Btvi1teH929DjmMg3keb5EYOtrthWB/xTKX/yeAJUrGXNWad4BNS2ve6cGqxeqLlxbUgzDatC0vKggasaqL7xYag/fVUZ+hwePHepDTbeVQ6FU6r1HHJDYEoREvMaZTQU9HeJde7YbVgzv6xBQMSbyyCr3g0mmXFNpotjI2KsCRwRCc9fcFHy/fmYeZsQ8mLifXWITm8hnEV5rcO3j+DbUcDQYOKRWmgN8J7FolIl0cGoRa2Y0UFl8j+DbkZMoNmrPTfhjgLW03oKInjHix08RwbiQ8iVDVgWARgklfcue8nU2F3Roq9Lfbmew=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d24b804-d47c-4b9e-df9f-08d5e8abebee
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2018 10:32:23.6114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

Has anybody had the chance to look into this? Does it make sense? Any feedb=
ack at all?
Thanks!

Fab

> Subject: [RFC PATCH] ARM: Debug kernel copy by printing
>
> It may happen that when we relocate the kernel we corrupt other
> sensible memory (e.g. the memory needed by U-Boot for dealing
> with bootm command) while copying the kernel. If we overwrite
> the content of the memory area used by U-Boot's command bootm
> (described by U-Boot's parameters bootm_low and bootm_size),
> the kernel won't be able to boot. Troubleshooting the problem
> then is not straightforward.
>
> This commit allows the user to easily print information on
> where the kernel gets copied from/to in order to help with the
> design of the system memory map (e.g. bootm_low and bootm_size)
> at boot up.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> Acked-by: Biju Das <biju.das@bp.renesas.com>
> ---
> Dear All,
>
> shmobile_defconfig doesn't use kernel modules, everything gets
> built-in. iwg20d and iwg22d platforms from iWave use uImage
> to boot, DRAM starts at address 0x40000000, the kernel gets
> loaded up in memory at address 0x40007fc0, bootm_low is
> 0x40e00000, and bootm_size is 0x100000.
>
> The kernel is getting larger and larger, so much so that during
> the relocation the kernel is copying itself right where the
> bootm memory area lives, preventing Linux from booting.
> Here is what this patch prints when applied on top of tag
> next-20180625 and running on the iwg22d:
>
> C:0x400080C0-0x404922A0->0x40E90800-0x4131A9E0
>
> The designer then has to pick up a suitable memory range for
> bootm memory area to fix this, but the only way to successfully
> achieve this is by knowing where the kernel is going to copy
> itself in memory, so that he can stay clear of it.
>
> Other platforms that use the same defconfig suffer from the same
> issue (e.g. Koelsch et al.) as they have been designed some time
> ago or the original BSP was based on an LTS kernel.
>
> Debugging this basically requires a JTAG debugger at this stage.
>
> Do you think this patch could be considered acceptable? If not,
> what would be the best way to get useful/sensible/debug
> information out of the kernel when the problem occours?
>
> Comments welcome!
>
> Thanks,
> Fab
>
>  arch/arm/boot/compressed/head.S | 43 +++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/h=
ead.S
> index 517e0e1..6c7ccb4 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -114,6 +114,35 @@
>  #endif
>  .endm
>
> +/*
> + * Debug kernel copy by printing the memory addresses involved
> + */
> +.macro dbgkc, begin, end, cbegin, cend
> +#ifdef DEBUG
> +kputc   #'\n'
> +kputc   #'C'
> +kputc   #':'
> +kputc   #'0'
> +kputc   #'x'
> +kphex   \begin, 8/* Start of compressed kernel */
> +kputc#'-'
> +kputc#'0'
> +kputc#'x'
> +kphex\end, 8/* End of compressed kernel */
> +kputc#'-'
> +kputc#'>'
> +kputc   #'0'
> +kputc   #'x'
> +kphex   \cbegin, 8/* Start of kernel copy */
> +kputc#'-'
> +kputc#'0'
> +kputc#'x'
> +kphex\cend, 8/* End of kernel copy */
> +kputc#'\n'
> +kputc#'\r'
> +#endif
> +.endm
> +
>  .section ".start", #alloc, #execinstr
>  /*
>   * sort out different calling conventions
> @@ -450,6 +479,20 @@ dtb_check_done:
>  addr6, r9, r5
>  addr9, r9, r10
>
> +#ifdef DEBUG
> +sub     r10, r6, r5
> +sub     r10, r9, r10
> +/*
> + * We are about to copy the kernel to a new memory area.
> + * The boundaries of the new memory area can be found in
> + * r10 and r9, whilst r5 and r6 contain the boundaries
> + * of the memory we are going to copy.
> + * Calling dbgkc will help with the printing of this
> + * information.
> + */
> +dbgkcr5, r6, r10, r9
> +#endif
> +
>  1:ldmdbr6!, {r0 - r3, r10 - r12, lr}
>  cmpr6, r5
>  stmdbr9!, {r0 - r3, r10 - r12, lr}
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.

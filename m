Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB659C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6286A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="T5P4w/jc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6286A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbeKTI4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:56:00 -0500
Received: from mail-eopbgr780101.outbound.protection.outlook.com ([40.107.78.101]:27549
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726431AbeKTI4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlTyT/TFl+3qCGNe5RFm/kLRXFC/pYzRRNkISVyuMMk=;
 b=T5P4w/jc7a0liBZTQO1Rj8BnZ9tLBrOMHhsePGkKnrwC11bUTTASOAy7mWz9BLS2G+SXob2ew8+S4RDQOG9L9subjAtP58qacK1I1d5kWWE1nwdQwhs+0pvG3eVU5pXVsKJalkGsnrbgY2qssXaMB9cLAPcjjwiyo4V0eI2tlYc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1182.namprd22.prod.outlook.com (10.174.169.158) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.20; Mon, 19 Nov 2018 22:29:29 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Mon, 19 Nov 2018
 22:29:29 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Firoz Khan <firoz.khan@linaro.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH v2 3/5] mips: remove syscall table entries
Thread-Topic: [PATCH v2 3/5] mips: remove syscall table entries
Thread-Index: AQHUfKqPNeJmhHpqrECWQEltxz68yqVXtVAA
Date:   Mon, 19 Nov 2018 22:29:29 +0000
Message-ID: <20181119222924.ybnl7qe4hobud5fb@pburton-laptop>
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
 <1542262461-29024-4-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542262461-29024-4-git-send-email-firoz.khan@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0087.namprd15.prod.outlook.com
 (2603:10b6:101:20::31) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1182;6:ay2kYNz67gJ8ycpo0D+agONzSJqr7YUmce4uQjgOZI90KLc0mybK29qu2yHzjRS3SNNVJFfFPJKZw7kwbUyrs8o+UQcxykUMFbKTYvpMnI0IW/JC/qG2xRJpcmRuUJI2o7MsQLuPPopJ5yyMCQduWX/NgEL8vamProeVMyNeJKKaHzQdHkG2KMYHEhfP/EzWPidkEe1i99kKnl7BYZo2Wq1XkzJQnZ9gjDhMnnPi9Z1kKOhyZzvbniZpvluKhY0vxRs9mF+txsic9xKzR6igIU1ZVGAylDGVdgm8Cx00y4WJAB02/0QrM/oAA2612eUWkLK0pLQS62tPmwu4YhXSe3IIBF5n+kMSWbYpGFqtmTXCxdjhAK0V0eI5aK6WPkak+GDZZg5SGkU7fJRa48ce4BjgAe8pt1XkGFOlu9dhSXZk26KyBXZWvFsyKyjXUTW1cr8zXuVXdxngS9dxUpXd3g==;5:3UaVLW9DBOSvEoI0MBnlWN4mOy6Vu/0YAGpKUuFq+OmZV9eVDwHu+dGW1YOKIQKe98EhgpRrkim3e6nkmN31FQ+XcEBK+JpzFkPewHZ1zoslh2Fo3AJE1YK3RkIzPdw+OuNhAnXjSJTmymT9Tn+cTcsAHCRZ498aq2MlGmHdhls=;7:51PWvPQ4wEpgyfFvyexJw0Ut8Nxpzbg0GwCcxTRB5kekN0vxCqBEzMN78Ooh23BzYlenI/RBd7h8FvV9irFTxWNCcj7kPoiC9BPPMr7MN/7TM5bYubGjCJSfWFWqCmOcQ83JSnL9xN1I/4C2R+7RBQ==
x-ms-office365-filtering-correlation-id: d26dc59e-3ef1-40a2-bd02-08d64e6e780b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1182;
x-ms-traffictypediagnostic: MWHPR2201MB1182:
x-microsoft-antispam-prvs: <MWHPR2201MB1182C7F42E7C37E8280C9C62C1D80@MWHPR2201MB1182.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(10201501046)(3231440)(944501410)(52105112)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1182;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1182;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(396003)(39840400004)(346002)(136003)(366004)(189003)(199004)(14454004)(5660300001)(53936002)(508600001)(186003)(58126008)(305945005)(6512007)(9686003)(54906003)(33716001)(7416002)(1076002)(316002)(6436002)(6486002)(6116002)(3846002)(7736002)(2906002)(476003)(52116002)(6246003)(2900100001)(446003)(106356001)(11346002)(33896004)(486006)(39060400002)(66066001)(76176011)(71190400001)(71200400001)(99286004)(42882007)(68736007)(105586002)(256004)(14444005)(26005)(25786009)(81156014)(81166006)(102836004)(229853002)(8936002)(6916009)(97736004)(386003)(6506007)(44832011)(4326008)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1182;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cKl3t7o7AE3hD35HwQ+3U7nCWSnGQm9Bbup3tKndmN3BIYghwREwwj76mGA7kOZYaaHNAB26o1PTzS/Pf7h+kjFa8LeHot6i0lD9CGw10z4UtORX5OGW8VdFXVp4y3B19J58/O9K44td++psf3ODjsS69eApDNYvZ+yb6RmwgmGYbAcSoVV98ORxsq1elusk5qZ4JZx1Pvk1TNfUcoCM9pcDR6oeDQ/E6Jr8V1XTfCSt02NMdqnvQ8VjKzPLMV99TyfYJUPCSBU9LNnNXOE/AuDY1opbxszMnCZm1GYlY36P9L6BajXfRQVwv8eBARaBAnNZ1wB2cOuJ/sUcr/1LIumqR+7dLlfhHgct0939Gg8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <048540EEEDA7B04DAE7C3A95B96AB90D@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26dc59e-3ef1-40a2-bd02-08d64e6e780b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 22:29:29.1211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

On Thu, Nov 15, 2018 at 11:44:19AM +0530, Firoz Khan wrote:
> diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o3=
2.S
> index a9b895f..4eee437 100644
> --- a/arch/mips/kernel/scall32-o32.S
> +++ b/arch/mips/kernel/scall32-o32.S
> @@ -208,6 +208,18 @@ einval: li	v0, -ENOSYS
>  	jr	ra
>  	END(sys_syscall)
> =20
> +#ifdef CONFIG_MIPS_MT_FPAFF
> +	/*
> +	 * For FPU affinity scheduling on MIPS MT processors, we need to
> +	 * intercept sys_sched_xxxaffinity() calls until we get a proper hook
> +	 * in kernel/sched/core.c.  Considered only temporary we only support
> +	 * these hooks for the 32-bit kernel - there is no MIPS64 MT processor
> +	 * atm.
> +	 */
> +#define mipsmt_sys_sched_setaffinity sys_sched_setaffinity
> +#define mipsmt_sys_sched_getaffinity sys_sched_getaffinity

Is this backwards? ie. should it be:

    #define sys_sched_setaffinity mipsmt_sys_sched_setaffinity
    #define sys_sched_getaffinity mipsmt_sys_sched_getaffinity

?

I don't see how the mipsmt_* functions will ever be used after this
patch.

Thanks,
    Paul

> +#endif /* CONFIG_MIPS_MT_FPAFF */
> +
>  	.align	2
>  	.type	sys_call_table, @object
>  EXPORT(sys_call_table)
> @@ -450,20 +462,8 @@ EXPORT(sys_call_table)
>  	PTR	sys_tkill
>  	PTR	sys_sendfile64
>  	PTR	sys_futex
> -#ifdef CONFIG_MIPS_MT_FPAFF
> -	/*
> -	 * For FPU affinity scheduling on MIPS MT processors, we need to
> -	 * intercept sys_sched_xxxaffinity() calls until we get a proper hook
> -	 * in kernel/sched/core.c.  Considered only temporary we only support
> -	 * these hooks for the 32-bit kernel - there is no MIPS64 MT processor
> -	 * atm.
> -	 */
> -	PTR	mipsmt_sys_sched_setaffinity
> -	PTR	mipsmt_sys_sched_getaffinity
> -#else
>  	PTR	sys_sched_setaffinity
>  	PTR	sys_sched_getaffinity		/* 4240 */
> -#endif /* CONFIG_MIPS_MT_FPAFF */
>  	PTR	sys_io_setup
>  	PTR	sys_io_destroy
>  	PTR	sys_io_getevents
> --=20
> 1.9.1
>=20

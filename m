Return-Path: <gaku.inami.xh@renesas.com>
X-Google-Smtp-Source: AG47ELuL2zgruSYuwN0IVHEnHvgsWBsRF+YPEYh2GGeFdyxSwUSKWpdZUq9X9KY8TdXIJGw+UCFK
ARC-Seal: i=1; a=rsa-sha256; t=1521001665; cv=none;
        d=google.com; s=arc-20160816;
        b=dxuVJNi3qwwcJk5GIZShUR5D+UyHO6yKAmKCRVULMkru0zWy/ZqT2C8MVE9WKcCHuh
         SaOed3w8v5QP3Fu/PHDJ6dXPqgFIWT1NO0NEjRXWrLuB0mq9T/NmorMS7jOlobSeNl51
         tVNELS0c8P2EJZjfRfsuw3hRJ3PcXQ4GxlBt/4Dehp+JpSWS2yYPF03ZEHAAWlAHNCiJ
         ckmwj7vYqu1W1tfT7kdpep6zmFU5AJTW2o8EX70O+fTiuR3nzyzhUtruCTb6lWC0RJ82
         7wgZ1pY/X2Guz8++Zsw5KAkpumvVsVTaVY/PY3ecN81kbweGtmx0QAMf8a1yEPDSYpCB
         Zw4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=5cM7rQD4p/hklXgWxReUb5614s1Pz3Klb0bhVBgHEbY=;
        b=0k4z1OIKK5LGrZaFLC+Yx//OUpatbjGo7BzGNrqnv4hXpx77EIDieHE4u9ObAFa1mr
         TUrjoHBooImDyH4evQbNGXJrt8ZAuWkNyf4cozQplh0BUXToStvOLTmoJzZklKGoonv9
         3E0y31hR74T7JyLy/Q0MP+frrW9XskegSLcXUFGNDBOmGyiHtGdg/1n/QiDRpEXIGCdT
         uKP6RYYkIFfhnaAD5CdGHNGwaWI3TnL15DAROsFKApzhTg53eBxTBuKzIoc1YSC57xmD
         YuJ4jMJfnp/4F8MLgMhczv1MgFRGiMuDGjw4AUdPLdXkP8xZkEsBtWWo3xqW7B+DLSMy
         VdJg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@renesasgroup.onmicrosoft.com header.s=selector1-renesas-com header.b=RQtc3yYh;
       spf=pass (google.com: domain of gaku.inami.xh@renesas.com designates 210.160.252.173 as permitted sender) smtp.mailfrom=gaku.inami.xh@renesas.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@renesasgroup.onmicrosoft.com header.s=selector1-renesas-com header.b=RQtc3yYh;
       spf=pass (google.com: domain of gaku.inami.xh@renesas.com designates 210.160.252.173 as permitted sender) smtp.mailfrom=gaku.inami.xh@renesas.com
X-IronPort-AV: E=Sophos;i="5.47,468,1515423600";
   d="scan'208";a="273737470"
From: Gaku Inami <gaku.inami.xh@renesas.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "juri.lelli@redhat.com"
	<juri.lelli@redhat.com>, "psodagud@codeaurora.org" <psodagud@codeaurora.org>
Subject: RE: [PATCH v2] Revert "base: arch_topology: fix section mismatch
 build warnings"
Thread-Topic: [PATCH v2] Revert "base: arch_topology: fix section mismatch
 build warnings"
Thread-Index: AQHTpG8NqL2Inq57uU6hF64zCyHgaqPPTX/g
Date: Wed, 14 Mar 2018 04:27:42 +0000
Message-ID: <OSBPR01MB18007C618835874677A17374A2D10@OSBPR01MB1800.jpnprd01.prod.outlook.com>
References: <1518487600-5740-1-git-send-email-gaku.inami.xh@renesas.com>
In-Reply-To: <1518487600-5740-1-git-send-email-gaku.inami.xh@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gaku.inami.xh@renesas.com;
x-originating-ip: [211.11.155.139]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1784;7:zbu4T2apSj65oMC+z+WiUOtLhg6YiteDLXgPIUKZVYXi0dc3UiJX8/gY/djqG0zslS7qiCG6Ve42/z3iXZuiCwigh29oiGvY5PHlOqVTJymtAksdSjF9PRiY+Y05Rh1D9hl2UCH2f9Rg1eFrr5CGJaVHZt0rn8HFlMVjM0NgaPbmoBCa/R4M120Qqy4iymgeLPiFtePcUtpJphVuc/DlXdEOuIR7lN4tIq8fN4/pbCwMJnTvPU4pjP7VWFlbMKBZ;20:z4oYG/oXzrLs/SrNcGImoV6gRzFceXSphN5DEHbZiDp6vsMyjGyEROrcOsVi5enDwwaPp8cDjMRcSc/NiAWtnx6Oecb7enG5wMZ1MNhM4p6RInGd53rrBsRaijK/PpG9R9ZTBUaK7Xen1Q6Xbo179xNL7V7CIvTldXXuDHKXNF0=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b8f6b4e-e180-4bd6-1496-08d58963eda0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1784;
x-ms-traffictypediagnostic: OSBPR01MB1784:
x-microsoft-antispam-prvs: <OSBPR01MB1784B815F0DF86487A883215A2D10@OSBPR01MB1784.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:OSBPR01MB1784;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1784;
x-forefront-prvs: 0611A21987
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(39380400002)(199004)(189003)(13464003)(5250100002)(110136005)(2501003)(5660300001)(68736007)(54906003)(186003)(4326008)(3280700002)(86362001)(26005)(53546011)(478600001)(575784001)(97736004)(102836004)(2906002)(14454004)(106356001)(6436002)(6506007)(25786009)(305945005)(8936002)(76176011)(81166006)(55016002)(316002)(33656002)(59450400001)(74316002)(99286004)(6246003)(9686003)(66066001)(7696005)(105586002)(53936002)(3846002)(2950100002)(7736002)(3660700001)(6116002)(2900100001)(229853002)(8676002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1784;H:OSBPR01MB1800.jpnprd01.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 0Z3mcxhlo3z8D0msdk+JXzxHWJ0G8Qbc8iqxF3X7FJ2x8ft+2y2pEH3qnFl1d5RPUsN/jIyXewLKWWG0x8z9O2NQOW0aAKn9gBncrNA1TwgUczTbg081mudb6ZkxZfd5k81ett9D1x+wiMLy+nWFfPBsF1R5dbrrArIeujpcTeX4n2Wo6wmpjTQKcWxN/OdGC1GZf37stmGtMuG87NQJzZkoHXPJCYJXnbL4wmTE93gmk+T3zFQV7REo8h/IEi/sewXnsVDqDrBdX+aJ5RVBZqERBO4Atys15NumdWlyTRW7Ku2jXNSYpVUT14jysQHLcJlNDTefYHkWthFtM8Ck+w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8f6b4e-e180-4bd6-1496-08d58963eda0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2018 04:27:42.1908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1784
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591730231008876964?=
X-GMAIL-MSGID: =?utf-8?q?1594885842145557788?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Greg, would you review this? I confirmed it can be applied rebased on 4.16-=
rc5.

Regards
Inami

> -----Original Message-----
> From: Gaku Inami
> Sent: Tuesday, February 13, 2018 11:07 AM
> To: gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org
> Cc: dietmar.eggemann@arm.com; sudeep.holla@arm.com; juri.lelli@redhat.com=
; psodagud@codeaurora.org; Gaku Inami
> <gaku.inami.xh@renesas.com>
> Subject: [PATCH v2] Revert "base: arch_topology: fix section mismatch bui=
ld warnings"
>=20
> This reverts commit 452562abb5b7 ("base: arch_topology: fix section
> mismatch build warnings"). It causes the notifier call hangs in some
> use-cases.
>=20
> In some cases with using maxcpus, some of cpus are booted first and
> then the remaining cpus are booted. As an example, some users who want
> to realize fast boot up often use the following procedure.
>=20
>   1) Define all CPUs on device tree (CA57x4 + CA53x4)
>   2) Add "maxcpus=3D4" in bootargs
>   3) Kernel boot up with CA57x4
>   4) After kernel boot up, CA53x4 is booted from user
>=20
> When kernel init was finished, CPUFREQ_POLICY_NOTIFIER was not still
> unregisterd. This means that "__init init_cpu_capacity_callback()"
> will be called after kernel init sequence. To avoid this problem,
> it needs to remove __init{,data} annotations by reverting this commit.
>=20
> Also, this commit was needed to fix kernel compile issue below.
> However, this issue was also fixed by another patch: commit 82d8ba717ccb
> ("arch_topology: Fix section miss match warning due to
> free_raw_capacity()") in v4.15 as well.
> Whereas commit 452562abb5b7 added all the missing __init annotations,
> commit 82d8ba717ccb removed it from free_raw_capacity().
>=20
> WARNING: vmlinux.o(.text+0x548f24): Section mismatch in reference
> from the function init_cpu_capacity_callback() to the variable
> .init.text:$x
> The function init_cpu_capacity_callback() references
> the variable __init $x.
> This is often because init_cpu_capacity_callback lacks a __init
> annotation or the annotation of $x is wrong.
>=20
> Fixes: 82d8ba717ccb ("arch_topology: Fix section miss match warning due
> to free_raw_capacity()")
> Signed-off-by: Gaku Inami <gaku.inami.xh@renesas.com>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>=20
> Changes from v1:
>  - rebase on v4.16-rc1
>  - add short tags for fixes.
>  - add tested-by, review-by and acked-by tags.
>=20
>  drivers/base/arch_topology.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 52ec517..e7cb0c6 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -169,11 +169,11 @@ bool __init topology_parse_cpu_capacity(struct devi=
ce_node *cpu_node, int cpu)
>  }
>=20
>  #ifdef CONFIG_CPU_FREQ
> -static cpumask_var_t cpus_to_visit __initdata;
> -static void __init parsing_done_workfn(struct work_struct *work);
> -static __initdata DECLARE_WORK(parsing_done_work, parsing_done_workfn);
> +static cpumask_var_t cpus_to_visit;
> +static void parsing_done_workfn(struct work_struct *work);
> +static DECLARE_WORK(parsing_done_work, parsing_done_workfn);
>=20
> -static int __init
> +static int
>  init_cpu_capacity_callback(struct notifier_block *nb,
>  			   unsigned long val,
>  			   void *data)
> @@ -209,7 +209,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
>  	return 0;
>  }
>=20
> -static struct notifier_block init_cpu_capacity_notifier __initdata =3D {
> +static struct notifier_block init_cpu_capacity_notifier =3D {
>  	.notifier_call =3D init_cpu_capacity_callback,
>  };
>=20
> @@ -242,7 +242,7 @@ static int __init register_cpufreq_notifier(void)
>  }
>  core_initcall(register_cpufreq_notifier);
>=20
> -static void __init parsing_done_workfn(struct work_struct *work)
> +static void parsing_done_workfn(struct work_struct *work)
>  {
>  	cpufreq_unregister_notifier(&init_cpu_capacity_notifier,
>  					 CPUFREQ_POLICY_NOTIFIER);
> --
> 2.7.4

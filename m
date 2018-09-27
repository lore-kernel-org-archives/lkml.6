Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC47DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D23921708
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Wuf0SiJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D23921708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbeI1BQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:16:15 -0400
Received: from mail-cys01nam02on0090.outbound.protection.outlook.com ([104.47.37.90]:34154
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727320AbeI1BQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwIVDSXc5rPcGnJWCfwUxitJGJo7nCzXH23+dhDdPqI=;
 b=Wuf0SiJ2K5yPsxoi3JhxV/aKagX24hJz/cVuWXhw4LFJSQ+EBUMy9t+aYDH1fQEmGqkRUeHcn0KK7q6Xb1UA0P2EDlPDYJiRZ7znSD9pIt3gmisjn0XYVqiJBaZktmIQeFlNZvW0s2Y9QiQ9nOrdJhWYQDkmp//jbAMKKqZuyi0=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1375.namprd22.prod.outlook.com (10.174.160.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Thu, 27 Sep 2018 18:56:29 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::1886:62b2:fbe4:9627]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::1886:62b2:fbe4:9627%9]) with mapi id 15.20.1164.024; Thu, 27 Sep 2018
 18:56:29 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Maksym Kokhan <maksym.kokhan@globallogic.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] mips: convert to generic builtin command line
Thread-Topic: [PATCH 7/8] mips: convert to generic builtin command line
Thread-Index: AQHUVoMf+XdDhAaEwESEN/TIkkcHlKUEeo4A
Date:   Thu, 27 Sep 2018 18:56:29 +0000
Message-ID: <20180927185626.gcvx5qjemxbff3zt@pburton-laptop>
References: <1538067417-6007-1-git-send-email-maksym.kokhan@globallogic.com>
In-Reply-To: <1538067417-6007-1-git-send-email-maksym.kokhan@globallogic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:404:109::15) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1375;6:2Uw269i1mLYYw3W11MeowmBs4RyMW+sqM7/bpaP+XSj57bcCXB2GtwzWEYv3eoe7xUDUxm+0iLJkoul4N7KOtQrsIgJ60hBT5ItbLepWiNQ7zMEKdVqcBFQORlCF/A1+FIn26QTFt0RU419p0xNSnC3RovVm7YHI4bUTca6qIgWvyMIvJAAEut/oGS5Ngy544ufQ4IHkVtiBZk0PA/y1qp71w5AuigI+RnZNsy2qbbRnf1V9do0iGF44VY3rVfU5Snb0T49AozkXpU1aNYgm0xvuEN8ye4zxEB670uv4+BS9FvQ6qyV538DMXoxJISbQKacV8qopwRapKD9CKMXmX97gSjtSdcxvkemscNwV3dCSmokh4ONTReR4cSQeqkJnWAUbkHAp+jWWWGXiMCGeBblIagmkBKdUQMYu712L1k9XNuAoqJoE6I2rsBm6oKzbJDziFHxMtcms+uJifeKBqA==;5:CtIkYX7F46WybmJNiO/3rmy6JIao7O8/tWfLVbV59KjPmQ37GNQ/DczZcfVDxiDzhJU0h1CutTL5uEf/c2q3U4+IufGEcEU22dlqnoCMQMdQFRkza1lRpC5hhtZYJMSG5E8glq5uXOOypCXPi8ghQWLs3kauEx4LgIAt4tDM6wk=;7:maavMCuCox/fP/VrdKBPnxshAAYF4CBB1jwuzagcdofkV81QwxTervsJvSHxu2Ofei4IYXtLlDqCUUmcSOgDQUhWvTgcdIoiGe5ZjfpIqbdR5NkF7MXVYgNCK4lvFjPE3CU5LEDLKCtbTdphxIS8psqSqave1b9K021h2rNnK0oLNthkNB2Ete1V3dhAeWai5WJEjDKpi/OBT7eptfxNDM/AAhMzxhhIt0g27pnLVpCLexTe2t72joTwB0l2tkFu
x-ms-office365-filtering-correlation-id: ca593865-cfe1-49d2-1cfa-08d624aaeeda
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989299)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1375;
x-ms-traffictypediagnostic: MWHPR2201MB1375:
x-microsoft-antispam-prvs: <MWHPR2201MB13752F58FA661195A6437734C1140@MWHPR2201MB1375.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051);SRVR:MWHPR2201MB1375;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1375;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39850400004)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(52314003)(6506007)(6512007)(476003)(386003)(44832011)(2900100001)(11346002)(446003)(66066001)(33716001)(97736004)(58126008)(34290500001)(9686003)(6246003)(6436002)(316002)(102836004)(486006)(52116002)(68736007)(4326008)(229853002)(14454004)(71200400001)(71190400001)(54906003)(6116002)(3846002)(1076002)(5660300001)(256004)(25786009)(8936002)(6486002)(8676002)(5250100002)(106356001)(81166006)(7736002)(6916009)(186003)(105586002)(2906002)(99286004)(53936002)(81156014)(305945005)(76176011)(42882007)(508600001)(33896004)(26005)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1375;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SsAdYPFOUTvkKZeLue3buUHf5i6ccXjnGs2NwaTB2y96Q8Uvn5tcs/jb2TB2U4AZkdXWg225P/E41jCn0sx+wf5kVUrkjLVIL+wtpzNflqqd/FkcelWZ1z62inOlkC2AeqKuRSpnv6zgxkMPhBu1w5xW9adkhfOxs12LJfVRRUYpN6FaT3t7NLLmen8a5LEoWR4LRjvS5kitWzjvNeNSNZfnuUeoFsOEdRXLDdA7lL30tyRnRqwL6lSD5YwEZ8SyIWasAniwIP4444pME3yZBXtBOvTGp50VrXKGw/jZPoEH3jLXYmMpij/Be+srl85Pb7EYl/OoEJhVXm8tDc62mwJF3qnx4LFnCcxOH/oazbc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <722920533DA03D4EB1C4EC7F1E25BB1E@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca593865-cfe1-49d2-1cfa-08d624aaeeda
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 18:56:29.7492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1375
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maksym,

On Thu, Sep 27, 2018 at 07:56:57PM +0300, Maksym Kokhan wrote:
> -choice
> -	prompt "Kernel command line type" if !CMDLINE_OVERRIDE
> -	default MIPS_CMDLINE_FROM_DTB if USE_OF && !ATH79 && !MACH_INGENIC && \
> -					 !MIPS_MALTA && \
> -					 !CAVIUM_OCTEON_SOC
> -	default MIPS_CMDLINE_FROM_BOOTLOADER
> -
> -	config MIPS_CMDLINE_FROM_DTB
> -		depends on USE_OF
> -		bool "Dtb kernel arguments if available"
> -
> -	config MIPS_CMDLINE_DTB_EXTEND
> -		depends on USE_OF
> -		bool "Extend dtb kernel arguments with bootloader arguments"
> -
> -	config MIPS_CMDLINE_FROM_BOOTLOADER
> -		bool "Bootloader kernel arguments if available"
> -
> -	config MIPS_CMDLINE_BUILTIN_EXTEND
> -		depends on CMDLINE_BOOL
> -		bool "Extend builtin kernel arguments with bootloader arguments"
> -endchoice
>%
> -#define USE_PROM_CMDLINE	IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER)
> -#define USE_DTB_CMDLINE		IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_DTB)
> -#define EXTEND_WITH_PROM	IS_ENABLED(CONFIG_MIPS_CMDLINE_DTB_EXTEND)
> -#define BUILTIN_EXTEND_WITH_PROM	\
> -	IS_ENABLED(CONFIG_MIPS_CMDLINE_BUILTIN_EXTEND)
> -
>  static void __init arch_mem_init(char **cmdline_p)
>  {
>  	struct memblock_region *reg;
>  	extern void plat_mem_setup(void);
> =20
> -#if defined(CONFIG_CMDLINE_BOOL) && defined(CONFIG_CMDLINE_OVERRIDE)
> -	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
> -#else
> -	if ((USE_PROM_CMDLINE && arcs_cmdline[0]) ||
> -	    (USE_DTB_CMDLINE && !boot_command_line[0]))
> -		strlcpy(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
> -
> -	if (EXTEND_WITH_PROM && arcs_cmdline[0]) {
> -		if (boot_command_line[0])
> -			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> -		strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
> -	}
> -
> -#if defined(CONFIG_CMDLINE_BOOL)
> -	if (builtin_cmdline[0]) {
> -		if (boot_command_line[0])
> -			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> -		strlcat(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
> -	}
> -
> -	if (BUILTIN_EXTEND_WITH_PROM && arcs_cmdline[0]) {
> -		if (boot_command_line[0])
> -			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> -		strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
> -	}
> -#endif
> -#endif
> -
>  	/* call board setup routine */
>  	plat_mem_setup();
> =20
> @@ -893,6 +856,8 @@ static void __init arch_mem_init(char **cmdline_p)
>  	pr_info("Determined physical RAM map:\n");
>  	print_memory_map();
> =20
> +	cmdline_add_builtin(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE)=
;
> +
>  	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
> =20
>  	*cmdline_p =3D command_line;

I love the idea of simplifying this & sharing code with other
architectures, but unfortunately I believe the above will be problematic
for systems using arguments from device tree.

At the point you call cmdline_add_builtin we should expect that:

  - boot_command_line contains arguments from the DT, if any, and
    otherwise may contain CONFIG_CMDLINE copied there by
    early_init_dt_scan_chosen().

  - arcs_cmdline contains arguments from the bootloader, if any.

If I understand correctly you overwrite boot_command_line with the
concatenation of CONFIG_CMDLINE_PREPEND, arcs_cmdline &
CONFIG_CMDLINE_APPEND. This will clobber/lose the DT arguments.

I'd expect this to be reproducible under QEMU using its boston emulation
(ie. -M boston) and a kernel built for the generic platform that
includes boston support (eg. 64r6el_defconfig).

It also doesn't allow for the various Kconfig options which allow us to
ignore some of the sources of command line arguments, nor does it honor
the ordering that those existing options allow. In practice perhaps we
can cut down on some of this configurability anyway, but if we do that
it needs to be thought through & the commit message should describe the
changes in behaviour.

Thanks,
    Paul

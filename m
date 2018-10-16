Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014A1C070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A400721476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Bb96mqBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A400721476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeJPSFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:05:10 -0400
Received: from mail-eopbgr40067.outbound.protection.outlook.com ([40.107.4.67]:10823
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726083AbeJPSFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26o/lbRoULiA2s28Wu5b4LVcBQrkxYMrt9bjxbSM95E=;
 b=Bb96mqBlgTAE6tOSa2YIhyP4V8I7UYucLVN8gKvL/D/xQONFXfeaNJ/YBricKLkSBGzTAUselu0jwlzMkDiHZfS9uo+rUJQ6uaQWZufbCemUwmOlIkMdD1psQaW74ThKqEWJhNC1PGDxxaiUS5dFcvoIaH4RVWhaGPFqU98LH2c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mark.Rutland@arm.com; 
Received: from lakrids.cambridge.arm.com (217.140.106.55) by
 AM6PR08MB2983.eurprd08.prod.outlook.com (2603:10a6:209:44::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.31; Tue, 16 Oct 2018 10:15:06 +0000
Date:   Tue, 16 Oct 2018 11:15:04 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH 1/2] arm64: dts: meson: fix reserve memory regions
Message-ID: <20181016101503.ktumdffk4nlxb34t@lakrids.cambridge.arm.com>
References: <20181015162833.7544-1-jbrunet@baylibre.com>
 <20181015162833.7544-2-jbrunet@baylibre.com>
 <20181015164214.hpqz7zear2c44ijd@lakrids.cambridge.arm.com>
 <06a189c5-d5b0-d5cd-d3b2-e2ed21721aeb@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06a189c5-d5b0-d5cd-d3b2-e2ed21721aeb@baylibre.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Originating-IP: [217.140.106.55]
X-ClientProxiedBy: LO2P265CA0067.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::31) To AM6PR08MB2983.eurprd08.prod.outlook.com
 (2603:10a6:209:44::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bce6ba7-79bc-4435-e383-08d633503eee
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB2983;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB2983;3:dnAmeJqrVcsM5C2ULvJsrAsXyLWUee0iKwg8M6xAHtm7sib/EOPjLufi2Ajs7rBCsfXrcib/VA5LcqqpGkxjgbiYbTOwPnQp9gor5kVM96Li7E7zyQcF3SjaZN8nprOdbUoppFLkeGxWVIXHU25dc/ewip/GtwFtfJvfvH5FGA37s0SLhoScZKFkmBTkY6PVNAsYUCYHxDZ91SV3KRMJYGz9jGwmxXv09oE8NOy06LjDXhvIOdod1auiiL/RIahL;25:S9g1HorVLCGowlT3ks5XIbCCntf2bxsvzhG+Vw0ojKf+Gme1BkOyW9cwsIhwUoQWDes/3GbWI8U/jGPhj+dIm515ngkPA0sbyfUJfUNzrBQoV43wmyK4dJtke2+AuR6xIwpqaig6+Ww2/pt0vCZtCTyDO48lNGxSNAVEPJdkn7uGnq4I54vcb31Zq3H6DgyYFUTQG3SNsXSxt09Kdzme87b0CTw0C+GE2QGSnZZHarv+XmZFYCRSka5PbGsIkfrDupLKCveoJw04RwKs44SCQHNkL0JDpZXcnnp70Ti5tlGvQibNtoZ9MiyG/j6iSJWzS6R0kXn8u/+vFfzGXWV5Ww==;31:HbxyRYzJX+P/qXOiDEAkEVV6/Cvs6vet2z/fcoAzTGxNR0Gz3qTe9syLfRD60u9pZSmj5q35INCqL0ceM39tzNqQoVVEQv5CVxvcho8ZVeQcsJaeQuQWNOZ/p78tfMDy8IcPhvdIW3W7UX3nCt+NPKVjLM2aNAiNbsoTrC8xBxZE4Bl1pmk5sUJyYKQYZa9RYa+0Q9bIA+XqKdTabXraojiVTeXAO6pkPU+E3KLTg00=
X-MS-TrafficTypeDiagnostic: AM6PR08MB2983:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB2983;20:BcoRQoUyQyLILffk3mpKkcShioQUB+cSeYtSwtDu6fRpE1oPnzZoJqHSts7vwkpbUixBC4JC+PlGhYzN4HCZFiOJ3gTZnYR9nSFsKIlEClYq3wLgiVbeNgJTVi735klhsh0sVV/HcLwtMGosPvzbIAaGy3Fc9W0+3H8PIXpTuJiHJ2OL3WpG2HgimR+XBWQ96D1+YtIJFElIAyt1L5v9f5x3GM6uDRm80JV3cv9zuTvneIqV/KLh2MnH3PbDnQ39zpXl2VFD7XxRKPIDDWSMo0jYjjRlo0RWoimYqeW47+UxJz8XfD80/JuUqvmR+Vr8O2v2KMw3IiYn/eYQXOhBSuJWX+xw7OYH5lj1lOv/SmLIEUwk6dFRJMUhD91zFNSXV2ckyVflMqx7UFrK3B3BLTgdLowU9aIO94gwg34FHvY=;4:VrDmXa2oMleg0xGN2PjsP0RhM7wk6aepL60l7zaNMJtRLxak9CeYHepu+P5f1gY2/xWhnvhwC0lhE5ojYkfLSalMXjTLaOXgFcdCRIMlo7SNZ8YVJL1V9NnzvcoTT2iFI6R8rKYgZXrNGMcQPe82bmzZDnyfI0tvqbmG9XkGQVyIiPDOYUq3hwfmFMIiLl+b7yoVbud0KA9Rlj/iisLuSZcTb3ExCWeyK+wiHqV+por+Z137WlryXcfJCwGw3FqWPU+pAIGUxWJcRdTn5/jSdw==
X-Microsoft-Antispam-PRVS: <AM6PR08MB2983C1EA18E65001CFA9B6B084FE0@AM6PR08MB2983.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:AM6PR08MB2983;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB2983;
X-Forefront-PRVS: 0827D7ACB9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(39860400002)(136003)(346002)(189003)(199004)(53936002)(5660300001)(93886005)(6246003)(76176011)(52116002)(486006)(7696005)(26005)(186003)(47776003)(14444005)(476003)(45080400002)(7736002)(66066001)(446003)(305945005)(11346002)(25786009)(16526019)(72206003)(478600001)(4326008)(316002)(16586007)(54906003)(58126008)(229853002)(2906002)(105586002)(956004)(386003)(106356001)(53546011)(86362001)(97736004)(6116002)(68736007)(8936002)(81156014)(81166006)(1076002)(44832011)(23726003)(3846002)(6916009)(50466002)(8676002)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB2983;H:lakrids.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB2983;23:aoUNnTy3qTu+7f6qxEH7/beP1aEc4mqg+iRrQXv0z?=
 =?us-ascii?Q?07BOoeKdMJ8z6zLIrUVgboTaJzlfaIZ7CchU+qVbhtEZheC4MTcfrowE+60B?=
 =?us-ascii?Q?bgjzpR2KZyEoQRaOwpevuggtYtwcNFKD7eHHq8MjnGnYvsR+jO+2Y8rlhJVE?=
 =?us-ascii?Q?pUFFNZruTciE6T9A79U4TI4OV6iclAm4gCqDiPMGJOBCN6G1AYfHd0gIAda+?=
 =?us-ascii?Q?4eRBEjLfotMzjvfWVsEptCNNms6UF8CX56XReL0MKD8FVZpSEJ1RM7cJa1c3?=
 =?us-ascii?Q?lRLjP+bAyzHAnO33y+Vh3iWSvucu5iXydTMf8WxN1L6GAxRJUtI/l6dpPgB6?=
 =?us-ascii?Q?BUKEk+O7yHrUu798S6Iz6W/+6FWsK1+ytfcxvOIZujZS45G3eYh3OqKLvbp2?=
 =?us-ascii?Q?QRhtv1zyBZoHQ6dHoK/JYYw1IV41vHxj/ZB0j4PAnvT3+9qehjoacCjj7HGB?=
 =?us-ascii?Q?LDjHA3wso05nEXGsIU5S4bn7MDiuDUDGnlSIa5TW5VZMPY+emakn+fK/2gY/?=
 =?us-ascii?Q?zqUs7+mlf02QVmHjD94nzBKaL0S+lv6cij/NiPbxY82x9EMlZvwQAB9LGQm+?=
 =?us-ascii?Q?lYJHBOntHuPOhfXxaPIsNVLG+X1Opvm96RuQi49u9XIXMw8+cZk8V4W19SSy?=
 =?us-ascii?Q?mYgTNNaG1gXarLyOc1mxNiAUiIKaz7wnSGQNB//r8ETfsSrlny37S45P8nCZ?=
 =?us-ascii?Q?JUb1+rwhmIw/CpLzwACC6T8F410zb7Vy5MHxoKKmW7xljnGmSdi8nTm3yuLU?=
 =?us-ascii?Q?9d8Oica4uXKOtji4oVUOffnnFBwBlRbfW90khHmqDtzJc8E6wMgeXWY1qsNP?=
 =?us-ascii?Q?tu/V9z74Jx/Z9UVUMVx0u7IhnXmJJrqmiT+mYJPv2Udioaebx3VTcyKqVwWD?=
 =?us-ascii?Q?Ozo7DlwWB1HN5tVMz7TWOBZR4uSqZlXivHxmuBrFBZHk78yIC8DrB5DP1lpL?=
 =?us-ascii?Q?z0CSwQY+LMfxRmrZ4yyYLbmJLZeMivskuq8/6tyr7EnqgaGW6y6Dvsm72Kfn?=
 =?us-ascii?Q?l0ETky7ysf1qMKuHKuYOJCZbss1alHosTKkAbbN6O8GNOc5aFO4Mec9XtjrX?=
 =?us-ascii?Q?IP+9SexDKluaQL/jZorCaeDAWryIgEY7tS215ZLXUZh3q06O/v2pOkG0Ene0?=
 =?us-ascii?Q?29gytMPeIKn4t0J/mAM9Vyq6TjDC7qXh4wCS5nvAwycOHDcgcOq//qPlaT2G?=
 =?us-ascii?Q?0C46Ya12q3DUp6GjfxaFbCDKIHUvFvIl64TlO+tfSZtUAN274cug337V+SAP?=
 =?us-ascii?Q?2Zq7h022d+sMqm56AHtdZapwRxXBwm5bTaspEPQmsBlExHNJpxM72iXnlfN3?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: 7BwflGLswh9YgBvd5yLhyQyjqNqIsKHjb8YKKJMBzqpTvks6uX9qHPAoiTdhUsMACiJTSUGv/S22ioLYPeWPfhbEGx+BRN8VWd+5r8mLYs8LDO7jw9eSm/5ctgSGmYAqwldu9T5vO+n7vysVuekabKeXEqIBDxWgk/qytaumbLOq0Wd1c/o1/Lb4gg/lIkBa8hJCdeOPMV1Fdk34cUqdvaOl1PbDZOollatdaN8OAExWUCU43YnfZRQ8i3ngqm3g8iRB9dFg8vH79dbW0FNPAm5NoyiD6iIXL4rXDq4PXF2bCdVW3id9SSEzDpVaiXJLWjOAstk8e8tvwMVg46Frig7XzR2SHRhvoUrKEBdToBc=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB2983;6:vuIsuy3AwuO2izvTZjwHUNPPV0yhcrhBsSnUZvbIUT1BUEgubohfFbjqLT3X0RUdn8SsStmxBb4qaOwJbKIJ+tlujPXBXEs9gIycfL8busrE3odKENPxpwEXYZBAszpqr5MlAdp2zVo7MBtNM/j4sTn832eXrM+FLxxiHsh5DaZSsSbNgYVlFmuMZ//GA0x0NMOSRI7oEfa8myzWvgGVSOVOFlrIfP3K/M+waBUb4/aoZlaQcwDHy4nK3+NI0eIEU0bKO34MlbptaiqCLOescTeofV72+cYbHU9fsOaEyRNslaoyQxnRNyoL2xTPrkC83BmEiqGZf/PZg8T25fY4hVYO5WU1ynRqyZfHiTeAIdxGdxtRkDMxJcjh8O2nmLrejve7UE1ePsieGtecnBkuiGqRECB8G52W6XXexpOtpCA+SF82n5yffkjpEBUl+CXhYEi+xQYd/SbgrRplTUe7Yg==;5:sKfybPHPpnIy/yaihkJyfR6vW62+h/ppt8C5Z0iFtrsar25ZPuTHAAmV+7So7r2d2LHUR7PGwvtiLRwUvVT066N7mkWwafFfc5ViXmJRWbBJMEkS987SguZtf0btl/jYWSsO3vL+3j2wl0st2Pywn+/35IYWY1iD/GKoMQktyKk=;7:QBeEcXSaz7q7bqAvk+v5Y4S9qm4rHVD/PiUc6+CX82vJs+fnVdrI0uBPDD/f6AaKI5xT3Sn+6aUkEn/jfZML8l2aiORfqVLhnOxmtrEONHSEzAhB68jRz/FjfXcOdt7k2T5AxvzY2emEZyskjJmrX3ZURSnrFSRjZh8y4pOsuvwulCZXsBRV+Ax2UH+eHZgY86YaAiO3S4NLwwqcnVhwpz6POOzOgvFkyPq30X7/ukUxRh981/MsI/lKEg3qLldr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2018 10:15:06.4497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bce6ba7-79bc-4435-e383-08d633503eee
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2983
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 10:23:50AM +0200, Neil Armstrong wrote:
> Hi Mark,
> 
> On 15/10/2018 18:42, Mark Rutland wrote:
> > On Mon, Oct 15, 2018 at 06:28:32PM +0200, Jerome Brunet wrote:
> >> Since commit 50d7ba36b916 ("arm64: export memblock_reserve()d regions via /proc/iomem")
> >> was merged Amlogic's boards using mainline u-boot started showing the
> >> following warning:
> >>
> >> WARNING: CPU: 0 PID: 1 at arch/arm64/kernel/setup.c:271 reserve_memblock_reserved_regions+0xd8/0x144
> >> Modules linked in:
> >> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc7-00263-g385684b3eb27-dirty #254
> >> pstate: 40000005 (nZcv daif -PAN -UAO)
> >> pc : reserve_memblock_reserved_regions+0xd8/0x144
> >> lr : reserve_memblock_reserved_regions+0xd0/0x144
> >> [...]
> >>
> >> This is due to u-boot setting some /reservedmem/ region while our
> >> dts declares reserved memory on the same region with no-map.
> >>
> >> The conflict produce the warning. This is fixed by using /reservedmem/
> >> in our dts as well, which is probably something we should have done from
> >> the beginning.
> > 
> > A /memreserve/ does not ensure no-map, and the kernel will map regions
> > which are described in a memory node and only protected with a
> > /memreserve/ entry.
> > 
> > Is it safe for the kernel to map these? e.g. speculative fetches won't
> > trigger a TrustZone controller to reboot the system?
> > 
> > ... or are they not in memory nodes to begin with?
> 
> Do you ask if these memory zones are protected by an Hardware
> Protection on the AXI bus

Yes.

> instead of simply protected by the ARM TZ MMU entries ?

The secure world MMU has no impact whatsoever on SW running in the
normal world.

Only the HW (like a TZC on the bus) can enforce restrictions.

> In the later case, a speculative fetch won't fail, is that right ?
> These zones are mapped on the DDR, and seems to be simply protected by the MMU
> from the ATF code, there are other HW protected RAM zones we haven't modeled.

If the bus does not protect these ranges, a speculative fetch from the
normal world will not fail.

However, this means that the normal world can trivially escalate
privilege to the secure world, and any bug in normal world software
could corrupt secure world SW. So I *hope* there is some protection in
place.

> BTW Can the Cortex-A53 do speculative fetches ? I thought no.

I believe COrtex-A53 can prefetch, so yes.

Thanks,
Mark.

Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58E8C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534D125CE9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="LkTCzI1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534D125CE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753642AbeGBVjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:39:35 -0400
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:17066
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753492AbeGBVjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYp/R3wYzBCPkT1Z07VtvM6LG7oOFWaZZeck2o6EC64=;
 b=LkTCzI1QsANw4L111nmnBl6UgzM01XWtanAh4J/+JPkEmizrDueGwXutx/iBhymT1a6SWtVbO1QLAQdY0S2/Pl19GQpeAesKZyuy7aYREglbJ+oW0P/EJFOPXuR7P66OPdZATnMFxDcoIyAkFy4MxhrLGlG1ZiE5QSvE4+ZyNfo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.22; Mon, 2 Jul 2018 21:39:31 +0000
Date:   Mon, 2 Jul 2018 14:39:28 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Remove no-op cast in show_regs()
Message-ID: <20180702213928.35olwcekyg7shwow@pburton-laptop>
References: <20180622180703.18324-1-paul.burton@mips.com>
 <20180702152029.GA437552@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702152029.GA437552@linux-mips.org>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR2001CA0003.namprd20.prod.outlook.com
 (2603:10b6:301:15::13) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9fa3cb3-a114-4463-443b-08d5e0644ba7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:CculrbY5EMkxKVUza6N+Pm/GY73N9Rqe5pXv/aKcS5v4S4MmhgjrRtv9XeY7bjqOhJhy1ZxkY41K9wILeuV2sytfWPX3MYrSjAMbwcssM0JyUYmNl8hXRaS6TKndItb67/2efabgSvkZ2Gtn1gjMErQ/RI+TDiQxn6pCt2F8v2tmelVluJw9OnFKUy1MUnaZ4ccItUi0Q8t58zzLSkuG+Rr1l0IXn3F9GufMftkIcFU1rCvITpxpgZFLLdlF1B9Z;25:g1J6PRXvo1t1lTXnjJCKbkJehU7XiiUYmY+ClRlWs3qbmpOYHO9hp7kJHy0/Vn3ZXYMkyb1oaiYSDu3VDz73kpo3O9pQ7YT/nguI4Gbg7kLpD6JQ8vRcRFn92sCYX+ynwfG//RCuM2EM/jBo23d6ddwrN+g1Mlw8PjFHFPcUPqoS3dXPPfPM4jjSVCeMyymgVN8tFmLW7U41/V/GTSWYHCaXddxFtvZPIIoee5T8rjEJJMbNKvP48gZ2EqpIWXFEBz8EkvmGtZZgim6Y8uvZDcfc+ZduvKLDejJXhV++4JN12btOuXjc/kCje79NxgbAbftqFq6ULTyZmUxWhOZWXw==;31:Lu3opbFQ/LOc9ZLiuPOYwE4m38JATTHpv3Z3lgjIROyNjL0b4oVxCdxtiX1mP+0zkx+oVphbYrUHgWhIDqECdGVmRs6q4lAko8c2O7Wu/M967gkNEe9SgCvP97gwldpYIHw7w9yB49gAeP/Azs74GN3FAadho875IXEyZXr4SrgVavEYlNq9zFdGvkoJG0E2S+gBmr3T72enGtaz5wBr2gqpDZoJcw8qozi1moVx76A=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:uqj73mw9lIcSw+hTRuaouGt4FJ/O5H0SUMPHWFYkT1znin5WNFUTJtcgyo5YxWfEFEwh1tmI+AyH/mpafCg2yCpnKZ10GS1LhCnC9m/iez+5KF1psjE8CpT1QDrOSPw7UeLWg0WQmjSZTT+9NkB4DtE9G2xj5Cm3FT/gM3Xfq3s8cBjYSYnogu75ZUnrTAUqvWggNvTFp4kp+gEn7OGpefjAREND7APitqgtruJ6hmNVy4K3XxF0Y/zX0LyK+Tga;4:/TbwoWmpLOfGhZQ0IgN6f2M6uUQWXP5DmqHcGjA88UiaAKq0ti6NjRVfgofSppEO+TUPARspJH8xLx1sq4hkFeK+u1H/TjIKM/ro38/8Hqhh2+nRzhZeRY2nba/w3uvP8Tj/hrKbN3WL0pZapi0rHRuYQm3iuM9mrJCHlssNfvQ8lSB03Zuv9+y5cvOFQlNhIdAm5RQUzQwRDsSwkhJuCI0I3TodBFRSw+uLaB9Q57iy9Hvncoce4/A1xvSxMMjx+KwJzjXXQBO7nXvVtm6BeQ==
X-Microsoft-Antispam-PRVS: <BYAPR08MB49341BE0D837C05F870AD11EC1430@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(3002001)(149027)(150027)(6041310)(20161123564045)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(376002)(136003)(39840400004)(396003)(366004)(189003)(199004)(305945005)(25786009)(9686003)(33896004)(6666003)(76176011)(6496006)(52116002)(4326008)(316002)(58126008)(54906003)(16586007)(2906002)(8936002)(8676002)(81156014)(81166006)(446003)(11346002)(956004)(476003)(486006)(7736002)(44832011)(105586002)(97736004)(66066001)(47776003)(1076002)(53936002)(42882007)(6486002)(33716001)(106356001)(6246003)(386003)(229853002)(23726003)(26005)(76506005)(50466002)(16526019)(186003)(6916009)(478600001)(5660300001)(3846002)(6116002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:+g1Ja2iUWRScWUb58t9g91LoG8mrv9PPCJixEw4zB?=
 =?us-ascii?Q?+N4zGZzzr9KhPOEDwPrkldErd2b6nQFkDwFeKdhnzWsjdK/aXb6P8D0BmEQC?=
 =?us-ascii?Q?5z5tAnUqQCIcX+KEaXqPxqJ3+0/P9vgFJQIOvVVxWyWC6yX5YIV2CLH1EG6i?=
 =?us-ascii?Q?DK19fWBFBrHKjShb8bm2GEA75IJQdtZkmJ3wY4IRBaWWqQJVv9meoqsyVJUm?=
 =?us-ascii?Q?CJ+enGGQBRAdrbKyPlIkIFExVZRSARCBHxoNmsngEay6VEQ+7t4PF6USz41q?=
 =?us-ascii?Q?0825QaIPh8E0isa9P6NBuC6BdG3bBG3MQKPYhVF0w/E4JY/Tq5/ehyxkMu0a?=
 =?us-ascii?Q?25extWhQHrWYNGhlH5bz50BAMwZYF2E3wA5QcS5RvjtrHCgTuFmDGlNpzygZ?=
 =?us-ascii?Q?mSlREgH6JyVPpERkvUh+DXWOghQRtD50PEP3sH6zigMzWRnVrebJjlAuGa0m?=
 =?us-ascii?Q?f9gutgAdqAWANdhYmPZjEgsRbhGMLqUkQkgcPNlWGWpCvbo4HMX72hKiG41b?=
 =?us-ascii?Q?9a+mI8pipB0jexcxxRhyUOFQhp9MQ6nPRkFuBq5rcDXyTLyqq+DdHKh3U6+Q?=
 =?us-ascii?Q?CjH+yM2Dy+S50fVEZt62X9ZZ3RYLke4uV4Qf2IxOoux32ssXkkrMByf4qhch?=
 =?us-ascii?Q?Zt5ZuhuR6IJTGqZQSb8X7iO1UEDMhm2v7TlO+K/y8CWgpfhtKH6kE5SFXpz1?=
 =?us-ascii?Q?WmRWGEciR8Yu/QXjWwW5mxr2DYgd4QIZ3pV9Mgo1gsU18oyT5vco+LYt7uAF?=
 =?us-ascii?Q?7YbvmJrr/X6UBNhzUXKZtqnU8491+kV1q8VXa+G/I9DKyvHq9y4CZo/1Bl+G?=
 =?us-ascii?Q?cFeZF6FuBS23U4VGRS9fpjLlLiGyTZOtonGiLVoxu7coCZ1sPRYgNgDOnB7k?=
 =?us-ascii?Q?/3fz+O0Brlwvm8iphcBaXios6s6p6VhgyOg9F3rCS/NCqHAHp1aII1zbnhid?=
 =?us-ascii?Q?eoujgXbfNkIASUkPTX3dbb8cxfwMwgLOKw9y8XDcXU/A8ZZA5eIdsATxA/8h?=
 =?us-ascii?Q?qvs13NhkfFdBPrUwKEPlKKU3XUv8NM/K3UcfTObJz9a/vJ9n8mt6YN6k2FJD?=
 =?us-ascii?Q?OqCu9zaPlWcAR4L8x7IoRBFuE7wJ2ttplLCifJj4an4XerxjWMMUR7YXjEyU?=
 =?us-ascii?Q?vtGOrIhd0B+9rEtxbO8IL+2mBe5hVXWge+oKqK9+bFp1phr+zfwHhhN5wB8P?=
 =?us-ascii?Q?+Fl27N+vyDONAyLIYCSIxCdgAzDAlNwuACBc8eosceWTxlTv31nu3rH8wQZE?=
 =?us-ascii?Q?cgOuh9vOPGdNUfjg24hAsBxUHxLeoWIYgIOaadTnrgPpuQqGhdZZP968TZYP?=
 =?us-ascii?Q?r0QakuAGbEPwccXwyNEMAU=3D?=
X-Microsoft-Antispam-Message-Info: RpjIzWVUYeNnk5oR1qrYBDurJIj86bEJEKXeoaR1tRTEM7PfB7yXQASI9PrPrrd5B4KyD2eB9ANHmAW9NHha4sUeuxSmeOMaH/9ceEj2RFOHTjR85xZhOaSGadR/H1YcL6/jxa3IQDYlA/n2ygOpFdBLFGKW+k+HOeISLM8eFHlgJsqfN+3WTTYFPcCA5VPsTMkx4/EwEaP4mR1tJRcawQq6R/8up2R4NSs4jS43U10Y1s6C+zgm6abyoraIUXrek2EwPdtcI2vyH3GkrBclAqdECdBIcGoX5VMSojnAsJYvwa7lSIQ6j1ywylHjECuy8rDVOM+L+SEGlqmhbXZgoK5GGja92ceVKGSQbYt76do=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:ihhLof9QXpfmOASWKKtNilfKTpcYeo0JLr6OWOoi6728UUrR5uwFbiLDzmquCA0s9CM1tKmLZkLnfEUpK0rZWeGxK240whQWvW//sNmzyZaEv2tfCFC4BSQrQOnTD4q7sjK+6WlSr7DyPvp9wINmQ1C7BPJiDKbkr3KIAHwPrj3wHcFWOWahLBsW4ZKiZdwnVTJ0oCqMfsdLD9Z0U7su+z8MdfQLrU0VP240zoaBtOwqvibFVlg4f6EmeeviOwnwXGnCYUL8Et3F3xPeRto82pJEDxvv7iWvN3pYc/XFdFJowohcO9IbOSY8MO7iGA9CWJY/+T1+2xYGTXDtA/Es4qZGMCrhJaajfxso4+b7R9q8xS8CYD3AQiVm73mJEJc2NbD7CxwGV22T//ElFw1OS6FUnC1a6yGB+FgBIKy4g7yzORDXqew57qz1ISs5rVlrrJFfg0ngZikWNHm/atZuQQ==;5:fmdhwmFCeVm5+83LhcxrI5lSY8YH8hJOcv/O3fKDPsZlo8eSq/gPoyLD26iXu5ONHOJCAn7Saqnac9sZWJpUWo2pzlKwnGt23QjVujmVm/40LSwTLjqTxayrngXmlYL7194oiVw61KPVV6hL9bfgBomVOjUaTY94J5bcnFe+XDM=;24:8b5jgLF/97kQe+W20Eaqn9SK5bKRGnMT5g9K/8ZbZyj0Ilwv0hPYUkf9JK93Q3n+3gC2xKrzdEczJZZGeX2vLyUFPULDYP71ErHjwwob6c0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;7:SQZ5C29aZkE2I3rvQhuqtbv7SaDHpk4Zm2bFLSPyfdeSdOHt0+QW/bztFYh6r5yd91Qa7F+8MfJdKP+BrNE3+q9guapPAhLEowRGU4lmBEw/GLRyZP6kEDnKP8PWhrH49EpfYt2ZxneVWqFX/wCoPzRxcPrmoJeKMeGBLoluNSDvu95UDRgkILzR5YRs9SeG8ZXwxcvzW147BxS/S98KmQLco+yO15e53z8RjSB8RugISu8IW3NlZOH2SeQSpfds
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 21:39:31.1835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fa3cb3-a114-4463-443b-08d5e0644ba7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

On Mon, Jul 02, 2018 at 05:20:29PM +0200, Ralf Baechle wrote:
> On Fri, Jun 22, 2018 at 11:07:03AM -0700, Paul Burton wrote:
> 
> > In show_regs() we have a regs argument of type struct pt_regs *, and we
> > explicitly cast it to that same type as part of calling __show_regs().
> > 
> > Casting regs to the same type that it is declared as does nothing at
> > all, so remove the useless cast.
> 
> Good catch but there's no dump_stack() in v4.18-rc3 so this doesn't apply.

dump_stack() is there in mips-fixes as part of fixing up
arch_trigger_cpumask_backtrace(), so this would apply once the next
fixes pull happens.

But I'm all for cleaning up other instances too.

Thanks,
    Paul

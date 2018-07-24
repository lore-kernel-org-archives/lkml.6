Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD889C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7682720852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="fIgG1nMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7682720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388984AbeGXV4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:56:18 -0400
Received: from mail-cys01nam02on0116.outbound.protection.outlook.com ([104.47.37.116]:13532
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388765AbeGXV4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7yrurE1uXNOv0PZzTDlcUWnwfUGfQvbIiL/TfWn4Ec=;
 b=fIgG1nMnk0l5M4t78PaY8xzs6m1RTrqiSwdEWYA/igdcRQuoNoye2Posnlc12GcFvXvS3quyE341tJuDTAr9pZhyNzJ3uqE58n/DguTonS0K+m9UwqDog/M3gw/gf5533tYBauASybJT3CR5lASb6iDOlVn1jyOKFP6+cWIPC2U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4936.namprd08.prod.outlook.com (2603:10b6:a03:6a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 20:47:59 +0000
Date:   Tue, 24 Jul 2018 13:47:57 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/3] MIPS: jz4780: Allow access to jz4740-i2s
Message-ID: <20180724204757.qrgjttepzcfdzxlv@pburton-laptop>
References: <20180606193811.16007-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606193811.16007-1-malat@debian.org>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR06CA0066.namprd06.prod.outlook.com
 (2603:10b6:3:37::28) To BYAPR08MB4936.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb712f03-d428-407f-cf99-08d5f1a6be41
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4936;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4936;3:nDLOIceaEL4nLpphH6vOg+NWBfCPQnCe61YIG7rKgnufthuE5tmYJAK9mMzDsjsKPwTOqewMAXsBe/EqZnLf0rPITnKAzZieb4EHBRJBeLgd6E8zMOlnOxTOvBSoshTpJ9pJkfHAtuZNFp1GpBh6cT4rb78ziH5U1/LO2NgP5nfmH8w4OL4tCj5l6J/YVDtdcvzVzJHvw941OihtF100y/cBuA8y3tzFN3a3+hhFnKq6NiFrO7e5EzC6xIdwEiNW;25:oWzdilc09UNVNxz5p4twt2pkqhnxDdNnZkmR/eHNS8GWptNoOwDN4xN6O/nRJ0qAjdQVKJmue01hVQfmtWVFcdP9Y/wscUd5ybtk6Fr6I6F60tRkRY86rwqcuz13TJj2x+3yRfJl/nkEsJzILdVzKql6BptNrFUUE2IQhBEbmndkmPY/1S5VToTWqVZ8xydXgbfvSXFohDvu3+RqHWAndOdEIJzwxr29rNJFWcEZuLitucbRSCGudRw0rXLazPzfNiVQ8pPE9wnBphErPv4ymzSbQZiqZcWQhYWt0EzC0C8bL4qaRhpQfbvkZ4A37ru23U9PyHBNW2deIQfBtOe5tQ==;31:79HvHc4E589Nz02fv4ny6Zxun5eRkZllpxpr5UvT2z9UkVryfMd0hC3DkWnL7sJQA07Zw47aoUEhyxtCUWOgC+AS19mTHm1SL6TcbqLVbjLZW1RnSGAVleIL49k4QVja6kuUL6SofZ6gUFY2dFC2jyywCYWYdH+7WTwCai2uE6aqEkjt5N76bH2/AokUku/ylE/YKAVh3bNC48XFCKb890Vj0NNRJf3BPoRFfXn8VLY=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4936:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4936;20:paPD87YqmptjqJ8j4LfhDeVK1MJcVHB/fvT3y6R+sQjud4nlbQwWzrZSGREtPCeWuqBNuJekHAbv1sevG+nC4276mRqUyHGv3G+2fSgl2g7lcBTtCI13yOVzWjdM4GLsr07dwiwLSbPojLmJMuXPmIM/2ZBK1CHNCfDGwefcGMT+G+amroCaUrNqJL1lQ/NmAsoVSeTLfSEJdGmyN96uE1GlnxPixnmuMb083n/y3P5pnfduXVDpG0iILY6fUOWF;4:DdKsJB7x90VI/NVc1WSUKDd3GXmKWDteb8Ea87QFgbG1vy4VNllFkA/dD7eQRDRaD2JNPOQwBNv5cTV4TxThAiRV6MWLL8o/GdOpXDXotGttAlCjSo2e7G7n0vPjQsYRtWxeC9znZnlc5XPy8tM50DVhA1Bb09LBmYpHhNTTIeUfz+pDQVOW4On/3T1kxsqEUE67+K4gp14L+sWyZ5CQwifLGa73Bz32x6zws4gCkQ/DBPvRUz7VdO49x0oQ5wRt19Qo48B2FkuZN2GWv3kFcw==
X-Microsoft-Antispam-PRVS: <BYAPR08MB493639FD8D174457EDE20555C1550@BYAPR08MB4936.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4936;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4936;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(136003)(39830400003)(366004)(376002)(396003)(199004)(189003)(476003)(11346002)(66066001)(76176011)(7416002)(956004)(229853002)(52116002)(47776003)(5660300001)(6486002)(50466002)(386003)(9686003)(446003)(58126008)(316002)(33896004)(68736007)(16586007)(2906002)(81156014)(81166006)(42882007)(8936002)(8676002)(6496006)(54906003)(76506005)(6916009)(53936002)(305945005)(106356001)(7736002)(105586002)(186003)(478600001)(16526019)(1076002)(39060400002)(3846002)(3716004)(6116002)(23726003)(6246003)(25786009)(4326008)(33716001)(486006)(44832011)(97736004)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4936;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4936;23:l1cqLsax4ITweeyAD5+6e3wCDREP8WcH/I2heR5Am?=
 =?us-ascii?Q?HPZ8ouLBHJTVbRUZYZ/OU7vXtjXym1i3DgEExfrD3yVT69N83kzCbHPWadfj?=
 =?us-ascii?Q?g00llSlJxn3nKnbrds5gIonSW5nYosQ6lYynyXtdaKOPPBNvf/xe4iCRn+LD?=
 =?us-ascii?Q?TYAs4nMDX2Lmayx16EY8fDxmZkdbFIFVhg+hdwmNAhU532GtJCgNkuk6zLyQ?=
 =?us-ascii?Q?rdjff9x+NXtz0gs2p9z6QO5KVrGrMQDKCPFstz4WF1tJPC+x6Tvc6+Ui2IwM?=
 =?us-ascii?Q?JVpm1eXMybak1C6BNpqcyv1PKxiVRNit6uvXez5f92uoyrPP9kVRfZftZryJ?=
 =?us-ascii?Q?FSevpm3t2Vs6vGg7+90JPbmtmCnZS45v7qKWcb2mYxPvXemi9GaJqyAM8g2E?=
 =?us-ascii?Q?ZBSBSOyZR5Ho/nBI2oMcHJYCLEJxAn+7C4lAEsSILhwqQ299ZMynAMR3g72R?=
 =?us-ascii?Q?wxqB+hVTqXg2taoISDB+BzDnZ8OtLAX674xEU8AuHGf6J7/zio3HSP6OOI8p?=
 =?us-ascii?Q?W8OhkmPYNAi87kPihVtEzOQbNrwz4dY+799S5HDLbgSwI5x50KCRW1eB5KJ/?=
 =?us-ascii?Q?q17RaYAoRHvMpqi08LOWO1heT5VFi0RUB7CKMHZnggHuTVJk4WK/zxbRA/pD?=
 =?us-ascii?Q?MgH7tFLTAxAf5v23/FCgzHLL0TWEQk91VuB05P//Ksj2kckW3qdF+I9YQiKB?=
 =?us-ascii?Q?aK8UDIoORU5tljKqC3C3287NNYxNg1uIwMPCwB5+Msie2XVwNunfxwdqXcq0?=
 =?us-ascii?Q?m8CUyGoWckfxhdP+SROxtJTDkmh8X5i/ob1a4A5t722nuv9AZ/hdMOpMD4YC?=
 =?us-ascii?Q?huIuMl5fzVDSz8aEsXKbE1eKrti8LKH9C9rAB3YKJyWBQVgZ2aOa1OEiLBEX?=
 =?us-ascii?Q?hlOJVFOidl3Zdo9G+fbm1FDm27G8ygCc9iUlsZREHW5IDZjLNXreOUqt8VdJ?=
 =?us-ascii?Q?Yxz7shvbJR+dCiMDH6gSd/ZWs7ktSfF907OFwCVvbftTZetGW5ZME+NiTQDj?=
 =?us-ascii?Q?Kb71FEbJGQd+JN56DVmoIxkfgGpN38tfQaf8hCEOYwkmnc+j4KYnNUWf5Z6l?=
 =?us-ascii?Q?4P4j5WvFZWfbtLngL1ElSzcqRCRYTJUk2lV9T4WiexTUo6VtTqf1tNiXEW0H?=
 =?us-ascii?Q?6IKyW79m47KC19AayKs3MVY5IbLhFVsICwY83B+VyryDf7MzvP9b5gyuADyQ?=
 =?us-ascii?Q?osE4Hyq4QB9QZ5TGjk/1pNab1aO43pRe7B7qELMN3uLWsKqkhawQtrzpk8CP?=
 =?us-ascii?Q?8M2o0daPRksu1ujbSbNqeszEVzgDIg+FtkYba/zzrQLF4Dg7QYX7n8JbjStE?=
 =?us-ascii?Q?jykIBG24gNutq+b57fzINV2w/D3QzDkQ9nBJDfG54AKFzs88sdDQShPFJRiT?=
 =?us-ascii?Q?LQqmw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 8SmmFrjHvO+9TMClKM1pryEFRLLiPbsfozJaK2DZNzrj9sfJvHfLmwCO6sIauSvLqo05nAPizHAEnTjl/ObJCz288HMiTpPbyK+gCKofZHv3QUtIA/m5HX3DCeekegOueOOVXJZjQhVSvdGqGU4rgN4mgD5TinW/EswKcnKnxg0NWNd4qyRKZBEej4IxPG/9SOEBUfI0NV9oLTrkKyYaiIowR5jqfJHYoWmjaPeTUCQZOMZXwWIa6UxGvpxE5Fl5iE60w9qUaxNomJBEv6l/PsGlJmLs3ir98YJsTm1BeAO0TbWO5xrI4z06F2OngzkihV5mR2E5HJGkDyobj/8i2aY8mvn+yah8AXBP0fGWMmY=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4936;6:Hnxsd/9BorN5opIQA3M+RTq7rU0KPIIV2JuQqr2SYSH9+GmVXjA07yIQ8hwg2jvML14U5xOzlAO4I56lj/QFgLlOxZzCy9nlzdjVVfe8dJ4RJYYzm+EWMohtzEcg4xjfTw2fJHkQNQl3Jm0V/BliFdKiUGZyMOAC6j0az0Daov4i0R3tzRBXAQBc6XpW76HIR73Z0AL4Mr8rXp0RAKKRPPMw9Ch/0mwmXl0ZiWplDSB8MTFISaLPCxTFu1xlPsXgPCaG8CGsNqfrk2g7J2MkIlbur/+Cj/BSFi05Yq2BVQiXFgYwsfUzut2iNWqjeXDwplQxNiGKh5Ep3pe/tiVA0txo8aEpNSU03WVIKAYhVjBvCpsYGhx8Xc/1gx8q+1z6ba5HM9ijkU3KOCEYL0SAf8A+7BfJXj1YldM2IISv31Mcau7smLeCMQ1th2TWlqFwN8BbwJ/AfPqrmdmvoHFsdw==;5:VGg19OLzP1nj6I/znLebT2Q21G9PnsSlAmPoUQ80wF8p5imyye3I3Ceh+egrgWWFXVCORKeW+f7QL9mHHQsFFQhgE8gqLib6/QQn6FV0uu9wvQqOau6mdekux94tM38BxKd+aPuIY7ZL8FKUQpgrVsrmCV/kMf0ZYcjmczArF8s=;7:CfNNyQ5zUheACT4bRMPnFxzhQnvjAWWTLI+ik+jwbSsm3hAaQyzivw8IndcYcmzHXG4yv7zvv6HEnhamdtoEYPgP3g1HHxjkhrdqGNTgFB/FACGtFudbw7pvCyw863Yv0bHUXFgoVDROQoTFuUhYWpOgmOUE2PMb87Mz0sgmz1wIcXtZ6DxuFWWbQ0edKMZBiET3gwdUg0eLzh+nAysEmmTAWOxfnLBf1CtN1OnG2fQ878e5KkmYbCIo2zb8wch3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 20:47:59.9490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb712f03-d428-407f-cf99-08d5f1a6be41
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthieu,

On Wed, Jun 06, 2018 at 09:38:08PM +0200, Mathieu Malaterre wrote:
> diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
> index 1a354a6b6e87..35d82d96e781 100644
> --- a/sound/soc/jz4740/Kconfig
> +++ b/sound/soc/jz4740/Kconfig
> @@ -1,20 +1,20 @@
>  config SND_JZ4740_SOC
> -	tristate "SoC Audio for Ingenic JZ4740 SoC"
> -	depends on MACH_JZ4740 || COMPILE_TEST
> +	tristate "SoC Audio for Ingenic JZ4740/JZ4780 SoC"
> +	depends on MACH_JZ4740 || MACH_JZ4780 || COMPILE_TEST

Perhaps this could be MACH_INGENIC, or even just MIPS?

Thanks,
    Paul

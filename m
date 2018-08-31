Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA29C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E6720837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="MY2H22rT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E6720837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeIABIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:08:21 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:45335
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727252AbeIABIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t9FBDItD2a9gP3/WggVWJ18nwoBcgfLZnK7ooWPKZs=;
 b=MY2H22rTmzoj60mjXljA1qrDRHravMJi8M+5kzfCRYhPDkBGSaTw5RYfpHEMu9fgchp1A1D4T6zTI+f7VkfJKmHetaHnb92Qwnu2PeEzTw27ZVnFihG2WPIk8JcROtLWRW3I17/07lF7rpi77Do1U5eQxRTRQzp0ZUG9vS1dUZQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4935.namprd08.prod.outlook.com (2603:10b6:a03:6a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Fri, 31 Aug 2018 20:59:00 +0000
Date:   Fri, 31 Aug 2018 13:58:57 -0700
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
Message-ID: <20180831205857.nb3ij3rzhfs2fu42@pburton-laptop>
References: <20180606193811.16007-1-malat@debian.org>
 <20180724204757.qrgjttepzcfdzxlv@pburton-laptop>
 <20180831203752.37rsceiwotcmeses@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831203752.37rsceiwotcmeses@pburton-laptop>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR1201CA0015.namprd12.prod.outlook.com
 (2603:10b6:301:4a::25) To BYAPR08MB4935.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 461b88c9-b2d3-4679-f5c0-08d60f8493bb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4935;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;3:hVJ4/e8ehx+EhoWGKAtYAJrdzDwFpEHYTaVq8cxK+ZffE/p/esJNEMIaOxJZDp9Uh4+k3DvNgUy+RDKERd8UemPPYHcjevbqIs/NKrfr8BBd5Vo3+30RS6m0Xgx8eVED6Ex3lIVuvYH4/hLDFN8qe/xXFuDAkNpqzaKqx71bwYPRBcOxT84Wf5z/Lj0O6ytAXNJWqrirl6iis7DkgVdAsYa5YwFmRv7u0RSR8E0Ie7q1GQ5HJbg1L1vjtxj6GjCj;25:8KM/edtb7VDJdg1Z738S/D+voAMtMmAagtlS4CAhxsQ4qTGWA6zCcYBycCil2e8yyMykIwppTfSz0nSbtO7qwGW10VzH0FDfxavclSw7KyydUkU6mQPL+7amQAFuA0KCPkjotmxnbgXI5SoL3rvAsCyH1BIIzBTAlenKZxA96rb/OYtwzIxxnFqvXJT6ooUjmUsjbErRrCQwYHJM8NTWUro9QSWClNU0fXTkX1Q1Dt7VKlNHO5GifDEJl5+Ul5lBmTgyIm7+ef5lDuP8GqXCRsW1uoplny8+MlU5hz0q6D6WZkQfB2VwMsFf6af8ZZ7rc88NaEz+OJeE6bIwyiStbw==;31:gMzcogwRQWtg74iJspA7D1cqW5nRQJjb9JJ2+ja5SsobNpeFTrJ0v2xHq0CaGVP1OsPlUO0TmPWYdRGa5m6ysleQ0slaqlj8lnoNhmNu4gMFhc0+lMpS+fc3IgSBX3cPcpTL9Emb7l5sQsDGJx5e7Wv2b69LWuilAFeuqdCoGpo8IL/U1t7uVD5anghEmJlsLJV0kA0y6WFIIAlf7z/TOtAA7GqNm0YwtwbNFU6wpTo=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4935:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;20:YBNQw0d1syHVQTE9QWJAkAjdUdcrQ0INHNgyRB+F+JmIdt4d5P40x4nLhpGV6wOtFZZpfYXUH7X6d6UOpilGMR8QTTvBhWSO7NLhRPJHbU8PKzhR7yswxbjD+NqpskcUtSo09f27ubfPjbQofByd5fsA9fyvdq8kdrlP3Tg0l1wGZ0qGbp71qGxwmIcXnnuLAfXU5QvZo70k/MjlGMhEivJk/Zg4waDC84AZqBh+lOfalgnXwCKFyGQYtKM1qiD+;4:nPdl2NWwoVw0jA2npWWzstADQc0GsMMI64qh4OtnuW8ZgFy9ks+MJGVWckjPT6WXyZ3VBQNn0uyYibxksdG8zzleU+XLBncznsYGk/J97xeeOq65QOkt+UAm8MlBUDR8RKCy0ggg2Qy94jcKT3TNY5/sx/V/jI+dMRYh1kLxW3Orm4dM5AvNrAGA1R6CgbTJGesfbyFBwUvQ3MTgGw6t5Sn3IkStvRHPH4cl/OKHh59n3zzabx/WsEbgaK0lLAybIVJJy0r55WeSXyZhWL4XlA==
X-Microsoft-Antispam-PRVS: <BYAPR08MB4935636D8D9308DBA54AB541C10F0@BYAPR08MB4935.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR08MB4935;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4935;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(366004)(39840400004)(376002)(346002)(396003)(199004)(189003)(7736002)(478600001)(6666003)(50466002)(6916009)(446003)(33716001)(386003)(11346002)(26005)(5660300001)(476003)(486006)(956004)(81156014)(305945005)(4326008)(33896004)(76176011)(6496006)(52116002)(44832011)(53936002)(8676002)(25786009)(81166006)(6306002)(6246003)(39060400002)(9686003)(23726003)(6116002)(3846002)(1076002)(316002)(16586007)(76506005)(6486002)(54906003)(58126008)(7416002)(966005)(42882007)(186003)(47776003)(16526019)(105586002)(229853002)(97736004)(8936002)(68736007)(66066001)(106356001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4935;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4935;23:8kiJwTh7AiIoNSM4+Teie7kz4YhR61/Djbuum1ys4?=
 =?us-ascii?Q?A3vg9szE1Ob2jzzCu820QSmpync0f/n3V4e8UQdRxeVDc6pSeZQ4khXi/nOV?=
 =?us-ascii?Q?Tn0NBhsJKh4qnyTapXXbE1Ric7K/aip5dGO0+2GIBUWemNYSGEr07+L5LnMr?=
 =?us-ascii?Q?7mwcnmToGDi8K1Curc246wnfce/UUzEnSUwYltHQZY03TXiMNCVY5S3bxfn2?=
 =?us-ascii?Q?oSaBJZ3w/AUPEoj7r/u7mN0/1vum+GIH5EEoa/ZUeRGLieEOkPvU/cC4un2o?=
 =?us-ascii?Q?m1QTiDBC8iSQq6Lg2nws8UAlTkoJN2sG40XorAbWVlXzUwLu5gIbQlT6HU7p?=
 =?us-ascii?Q?u435RWy3xPneO/FrdYkgUwoagRs2ANYTyMm8PsLzs3HFpRMytkxjqze4aLpD?=
 =?us-ascii?Q?GN7eoI4B1ZFsVsjYeXq7z0huVVqagYIgX93geQDGCZdxlmcTv8yy9WCY0n5X?=
 =?us-ascii?Q?k/5yI+N6YWMEssesfMzqyJLCfKUGEHSusFUdKWo7XvpGDTh8lNt//s1a5pdx?=
 =?us-ascii?Q?VLeeGoG4pjL74Xk76a1wSCJ9joy9B+9pU4eyHta3CQhjSU3LCnVxGvJ2lcZo?=
 =?us-ascii?Q?cg2Y0RrQ5nWv9JsNoQUf3n5STveg/f0lyGybLeyrGl0R3WNs2dPc71/TiUhB?=
 =?us-ascii?Q?mT232Rm3ElTNFjwafHiAwVE5v5o2DcNAmVfKyJ8N8zbv1Quwy2kobvvTyJYm?=
 =?us-ascii?Q?fnaATHEafpUjlcKxxmba0zrIFVycDY7GwWrpp2rfZtZZ9wKkBb5/QKSNz8F9?=
 =?us-ascii?Q?PZI9721eqfFpMyo0qYrjsizLXZbb64go2RgjYMSe6YOU0wnSfR/sJ3/Kb01R?=
 =?us-ascii?Q?5To7oma2x6UlcLwp6T8cUTsh8sQd33kRV8mtZIWNLgbT0ey5QVmZ5JIWQdCW?=
 =?us-ascii?Q?wCme1eduyX2k5OZME3LYQEczdKfWk+QvtiWY4Ipy8CI0iUuaMPhWnxnYy6mz?=
 =?us-ascii?Q?Rt/rl5z/EA2vHJxWHqbqJ5cjdcjAJKAbK4ca+avHba3y7+KgKP/oa7BNrbzk?=
 =?us-ascii?Q?nFbrmcllFf4n3WOKR4ObUCd/WhxmeE9vb/SsYbOPcNxPslYDYph8SNEiogJl?=
 =?us-ascii?Q?VcsIGs2CYSvFz8JauNrNBPJLQvDe9MDbnnVGrTqEr2znJ1lx8PAQCCWt3uYr?=
 =?us-ascii?Q?4PW0FyfwMvid+xIM8n7X/cJdC4l9tae1dlcoNUvawtHSKTb/cwtHqdCSV7LE?=
 =?us-ascii?Q?kHEhmCyBdtRXjYEKTqwSSKcEhMny9eSdhSjte2YxZMx5n/hJFrsJ+n2Ljvsf?=
 =?us-ascii?Q?VvS8dSiSCLgENnqUjUQMvn9E9MkEtZH2mxW6+fkrUekFwnanpQLeutGAkf9P?=
 =?us-ascii?Q?ZwSHLkUi8fv1uOXSYmP2+wCW7hy5NAzzljgCuroYM2D03O2fhBG+TokKOp6T?=
 =?us-ascii?Q?v7wsXfFQJogFpY4tUoyjy9A+zh8Zo1Ru3QjYChu0YSjUV91?=
X-Microsoft-Antispam-Message-Info: PDwHxQnARsARzrxZb3RAFQmdYlQ9yJcEAhtU36ySXw9HDl0PnxOV67F0tKnvLDf+I2IOt0hnOOjeA3HI6rGlQ36UWXCt53wgt6pIp49BhKqzO5ICvmzAFTJ45z3T1yFBb3+/TIbtkq9ydDcbS0BIdBAisVOSeNNHhflZnVSbJPBF0pYOAsa+HUtUv6RtKFV+6UYZ1jOWMebTlEFfHcsm88rDBxjquQFspdtSGYzAnVcPx43RnuSKYdkDYCAQHfUWij4rMSPSOIoBLkOgL/s+lwKxkfZnWk3H35bM7uNSSwh1tqNjmq6Yha5MJzoYpoTwEqRR23O9YlWutyiuRnfRUy2bkB84RbDQh4IgHl1Y/Xs=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;6:94PxELN68l97CQj+8t0f1i6dpJh/okd7e60I8nQT1qSSAPItyMEzGLCvfzdwJVbqmS4RmDN3SFUr4n8kG26Z5RCgc9GxgRwqeaZmgLn/P6/AeiLx1B3Hwmwp5dJ9REo25gNeuzpqDO2q0H/OaDOP3r7FieUbJqVjLysFYiyouY06JBnhoQ8H5jHuADAfULdOTPfE0Nj51nB/Cp175+YyggeCaaRK3YWZPGJW0iJzIgNau8hNkf5KZkdQ8qw11TgBJYbe7aP+zQ5HdNxhp8xqTE6LGcUr2IRtMJCyGmaCwgxYvQg7wNfWreN3jvaU8VKIBMhosDfImXZGKIrkzUJTCHtr4pjXCo3HOvwW+OFwIrJbpbgdXgoxddSbPSCVreDadGQaK5/Esh60VA6N1UO68E5a8W6uuJXns10UD+8nIl7U37Th7lDn9H5h7aiQuru41hjdbaXxqYshXWkFSplhsw==;5:zTqdMEl0OBkGX689OHqsLg/eH3Ub1ORuOcopFiRsgh4AmUGeMv4Bnc7Z1b4EcrW13smUjFhNCXmdRrFvhLZMiCyEstxmnzJ2WGGJVquz1HsxStLe11mZk68D1Y6P4ri19+QvgzkL7M80cZ/XQ8TRlgtYV24ndkWbYae3OwQNEkQ=;7:EQlckJ7ygAL+Tmcv+Go908sUdyA51Ci5ici40HGK2SZR0u7psmandjTA7M2wugPGE/vqXYIL80DQHhF+/phTLvzGcWT+O8Hb8SAyKNRXhB+DjKBCcWOx2K0bU8T5VtSSAOJAresd4k5h35gCMeOvc2mUbGt8cl6UQqu56XiuqOdcyQSWNy8IhQn98hXhEruCiWoYYJfSftKwWnKwtPZjcjGoeAG63E/nqNtj/705c9EaWl6x+CHQ/5VIBCDp7NXr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 20:59:00.6771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 461b88c9-b2d3-4679-f5c0-08d60f8493bb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4935
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 01:37:52PM -0700, Paul Burton wrote:
> Further to that, this series doesn't seem to work for me. With
> v4.19-rc1, with the patch from [1] & then this series applied I see the
> following when booting a ci20_defconfig kernel:
> 
>   [    0.846684] ALSA device list:
>   [    0.849642]   No soundcards found.

D'oh! Apparently I haven't drunk enough coffee today - missing link can
be found below:

[1] https://www.spinics.net/lists/linux-gpio/msg31965.html

Thanks,
    Paul

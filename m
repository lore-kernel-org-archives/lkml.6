Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD6016256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CE020892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="FnxsVfQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CE020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbeG3TNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:13:09 -0400
Received: from mail-bn3nam01on0112.outbound.protection.outlook.com ([104.47.33.112]:35200
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726888AbeG3TNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNtU6ELofLLfbu/zIMIX6iw8NDxAJLorV2/LCBEU3EI=;
 b=FnxsVfQzLg4lAWT9Fswmq+UrDXD/oEMVtH9Yxysej05H0XROjKs0fklDE68jUGOTyrDAkVwEwSkI7FALwdkmibOgGNs/UIzZ5X7vYlEeRZNaTXkGQzFNPkTtt0Wno7lcK0U8cRBxhqiCCpR8evDbs4y6VlJe+QbKby7wxAQHIio=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4931.namprd08.prod.outlook.com (2603:10b6:408:28::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.16; Mon, 30 Jul 2018 17:35:24 +0000
Date:   Mon, 30 Jul 2018 10:35:22 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linus.walleij@linaro.org,
        ralf@linux-mips.org, jhogan@kernel.org, linux-gpio@vger.kernel.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 1/2] MIPS: mscc: ocelot: add interrupt controller
 properties to GPIO controller
Message-ID: <20180730173521.fr6be2kw7irk5jbp@pburton-laptop>
References: <20180725122621.31713-1-quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725122621.31713-1-quentin.schulz@bootlin.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR11CA0010.namprd11.prod.outlook.com
 (2603:10b6:405:2::20) To BN7PR08MB4931.namprd08.prod.outlook.com
 (2603:10b6:408:28::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6655b41a-51b0-465b-83d9-08d5f642d4f9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4931;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;3:rwyro+jmHJ3LoFOHXS8PZs/4gCQ6yrYX6jqPDqv2Hx01e4Bcim0AmpNiSj7ng8RWDMDzQd4EgBR9TaaxhnxOqDoDEVCV4XskrLJG6ikTFd4Pbu+TRG5mJEdcRvZ48Na5oMtL/Nxds7ijb1v9zYmKBrl8dtvD7mm6YnfdOtaPaim4f+BT5uS1QxNR3/5vr05UFn7vMjRGXAd4JcjT891abrUFj/W2ZRULT3xl5BDFIo4YPcuGHtZlu1GZiOIz2w/W;25:hRiD5ykMwU81/7cVu1eFf4gRDzsksqcOW9k5UiBwudgnmBbatavmceOX1UdpZ4BINMIq3umyref16yLfKHwYTfIv3fUmVrr9pqWcrPq9AppoL4vvIeQ8YB7OayN1db1RHOygQNm/Tz8Fq8HH27XyGjc5UW1O7idtyPToPF+R+N36NXrKRbEKJa0+vAVWmMVVz8dZbNtNdTuknKpJDaTqScUVvYqWWsyE4YfdKrSiFPXnWWOSTG2QtX/lYXn61mgYRXpKrqLgUXMHzeVmqfW/IEUTN7AzeRwXyugG8Sx7rkezItusP6yf8riZSbjmT0xIsOIAxdP32P80xBp7cRwCMw==;31:Ob7Rub17Qc5AZ3HS1v77n8zBoJC0OVvlezShdfk5bDiIDVbdYf1gwiLHDI4zlcB7ryIygl6y80yL+Yneq4LRwW/AL4/6HygfekeyJvst5pXwfNZTO+fxOVGz3OcJ/B7OXu/eYbyO0mXmIMhYTXS1viUKTlmGNeiFlcellkkDxhTzlMKx9ekAP26uwdXwBf6D7YlW5j+PIPFg6PIKsunotuDAQ1mkCbfFSdikAm+bAN8=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4931:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;20:m71wYsi2nhk8gPc9l8fIlsWE3cx8hkDF64zyh7QmMy+zsj3cTwltJpmmVcXMOzYgTqLZ5I6rgOOIz3tHIl9FdTvTBMStKln51EH9u+CPSQli1vK/wF7/iIEdFOGMY/j7wIgiMptd1UVxEKOn9iIrz3gkH3/gLqmFuwxSOzaEb2O0d0G+aFwU2+X8S3VvXooySM9WoVm9kcWiRpg/3Xo7UT2FmrgwDSEJjZAOQRCW/uT1R2us6NTyEok5uovax4DQ;4:1Ua2/dxPDjlwM0NW2dEYPRWc/qLksM/59oXEvuiBsEqe6g6L32Qn4mVwUq1sMe16gh9xTQiH00S/WFSOpHKJcX3M4T0P714T+ieTtnG39fc6marf4wQCjBztgUUyJCZzJ9uaZJtBMF4QfuPJPMm2m4pASzFVkiFM7kw9kzhkS5Ni8pTYHtbm/jgf42XN4sK382pRTxnjLbaVEd5kxp/B9JefwIM+NyosDTTmBgCy+jj/tXnIQO28eA++XOps1dXfyNV3A4RwEh7bPsmOMhB0ww==
X-Microsoft-Antispam-PRVS: <BN7PR08MB4931DA5EAC254F2F5F8F4283C12F0@BN7PR08MB4931.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4931;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4931;
X-Forefront-PRVS: 0749DC2CE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(346002)(136003)(376002)(39840400004)(396003)(189003)(199004)(52116002)(47776003)(66066001)(68736007)(386003)(33896004)(76176011)(6916009)(9686003)(76506005)(106356001)(2906002)(5660300001)(53936002)(7416002)(6486002)(11346002)(42882007)(229853002)(8676002)(105586002)(7736002)(6246003)(8936002)(81166006)(25786009)(305945005)(4326008)(81156014)(6496006)(50466002)(33716001)(446003)(26005)(316002)(486006)(97736004)(44832011)(956004)(476003)(478600001)(16526019)(58126008)(3846002)(186003)(23726003)(6116002)(16586007)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4931;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4931;23:gzk0LFcrQXLZ1sJAAVpM/xOXVKiGu/FMJyDhRvyl4?=
 =?us-ascii?Q?2wOrkUfTDLVqhbXIVOl9cxPxI7uf5yTJju4BcLaRM0uzSrGZZlSnIWS1+hpr?=
 =?us-ascii?Q?0/UpAVTSe9d1ktqOwmthG6o8dfwkckXCLFyAfcXXB/+qTB1Cb5zQFTniaJot?=
 =?us-ascii?Q?CO7PjS3p9NO4Tw+NCD/wbZasPcakTg1GVPD7JWzbFdgEfKfFBxgCD8Ts7jlS?=
 =?us-ascii?Q?kAznstgELeyVGRtzHptI3kpGAbd7XK6+QoShYqpddA4v4WP4L+EA7fY4i+oh?=
 =?us-ascii?Q?7rk/n3XfETevtY/8M0apKs6t/T5K5REqZSBR0yjhsQqrF8VXSo3cj6zjIL2w?=
 =?us-ascii?Q?UIqRbWBHsvJ07w9Je/UQYwA+7rqf8Vk+JiLvPYrIiCuQ94ReiWboSBCwjRiP?=
 =?us-ascii?Q?cJNGwXPLLIJI0ABmIRhf4X8jehaBD8J1+8SqiuuZRG9H4R/VGX1jLNjAEtpt?=
 =?us-ascii?Q?Muo87acL5l0nw/E6X3Zznm4ZtArhSYTaEDTCoo1BAOSzUGAeoPorWI0k9nj4?=
 =?us-ascii?Q?NpXw20cPmCDCOIc/9WsWEu20QptX7MrkaqyG6G2sFlNanuKHdMfj2rDIzvwP?=
 =?us-ascii?Q?dOj3IaOsv7+pwE1ou8h0lGPD3Xsjzc67N42w+pli2gbcthZs0BlB7d2LJqpG?=
 =?us-ascii?Q?SdwQFYddRlZC8H8fbXQcKUwtjH1OzLZXkHcc8cA9BLXKrPY6L6vYfMwoYXsJ?=
 =?us-ascii?Q?ORPJKT1x5EkkxqCnL/xEBjRvhvSciK9mEMRUsbFqjRYBWUr/dNYppu+XHVWK?=
 =?us-ascii?Q?IN5H+MoG8ymBYSzAAzB083NfmwI5/wtxQsSEJOZ2DlXryFskFPi4O20THLxl?=
 =?us-ascii?Q?Uy7EgJx4sKi3+vp3wyHpTCR/inFwfejEXm62KjJmNJHU/tJdie5lK/cnE0fs?=
 =?us-ascii?Q?XQhJH24bJWuUsYUq4j2t8b7kBSwNhZjF6Kvc1BC6vgOP6ngyu4rEhDtYAqc7?=
 =?us-ascii?Q?RIuJPH8Vrac3Ytj9Zkdf0IuJh0YZkbRdgy3b3PeruKy2EcdqLGkhVQ/V+30l?=
 =?us-ascii?Q?FpunFSljBk48tJz1zbNlyuCAIAbIaLsHeJcy0MX9OHEt0yM2r6W7Z1iFRIWM?=
 =?us-ascii?Q?SDamPLuoRxSSggOfmSlgTae9bU9HFB/023EoEJDO+M8eraSH6XcJLSJkoRQg?=
 =?us-ascii?Q?iNT6O+6ZWeSjsyLAs4DuyWfTz2G3p2FsCEWQ5BPkSTuo+fdb/uvRwgLPGrLG?=
 =?us-ascii?Q?CrN/+rjTucfKCKi2Ev6l9GwuPpeqUUl9kjMPyYXY/p+IufMdSjfNBc7y8Xmn?=
 =?us-ascii?Q?XXS8WsZSht/mFGVrHQtq33HBS1UCvyjAYGXapigAcPU7qx3jwLUI0VKL5maX?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: 1RD/3LLRdVWrD7WLqD+KfzPoNz9Op/xLFV0v/5YevL4wT266+ZtWU7hu1/E9z7Z4Fu6CLracL1Mcq7C73HEkrZxyTtTXtAft5M3QBeixY1aYfoBLlvWxpQ4wOCl8zB6p+JCDWlKRxY37vazwOFZcvaa22iaJikMrmYsQB25/hKDyGMSIWciz3BXfogIQOt1xjP2yLP6qLzJRL/Ir8GcQRACSkRenilxNZuzMdFsjc8HwVvYlJFHVizAw4+D8js8JvKe1/FBKZL2V7/V4ouHKtmtYMmBmDEBZBApIMVOaGY4s/tAYiVc8YilXDPRRp3WKe1lqlhUvXKu7XJiS8eRfm7Bb//bQJ3K+bhu8ELDHRiw=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;6:mqNbBxNE3N6ZFWNwefpMj55zdBJHIgg/tbHgFpEG8IEldFPyEcApaiyDg86XaISkW6wGxb58efSt5QdqWHA723uuPzR4U/4OfFf5UEiQrSZU7wBCUI57KmpdE7kAMn9Jo+h/+yUxxuafh5/fYZhBlY+6tzwWxL3z1326ILITuVdx/yNOsJxZUUhbpktb9kxBcdvjokC+hhZu9LhEC9qnaO4Yck6mZvFd1YH/yF1khGLnCdxbiTxRFq9PjniSCXxkF/dJsWt6PcxGcxbB4Yfy9EbHjQ37CHci7ID4YgSdrGZAxywmIxiQEO2uYB0wkP46COHloQAnYGRu2wes41Mvcj1aTQxA/E+rOxdq8V+/rQcMyk3skQnnGAFlWK9wFChBwvu5LJPK8wOwW9CClxvjJOe9CbHrLpKpM4cPA4H/YRiF4i0Udld15WBVje3yjyxSzNXwrcvAiHnwrcchDn7Png==;5:maB0fo1rnnxXr4lk0gizCniR5s5YTr/OlGBOYFNuo0YXrxrMBidOMFbKlNkuBewFUCbrd4F5lsxa7szafdVYn7EsBmGzOI/wLrOSTlj/FuLR1LP+Xf3AbeYzjNJhlDk5xpQjjZYEBWMipVD7SsTRdSU8sUACaoB3Ktya1ZQqJuY=;7:t9fnEzcbCkECVVkNspuXwqrt1zs5woWdXW76frJrGnZEKk6c9NxwZ5oMjEsG5EsgJhsc/REUfL5O1BzLyerClSOuFGDQNWzG6bHd8MWBpirU9VhvtzBq6CzHND93LtOJuieyGlQlBqPw3RKaNGWXuLpDuHJ2D2Kung1Y0AU5K2KdWepmUTQuh6Nh1UMKcyRFH0xZEP8bQwrlvGzkCmRyqRBeoVSlP7s3MbC1mU7xMmIbI6PVQHOObnCaToI/U2j0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 17:35:24.1897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6655b41a-51b0-465b-83d9-08d5f642d4f9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4931
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Wed, Jul 25, 2018 at 02:26:20PM +0200, Quentin Schulz wrote:
> The GPIO controller also serves as an interrupt controller for events
> on the GPIO it handles.
> 
> An interrupt occurs whenever a GPIO line has changed.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  arch/mips/boot/dts/mscc/ocelot.dtsi | 3 +++
>  1 file changed, 3 insertions(+)

Thanks - applied to mips-next for 4.19.

Paul

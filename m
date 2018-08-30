Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F82DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0293520835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="CAFAWD8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0293520835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeHaAcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:32:53 -0400
Received: from mail-eopbgr700130.outbound.protection.outlook.com ([40.107.70.130]:59635
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727181AbeHaAcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDT6TKJgrrMl9krvRiPI/PRxQDSS7RGGUX5fwy6qIgU=;
 b=CAFAWD8MUZ8rKyjbUckZHk+N8BytYvwBFzqNCttzqQtGJKJYX89egAYtOSGR4Z2pS1CcZDw0VmLYzxxaW8IErbkKR+smHLzJuWy6wRtD8Bmhwog5MCte2IRp/3UASJGHyPtIFIzRveVYpmqVR/vxqARmjXnKpVRYfizNBUE2wcU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Thu, 30 Aug 2018 20:27:13 +0000
Date:   Thu, 30 Aug 2018 13:27:11 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Mathias Kresin <dev@kresin.me>
Cc:     John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ralink: Add rt3352 SPI_CS1 pinmux
Message-ID: <20180830202711.fmymr3uay47z7dfn@pburton-laptop>
References: <1534970286-3758-1-git-send-email-dev@kresin.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534970286-3758-1-git-send-email-dev@kresin.me>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::45) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cda4fd0-c16b-4cca-32f8-08d60eb6f892
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:4E1BbOwgbe4Er7hnjb9QAWX8tKGLtnm2KKl0U1l/3a1hptXM3EkSLpv4YnefZNrqkUlwaeh0WGDVbvnJBGeEGHLUToScApCQjjmprO2WQjJiZeZrxQggtRVPdj0wLCe7nA4JUXdo1jY7rbEIqo76Dhvi1DLGW/B6ClGgn8Ala5WKiljhdhHb2ifP3Wn/Sg8kYJWe5rDkUyZoARgGmE88QtXYDrzAOm7qAPCLYFvSLNWPtXiPiVbPinPgP1VfEbVR;25:/PSVxrfloafWvk5gg/FxSGvdd97wwFGVm6qbSonuNFvUm0ujP+8BMyMBy8LyEmWry0sSvmqnBIvJtMKxKZnmcltKMXOm+djYmfpmstBDRbycqHnsQIHiGGgJDKc30cXwYVGrRhWkQz8ECPxKAZLrvJupqWrWm+7p4CqFkGFOMd+u/bS/DNqBdb+MIXyhFNbWYNf1LXNJRMOK1Xdi0jKhiU0LDRwnlWa1A+f44lpUgAxUtJnZyvHfWH6zQWYxIIRVjLBg0me4h/s5cfoIVZUqKkaXQijENy89MtWM4vQ6A8Y3WhaUKDaytfVCjxmKvp26VOBYpSqYWqkXycpizcTwdw==;31:8CwrcgJhwq26Q1mz6QnQNBGqw6sAQjP3Nc985IEzCDowpKoCpKuHjjzPiylYWWhPyN50/oQs/qAHUe2aBKwmSCmbOpO3CJOmM+Hk3PLHZeOFBAhncj3vjP2qoC95RwXNYA14b8aWQnWRmsAXg10LiGLzK0kjLX6RqHEIEKdZj/36sVUNqAAV4Q6oY58LQotkFw3R3V4w22HemmBHJOgbuz9q3DkCCmvvvBu4Li3+sQw=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:iyyrfqDNJrqqa0Pwutb6vkvi5Ty4lm/7wIQIXc6pDD3IqekFcOxw6+VjPnS3cKuvu2+er7s26L3lg0jwyvGzNnFPbsU0mlQ7a0UGM8BmgPWxKG8fbQvniszniSVEYMltJcg1Q5RkFZfcLpo6bvSs5sw1uhAqQN7vwuzO7X7OpN831W7eh1CaEHu0qykEy0k/CNojvIid1wZcHZFWrm4kPPTw4X9yD9InhRvtqs7k2hBC+rcxAIdbMMv/vhdlLqsh;4:LnL+k0Z9i/8C8Jb1Pm1CMHp5Dq46Dw1ppKeaidNnahMR8WFtT9LxRJyVU2sw+1HCH/5DrKPBIz7oxTpt2VgI+FLZtMnm8Q/j5xZKCOkqgYtYmaCObucjSblrMOMMzGnxvCXaJ0gJGlZxypJVcw5tPKUVft321ECAR6tBBcg6kRquOdzKodnd3ZSthatz213OjUOzdGnujShydKGl9wXdJcinXTHSYLteAB6rMv9Mu/UfR1kOhyD9TIUJ0nCWpqdE8Y9Tg2/h2DUL6S3uz6LJMg==
X-Microsoft-Antispam-PRVS: <BYAPR08MB49343630476116CBC2C97D3FC1080@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 07807C55DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(396003)(376002)(366004)(39840400004)(136003)(199004)(189003)(8676002)(81166006)(44832011)(25786009)(4326008)(6246003)(305945005)(9686003)(446003)(316002)(11346002)(33896004)(54906003)(486006)(476003)(42882007)(956004)(478600001)(76176011)(52116002)(6496006)(8936002)(6486002)(81156014)(6116002)(7736002)(3846002)(58126008)(1076002)(229853002)(16586007)(23726003)(53936002)(97736004)(26005)(76506005)(16526019)(6916009)(47776003)(105586002)(386003)(5660300001)(33716001)(106356001)(68736007)(66066001)(50466002)(2906002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:DCYvksyVw5Z+Kl2gwmd4myFg16sXBeNkI0ir1n/YG?=
 =?us-ascii?Q?AobwnH2SJyjn4Nw1vRUVTOKa8versN0PSdgDhS0RJ1J3SiAlODRWSYDEdpMe?=
 =?us-ascii?Q?WAYWjjmQ7n7CnAXrQq9Ptzq7zkJCVbOyWlCPVEH0kjxl2yBi2tkb/UT9C3RN?=
 =?us-ascii?Q?xmVCtyab7evPgN2pMj648AA6D4iafdCCQCmH43l/F9Z6CqelMeHzkF3wKxNo?=
 =?us-ascii?Q?l6tqzq1+wfbrX79BsphGi3uwlNng/CPw2pK6pgf6HxGacyd8RdjhBJNjcmW3?=
 =?us-ascii?Q?HR46sdQzQUC9FmKMyU4FKa2cR73f6/rSYuWCrMPQEfOIz35uA7A7UhstHpX9?=
 =?us-ascii?Q?WYuYsUAYenwTsTmHCDUPnm4BPKZPNLEHxZ64vVJmpdDGclbTvA5NKoH7XtoY?=
 =?us-ascii?Q?Pyqyj3Aul5yMZ4330hU+kxBs7XG/3/Dfcy1mvlE0v5Z9iBtyZs3f2TGyOwhS?=
 =?us-ascii?Q?wXVNL2qMgvSXxRiLGQMEGGojvFQ9Shdre9BUAFbW3QoYG3YMGnQPGgaubiYf?=
 =?us-ascii?Q?eGBdydHcznOrOL5RxyRHDvFheC6uWq/nLVq1Mlw4B1b4pF7BDmznQJ23s+6Y?=
 =?us-ascii?Q?U5UMQRr/iYfkYLtQS1KFHOO3kuF7gmx4GCEU7ogUepvA60KhLBMYg2d4u3/k?=
 =?us-ascii?Q?6hHnFF3E64ofFhhbXq4Su+vb5hHMwHCRGHE2i1lareGSFmtNGH1hXpUCJjLN?=
 =?us-ascii?Q?MFdhDwBG0avqkJ4ExGUxtjyFoUVeYTta2qFLNZtoMbuc2qCvLJzxWtN12Vbl?=
 =?us-ascii?Q?xI/8yfOp958vqBX43NSuEssZo7XaGVlS45qQjskPdeHVLKkqwY2sGHZfPfUw?=
 =?us-ascii?Q?lxdVLoY2yPudVDaE0T536la7Y2soBVexTP9TvjOi7zF4hEl63g9BJfZH20cq?=
 =?us-ascii?Q?rWr0RRsgw4z8eSRBUw3cvZQMfYPVc8cLS8ystK8Zhh63BzJ9pQpr1waDEovC?=
 =?us-ascii?Q?1SZw7XqUhNYaMNN298L+j7s/kUnuneB886vMjuq4mddm9aTJRa5fBgI9AeH0?=
 =?us-ascii?Q?sPZ+21qvJ76hWRR6HyR5YDsFPSEMga86FUltmmLL1d3IgTz/CVm/4rH32AYd?=
 =?us-ascii?Q?Vjsf4fyKh+FpB6MNV0LNCwB65o0IiTBP7ee/iFSGGdo5llRVotFmbcUJ5J/L?=
 =?us-ascii?Q?YC+dFT3noDgrZhKvlZWqejL4pjNwUoH8Hl/v91CKLgXqeixdvEQwX0T5WHQ4?=
 =?us-ascii?Q?5/2XgRshl8QemwC3M2gBmagpk8nZNstfBygj+kZJvY1ykuoVkf8Q078Mnnsz?=
 =?us-ascii?Q?k/AMNUw5b1FBedXctWPTise207gQF5dRFiDTf3enYkvW01JEYERGkfJo05sV?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: Qafx/Nnes2NG3bMjsVmR5KHLrI7cXp84LkTAIzyOp0MA/HlsNvepqIc2aF4lppx+ywbxEwzext3OLWLmOYLM6d6dMicVuCA7vH9c/ijOjWzhPVyg7IAaU2rGNX1hSfYrirxM50s4WTjqAcgvpwzScom3KJ2P4IbYus7QZSFgY+85ijoKCHwn8xAgNzyuqAhvei7w1wge6jEdigS/4Cg2vzF6QZdNHMTp18lPjf26Meq0e9BwZW+2xPBkfyBkWteY2S7vI66usYeRmtaXfFGBMOmyYT63uQRP/qbg0FMZ8BD+tXsxq96+vosq2oFurc/5DMtKGnUW/VIXVBK9a1MJrwiVSBjfHlE9RM1LO47upu4=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:ExFnehuiMuP37t/02PaEIa4lZ3iNBSJUzzbk9c404yAAcSFBrHdjtfnTkjFmqoCT2ATS2Am33pn9oa4tHhng61GplmkIZq56O/3/5pRZ55EdI8WLWQoNEz+Oj+5Or5LcmtIEY8p6of/sZ+ZJe3ba9PWNPJ4lhDZH3tpqE4sp4QzSocssLuQc5WP3Y28vu9yEBnT3Dsf3n3FN9fRkCUaMX8MZ3JPo9AFLueOSo9TULrtPvEMLikwdAwITP8AYqec8DaF/zX9AW9VgLQl8xY2mUADhE+UAnTooX0SbcXCGZvtP7HNJ+hLtQjE5ihdPV/L+jjCvB3D0WQ49gaaF5A9dGc998fOQIxgF4nlKEaRTSyQW+6beI6IjT3ed1gbq385CDXLaYnIk9YUjkzeTrqHqOhtjfTiqq37KHjSTqPoiZRO6S05ORsLrHGhLaEJteQawKdgoLgqDJp633ZImrEUHVw==;5:bw31IsawDCWz9tulPhr7nzrbm5/4VKbJlGqTLF5sc7b3XOKPkpqCGT5G+Amt0VS0w5SPGf2sJN4A5ORtDXXN06yhq6GEA1wlZH2x1iVCwVPHyVOTOVPDbZVY6QUhcVRk9Iyw00U66Ce2oXiUCGV4ntA8XCglEwwwR7dyX3mUjxw=;7:rmk8expKS+0F5RoqEfqENrfa93W+VD8GuaBZTaR5Wb6cXRWDC+VrmtT1PKve85KH/QYBgYXFHfMRPJ5FutIAblclCkW2LnWlKHmecE+p6XT+AqJEocpaKMs1ZnHSF0coBEo2mCMezknCvwtE0lDUCV39wq8F04WQEvTsixcPXf5mIsSebaIJl3DrI0KOa+xXYa8UR3VHCrdLaxnKjLDPN+UhXV9DDHUmBXBsvFokrti5NfoBLd7Qyj3o/ykICATZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 20:27:13.6081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cda4fd0-c16b-4cca-32f8-08d60eb6f892
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On Wed, Aug 22, 2018 at 10:38:06PM +0200, Mathias Kresin wrote:
> The rt3352 has a pin that can be used as second spi chip select,
> watchdog reset or GPIO. The pinmux setup was missing the definition of
> said pin.
> 
> The pin is configured via the same bit on rt5350, so reuse the existing
> macro.
> 
> Signed-off-by: Mathias Kresin <dev@kresin.me>
> ---
>  arch/mips/ralink/rt305x.c | 5 +++++
>  1 file changed, 5 insertions(+)

Thanks, applied to mips-next for 4.20.

Paul

Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE98DC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720B520673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Bp58w3lr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720B520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733130AbeGZS6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:58:12 -0400
Received: from mail-bn3nam01on0138.outbound.protection.outlook.com ([104.47.33.138]:12096
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730285AbeGZS6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8pFdV1dOS1DMxpc0a4mIq6oIc2A5pLBgmGZholEOJ0=;
 b=Bp58w3lroi5Vch1i6qOFwh0bIKORwBjx6eZFeQ8AACRPx4rDEgDhy015xjsVzcsUYsEAuFGl7BCUDNsI92IRaDWZ/lINTcGmsJjqWMH7Vo/5eFptbeL2qzN53aWIx+G8QL4hHYrjSe+6F6Qz85lvC33cnv8Bb8qVs/8ylhuBXn4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 SN6PR08MB4943.namprd08.prod.outlook.com (2603:10b6:805:69::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Thu, 26 Jul 2018 17:40:18 +0000
Date:   Thu, 26 Jul 2018 10:40:15 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: TXx9: remove useless RTC definitions
Message-ID: <20180726174015.2brsh3x5abcdqh27@pburton-laptop>
References: <20180726164054.9092-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726164054.9092-1-alexandre.belloni@bootlin.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR2001CA0012.namprd20.prod.outlook.com
 (2603:10b6:301:15::22) To SN6PR08MB4943.namprd08.prod.outlook.com
 (2603:10b6:805:69::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: beb523c7-cb61-408a-3f38-08d5f31edad3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4943;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4943;3:8CvZYSLEGslinLh9lSTRcnaV927tkjcwRkZSy9La6Ps8SM3kR8Hexysh5YLCSOZ2nuHzurHDM5VdgxP0HiKc7vBgZEcDU3+yfKkeQ4CHgFzHwgJ7uc8P5Pf3OCGvlvNRKVqKHfd7zv+4MP9flF/ddBnsFuAS4yJvGIbg2OIVsHnq2dhIi0s6qhUz5c6lojsovJvQrJESQS/z0mUQEgNK7ukRkgi+DQY1XEo4QDX1SspRyMVFYLoiblFUmhF9siza;25:lT0FOSu47Skt6rKtj7iTR9YHHDKO9fuj2KsibifGw3O1lJBJKI2+eolZO4CIIfjyiR+v5D4wSPvkrW5OB7bBITxvDP1ltkDgwjmFqu5sRvnZsedF8I3yhcpk6L35oMQ2OdrbcWb+E82hLR4ll5P5kbp1dAcAS/CcfhkySZFQOhti26HQiJrGi/MOB7pGPOu4H7okoPvOA46RZass7S87CQWK9pFM+g6iEaK/PdQCJOz1s8VqOwgSRqSy/Qhyn4YlJaQO2fYWhX4jLkslCRw5sZ1HjenmkF3OVqUxDS59k5rsdGzCoGDISCQAigEMLML+Yrr5DFoOsl+k1cF5Y6BDTA==;31:kfrqjhXcGRaNSExLg0GHlb7bWcFP6fau8HkRkfkkRVPNNbxp7eULNYEOod80D66Jf73Tpvi1Os8qxWME0APm8sUpnpKLNl8XD5nRc/JxiYGm+IMkU+/Cb2eBNq9/7EfJ/zEWmmAYaaW+Lx/KhFT7R5uLfVQ2qZkYg02e93FrDp/Woc6Hy93sqLYbtPQ5shbdoYy4FYX1qAXwlSY91O/ReCHXAhIdpKjhyWF8mEYuGHM=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4943:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4943;20:JBWGXmKEOHn/f1voCp1VmMTO6Ba3gvtQckKR4vbL6RjDefMGp8zJpxG6YTz05Eme9TyDXC1hbWftrunfAA3vd1j6sT2WU0KqInPnmm60ie4nhfhnA2WSjJ5byRQFNTqF6fs/e+eobGlZpSvnyCDbhb3r1/4WG4UXNC2/MxX3Yff2br49pl/NKIFCFsmoeBgkPHhVYTG+IKHzdWWowIXm6x1qJsvaIqdnqJlTxsViopgu9ujByqDBOukD20bxJmvN;4:ebrBpo0Enx9YAUD8VrkhD9xvuHY3lxz1FiW79wNZpbMcXlsgJIITXYTP2RF8nnn22PzApZufUS1ngnY+395h0p33bTg+Vm7ALuVAOhHPceGM474icjKiwPPsu0DqMXwaFKQaAIdJjXtF4ph0K2M6O9VSVNWUaplqaFneVtK1dH0S6uyor3gG/8E5v5NWkbdjEKp3zBPUX9NWIXTlv7s7dH9qNxAjNsq9vo4/YhGnJaupMM6s5bcWn+5VrJ8AEIkaktDx9mdQGJGff8I/HJtE9g==
X-Microsoft-Antispam-PRVS: <SN6PR08MB4943AFC5A583825B05AD7C4BC12B0@SN6PR08MB4943.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR08MB4943;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4943;
X-Forefront-PRVS: 07459438AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(136003)(39840400004)(346002)(376002)(366004)(189003)(199004)(4326008)(53936002)(476003)(6246003)(956004)(106356001)(16526019)(186003)(26005)(486006)(44832011)(68736007)(1076002)(6486002)(23726003)(105586002)(9686003)(6116002)(229853002)(42882007)(446003)(3846002)(33716001)(11346002)(50466002)(54906003)(58126008)(16586007)(5660300001)(6496006)(316002)(2906002)(97736004)(7736002)(305945005)(81166006)(6666003)(478600001)(33896004)(76506005)(81156014)(52116002)(8676002)(25786009)(6916009)(386003)(66066001)(76176011)(47776003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4943;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4943;23:Wi7WFyeE90Jj6E3G9C3FnvSGkQqrRBYOoiE57JXD/?=
 =?us-ascii?Q?FObm76fAP4FO6lfsz1xYzfLbMCZ6tnc11z3ouHKG1NWoiLW3yZqDl2tNIL5P?=
 =?us-ascii?Q?DQsXdyMzgJHgulvX0swIUlTa8jidvqVysuHQe8eXiygWP9KXzmk/+gDRZUV2?=
 =?us-ascii?Q?KmIJqL6RMx5ulAGVKvYp6Ns/P/wrtvvNS5f1REpCBFPl9OTWzNiz+OpiEqqA?=
 =?us-ascii?Q?1xxhONREH3PS0IOda/zHfZ1ANwshdKF0URiwUAaT9PHF3+XZ3+D0KvjUezel?=
 =?us-ascii?Q?Nt+RC0CaE1G7vxkuqTmEb1bdvN5BUab3U2Jr/AiEsZWHK/XtDwq9JjG82Tx+?=
 =?us-ascii?Q?P99VLcfi5e8zzi2jQEAbnIhso4cAI48gT8kvzj8SfQBOkwEkAjWJTXqn8aRf?=
 =?us-ascii?Q?SDtmeMcSuWYj+2SSU1xzqfqHnuNoGhO2sllUSwu48aanZkQDyXhzSTEV1hYv?=
 =?us-ascii?Q?NoM+8XdK1y/zy1CTwGzhFF2o6X0d0S48BOEew2NYskBiD2JcjMiaLXQD8SE5?=
 =?us-ascii?Q?2BvLLcs1ItcglXXwoTf01MYxzphmWpAtx4xM67wZYS6mGlsvwDOmImUjg/CA?=
 =?us-ascii?Q?oEqH3C2VKbisGDsM8H/7lJ/4T4c68dw/st1JJ8bwRlQA54/QLBONgM8f/Ywq?=
 =?us-ascii?Q?DzrLdhY5fLi16T3UUMP/BiCCvi3N4ATVdFTuWp8jGpfR+0JljXL90KG4ui05?=
 =?us-ascii?Q?KnuOXZKLcGEP8MsIcuKf3P2Q89/B0GZgW56xWs9W/to8hAOFY5fr3cJaQ37/?=
 =?us-ascii?Q?TcIUnGGGOii22EWI4FAN8u4X4yn+yqs+6Hpq2cqe9DaO4AZzzrhjsGV6ju5+?=
 =?us-ascii?Q?h2ni11ykNdYhPdJEo4EzszOHCAD6FH9kEYxDo0X/OZaMmTD8qun310kM56Yj?=
 =?us-ascii?Q?hIrc/yD5Th8Yje1thC1vh8+vyi1dhVrH3Z4C2Rx7Hijs4PnKsAYNUI5pX2Ax?=
 =?us-ascii?Q?1FKsQbdneTjxpFYh8SKIvUtdeL9SdXXsqw7FjW+ukzmqJJdHTGxrX+1Et67u?=
 =?us-ascii?Q?cbxiLwRtoDJYxJ0mvYJipFjoHpI7I0ttDFPJ4yRkBr8XjZ7VCSwxms06xR8A?=
 =?us-ascii?Q?AFUihhw92FwRu0mo8JrJFEKyxJY+innIMJh3A5QldlpE/m8Yfbxfs1iC7IxN?=
 =?us-ascii?Q?p500c+tbnX8CgUueFCCSb5/vNai1wSZPo1s+0jkAurs6FxCz/lUeAEVhVcYk?=
 =?us-ascii?Q?GG/5MDP7m4jdo3MLLd8Jz2NbQ89E6PyDeOnoICKg7/5YBxQL4FvQ6emzBlyk?=
 =?us-ascii?Q?LW4Fn/gmFTcZmy1cl/3YqW2E4ZEUFG1LvR/SKjp2/39C0depnOfH47hCPsgI?=
 =?us-ascii?Q?bUzfOALKLiKxV5FKj5nLtU=3D?=
X-Microsoft-Antispam-Message-Info: ZpumelVdhdBBqbEpSWIe6aiU6ybSXxmegkdHNQIbcazYgb29xJybHrG9WjlMAMr0QF79ySy2F3TYeG4beO2lrmMzePj5JwYkELa4IPHQO75a9fttSJp/Y6espuuJNo/6pxg7C5BdTCEwVbQeVHzbJ0ACNhtoa4MviP2FRiCnsGj3NH+m9JWzh9wzj9NlU00FHzLKiOZpoR12zEMjVudwu+vwVPSBYtAhf9zTO4jwdF0L2XywLyimW1Oo/gJe9qcynh59TsSke5kM25Hi7+3beAoVRLGgphY8PG5nPwOMEujWKLR8WZY6dbV3QiGL55+zw4d6GI+k65qg0BRRlhKzcs6+Hb/73G0GOl9tIGNozOQ=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4943;6:JkqgxO0Jn/r3MKlh4WHO5ztXYuz5h/8tNpaDLS5/ij9mieQNZNNBZuQ+041lX+pnWzH3g0JqkwTz2EkmmEnwPQj7gEbREyValbxrriNB/Ghp6lh6qPYIOHgb0L+rLhs3sGWz3LNEZf0W9xmwFGXCfLMO7afnlDRA0fTvcsyjfpQPfFDmT9TCc5BiImZ5iAT2Wptgks8sosAWO9kqgi7K6/iZ+PVikcTEj1QBjQBUZb2wnVXJd5R2qZMEWYTylMrXwPpJljxLZlkOxjHgFlBkI/S5jmv+C3x6kl/UhwnL4C3KEJe6eLXMYjFMYd4kHz2VyIFju1lYfGd8pkcOXE/+9S0QXcjjCw+23kAZFcMFtEBu07Lc/tJi/BOvgrFY9CzdPQ0PP56PFgkPwiF2DHHIGrPta6HTVWy96XYFPtV6pdV9eCLc72+WjPyeTGHzx8Aq//2Yrsg+QYFhIkKunVnSlA==;5:yL7ZG3IO/i6TF1DdKoHQYGPkSqDJ9cLHI279jG3SCzGW+T/cHSDRxdM8xuCtONSwrEXZQatoRYbibIjk7lFfZuz87T+/AvQ6Ct7N7mebMSu9USD7NdeSfyJJEq5f3l9YJzr6tyL7pFLM8O3Lna4nk5Ff0y+L2bcac9AkUmMY6Tg=;7:a/5vIbQGr0YHH3B3h2NH2GP2l83W/XEd3XvW8NM0TL4NKgIABAQr2BIG8DRvW/HRf1OzW3vISI7F23YrrZHc88b92na2+p3MM/18yecyQyt4gjAlkIFJzuID7krvLZkPWE2zka9H1iBRUY4ahx1/e6d4bWmccfV3mmNXjihei7cRCgORYhKK2Gf+qErr2+q1WFU9SynAXIC77Jfk4rSwMuZX6ThhwjoBbGQO6RoJ0/j5Fapj6axKaN54DyUaB2FW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 17:40:18.6577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beb523c7-cb61-408a-3f38-08d5f31edad3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4943
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Thu, Jul 26, 2018 at 06:40:54PM +0200, Alexandre Belloni wrote:
> The RTC definitions were moved to the driver, remove them from the platform
> header.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  arch/mips/include/asm/txx9/tx4939.h | 27 ---------------------------
>  1 file changed, 27 deletions(-)

Thanks - applied to mips-next for 4.19, with a small change to also
remove the tx4939_rtc_reg macro.

Paul

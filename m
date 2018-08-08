Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D096C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD3721BC6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="MPwuoRcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD3721BC6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbeHIAD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:03:58 -0400
Received: from mail-sn1nam01on0118.outbound.protection.outlook.com ([104.47.32.118]:9600
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727530AbeHIAD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lxETS1x7qowOxi0gafLI2f7xDY4M3V4n89giaCScc4=;
 b=MPwuoRcqu3T78HsWbPm7r8BBVmxF+JXKDmjspCloICWX0/SAHGvhMeEJAxIms4hvdPLuoeQ+SJk8GVj8bRRlXlUKnKnQ1gH50EWJeBvhGL5zlrANQUIAPxgaPAYoCGtZeBfVVK3G36/YCMcn9wKYuPSwOqHg/0FXiuLTYF+/nUA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 21:42:18 +0000
Date:   Wed, 8 Aug 2018 14:42:15 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Fancer's opinion <fancer.lancer@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mips: switch to NO_BOOTMEM
Message-ID: <20180808214215.bf6hyurv3nunfynd@pburton-laptop>
References: <1531727262-11520-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180726070355.GD8477@rapoport-lnx>
 <20180726172005.pgjmkvwz2lpflpor@pburton-laptop>
 <CAMPMW8p092oXk1w+SVjgx-ZH+46piAY8xgYPDfLUwLCkBm-TVw@mail.gmail.com>
 <20180802115550.GA10232@rapoport-lnx>
 <CAMPMW8qq-aEm-0dQrWh08SBBSRp3xAqR1PL5Oe-RvkJgUk6LjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMPMW8qq-aEm-0dQrWh08SBBSRp3xAqR1PL5Oe-RvkJgUk6LjA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR06CA0093.namprd06.prod.outlook.com
 (2603:10b6:4:3a::34) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0723c158-4f80-499e-0669-08d5fd77d0e7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:T5rxW87gLn4AxtaECP03VP5zJ7NNEUaYYvGQiyxXJRbruXy3/ye9V5WIHYNA1VM11Q6Pposrc9H+csJdzWfUmaj0PRjhbDc10/fpyrY7rWtdAflhx8h03rx1lJkmQjOVYhHrTlgQflJj5kGEnjUBDK9jM6VWVUdJ1rYyMKJkmLUg67VJPPZvHmkxxRSc753Wcgw/EJf1Al3pnhOEHCngY6aZH3hvAaY8goO4HXJilcn7pFow8U2RxVgciGrLhIbn;25:J+Ue6bgcJUlfyVdZ0YF2ibqnGS3ZgaMUnkiX6fvrecQZMZn3aDlKq7u0WYeOiA6U73yitIdnQNgDVw29KVG6tkPwmVTFHLJqTol8VT1Vvp5+vUvvWYg2QLW3lPYjCAL/2H1RFXzVfV0zpUVyKn6fHiqfkhajFGrir51GGnul4Gmbci8So3SpCVlDE+RC/ADqtA1Pc9WlorLw+VHhumlEio+slCEFS7vsbgcSGrrPfd4M+T+Jep+Yja9ekXDjAWZ24+D1uKCWTwyHgzUBUuyrXilXDROJMq+i/0Ea72mgw8zkfNXrKE+kuy3A0SwDTdxPMP7k6F2rJCLYdKcFXYHWjw==;31:9QfEB+rhGy56zj0q/eUH7OVXO3OpSY8/G8vi8M9h2MZOhg5I8p3b7swW9jbbRnNQzDlVS4Q57NQU5tfi1zHM6uFDA8Y+2L3c68fHIeIKs5pxP4PuY7alTLMnG+KhIWGC8JSPgz6ms91WjVhiabx5Z50BihoIdbtT51sCjrfi1d136wM3eaNnqjJEhfJQZlfVc6R1/x3FzPYe54L0zagbvNOkASBpB9Gtwp6Daa4E28Y=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:iJA2p1xmfKXY/x1Jb4HE4zYGy3ftrTBtNLbbF+Ded7lbGTSmHGMFf3ZGN4LAFzaUpdCN0mNfkYyyW3oWMEH1K4beXxc7bcqAaYa7oCBfAZpsn4tCDm6bqlND4Guw1t/y4A97jMDGSbPLnjZ6dRgs2m2pGManuZ/kXqtmi5+g4QBU3JWpURsJ0d/S43Gh7FtgfNXcb0Ak0M3xn2fRL6IdgOzA4x9QUN2P/EFgy9SfvRaF4QPIzg0o2CFpxmRLV9cD;4:V3Pvpvc/g5T6FQdulOljcvwQEgaGSkLyp5VoJ73RAZBtss3OZx6TPDmIBpFgy7lGgo2IefyU2ZX3pIGgQg6wQMAgqCIobzf3TyYio33xPB7hcNgSaAAGYp2QMSkEinlJ9AdTjoGy46ilU3voXTILbfpH8iL2aul1UUwYihqtVCjVe2aT8kyNMr9bhT6yHPI1+fxXPB2CTkC/46syNZY9vR0J9rLysF3U/VhhRYLzyv7BApugORRxedbb/1lxi4+sHWcuF6vsbjstDbP2NKVS2A==
X-Microsoft-Antispam-PRVS: <BYAPR08MB493487D44D86139F0C209188C1260@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(376002)(346002)(366004)(39850400004)(396003)(189003)(199004)(1076002)(6246003)(76176011)(66066001)(4326008)(47776003)(52116002)(33896004)(9686003)(6486002)(386003)(39060400002)(93886005)(25786009)(186003)(16526019)(26005)(305945005)(105586002)(6666003)(5660300001)(3846002)(106356001)(76506005)(68736007)(23726003)(6116002)(316002)(956004)(33716001)(478600001)(50466002)(44832011)(229853002)(486006)(476003)(81166006)(11346002)(446003)(7736002)(42882007)(6496006)(110136005)(53936002)(16586007)(58126008)(97736004)(8936002)(2906002)(54906003)(8676002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:IpwAkpUbvHyDXcSZZIwStDYcMp/IYIDgkQRd5pSMS?=
 =?us-ascii?Q?bwl1u3rGb1E1S/QtkRcTdGOYwAmV/11dRgqGyo3bKmJHwoy6z52hIDZas7oD?=
 =?us-ascii?Q?ypGswgXzrl+Jyw3f2jaKUJqHB179JA6g6lH85nBeUhIhneqb8MgQ+uwPsALo?=
 =?us-ascii?Q?Y7PT9HlyJHD2g8xnrA5b+b492vxEF4g2/3QZnfToKHxdH5h+1xrk1eP/5Eqg?=
 =?us-ascii?Q?SsxN94xewtqeJQDhsoBHKNqPGMXwp8MJQsDVjpxkTLyLoLmUqF7Op/gvoZx8?=
 =?us-ascii?Q?FmEW3LdtY4Rfw4EllGTZ1OG/9t7QiAi+WPIYM7JuEZbb2xTnt+vl1rDkKLLy?=
 =?us-ascii?Q?4dhKu99UcyFxcpV6AfUFN3xcq0pg1CUWUSd56UxM1PVKmGlFKEO2R2Q43zXX?=
 =?us-ascii?Q?g2DHVYSBNAHr8rBZyibR/agEwbcToCWhy90dMNhzjyLMpawNdtoWIWATQZ0e?=
 =?us-ascii?Q?H/eMp5mvA3QP0QG51UvrBPtJAGDMvXxW+SSeU5ogpS/bfnMKSlcVkrvQLrSB?=
 =?us-ascii?Q?9VHtox76lqB8t5obNdlp8kIHecJp7W6CGBZ5/URoc/2IgqJlJivbsuljcGBZ?=
 =?us-ascii?Q?gXbOEVIdo0+3sk3sAdNWi50rb4JOiTFcT0Blq4gJv2//HFdSBZnCnmPaxiUd?=
 =?us-ascii?Q?xpM8YGybYig6GtSInBVAXjeXkEdmam+bGqHyjz+rU/lemPId+jq0A/Xujvbz?=
 =?us-ascii?Q?LvE2eC8fNSgx3b17karfuBfGaRUlJKHtJ89p+hH3fe5Epv+kdzhP8Laaibn6?=
 =?us-ascii?Q?gNPvp1QNfO9OyIQYgxsUGWfMyby7Cup6BYvcbWw3VivR2PDxO67ggoIsSZG7?=
 =?us-ascii?Q?t931FlxvBOxYEgpO16VG7llKPs+YDafxy16QxOorC+QDTzqBbwetEIGAwRXQ?=
 =?us-ascii?Q?9XzHOWWxp0Btrs6eqxLaJqouvmxKFChl0jUISmpXKoPou4x37fUqBcqvtNcL?=
 =?us-ascii?Q?V7NhWWI6GDCySXmORFO5LZPtsyw1r/ddXDJ8Dw+Ki9q7cb4gg+yvUrd37V4K?=
 =?us-ascii?Q?ydH0HI7C96mOAw3Ae2XrrjesWKVVa8UxZo9qiDnX/Q2Cw/PR/+2HeGRnnCZG?=
 =?us-ascii?Q?u4HxbwjHyCe4FYzqf/Fg762+8K+FNKSC1VMSemOEMq2AKm35NHQ5U0foCEv+?=
 =?us-ascii?Q?dJhHPDDAlCmUUU+yETcbjurYjpqkd9cX4070iQTKGptI+DjEs09E6vHwA0Oi?=
 =?us-ascii?Q?M8iVvN+8LWXrGu3mlwVQtFnG3NVA29zsl7TLVskCe9ja+VQMygvFH38V+cPJ?=
 =?us-ascii?Q?XJ0sWp57KejkrGGtJmnCdYfXqDNEisJMEMX8D7HQl+wXrGXKYeTxDMQVHXwv?=
 =?us-ascii?Q?PjXIukCpjQwn4esERcWNW8S2HteBxO+/CKObDDE0kSoifZ9yx1thyBGN2den?=
 =?us-ascii?Q?qXX2w=3D=3D?=
X-Microsoft-Antispam-Message-Info: 5XMXzFyOLygilyJHcxQBNvxMxhybu/6EKChk5DISLBFcMz4RewfXov6rlWinnWnen+IEFMddb91F5HfOMqDaAGdgptvWFdX8qq+4/H3n20mkLzXIxOKulUITkxVpRQwmBWC834TPhLbRYd6z2mu2aiXuXoI+Pubs/mXjHbvLn2mExcuG7IPJV8aShlJ5DRrKLlYMvsgclv070N2vXWAZB0+Yw5Rqkbh0DYSPPPTJvqN0m8DN8ZGdUAWfLwyjIs+IikjfW5mGEUMeI/2zWcHPQ55msyOaTu8OowmKfmTKF0MOdCLKAcYzCrYaUdna2L+WLEk/75LjQvuH6pNw9rkjSKjQWOGBDAyuOOiUZO937bA=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:d8zHiOddJ8sqotI3KX3j1iyMRwgAbxINBfx762lAEQmq7rZ7NKV8kT47oQyKi6OcbioLkX/hH9y5mzhRgDL3LM/L7iR4mWlv54PHAUJcdPkQA5onFB6xg8YOhKCsgBO5prK9ypsOY7pZafaNv0k0MYRyqNcPaB9n09kksfuQ24QbJrGYWTbH0k10VzESOfbqV9vb0d6qyVSQQrQdjDRrSsQ/y25lKk2Yk9lf5KqWRKF8B89i8stpp1VStIGC1ct3l0xhI26O8By7Lc91U1MLxP8kL17lK7lnaSWtcEj7pmdfQrlSRSn4jTa5zDXu8C1MiGxTjVwre3/kw6bcJprMrdEbMutQ5QC/Y5VRdGgnZTDt/xBuflSzQ8xeAkQUR0LL6RG8ZPsKJAn7JC+NRT+zUmZQiYTNP8KIP5+f5AWhiDLd0POLhUHfhtBPKh32STtS0wvtpPwzgH5bSMkwPpQaVA==;5:+7v1Js9AI9pYbY7c95lUOBmsK3PEJ208NiVwPV2Vcgy+ZMy10N7jcT9duEtAZyBwst2x2AKU5/Xp5JM3epwEjqLOnguIqo2PYyQIEnXai6vfrbXw291lShactT4v47OZj27umP1mIKe3sMdklIa2Vh+z23MQZaHOF6HbQxm6MiM=;7:58CERGHIsrKbWdajzBL6co8+0Bd1RPbx4GTCD91G/CzoNKvxBCJG+8++wtk08kth730adQn1V87uMaq1pdXduoLGVdvhEbwyyPVB/Cq2kar2Zfx0Zri9/SxrtwzGcPZr7pUS54Uq2Fzs4hokwec+puDcxQtHfc3ONngtUiukdLf2kD2yzXrVOmNbv/X81l6sHGE3IJrrrZZ+YkY2dQUSfnwIFZ0h8APo9ocQpJdX3ZSbq8OybmQQYPzHkxlDH8Sq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 21:42:18.8258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0723c158-4f80-499e-0669-08d5fd77d0e7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey & Mike,

On Thu, Aug 09, 2018 at 12:30:03AM +0300, Fancer's opinion wrote:
> Hello Mike,
> I haven't read your patch text yet. I am waiting for the subsystem
> maintainers response at least
> about the necessity to have this type of changes being merged into the
> sources (I mean
> memblock/no-bootmem alteration). If they find it pointless (although I
> would strongly disagree), then
> nothing to discuss. Otherwise we can come up with a solution.
> 
> -Sergey

I'm all for dropping bootmem.

It's too late for something this invasive in 4.19, but I'd love to get
it into 4.20.

Thanks,
    Paul

Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407B9C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDE2276CF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="npwRXuy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDE2276CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965476AbeF1Vbk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 17:31:40 -0400
Received: from mail-eopbgr690120.outbound.protection.outlook.com ([40.107.69.120]:63664
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932238AbeF1Vbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 17:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3qKqty3e6bAAPh9FFYqoyRiJcEzn6Cn4exLTSObqJE=;
 b=npwRXuy1lJb76Xm5QVlvtaWYnW2JGjirb5ezH088Whe3d2stgHVTHUHBiWFbEUzGQGa8H2Hx4s6II6bD38RuU99FTssfeIPnonbWONWD8FSd+KpIbteQtUj6b3gUD8hIC7deasNN2RgtoGnZvMXVa+hlM7dGVJOu26JNoQWAsGw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.22; Thu, 28 Jun 2018 21:31:36 +0000
Date:   Thu, 28 Jun 2018 14:31:34 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] MIPS: AR7: Normalize clk API
Message-ID: <20180628213134.5mzbcqtbb3ilvvev@pburton-laptop>
References: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
 <1528706663-20670-3-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528706663-20670-3-git-send-email-geert@linux-m68k.org>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CS1PR8401CA0030.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7503::16) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fc52cdc-b1c1-4ebe-c6ab-08d5dd3e86fe
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:f6CZtBHcsQQSjTITFP2GDz6qft7mBovXCbvIQ/dhXyROHTaKOFYSifTH0cNd/UNPvb5Gip6xs+gMEIBICkyIjf5o2oRqjOnKcwHoRAfzlv6OwWVQ3HvdnrNqykVP3XqtJ58V0Kn2CCtrwsvw5ofQQ2fcKeMJMMseSgYc+7oWa66EShdawjEEILmJs7KlMUFuDEPE+hdwDShi5Whdq8TaacMEAYHRmUSfMoWSgoSSTuJxkceCMEYKaHaQMNANH82Y;25:TIvFKA8h/AXArXhozd7WYfaKxxhF4cqUyZiqWw1h61+m3QoBqbC86Zx2Tn/cHoXAQpWUNhFym/tMy+Cd9QPnTdimUdjbh/yH8kT318CaPDVKvU3bEoOOxxN2LPXrCEzROye7xLW0cMLfyp8Bb0qs6EwEsOyxUq1wpt4COw4weHC2V36SI/g7rsO1VZ0/E6aT0Rb5tFZRJO9lAZOfKgZ7Agz2naslRUc2ZzmVfKEPDL0BW1/yLwwxDxDBcd3ULYlaN8AgAjCrKOMzMXyM8JrDEgWHW+3K9qIj02iaIV2E84RZ5kI8qndtX2SxS7RNuf78G2Zyy/N1O/UlwwsYiWqLRw==;31:3B6ZZFrJVyiWftqYdNfVVy4Cq4RgQJ8NZFUJPm+sRr/GZzTHgO5rhqWTSEiB555sUknytNSbKEVUaFSkoSJH5gPv12D77MmbVXwU7jerX7LZtDm2oFjX1VLyn/8bmtS991QPUoNEA5kkxYZQTUSKc3vCAZ4cMbXAitOVv0o7RAbZLzOmBmJ3oz4MGNbRVoqDTZBS2JSGXtPzzs2VmEsVrGWFM/qh3crdNz6duyIDavs=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:zTqGLhmfdvfYrccS/ygp6fviKXQ1brSsk86ZuCPIofFiPK/4cG1JC4fpk9TbXz+ZfyR2WP/iB2Mcp0SYL080Dh/2cUB9B7yx6SF2BfvlehTbNtz+cFOom6pKP9E1i54aqt5MJyYxSYUcwaBT9FbzTNej9JJchM3//vsajNJ97g7Uk9btKVDus9O7xNpKe0PH1iND0cDBD3N6T0nQA6Auc2JpBytI9KNM+3PBfi8SIcbTf4Kib5NAU3i3kVg/cBML;4:NCFnzuaLapsnFWbi5IfQHSjiVYkQ5APDrJnp+YaVNKWwgA2SRrH2iNliBnN3nNga2tPUBzNcaebGjlKH2NyEcXIXsB5St728dI+Dof9gHu4aw1u+sppb6nmSfwLwLe32KBqpj3CtGcwhLU9h9Si4IURU/iQIbJv3k0agO/idq5Fvv3hnkGgg+dgFlC+giDIvvExvdJAzIPOkxnsC/k5BRlNTe/s0b0uzMTcDxQ3Bm72qt7GCTSE4DNnbeiDewJviIJm8/lRwGKYGU6ENX3KAUw==
X-Microsoft-Antispam-PRVS: <BYAPR08MB4934C03B34927C48EAFF6BBEC14F0@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(136003)(346002)(376002)(396003)(39840400004)(189003)(199004)(1076002)(446003)(44832011)(50466002)(58126008)(956004)(316002)(6486002)(9686003)(486006)(11346002)(5660300001)(97736004)(68736007)(3846002)(229853002)(23726003)(6116002)(16586007)(54906003)(16526019)(186003)(105586002)(386003)(476003)(26005)(6246003)(305945005)(7736002)(106356001)(53936002)(4326008)(6496006)(25786009)(42882007)(8936002)(52116002)(76176011)(6916009)(7416002)(81166006)(76506005)(66066001)(2906002)(478600001)(8676002)(33716001)(81156014)(47776003)(33896004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:kuuUCBZOgaGtKyhDGqgsqe+v36ggcTwDpWp5ELj5i?=
 =?us-ascii?Q?IF4d16AzGGmmA2F+LA8fsG6yZiP9r4kE6ojoBvZOodaoNgkbhqNBVd6adUxL?=
 =?us-ascii?Q?9+Laaj/4ijd5Ycz0rBdBJ3tq9YTbzGkchXbxS3aTDlN5sKClT29RipdZ84PB?=
 =?us-ascii?Q?fiW8oSYg4ZDu2fNd5lfppLp4q/I3uhpsBNLcCVrrb/oLgyw6XAiXJ4/2B/5h?=
 =?us-ascii?Q?aP5czbiDCWcRRYPQbHybayUIOnwvZSIzYfpmyy7vjXWy9h7hH0xuqhNbJYDW?=
 =?us-ascii?Q?9/uKQUkaAT8uAb8GO9SwfL3cV7uKzSlTUih8yCnY8ItPDagTJvzXFtAsoaCB?=
 =?us-ascii?Q?UC6gJ3C2LSJdNc4IaR6Zekx66jHZJ/xdfn+Zu/eqki5r7cLPGq2u3RIKlvP/?=
 =?us-ascii?Q?xpMVgDgJeqBpGTlVlIEB8AgSife2bYMPO/xvNw6unjZ3trFq/H9iypNUPVOX?=
 =?us-ascii?Q?dU+6RrBUiG5s4yw68adwvVVxizd0zmwHsX3dHzEsu3xB2bPecdb20zL//ctg?=
 =?us-ascii?Q?PJbWPg6Xa34r9eW9RpxwxJdTIrG37mOMBxpuMyMyEN3yCLY5huHmJNKVhvt+?=
 =?us-ascii?Q?MEgyUXo02hICXOhmFPR3vWLRkb+j93EbjsuvXeBgDmNh1H38zKR70tSEyTRh?=
 =?us-ascii?Q?xEvrQy/PreZogLnd01mk0FDOiRIpZpVECRzuVRwql1UPtmRXNe0oMu8AZMmP?=
 =?us-ascii?Q?/WnE5oXU8+o3WmV3wsYkkCWeKOWrqodZyWKUuNQsFpAeaXWYxK8veYV7aXqy?=
 =?us-ascii?Q?ojTBzrOBQrCdhatxOQdbA6hy/NlkP8ua262ImI7nxIdIWosFDzWL0RtW+KJp?=
 =?us-ascii?Q?Q9Jmuz8sLl6JNhaP+bM3pjpY9WY95bPAhrSBi2hrU6Q3WOBBM5pJKrBpP5Z2?=
 =?us-ascii?Q?rPUUBG0JcVtENznY58DlGCZPT8heTdGk9fcf2M6yyvkYZy8bsgT9hE4zhB4b?=
 =?us-ascii?Q?n6RvwZwjG2IM47Gn9Z+2QxzqDADz7Cp6sS7EcrvjSlHpAvAauIBvVinbF1A3?=
 =?us-ascii?Q?rMy9WaMWAhF14s2hNOPksUaqpDgc1+VFzpC5j5vY2vUfTLDnVUDMca5cjgxC?=
 =?us-ascii?Q?TMz/4XTLpYbFInHXoBAzjv1vIA5rnv/cBc/kM7YrlDQPFfkU+XMWOPMJkCRu?=
 =?us-ascii?Q?Nq1gv+4kQoTN3gyGQhU1TP+wvjK2IH2j89Qgc10abvTnGNyg/JETa6KsSVst?=
 =?us-ascii?Q?hqPvJ3zowb9EKOK9/ASKNIcFFFj8V6WmTDXre78Dq+wF5CwmuIyVRT9OznjC?=
 =?us-ascii?Q?wr9BKD608tj2kuy5rDC4877qbNZa0rUhpsz0IdN1XXhHWDNwzLDfUHyQsLAc?=
 =?us-ascii?Q?w/HuqK/X7TFUO/nbcK4lfI=3D?=
X-Microsoft-Antispam-Message-Info: oP4oxrZMglLHKW73EaJ+XVwsI+SV3RtSABXg2ygjdmvm+yYlRJourl+QaM/sqSbDjwWDsK7cbvC4jWGO3Q6/UQaiyn0lhQ9Gnf0BwHhLqyFyEpg+wF6PekKgI9C5MJm6LdswLXLwLF1Gv94KGjCjDL01tUR74yBgGtDKI8ysRgN0gLayk/mRVMPJWrZAMXrH3E/AGWFoF1cg2rOhEdm4YzupzjsT0RZyFDKDEU+uyN/vaD2FgX7L3audHJcojLNuV/tvdyHhfNxwYNrQcRKTPqnk5zyLCtxvWPYfZp5j9kACYsgWqMaXRDkMpsH8bMi0pusrQ1p2qi1JHbxoOwphfvunGbe77YAL+rXNOw/YGWk=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:LXpPhRKgp74vhwFx+sIXHvEwzKEgjqwTmwL2X/AdufQXeeC9cCfqaN8HQqQn/AcQ2FF8NNEjAcyYxTSs67WEHZlZbTItO50+pHV/8ja6GUNJSGmRIsjz5taHRns4dim39Djx6JJhO+iJnK8f/aXaYsLUuq5TN2+eItquVN9RQHHhkortcC6Cs0srT3qnTYC9/HnJuO+hrpMgvC+gCvtn+9UXs2xbQ85ItFs+60BYejOi+/t453X7WykGz5bebhLrkqCjLit8t6HROdzIcLBBUBxhswq47oPyekJHVMmoHNfypaE2WQfLTfBHuyvEDq4kAYUDNXipCP7iE5Y8KucSyX4jy5eykufrY6JnlBP/TbjQQA9Ng0rQqX7f39n+rYHEzCnJZnnsnehGrzfbbNT/rq68PFo66tJof6fKsHm3VpqzvP7+5Lfy6H26xRkqECC6ejfMSQOMwUTQ9leNfJeYVA==;5:BEQY2cv177kNhtMBu1TwFeg4Bym2f95mTp8W2eCR3614/oJrDveWyhrp2wxynZ4t4m1XjplmOyS6v7MijcvBGqQZFyP/eDhGeGwGF3U6Kb3lP0xoIU3jl2gWbRWGEzcHsz++E829Ho/Dc7FYc92CghT3hfNP5w60oaTLzPJN7UM=;24:/Pkw0OD1wdimoR+YGuM35j0dxVNPZgEoRnezWxr/dCNgdCYMECEulFQ6m9WWPyDUE+QTy9rbR5jb3UJCg03EY5Cb4k4mYV9r8aLA3ZV4c2c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;7:ARq740spXzd+OhyrP1BxVZrxurxnWQQ7oo06K5uCPnPLgI7FikyuOj/+FWUq9uHAmAvqHesvTmi0ovpJ1aNSthiR6uF5LWwEC2exQcadWt9X4mwmmWZwFFhiDizUED9Lj/3REyoOmY95tpS6G7G07n9uJHwt8aszxAuWBYazfQB9J+x+f1zNRyv9gcJgn1iWhlkjqLYq0ClnBpHgBUcW3gUiaySnf0+DhsRClLM/a44ctIEDithSBnBMX+dGyBBW
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 21:31:36.3785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc52cdc-b1c1-4ebe-c6ab-08d5dd3e86fe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Mon, Jun 11, 2018 at 10:44:22AM +0200, Geert Uytterhoeven wrote:
> Coldfire still provides its own variant of the clk API rather than using
> the generic COMMON_CLK API.  This generally works, but it causes some
> link errors with drivers using the clk_round_rate(), clk_set_rate(),
> clk_set_parent(), or clk_get_parent() functions when a platform lacks
> those interfaces.
> 
> This adds empty stub implementations for each of them, and I don't even
> try to do something useful here but instead just print a WARN() message
> to make it obvious what is going on if they ever end up being called.
> 
> The drivers that call these won't be used on these platforms (otherwise
> we'd get a link error today), so the added code is harmless bloat and
> will warn about accidental use.
> 
> Based on commit bd7fefe1f06ca6cc ("ARM: w90x900: normalize clk API").
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  arch/mips/ar7/clock.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Applied to mips-next for 4.19.

Thanks,
    Paul

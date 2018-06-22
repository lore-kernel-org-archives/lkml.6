Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F65C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258BB24054
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Ovqx4UiM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="MeKPofoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258BB24054
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933414AbeFVKZS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:25:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40460 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751274AbeFVKZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:25:15 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MAO1r3001995;
        Fri, 22 Jun 2018 03:24:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=LVlJmEaBMkpdraOOU9WpoRHTyC9HBLKyCGDhE9n0gxU=;
 b=Ovqx4UiM5zTx+eH0l1fw5bxydomu+K6qcZLA3TTTVM5QQMDhQJcqfAoVYiul6Z9sZ4NZ
 kMVFsQu+L6i9K4tar4aIVnfwR/MbGlMn2vfXcUEgk533Eh3NftgoYoKnD0pZpXuKRU3e
 tVwVKSNJ+dd19roUpkDUE5jOI5MSHYKFMqI= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jrp8s93hy-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 22 Jun 2018 03:24:51 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.29) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 22 Jun 2018 06:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVlJmEaBMkpdraOOU9WpoRHTyC9HBLKyCGDhE9n0gxU=;
 b=MeKPofoSAnndDw5eFIORW94XSjf1VAboh771QVRqB3x9yEgqvirL7kCdKYQmFzZhs+Cw1pJNtG48cdwL3pdBitNDUSWX54mrvSh1towUBqWxaa4oYqOHsZFL3Kv1lig+v+svTVCTtvebKPJoVsrCaKW5lWzNXOXOdmFqegnUKkE=
Received: from w1t1fb (2620:10d:c092:200::1:a89f) by
 DM6PR15MB2507.namprd15.prod.outlook.com (2603:10b6:5:8e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Fri, 22 Jun 2018 10:24:45 +0000
Date:   Fri, 22 Jun 2018 11:24:29 +0100
From:   Okash Khawaja <osk@fb.com>
To:     Quentin Monnet <quentin.monnet@netronome.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180622102428.GA3050@w1t1fb>
References: <20180620203051.223156973@fb.com>
 <20180620203703.101156292@fb.com>
 <3db6047a-101a-2ed1-9ca3-9e90b45ea00f@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3db6047a-101a-2ed1-9ca3-9e90b45ea00f@netronome.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [2620:10d:c092:200::1:a89f]
X-ClientProxiedBy: AM6PR0402CA0031.eurprd04.prod.outlook.com
 (2603:10a6:209::44) To DM6PR15MB2507.namprd15.prod.outlook.com
 (2603:10b6:5:8e::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5daea6a2-b449-4085-d4e4-08d5d82a6106
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR15MB2507;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2507;3:SBiBfjixUHR2yx2EIsO6cv+tPfnck/Xfez4BdEdGV/CKOWpXmT0X3xJndqm29q/WmaL42SVBjYvUt41iG3YKu5J6eXllBrf8RSJBXNXuq6Ge48gKOwkP0THrPuRydcId0XK6JmgstwYgvG+A/AATWvKR89RV3xylrPR2i9xCVSVGI8gt/46qRuAITpoPPRdCtaNODhgOEEq8bwOQHVXt+fBOHdn7EeA36OmMwDkTq5QTo254zV/5vavzV7QZforp;25:2yPn6GeDiSlvoECsHXyeTXHsgeglmBHpW4bmDb5SpPe1WP3mozH+1pEBXkiZdZXe8jIUPmKA85srgH03gV4BuNbJ32iThapwr/3x4Lunt3mZdEjVZTSnxVfrFGnY44teLqOwxjKPWYbdmJ4TNay4EHySUhHa91KGz4krV6UDWYeL9xfhVqg76bVIB7P14lAL097eRnwzeSQpINqjlzSQ55RjoMNbQbfQwkfJvQSIqEIHx6YYfadHiQh6XpNrMYpH6OdCGQHQsW9hnX/okdkjX+iORj4VFbIRL6KODBpeNXI/If+1vcWU8Etf4amJIxiGTZmW/EfDJ2dEHXTOILmR4A==;31:xwmXc/T77mHhQFV/tpfy0c7qoszKEPMoMRWQnRw6hy3JEl+Z/SsEDMbQFlLZKgGKw1UJckRRDJrDxK9R9D0BAQyMDeaz7HlSuoHvBhhGRM1S6BEv0o3iowfD9ydO7m7NWzZn1X0TyQpbd85Tm3Tu8doHZy15kWhNb+vabCDJmTgsXxNpxI5pFkonaG8PgjRoSMT1oopPx0aWsKYeAiOM1Pg0cdGyEA+tt8RRlaaS6/Q=
X-MS-TrafficTypeDiagnostic: DM6PR15MB2507:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2507;20:g9erOHNOtNWt6rsCtYWy+udTB0mCCtIbxa41dc8U6CzvlWYZ1tRu9SHv5hANDR1wll9m2wq5apaOewrzKy9qfkPVs7+dQdVQSOwHH2PByZGTSLCiM3X+OLVSaOn/vBDDFMH/EtliYDmr5M95zOX+TinmgMINBXTODI1iHp7FVhFAXQwozd0Ee5WYtNsz9t47wlqmGBUzoP6Oofi1YbBRA4j57dZjGuFSLH9TnpwQUXpuAOEE03AywlpTcNBQJKEaM7NJ4eAqno3P3KdL26M5+7dNPW/l/CO78hp+wZhUZM35u5IDhoscqv0cHLyVcDd56FK2GqG74OaAP7lUjEYcZZyJUubROXPmD24UfklKO+6R8Et9lE6MNESniGNNqKjmDy7/a0Vl9Wj4aEnV43Tfz+66bdcz76PPoEw2HiyKgG7hOQzyypAqS+SwSjQyrXz5bGnIPqnItngACFdEVVIJqx/b5zqhHoN0sGCI995p3yfr2Xegd1Io+IrMoIpGT4tZ;4:667QOBEuullhgdobk7mxS4mROmKclbGDtpewESN1NFvdTMGGB7dRgVzpiToW7yfcb634g89IDn7D3MpUtsm1/5zB+U8fO8ySd1UmI7BBHsWdEdgN/SIbHTYbFg6V76BTtGPPpP+LIadVV1MPWyFm5pMOFSksbDApyR5LYzMpXJqUmqQaNYdyOgpDH049L3yzXyWVK3uiIWI1t7osA3P5tsYiXC2T1745Q0BOXtXGLlleRsfZZaqr0TPSCKR/BAXBJNEGSG+JLZKwK4N9kg9fjfgGMpvplgQJtH+0khjLsSl6Tw7NR4TdIcCfwom1NGKG0N+9gImP6Rnbl4UjjFdkANYchdG6duwb5ttgZTGnELU=
X-Microsoft-Antispam-PRVS: <DM6PR15MB2507748C421EDAD57382302BC6750@DM6PR15MB2507.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(81227570615382);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR15MB2507;BCL:0;PCL:0;RULEID:;SRVR:DM6PR15MB2507;
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(346002)(39860400002)(39380400002)(189003)(199004)(33716001)(25786009)(7736002)(39060400002)(6916009)(6666003)(5660300001)(486006)(4326008)(33656002)(305945005)(478600001)(8676002)(9686003)(53936002)(16526019)(81166006)(54906003)(68736007)(81156014)(11346002)(6246003)(47776003)(50466002)(86362001)(229853002)(6496006)(476003)(52396003)(52116002)(76176011)(446003)(386003)(33896004)(316002)(58126008)(8936002)(59450400001)(186003)(55016002)(2906002)(97736004)(23726003)(106356001)(16586007)(46003)(105586002)(6116002)(1076002)(18370500001)(42262002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB2507;H:w1t1fb;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR15MB2507;23:XHIJp7499kfFss0pF2M2+mhAv15gymzmzgWDqHBfe?=
 =?us-ascii?Q?gYwv4V5SSFz/s6gpFtASpUHzmj/hFp+ov7vU8yk43MjMrRM/cbKzEPX+bKhh?=
 =?us-ascii?Q?mC+xsU0dF+nE4/uASj3E1beQp+o1HqvLrSI0jjlwF11wDdHPNa89+4ENOAis?=
 =?us-ascii?Q?U6znpyExheq9zVUUKCeBmftVsLzw4X6slBWXuXFk8Q1zXDyW/rlbNiSP9bBp?=
 =?us-ascii?Q?UwdxtzjXprYFP/3AmZOETqxlstJwVb8b4Wr/NYxEm3OIitAvP1K+855MwPnv?=
 =?us-ascii?Q?iWDjZvCcAD8Mafjv0QPZCC1bx/UCfAxryf87lZAwHrOI+B72spXAfeMC+I5z?=
 =?us-ascii?Q?FQA8VnE4cD5cVVHgrD7Tr+H0EtkXfQpoEj8w2PDQxNcaCTvzFCo/AP1QN3P3?=
 =?us-ascii?Q?7L2/HI1VVJW7J16Op0POaGhTAM2aVOtF96Q5HLt+Sad3RpbTkCbDuTGqol7h?=
 =?us-ascii?Q?F3jSpo1n64SSyy4Fxr+cj1SHg3RM67O/PQblS4qVi27Q+oMHJqZ+U7OPTil3?=
 =?us-ascii?Q?7vD3I3JZDs56k3GEIkhQjcl7MrErrdFADsjewDJzVUt5AjN2FGWvVIUgtTrQ?=
 =?us-ascii?Q?6Y1MvOBcw7N0AHQoCiSGAKRsqY6L3AgxIsfcuTjCs34mE+rDRZkQJ1vdXxjI?=
 =?us-ascii?Q?UAQsYs91WyRBm36zaNQ2z6m5ipvrvM8L3U9Yht9pxCbgnLlL728I6jHhaH5M?=
 =?us-ascii?Q?Jutrq93VEk07/cDQ2p/J0VjVbFo1VeUjFzGCZuNkmT6qwvgKgFrgY4F0YkBd?=
 =?us-ascii?Q?8anAOxOhAmpoWVn4DoIv5fQbG1sxnMraP8P7Lt+8aI4ihFz8KrNUyVHrH5l/?=
 =?us-ascii?Q?gldcQYyncuJKwLLnYGMJawfeDOgPnV5to1dY1g/DDCmjos87DRTXkE9bPV9C?=
 =?us-ascii?Q?AG5SOnFYfgWvuS/PCDAWSLdxchVIjncWCubQIjkpwN5SMxyQ2/ADKG+pN5PO?=
 =?us-ascii?Q?Iuowz/Ki53sdUUmdluSgKhJFVa1UazfxvgQ9VutKI3DCNSQQGaus8a9Y6Q52?=
 =?us-ascii?Q?7FftebHawZDfQ9HOMJRebiKJEgaHxWEwyYwRXJbEXYXsB+X1aWiysAHjlPUO?=
 =?us-ascii?Q?Bmivot9d68NLnWfd5nRQDe9mk1jouafbZzHdz6OzUYkQUiCweVomHMiK76UU?=
 =?us-ascii?Q?CYdEzZFMSgocdS8v0Q8Vr9d71SYfayRUnPgnAJsn6Oy8mnvlmOFjODPa9zt9?=
 =?us-ascii?Q?Z008vXcJy8bFXZqpqMXOWxPzxo9qpuiUqH2a7G/OZfXyV8/pxjCZ5uJnXo+E?=
 =?us-ascii?Q?2VS8KHewslxHwBUFOuUm+obSfWGXWWLiMhm2Wqs+kdyxx22rrz94eVi/ivia?=
 =?us-ascii?Q?eqyidd5DLzH8cYl0ZdkdVjjKvES2Mb2E5go4LEIarGf3amNjv6cGdgSrpKU4?=
 =?us-ascii?Q?ktTww=3D=3D?=
X-Microsoft-Antispam-Message-Info: g1fpQmQK5CbkdJBeBGObXBrqg1sIFeOSqDJd0GU7pj5EefJS7CTtu1+b8HZ+i2cvEAHz4FjOwj+Yux+m/IWQx+nvrFv1bDoK8s0FWNGUEI0nzvy0gL7pai9y5Rx7O03K5rQyYOF8iTx8FO2F9N7LLXZALXzZi0FUH5pdy3EelAcO2aQG0eO+YCXbc6TVDLttj+TCf2t7+aTdgp+FwvBZzw3iN76bk43C5ot3gyZ9Y/D7vq171vF4j0hfqhCKXDJ+dZE6v7gtxXx+tDJkgKAVSwk4Kz+DCzjnHb24EgZcztqdF0jgziX0UgMEth6WInHBwQ126MgAfngdUcIjCq5Njg==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2507;6:2simwjxvuQpaHPnYGXx63j9qMwAYCYlKXtw0g3xiZopxWKL+nhUHbUBFosWaRxiwXQD5FWvtdVXk9/IfawyAJwMgdDPEE/moXSUZMe5WWSnFxMtaGzyPfZ9+kmrN50Nv8QGSzpg8VVMPiqcNmMWT1/Idi6QtE/yQd7OCl6QKUankEaFoqVptRpdzJUJmXS6aK1FTZDd8oIdqXc3J0ewdx4pPdTU+fJnErDJHYZG6mIftPgf4l6YvudN4QABTQhg8YoIIqyOTfvPQ2WL1Orh62BgmvdbDpkLbThZUP0wZ2UNCNkTNfpr4gI6twUyO5kZOnNnDrf1Qks2oZIGiuwVBIPrK6n1PR7QBhGj2shw5VBeEJlFKBf2VgY2lc6TsaWps44ieMayf06bIuQ64RYglCh/b5qNwpL/TefwQD79c0R0onPFSPqhDHamlKEgrXGWYYG5+WSqZXJ8/UkLuPYo6Og==;5:W1rh9xcZV7F3bPzk8+TICTEqyowoXWaml+sBt+aQz/g+1L6XPschq4GYAya6JQh8AmtHAqhAihX3MS9D8yvojVjBXGUuzuHTxY0tqwT+IgNqi6C3ToK2PtH3ow0MN/24qWmaJFwnD16RQpL8a4qJkgGfYKbA9LT7rTUZEkXuSPo=;24:p9iTyF3D+LONaRm+YwDSu6U4UENBWykim+Tj3UfDkBdCzZNSlzYxWrmxmY7fJXJEB79rvrZ7speppKBfKg9zDjvc9SzMoX4rKQVwdNY0cb8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2507;7:EuLQ5JTr25OHsYit3UTIDnKNl/8qsjHoXFCIfucfX5EVTcSfnNHKjFFLYK7Vwex8IccHKPgaeS2VrneU/iMLoC+GjL3FYNVPtOwmZRr5KhV3BnStB6Cy2HF7rS+gk7TKoDfFL9vCV+mDxgovC21Bk5RG495C9paYD2ouEyuvAcpoCEMOFiAQmtFUAQJKPNk3KLk+pDTaUu4D7Cv98fWyoF47o2gB6Sv4VzLeFGwHqqDEK79OpoQ4kEM+w/0YZm2D;20:uI3sk3ICsYcMHdpKqIhZBbWMLc+sEnzcATuWXgMWPC5D2us2jDPzK9E/Xp39bxPf8bV+isrQumL5xSRxDKdIk+fn/6QWH6IbJ1bY+Oj+/w7g7qL2ckxnik437niRLJn83cetKTbZ4H+odTZ+620EDZaG0lBsAxqMqZ31cDi06jY=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 10:24:45.4535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5daea6a2-b449-4085-d4e4-08d5d82a6106
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2507
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 11:42:59AM +0100, Quentin Monnet wrote:
> Hi Okash,
hi and sorry about delay in responding. the email got routed to
incorrect folder.
> 
> 2018-06-20 13:30 UTC-0700 ~ Okash Khawaja <osk@fb.com>
> > This consumes functionality exported in the previous patch. It does the
> > main job of printing with BTF data. This is used in the following patch
> > to provide a more readable output of a map's dump. It relies on
> > json_writer to do json printing. Below is sample output where map keys
> > are ints and values are of type struct A:
> > 
> > typedef int int_type;
> > enum E {
> >         E0,
> >         E1,
> > };
> > 
> > struct B {
> >         int x;
> >         int y;
> > };
> > 
> > struct A {
> >         int m;
> >         unsigned long long n;
> >         char o;
> >         int p[8];
> >         int q[4][8];
> >         enum E r;
> >         void *s;
> >         struct B t;
> >         const int u;
> >         int_type v;
> >         unsigned int w1: 3;
> >         unsigned int w2: 3;
> > };
> > 
> > $ sudo bpftool map dump -p id 14
> > [{
> >         "key": 0
> >     },{
> >         "value": {
> >             "m": 1,
> >             "n": 2,
> >             "o": "c",
> >             "p": [15,16,17,18,15,16,17,18
> >             ],
> >             "q": [[25,26,27,28,25,26,27,28
> >                 ],[35,36,37,38,35,36,37,38
> >                 ],[45,46,47,48,45,46,47,48
> >                 ],[55,56,57,58,55,56,57,58
> >                 ]
> >             ],
> >             "r": 1,
> >             "s": 0x7ffff6f70568,
> 
> Hexadecimal values, without quotes, are not valid JSON. Please stick to
> decimal values.
ah sorry, i used a buggy json validator. this should be a quick fix.
which would be better:  pointers be output hex strings or integers?

> 
> >             "t": {
> >                 "x": 5,
> >                 "y": 10
> >             },
> >             "u": 100,
> >             "v": 20,
> >             "w1": 0x7,
> >             "w2": 0x3
> >         }
> >     }
> > ]
> > 
> > This patch uses json's {} and [] to imply struct/union and array. More
> > explicit information can be added later. For example, a command line
> > option can be introduced to print whether a key or value is struct
> > or union, name of a struct etc. This will however come at the expense
> > of duplicating info when, for example, printing an array of structs.
> > enums are printed as ints without their names.
> > 
> > Signed-off-by: Okash Khawaja <osk@fb.com>
> > Acked-by: Martin KaFai Lau <kafai@fb.com>
> > 
> > ---
> >  tools/bpf/bpftool/btf_dumper.c |  247 +++++++++++++++++++++++++++++++++++++++++
> >  tools/bpf/bpftool/btf_dumper.h |   18 ++
> >  2 files changed, 265 insertions(+)
> > 
> > --- /dev/null
> > +++ b/tools/bpf/bpftool/btf_dumper.c
> > @@ -0,0 +1,247 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (c) 2018 Facebook */
> > +
> > +#include <linux/btf.h>
> > +#include <linux/err.h>
> > +#include <stdio.h> /* for (FILE *) used by json_writer */
> > +#include <linux/bitops.h>
> > +#include <string.h>
> > +#include <ctype.h>
> > +
> > +#include "btf.h"
> > +#include "json_writer.h"
> > +
> > +#define BITS_PER_BYTE_MASK (BITS_PER_BYTE - 1)
> > +#define BITS_PER_BYTE_MASKED(bits) ((bits) & BITS_PER_BYTE_MASK)
> > +#define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
> > +#define BITS_ROUNDUP_BYTES(bits) \
> > +	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
> > +
> > +static int btf_dumper_do_type(const struct btf *btf, uint32_t type_id,
> > +		uint8_t bit_offset, const void *data, json_writer_t *jw);
> > +
> > +static void btf_dumper_ptr(const void *data, json_writer_t *jw)
> > +{
> > +	jsonw_printf(jw, "%p", *((uintptr_t *)data));
> > +}
> > +
> > +static int btf_dumper_modifier(const struct btf *btf, uint32_t type_id,
> > +		const void *data, json_writer_t *jw)
> > +{
> > +	int32_t actual_type_id = btf__resolve_type(btf, type_id);
> > +	int ret;
> > +
> > +	if (actual_type_id < 0)
> > +		return actual_type_id;
> > +
> > +	ret = btf_dumper_do_type(btf, actual_type_id, 0, data, jw);
> > +
> > +	return ret;
> > +}
> > +
> > +static void btf_dumper_enum(const void *data, json_writer_t *jw)
> > +{
> > +	jsonw_printf(jw, "%d", *((int32_t *)data));
> > +}
> > +
> > +static int btf_dumper_array(const struct btf *btf, uint32_t type_id,
> > +		const void *data, json_writer_t *jw)
> > +{
> > +	const struct btf_type *t = btf__type_by_id(btf, type_id);
> > +	struct btf_array *arr = (struct btf_array *)(t + 1);
> > +	int64_t elem_size;
> > +	uint32_t i;
> > +	int ret;
> > +
> > +	elem_size = btf__resolve_size(btf, arr->type);
> > +	if (elem_size < 0)
> > +		return elem_size;
> > +
> > +	jsonw_start_array(jw);
> > +	for (i = 0; i < arr->nelems; i++) {
> > +		ret = btf_dumper_do_type(btf, arr->type, 0,
> > +				data + (i * elem_size), jw);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	jsonw_end_array(jw);
> > +
> > +	return 0;
> > +}
> > +
> > +static void btf_dumper_int_bits(uint32_t int_type, uint8_t bit_offset,
> > +		const void *data, json_writer_t *jw)
> > +{
> > +	uint16_t total_bits_offset;
> > +	uint32_t bits = BTF_INT_BITS(int_type);
> 
> Nit: Please use reverse-Christmas-tree here.
> 
> As for patch 3 you also have a number of continuation lines not aligned
> on the opening parenthesis from the first line, throughout the patch
> (please consider running checkpatch in "--strict" mode for the list).
i didn't use "--strict". that would explain style mismatch. will fix
that in v2.

> 
> > +	uint16_t bytes_to_copy;
> > +	uint16_t bits_to_copy;
> > +	uint8_t upper_bits;
> > +	union {
> > +		uint64_t u64_num;
> > +		uint8_t u8_nums[8];
> > +	} print_num;
> > +
> > +	total_bits_offset = bit_offset + BTF_INT_OFFSET(int_type);
> > +	data += BITS_ROUNDDOWN_BYTES(total_bits_offset);
> > +	bit_offset = BITS_PER_BYTE_MASKED(total_bits_offset);
> > +	bits_to_copy = bits + bit_offset;
> > +	bytes_to_copy = BITS_ROUNDUP_BYTES(bits_to_copy);
> > +
> > +	print_num.u64_num = 0;
> > +	memcpy(&print_num.u64_num, data, bytes_to_copy);
> > +
> > +	upper_bits = BITS_PER_BYTE_MASKED(bits_to_copy);
> > +	if (upper_bits) {
> > +		uint8_t mask = (1 << upper_bits) - 1;
> > +
> > +		print_num.u8_nums[bytes_to_copy - 1] &= mask;
> > +	}
> > +
> > +	print_num.u64_num >>= bit_offset;
> > +
> > +	jsonw_printf(jw, "0x%llx", print_num.u64_num);
> > +}
> > +
> > +static int btf_dumper_int(const struct btf_type *t, uint8_t bit_offset,
> > +		const void *data, json_writer_t *jw)
> > +{
> > +	uint32_t *int_type = (uint32_t *)(t + 1);
> > +	uint32_t bits = BTF_INT_BITS(*int_type);
> > +	int ret = 0;
> > +
> > +	/* if this is bit field */
> > +	if (bit_offset || BTF_INT_OFFSET(*int_type) ||
> > +			BITS_PER_BYTE_MASKED(bits)) {
> > +		btf_dumper_int_bits(*int_type, bit_offset, data, jw);
> > +		return ret;
> > +	}
> > +
> > +	switch (BTF_INT_ENCODING(*int_type)) {
> > +	case 0:
> > +		if (BTF_INT_BITS(*int_type) == 64)
> > +			jsonw_printf(jw, "%lu", *((uint64_t *)data));
> > +		else if (BTF_INT_BITS(*int_type) == 32)
> > +			jsonw_printf(jw, "%u", *((uint32_t *)data));
> > +		else if (BTF_INT_BITS(*int_type) == 16)
> > +			jsonw_printf(jw, "%hu", *((uint16_t *)data));
> > +		else if (BTF_INT_BITS(*int_type) == 8)
> > +			jsonw_printf(jw, "%hhu", *((uint8_t *)data));
> > +		else
> > +			btf_dumper_int_bits(*int_type, bit_offset, data, jw);
> > +		break;
> > +	case BTF_INT_SIGNED:
> > +		if (BTF_INT_BITS(*int_type) == 64)
> > +			jsonw_printf(jw, "%ld", *((int64_t *)data));
> > +		else if (BTF_INT_BITS(*int_type) == 32)
> > +			jsonw_printf(jw, "%d", *((int32_t *)data));
> > +		else if (BTF_INT_BITS(*int_type) ==  16)
> > +			jsonw_printf(jw, "%hd", *((int16_t *)data));
> > +		else if (BTF_INT_BITS(*int_type) ==  8)
> > +			jsonw_printf(jw, "%hhd", *((int8_t *)data));
> > +		else
> > +			btf_dumper_int_bits(*int_type, bit_offset, data, jw);
> > +		break;
> > +	case BTF_INT_CHAR:
> > +		if (*((char *)data) == '\0')
> > +			jsonw_null(jw);
> > +		else if (isprint(*((char *)data)))
> > +			jsonw_printf(jw, "\"%c\"", *((char *)data));
> > +		else
> > +			jsonw_printf(jw, "%hhx", *((char *)data));
> > +		break;
> > +	case BTF_INT_BOOL:
> > +		jsonw_bool(jw, *((int *)data));
> > +		break;
> > +	default:
> > +		/* shouldn't happen */
> > +		ret = -EINVAL;
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int btf_dumper_struct(const struct btf *btf, uint32_t type_id,
> > +		const void *data, json_writer_t *jw)
> > +{
> > +	const struct btf_type *t = btf__type_by_id(btf, type_id);
> > +	struct btf_member *m;
> > +	int ret = 0;
> > +	int i, vlen;
> > +
> > +	if (t == NULL)
> > +		return -EINVAL;
> > +
> > +	vlen = BTF_INFO_VLEN(t->info);
> > +	jsonw_start_object(jw);
> > +	m = (struct btf_member *)(t + 1);
> > +
> > +	for (i = 0; i < vlen; i++) {
> > +		jsonw_name(jw, btf__name_by_offset(btf, m[i].name_off));
> > +		ret = btf_dumper_do_type(btf, m[i].type,
> > +				BITS_PER_BYTE_MASKED(m[i].offset),
> > +				data + BITS_ROUNDDOWN_BYTES(m[i].offset), jw);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	jsonw_end_object(jw);
> > +
> > +	return 0;
> > +}
> > +
> > +static int btf_dumper_do_type(const struct btf *btf, uint32_t type_id,
> > +		uint8_t bit_offset, const void *data, json_writer_t *jw)
> > +{
> > +	const struct btf_type *t = btf__type_by_id(btf, type_id);
> > +	int ret = 0;
> > +
> > +	switch (BTF_INFO_KIND(t->info)) {
> > +	case BTF_KIND_INT:
> > +		ret = btf_dumper_int(t, bit_offset, data, jw);
> > +		break;
> > +	case BTF_KIND_STRUCT:
> > +	case BTF_KIND_UNION:
> > +		ret = btf_dumper_struct(btf, type_id, data, jw);
> > +		break;
> > +	case BTF_KIND_ARRAY:
> > +		ret = btf_dumper_array(btf, type_id, data, jw);
> > +		break;
> > +	case BTF_KIND_ENUM:
> > +		btf_dumper_enum(data, jw);
> > +		break;
> > +	case BTF_KIND_PTR:
> > +		btf_dumper_ptr(data, jw);
> > +		break;
> > +	case BTF_KIND_UNKN:
> > +		jsonw_printf(jw, "(unknown)");
> > +		break;
> > +	case BTF_KIND_FWD:
> > +		/* map key or value can't be forward */
> > +		ret = -EINVAL;
> > +		break;
> > +	case BTF_KIND_TYPEDEF:
> > +	case BTF_KIND_VOLATILE:
> > +	case BTF_KIND_CONST:
> > +	case BTF_KIND_RESTRICT:
> > +		ret = btf_dumper_modifier(btf, type_id, data, jw);
> > +		break;
> > +	default:
> > +		jsonw_printf(jw, "(unsupported-kind");
> > +		ret = -EINVAL;
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +int32_t btf_dumper_type(const struct btf *btf, json_writer_t *jw,
> > +		uint32_t type_id, const void *data)
> > +{
> > +	if (!jw)
> > +		return -EINVAL;
> > +
> > +	return btf_dumper_do_type(btf, type_id, 0, data, jw);
> > +}
> > --- /dev/null
> > +++ b/tools/bpf/bpftool/btf_dumper.h
> > @@ -0,0 +1,18 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> 
> I believe SPDX tag in header files should use C++ style comments (//)?
okay i will verify and fix that.

> 
> > +/* Copyright (c) 2018 Facebook */
> > +
> > +#ifndef BTF_DUMPER_H
> > +#define BTF_DUMPER_H
> > +
> > +/* btf_dumper_type - json print data along with type information
> > + * @btf: btf instance initialised via btf__new()
> > + * @jw: json writer used for printing
> > + * @type_id: index in btf->types array. this points to the type to be dumped
> > + * @data: pointer the actual data, i.e. the values to be printed
> > + *
> > + * Returns zero on success and negative error code otherwise
> > + */
> > +int32_t btf_dumper_type(const struct btf *btf, json_writer_t *jw,
> > +		uint32_t type_id, void *data);
> > +
> > +#endif
> > 
> 
> Thanks,
> Quentin

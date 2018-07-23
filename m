Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FAEECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5587220779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="TO/lu6PU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5587220779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388995AbeGWSEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:04:16 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:12096
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388942AbeGWSEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAC3rZCBMAXWR4KoUBKmC8emZSuG5BCmG0ht3H65l9k=;
 b=TO/lu6PU5HGHjK4NLxZ4tHZCg4NX6g5ai9M4dAz1sf4/3vMf06SyE4gaOpPN6qqUopszUdMEJoF7LiTJu5+IZ1KQsyL2vIICphhb5hSQBDQkQZh0bDRNEuv9cbgo3WEFPGjsF8L95ASERYH9gHRA41zjItCenWFUAA6TkhRa1dE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from localhost (213.57.183.250) by
 DB6PR0501MB2694.eurprd05.prod.outlook.com (2603:10a6:4:81::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Mon, 23 Jul 2018 17:01:55 +0000
Date:   Mon, 23 Jul 2018 19:51:10 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     "Ofer Levi(SW)" <oferle@mellanox.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Meir Lichtinger <meirl@mellanox.com>
Subject: Re: arch/arc/ allmodconfig
Message-ID: <20180723165110.GR3189@mtr-leonro.mtl.com>
References: <e074d0ae-6d79-d21a-2278-15d516bb943e@infradead.org>
 <C2D7FE5348E1B147BCA15975FBA23075012B0724EB@US01WEMBX2.internal.synopsys.com>
 <AM0PR05MB42600653CF591791731CCCD8DA510@AM0PR05MB4260.eurprd05.prod.outlook.com>
 <DB6PR05MB4597A63819F227B17652B5B2B2560@DB6PR05MB4597.eurprd05.prod.outlook.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B07F319@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B07F319@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [213.57.183.250]
X-ClientProxiedBy: LO2P265CA0119.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::35) To DB6PR0501MB2694.eurprd05.prod.outlook.com
 (2603:10a6:4:81::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c9d0daa-8e79-4be3-2a19-08d5f0bdff08
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0501MB2694;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2694;3:/FalaOof0lx7UyRpty0/IbUhCg1sS0LwRgPD0s5YBn8x5zLw6uGD8IY75BPMFOMGV3kh0Rh/w4Y3sjNu488XFbjKEOq4bX0UbOh3QShjicFiI6H9dNNBGvpnUwZ+Pl2Y0swhaKKs0g4C0vJXOVJ1Ddpg5rhQst2eQMo7bv918ij/qHgWivkQIgnIJaKtT4dQdouTC4wiEIA+/6F+0sP50m34bjNdq5fuTVlrmzj5/IB+8+FuHzLTfUou+nuCF3oz;25:Y3wQmeIRkhb+bxPsZLwMQ5szS2UVZBh9kxJHyfsd3mJndT1cZzhYtn5L/uN57yuFf97/g5GvKVocy3VUhs0GsTeHG+9FUlQvfwrYDBJ8PiInmyvTn5bt6NWdxGcK/i0uM1+yVlER/m47Y0HJfPtF0U1B7MISgUizc/i79LA2SFawpDuuTPU+lVLpmdQ0thkU46rXJ0JPwbyIOgecTl8PguRABOP9HG3uOouV3ybHOBdLoOyyOZOIlFtD/9rUiI4X26DPWGxlGFFzPaeaOhUFeHbJb3kUqwczWj4vwSMPrPXKnUDxZt4R31Rg7ZK+k3U71vVGiBVs1dE7mipRijh4JQ==;31:mXpnYWwgk7hohfWeWK1aaUOcvvJfDDLMn0t8/s6chKzbCWZVUppjahJcksFPLwcr6TTgGpeyaOLM17RlChA5Z9AGBALy2Zt0KvlZKlM+w/XGAKw/sPArXbaSBMnQaY/s9NtvBpLnbIeCtJWDIhzKRQKg9Oe/6EEQmFwz8RI69hGUppGIYQbjvOpT1gMMpIUGv5FWv9wj2hNC6ANe4/uoujVyw1F/Nr6WY6Ss+Ybiy80=
X-MS-TrafficTypeDiagnostic: DB6PR0501MB2694:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2694;20:GvpBiIKpnZV7kYs+ZqUd27YvHVdg90xAdOjkhK+xeHwFwN9ElDCYL88nVUaM/rHwdk6YcG91A/f6aduAwKPrvvWq/NOzSW4rYZu1prqiavbo1XzLBuiaWm5EuMupwG+6kxIBVeFxOhiZxxRNZmfBEOIYeX546rQzERUSzxhXiLB1PKayYQmVOHKpvlmB7N5wKfGrIsxCeymW7eYAuHl/RV0phYeD4VAoIGPM57yiHgFCktQp92XzBOIrGKUKbbjYXsI0gdG0GLP0IF53srWi6N7B6lhtYpbRCtYRl+Hg2h34vuOxRYpLSOo/5nBcznLqf6FVHElfFja/hGWRRCEv1CSS+ocHG6CgPpT/1IDzwicMUiOaTBzhNWwbw3yOEUNn6/P3Ydc8oQZuQSWs6GxeiPh5rafew0am+sc9SDmTslAQRKUn2wN0KkZclMhS+JO68ScfaGq9caxGGa7xojPLghqIX85Q14XMF5knYelvVqJKbQHvpgbFO/vjD+773NCr;4:LpRerTf8CAHeOc7UmWI8kkAihUnt611pmZZWvjiVW2C7uIRduDgi+URanUrFNdUu5QhJi4fHXx8xC/PS+splDweZdTn+MjZtBIbsEyRVM6koATHfAJJYYMAUauUvZssttvql8d3JgiO2sZPpXL0yzUwnJYEdGLYLfxz/DDyGzfBTTHQ2FBK0l7ZwIv0/eh1OaNh0sw7Hj5YoUe+ACEXbn2z5qJCBqTj5e9VixK90FAUDRjXPLG2/qfVN68Tt0zCPobPSjwB34kUBO+xMhI6aX7uJNJYMKuW0LjFN0SS8ylPGqp2ZmgxEN1TcumKnerPI/h+wacyzDzTr8ZCWL/xj/6sg2B4bwkWf5pjD9CjWBq4=
X-Microsoft-Antispam-PRVS: <DB6PR0501MB269452F2517891EE2E889041B0560@DB6PR0501MB2694.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(258649278758335);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0501MB2694;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0501MB2694;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(39860400002)(346002)(376002)(366004)(136003)(43544003)(189003)(199004)(13464003)(54534003)(97736004)(107886003)(53936002)(66066001)(47776003)(2906002)(229853002)(76506005)(105586002)(58126008)(16586007)(86362001)(54906003)(6246003)(106356001)(50466002)(6486002)(81156014)(8676002)(305945005)(5660300001)(6916009)(8936002)(6666003)(81166006)(7736002)(26005)(25786009)(1076002)(68736007)(23726003)(6116002)(33656002)(3846002)(9686003)(33896004)(446003)(4326008)(478600001)(76176011)(386003)(53546011)(6496006)(14444005)(956004)(93886005)(16526019)(476003)(186003)(316002)(11346002)(486006)(52116002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2694;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0501MB2694;23:j3ng0DnswnXvVStRn67EtK+J3VxMCpnvZvJmFOS?=
 =?us-ascii?Q?yE0lTNUf8PP7ZbFo1NF8Z5Y1VB4pXzdhf9bl5Ee9ot+pSc4ycUQ2H+hNVxKb?=
 =?us-ascii?Q?xhzsswc0pueobScb05PMntr0zGawWkLWraEDnqh6ojH7Nm94VfLh+Zk0osn1?=
 =?us-ascii?Q?gtYu2cG0FPJ6JkVT6aavDIyXus5Zl4cK1MQQmhbReE6QBFJodW11UUCV3P3k?=
 =?us-ascii?Q?QgujNn6L8UhzuHrUvaRTZP6OigI6zSX34c52s69HiWECCgMzHWwQzayCqRND?=
 =?us-ascii?Q?cYoJ8g2335dbjsmgoX+/QQuFVN5QHH8sRmPb3uwd0ys4Khzocu+UbVyEOvSL?=
 =?us-ascii?Q?6OiM/Lq2wlz3oeLFDDah9JZ9uUpKfy5K3HFfCbB23KUd1lTrhm3DYxPbnNiZ?=
 =?us-ascii?Q?aAp/CbfEU0fW1k2kbv27aIuRcbVhXSNnhsW04l44/nvss3iRdcI3GxueOOn2?=
 =?us-ascii?Q?js+HDHQoOfYxzP1TeaRfsQ+y86PqgFaW2OHu9Xz5lIlRb9hFBerVrh2jsqzq?=
 =?us-ascii?Q?z8B/bgp4V3t+4t/483tqrWRjE3EcNMHnhtkNlHvfZ7iNA+dP3dLgh5H3B6TV?=
 =?us-ascii?Q?hV7XUWnUHMkOdik6v7SuSkQX/h/rexKfKAMHq5gHRpYDLY861dZ5l+VO5axr?=
 =?us-ascii?Q?p2zTQFs9RYPSxrf5L4tlAYvjIJEUzxltEHDD/C8L+RLQLL1XEABmb3H7ZQKQ?=
 =?us-ascii?Q?+peGoJMBGKfNv8d5bFPdaYLQ5ka8JdN2DQpbugBlQcy0YHFgw4S6ynxLDxty?=
 =?us-ascii?Q?i3yzCZtmFONg7yNPQ6Vv4ObCUEaY7rPkgDT49040GUv+CtD5F8aZxd5IZToL?=
 =?us-ascii?Q?motVIVvL7f2hNTUhhWVsUeMyDoidOXCePXMCqG2bH8BMAzqpIGR9HUjy3gPe?=
 =?us-ascii?Q?oiKT2o4dIryeCE5Ovhc2ivRnuipHLqJKOFjaQQdwF44G1Q254B0ity7jVIzM?=
 =?us-ascii?Q?JIgO7KBjZUVQ+3GhVdqdy76dY9jSd9HuV8HdKlQQnZG+IJj332wlFjY5mfLL?=
 =?us-ascii?Q?QXNEflhv3XGf7Yv+IAH5go04xgb3pq3LlY3CZdZBqlcYN8NJbCrs7etS5Zf0?=
 =?us-ascii?Q?7zeZHIOlNtiXTmSbtVnF5V7MCskabVQDU9j8NZ4M0B4gflim3E+MfjS7DPYY?=
 =?us-ascii?Q?44QMvbrGu0qbUbAZlllEKJOO4BCu0ck2DrCkhZtzuvamZLCDU7FvDDUl0TR8?=
 =?us-ascii?Q?W4JodOZN/rPEKZfld4cC+40UOOv29SFAARKSejfxAGc12aDLROpkGCJK2VYE?=
 =?us-ascii?Q?dKaKlxTxFzr3H+c16htFZ8SQhmhuNYujNcFTqX9jY5oIUvCPm19wAjkxxmIl?=
 =?us-ascii?Q?P362tQwtPGKwn1Q/LZ5VmNIxH74MEoIbWex+IZnUBMeey8K8FiCDdrcpfUVs?=
 =?us-ascii?Q?ctLilm0YWeXSIzpbY0CffotqGYn6eW4anaT9dQusLOKy+aGss1ExpzWvWSN/?=
 =?us-ascii?Q?3Qq3DCjO8rjcwZhDKlXBmwyDpWopBsuA=3D?=
X-Microsoft-Antispam-Message-Info: uB+Sj7cZs7QMvbY4xnyKbsAGh0lFnBdBjjSij+UkQCktaNemAsdbj03u5Wbd4DcIIK3KGJd1bL1mdTsp32CLgUfRXRjvN96utbUVuCXnUgiMFWWge+2Q1fcOr1SOBBfj4uVJSCA2wxzOcoSdL2fsz3W5BoD0AOWPf2/OcnIeZdu9e16Ol/cH7XJHhQUegM+smjG59u48sfKrfu6a2JLLmY6eWEpNaODrCnYFDoajIxzQIG5rr/pNXQH3GorA3M3qbk/s5rTDkgR9lB/YMfzWSoKAEHSL4inNYTvRUlt/++6AMeAQagnI8MWf/Dur+Lf4QHP6P0Huazu0o04JC0HowA4cwvw3faJOi6G8dJfhRcw=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2694;6:Sue5QVgOnpoTdPVwfo+V9LIZaIgE19cHHpKynOhUyWxjk9UIdppT6NRQaWUzFM55apyjRJ2eWJMsUw+/ad3hhYxCHPUrKAOWzP+xbNRxms1zP8b0yh92ByVRqEJY7F22+rPYTfXkSqLJ4f0jxwME1UIoeodS9RDfwTEp5WO1b9Mby2TWE2ZGahkXxV+Nwi5gqq3nE/dOV+lORGT2TXDxc3wfRiAp6/dcSO2aiZFFM9wQTH2YZP3Ne3y+J9T5mlPfGxjxZxuB7mdxFdAvAUxjTuqxEVMarCTM3u+anyjBORCc8xXmTXicaSEZB4xIMYYNMrufZV5EGYgf7cWzVuOgjdVgukP+ut3AzqVfbtIsVAZQfTxr7c/BVgv+x7+1i8uk0FOwsW1Rmj262QLm0c3GL2V9wVQwqWfsdq4EW3LFYR0DPhcamXV5/Ax7l3SI24weE9zbm6uruIB+690+J8H/0w==;5:tekeqskHjq5wdGvtmV9+ptlPLPDcQlOr8vGXZVo/X/c3bY5J/Q5mnvyIHlfFB3jCt3Qstp1WbhAzQnMCRRoSIBD/ELo9ZFHpYilQdGAi7sq0UAowJfMoy6LrpYhZB5UhIUKJzzO9AiuRWmDRqXvRtX8qtQOeUdD0TyWwyOZLgh4=;7:iLqdI8QWR1ipuI0eA6ttLCI+2wjo0LLQO/5XdldAx/60RYAUxhnoJ13F8w6EG+dALGqwfyBypBmfqEoFA4l19EVpdh/ajb86hGHB6UI1pi41pYRxNl8Q3mPdXjlnlNEdqNo8XUyXj/FYrW90VH5uq2kwfkkuM3humYNhYofDkir/OFDA73BXjqehBRYi8oydwJ0Zg+85kkpyRzdX5oFI8Jpk8LE9E4md4FdGW8pELI9/6Is0PvPVQamxLZ3bX/k+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 17:01:55.6003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9d0daa-8e79-4be3-2a19-08d5f0bdff08
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2694
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 04:36:57PM +0000, Vineet Gupta wrote:
> Hi Ofer,
>
> On 07/23/2018 01:34 AM, Ofer Levi(SW) wrote:
> > Hi Vineet, randy
> >
> > Indeed this structure is missing, following is a patch based on linux-4.17.9.
> > Sorry about that.
> >
> > Thanks
> >
> >
> > diff -uprN linux-4.17.9.org/arch/arc/plat-eznps/include/plat/ctop.h linux-4.17.9/arch/arc/plat-eznps/include/plat/ctop.h
> > --- linux-4.17.9.org/arch/arc/plat-eznps/include/plat/ctop.h    2018-07-22 16:16:09.000000000 +0300
> > +++ linux-4.17.9/arch/arc/plat-eznps/include/plat/ctop.h        2018-07-23 11:18:12.179402620 +0300
> > @@ -143,6 +143,15 @@ struct nps_host_reg_gim_p_int_dst {
> >  };
> >
> >  /* AUX registers definition */
> > +struct nps_host_reg_aux_dpc {
> > +       union {
> > +               struct {
> > +                       u32 ien:1, men:1, hen:1, reserved:29;
> > +               };
> > +               u32 value;
> > +       };
> > +};
> > +
> >  struct nps_host_reg_aux_udmc {
> >         union {
> >                 struct {
>
> Thx for this change. Can you please send a proper patch with changelog, citing the
> issue as Reported-by etc.
> Also if Mellanox is interested in maintaining the NPS port going fwd, someone (you
> ?) should add their name to MAINTAINERS file under arch/arc/plat-eznps and send
> that patch as well.

Hi Vineet,

Thanks for your feedback, I'll work with Ofer to make it happen.

>
> Thx,
> -Vineet
>
>
> >
> >
> >
> >
> >> -----Original Message-----
> >> From: Meir Lichtinger
> >> Sent: Friday, July 20, 2018 10:19
> >> To: Vineet Gupta <Vineet.Gupta1@synopsys.com>; Randy Dunlap
> >> <rdunlap@infradead.org>; LKML <linux-kernel@vger.kernel.org>; linux-
> >> snps-arc@lists.infradead.org; Ofer Levi(SW) <oferle@mellanox.com>
> >> Cc: Leon Romanovsky <leonro@mellanox.com>
> >> Subject: RE: arch/arc/ allmodconfig
> >>
> >> Hi Vineet,
> >> Ofer Levi is now the maintainer of arch/arc/plat-eznps
> >>
> >> Ofer,
> >> Please take care of the issue below
> >>
> >> Thanks
> >>
> >>
> >> -----Original Message-----
> >> From: Vineet Gupta [mailto:Vineet.Gupta1@synopsys.com]
> >> Sent: Thursday, July 19, 2018 19:22
> >> To: Randy Dunlap <rdunlap@infradead.org>; LKML <linux-
> >> kernel@vger.kernel.org>; Vineet Gupta <Vineet.Gupta1@synopsys.com>;
> >> linux-snps-arc@lists.infradead.org
> >> Cc: Elad Kanfi <eladkan@mellanox.com>; Leon Romanovsky
> >> <leonro@mellanox.com>
> >> Subject: Re: arch/arc/ allmodconfig
> >>
> >> +CC some folks from Mellanox
> >>
> >> On 07/18/2018 10:37 PM, Randy Dunlap wrote:
> >>> Hi,
> >>>
> >>> When I try to (cross-)build arch/arc/ allmodconfig, I get a syntax error here:
> >>>
> >>> ./arch/arc/plat-eznps/mtm.c: In function 'mtm_enable_core':
> >>> ../arch/arc/plat-eznps/mtm.c:113:30: error: storage size of 'dpc' isn't known
> >>>   struct nps_host_reg_aux_dpc dpc;
> >>>                               ^~~
> >>>
> >>> There is no struct nps_host_reg_aux_dpc in the kernel tree.
> >>>
> >>> Can you do something about this, please?
> >> Thx for the report Randy. I'm calling out Mellanox folks to see if they can
> >> provide a fixup, else we will revert the corresponding change.
> >>
> >> @Elad, upstream commit 3f9cd874dcc8705 "ARC: [plat-eznps] avoid toggling
> >> of DPC register" added reference to struct nps_host_reg_aux_dpc but the
> >> definition is missing. Can you please provide a fixup as I have no idea of that
> >> platform specific struct.
> >>
> >> @ Leon, reaching our to you, since it seems you removed Elad from
> >> MAINTAINERS file, so I'm not sure if he is still at Mellanox.
> >> The two folks I worked with on EZCHiip Linux port Noam Camus and Gilad
> >> have left Mellanox.
> >> If you or someone from Mellanox are interested in maintaining this platform,
> >> please update the arch/arc/plat-eznps section of MAINTAINERS file.
> >>
> >>
> >> Thx,
> >> -Vineet
>

Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC031C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B47520852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="BO6/Rflk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B47520852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388967AbeGXVzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:55:23 -0400
Received: from mail-co1nam03on0108.outbound.protection.outlook.com ([104.47.40.108]:30881
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388765AbeGXVzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/qYgLfvHaKZrauICS/pfgUbccF67NFxWpFDvGOxEAA=;
 b=BO6/RflkBD9/WjAt57LKC8Z9SRc5PI0ORFqHFgl8rGq5gS4/yiCBEP857GrUj/qkFIDxKRyshFjjLGj98GpaHhkoifftZA2hR0FRiZDb1LjtgfJsh5K3NZsvlkWXN8/XV6w+tVCp2Pfv4ft84muDiDosPLXhy6gWTHNpaxfhSHc=
Received: from localhost (4.16.204.77) by
 BYAPR08MB4933.namprd08.prod.outlook.com (2603:10b6:a03:6a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 20:45:26 +0000
Date:   Tue, 24 Jul 2018 13:45:23 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: Ci20: Enable SPI/GPIO driver
Message-ID: <20180724204523.zf5siuo7uh64g6gy@pburton-laptop>
References: <20180606193730.15087-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606193730.15087-1-malat@debian.org>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR2001CA0009.namprd20.prod.outlook.com
 (2603:10b6:301:15::19) To BYAPR08MB4933.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f5d951e-6b29-433c-63eb-08d5f1a662c9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4933;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;3:hipnqiKuvu/qLLsGUnDNHMvVY1FRYROuDbqDJaGdFfIgvTfqLXUWMZ9MRAnl4rFL4SboC3my2qw9VXemQADEXJCvhHAo3WtpsI9rLTkwD05ULGOMMNJ9IhxsUDe4RqtHezCVnd7iSkmyb52Sb1KoanDjXDCqsA3MhvNeI/R+8wF1NxPr5tfmyzLCMJnA7VQu6wtTPM0Qtzi6NNz35JAvJ5uKpYidiPS+GbMTjrCCStd1oN5eu+ffxsb7HdsjalT2;25:aMoWvhyReFd28EsWSptB29ai+ioJUvqIqQ4kS5GIloj1MaaSHbowdg9hdYvccX7ohOCbaQqtjduGL/b+yxFhXtNioXnjetd/mk3lXfCXyo2dHt0175hFeoVFfAubu4tS00LbfRxh++8TV0u5RfTh+ht+bysG069RwOhZnnzm2NltVGqQn/reLmYiR5hvWR17jhJXGyDNoC8m/fOXqPh/1uVVQ/AJ1O0UrIKUyW87MWS7guAyC36iNOfkvV7LaWUx3BujtLka85Nqpen6VbRHsfwYdh4QM2MpY4zs4gn9YIsUC3mIw/7aoYhEflpXuviI+46iD554Po6hqdko0UcNIA==;31:RjKKxN4wtZwusLPK4V+vh9dg9BzA3tVOdTNeh34RBn3gYFtoZNyBFqpzBjk8CEnw5iBlBgXNQNa8R2CoNFqXRzzQyqUZKAHnun7PGK2eEC06SewVokLaAHA/jWEHhgghFgOKVZU0TJTZCwmTSEkEPQEkj4FgwXDwshFx5P6J5OQNuqoYERyKYZSOOtoT0oVwGo/5yMVavc5m4cZMm+9CFYkD25N+grGI6e4RpvgJHeI=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4933:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;20:Y7CrlZb/nlKDdUE4vMWaAQQIqLxF9JXXcPmI8p4xwES9X09cAHMQxqekbgQlRd+0z7sRfzwLeRY2nozDvnn6MP4HhxkyKkkotMx2roUXy2jh5CrBDk2Cp3TEciIO3g74VlWGpeLh97T3Os/yQFB4FOnCoIsLQ+7GK3zntneRohTd+nCbsQgtaPxbJAGNIy1iRpTVrA4J/wuZFzgzf4Vd0vM7Te3GQc4ZfmIE8ZwFfdbjAd+boWalLMiPaLObLBV6;4:DektiiydpOuoD8OJWhUwOQMRDCeUvouT3dSjMgENWZMeuPpDF8PB36RzxaByli/AGXkZ9COYQZjvAg2kHRoYRscw1KkPw5pjv1FL5Apd7N+Vp7pGmv1GkLen408a15H/7zm9Zg6iQkWVxY4ue9AXtB6NoPaxU8y/qeMrW+Ik2Ybya4yu3j4MDjeTvzLPDmSqIYhAlvYOZSxExbNWveYHyDcYSP1NzmtNTcXhRkHfj6p+Y9xWYwrIwtEcfXcNpigoKMgnKaOQaJklCBbtCue+jw==
X-Microsoft-Antispam-PRVS: <BYAPR08MB49337C8EF6DD7D288EDDBAE5C1550@BYAPR08MB4933.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4933;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4933;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(366004)(396003)(346002)(39840400004)(136003)(199004)(189003)(54906003)(6246003)(42882007)(476003)(33716001)(2906002)(26005)(1076002)(97736004)(68736007)(76506005)(305945005)(446003)(58126008)(486006)(16586007)(186003)(956004)(11346002)(14444005)(3846002)(44832011)(6116002)(5660300001)(478600001)(316002)(16526019)(23726003)(25786009)(106356001)(6496006)(76176011)(53936002)(105586002)(66066001)(47776003)(52116002)(9686003)(4326008)(229853002)(8936002)(7736002)(386003)(81156014)(6666003)(81166006)(8676002)(6916009)(6486002)(50466002)(33896004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4933;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4933;23:qRPT1FnFk9797kxm2ruNMcJG1gnME0hMoz38UjrN7?=
 =?us-ascii?Q?USV2G3CIq7aPGk/YQB9BfTnDUhvp+a+fN6/rvPZlODOJe1T6zNHZEI0q/Vq8?=
 =?us-ascii?Q?flv2zWjNbf1XiQypU0CukYcP8nV7Rlsv1lrZCi7oIm9wqPa9Q9wUKRzH0Awc?=
 =?us-ascii?Q?wvTmawchNibcg3AjQ9XghJOr36JvlYAWaSH3PNTfhqh2r1aPuoJWATCRO2jm?=
 =?us-ascii?Q?areIbgm23pAN9/GivzzbbwJsb6W+2SjGTtxQLdVMoNP8jUAS5lUtip8QTQQN?=
 =?us-ascii?Q?tHwD00h/P1JC1PCAMavFol6KNrr7Ix6nWJHmcpipnwxbRYRpVY9vxYpCN+Qf?=
 =?us-ascii?Q?24Dsz1g6HrxpoeZxgm06/wmZfKdYfp1CZGGlknefqIRAPGZ/+PbNuglwOH80?=
 =?us-ascii?Q?rlwcRTYZ+Uf2Sn6u1hok/ykYsO4HQWrhyewP6ddcVhR7Kw3/eEKfXusNiBVa?=
 =?us-ascii?Q?mnUTAP5YY4RbsDxOxXR3xH8G+kX2sAW18r36SN1rL678IR7YGF7y/t2ooo7M?=
 =?us-ascii?Q?4wLijXHZjts0+flypdBIYe9F+Gh8QypXfQ4hdmToPtjLdpCLZI5mB6q8z018?=
 =?us-ascii?Q?ktZZRci/PxnDSPGyZKtOiFFHBqf9+o6O6wN80rrbRDA6uT23wv67SjfLuP84?=
 =?us-ascii?Q?9mdvxnp/KULnqMTZvCX7x5xQ/zNLXiVtgweLEQO2vK5pbMvASvj/Bi+ihRVV?=
 =?us-ascii?Q?1q5A305g/qryO6Nm3tuUDPjvu6OD44U6tViYzpeP2o9YFdAn9kJ/pW94q8s3?=
 =?us-ascii?Q?M+HagG9Qf2u44AS+HiQKyWP6P/SgNGSuHz7dSpJ84FSVzfgngeTzrsZesUwF?=
 =?us-ascii?Q?Ma5zic/NciepLkOgx6jcgL25KSEUcvdCle1IC7IydevdgwXDo4KM0Dveb08I?=
 =?us-ascii?Q?H/Sws8rQ9CpgaFR9tzVLXA3W+hPjkDtwyMpi3TZ85l9Qm0lhb4pnhaEVOlou?=
 =?us-ascii?Q?PV+G+b9bjKDCdnFZURAm3cra0wM8YvRbx4kSsjhrMW3+Sn8eymLqA6vtyzBY?=
 =?us-ascii?Q?3voiSH8Ad0Fn7/jCb+BgQU54Qynj9ka0pLtyJLcjL1sBLV38dWHlI3gt3daW?=
 =?us-ascii?Q?MDN3iJrueUhYI9vm6lwouDqmMmeLb/I4/QUioC1FuB6lX3EXq6ahzMytDb3X?=
 =?us-ascii?Q?c4t+J1uOVinv8ZnE31X+qVAY19r2UWNCzNX47Vw2icoznIL4BgngnxDx6b9l?=
 =?us-ascii?Q?mvRh02GH8F15Bg/LivQtrU3U3sRNybdnRlFqN3qenPEom6cHI0+jC2rzCXoD?=
 =?us-ascii?Q?hh6md7mzjedCLGFTgHPw+gWvxtOVa7Q4rQE14gZfSAYTZzki9gQz7dMWP0cR?=
 =?us-ascii?Q?pj+pBjF5VPbmpYU2ixMWpy+aakRAlVLc6LRVgZOTY6W?=
X-Microsoft-Antispam-Message-Info: WPuCEaEy+ch6GS+i5wVINSuZtxGuP68qdGbmv28skNTyHrcdN5Q5rBKq4lVBkzgssv+q1xRz5HWsquJ9okKieYynX7vRMJ+C0egoT5RvigViISZSt2Hw+HjNYjwVd/TOS+kV0Ve+mOIxJiw95R0oEKyZ67pzlQLuRSPBVZEZ7v/a/0ABKBTwS6wzI39Zw0tQ8JYDHwKiMyS05pLK2SFTk8Kejcm8RBrTiiE7tky/om+BWP9sV/1IGG03ezTgIbymsqSxN+RM1B7r+ifLLyMvtqyFFF+vrhyJvqp7VkNs536a/WgJNSjy/9zjP6Juym4XDuMQsPzXI5+m7pFTso9x2yHGhRfjjdzyz6fVtT9V70I=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;6:snxw7cty164/6zyHno6HxgUeDUjfxW3+fNwYZEo1cIXK+SNQjrUXNl55sDSEKlWNn+wDgzNnhp4loxtcQ5kbu+5ZiDDLyswI82Fj9TedRrZ3fv/y9BsHcOXhAN03r22oDPws8NlwO4Z8xVQtP2qJoAg5HBsPPL0dm99SuqmYqTEPtmXBAZy5h8gqzjfS8gxGtqONtyzFT9kKDdKQBlDY8vR+CgnKtC4PZnFFFZ0/NAyBjghPE3HR/2Bgbeqgy+PQ2hLQwabZwWb1VTdkHWGD8FjAHhiJ0RUYCGaPIpywzawwSaYzh7jdmXM+g4SK3E/0wPFM8Y61fuwTsMt0MkqF/Cg1OS8r0RgB382lVTFhx7bfcEfobW0/O5sZf5SiQU0cMDvnEdiRDW4DFCSVgCWcyOdpSlg9qlRiP4fk4tD4A8UznMh98RGjX1uekeF43L8rcfop5WU5nxAbmcP3XvQQfA==;5:9o2lJSgIfseUHWakvcQrkpX/2nQZv7qsFK5L9agJ6Q/K/eDhE5v0O8UttXcPIAGz/CCLaY3XfL/jq/B7Xrj1Px7k59Jbhk4JcdXz5ghOYBvOfNmK6xid7aP1JZgBVFmrel3kmRzpI7e6dZew0lBOsd4EBTqBxMPcO8WXaIKiQP0=;7:j2JcEqtDbD4mVTvzl2ePYuRrpORXjLem4qoMrYlsc9Q2/r55LkyDs23AL7pFdaJGWnrcxWbZWyy/RxPkl6a3WytcIcjx5Xl5FwYPMP4r25ETOu5mgMeVPFVlEov2aLZqU0v4kIHYkYcEdSEdGaUWHi5kZkgfda2dcJLW/gxwJqnro2TXL+X7qh75W9HLR5nfxEgm1NUlYfp0ULH3UKCuktSiVH3YYt6ONsabhpDbCtz286gpypMifoB6zk1NPgMH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 20:45:26.5452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5d951e-6b29-433c-63eb-08d5f1a662c9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4933
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Wed, Jun 06, 2018 at 09:37:29PM +0200, Mathieu Malaterre wrote:
> Update the Ci20's defconfig to enable the JZ4780's SPI/GPIO driver.
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/mips/configs/ci20_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Thanks - both patches applied to mips-next for 4.19, with changes to
make the commit messages more descriptive.

Paul

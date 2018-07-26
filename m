Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7F9C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B7320673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="KkQnRnvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B7320673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388497AbeGZTBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:01:31 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:46880
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730285AbeGZTBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjI7qSHQMDiPkWRPyTlThxp3EyluiSVIcFvdnCirLqA=;
 b=KkQnRnvK2QXfo9ZXrOQjjcC965J7ZVyT+Zt0TKCzQ3X3tMPz7CjWOw2LOSsBv9myxfNuFTnm4oiWnt3reOAp8+3Uo8uVHerG5270dqy8nl1yFP8UEVjVpL3N507vbuNd+5l+6eMipNqQzbaFGSiB8i60K8VFuIo9XwWmMx1EG0k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4938.namprd08.prod.outlook.com (2603:10b6:5:4b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Thu, 26 Jul 2018 17:41:58 +0000
Date:   Thu, 26 Jul 2018 10:41:56 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        mark.rutland@arm.com, ralf@linux-mips.org, jhogan@kernel.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] MIPS: mscc: ocelot: add MIIM1 bus
Message-ID: <20180726174156.kj4xcxbvv4q7tc32@pburton-laptop>
References: <20180725122241.31370-1-quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725122241.31370-1-quentin.schulz@bootlin.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::25) To DM6PR08MB4938.namprd08.prod.outlook.com
 (2603:10b6:5:4b::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adb065e2-ce3d-4c15-d1a7-08d5f31f169c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4938;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;3:A5QIFTHd9Rrzj+YyGWmKrm8TwLFui4VbJp83DgRtRf6V3BMDh6GIrxurthEjYbpYC3y4yUsb2TA5aEMuxtJsO59FBysXV7KgwT+/O+T+JeayTmSCQq+IEbro5ZVxcChklqZc/KbGuuI/9F83EH7FUJeWBn242c8518YfxF1MtPBx4c8WKY48xL08X+UL8q9dpuWuBfOnBv6lCi3HwScsHm773puiIRPtel3XOoicZd/dgJ6eznEh2kkrwOFGW/SG;25:aIZ5mlm4rW8hb3uKdUKX0qJO5SNyyT9gdhh7HO7tP47egKnkgPdUvpM+esQNUDbsx2r+UFSAHS56RTE2/kdQgpn9yyGFy7tZ7jIbTFRfQFIrRUuhlSV920HMubN4Ihu2ArM2SO+yyeC/2/2YuvoRRe4lR0FXv/yVt2ZUbETEmeqYx4t714IqmZjaoSq11SScWKwCEVbAmgwV4o4gjGaErFaXvopXXOBji2pbYlJEP8HtfF5DG5NM/ppayVFwbI0oIwQ6d23yEso8cDxaqev5oSfwBrIm5i1g2ybdE06pPsEYnZTkTjy9muU605sS6j0KkqG4zXAZeUeX5bF1NxuTig==;31:9y6u06WBWJVPn/xnbvOLzd+hGMpYg1g7VMLZu5uypCh4rnaguXf5QrJRdakOv5jCF8wQf56g002ZXqCAIRDJmvy+wOiMOsqEPdKhiLA17/am5ZFWbMCL5T81tYlRT5DW68P1ghJdAO1s2d3thwXiRw7y+CRM9aOsA+BsgfsSlsQlaCSM7Kw6ChA8Q8eXS2GVrIdcq8kSF43gbYiRPiJGsOongwiV4G87mvZCFp9tr3I=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4938:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;20:wk6KnM4ZZ1RAxR/QMMTKt/5+BRFbp4imxScYy37ynnTDB4UKjiWB8Qt7G/z60+f31G7mT7USnR9P0prH+ijkSOFmnQac+Pve0nRKL5Wm6lyGoEyz2MNJzA8pDyYHzWGIpHgthdbviQsB9gTjNnX7pMI56Ab5pZ+HBNpH6UNtqdCvGtQ3tQblZzcyryCw+f+XfRygCC03qR3dNs/Y1gaVWULMGDAPsl3G43InJY8TM39ANAVtWNtNWgBDW3C8M5xC;4:Jx5EPTEkbrIw6//N4R/TD4m1SHAYXLpAH8L8fypQBDZpfHhBKgB+lbYbMN7PMTUb/TgHlY8cJjBp1pScyG+JWuG+kUo8lkcG7ukO5rvKNsoEg/UnL9J9AhQSgZk+GOPhzj4bFeMmSE9lFancliYSQMitOy5cDfscfVJ9j4ca1x9Nl8RYIijciMkwB5ZW4UTscSpM4dQ25SkO91IlNnWGL7UE3zqtL+o5J0OGmx9G8RkIe2CHie2KhBqEs3pGJS7O5TsFQ+KUoYw1PzGbHIQrsA==
X-Microsoft-Antispam-PRVS: <DM6PR08MB49388BDCAA3FAD205742A0C9C12B0@DM6PR08MB4938.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM6PR08MB4938;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4938;
X-Forefront-PRVS: 07459438AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(376002)(136003)(39830400003)(346002)(366004)(199004)(189003)(6916009)(956004)(76176011)(386003)(33896004)(47776003)(50466002)(42882007)(11346002)(58126008)(26005)(16586007)(16526019)(33716001)(446003)(52116002)(6116002)(2906002)(6496006)(5660300001)(4326008)(316002)(486006)(105586002)(44832011)(1076002)(186003)(476003)(23726003)(66066001)(3846002)(25786009)(8936002)(305945005)(81166006)(8676002)(7736002)(7416002)(81156014)(76506005)(97736004)(9686003)(478600001)(53936002)(229853002)(68736007)(6486002)(106356001)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4938;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4938;23:bQXo/qAKK+4pLIb1kPXxAZd8uU6xfXSV1jK0AgqzZ?=
 =?us-ascii?Q?0KcXb/iGLUGdVBorq0pP/6frab/j2Vr4XXtYdwKJP6vHh3Dogm7Jf3/RHWv0?=
 =?us-ascii?Q?USsQT60+4W7eGm3cHP2ZBD4exuf5rcfC9OhCZidku+sZ84ZS2yaSkYB/e+AP?=
 =?us-ascii?Q?Z9KW8hXPu1fFCZYWQpv9ZQjT6p7w8ZaD+3CzX5CgdfONupY3s1dUmVS1Z44n?=
 =?us-ascii?Q?V2/hjqjyIoJj3ISCRFnvlTGTNTiwhTy6qibyrnaWWbgDDNTq/T4kAgqonf3Y?=
 =?us-ascii?Q?BBwp4oW06S7D1nFdKevVgjON7v6ZBrYLd4M167gjYGnsl7vEHpTbA/jrQBn1?=
 =?us-ascii?Q?Z4UECeySDB9gpgIQwrwjU5m2zRQ1XJMxhOX3rbkgjQV8Ij8+JcC9w2xxa0vv?=
 =?us-ascii?Q?C63LSbRNI1s6vNQmMtMzm2SYlbjkJ3rTnw2zOKNxW7S2uTE9kwvtWoEjouiU?=
 =?us-ascii?Q?NSoy6xJMG3Bh+64OjBYjJzK61gubJW8AOBOwvUIP9UVa6VhXk3pOJRII9Le6?=
 =?us-ascii?Q?sYIK85yp0Mnswsjx5xt07TT/OWG+tDgRigXgYzq9T4+lfdC9Sy3Vau9F/DwU?=
 =?us-ascii?Q?Xy/dDJaBvs1Lb/6xqO55dVF0UTnE96DMmaP4a7kVLFOtvPk0wxF7n6O5Yzdf?=
 =?us-ascii?Q?bYlgPOAvDvoiiOu3u8cNL4q6jhfmW2ENdzGeoSaMKriTQvwuy1W35KVOxN6E?=
 =?us-ascii?Q?D/dETgpYEb+86h9PorakFVHo6L85pNsfyC3y165C8q8URaZhwcOi66ij9jwD?=
 =?us-ascii?Q?JpyVvRnQbW/gWF1zfZd97M1PPyHU7LCqjtvkV2l1tJ+rS0iUiDIjMr8FxFAv?=
 =?us-ascii?Q?3OBAuuQRV1gGf2qZPmgCqqrFnmRUmUFIbt14LWf/IH6PzedLheUA2Ht4HiTJ?=
 =?us-ascii?Q?XolXQ38yIZ6lduwkOFd/UdtChe/RVlcEJKcU8jf33J/C+FcpjWeLtkz080YC?=
 =?us-ascii?Q?L6w0ggvMINp7n1WCBQTXXC9eHn3xNfKgUXgHz3FnYRI6MPF8UlLTyXSpS5mK?=
 =?us-ascii?Q?XMOBFwSNewbCZ/nQ+kluMt5u4LqxY7UPOKMeKphshGLPH62D7T7mWWDqYtDQ?=
 =?us-ascii?Q?azh2BopU7y/gC984g32I8vf6oqOPeqB/WD01HX5LFeS/7wk/YbDdF+s0uWZr?=
 =?us-ascii?Q?aS9TqwT7FGx1RY+NSMOYVPHZ/xyj1VtfDYBdCK6PukkBkiw6Upx6QBs79U0R?=
 =?us-ascii?Q?/TmnPGXIVdmw8L7MP8g7TTSpguZVCvMF1Nk+R8qbDqVu03TR0T6gYKV4N3t0?=
 =?us-ascii?Q?wOZOmKIp269poPYG1XOi1eWAiePD3pc7h12zLON3EHGBecpS4J2/ahZQgvxW?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: rEQyqjl8Kkepzs/xYh6sxYjv5Va515vBt4TGiDUK9DHFrsjGTDiimldQEH+eqNiA8XcgTJQQ0tLv7S6Eb56hZfTToI/jzZfXO+4lQNSPlK7F/QtGYunTU0oZSiWg087ls7SfmZpU8BOxoHXi5PVXbRuBJii9VrMj0+ljkaZ/Nf4k3KZuNyCaIuMJ50RM58sKdh63ke2s+rYCK/Lm2IA+PFLRrqHL0OrM1sO8l8GucOj4HCpoSGlt5fmJDyoprMtwaz+JxlpjFAGA54MvSJDRskakjMVH7Jq8WP+yg0AXLR/ExUhgj67xlxcEKgtwa91Ghf6mdkNcGWSlQYglOot+twvrgQBbutFTGezDGFk3yFI=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;6:7+KJFYpPrd491xQTexAvWRJFmfNFrlzg9e0Fukrc+0ruBvgF2Sp3eHCWdZUsotrNp3wt90exngRcxGSZoy7/10u+s/dS7YmkPbTygMAEAKxXK5uotK3TDnqvNJ3Nc9OrXZnl1M0nHgD3RttKtmE6KXBdX2491C87AZJSoFbalq9NKcL5aHb+TuDTASkE2G8tgnxjGoGl2oZC4fN5whhQ6ug4Wu5SVGH0tHOXd7LIx+cuv0fjPfkN0rOcTYxx8VgTzqeQB53SkVm+39F9gA1C7dZrb2GDrPzjQ+svtyOHma6K/McB1wlRyPbgqIJN7udJ+zY98ld+tlFwqa5YnGAUDhl6Oqytgb0IY4QnuX5X7FfKPtko4DUXljXrnz9Vs+14/Hvmv9wR9rT1X5quKn5J2lgZ5zVSE2inOt7gmidefnFuNlNeccC+dE7AENcxdmK9FvuWtyaa11i/wcFxdNq0XQ==;5:VEkZ8VWur7+qMdJrqhjNNZuMJRq8MhWPy+QtXAzdDfQDWYwngsuDe4bfDpSmU+gBG/YamHKIio3AUWAYO19D73VlfOs9th03nsARW51tCOXbWJn31nrEZyvMAIJpaleKQfP+OXJ0RZYOAOwQQax3xJ5xpoZ5jtEspdL7R4L/IB8=;7:2hJb2iFFWs7nyZO7Q2gjg1dc8w07VWOZwUz6F+RcyKli3t4acVmOVSVlZ231G7LogKupKeNG6VrN7I4A8YwvaTuBXksIlNl1IPAAWpCFh+2FrdHPeVttusJ+wBDQf873TwupEdpFAU4ixGoU99oBBAIjSXGmUXkWPY4ZLGSMe2W7KupHPDGAJ0Kcp4160PU835kyaaXrcGTIXLxTNsz0qVoTMX2Uh7hSBJHYQO+AsZI72TkbRqZ+qq+00N/upIaK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 17:41:58.9986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adb065e2-ce3d-4c15-d1a7-08d5f31f169c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4938
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Wed, Jul 25, 2018 at 02:22:41PM +0200, Quentin Schulz wrote:
> There is an additional MIIM (MDIO) bus in this SoC so let's declare it
> in the dtsi.
> 
> This bus requires GPIO 14 and 15 pins that need to be muxed. There is no
> support for internal PHY reset on this bus on the contrary of MIIM0 so
> there is only one register address space and not two.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  arch/mips/boot/dts/mscc/ocelot.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Thanks - applied to mips-next for 4.19.

Paul

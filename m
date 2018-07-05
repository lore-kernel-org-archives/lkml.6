Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92DBC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3027123EA1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qGc8S5BW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3027123EA1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753553AbeGENb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:31:58 -0400
Received: from mail-db5eur01on0060.outbound.protection.outlook.com ([104.47.2.60]:37579
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753397AbeGENbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fnuoxt+jtogLOwgDsgl2i+/xRJcVcQYADvhcRuFi3K0=;
 b=qGc8S5BW1qWvtZfkYZM17HEG0zC4H5GcHcrsnZtnX9lCGWY8qHLIyx50N/QM6hOYt2T3wf5bX8yCit0orE8TBqiTe3Gm4U3msAeCzsUqkSEkSDdeB9agPCW5uwfJayRo7Twos1pkm4aKQCMohXmNnA5dkDOwn8FwDEbIXPqRX6Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from localhost (217.140.96.140) by
 AM5PR0801MB1377.eurprd08.prod.outlook.com (2603:10a6:203:1f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.20; Thu, 5 Jul
 2018 13:31:50 +0000
Date:   Thu, 5 Jul 2018 14:31:47 +0100
From:   Ayan Halder <ayan.halder@arm.com>
To:     Liviu Dudau <Liviu.Dudau@foss.arm.com>
Cc:     airlied@linux.ie, liviu.dudau@arm.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        malidp@foss.arm.com, nd@arm.com
Subject: Re: [RFC PATCH 3/4] drm/arm/malidp: Set the AFBC register bits if
 the framebuffer has AFBC modifier
Message-ID: <20180705133147.GA31243@arm.com>
References: <1529070694-21088-1-git-send-email-ayan.halder@arm.com>
 <1529070694-21088-4-git-send-email-ayan.halder@arm.com>
 <20180626131716.GA14974@e110455-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626131716.GA14974@e110455-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR07CA0215.eurprd07.prod.outlook.com
 (2603:10a6:802:58::18) To AM5PR0801MB1377.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7641b5fc-c717-46e6-0bf5-08d5e27ba9e9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1377;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;3:c1+Csvj2egYi1kR+4O8cGxs0fi3vqUjm/FTBPLPDjms3ba91oAFO2s2Y/13LYbookR0vp+18PXNsY2J7AT7TdOwCD+H8ezsXUo0M3Yu8wrHBmtggpz3pLkTMevNnopXuIibXEZKeXafo0eZU1V6i2GBqDQ5eR6x2KYHAJLKYIuYv+OIS7SbyNcjOzV2UsESlCU2oK+rxcQhhK3H6s9BDTxHisx+XuVKopwPlAYb7tAo148/MRnpppjrJDt6GP6P9;25:/kT4FaGnWLtyC0e72hVzY1dXalsGL2eDF4jcrjGgggPTWKWZD8Kf5KUkejUrcfbC9md87tbReVeDFn/btOL5IssQakjjNQVeGMigJf7GE+hHSzwe4Xkj7Zr1ZihZO7p+FDz9CLzgiDzGqx/cWNZcRwPM/dLo4EWRSkLEJ/R7FrK3EVqr8fNeFZkjvGH7pgu2rR/Hp2wt/jQleV2vaj/qaGWYUw1WrExeLqdfUVzVjfWd8lexocZnNnbI/LdtherKUUrZPR6qOzPists9+1Xcm2d1ot7DrPs0Qxp772TbWeQN80Pngdo+Qi3U7UmDr2hMovtbg0W4f/R0lA007gMrVQ==;31:oVJ9CQZVB28UO3O0QTPkDl+Ooql/wXGK4VaaPoqQ7xDPSRc26XhqtCHwEJf5kbp4qJFGqVYw8BtCU7xcEVKTaP8QYLk/voAo/fV+zQUv2u4aUxZI/eCUuy3/k/iGNH7c/ros61NDdbzWIc5egII8VpikcmOIVqAqFcDqWt5RAkh8LVAy+et4qFRaUvbsWdWHCDb12IvEBDdoRPE0Y0sWQIJopNvWZwIuY+ZxwbFOTbM=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1377:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;20:j1sJgQdUVjQGydQKRsm0u+E9TwGxycwaC1yr7Imin+lenLb9K8h9GQF1k9g5KEEWppI9gdReCZ09vW9guayf68oQT6hLLvSIX2P/cp1IgemHDBW6pu5cnE01lZrkw3esWsoTcDcQj0gC2gSvmJlIt/pUmH+fN/rOjNCkErgewKI=;4:ZM4GIS0qBosuwq7Yd955C6tS6+1zz9LdHzjftkwcuYWJ16givA8ZlN4xjTZNTffbcO8V84ZSBVWOMZbKZ7qbGSwUmpqzCoavYOnm09sQzrOWguJUfm6Ks3OIkiZDNhPvAW1NhUvNlvGrrh4rxrsZE8nx0uRJEKVMQWRosAKIylCnb5wwC7aotpo/jzPpPLlhjDHOA2feQo5oJFYwX1d4GwIBkXCbVIdfWfE8bNk3RfR5Rb4qKMUCpYzKLjzzIYiNKWn/UHWrr/Tegtt5Fz325phNdKkUgCuKR8yFY0F9nb1GvwhiFRFMzcAScqUCVrtbboBn5V2+i98yy2u958TocmWJ0m8GX8hTNb+JZam5SKX8kY0ybKes7I7bINnpPnuz
X-Microsoft-Antispam-PRVS: <AM5PR0801MB137730AA41A0EF09151559EFE4400@AM5PR0801MB1377.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(217544274631240)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1377;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1377;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(136003)(376002)(396003)(39850400004)(366004)(51914003)(189003)(199004)(6666003)(52116002)(76176011)(44832011)(486006)(386003)(105586002)(45080400002)(106356001)(316002)(7736002)(5660300001)(16586007)(6496006)(16526019)(58126008)(47776003)(446003)(2906002)(76506005)(72206003)(575784001)(86362001)(8676002)(81166006)(81156014)(956004)(478600001)(2616005)(8936002)(476003)(11346002)(966005)(14444005)(66066001)(229853002)(53936002)(68736007)(6862004)(23726003)(6116002)(1076002)(3846002)(36756003)(6486002)(6306002)(33656002)(305945005)(26005)(50466002)(4326008)(97736004)(6246003)(25786009)(18370500001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1377;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0801MB1377;23:nCDrSiaLFs7GHStnAqfq95IJmIqATIB4QkJWs/m?=
 =?us-ascii?Q?7ujVkXcTTRinBgJp6Tj+Vln7i4UHdWFcskDJwHmpBg3llrw0YyRVsw8hN81p?=
 =?us-ascii?Q?lDi7n64hcvocoNOtmvfHzfwWGelHx9KOEHDmcskt543HxDG9dShQGzXaViQJ?=
 =?us-ascii?Q?Sd8oCTZCPkE/G1RIwgfhB30ZfZUrDvLhuI6YsgVH+nlyNneMNTCCv9EY9dEw?=
 =?us-ascii?Q?AfYg79SJVvJoCnCQ3xmZEtBPbTd05gF/FoHYR8QCy3X+AWv2fyN0+1ozpU5Q?=
 =?us-ascii?Q?i5OtEds0yEj/dF4On55Y1Xarn4LJe6VKhTLy2ZIoS4V6xELyKVH4ggzDGnq3?=
 =?us-ascii?Q?NtUXMSylYshgyV0w/Fn+VydkoeDbnjPZ5s3+xfOyDC/034MQZV/d3CkrhTLE?=
 =?us-ascii?Q?S+V2rSosr8PVimZttW6tVvF0t6AZpKHwlZKs8hvNhrqWlKRhLwt3ZvcKfh4e?=
 =?us-ascii?Q?DyB3p1ZErqeCGUPRS1i5vYIBUx5x7WGj1kudNFWAoqeV9xKmHrZlDBmDJo3Y?=
 =?us-ascii?Q?Co979NcLIDMjFZ2k2oPtBnB6gwCHel/0U16cLgTLwCBHBKUIpjIn9mL5SjkT?=
 =?us-ascii?Q?ecDtmoRruefyOPeSY56dihU8UZp95vUAuJRNQ5Yw6p02hb4XgZ2tqnwn8iXJ?=
 =?us-ascii?Q?n2JAFBIriMD7oL3XqbGbjU1XN7tvROxgMduAj7R7wCsyS4B9Ybla9WiAN+zi?=
 =?us-ascii?Q?ttaojU94Q8FMJIcwUBMKcU0KIX7ZS5TRzFna0DfOk3gfk9pvO9tpGrn/tls/?=
 =?us-ascii?Q?jK9ZgBUX0uQT/F0e9lMdiz3T4ciosLB0WK1ljeEecvyijZmjv3e/FowcRnvN?=
 =?us-ascii?Q?fggrqj9S3McNP3k75IlZqzvOpvj+1vqFkN6TprUZlQm50kLsNC/A3B/rKnY/?=
 =?us-ascii?Q?L0RsLv7wIYj8UgA8VCq1odyZaoWqFc3pQjEfhFdpNsiPx369rhqOGLtUKAG0?=
 =?us-ascii?Q?j5w8HTJdyXCAU8FDUo5ltK/1X6K949WaoSArMrAw7KtYQuheXpI9+xEI5SGY?=
 =?us-ascii?Q?tVPTnh8fwOT8AVrE+AzQMmxXNMALLqhzHUnDN0q5wCDQxIKNawYpFIZJFSS4?=
 =?us-ascii?Q?tAYHZAPljQbFchkeepEhfm+TwwhqzUyxB11hP2PJ+sY/zv8qvZxVg3Vj2D7Z?=
 =?us-ascii?Q?6vnb1ejKh7cplSL+34WwWenTZx+863lJI1imKKV46Q6hH1pwLmqtyb/nIlGj?=
 =?us-ascii?Q?hadsK72zqiuKVnoUPJUfKGluvvPKdvKs0GXS/xwn74oNpIy+WcmgDVMxNfDa?=
 =?us-ascii?Q?zIvrQpgOH9jUcblLZbaUV77q/mB5y4TejlOsoLBc8Ky2B9VLh1DrkMPvmyzL?=
 =?us-ascii?Q?3iEH8EPhKTI/aLnVWfXlgc7seZJziANVVFu6uFY1isW2F07pmsi8urGP9D08?=
 =?us-ascii?Q?eK9mtb6Y3gxNrWvP6EcPqjeD9Rm0pWqcKFuzqGm/HMOSIE3aG/sagqoj++SY?=
 =?us-ascii?Q?Ltdxeb+NiEN1s/aM2oV35Mi1+wLYf5XQ=3D?=
X-Microsoft-Antispam-Message-Info: MPwTPz1XY/hT6ZyEj7wI6GEEoohLIcLNI2/QHvlcfIbfGJcQIqy2WL28ok9oTtk6gl6vxBqNU9Rs17On2zQa2ARA8W4RHfJK9Jvk2IW7/Hzn+Y11r3wpoC0zYL6xIGLzVKS+CHQKgvmICmObPirMOVM7i9+6p2gSuH2piqmh+ltNlRva2bXRI0EOpLS13J3iK5/qiHRadimWzh4YA28gN0tLjADNg7jLrFN4bjxBcOGY2QQND0KCZ60g0tnhY5jLdyIpvx4s9r3RLsO34jjpNw9U3r9v/fgGSKkSP0isU02hadVC007QA/71MqyJqmUU+p5WInqjzWsjkD4OhavKsp5//BVaazvv6N+D5OD+om8=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;6:ieYm1Rpe0cdj4UhHfr1NgPI7/5HhQ3caCT/hkhUFScotwt3jOgcE4duaOhQ+uElzah8muAO7dZoR3W+L6PdpSg2fnf9teZqhs2f3uGDtGY0xn37lE5dPZ4u3G8VtO076vUO/avDxK8S4yDTd0dR3GmV7wJG2WR1a6L/+tFSsskt7PYvvFEclSvz9og4ciN1lc19j1FQygZxmzJ0KkCsQeNgJf8/dxPRwGD85dUsxyQk4sTKqd3cqvRKjZPl3RrL4n3pbhSMA+F6FiwCx78FMwTARyrc/e4d0KlN5Jbt1XQxOTVjSVbzJl8GB3m7vUZJFpPhRrYPu4xqTmB2bPpEu8KBTnDm+HX+LY5jzvhUwi50slWp0jFjeE1t9OHh92IkQF3QZCd+G9JAZrbwBpW86E1pJvo9Itxd6GSkQAWFRA5ylk1XkJYXvfcepYwZH/skHcLnYq2ToCdKnx4e/rzOBKg==;5:g508N3RG0NFBD8Vf5tAfYJNYrPBgznVQ8LRBbndqJobnt3vC37ZrDadbS8l4KWnPU65s7gU9svZkMxAEcVFSY19T6DXKZ5aoYzpfjWaOIZ7pwWtbWN6h7SYFpgXmvPLqbah2hyAbFBC3E8jKoRGhakzbsT8vPMYqHW5CJyuXQog=;24:nn/QAMQNGhZRnRHt6KBJePFdbi0onUbRyq+oOVmh3U8sHXj5istgU7yPQxjdvOkdQsSY3jSeo0ge+d/K6Ogj3z4A8xhgh3A2zlSGsQ//kZA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;7:Frspvh8phBE190zOLUt/0L3DkeIcSotjL2J1eS66BsywDxT0y69WR/IPHuM0fAk3Ay6PcSvfPFnjiFRSKPwdXCO4gf0sgiFllb7eupRZkerEt1umkdSM7CDB/6yn/8bPk2zwC2e7xCvrzSbkeLdz9dyYwSHUGkXZb8kXtHLwGmkeo1+xsWIJ4IncUzYIj2Q3uA96yS7Rjy89TcAStkUDhO9CvIL48FHThrxAiTQEkJKagbwIJizDMVpJmkeRGY2B
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 13:31:50.0395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7641b5fc-c717-46e6-0bf5-08d5e27ba9e9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1377
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 02:17:17PM +0100, Liviu Dudau wrote:
> Hi Ayan,
> 
> Thanks for the patch! I have some small comments to make:
> 
> On Fri, Jun 15, 2018 at 02:51:33PM +0100, Ayan Kumar Halder wrote:
> > Added the AFBC decoder registers for DP500 , DP550 and DP650.
> > These registers control the processing of AFBC buffers. It controls various
> > features like AFBC decoder enable, lossless transformation and block split
> > as well as setting of the left, right, top and bottom cropping of AFBC buffers
> > (in number of pixels).
> > All the layers (except DE_SMART) support framebuffers with AFBC modifiers.
> > One needs to set the pixel values of the top, left, bottom and right cropping
> > for the AFBC framebuffer.
> > Added the functionality in malidp_de_plane_update() to set the various
> > registers for AFBC decoder, depending on the modifiers.
> > 
> > Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> > Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> > ---
> >  drivers/gpu/drm/arm/malidp_hw.c     | 27 ++++++++-----
> >  drivers/gpu/drm/arm/malidp_hw.h     |  2 +
> >  drivers/gpu/drm/arm/malidp_planes.c | 81 +++++++++++++++++++++++++++++++++----
> >  drivers/gpu/drm/arm/malidp_regs.h   | 20 +++++++++
> >  4 files changed, 111 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> > index 4dbf39f..fd6b510 100644
> > --- a/drivers/gpu/drm/arm/malidp_hw.c
> > +++ b/drivers/gpu/drm/arm/malidp_hw.c
> > @@ -76,33 +76,38 @@ static const struct malidp_format_id malidp550_de_formats[] = {
> >  
> >  static const struct malidp_layer malidp500_layers[] = {
> >  	{ DE_VIDEO1, MALIDP500_DE_LV_BASE, MALIDP500_DE_LV_PTR_BASE,
> > -		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, ROTATE_ANY },
> > +		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, ROTATE_ANY,
> > +		MALIDP500_DE_LV_AD_CTRL },
> >  	{ DE_GRAPHICS1, MALIDP500_DE_LG1_BASE, MALIDP500_DE_LG1_PTR_BASE,
> > -		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
> > +		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY, MALIDP500_DE_LG1_AD_CTRL },
> >  	{ DE_GRAPHICS2, MALIDP500_DE_LG2_BASE, MALIDP500_DE_LG2_PTR_BASE,
> > -		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
> > +		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY, MALIDP500_DE_LG2_AD_CTRL },
> >  };
> >  
> >  static const struct malidp_layer malidp550_layers[] = {
> >  	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
> > -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
> > +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
> > +		MALIDP550_DE_LV1_AD_CTRL },
> >  	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
> > -		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
> > +		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY, MALIDP550_DE_LG_AD_CTRL },
> >  	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
> > -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
> > +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
> > +		MALIDP550_DE_LV2_AD_CTRL },
> >  	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
> > -		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE },
> > +		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE, 0 },
> >  };
> >  
> >  static const struct malidp_layer malidp650_layers[] = {
> >  	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
> > -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
> > +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
> > +		MALIDP550_DE_LV1_AD_CTRL },
> >  	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
> > -		MALIDP_DE_LG_STRIDE, 0, ROTATE_COMPRESSED },
> > +		MALIDP_DE_LG_STRIDE, 0, ROTATE_COMPRESSED, MALIDP550_DE_LG_AD_CTRL },
> >  	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
> > -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
> > +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
> > +		MALIDP550_DE_LV2_AD_CTRL },
> >  	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
> > -		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE },
> > +		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE, 0 },
> >  };
> >  
> >  #define SE_N_SCALING_COEFFS	96
> > diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
> > index 4390243..bbe6883 100644
> > --- a/drivers/gpu/drm/arm/malidp_hw.h
> > +++ b/drivers/gpu/drm/arm/malidp_hw.h
> > @@ -67,6 +67,8 @@ struct malidp_layer {
> >  	u16 stride_offset;	/* offset to the first stride register. */
> >  	s16 yuv2rgb_offset;	/* offset to the YUV->RGB matrix entries */
> >  	enum rotation_features rot;    /* type of rotation supported */
> > +	/* address offset for the AFBC decoder registers */
> > +	u16 afbc_decoder_offset;
> >  };
> >  
> >  enum malidp_scaling_coeff_set {
> > diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> > index 533cdde..3950504 100644
> > --- a/drivers/gpu/drm/arm/malidp_planes.c
> > +++ b/drivers/gpu/drm/arm/malidp_planes.c
> > @@ -330,6 +330,71 @@ static void malidp_de_set_color_encoding(struct malidp_plane *plane,
> >  	}
> >  }
> >  
> > +static void malidp_set_plane_base_addr(struct drm_framebuffer *fb,
> > +				       struct malidp_plane *mp,
> > +				       int plane_index)
> > +{
> > +	dma_addr_t paddr;
> > +	u16 ptr;
> > +	struct drm_plane *plane = &mp->base;
> > +	bool afbc = fb->modifier ? true : false;
> 
> The decision to set afbc based on wether the fb has a modifier or not
> seems a bit weak. Should we also (at least) check that the modifier is
> an ARM one?

In my next patch (of this series) ie
https://patchwork.kernel.org/patch/10466537/, we have checked for the
validity of modifier and format in malidp_format_mod_supported(). When
drm_atomic_commit() is invoked, it first calls (indirectly via some
intermediate functions)
malidp_format_mod_supported() and then invokes
malidp_set_plane_base_addr(). So there is no way that an invalid
modifier could be passed to malidp_set_plane_base_addr(). If
malidp_format_mod_supported() returns error then drm_atomic_commit()
would return error too.
> 
> > +
> > +	ptr = mp->layer->ptr + (plane_index << 4);
> > +
> > +	/*
> > +	 * For AFBC buffers, cropping is handled by AFBC decoder rather than
> > +	 * pointer manipulation.
> > +	 */
> > +	if (!afbc) {
> > +		paddr = drm_fb_cma_get_gem_addr(fb, plane->state,
> > +						plane_index);
> > +	} else {
> > +		struct drm_gem_cma_object *obj;
> > +
> > +		obj = drm_fb_cma_get_gem_obj(fb, plane_index);
> > +
> > +		if (WARN_ON(!obj))
> > +			return;
> > +		paddr = obj->paddr;
> > +	}
> > +
> > +	malidp_hw_write(mp->hwdev, lower_32_bits(paddr), ptr);
> > +	malidp_hw_write(mp->hwdev, upper_32_bits(paddr), ptr + 4);
> > +}
> > +
> > +static void malidp_de_set_plane_afbc(struct drm_plane *plane)
> > +{
> > +	struct malidp_plane *mp;
> > +	u32 src_w, src_h, val = 0, src_x, src_y;
> > +	struct drm_framebuffer *fb = plane->state->fb;
> > +
> > +	mp = to_malidp_plane(plane);
> > +
> > +	/* convert src values from Q16 fixed point to integer */
> > +	src_w = plane->state->src_w >> 16;
> > +	src_h = plane->state->src_h >> 16;
> > +	src_x = plane->state->src_x >> 16;
> > +	src_y = plane->state->src_y >> 16;
> > +
> > +	val = ((fb->width - (src_x + src_w)) << MALIDP_AD_CROP_RIGHT_OFFSET) |
> > +		   src_x;
> > +	malidp_hw_write(mp->hwdev, val,
> > +			mp->layer->afbc_decoder_offset + MALIDP_AD_CROP_H);
> > +
> > +	val = ((fb->height - (src_y + src_h)) << MALIDP_AD_CROP_BOTTOM_OFFSET) |
> > +		   src_y;
> > +	malidp_hw_write(mp->hwdev, val,
> > +			mp->layer->afbc_decoder_offset + MALIDP_AD_CROP_V);
> > +
> > +	val = MALIDP_AD_EN;
> > +	if (fb->modifier & AFBC_FORMAT_MOD_SPLIT)
> > +		val |= MALIDP_AD_BS;
> > +	if (fb->modifier & AFBC_FORMAT_MOD_YTR)
> > +		val |= MALIDP_AD_YTR;
> > +
> > +	malidp_hw_write(mp->hwdev, val, mp->layer->afbc_decoder_offset);
> > +}
> > +
> >  static void malidp_de_plane_update(struct drm_plane *plane,
> >  				   struct drm_plane_state *old_state)
> >  {
> > @@ -338,6 +403,7 @@ static void malidp_de_plane_update(struct drm_plane *plane,
> >  	u32 src_w, src_h, dest_w, dest_h, val;
> >  	int i;
> >  	bool format_has_alpha = plane->state->fb->format->has_alpha;
> > +	struct drm_framebuffer *fb = plane->state->fb;
> >  
> >  	mp = to_malidp_plane(plane);
> >  
> > @@ -349,15 +415,9 @@ static void malidp_de_plane_update(struct drm_plane *plane,
> >  
> >  	malidp_hw_write(mp->hwdev, ms->format, mp->layer->base);
> >  
> > -	for (i = 0; i < ms->n_planes; i++) {
> > -		/* calculate the offset for the layer's plane registers */
> > -		u16 ptr = mp->layer->ptr + (i << 4);
> > -		dma_addr_t fb_addr = drm_fb_cma_get_gem_addr(plane->state->fb,
> > -							     plane->state, i);
> > +	for (i = 0; i < ms->n_planes; i++)
> > +		malidp_set_plane_base_addr(fb, mp, i);
> >  
> > -		malidp_hw_write(mp->hwdev, lower_32_bits(fb_addr), ptr);
> > -		malidp_hw_write(mp->hwdev, upper_32_bits(fb_addr), ptr + 4);
> > -	}
> >  	malidp_de_set_plane_pitches(mp, ms->n_planes,
> >  				    plane->state->fb->pitches);
> >  
> > @@ -381,6 +441,11 @@ static void malidp_de_plane_update(struct drm_plane *plane,
> >  				LAYER_H_VAL(src_w) | LAYER_V_VAL(src_h),
> >  				mp->layer->base + MALIDP550_LS_R1_IN_SIZE);
> >  
> > +	if (fb->modifier)
> > +		malidp_de_set_plane_afbc(plane);
> > +	else
> > +		malidp_hw_write(mp->hwdev, 0, mp->layer->afbc_decoder_offset);
> 
> Given that you are testing for the non-zero value of fb->modifier inside
> malidp_de_set_plane_afbc() function before setting the afbc_decoder
> register value, I feel that you could take the 'else' branch from here
> and merge it into malidp_de_set_plane_afbc() function (possibly also
> rename it to malidp_de_set_plane).

I am not exactly sure what you meant here. We are testing for the non
zero value of fb->modifier in malidp_de_plane_update(). If
fb->modifier is not zero, we set the afbc specific registers in
malidp_de_set_plane_afbc(). Thus, malidp_de_plane_update()  will
invoke malidp_de_set_plane_afbc() for setting afbc stuff and will
continue with the other register settings. I do not see a clear reason
to refactor this code.

> With those small changes:
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> Best regards,
> Liviu
> 
> 
> > +
> >  	/* first clear the rotation bits */
> >  	val = malidp_hw_read(mp->hwdev, mp->layer->base + MALIDP_LAYER_CONTROL);
> >  	val &= ~LAYER_ROT_MASK;
> > diff --git a/drivers/gpu/drm/arm/malidp_regs.h b/drivers/gpu/drm/arm/malidp_regs.h
> > index 149024f..54f4ec5 100644
> > --- a/drivers/gpu/drm/arm/malidp_regs.h
> > +++ b/drivers/gpu/drm/arm/malidp_regs.h
> > @@ -180,10 +180,13 @@
> >  #define MALIDP500_LV_YUV2RGB		((s16)(-0xB8))
> >  #define MALIDP500_DE_LV_BASE		0x00100
> >  #define MALIDP500_DE_LV_PTR_BASE	0x00124
> > +#define MALIDP500_DE_LV_AD_CTRL		0x00400
> >  #define MALIDP500_DE_LG1_BASE		0x00200
> >  #define MALIDP500_DE_LG1_PTR_BASE	0x0021c
> > +#define MALIDP500_DE_LG1_AD_CTRL	0x0040c
> >  #define MALIDP500_DE_LG2_BASE		0x00300
> >  #define MALIDP500_DE_LG2_PTR_BASE	0x0031c
> > +#define MALIDP500_DE_LG2_AD_CTRL	0x00418
> >  #define MALIDP500_SE_BASE		0x00c00
> >  #define MALIDP500_SE_CONTROL		0x00c0c
> >  #define MALIDP500_SE_PTR_BASE		0x00e0c
> > @@ -208,10 +211,13 @@
> >  #define MALIDP550_LV_YUV2RGB		0x00084
> >  #define MALIDP550_DE_LV1_BASE		0x00100
> >  #define MALIDP550_DE_LV1_PTR_BASE	0x00124
> > +#define MALIDP550_DE_LV1_AD_CTRL	0x001B8
> >  #define MALIDP550_DE_LV2_BASE		0x00200
> >  #define MALIDP550_DE_LV2_PTR_BASE	0x00224
> > +#define MALIDP550_DE_LV2_AD_CTRL	0x002B8
> >  #define MALIDP550_DE_LG_BASE		0x00300
> >  #define MALIDP550_DE_LG_PTR_BASE	0x0031c
> > +#define MALIDP550_DE_LG_AD_CTRL		0x00330
> >  #define MALIDP550_DE_LS_BASE		0x00400
> >  #define MALIDP550_DE_LS_PTR_BASE	0x0042c
> >  #define MALIDP550_DE_PERF_BASE		0x00500
> > @@ -223,6 +229,20 @@
> >  #define MALIDP550_CONFIG_VALID		0x0c014
> >  #define MALIDP550_CONFIG_ID		0x0ffd4
> >  
> > +/* AFBC register offsets relative to MALIDPXXX_DE_LX_AD_CTRL */
> > +/* The following register offsets are common for DP500, DP550 and DP650 */
> > +#define MALIDP_AD_CROP_H                0x4
> > +#define MALIDP_AD_CROP_V                0x8
> > +#define MALIDP_AD_END_PTR_LOW           0xc
> > +#define MALIDP_AD_END_PTR_HIGH          0x10
> > +
> > +/* AFBC decoder Registers */
> > +#define MALIDP_AD_EN                    BIT(0)
> > +#define MALIDP_AD_YTR                   BIT(4)
> > +#define MALIDP_AD_BS                    BIT(8)
> > +#define MALIDP_AD_CROP_RIGHT_OFFSET     16
> > +#define MALIDP_AD_CROP_BOTTOM_OFFSET    16
> > +
> >  /*
> >   * Starting with DP550 the register map blocks has been standardised to the
> >   * following layout:
> > -- 
> > 2.7.4
> > 
> 
> -- 
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ??\_(???)_/??
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

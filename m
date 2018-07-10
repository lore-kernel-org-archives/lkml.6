Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0E6C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BB6208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ZcXfzfOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BB6208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933381AbeGJMje (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:39:34 -0400
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:36666
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933169AbeGJMjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8R4ealVTLxsaSWs7BaVbIbK3UCLP7No2eKWq7mrF5To=;
 b=ZcXfzfOurSnlzuaKQYSEGjW/USLvgjSF7mq4okwvuotKBwGJNT3r4XdGuzfTREM8oaIbtlx2UmQ7UwgW7WkJe2S2bCkPPuQqJPGmgNhssrj2I422RqRKUtt6ICDAUA354zRlroyPYbW+OcEjK5eyJe1zclisXwTb0H3R+KdP4nk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from localhost (217.140.96.140) by
 AM5PR0801MB1378.eurprd08.prod.outlook.com (2603:10a6:203:1f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Tue, 10 Jul
 2018 12:39:29 +0000
Date:   Tue, 10 Jul 2018 13:39:25 +0100
From:   Ayan Halder <ayan.halder@arm.com>
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@foss.arm.com>, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        malidp@foss.arm.com, nd@arm.com
Subject: Re: [RFC PATCH 3/4] drm/arm/malidp: Set the AFBC register bits if
 the framebuffer has AFBC modifier
Message-ID: <20180710123925.GA1544@arm.com>
References: <1529070694-21088-1-git-send-email-ayan.halder@arm.com>
 <1529070694-21088-4-git-send-email-ayan.halder@arm.com>
 <20180626131716.GA14974@e110455-lin.cambridge.arm.com>
 <20180705133147.GA31243@arm.com>
 <20180705173821.GI15340@e110455-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705173821.GI15340@e110455-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: MRXP264CA0040.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::28) To AM5PR0801MB1378.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3576a379-56fc-4d74-88a5-08d5e6622dd6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1378;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;3:MIuQSLoBQeZXRWIiUxF55Oz7LC2DOYKjajhxKXqJQGMrDG4cRU5WCuFLdwkfo4m/VRujugQZep5v4tSEDutGCH6AoGg7vaDEHmo2FtaEVs36T1/Q1HotixsHzVo8Z89eYoxk2VIPdn0x8iXPF7YQ8931vhbcsGlPdkGKspWcgJLlrLm7jESC2vHJNS6xX2NkS8zhHAv9rrX+AxB5hd4poIjTpNqggTKPcp30Gzoy12OLP5S4JaZ0gq65/dQVdiD6;25:zHWfB1vpHoiS6RT85hkbGD7buRaJLIJx2Ia74jFAmlnFHceKo7s/xIx1sxjlJfHUd0m+fU4chJf7zHw2GDb+wNjeWh31UrWXI8WlLN0Q8vfBxnaysfHuKtdMX4OMdL6m+iQaCPC7JXsck0rk4LShBER1wV/M0HIF93oYmMNUkh7UxG3RoWlYZxVRDz5vm4DNs7MmsWeLtcJrzxpVYL/MY4CTY+LM89e/MARcgD7yFcYs50kBLpv3oAjKeGXNWru8tEuEPe8dZbd+7tT0fAmPa47ooaUqA3QZ0IAOPJZkQB/yAGKoxmFg+tjwbysPNmdT0qFtJ/I63gawhUglDw4wSA==;31:jL9OQmKO7hmUGszIFOBHw6dAAipAznVlj611WYP+hECXlwgokqm9c5gzzhXR6I4SsbmBMdHA7RMM8MMzoWkpwhITV0VlMd1fFd2oAAMLQh5oQJeqZ4rUZJPvoO2RA+BTMWgWNtwgDRHhBi5bySPPwRgKfZmn3MVZ8DaQHN7OB39SSiTzA2GAxfWHQo0WajcOS0kSHJjteIe1yJyvbFV0lFGdclrfJVuv98oCJ8UrWME=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1378:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;20:06F/3bta2rjb0xvlLyi9vrsDiYOaG4NtOh8MLzI3Y6llcvm/63nIUprAq1ABvIvTPFrlYRusslG4u+tkO1oBVrQfIgpYso64cvnrzW/SPpDH3ClaXIkBwooUO39sceGXmgpqGsAzMOLsFcqxCLnp6iwbeQlV7JBgYyhtBoSL1c0=;4:7MEjeD4RHKFW2ZNkswYbwQ7mhw0PPpMCT2l8JvOQyzSWMcEaVh6XkpH00NO40CnlLU+T9bIOvBZL0rCTuetXoDN6KS/OorPP5U45/z7Oj4cCMYvXRh0En0wgtq2ziOAK9ylxK6PSJ12K54LXbkb0XLERIeTOnWDYGob8nfev4sZgWumeUD/fUuaz1ymOaGLKiD2tQvNGZKtCjipq85yAKkhE7yAxX8jJk2RgASeZsSXBJDW1u5T4OcXA/PKYlo9EjirDUKr3s1I4Xz4qPeNn2nPxohbIS7XKVmzpP0Xpxr1zh2zXi8Gx5iBBqiz29NBxoMrlpujpkB3skkT5MX7jB4Gugl0+FinHRP+0Ujbcv08dKcqVAOd0eUNStArg/qQy
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1378B0B9AF7D228DEAEF2DF0E45B0@AM5PR0801MB1378.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(217544274631240)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1378;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1378;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(136003)(366004)(396003)(376002)(346002)(39860400002)(51914003)(199004)(189003)(6116002)(25786009)(86362001)(575784001)(6246003)(16526019)(16586007)(2616005)(476003)(11346002)(53936002)(5660300001)(4326008)(316002)(37006003)(956004)(97736004)(44832011)(23726003)(6486002)(58126008)(386003)(14444005)(1076002)(3846002)(486006)(6862004)(446003)(26005)(2906002)(8936002)(47776003)(6496006)(68736007)(8676002)(478600001)(72206003)(81156014)(45080400002)(81166006)(7736002)(6666003)(33656002)(305945005)(93886005)(6636002)(66066001)(76176011)(966005)(6306002)(105586002)(76506005)(106356001)(52116002)(229853002)(36756003)(50466002)(18370500001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1378;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0801MB1378;23:J4hhNkKZ31CZ30gVqDvI2amANAhpMzgGsms1taB?=
 =?us-ascii?Q?bxnpjMCwem4RgmcJHSIHnqFXWMJmqxrANveT6bY6NDSKFHc6p7Q9hXnzCeqQ?=
 =?us-ascii?Q?iEmuYK+KwHQlPbmYVXT6cyy8YHjzYjONeK0PhQsta118UdjG2sEEQOla+26b?=
 =?us-ascii?Q?dOFpLaqGGFFE0T6faS06wv2C+zn1/o5pKw9gYwoP6EzsAU7Bh8a4tZ7r44h9?=
 =?us-ascii?Q?ycEhsUrm1skcKwXFa2AZGjX8Gyg7joy9UcMNkSLcoKnPpOijy3t160dZcrz/?=
 =?us-ascii?Q?plEaDwcIQjXY5/Fzhlrs41wik8BW9CYHchokilQS6rzkOO8C4xOz2TqPL3wD?=
 =?us-ascii?Q?AmKOzL/EpL6C6+V9DS5gXK93yWbVOsXRhF/j7mRQMh9KhqpzUAQgkzAgM6RJ?=
 =?us-ascii?Q?eqtSsNFEpmGcRVUQdaDF+cEPw7dK1BdWL+RI7oPr+Jp38v9syF41ZdMRb/dg?=
 =?us-ascii?Q?wAiK1P/8hD5ax5lpkjaW5OJDhRcoZYtWuMDNdSG+he8FFzW+kPJBGZavdA5h?=
 =?us-ascii?Q?ZbtbK44WGp25wvYyVbtbx6ueowsO35OH3WBBo+bKkryVKymP7z/0iLjv8A38?=
 =?us-ascii?Q?f0AmJ4qX84TBGv1BcFftgnXXw85EVKYWypurWVee8lAwxs0Ajv98gizjzbOB?=
 =?us-ascii?Q?QVExCRdJEu3CALWR2AQQiL3Qpx4sKazL6T5xvFm8+YjU29VxbGw4CuEmUFn3?=
 =?us-ascii?Q?PLhjuYU+7vpswjjmIBHogvmvWt0skckQck3t+gWVTgcrUFXpbUs8NdmlC+jP?=
 =?us-ascii?Q?SQ0thDCkvaTRD9CUs3AIMmOdpn2S98JIy4kcTjw0Q1MzVvvS1jCjrErBROdW?=
 =?us-ascii?Q?DiOBStJ7RV4rZIhnh68yTd8dkTPtqkMZqCDzoL0A1m5M6+0D/yyzdekdwSj3?=
 =?us-ascii?Q?3sD1XR+hMuD10GlhHb3URw5Zf5/eikctNKomQzdGsUL+amMSg2IVEsendZGP?=
 =?us-ascii?Q?8rTXVqa8YnFcGOkab4MEQOmPm3UgL6m13SXEcj3IaiuA5MAt4+qUDRYw7hK6?=
 =?us-ascii?Q?xvmJ240ctNFVggbAd1yuBfdzcQY4qWGkZqoOR62U9mPhyQdycWSJrNThswMG?=
 =?us-ascii?Q?b9HFc8BML96ABUmWJCTKOCAdY/yzLVQQpbFq3fbD/XpJ3neSfxkMocxrsP3d?=
 =?us-ascii?Q?lP282HdB3oF4Tm1KPDemcvLXD+r+7ClKIO4CCTgfmai29LDcnc2DDxxWUe5h?=
 =?us-ascii?Q?Q55bzGkv07dGnzKabc6qg9iLse1L07XrEPxjIghC1JS3bpaX6Z85OPVNaTKE?=
 =?us-ascii?Q?rxxdmEnznVD8wV8HtBa8pJppWyQjCBEhDYgucUnBIUsK7qJbFWYW2tAGH+7I?=
 =?us-ascii?Q?51zwye6t4oRcN8B6p5b4tRXzlBf6jtWykJXffFEvC07kQyX2YQNmOV5e0H/O?=
 =?us-ascii?Q?etGIdXFsJz/gIKbmnnWyOphqZXrxzcwnL4AuIi84M/mf971nOEtHI4Z20CEv?=
 =?us-ascii?Q?Mu12m2lCNg9zhXvnxzJsJoYXPH0xHK1wAP8/1gQc6VWQGY1wBv8t9pua2iIT?=
 =?us-ascii?Q?MX9sMIysHNrBjeU2ULmeOqXk/484a21Cr+TU=3D?=
X-Microsoft-Antispam-Message-Info: BtsBhbk2G8/d4v+lspttyeR2rRFJKWGOCtHHrF71G1b3tZQovhKguZ5eZD3S8yA+rcB5iIGF/N3ni82y7a7aEyi3bPM9GagV13CDSER0AWXcxfKTGgxvX+VDqIpgi5pl/Nes1qGI0edlku8AfL6YhEgxu5vAY1/26OH89rdA/i+e9XQVHGgrAjzjN139MWHGW1vBeXOLeNqR3okvc2Ze9y+HNTsIZVg1/utrVNyeSBSo/sAEx0VI6n5FUQQ8Y6Ibqt2n+HpLbOIZZShYBnSbei9zTKSax0ilnoZBX3cSmBJ7etlugr91yfqXJfGldRKN4FR3iPd2YRDoBDISC2lyMDa5j+D0Pjxs+aUFlEd7Yxk=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;6:o6r+HJhYOKVgPAlh0QHxhI/gpu7OHoa+lTR1AQvH/kPMAV73FsEzdvvIZmcwwvsZco0tN9DHbptOFU7/ZWVfpohIbHbILU+u/6VeSolvEJ+dUok881B/pdCr8n8iB2CywkhSHLmjB1dJEK+POvD5chVlZB+aloQmM5FTURuzvDF5vzk4m0T7ZgzaJYpjNUrzi9bRjLS6IHZDugj9XBBXzxUIxZ2US2pQ9KAwx/M+1yBpyd0d6B0AiH0rBrCYsQjxRzYP7Fn1dic/FSmBGSTm5sQdjhq2FPl7q4G6BB8z17EKRvArMipYD0gXYNOwM4SNcCspwHAjQRpvSoUCzuK/CMW44QqWCPtzHsXo26sSMOvtDeDsgeydz0PPp9nJ5CHd4YXJnBLDIYnk++8eZoVxdWAvnjFwySoUq6Wgh/qZsBnbvDLbsmFCAkYl0n8qYgFcJRYAioHvf4ezFI3q68TGuQ==;5:cg19f3G3HrMF6hK2PlDvJDn1+1/y6oOsO2BUTmFX0CJmTJpVEBckir6yLiu5Wh225jivDWd7snw9Uz9JBGN4JsRUIzeuDPN/flXxGX00BONEcdN+vmcmi68NMiHa8lBuQARp5pPUGcDKVtZ3mA2a9n1czoCUdkeyLNLyG+htQog=;24:0MYGBSLam7dTv6AHzBBKrPjj6VGyJE/fuhxFV3XfT7TdUVzsnrPX69wd1brqiN39Kj2wrmcw84pnMHnL6UgGvcYe+8WlhziY3nwc+urU+J4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;7:SwY1xPDdbhwC4PT4x1mOlyX03bx2ugB1951Ms/KhE4DAblN4UYlyV7wFsS9xyr3PXe73ibcRjD5AnVDSyFRV7HiiZQk0nQOB9B2RVeVj9w9kwnYYVMlphXJJAAMW1TJSoMILWPnuSutj72c4BdI7fsIE9B/ijtH8JlAqk9ULA9P+ohl8tZwdGvejoBeAx5c0OGGbM2uIeD0H5MDDRpe5JI1ehHCJIHLlxBT5ONG++tgf8fcciqX/RFK01/faCvua
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 12:39:29.1419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3576a379-56fc-4d74-88a5-08d5e6622dd6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1378
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liviu,
On Thu, Jul 05, 2018 at 06:38:21PM +0100, Liviu Dudau wrote:
> On Thu, Jul 05, 2018 at 02:31:47PM +0100, Ayan Halder wrote:
> > On Tue, Jun 26, 2018 at 02:17:17PM +0100, Liviu Dudau wrote:
> > > Hi Ayan,
> > > 
> > > Thanks for the patch! I have some small comments to make:
> > > 
> > > On Fri, Jun 15, 2018 at 02:51:33PM +0100, Ayan Kumar Halder wrote:
> > > > Added the AFBC decoder registers for DP500 , DP550 and DP650.
> > > > These registers control the processing of AFBC buffers. It controls various
> > > > features like AFBC decoder enable, lossless transformation and block split
> > > > as well as setting of the left, right, top and bottom cropping of AFBC buffers
> > > > (in number of pixels).
> > > > All the layers (except DE_SMART) support framebuffers with AFBC modifiers.
> > > > One needs to set the pixel values of the top, left, bottom and right cropping
> > > > for the AFBC framebuffer.
> > > > Added the functionality in malidp_de_plane_update() to set the various
> > > > registers for AFBC decoder, depending on the modifiers.
> > > > 
> > > > Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> > > > Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> > > > ---
> > > >  drivers/gpu/drm/arm/malidp_hw.c     | 27 ++++++++-----
> > > >  drivers/gpu/drm/arm/malidp_hw.h     |  2 +
> > > >  drivers/gpu/drm/arm/malidp_planes.c | 81 +++++++++++++++++++++++++++++++++----
> > > >  drivers/gpu/drm/arm/malidp_regs.h   | 20 +++++++++
> > > >  4 files changed, 111 insertions(+), 19 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> > > > index 4dbf39f..fd6b510 100644
> > > > --- a/drivers/gpu/drm/arm/malidp_hw.c
> > > > +++ b/drivers/gpu/drm/arm/malidp_hw.c
> > > > @@ -76,33 +76,38 @@ static const struct malidp_format_id malidp550_de_formats[] = {
> > > >  
> > > >  static const struct malidp_layer malidp500_layers[] = {
> > > >  	{ DE_VIDEO1, MALIDP500_DE_LV_BASE, MALIDP500_DE_LV_PTR_BASE,
> > > > -		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, ROTATE_ANY },
> > > > +		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, ROTATE_ANY,
> > > > +		MALIDP500_DE_LV_AD_CTRL },
> > > >  	{ DE_GRAPHICS1, MALIDP500_DE_LG1_BASE, MALIDP500_DE_LG1_PTR_BASE,
> > > > -		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
> > > > +		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY, MALIDP500_DE_LG1_AD_CTRL },
> > > >  	{ DE_GRAPHICS2, MALIDP500_DE_LG2_BASE, MALIDP500_DE_LG2_PTR_BASE,
> > > > -		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
> > > > +		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY, MALIDP500_DE_LG2_AD_CTRL },
> > > >  };
> > > >  
> > > >  static const struct malidp_layer malidp550_layers[] = {
> > > >  	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
> > > > -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
> > > > +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
> > > > +		MALIDP550_DE_LV1_AD_CTRL },
> > > >  	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
> > > > -		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
> > > > +		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY, MALIDP550_DE_LG_AD_CTRL },
> > > >  	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
> > > > -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
> > > > +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
> > > > +		MALIDP550_DE_LV2_AD_CTRL },
> > > >  	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
> > > > -		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE },
> > > > +		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE, 0 },
> > > >  };
> > > >  
> > > >  static const struct malidp_layer malidp650_layers[] = {
> > > >  	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
> > > > -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
> > > > +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
> > > > +		MALIDP550_DE_LV1_AD_CTRL },
> > > >  	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
> > > > -		MALIDP_DE_LG_STRIDE, 0, ROTATE_COMPRESSED },
> > > > +		MALIDP_DE_LG_STRIDE, 0, ROTATE_COMPRESSED, MALIDP550_DE_LG_AD_CTRL },
> > > >  	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
> > > > -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
> > > > +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
> > > > +		MALIDP550_DE_LV2_AD_CTRL },
> > > >  	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
> > > > -		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE },
> > > > +		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE, 0 },
> > > >  };
> > > >  
> > > >  #define SE_N_SCALING_COEFFS	96
> > > > diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
> > > > index 4390243..bbe6883 100644
> > > > --- a/drivers/gpu/drm/arm/malidp_hw.h
> > > > +++ b/drivers/gpu/drm/arm/malidp_hw.h
> > > > @@ -67,6 +67,8 @@ struct malidp_layer {
> > > >  	u16 stride_offset;	/* offset to the first stride register. */
> > > >  	s16 yuv2rgb_offset;	/* offset to the YUV->RGB matrix entries */
> > > >  	enum rotation_features rot;    /* type of rotation supported */
> > > > +	/* address offset for the AFBC decoder registers */
> > > > +	u16 afbc_decoder_offset;
> > > >  };
> > > >  
> > > >  enum malidp_scaling_coeff_set {
> > > > diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> > > > index 533cdde..3950504 100644
> > > > --- a/drivers/gpu/drm/arm/malidp_planes.c
> > > > +++ b/drivers/gpu/drm/arm/malidp_planes.c
> > > > @@ -330,6 +330,71 @@ static void malidp_de_set_color_encoding(struct malidp_plane *plane,
> > > >  	}
> > > >  }
> > > >  
> > > > +static void malidp_set_plane_base_addr(struct drm_framebuffer *fb,
> > > > +				       struct malidp_plane *mp,
> > > > +				       int plane_index)
> > > > +{
> > > > +	dma_addr_t paddr;
> > > > +	u16 ptr;
> > > > +	struct drm_plane *plane = &mp->base;
> > > > +	bool afbc = fb->modifier ? true : false;
> > > 
> > > The decision to set afbc based on wether the fb has a modifier or not
> > > seems a bit weak. Should we also (at least) check that the modifier is
> > > an ARM one?
> > 
> > In my next patch (of this series) ie
> > https://patchwork.kernel.org/patch/10466537/, we have checked for the
> > validity of modifier and format in malidp_format_mod_supported(). When
> > drm_atomic_commit() is invoked, it first calls (indirectly via some
> > intermediate functions)
> > malidp_format_mod_supported() and then invokes
> > malidp_set_plane_base_addr(). So there is no way that an invalid
> > modifier could be passed to malidp_set_plane_base_addr(). If
> > malidp_format_mod_supported() returns error then drm_atomic_commit()
> > would return error too.
> > > 
> > > > +
> > > > +	ptr = mp->layer->ptr + (plane_index << 4);
> > > > +
> > > > +	/*
> > > > +	 * For AFBC buffers, cropping is handled by AFBC decoder rather than
> > > > +	 * pointer manipulation.
> > > > +	 */
> > > > +	if (!afbc) {
> > > > +		paddr = drm_fb_cma_get_gem_addr(fb, plane->state,
> > > > +						plane_index);
> > > > +	} else {
> > > > +		struct drm_gem_cma_object *obj;
> > > > +
> > > > +		obj = drm_fb_cma_get_gem_obj(fb, plane_index);
> > > > +
> > > > +		if (WARN_ON(!obj))
> > > > +			return;
> > > > +		paddr = obj->paddr;
> > > > +	}
> > > > +
> > > > +	malidp_hw_write(mp->hwdev, lower_32_bits(paddr), ptr);
> > > > +	malidp_hw_write(mp->hwdev, upper_32_bits(paddr), ptr + 4);
> > > > +}
> > > > +
> > > > +static void malidp_de_set_plane_afbc(struct drm_plane *plane)
> > > > +{
> > > > +	struct malidp_plane *mp;
> > > > +	u32 src_w, src_h, val = 0, src_x, src_y;
> > > > +	struct drm_framebuffer *fb = plane->state->fb;
> > > > +
> > > > +	mp = to_malidp_plane(plane);
> > > > +
> > > > +	/* convert src values from Q16 fixed point to integer */
> > > > +	src_w = plane->state->src_w >> 16;
> > > > +	src_h = plane->state->src_h >> 16;
> > > > +	src_x = plane->state->src_x >> 16;
> > > > +	src_y = plane->state->src_y >> 16;
> > > > +
> > > > +	val = ((fb->width - (src_x + src_w)) << MALIDP_AD_CROP_RIGHT_OFFSET) |
> > > > +		   src_x;
> > > > +	malidp_hw_write(mp->hwdev, val,
> > > > +			mp->layer->afbc_decoder_offset + MALIDP_AD_CROP_H);
> > > > +
> > > > +	val = ((fb->height - (src_y + src_h)) << MALIDP_AD_CROP_BOTTOM_OFFSET) |
> > > > +		   src_y;
> > > > +	malidp_hw_write(mp->hwdev, val,
> > > > +			mp->layer->afbc_decoder_offset + MALIDP_AD_CROP_V);
> > > > +
> > > > +	val = MALIDP_AD_EN;
> > > > +	if (fb->modifier & AFBC_FORMAT_MOD_SPLIT)
> > > > +		val |= MALIDP_AD_BS;
> > > > +	if (fb->modifier & AFBC_FORMAT_MOD_YTR)
> > > > +		val |= MALIDP_AD_YTR;
> > > > +
> > > > +	malidp_hw_write(mp->hwdev, val, mp->layer->afbc_decoder_offset);
> > > > +}
> > > > +
> > > >  static void malidp_de_plane_update(struct drm_plane *plane,
> > > >  				   struct drm_plane_state *old_state)
> > > >  {
> > > > @@ -338,6 +403,7 @@ static void malidp_de_plane_update(struct drm_plane *plane,
> > > >  	u32 src_w, src_h, dest_w, dest_h, val;
> > > >  	int i;
> > > >  	bool format_has_alpha = plane->state->fb->format->has_alpha;
> > > > +	struct drm_framebuffer *fb = plane->state->fb;
> > > >  
> > > >  	mp = to_malidp_plane(plane);
> > > >  
> > > > @@ -349,15 +415,9 @@ static void malidp_de_plane_update(struct drm_plane *plane,
> > > >  
> > > >  	malidp_hw_write(mp->hwdev, ms->format, mp->layer->base);
> > > >  
> > > > -	for (i = 0; i < ms->n_planes; i++) {
> > > > -		/* calculate the offset for the layer's plane registers */
> > > > -		u16 ptr = mp->layer->ptr + (i << 4);
> > > > -		dma_addr_t fb_addr = drm_fb_cma_get_gem_addr(plane->state->fb,
> > > > -							     plane->state, i);
> > > > +	for (i = 0; i < ms->n_planes; i++)
> > > > +		malidp_set_plane_base_addr(fb, mp, i);
> > > >  
> > > > -		malidp_hw_write(mp->hwdev, lower_32_bits(fb_addr), ptr);
> > > > -		malidp_hw_write(mp->hwdev, upper_32_bits(fb_addr), ptr + 4);
> > > > -	}
> > > >  	malidp_de_set_plane_pitches(mp, ms->n_planes,
> > > >  				    plane->state->fb->pitches);
> > > >  
> > > > @@ -381,6 +441,11 @@ static void malidp_de_plane_update(struct drm_plane *plane,
> > > >  				LAYER_H_VAL(src_w) | LAYER_V_VAL(src_h),
> > > >  				mp->layer->base + MALIDP550_LS_R1_IN_SIZE);
> > > >  
> > > > +	if (fb->modifier)
> > > > +		malidp_de_set_plane_afbc(plane);
> > > > +	else
> > > > +		malidp_hw_write(mp->hwdev, 0, mp->layer->afbc_decoder_offset);
> > > 
> > > Given that you are testing for the non-zero value of fb->modifier inside
> > > malidp_de_set_plane_afbc() function before setting the afbc_decoder
> > > register value, I feel that you could take the 'else' branch from here
> > > and merge it into malidp_de_set_plane_afbc() function (possibly also
> > > rename it to malidp_de_set_plane).
> > 
> > I am not exactly sure what you meant here. We are testing for the non
> > zero value of fb->modifier in malidp_de_plane_update(). If
> > fb->modifier is not zero, we set the afbc specific registers in
> > malidp_de_set_plane_afbc(). Thus, malidp_de_plane_update()  will
> > invoke malidp_de_set_plane_afbc() for setting afbc stuff and will
> > continue with the other register settings. I do not see a clear reason
> > to refactor this code.
> 
> What I'm suggesting is:
> 
>  - rename malidp_de_set_plane_afbc to malidp_de_set_plane()
>  - remove the if .. else malidp_hw_write(mp->hwdev, 0, mp->layer->afbc_decoder_offset);
>    and keep just the call to malidp_de_set_plane() without any other
>    condition
>  - inside malidp_de_set_plane(), change from:
> 	val = MALIDP_AD_EN;
>    to
> 	val = fb->modifier ? MALIDP_AD_EN : 0;
> 
>    and then the 0 value will be written correctly into the
>    afbc_decoder_offset if fb->modifier is zero.
> 
As discussed, I will consolidate all the AFBC specific register
configurations in a single function ie malidp_de_set_plane_afbc().
Thus, I will remove the "if (fb->modifier)" check from
malidp_de_plane_update() and add it in malidp_de_set_plane_afbc().

With this and  changes in other patches as well as the ack received,
I will send a v2 set of patches.

> Best regards,
> Liviu
> 
> > 
> > > With those small changes:
> > > 
> > > Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> > > 
> > > Best regards,
> > > Liviu
> > > 
> > > 
> > > > +
> > > >  	/* first clear the rotation bits */
> > > >  	val = malidp_hw_read(mp->hwdev, mp->layer->base + MALIDP_LAYER_CONTROL);
> > > >  	val &= ~LAYER_ROT_MASK;
> > > > diff --git a/drivers/gpu/drm/arm/malidp_regs.h b/drivers/gpu/drm/arm/malidp_regs.h
> > > > index 149024f..54f4ec5 100644
> > > > --- a/drivers/gpu/drm/arm/malidp_regs.h
> > > > +++ b/drivers/gpu/drm/arm/malidp_regs.h
> > > > @@ -180,10 +180,13 @@
> > > >  #define MALIDP500_LV_YUV2RGB		((s16)(-0xB8))
> > > >  #define MALIDP500_DE_LV_BASE		0x00100
> > > >  #define MALIDP500_DE_LV_PTR_BASE	0x00124
> > > > +#define MALIDP500_DE_LV_AD_CTRL		0x00400
> > > >  #define MALIDP500_DE_LG1_BASE		0x00200
> > > >  #define MALIDP500_DE_LG1_PTR_BASE	0x0021c
> > > > +#define MALIDP500_DE_LG1_AD_CTRL	0x0040c
> > > >  #define MALIDP500_DE_LG2_BASE		0x00300
> > > >  #define MALIDP500_DE_LG2_PTR_BASE	0x0031c
> > > > +#define MALIDP500_DE_LG2_AD_CTRL	0x00418
> > > >  #define MALIDP500_SE_BASE		0x00c00
> > > >  #define MALIDP500_SE_CONTROL		0x00c0c
> > > >  #define MALIDP500_SE_PTR_BASE		0x00e0c
> > > > @@ -208,10 +211,13 @@
> > > >  #define MALIDP550_LV_YUV2RGB		0x00084
> > > >  #define MALIDP550_DE_LV1_BASE		0x00100
> > > >  #define MALIDP550_DE_LV1_PTR_BASE	0x00124
> > > > +#define MALIDP550_DE_LV1_AD_CTRL	0x001B8
> > > >  #define MALIDP550_DE_LV2_BASE		0x00200
> > > >  #define MALIDP550_DE_LV2_PTR_BASE	0x00224
> > > > +#define MALIDP550_DE_LV2_AD_CTRL	0x002B8
> > > >  #define MALIDP550_DE_LG_BASE		0x00300
> > > >  #define MALIDP550_DE_LG_PTR_BASE	0x0031c
> > > > +#define MALIDP550_DE_LG_AD_CTRL		0x00330
> > > >  #define MALIDP550_DE_LS_BASE		0x00400
> > > >  #define MALIDP550_DE_LS_PTR_BASE	0x0042c
> > > >  #define MALIDP550_DE_PERF_BASE		0x00500
> > > > @@ -223,6 +229,20 @@
> > > >  #define MALIDP550_CONFIG_VALID		0x0c014
> > > >  #define MALIDP550_CONFIG_ID		0x0ffd4
> > > >  
> > > > +/* AFBC register offsets relative to MALIDPXXX_DE_LX_AD_CTRL */
> > > > +/* The following register offsets are common for DP500, DP550 and DP650 */
> > > > +#define MALIDP_AD_CROP_H                0x4
> > > > +#define MALIDP_AD_CROP_V                0x8
> > > > +#define MALIDP_AD_END_PTR_LOW           0xc
> > > > +#define MALIDP_AD_END_PTR_HIGH          0x10
> > > > +
> > > > +/* AFBC decoder Registers */
> > > > +#define MALIDP_AD_EN                    BIT(0)
> > > > +#define MALIDP_AD_YTR                   BIT(4)
> > > > +#define MALIDP_AD_BS                    BIT(8)
> > > > +#define MALIDP_AD_CROP_RIGHT_OFFSET     16
> > > > +#define MALIDP_AD_CROP_BOTTOM_OFFSET    16
> > > > +
> > > >  /*
> > > >   * Starting with DP550 the register map blocks has been standardised to the
> > > >   * following layout:
> > > > -- 
> > > > 2.7.4
> > > > 
> > > 
> > > -- 
> > > ====================
> > > | I would like to |
> > > | fix the world,  |
> > > | but they're not |
> > > | giving me the   |
> > >  \ source code!  /
> > >   ---------------
> > >     ??\_(???)_/??
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
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

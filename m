Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63D8ECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC5D20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="GLmcaZPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC5D20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbeGXBw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 21:52:26 -0400
Received: from mail-sn1nam01on0125.outbound.protection.outlook.com ([104.47.32.125]:12517
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388263AbeGXBw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 21:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63q9AeiWkpeWeBkdXV2uKkqrYdBASp3rKuCoxB+q8Eo=;
 b=GLmcaZPbnBsPGaoqM+CkIuPzrcbbiLJC9OX3a/ohQxJTn1u8kFcB8WGZ4pJtE2eAgSgfZQT8lQ146CKrePgUO+kiHv7Ee+R3U3D2mXQMDTfkSq+qcqbAVkY4YXDFO1QzAKqHy4JlGfnfpu/Ir/UbesyVx3gbVX/FOJGbjgjmI1s=
Received: from localhost (4.16.204.77) by
 BYAPR08MB4933.namprd08.prod.outlook.com (2603:10b6:a03:6a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 00:48:33 +0000
Date:   Mon, 23 Jul 2018 17:48:30 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: jz4740: Bump zload address
Message-ID: <20180724004830.6jvx2ngv5jvcutvr@pburton-laptop>
References: <20180708150712.7404-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180708150712.7404-1-paul@crapouillou.net>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR06CA0092.namprd06.prod.outlook.com
 (2603:10b6:4:3a::33) To BYAPR08MB4933.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce13145e-2c7c-4b42-3aa2-08d5f0ff2eec
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600073)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4933;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;3:orhPu4dsBxmfwmv8ttr0x/pFyPXrxEG2A6YjTT6aaNmgGNa1I92gDS9mLNn13790F9NPKDOJTJGPD5RCgqulEa5qW9eveG+iKkI6F4M1JFLXUifbq3//4eFOW8soWiN7zchWCMl55Bg4vGtVNpFF495TOw/SLyLp9+UJUeOaNeGfOdwqNjv4lOs66bFfONggvKqTikQ5tFR+Y4+Hb7BHXz1m1T1V6WhVYyOPvK+lWNJe4mC5oNZ8vT0o39UHXzuv;25:g6kNfehZ8Fel0zxBQOIX95r5HRls3KRBArfmjZHqpd6VVohFJ/9RGi2jPLFFru7oP3wv+8fUZkU9pVN9lkAWhv1Tvupu4FMfgF3NlBSD08Rxj0yi5lbA7o66ELUaugRS11YS4ZaNl68z4kSx6wxcCaD/fS8+hJ1cgzePHHH6yf4TOV5L9ld19dFq2I0cmg3UFCgmSruiMBsNx7RW8wmsWDfPL41xJJVQ3DZpsXok6E5R41C8GIOETNuXe4TluIhh90D5KtH6c5U6gy+qQyBjjdfZXXghE0wT7yFqYH1GtdpsQPsN9rDvBakRFPLxaVw2g8j+BmeJOzUrX9VFuZe+kw==;31:ZqnquNf0fZ/azleHULkWnO21r3E1bkcdVzXeRRRF0uKPJcQ0J/7oTozB00T1hUot5Tp7X0qcwWS+1LH+1CBxgfmBUTZJDm52Vg4G1DkU91eXHdWWcaMNFB9DhwNIqCNiGlf74hHWXX5qAbyAIcKHCRlo3YXLs/Q5nUNKefLGOtaDbWn6z/io4e82C293QmZv6XLKVLEN3dDDBcm/zIzMlmY3wAFmtuF8bvXic7A5tV0=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4933:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;20:irS26DpqhnFtZoyj6lmEKvgLdD5065LEzm3qyOEq9kiRZfxyWkUQJL7gwAdX+aTQzw2V0SopptWufjSuoMfLRgfothD/sU9hDJNk+wvPBc67gG3mKxkrQMaHIlzQiK/dnUW2+ISN3wprDcHB0TL0EtOqEuHLIzk361L25K9NRV5OknEKU17rEezwJK/2/WvVdiVK3p1eaAaPCoxyGUmOHDzhfFJm/4P9j2kSIFdiuw/Qtfq+cuAvuzW7ymos8vDH;4:8Z6psvBKl++dXddYm8KU3/942CdTqcbhxLDl3dXXvFIFs8c4NlozMDUCtZc0HmOcnd4wNlkAAiGfONV2JD3+3R3IlogYDypWWU9msxE99FTita+X1l1gfkP2/TJM4Kw6DFPpqJjqG5fMVl77zpt5uH9yB7lXFgBngYGfVdDl2uoL4RPf17DKhRbzRCQpy9itr5YXPIyf124NInAGCI2t4/dCA/QkerW9ggkqZoovW84bpZllLTBXDyD4osTRIj2v0PCx1xx9LeloGrK9uahaMg==
X-Microsoft-Antispam-PRVS: <BYAPR08MB49331B099A03A60D2864E5FBC1550@BYAPR08MB4933.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4933;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4933;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(39840400004)(136003)(376002)(396003)(366004)(189003)(199004)(105586002)(9686003)(47776003)(52116002)(66066001)(6496006)(76176011)(25786009)(106356001)(53936002)(386003)(81166006)(33896004)(8676002)(6486002)(50466002)(81156014)(6916009)(229853002)(8936002)(4326008)(6246003)(76506005)(7736002)(97736004)(305945005)(68736007)(186003)(956004)(58126008)(1076002)(11346002)(14444005)(486006)(16586007)(446003)(476003)(42882007)(54906003)(2906002)(26005)(33716001)(316002)(478600001)(16526019)(23726003)(5660300001)(3846002)(6116002)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4933;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4933;23:TVlLe/wiDakqVSMb3XK4SaZvuTRb5VpfOlqV5G485?=
 =?us-ascii?Q?xkQGFHXJgaCeiJpfbS3hNu6azZB+DtRLM0brK8xon8UbPo8pbrALvwNcceR9?=
 =?us-ascii?Q?jnJT9MvTfdTWJJX/3tqVqVytOr9CFj1bUH/1oezelEnBLZHsPWAs/3lIoM9C?=
 =?us-ascii?Q?dlgm3Hah7NydAQkogJwqDcfSjDM/ojXsunCajN2e+yzhOl4V43mZmn5b/fFE?=
 =?us-ascii?Q?z7qQTI70alFqQOzBfRtaezvAVInNedRmGeXRpnKTsKvkl05OjlVp4yfkrkEY?=
 =?us-ascii?Q?0dpnuxX/dyCm/g3+ncOglW9VpzM3r3bL/1kvH9iZnJX81yw+sKK+tF00PL0n?=
 =?us-ascii?Q?gFPTKQ/79+FnRtjOsvKX0bbKzD6JnkUkx8f2N++Mrx+bUFtgyyNn9uKxmjaL?=
 =?us-ascii?Q?YbeA/RMI1XuULGNChGqAvP0cgD5oYh7h4XjOm7pkWakC9kFpzzf01qPsVF4L?=
 =?us-ascii?Q?ixRTNHm1dawmjS6W23Jble+AK65thJvnREuCfijxRrLmpuuvQgHVMgIlGZN6?=
 =?us-ascii?Q?ZS6T5i0hmXgL0mLcdMw87+91SUvcfwclIkK1FO4+l1zoTjxIDSpACm0rouPK?=
 =?us-ascii?Q?JTBX/ou0iUrFoeHBZ8u2iDJwKFbOXtZnstK4Zb46WN2/jv3OkRCvc0eMoYt7?=
 =?us-ascii?Q?n3ncFPvJPSWZaEWJ9BthqH2llzCuLs+uMpcBVbFGOdy/j/YcTwAP6ajgVsSh?=
 =?us-ascii?Q?GpRAL5HMk1BwRXo1A9qQbKF5uzoKarmmG1PXQJfaVOhGTbBBEEHDTBdPCG60?=
 =?us-ascii?Q?5nT06B9e3Tqie/zlxTABsDTDv1KO0M8Yw5GUpAofyftdWP5oN+g4HkNmESvT?=
 =?us-ascii?Q?5ylVn6AOmrnf5oE0MxzIIuenkf83n492TunI3xCbXgORTO+PBnP5QhNOpo1d?=
 =?us-ascii?Q?9jkANncdTb6IruTdo5S1J9mDOyl5RE87XoISf6O5uW/0XxiDmiep4QEwwITl?=
 =?us-ascii?Q?DOfWd3tH4Jqvf33tUn7g2t043+OgqjE07l87YnFEmAVn8+8SscqIkuHcrSCv?=
 =?us-ascii?Q?AP5SI2X7c75lEvAKDbKr92cj5N/IqIOmjRUiM4P/0/3QBMlH4jwcITIVcUh5?=
 =?us-ascii?Q?rsYQD/oPbY6UHd5iGVDxq0Fks6Awn+EZhzVfNhf1m4XicP3zPzzSoB0tZSM9?=
 =?us-ascii?Q?L5DgNLc1l2PjoUB3QWDDgdsJCij6i6txwuKPeTQIWHpEPjILJgAE6yxNm9Ls?=
 =?us-ascii?Q?7887eigVQ/+JV6lG4SBdeHOAgkZAlcC4E8XjHJ/VdvCi3hlqzBeJhQfoNwGI?=
 =?us-ascii?Q?27l1wFX9tMAUHKQXxUQdjLFgmCBDkEDWQqkRh1TQydFfaPsjcovsesCOIBSS?=
 =?us-ascii?Q?PzYgjKZQvRYxyM2ERGWc2Q=3D?=
X-Microsoft-Antispam-Message-Info: pLqBtYMwTaXemg+Mr4Bz5nUm9TzYKrGV2vqnNN+ijTcmxGuQeN0gbIJofOL7MNTBnh/d71Y4+BVyEUnrL7h2RNaF3v34hXSASq/yelCYJua2R3rXdDapHHaGQMnTdqhWT+aH7i7tT+pya8nQzPhf6Ahj7QCYlDwafIp5uEfGH6v9lb7LoLqDCQCiClN0TZ4RB4Oeokc7sj1bVXwmHqEOi3Yq8hBDMbL/81G0uvn5qnrEOR9ifX15lMA41GqQSnj3PRI7Zq80I5DPezkefIuCUgrjKZlNKWurvNWIzmqwKZLjoyrFUAlMwbdhUJ5pLxx+dBy8waH6HTzmSsIi66D4V+gfUAynp1HGeT81IN1QdK0=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;6:C31unq6iOTiAzElFuz0t80DCSGC36Vh6wbxTFX+8jOMh1EdyePXwe50ZmGt7AyTbw/oqwbgYeWeJrirR7rJhX4QeCsdGh8eXYBrsfoD7L0jnbORZcXj7VPuTHnq4+Y77vOniiaaE54RYuj5F8xOjE73pRJNDTdmSbGICO9RlGwGjXJ6I47uR3khr+A/4VG92yRzYVF0NQjHAG8cI6fqtfHysmw2BM0dEQw8te2CwsmIYE4hEwaZ/BS6j+gr1V4QzslMqzUkSHbdM5RB70aFBNM2a9zMw0L8+h4AH43opZPrhpSSK0hxNLDcUde6b/9t9g8uGBRHI4YKI3oB9iCS3S7zd32Bznv1smriisA1uReW9qqAT8iLtLIonnY77KxNBd4kT966uKqOGswU56ypa5Q5r4M7YxsUqgxNFb6ka8hM6V3o4MbkBLCGDtw0ItpXkInsdPfn4quFDi/pnPVHWzA==;5:LCna/cKYo+evpZ/uZcgaQ33CvWRlY9AXC7VW8+ofqQSWcC+5wvJWCNglJJ1vUkpNRfKiWQf1xUg72XiKtbNGh5OVVkLVZieox2JJhg9BtXlw4CSjwCH40NOU5bd1DiLLaom3XkTOZemWucmhxFOd7Bvq9Fm8K8XxOTZ6uFoDX9s=;7:GLiS2qk3VcE0ihcIgVvpiWFDLGT9dPAEtu8CUNNNJZgovo4jaHsGwAKGo//Lw5RI7ePViU5Tj9CNC1XPG0iflOGytcWK+/cbb2gl1C7sFaMNc9olMnncDMz6Bn5lCec9qvQEt9pAqnhGoUFaEYw+H6Uua1dxykUCKLPyZuXiScyyMeDySHXgXby/+YYJpGTOcbXuV0db6ctaVGvvKRgtWLvvsgZmgWA/co05iwgjFHBPMPcahVoZTFlBbIxqcWkB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 00:48:33.5161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce13145e-2c7c-4b42-3aa2-08d5f0ff2eec
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4933
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Sun, Jul 08, 2018 at 05:07:12PM +0200, Paul Cercueil wrote:
> Having the zload address at 0x8060.0000 means the size of the
> uncompressed kernel cannot be bigger than around 6 MiB, as it is
> deflated at address 0x8001.0000.
> 
> This limit is too small; a kernel with some built-in drivers and things
> like debugfs enabled will already be over 6 MiB in size, and so will
> fail to extract properly.
> 
> To fix this, we bump the zload address from 0x8060.0000 to 0x8100.0000.
> 
> This is fine, as all the boards featuring Ingenic JZ SoCs have at least
> 32 MiB of RAM, and use u-boot or compatible bootloaders which won't
> hardcode the load address but read it from the uImage's header.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/jz4740/Platform | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks - applied to mips-next for 4.19 (and tested on Ci20).

Paul

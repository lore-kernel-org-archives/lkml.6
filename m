Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D43ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EC12147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="UyC/IoRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76EC12147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387952AbeGMCyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 22:54:13 -0400
Received: from mail-eopbgr700068.outbound.protection.outlook.com ([40.107.70.68]:31978
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387840AbeGMCyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 22:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twjvD1zC7bG7mmbIDNbDGm980ryef3HJ4zBR01txojw=;
 b=UyC/IoRE2sDhgz7mKzUSUy31UJ+JpOeb3Kk4Hbuu5hkR4gd7W7eAOw6Ro5hs2emLloXjkImy9of4mNn6mGiINC/ViP71qklniCOzj/UULwI2UWqSY3/H0i0rOcs1qRO4qtqT9XtPhjkT73jypy8PbVlyVfsYz1DAPeuuAKqKaNw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=syeh@vmware.com; 
Received: from vmware.com (66.170.99.1) by
 SN6PR05MB4014.namprd05.prod.outlook.com (2603:10b6:805:25::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.12; Fri, 13 Jul 2018 02:41:42 +0000
Date:   Thu, 12 Jul 2018 19:37:50 -0700
From:   Sinclair Yeh <syeh@vmware.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Christian Koenig <christian.koenig@amd.com>,
        Roger He <Hongbo.He@amd.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/ttm: use swap macro in ttm_bo_handle_move_mem
Message-ID: <20180713023750.GA30532@vmware.com>
References: <20180709152447.GA27520@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709152447.GA27520@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [66.170.99.1]
X-ClientProxiedBy: DM5PR06CA0084.namprd06.prod.outlook.com
 (2603:10b6:4:3a::25) To SN6PR05MB4014.namprd05.prod.outlook.com
 (2603:10b6:805:25::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccb22455-a8ca-4d14-989d-08d5e86a2b37
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR05MB4014;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4014;3:HyBUkWimyXW2AF5DzZ9sQQoHeX1mW6ralFjjD/lqF5Ck4sYvg1zWFBUksVl6EmmHuBUUFYzxXHVcNI6zSPGticwhNM7Ua62mYL8q9WeOP9t4q/frV3wRW92rO2cz/LMgftccjD7ACfQ0mtjOHmcXdFDrK4cTGOTbgLSs/w1DDOQF9aWWicIaKU2xesULhYhz+o7lI/B0qKcV8KqEARGqW4rvuxsjOb8Ft7JFCqsDqxzLiUM8R9YZfh0JsyARE4tS;25:gxbOorqACBHYfum7js/1w8cBoa5E/su5Ia1S7mTUCtglG+kUxBFP1eF4uRINKoIGpiWwOmSlwdqrIGyD09Sb9Kp8U/yASmyNqgzZ4FHZWa0neKO00lcDXPAvbc25dwQwp/+Yq4VreW1JQ5Y66QTtx0Lk0fI8s2g9Lo9jUwS13zhC4gyGLAjvNAPErKaXvTuEtzPzO+zKiOctReIiaikv66NiA+nEh0Hblq1FCl4kaaDVjQwMLy6f6wI7qIApiIqxMQKY2AT6jyi9N5w8N8B8xW4W4IfGpt7Bl7k5FEJfW9VCRiC/KzswHAqZ1RUHSfmucBKhslXNPiCxiEgI3bccxg==;31:Ew+5DU1m5woh1ZqRNFiBBvA2cRlfcn/OsB3Oh/xQXu8O/Me1Sf/DarcjB1f9LFTEfLffefBJCXc6vrO+81DUkbLGJc1LV22e/TEs/lT63IfImzWpXePG+EwbQFJvFAu9aoAIWfK39IbdzL+R+dWu+Bxc7RPtjWfm1PM6Qwh7PR4Rq5dRlLYuVaXOHXdgWYYrw2f4NBSlkYvo1rcfwzz42YHoDmSpM0GXmdkl1GC58/E=
X-MS-TrafficTypeDiagnostic: SN6PR05MB4014:
BCL:    0
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4014;20:svcWetAQfz+RMB4oCTVBmNwmUA8Sizl1+52Nqr+jnL9E0H6HfglwZAlQeA8a2lYnLID3thmncYWGQ1mEroTmipgjY7Ywwh3kjHXKZkp6IYYtQjyD55mmQqhFAPHor8P56fmp1SEyW4Xp8OCDPpfYRY/tFDHAM+4B8snlVMO0EL1Wu6Hu8vmce3qSPqj0ComRPdrJ/Om0RTTNthwekA1G5JLgjgfmBh/Y6qLwg8wFxEhkTJQnvDBtxAg+Bz4vaabd927WTNpLFEGIVOMP7Cn5+6yrugDFgk0Z5fgMHHRQsZnzTEDJf8rVlhAZiX8T7LQpo/5TNff9Piu6EczIIudJPpiD8sgPFRHNWd9QwlN40Y+QH6QaW71MZKVD53Q/OpTGwPVoMniqzGKw4kFf9i4Qnps32HhTi3DB797XQEljWiEu6vk54LeCsKh7A37koxU7fHCdZiPN2kYwSG0nxcat+abAcMLZWQPAXi49uj1/ztX7DI7NydBJFmi8lpBMu8kdXnTVcCVnOXcZfM315ZZGygwGR9ZRyU5lSarze3ulBCgVimIVfarhIGYq8DWAI9cWDYwbx9+9/hM5o2ix5hI4+XV9vxFb+5cK1kMLZUEj3qU=
X-Microsoft-Antispam-PRVS: <SN6PR05MB40144A901CC7CCCCA1522C0AA8580@SN6PR05MB4014.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(189930954265078)(217544274631240)(219752817060721);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR05MB4014;BCL:0;PCL:0;RULEID:;SRVR:SN6PR05MB4014;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4014;4:6WBFGQYb1lhydzoIyzhh0OnH2WKuf/NSO7suyvrafznCAp2GqqWk5Utm67eRSWY0Z298E/Y0/MOJRNT8N6x627a/Q6ZHUoHyzI+PPp9Sl8ob7dMZg2bOXqvpGMkPSf6p6dq/ARaMJYa1R28Vm3hAxp2o8flrLcS4tEd6kyRP39zWWO8vikf/yRkZn+IyR5en49PKP04sd6R5lo2LLR6AVfhp/LHxlH43jkNdukt+SYyavY6ZOu0NDV6AWaXeOiO0unUXEUKG56aIU0n+shkiKgADLHX30m8cGTzzxIFhodunmE10YkBGZWPa97nW/2wtBu/pxO2DKBuEmw3o7RV267jm5GM6+nX4k0yQcahpGfe36YwH/NCDPPPdSYNxya6s
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(366004)(346002)(189003)(199004)(45080400002)(2616005)(11346002)(86362001)(186003)(956004)(966005)(478600001)(58126008)(21086003)(6666003)(25786009)(386003)(446003)(68736007)(476003)(54906003)(66066001)(50466002)(6916009)(16586007)(36756003)(305945005)(52116002)(7736002)(33656002)(5660300001)(76176011)(7696005)(6116002)(1076002)(53936002)(23726003)(33026002)(97736004)(3846002)(229853002)(81166006)(8676002)(316002)(47776003)(55016002)(6306002)(106356001)(105586002)(8936002)(69596002)(6246003)(4326008)(486006)(2906002)(16526019)(81156014)(26005)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4014;H:vmware.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR05MB4014;23:84Ww+ixqhr8p6Yq8v+zeAstxGC3ZPqQ7RGAxeB8HL?=
 =?us-ascii?Q?QPaQ0gz8eG0V9cCOOOM6HFDdPZBzbnlrtlxPpJn7w9+dwu+Eya7wBEPfShQ0?=
 =?us-ascii?Q?SOx3rLn/jrw07YczAX6BJ9huP6M1L9LZaRjnhKCh/qGBjyCn6bWw09cSG3yv?=
 =?us-ascii?Q?ULihRvQB/FT0YBG8wZbVmlozzCw3Ar9f3gRkLip6xi1z+lEhYRzRROm4jY1k?=
 =?us-ascii?Q?Pvam/uFJaT1M+m1vZ6xbUW0J7oncos5y2fXMGrjdMGoWLm8sB/zAa86dv9ep?=
 =?us-ascii?Q?Vtgj6a7AT5l//aVlhoYJHAh2hVxpJtxm0amANXWEDQ1WFBsol5v3O8hAzl71?=
 =?us-ascii?Q?Va3QvzLt24Km77uOZhkfMx8Efacg1WCKA0Lvu8h6wrI3PtzPzqBaace0131X?=
 =?us-ascii?Q?rxqlyuEDunO3eCZb1RgfxcGyR6GWFfXh/yCbUNFlsVOnkLDfTd6hL6XEm6V3?=
 =?us-ascii?Q?h3Ga3oAxh13udA/aC5mxVVcptpNc4Z34e2Vh6mh63FPJo+jtkjts/MZO7BQW?=
 =?us-ascii?Q?o6diI3HHjTkXUx9sPg7PQqATOY0pwkXU7RffrN+ogq5RPjjD3aW40i2R2jlT?=
 =?us-ascii?Q?39xgICNllPp8zHMXP/g+12YT1H1pQ3lzWAybDdkHY6C/fJwALJve6rU/1+Iy?=
 =?us-ascii?Q?glrdEEC0qzPYiX73AOU2UAVlkSF/BwsCKnGOHq77tKiXi3f6lYdGsPfZcy58?=
 =?us-ascii?Q?neu0uR2vR/JFRH9EUD6hH/yLhS9s/yDKImQGLCt74KYslFj5xtL9PRehRSJN?=
 =?us-ascii?Q?iJuxRbL0Xi7eqgDVU0sYxfjDiysxLep0EIo78pHzQRQh/yekR9BI4BnjXGq1?=
 =?us-ascii?Q?PFewR+BPFwgPnNtbHjsEWN0rYJhuIFk9TcLHU8dZ3VNX9GR09PGlndVgJAoL?=
 =?us-ascii?Q?d5Hj6Q5S9NfgpXgl5V1DAwq7hYr8+ZNp8S97yyTb3lNNZxo9bgwFyXDg7T9G?=
 =?us-ascii?Q?K8aziIpvNP6f4YXOFZ31nySdUkdtkJhYwV2ZeoT3P1PUxfpB3rFcdD7wwpIN?=
 =?us-ascii?Q?eRWUgQo2Yj9xRhypJWAC+2ioUEFaVV7bpxAc/mgZz8VmIA70mb4LN+S54KRE?=
 =?us-ascii?Q?TVlXyP8PJ+YbQe6RkfxEI0Rp//EfobtV1D0KZZZXU/+VFgs+9FnlLrjp6OdJ?=
 =?us-ascii?Q?uLH/94rUvGTWpjHitBIcTe8SH342thZJF4NTTWSP48yLShmJyUMY6uuwhgb5?=
 =?us-ascii?Q?nrs+gZxdoR1uxOBJpRoJ9SE7BT/e8AopVAaVreQee2H9qAFYiEqL0/kDx+ce?=
 =?us-ascii?Q?xltcuSUXFUb5dK4kZxPsaWwZNbdIQCoKwctqUQ6Om/AjkG62xZn3UJv903gr?=
 =?us-ascii?Q?DwU680IH93WL47JLPLJ1Ol2NDsgBTBocA7tfD7UYfBjGSgKmLw6R6JErDFKQ?=
 =?us-ascii?Q?K5YuhaLt0N5Dl7Ek4DwwkFvMVM=3D?=
X-Microsoft-Antispam-Message-Info: vUdZUc4kd2E7PpCIrmLnnwVTympoUv6qEmYB7qyqJUk/OGd+I7XQ2CZrY/2ZJCvUXtwfmVUi4SBGrBedRSmIoqNT8NY9pZkmr5uQ1qLtYuv3kci7HmZ0zoCDGgUEJTR+5WDzdCMBSaiNrO/zfX4DTra7uKFeVnvrU6KWe5rxeqXl6aSw4c8OjXOfDyd43pGob/oqgY26OM2XdSi2x9/lMtAql4Zfws1JZfJGeqRzRy6gceQePgqLhnypXTrLdT9kXDREf5DQgGLFWMVXQ/6wS+pVU9iS0AqjovGBnTLpf5zY5Kj1RLrzpfiRx//uGhc6QeYJPWXQ/fxdvUStZkUq90IxrMoCvvtaiy9rYwg0BIM=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4014;6:+oCibU6/6DCu7imRpKGp6DlGgrQCwuv9LBDdDY5Qp+iLurGMIcjupm6tunwFRtoAxdLdA+tNHSTMlJXGNxIRxb88LsMu4vqBe8QjvxFGgPNWv9y/lUwiFM1PzpA8IGGLD7UCzIJ6vzVXtwyB7Nni1pUjHsgYTnMbq81ZOt5ILKDw7eI/j+p0FweS4sLojG46asHY96kh8lxdcPhsUEqFhtHfwJZI2X9EWht4MbbcDmAzQ7qjbRuARCaQmWxTXYoafbSgUlGOPdh4WkxSY2tRgxHy8Q6SvEQmUNmYwpGhiJOYK8DO3qdqPlcaNnI8ksI5lDtllTvwjyR75uwqVi9yr3C3/3zqCo4EIEjWhcO5BA7WybUr340ZTP1paJH6twbDidNlOk7CfEZLtOzBkorJYBomBt2k1ARNRr7e61mDQA9SZlxUiVYnwlq00NKTcfoGcfINHFwbgaXY+eQm6X5Q5A==;5:3fVfgtzOmXADzVY1F9f3+7lsK8Jbo/CMlTMgWAfCtTA1hEag6UiwKJQig+a3mKLkfuHeJ1O/iLPpPSU3Tp9CMIPSyjzJEE6b0HDU/RaOBIBMj38W3oB0Md6LYL1X2bSEZfXx5kk0iWsDO5SJnjmBBoSd6u0/SnwIN0jGSvg3SKw=;24:aUNlxPatz+3dxAv2skw3u8KYa1iUZYTfbbBSZsIhV3H4WuFeTDlVbL0kya9NgGdv1AuDaKoFnlC+2cim/VL/3OFVVfg8GN8xp1E4ios2fOo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4014;7:YcnyhhVMXU6obcF9GVwxu75muN2H736wruLTR0WwuwzeNt661DaUM9i8uhb01hSEzW0SpnRSPz6dxe0GrQUaTpAzDlGTPxPeIAU1NPShRMPv1tEGqEJ0iBWlbKVHIi6daIxWV9jc0To4Lf/NDEqkryBbrHpYmY+uORK5NxP5ERUEf5yNu8WApvGmmdBx7BqzrPx2ChuBSU5eHbOTeRCCDT8hOtoU0v3rR2WhvLSATHkrc1WsFe4wQyU07Z37pwiI;20:P5cH9MVap9dclLOPvnlzrrk2CH/E+A9Xcv2xvHpy/yXrOp3R2griWouA/bmejE4NqeDKr43DOJDhXcBslR6uyV/qX0FRdsNIZUPD6etS12xgC2JQ1Sgf4vJap2Db9/QJsmIRXU6R7yCU05C47IRpVMLl7U08ULRlKn2sVwGUX/8=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 02:41:42.5940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb22455-a8ca-4d14-989d-08d5e86a2b37
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 10:24:47AM -0500, Gustavo A. R. Silva wrote:
> Make use of the swap macro and remove unnecessary variable *tmp_mem*.
> This makes the code easier to read and maintain. Also, reduces the
> stack usage.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/gpu/drm/ttm/ttm_bo.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 5d8688e52..5142dcb 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -287,12 +287,9 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
>  
>  	if (ret) {
>  		if (bdev->driver->move_notify) {
> -			struct ttm_mem_reg tmp_mem = *mem;
> -			*mem = bo->mem;
> -			bo->mem = tmp_mem;
> +			swap(*mem, bo->mem);
>  			bdev->driver->move_notify(bo, false, mem);
> -			bo->mem = *mem;
> -			*mem = tmp_mem;
> +			swap(*mem, bo->mem);

This code assumes bo->mem is the same as tmp_mem after the call to
move_notify. Is this always true?



>  		}
>  
>  		goto out_err;
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=02%7C01%7Csyeh%40vmware.com%7C3bd79878de5141b5187408d5e6326e6d%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C1%7C0%7C636668026634710967&amp;sdata=2raJ6TBpcEM5W7hi8iCEnrEdcfJa3W5ct3tF%2BlSZLkQ%3D&amp;reserved=0

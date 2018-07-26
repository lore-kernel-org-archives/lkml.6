Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5CEC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D653F20844
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="oDjyHC55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D653F20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbeGZN3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:29:17 -0400
Received: from mail-eopbgr700050.outbound.protection.outlook.com ([40.107.70.50]:34240
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729839AbeGZN3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZezFgDrVrDrLWqC/JgGeTzcQIXCtWvoeu7mG+oHvORw=;
 b=oDjyHC55xRhXRZxvRr08+jzaX1JwTGQAmjcwvndAXKMRg2JpYEtR4gDZorXZbjZviOyA89zsEcySHS2QPin8kZ3Bm8Gfpfoflkh+7LvZY89dZKCVo0y/3mfnpF5wjTFv1Bv0GY961fiiSbTKwyOrsMXYsYE3GvCS9n8eBLGzp6M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
Received: from localhost (5.2.224.70) by
 SN6PR07MB4383.namprd07.prod.outlook.com (2603:10b6:805:58::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Thu, 26 Jul 2018 12:10:49 +0000
Date:   Thu, 26 Jul 2018 15:10:42 +0300
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        corbet@lwn.net, linux@rasmusvillemoes.dk, dgilbert@redhat.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] linux/bitmap.h: fix BITMAP_LAST_WORD_MASK
Message-ID: <20180726121042.GA11481@yury-thinkpad>
References: <1532592471-21177-1-git-send-email-wei.w.wang@intel.com>
 <20180726093728.GA9069@yury-thinkpad>
 <5B599F5F.2070705@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B599F5F.2070705@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [5.2.224.70]
X-ClientProxiedBy: AM5PR0701CA0002.eurprd07.prod.outlook.com
 (2603:10a6:203:51::12) To SN6PR07MB4383.namprd07.prod.outlook.com
 (2603:10b6:805:58::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd74c574-20dc-475f-7fb1-08d5f2f0d3d4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4383;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4383;3:Z4EeboO8jt8/EzaJoftDa16pKT5BwTg8PhA/pm2m3UgVwCA1wEq0EYx4oS9pKBlHH6A3PK5rZUMDHae8xyCXiueaoiFXrECKOQujKSLLtHoICsA+Quny2adYnoJ2Vz8PZAgzgw8c451B41+GS5S3XWQom7knL5NdfvnWerknsw3g1xcbbEhQ6pRoUI4xL11C+YAF40qKJhbZV0JLsOrYzMjp/L6r+m+Dg0nvhqOyJOZthU8eH56f/GKfGyBQYU1s;25:9sUlJLr6Q8USiNWW+YdLFTjaUPn+b5h0dgJC5erztzotFHWv81wVLt5O0A/FX+rghaUFseCDMGaVRAq7i+Fpe8MwvzV+DI5JyL4r3APrKCDrSYWwjQTixoVdv0Ypb8b0pLuOZX3F/gGhQPggjd3zD68c+nJczzbwBO9zffEuKk19QIiwjDUb4YLMGpXmDnXBbxmJsEzlAHApZZh1aRaE7Ejb7p0hK5uqGrfRDEE1YJwZcMihEM92gUdMpRJL31BBFuaL/r04hNWQ8fO4qX2UIg2DRZORhacxlCe+avHv4CoiDT4mjXdQy+DLxa1qvXb8/ETv0jlXcTVIEIxRxmHWsQ==;31:AQlu/gud+5wOqrdREiri1wvt9Z1wcugMoCB3p75vZmtjF81hq5osFEC5PwdhlHxXvpWxqc7RBI/QQ+EkcRkeL7YMdNR2ZJp+lp9pCGfCD0bxsfUpzuBkQZvgb0H1J8zmQwihKqcqEA1cJjYIooa9Rne84KUj+lwanCS/G/5S//lKDUM7pr1ByMt4ITj0D+0z4PXS/QgiJljcmnx3PwzwDamHo38D73O3Ao0ZzvhDYY4=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4383:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4383;20:G7wXsDrwqQpIEHq7KEgySt0FeFVz22y8z1ObyuwolB/rsbzL5PfyTg+n/qCBdSndWtmQ3aCSpF/qHpxImbbGSkqt/4MFOTjWant9FyHGoD+GgUqGQrvCfq1Pys0ji39w1wMrA+Fi9Nui6JHXTSuZvqg3sKQQ/XS7H0lS8NAWWANAPhHxOTk5FCMwaNQSdfOyi9j1rNneqjMK4uHZaTOVVn5HkO4MBEMgg1quANH+ZjvDfymjxjsiosTU4kRQpRZMbx6GBu25GN3g2adPRhlxYul/gRJqKRGGnX4N1emF8E6FATtySn3kf66l9noZICX0fO35nGWKe3trzea8bXuMRX1xObkRhm3C53a2lcFq58xa3Ufu40uJWFdieSVHCWHls6nruzj58hiP0ISmsGjSvffEUakPYccoZFRvCGMF/V9KV6J8CliJWu/viUuI0DWEHLg3YoJswJUgTo1sZWK7nZ9d2L4o3NI+tFcpIANxo3+sBqZS0Ii2+q3LrXP+KMzw+4kv2V8Zw98O1IW44Q1n73WajfBbVDszYW3v0b1O4qMdm5qYf68xFkQF92S4irU0wM+lc8lkPmYid4xSVnIIePx6GGfc8jcVBXWcE+gQ/Rw=;4:ep5CB7gYroFpdFb8SPcBsnuQ/ZeDAceFrRxDDwVMgbJAepnAR0EYi/k8PZE6Z2KTnlSPrznamFQe9FYspPYHhajcXY65tKSqlc+vdQIIxgQrt6CRKnIQN0Em5U0a0wxRuIvejSM/cJpsRCsdycXyOO6RmyncquQ8oB1DYV0RBpGau8GGXXcYY/ev8gWT2bRXHbC2vamKU52i6EW+lZwHI4Q13WC6/vuduRu7nTyiVptpYnU1aQIDiNlYZodyV3ec3k7UWcJ/Uh0vv0tVH2841dZerjIbeEbQ15wmAr4l4ZZimGluywHzpbWKtIIwyhbx
X-Microsoft-Antispam-PRVS: <SN6PR07MB438334427C582D77E0BC2E6AE32B0@SN6PR07MB4383.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4383;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4383;
X-Forefront-PRVS: 07459438AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(366004)(136003)(396003)(376002)(346002)(39850400004)(51444003)(189003)(199004)(52314003)(97736004)(33656002)(25786009)(305945005)(7736002)(33716001)(81156014)(81166006)(8936002)(8676002)(6486002)(478600001)(229853002)(53936002)(66066001)(47776003)(9686003)(68736007)(4326008)(76506005)(446003)(6246003)(105586002)(72206003)(106356001)(39060400002)(6916009)(6666003)(5660300001)(33896004)(11346002)(52116002)(76176011)(1076002)(23726003)(2906002)(956004)(476003)(6496006)(486006)(186003)(16526019)(50466002)(316002)(26005)(42882007)(58126008)(16586007)(71446004)(6116002)(3846002)(53546011)(386003)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4383;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4383;23:QW+LDQjwVYhqXBT4+hplzgl8s+hYp32BuxNAlEVF3?=
 =?us-ascii?Q?4Ww23Zh5ogoR30NogRXZWZlw3BuPtuG2xhuv/sEQ/g2tdoF01G+JB0XrJTr2?=
 =?us-ascii?Q?wm7j/8nYroI5ktVXMFlNzrohoNdACVib9JFDCpWRy+XR58EZPdcHBQJAfG+g?=
 =?us-ascii?Q?sb5oC7UWjH7MmOUsDOHRHMGHZFwHH/tu8bEuLDcW2Ize2cZdG84VGLLmbNSl?=
 =?us-ascii?Q?LItpeEUZyqBPQ19+JTj34iTlzkANpWa5OqnFckBMwbXBE3iHNInMzxRZRtTI?=
 =?us-ascii?Q?K5OrWS10VD3D0Lfl8C3ceEmvRjMtF9us00cpgQeK7hAWbDk1Zlgp0Kpn20mG?=
 =?us-ascii?Q?CtoByr+8V4ZE534LPhOTUw4jGReNAHUZWgOVjYxUowRV7gzro1Cbvi6KKUOu?=
 =?us-ascii?Q?VaDoqnYMqvm4EQ+UfxSEnxjNSY73CtQj5otETSzaAG6HwwGWhGL52IHMJTC7?=
 =?us-ascii?Q?QrJfYQX63/7xmLmFszEcJmAY27Qefc8Xajciw4+6M1gOUS3VS1fI/wuJXowV?=
 =?us-ascii?Q?SQ25ivDss+q/S+f6fD+6Yy1fP5klsOTI8bmoyX/vKbP+hokTvwFQTIR4SvfG?=
 =?us-ascii?Q?P76XrfqLD3C+W3shjWZkXeHwYo8O0oBTYI73jmt434nBsPKTpzSWCbn7GbgH?=
 =?us-ascii?Q?9B+N1SbCZRxycCMsnvBZF20gSRGBlOPS5lRo5emCO+yb36kQaCmN+Ny7z9yQ?=
 =?us-ascii?Q?QM7OSbjg4Z5xKnasGENfHWsTf5bloisCsLi3ua0TchD9PlYGFRu5nhSC12Vn?=
 =?us-ascii?Q?mriBjxSHtbxt0YW2HEv7j5gIKiyOyxk9NBxwN6DKjOX/OSMNqnTOVHRFcywl?=
 =?us-ascii?Q?5uMfNm0M4/UwmRhEqWIL+ghrft332ur3lPHcJruZkgw/F9NC5Xlsj3z5wuAX?=
 =?us-ascii?Q?MHPDUrNwWl3yI2auq/2E+tbE57NGXDAfZpiJxMlNmIgPjHQXwiy9fSTndYC1?=
 =?us-ascii?Q?MD81JWBiq73WsJLK6vY0Q72Mh0hUHgbxnl8PPAWbdgNnMC9wxtTxnmwc5nz8?=
 =?us-ascii?Q?EuvBtXbBo9GOqS2zi/LxXLLMirg3loRRbi8QbFIyChIq5LVPbzPxIaKTDTl8?=
 =?us-ascii?Q?/rVunJTmvV3URP+NBZA+4PhgTLzETWY2J5DOLmIqm8QXg94ETqJ4LxC3njMk?=
 =?us-ascii?Q?usCgn0XM0oHNmFIJlxP5eb/isOwmUzcTutKtlJT+9hkN5DwsA+CQy8h0q1Cw?=
 =?us-ascii?Q?d91lJiOUSChMscSoUR39pG1v8EBVFOL9Rj35omujPIU5sgZSuG2dc7T1attC?=
 =?us-ascii?Q?bryEro9AzQmLU5mAKbJOt44J++7YzxLFC7WoBcOYwh6A6GvQvG2rRmxonFCr?=
 =?us-ascii?Q?iUsw2Ebf9okxMFNGhvjpYupjjWDzOVdl2EaboUtWJ/ensWieG3BGkUOgN9xo?=
 =?us-ascii?Q?irNWHunAYlf9pWckoffWFvnBagkp/F9urJMMA8WSNpnkyTWJF6pzSFmmmzwi?=
 =?us-ascii?Q?wmlrWY4vq0nMlq5BrW4+CSvgs4P5jk=3D?=
X-Microsoft-Antispam-Message-Info: fHkC5n0L4h85aJ+z7uOoW5Vntk4JHSuwoQYclgxodmm7+qSehd3/npiy9Xiy4R2T3g9Oqu1lrtJdUdKm5CZ0HXG412oERvn9Bs0rDwfwt8oop5DDmZYFyOdo48D3Bh6Vw79pw/RnxqWOpcMS8O4t3IW94lA+jHV9UbfvIkEBEINSMySW9WA8JxrlOd8NcpPD4OFnSVSmIMAnTsDcPpJGlzyNL1ix1LenLoHMaK5ECvxk4sImQaRUwZv75hD99Z0uJWMl9y162u4oVBkDGSByS89HqIyNdXW00+Nb1HvtEPeNXSKiH9ihuQzuEvJAMbugy5P5AG9Q7l2NRKA/Ud0afd9kWoOsMGHQAXLhvbHTuGg=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4383;6:UrTwxnbc2C+YpICVWmW0AyIkGG0wcExVjv4hH03G1Uw2wtQczh0cXf7yZ+yNfK0eEjgIXcVAeStFBfee3nySndDP7MtGvXgiDoUDjggm0ClID42Vs5VFrnBPtOebo2+NhjIs1lw/6ZMTddjw1DKp6kLcmC68a5b2UCbG0WV+jHE80ydYy5T+fc7M5SJFeZkBnrEHnveFe/FQYwpKwlF62tY5FVU2BURkrohZq+yeCic3GjUlu8/D05qiSfsrt8DrC7lTqK8lcY6xvvVnGxuCSKDikbB8ghIGVly2Sy2VEyWgRhJBDjR8t9zMCm3Yo2O8LHrwImNxkeTTgEQa4fXjBRtLaEXEg6RyoNMp/W+e+iS0Q77QPpWUsDeqEkTvvoc48eBaGiEqw3K8yWGbH37taX3TNE1+vl8eJN+QtBfNP3Q3/JFmXH48Uk3y5lbORdKJfJ8PcqD8C+tPP5rvsD/hng==;5:y5+c5EOf/8pidxs5ILazdStUudYdi20yMOuyaJhdGd0VPEqKuEU7PUIHTv4G8OxLB504dcdq4tKroLA/CGnb55T1RZiW4Okuombjq9/FoVlTxtwjIdmYh2WWwHTLRqAM+XSTMxJI96YALDO7I0opHoELSKyOSeKmzgd2JUPbJaU=;7:DVOjfehoFhI8CIbd2vPOFRhq6VKJ8sRNx+Au8p7/MxmAzP8UWSu4E4GRAfap5Gk1zbVVN6aX+gi4lXOcy6BHZMS9JKw8DWvYxKfTyg4u8Q0Sd3K0Vpf/bWZW6YUK48dvFMSsOwBkZ0XByNqNb2aoFQW9Fbv/q9OVCn5jF7rIPLWTvUUHIujtKQ4RwRAfEGEpSIEdph0fVII0fu60OJTO44dIZ/nOUE5NgMl8HJNPMqmiRcth1lkJeGWYrzV3ANRt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 12:10:49.8566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd74c574-20dc-475f-7fb1-08d5f2f0d3d4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 06:15:59PM +0800, Wei Wang wrote:
> External Email
> 
> On 07/26/2018 05:37 PM, Yury Norov wrote:
> > On Thu, Jul 26, 2018 at 04:07:51PM +0800, Wei Wang wrote:
> > > The existing BITMAP_LAST_WORD_MASK macro returns 0xffffffff if nbits is
> > > 0. This patch changes the macro to return 0 when there is no bit needs to
> > > be masked.
> > I think this is intentional behavour. Previous version did return ~0UL
> > explicitly in this case. See patch 89c1e79eb3023 (linux/bitmap.h: improve
> > BITMAP_{LAST,FIRST}_WORD_MASK) from Rasmus.
> 
> Yes, I saw that. But it seems confusing for the corner case that nbits=0
> (no bits to mask), the macro returns with all the bits set.
> 
> 
> > 
> > Introducing conditional branch would affect performance. All existing
> > code checks nbits for 0 before handling last word where needed
> > explicitly. So I think we'd better change nothing here.
> 
> I think that didn't save the conditional branch essentially, because
> it's just moved from inside this macro to the caller as you mentioned.
> If callers missed the check for some reason and passed 0 to the macro,
> they will get something unexpected.
> 
> Current callers like __bitmap_weight, __bitmap_equal, and others, they have
> 
> if (bits % BITS_PER_LONG)
>     w += hweight_long(bitmap[k] & BITMAP_LAST_WORD_MASK(bits));
> 
> we could remove the "if" check by "w += hweight_long(bitmap[k] &
> BITMAP_LAST_WORD_MASK(bits % BITS_PER_LONG));" the branch is the same.

But your patch doesn't remove external conditional, and it fact
introduces overhead, right? Also, in some cases it's not so trivial to
remove it. Consider __bitmap_intersects() for example.

Anyway, this patch changes the very basic API. In that case you should
check every user of the macro to be safe against the change, including
possible performance downsides.

If you find this corner case behavior of macro confusing, I think that
the better option would be introducing detailed comment to the
BITMAP_LAST_WORD_MASK(), or writing wrapper around it that handles
nbits == 0 as you expect.

Thanks,
Yury

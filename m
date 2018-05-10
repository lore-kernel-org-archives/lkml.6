Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756472AbeEJEkU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 00:40:20 -0400
Received: from mail-sn1nam02on0108.outbound.protection.outlook.com ([104.47.36.108]:38806
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750854AbeEJEkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 00:40:17 -0400
Authentication-Results: spf=pass (sender IP is 117.103.190.41)
 smtp.mailfrom=sony.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=bestguesspass action=none
 header.from=sony.com;
From: <Yasunari.Takiguchi@sony.com>
To: <mchehab+samsung@kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <fabien.dessenne@st.com>, <jean-christophe.trotin@st.com>,
        <sakari.ailus@linux.intel.com>
CC: <mcgrof@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <Yasunari.Takiguchi@sony.com>
Subject: RE: Are media drivers abusing of GFP_DMA? - was: Re: [LSF/MM TOPIC
 NOTES] x86 ZONE_DMA love
Thread-Topic: Are media drivers abusing of GFP_DMA? - was: Re: [LSF/MM TOPIC
 NOTES] x86 ZONE_DMA love
Thread-Index: AQHT5ItRb0y5QFw5Gk+kOQy+y2CJ9KQoXEaA
Date: Thu, 10 May 2018 04:39:58 +0000
Message-ID: <02699364973B424C83A42A84B04FDA854A3893@JPYOKXMS113.jp.sony.com>
References: <20180426215406.GB27853@wotan.suse.de>
 <20180505130815.53a26955@vento.lan>
In-Reply-To: <20180505130815.53a26955@vento.lan>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:cf8:1:aec:0:dddd:260a:38bf]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.41;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(39860400002)(346002)(2980300002)(438002)(189003)(199004)(13464003)(2920100001)(2201001)(426003)(336012)(305945005)(476003)(86362001)(102836004)(446003)(2900100001)(11346002)(23726003)(7696005)(106002)(486006)(76176011)(2876002)(126002)(2906002)(97756001)(106466001)(26005)(6116002)(316002)(5660300001)(356003)(55846006)(54906003)(107886003)(77096007)(246002)(478600001)(7636002)(186003)(7736002)(33656002)(8676002)(110136005)(46406003)(72206003)(6246003)(4326008)(8936002)(16586007)(86152003)(47776003)(229853002)(55016002)(50466002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR13MB1416;H:jp.sony.com;FPR:;SPF:Pass;LANG:en;PTR:jpyokxeg101.jp.sony.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT015;1:BtU+p+jGP98TJTPCni6+SL453SxAOcIJ2bArjnQOVX8Fuw7W/sBakGLoW8iXEKD5PYQRclKkH2W5OgEhIwHnjAWK1StHxTHFOln21+h5nvepXY2avTZOBJLLUnFexgWx
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4608076)(2017052603328)(7193020);SRVR:CY4PR13MB1416;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR13MB1416;3:lTX2RwXEKYkgXrV0wKkN+lHlUffhIekGfklKvpKDmqgHTh5L/XPRiDBxDLYiQRjEq1g3/3Qf9mHce0ZGyoT/cwEtvuJkJm3oxbBBpKG88ojGCF3bWm1sL839bmSCQeZaup2/64k3B0UP2ArzJeQBdYCzlJnHhOOl3rtMtBpWMtlQUY+kCpJZWUic7SEH3snl3hap8XlcEE9tTAYbjrSOblKOpYlMvdaqQpCg2010ADUQeQLuRVdI9o//6pEoM50EjLwXXkeog0N+3mjpdFOziocpmdQUqRzMpJioqTKMDtdM85hkz9LQ40Gpb2R3BZM0zvMim3qChN6QjEbW+zpM4vKTKIak66K2fr831LGeZWg=;25:tqPUrbNC8DyAjXo52eXZaHeYZx4Nf44TJ7agrhHe2+/uIqbtih7FyUWqKCRR5c9m9cqj5g/xqlBic3MjSY49BYHcWBZT4UtBxHwhI8qvuKNY2Lp7XgO0fUDwFdjo7YXCZdWuQiUohcu3cJ0jOfPYnIjGzWzDIjHlR0Nq+D+ukE69QJUOYtVlNrggUXiW5FhGpal+afLCihORLP7PzZhMJR95H4l9Axli/5H0ZoHmZZ614rs/Faa5HXx/y+sEiu5IFTuKYsDYuM94P4wmzkduaSwxmRJZWSuzdgU2vm9JD77bOYD4c/1r8m7YU4OI0kOSTAExIFwbnQfJo5CTN2808w==
X-MS-TrafficTypeDiagnostic: CY4PR13MB1416:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR13MB1416;31:J+r3KafUFWnhxSJNvKAYrn0PJOi02i5Vy6N8/Bk4rl+ympw4tSM2ZmFVrszv+GtBVlTivBDlEs8CIZBxjDLVtpCmsbd/FGK8IXx+j2yj45RtOd09ygo/z0M/YmAglyKG9Uet27vom26ogylmt94dgRU8gYS7Laptf5iAcvRRfl6QEer8YOGiGu+8i+gRegHYyZpeJYvj7FKwwBdKe1P5HugN9P+RDPqY/onu4rpfNso=;20:FPaC42jkCfnboIvmMaUjbeMwvKyZRnmr7h7WB3+Rv7Lb+IbyOTHt9COQBIwbY2RL2OxJ3uDN6bSgdx3y6HaksmmFkhEVY/lcJZW5+gHnbq0EaiaBGH4oKY5zaO+/+wrnis3EtxLtAWLvRFfw7vCXvB6jxkM3bRB71/d70tQIOslABWFxc3TiuyHavPUcLOlqj3jXTOxdS5ZnSke7NCp48oizDkMx3am2j3PB58MAK/P716nmFpVsPECjEdLL4fnC8bDmhWjTg6F6jHZjMGg4Fh1jJfWZ17df0SQch2uyMld8yv2iKuHaAPKZvg6KrUxP69d8IMzArHQ5880EOfl3r1T2rsu7reBozkrSw5ujgVOFKPnKk+mzVMd9bu2cOAoiPJ0PGlz1/QJ9pvx+I+3JT0xNOHNDK24CVUjgZ1ZCR93Y2FwGEySoMRieNzGdSkVJA404nqa8VQabOmkUBaHXSQ3PZ3PSBo8sCU6L+SQ54MnwToTUWmBGPowFkYdg/5jo
X-Microsoft-Antispam-PRVS: <CY4PR13MB14165FC90E4422625136034DFD980@CY4PR13MB1416.namprd13.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(11241501184)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR13MB1416;BCL:0;PCL:0;RULEID:;SRVR:CY4PR13MB1416;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR13MB1416;4:InmU+pUUG7Lk4irLvVJOZl+QWXAtusw4lh+vKvBFPR3OubLuNAMgt8Z1GuA4jglnFx52G8oEwDmRi7VjeV/l80XlrOLpGxjtdTgNiXqHtA2LFRPrc2F2mOReHyql5sFQWaiTkcyvficGKze1zTPTO7mcjDRPEKJqqUS5gheh+vPC9m2vvTqYD+lzeePN+O7BKbSw9QK9f1Ln7u3Hz1DlYjO6dBnP8bNkWywnP6iL1Gx+VmUmSL7D/xcDYpQ3z1SblkClhXsHozJdYxGRF5mf5Q==
X-Forefront-PRVS: 066898046A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR13MB1416;23:kJp7xmDzim7OvPD6wCmfvSuUKBanDiV3MbgbIXoHD?=
 =?us-ascii?Q?GbQm7EGgt2MLs6O0UZzpg1BHNBt4Tzx3Xcbc/rUjTqy9Jv9ORDMV/U5wB7cU?=
 =?us-ascii?Q?rJPPT04LBGwXne4CLIFW4DbFasWt+/2e+XckpuqpftargGoqe+5fU9Tp47kj?=
 =?us-ascii?Q?BhE0hALm9HkL1xAXQsk0VNuY2xvtRfBx6hl53znruTzU1tdaWcKATpZgzY2W?=
 =?us-ascii?Q?HNpWhm71lLNIT/x7gcAARid+agsM5tG1Y+0bakKUPpd+SVJoWEPNvIgZXqAB?=
 =?us-ascii?Q?B8p/I7aKW5gFwGZWft713JYb/2awvr3E/8JkVWxFDO2VAz8iYKFBAQ2evq/R?=
 =?us-ascii?Q?xSRp1hiRXlkq1UJuJGz2euY9DoSQYfmWstmefaJVuC5/Qv8J5H034S0FkEDc?=
 =?us-ascii?Q?T0DfglrgXSfl2L39vYyoQjWF12FXu+/agH1MpAAr5YaXkpItc3GJSv0KN8M3?=
 =?us-ascii?Q?BIKivjqfduT/4ScioTMXFnhnxpmlIPN9Uw15SVMenIi6lmXflP5EJ0G1cnam?=
 =?us-ascii?Q?hUrVW73BOcQKcQBAoyGxKjdsZ7UniQhA7fgyVBxUY5fI/+4NWOQmm25gzBUd?=
 =?us-ascii?Q?uaDLEHULCj24ndp1QYGX/xVr8wEWzNkFjkNarkjLvYfXZtVksgUZ5AOkxciA?=
 =?us-ascii?Q?BIMyxQoyDCA6ZJbnDjqaNlUKVuWQhPRl9TNInAngCuQ1/8JcT5oSLkObhsGn?=
 =?us-ascii?Q?0McHJHBQQAOLBrdU5jvRp4tKmKeKfKmklvqJ14fz171ZDyBg6HAfDXoek5JQ?=
 =?us-ascii?Q?Q8sBLra83pg42mAodIgLSVhaFXnmw9xWbjLGqTtBxjW/wYKm2PnEJ5I3ImoG?=
 =?us-ascii?Q?t5S7jH0/y+oTWf0DYi1c8ZeSpnZs8MJ/q9DIqaesYpqrb1o/ps0fAmqpexAs?=
 =?us-ascii?Q?Y5lzY+QLsd/Kqr6cmu4NHKuMdRcYgweS2REiaK0KRhYjIIs/aWJLjihU8gmK?=
 =?us-ascii?Q?v8Y9gG3ZlQzbhMlX1O3trKoNwSsILAmYh9sGUQD7foy4MCh5DxIrytJw67ba?=
 =?us-ascii?Q?rHlZUGVJH70Sk6qokgCWTtSS1ylMVrWt/XrCroSc0CSz2Gt+4hcwD1jVtiWc?=
 =?us-ascii?Q?b/c3gDrGovjMk9oIYfdSL4y3xa22O1Nx2oTIWfue5/HAZ9NtvcP6fjunJA90?=
 =?us-ascii?Q?vbysrohIUds2DjW2dLepCiQDB8QOazLqGDMfBDw6Lm6dNMw2gKwRDTVWXOnB?=
 =?us-ascii?Q?6qlXaO/VeqWr5z98U6yETr6QFyMGbYyDZcseaTdMaEUpdLWo/Pe6qnYyVUX4?=
 =?us-ascii?Q?olvJ/bGKNyFV5gCV5MkOwA1pidNKUQxiDoWV30JeRkOP8TZiPh5dgJV1rCyB?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: p9dm/uyPA2KWyBKiCR5sZwXvPjYoTa6/sxRuc8ykGV8lTaCxXdGASKFHU4wdIldtbfmBF4LR6RT1J5S9e274Jzo3xyUqCWFUGK0MR8QNCbKNJDxEMnbkPL7NQN1mMNVxEYCFzkWQdM4RKBxo+24uWl2kGWeNO5BbQthjSiORknNSgzeVeTN1LCTXuIo/RUHH
X-Microsoft-Exchange-Diagnostics: 1;CY4PR13MB1416;6:7GW2eRn01Ec+72GxpjMSHKnWWObryvXTCxQuPLp6DlXo0OK8owzEuAQOHuRC4czJ+CMnXMPILM1gWfIRmGSz7kOsVMVO1jeIuIANaC3j2BgcYX948zagfcvy8x/odQMWCCJAeBaR/amNzqgb9BrwUX3m4tllMNGySizStqYXT/BkrzTgrScVWqlbgVMgGQVaLT+qOcIQUz3YZUDQNfthcjAOlKH14OwLkh2HHbIzvV2NiOuSKzepmUElLxHUOhIKnOhfr7pauXBmvOXQoZLhOSO1I3WJPG3CN3shM25ky74FJ5o3t/NOQtVhdeEgcUZgIGVjehHwIApY82VhfEG2tgWjtoiAWc4uxydGYdYHjM7O10nKZFIttn2gvrL6+q+R2pcejlUregsAQ1gIme9YOATnTCvEnSYeNuqU9D+s2GGnUWxmrZ6W5Cc5RuQ0VEEu5bEIrRaOywSjPjyM9qTpdQ==;5:lbHPdSFMXXacnKfaVN25wJ8UA0ZmR0QnXI76VjhXyfitUzKfyZel+rUK6CXZbJyIGMoBfYUmSicMLiFhYWkmcs1wMNfI4Ob9d8KOfZzV3azDM+czhoGMXO2Y2XT1nrNkTZaPZeXCGC9FCWoHI8bSM3eJqptxeTVj8ESinnEXgng=;24:S8TWZQx11wxHnmERjv2VHKnlgCEZrAEHi+HwCRnbMDGOqDc+CWIEwIwnK3tuJj/LDAJYDEL+R6bbxAYvx8KWHveXuNepCSDFoi4Dt7qvlTQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR13MB1416;7:6IL9IrLRq8PmW3Qo0wYojS9vAjqWglvF9lRknbphBhIiugbvtyoVeswA4vkC7DsexXP3QthMWxL2Seab1+UXi+Ch676qFXGMz1ZS/HXDM3gsJtK0lDkIwQa0+xyUm3LXl/Cff3NFqngmaQO678b2950NazzdUTRo7EXS5tLqzPNnw3vEAbIYE77zTQRwaXG0afTovycgG9LnIArj0KU0gMWjJc1w54Nl/ohniQCqFnO6nQdviahSLwPIZeqM5zrY
X-MS-Office365-Filtering-Correlation-Id: f445123e-e10b-45dc-3f79-08d5b6301f99
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 04:40:11.3708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f445123e-e10b-45dc-3f79-08d5b6301f99
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.41];Helo=[jp.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1416
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mauro

> -----Original Message-----
> 
> There was a recent discussion about the use/abuse of GFP_DMA flag when
> allocating memories at LSF/MM 2018 (see Luis notes enclosed).
> 
> The idea seems to be to remove it, using CMA instead. Before doing that,
> better to check if what we have on media is are valid use cases for it,
> or
> if it is there just due to some misunderstanding (or because it was
> copied from some other code).
> 
> Hans de Goede sent us today a patch stopping abuse at gspca, and I'm
> also posting today two other patches meant to stop abuse of it on USB
> drivers. Still, there are 4 platform drivers using it:
> 
> 	$ git grep -l -E "GFP_DMA\\b" drivers/media/
> 	drivers/media/platform/omap3isp/ispstat.c
> 	drivers/media/platform/sti/bdisp/bdisp-hw.c
> 	drivers/media/platform/sti/hva/hva-mem.c
> 	drivers/media/spi/cxd2880-spi.c
> 
> Could you please check if GFP_DMA is really needed there, or if it is
> just because of some cut-and-paste from some other place?
About drivers/media/spi/cxd2880-spi.c,
we referred to kmalloc of driver/spi/spi.c spi_write_then_read() function and made this code. 

Regards,
Takiguchi

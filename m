Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CHR2IA0IGVu3TgAAmS7hNA
	; Thu, 07 Jun 2018 10:25:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 647FF607E7; Thu,  7 Jun 2018 10:25:17 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LhOjUplC"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9A235602FC;
	Thu,  7 Jun 2018 10:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A235602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932611AbeFGKZN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:25:13 -0400
Received: from mail-co1nam03on0081.outbound.protection.outlook.com ([104.47.40.81]:20864
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932118AbeFGKZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNmNFz0PMh3UR6VIPz8jNGnF+Vzgo8NSf4UM6fz02LQ=;
 b=LhOjUplCEiCzsElZtZF3v8U098owD7aZs+tABW00KgcjPTekrpHbvTH6X+fdvsLshH7xxDbJgG7HXZi12LCf3LaCaeGyLBavNtkHlkdLVIp8VOgDZzeZyN/ppLdeKw0kwD1RB/z4DMwysDLcWzqF5gFipW3JmxO8cAZD/8E99Z0=
Received: from MWHPR12CA0035.namprd12.prod.outlook.com (2603:10b6:301:2::21)
 by SN1PR12MB0333.namprd12.prod.outlook.com (2a01:111:e400:5146::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.820.12; Thu, 7 Jun
 2018 10:25:07 +0000
Received: from DM3NAM03FT061.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::208) by MWHPR12CA0035.outlook.office365.com
 (2603:10b6:301:2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.841.13 via Frontend
 Transport; Thu, 7 Jun 2018 10:25:07 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 DM3NAM03FT061.mail.protection.outlook.com (10.152.83.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.841.10 via Frontend Transport; Thu, 7 Jun 2018 10:25:06 +0000
Received: from hr-amur2 (10.34.1.3) by SATLEXCHOV02.amd.com (10.181.40.72)
 with Microsoft SMTP Server (TLS) id 14.3.382.0; Thu, 7 Jun 2018 05:24:44
 -0500
Date: Thu, 7 Jun 2018 18:32:50 +0800
From: Huang Rui <ray.huang@amd.com>
To: Colin King <colin.king@canonical.com>
CC: Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, Rex Zhu <Rex.Zhu@amd.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] drm/amd/pp: initialized result to zero before
 or'ing in data
Message-ID: <20180607103248.GA10576@hr-amur2>
References: <20180606121831.3347-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180606121831.3347-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39380400002)(396003)(39860400002)(2980300002)(428003)(199004)(189003)(186003)(59450400001)(229853002)(9686003)(11346002)(8936002)(126002)(476003)(76176011)(77096007)(6666003)(6306002)(26005)(446003)(54906003)(16586007)(486006)(106466001)(6246003)(336012)(316002)(6916009)(966005)(46406003)(55016002)(105586002)(478600001)(81156014)(4326008)(81166006)(33896004)(426003)(58126008)(72206003)(33656002)(8676002)(33716001)(104016004)(1076002)(86362001)(305945005)(23726003)(47776003)(356003)(97736004)(53936002)(97756001)(5660300001)(68736007)(50466002)(2906002)(18370500001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0333;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT061;1:8cbPKT/YHcjGDf6QmoQEgHorFWak+LxqXVohBeZGthdH1wMz18neqGcSMu5d70TvCTkf8YVGICqY2KUoA/1042SZ5Xw7hgQMbWHjuStp1znmpb7GnH97AV9DdFsn/JCt
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:SN1PR12MB0333;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0333;3:Mn3z02yec5gRs8NfJLa0AH3hArN5fkBGiY2IN7nE9urTHafgzbTqZNKxn8rrRsrSJbQtV3EbMsYarmtMYbWZFUGrckTczYNYWgEKKoWRoarNraWPQaIdCGYkFEai8I0EQvt9TT6Mwo98zyNJ362WY4PrsggS5O/oFZY3fLOBXLnzw2BY4iZgZB39fcrf1dEc4qKzzD91iiOXxGWasL/lzllNaRjQ70d9clJYnLT+W462NpiJ5s+BksJJsyXPncDqsVdlBO8nWaDylliN7VkMwKXZNK77DqJeiETgXcsVgMGxagrDu7H3Nn2mVy+IIH/LHnarvDbLnwMtMaAg0uWkL0XPrA4ucQNIZKOIttFnlL0=;25:m3hxP8ESL609yTcmruK1+0oUTB1czVtaI9C5QRAFlBXyR54tGOOibd422gVNGFH46hZ7j4nkIBzz98CqbRBb++y1KklBB8T+1E68GdQArWJ4oJJyurfdP4OAUOW7rimsQwOJDPLRCpOjx/IxphScRE9VAZ3SQWAslOvkOYALl6r5AG6GcLkTB68u8AvC7LUZaCDD8xUXf0JUjoz5cFfdStkgQUAIAMQynTCTXspcfYiBKo1wjfCS2KrrTn8LkqaBTrLRv4bijY9r63kezTOOkrc/IZPEpYK8a662KfVhs1PNNHDygvQOWQORpQNlL3OU148rsoXcT/9PFdIFCSuO2w==
X-MS-TrafficTypeDiagnostic: SN1PR12MB0333:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0333;31:W0yope0d+fHanrmJ0E/Bma4CmUM0vBxRI/0VwFJXoDaqqV3wXHqD0k4+07zAoz/xbyBe2F7BDLMgE9xw4LkCO4b2Nx/py1gHLHz/2m1XrOTcQTh29stdMxpzroabI1vDWXIt2lR5svHwJPEYaFH7euvvpVxDGotCHfzWIJRZvVZJ+4vHkBYQ1ed+ZkiY87RggbabVPSgnNu3nirsy5n44DcHwWg3/33lcQbr1N3wjJ8=;20:M00xlNkomB/iLikJWYxxhMS5/OSQRZjJ8gWwOaNSuqD1BFjDDQ5XCO0PfNgpJbL/n583JRO2jxqlAa+M2lV1SkV71QqLn+9KF1MABMtoAtA5AGtppTX2LSNqRuwhxHRT0gxgtwvWrA8PC/sj9+XrDOLDl6WiavFHVM30tpLfnJDxrRz7XRdIrzZH2Tll+uYU4QZuvTUnbGQql99/+czfsfnetIiAy7k5sXOsxohCLyDsopOQM42pmDfUvVKDC3RsSszgFVT8bHkNeZoTfoo0PzcF2uRcq98tkdYNhHsd5Iv6/1B320fYg9gzJmNipLqylmR2IopRtwOXPav02XLSeStq+vuO0X6oTgpFIjupZK6LNNmPTQvYw9TQNqT9d0AvTOhoPLJpPiw9R05ISkNn7LE38qjKuMS10LOIelYN0hT1OrmnlnWU0M7G4b6r7wJS1srf8YzPEpQyAGwsMowkcL0JznJa4hCOH1oXxneoUsPGiU57q7WzYSIbj1Q1bOh5
X-Microsoft-Antispam-PRVS: <SN1PR12MB0333524EB5965F15D7C6A82DEC640@SN1PR12MB0333.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(217544274631240)(198206253151910);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93003095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB0333;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0333;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0333;4:W+rMU2DCj47oYxxJnCPJLfl9D383a+pZhbLpBSZzN14FV8kRROTDVbln1+09W+TTtVG/RifUBec46t8q3RHfqS5Gi19PS4oHs9UjunP1boDU/dLYU+XtbvT530TTf8ytjqIPFhSBqd4ETdRDp/Pl13P71cs7pMr8pCLJdV4rKSuLhOqOWLyrFb5DdWGOFGTCrgstoqGLvEg9lCWn8rymQSOMqEp5yr9JhJAJ4t9XnbBp5X4bBp014NWnYMIaJEzeMj22MKiO+qEq7J0BN7jlPbdDdwXI31Z3YL1Svqf0zy3MS5qohQKZyZEos0TOVjJWySW2fKLunxX2nSB1OtkI6x0TOcLg07qTFLUng+NMNHA+ZZVb7K+JA+4dTMk9FhDU
X-Forefront-PRVS: 06968FD8C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB0333;23:MGC0IvcMC4pEyXM+rHn2HZyILHuwgN7+60LhW6y8L?=
 =?us-ascii?Q?Apxq+uhPlHEOuAC+hQ25+jwu4zFKfcMFPQLBWjnAtn7CLz7cAz8leZQc/4Vf?=
 =?us-ascii?Q?GFKzB40tumzz+RmwpEeSkVs5AOut1/rutrele5TbCyFvsiZ+3YKV3vgAeGcB?=
 =?us-ascii?Q?/tI6dRJiEFGmd/BNFcJIu86oLYSXoilR+G/0kR3N0TW7V6o702LXrrLnrKpa?=
 =?us-ascii?Q?6KD2lkukZkLSYNfsx6Y72DK2zwxGKw/QxIoMaMzt1TMDOultwBY9V9RZA/rU?=
 =?us-ascii?Q?cr5fa88gdbK/RUQ2uEB/+rHhuOMOXMPWColnztE9NjNE9Roe/qzZuFMkTUP7?=
 =?us-ascii?Q?1QeygLdcrBDY/98hfaPbrYtLn4nMhLKMWlFYRqGd0FXBacqEnPvblsHpG2iH?=
 =?us-ascii?Q?HaH0SN5X4OuOxnsPqVttpYFlW1hsnj8oBnuOx4W7NqYjpTGBvJLtbyJmC/h+?=
 =?us-ascii?Q?3R0jG1avwg6zaQJX+/oxxtzoF0V0n8pAMkPT319ckURwj0qXHv61sz2kPTS3?=
 =?us-ascii?Q?M1M0VBfsSFdnG76yt7o7BVDD9lo0f4v7Ga2TxV/+BecX8xuzrEu7Ty8UMMU3?=
 =?us-ascii?Q?+3lqmoN+rzQ9CTky111/8gKl2XntPmASa+vQlQPcnHVB9IeVK36ohvMfRSAi?=
 =?us-ascii?Q?XU7vq53mmuBdjCssTAM6bzDu0zm5YoW6oHVlLBjJzsHDVJMed8XC3jLnWeGj?=
 =?us-ascii?Q?dipCsE1hWouzfeAGFzpj2oiVEixpq4JqkiWI52q1BnHJMcyZ7miDvigkT9O1?=
 =?us-ascii?Q?/aHm1zwe+6INvdhHHo2wdCbK+qBkatnU0nzMOmDfgkevz0RikyqwvQIUOeiC?=
 =?us-ascii?Q?nwppCWhHhkiZTYTad7u9QCvX9hvetDE5qOXnSfkNHUEvB/Y4vIJdnDxZFbdi?=
 =?us-ascii?Q?0QnWBhhB1vaXQjJurTIr/O5gyac0bHCc+n8LXAduiSsbitl1qyNq2dbZABwU?=
 =?us-ascii?Q?6BrsubxM8Ga5YnSQE5INQ7I2cc1SBTE8gzI46yZxdPaVEZOE7DUH4Rcs50cW?=
 =?us-ascii?Q?uhxOPS8KJ+vcmr8dtom8vreFSN6eF4q7PHh82LJ3kpZkl7MB9wEEsUWCen5i?=
 =?us-ascii?Q?3vC/MKI/P+wAnxRvTWIbqxokBsCfPcH3RqmAGEnCYDiTyIKMZ1/XyYgp96Mr?=
 =?us-ascii?Q?ffvguPkCi/5YclV87vgolEk208jrSOunfQEZ+8sHdJfaGaG+TCxaL9uanN9Y?=
 =?us-ascii?Q?/5igksnkmcfEAabiQ+ggSb+DeaLSe2XCOA6Q0HDVlgONBw3IEoSpMxG76ur4?=
 =?us-ascii?Q?P757/1igWtHZ1PiBUwd7cir7xRwtonz9ZCqqTwdOmTFFA9E6LezIRD+/4NmJ?=
 =?us-ascii?Q?u+IDQ25bLyXWqU4cOAYa49KfjVsxF1ziADeP165LuxjMQVkxzYxB7ATgWm3L?=
 =?us-ascii?Q?k1IOzcQOfo44lN58K/TG1EKJRM=3D?=
X-Microsoft-Antispam-Message-Info: K70j81PS/arQ8WtOzkpzCts4aW+KhG9w0CwSiI7U5H6gsl72LIFEadab+JTwUPqq47aV5kYC3SZJBgE/koEhd12AzFACRiYF+vkL0/iUQWKwuSkyqjMx9tRyw9aixf5PClhxf4mNpctDS3nNTt/l9mTIo80yn3CBuiRFZkYCWdHFBsq9NlMneYIsSMThVhLV
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0333;6:KEDXkd5h9v0OTuxQSy6KA4nf5WW3+JZ0NQuPfIiBADYNPAgKfCqFCVhDIkDGOyJr5XimL1xylm5BBgaHNxibSFCOChJvIX+LTb0t3pcUHssFDu3cfYFjn9dxRgExVJ9ycuSebjK8kG/2+pv2pYIepOuT6fXw3WHNw8wstYNa/qnv8i3vVUydPGw6negk0SfVCYeNdBUfHkcGankHg1n8vUedNxOP0M/He6hcQlst7grX2YGs7ovShsGTZYQYAwaa834T986eotVz6LcxxIayKlw/3hIcm3jxAiHnD9/pPbsWW8IasplhJ2YbJZUUN6hhbuRVp5IrWHMc7vorW+g7Fe6cqBz6qBoC2NVceKi++mHwrErbs412t0n0iuR8zXrJ4jrQ8blFLJsO7cvwdCqKveEt/LPygGhKjqfCT8AFIGK7dCv8oz8FHb/+2BRmZhF3oqpsoIi0e3+FTzdo3EInRg==;5:Msg7VB5flQsLWXBg0oz9Snab+QI90ixJtSK/29zaHlKZSKu/UlQmbfsob77ubI/Vrx4oAh+ulMOfvYRGhvIYCsNr7mOl0GVsUHE1ud+x24POJO+8bJ3IOT37PGyvEoGD7NbYgFa+kETuga+ErLX+RQh9yYuKvjmQvEnzET2ly8w=;24:cYcYMqeUWBh5STWuDKjRcUlDnUEGaWY//stqT+Hpfw/Xb+WgjvfODBoem+0J2EoOyPcySrC+aNoV44rl/x+W1cVAFP83dkRNmexbm9csLB0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0333;7:fgepsqJAzv4y8qHQG2+amJw0sdiU0PC7Hh/3VwVi2iaZfayPXkHaVAf8Fi4mxHcbaE/HXB3Semcua9I3U/GEKm2bU6YFzpLsr7f/lOnyyfYgwiK0Sx6chcRYE3fRW2NVcZkmbSU/fczWvxBoCSBU87cxHP2uy/BmcXmcx3xN/iP2yjphDOaRr+9IhhQE9+w46q5ULIURlW5r47qD6FPjQMebaeLbcga1lKfJ+L29+k5/PYRKawu96Zur3lEFna8K;20:sYf8w2IMik395ycxvZpA1uKnhdshW5JDNAiPeAY6QOaPHe2wtn6fDShqSDwkl3LHP8BInPAGmhwXoQch0a+owkv3oMtK0L9KMI4z5dDSRhnqMfMELw7VBxhZ2U4Q/6F6PpO1yERlD4d3GFw8r1ZJd2i5ZEFl5awGG837ZYCqLWwzKM6sFI+aCpF8Kl3dIbrcyRqqhYEpVIjOkWPV38BI7RYhmYlljYv62btl6jw62UnBxV62l7tsMVXpYc5PCWR8
X-MS-Office365-Filtering-Correlation-Id: 8d7ff236-4a0c-4b8c-71a1-08d5cc60f0cb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2018 10:25:06.7522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7ff236-4a0c-4b8c-71a1-08d5cc60f0cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0333
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 01:18:31PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The current use of result is or'ing in values and checking for
> a non-zero result, however, result is not initialized to zero
> so it potentially contains garbage to start with. Fix this by
> initializing it to the first return from the call to
> vega10_program_didt_config_registers.
> 
> Detected by cppcheck:
> "(error) Uninitialized variable: result"
> 
> Fixes: 9b7b8154cdb8 ("drm/amd/powerplay: added didt support for vega10")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Nice catch, we must check return values for programming didt registers all
as 0.

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
> index a9efd8554fbc..dbe4b1f66784 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
> @@ -1104,7 +1104,7 @@ static int vega10_enable_psm_gc_edc_config(struct pp_hwmgr *hwmgr)
>  	for (count = 0; count < num_se; count++) {
>  		data = GRBM_GFX_INDEX__INSTANCE_BROADCAST_WRITES_MASK | GRBM_GFX_INDEX__SH_BROADCAST_WRITES_MASK | ( count << GRBM_GFX_INDEX__SE_INDEX__SHIFT);
>  		WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);
> -		result |= vega10_program_didt_config_registers(hwmgr, PSMSEEDCStallPatternConfig_Vega10, VEGA10_CONFIGREG_DIDT);
> +		result = vega10_program_didt_config_registers(hwmgr, PSMSEEDCStallPatternConfig_Vega10, VEGA10_CONFIGREG_DIDT);
>  		result |= vega10_program_didt_config_registers(hwmgr, PSMSEEDCStallDelayConfig_Vega10, VEGA10_CONFIGREG_DIDT);
>  		result |= vega10_program_didt_config_registers(hwmgr, PSMSEEDCCtrlResetConfig_Vega10, VEGA10_CONFIGREG_DIDT);
>  		result |= vega10_program_didt_config_registers(hwmgr, PSMSEEDCCtrlConfig_Vega10, VEGA10_CONFIGREG_DIDT);
> -- 
> 2.17.0
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

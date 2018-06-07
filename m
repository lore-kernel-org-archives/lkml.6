Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id MkEYFt0uGVv1KAAAmS7hNA
	; Thu, 07 Jun 2018 13:10:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3D653608B8; Thu,  7 Jun 2018 13:10:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="d6NZkATc"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 88AD5601C3;
	Thu,  7 Jun 2018 13:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88AD5601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932348AbeFGNKs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:10:48 -0400
Received: from mail-cys01nam02on0089.outbound.protection.outlook.com ([104.47.37.89]:59760
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752857AbeFGNKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xbrxj8F42BpkYAMBbPwtdy2VtYAsD3DkQOToh3FjPGY=;
 b=d6NZkATcX7+kJsGgElry2nybM83bzdjnuhhfyD3OrkAmDHZHlF3QiPh9OgIAtz/QoTZAN8rcVeIaBbbezxKoaWIBf0T2/JZi4uR++rCYqRBPJII5M0fWQryWHbdm/X95XgSVsMqkIxgyjVNseBNFb84C9LdUrnJLSHO53O3h59U=
Received: from BN3PR03CA0075.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::35) by BYAPR03MB3528.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.14; Thu, 7 Jun
 2018 13:10:42 +0000
Received: from BY2FFO11FD025.protection.gbl (2a01:111:f400:7c0c::188) by
 BN3PR03CA0075.outlook.office365.com (2a01:111:e400:7a4d::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.841.15 via Frontend Transport; Thu, 7 Jun 2018 13:10:41 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; davemloft.net; dkim=none (message not signed)
 header.d=none;davemloft.net; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BY2FFO11FD025.mail.protection.outlook.com (10.1.15.214) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.820.5
 via Frontend Transport; Thu, 7 Jun 2018 13:10:41 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w57DAd5Q012343
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Thu, 7 Jun 2018 06:10:39 -0700
Received: from linux.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Thu, 7 Jun 2018
 09:10:38 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <mchehab@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <linus.walleij@linaro.org>,
        <rdunlap@infradead.org>, <lukas@wunner.de>,
        <Ismail.Kose@maximintegrated.com>, <vilhelm.gray@gmail.com>,
        <sean.nyekjaer@prevas.dk>, <pombredanne@nexb.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v2 1/2] iio: dac: Add AD5758 support
Date: Thu, 7 Jun 2018 16:09:40 +0300
Message-ID: <1528376980-526-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(2980300002)(438002)(189003)(199004)(478600001)(8676002)(39060400002)(8666007)(7416002)(72206003)(2201001)(246002)(48376002)(4326008)(50226002)(107886003)(8936002)(26005)(36756003)(966005)(59450400001)(336012)(575784001)(77096007)(53416004)(106466001)(186003)(2906002)(305945005)(50466002)(51416003)(7696005)(426003)(1720100001)(356003)(110136005)(47776003)(54906003)(6306002)(16586007)(316002)(2616005)(126002)(106002)(44832011)(486006)(5660300001)(6666003)(7636002)(476003)(19627235001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3528;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD025;1:Prk3q/RVZx65CIKHGaEnKA2hiHP3oo7haQVQYyDqIwnoUbfVE344mjena9/p5mizER6Sf7GR0V/AEcgITVvbQJ34/hmRCaXkuW4zpRu+U4B2pCzpu0tHb2hggCsxp86m
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4608076)(2017052603328)(7153060);SRVR:BYAPR03MB3528;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3528;3:NMlg1lRdV6UBPB2Isv5KtUna/Le2v8BC4aygn2uIdf36sRVQQvPSXbKyYT5zMJsI6ibaFBMLFQyU+a18N0OREQ/IlJRE40Tn5kQdiz6IBqkZpkkG0Ir0eRHFlUh3BTsbHpOqOI+beCSTnyksRPqzWwwXq5yORAvzblc17nqWR7/Hob/URjYYcrUTitWRnM2/2HKBCRr47qtK1jAU+ImRDXMAI8H4YHrZqAphpTjJ66zcW1u+SKPdf8T5LU/GamQVx89NuOd/6lfjVltudXXlk5rJvM4dOVeZxd5Dsz1/Zfqk30051Wf97u1fzmnoxrnM8LS7QONYhjHhxDv0eHdo7XBi1rxWo/YVOWEl3oeY5L0=;25:QqWGgIeveVCbjXRK8S2dn7VbIK6HpLQpYYdl5n58WKAUcxiYUiHymXd1dpNe8taW7YRCwrZ269YbsRT/vVks3mUC4c5DLL6IK9At8ObONT9SFIPqcYku/iTbv5BTB2o23WYAfgXodENpKoiQMnjTL3xQqvGlMDqFMuxkIxplRFokL3xlkdlhptbRF5tUauVkWpyLB0s9UO/SUaDhVwYc65I87VqNg9wZeHJGSq7Q1lEQDIfntirEjPXKNl7jUlnqLsZsswssdoZVNb58zmD3qT2kGpfQ8ncciIunLuUDVomYAhjpc6yRmO+mrsYzc7bfq00l/yXP1NEJG8b68Le/sA==
X-MS-TrafficTypeDiagnostic: BYAPR03MB3528:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3528;31:ZDwRxsTeLQGfZylkzShUkMRWQJA7KR8VC9kQuUvd+y9shFbrnmkwjes+j9x7cDbYylSR8XJWraKJ5LYggV8WjQAicHqowV23rDhq8ys5+ZUEXu3JtZ6PLb9BblANzZtSVsCbdMPCY6ufKFUMBbouCrVHVbSkdaERWYl8Npf2ci5GyEcOtG4X+bLUFdiwy7o88eecqIwUZ1h3ZJAgiChaBrLjpZrWNuQakb1rzqbzuxc=;20:1l2frHmBqTybe6Fq8pfx113tmCYqyKjdOvlNwr6v2uVE/c9W/hi3a8A8FnoTPOFM6y/I1IkpWXM1buuOIe0LfC1dZzb+I/PxyZ5w0jJL14/uF5kYL0kjedvigo9KMD3WBXsJiCvGrBS+XwXZXcDLoJWNJzlZVY1kW9VWXicq0P7x14t4XrFUw7IwV5NaiaiPFdseCwyycUBbSZQrQe830/SCP1smx28ZmUL0+a2qAZ05A1+0v7ubp7crUfjQUNnAPTfc6vuE2XoQljCvs/NlRUMMzRjmW47B9R4N1UNB0qr8xjdHFr5Zdtba1qGDDQa/44oDMS4ElJozoAVToK4ky+PKjQY67qvbEzAt7NClvy8qahboEoRTGC2ssr8d6mMH1PQ1iY317bDGvo97dmbwhL4lWMOL3i7vQtBJVuV1I5DdhXZu/VlLCGaovQshzI3dFwf23xSFkHUA6dK39HvEbSScwRfyXB+0YooKBsImXd4vH3Qw/+XvoV4+s8ABdVZl
X-Microsoft-Antispam-PRVS: <BYAPR03MB352871579CD496AE51D50A0A9D640@BYAPR03MB3528.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(9452136761055)(232431446821674)(95692535739014)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BYAPR03MB3528;BCL:0;PCL:0;RULEID:;SRVR:BYAPR03MB3528;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3528;4:9VUWCEaXbY5/S6gshIb85cY7ziWPa2BcRzrFJvh1hFq+Lh1C28G171VuYUzXGfep8k0Wklsc+HW4fS52Xaw9O5d0n1KNhV3Dlg0BMTjOONGsnE3tzZodApbR5KZDqDkTCsWZdOq2gAXRkPQiHnlgyA1xlEF6KcALC4sWVH1nYa3gmuBTIjUC1JLx7xbbcg1EAbuWajvX7V9XdTJE35UoYnGm6N7PqGIy0lO/P9okqycW5SG8rzKtUvvb65ZrrLpGYUieTeIyNUdD5UgM1n1Ob0h/sq/Y12sAdvFaGVtW7dIUrJSA9DmtiSNIQFRQ5os7OVETPSxrQlmovkSXQ5TOFH6/ZC8kF2pqlPPN/PRdo7W6b8HBmOEqatsM91OwMri5A72MeSITkwniVON0va6a5VefDpVtYNiYzHquaoGYASTtxuWnw7yunpvoNkznqlkP
X-Forefront-PRVS: 06968FD8C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR03MB3528;23:d7kuP1REFzdJoDtvke2ECFNWzL29s9ZQeg+PseSFs?=
 =?us-ascii?Q?C9cn9I44GCD26mWUkDrtE19CC5kN7czmLX3p0XqwJ6yVsZLlOmD5LLCT3Tr9?=
 =?us-ascii?Q?oOHYoJ7tXWjSznTIU8/n0X1k9bRVW67fpYT9CmCOi6kUKCxT3mLHnYr9cRUu?=
 =?us-ascii?Q?uziTvkzV/ta/m00pdXmxNMq2vCEve2LkqAaCgigDnWJEsdxv/psod8VcTAvJ?=
 =?us-ascii?Q?MItUHrWrXaZnEWl8QTalhXNjY7JF+yyGyOk6aTBxRwy4HIBOA/KwdEC0O1tj?=
 =?us-ascii?Q?UYAaCzP11GiKIkVi8+8RtxFYkuXQ8pcxnO9DWtgqxHZAkmr8c1uQf+eQ/onm?=
 =?us-ascii?Q?CnFbbv2miTx5IMyywiMhedIGiJSDUsyZenz2o7nnExvvEFBJC2McvEYUivj1?=
 =?us-ascii?Q?GhqjXRHLUCiyWixezP8jiy5sarUXDQywih//knBgBFD3UUKVdnZMl6/RHU2w?=
 =?us-ascii?Q?USa3jxcHAho049WuuO/xSPvgj+AgUKQNvBy47iU7/hXwKZ87q+gCsZ7LiQbj?=
 =?us-ascii?Q?l2GWl8i5dt0ltRiuMoZ1UMY7ngXOMQRJo1aHt9SLQ7RRrLZ6TQstvq4tYXTF?=
 =?us-ascii?Q?661nSxWUQY0/85v6Gh3cuwzHqjyNmgKXn2UiPr66IQ3qONny+oCEVRWNs1BE?=
 =?us-ascii?Q?p/FWPLT9nvDqPTCyEnV2pmmzVG6amxJYqnuX6FCio7QQmTJppsPvWTUIiutm?=
 =?us-ascii?Q?Wnb6nKq6MMx2iFF+jlgTRWUsNin9W78RL6wHZ1bpF4CFalklzxo3raycfdzA?=
 =?us-ascii?Q?o6gXwSxF5WmewrfiC4+jBVly5vCtcOMWJYDHj7oU6x6Gq22akbfEO+YpwDoQ?=
 =?us-ascii?Q?fs+lUg+2zS8LZ13na6ksOlNvLOYHxFyFrqEuIGrV4T4f542bv5qz8EDnSSJf?=
 =?us-ascii?Q?IUrSQ597WUR+Rw6QrBgfuGq8/AyKsVODDUvVcffsqPzp9TTfugqAzYZ/Jqtr?=
 =?us-ascii?Q?+9wxjj7S1fwFKyx/sf5lVPLMQiub0SMylsjNomzioZxoGUw4M9BhV5fzQdp+?=
 =?us-ascii?Q?t6idfYeg79BisFSnei4E0m4aCLu7V9tfNMu4VX9nWYGY6vcjYzSKbLfkofcu?=
 =?us-ascii?Q?SApM4uHx/XCfx2FxpV0CycuckigARtu9oRgvvaPrD2q78xgnYrTJbw3kKqyR?=
 =?us-ascii?Q?zz/vQSNh6bXexGSIQCkGtJ0VbttDl6XdEPzLVGe+PamdIBlQC7K5LPJRw+yA?=
 =?us-ascii?Q?uIhbWzja+QwlNezX7tMOSn7v2fbPIKynIdpPI41V5/SuFu45Cf4e+YjkqfG5?=
 =?us-ascii?Q?X2S7asnRCbzfimkrC4=3D?=
X-Microsoft-Antispam-Message-Info: kQC/nyjLkX6Ii7xCg7JXqyj53ranl2IbWSqbnWOmXJK8/ZBt7yVW8I2N7mh2VNxhqcrzIn7TJ4oeMe7qbJJT+UccVSy7XJw+wetZhbq8Br2mjwamP+O9n+OmbhvDUAZNpCNPq4c9mPJ8iMOGM0ZpATkF2fsSv9YzJYgXmJiT+F2HJXC9ikEvXRc+NSajm+H3
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3528;6:/mPOh1Tq8YO+IqVXXYeIucaN+yt/b1HPumqzLlCEL3BEHdUnUoibzlMQQtP3Rf/D5XAik58nuEcTX/wVuGWKfbE4WWl8bzFre74RpBUkbmA/st+yILciJ9MU3Ebr/TjSd/h+xDy8R9xWUjJ6+eU2G85tQ1PJObrSwLZcNi2PtzA88ky80O8Vpqk8Uwz0JNYC6DP25UC9CmgO5D4I5GbIMVaQbYqexe3AoJnv4qkCUflsU1FT9ZaDLI7wXbwMXcptRJQoWsHfuH4UEo7sjyxteLHtZaoH+kt5kEWgJiB7/YJnlIWPVvuxj6TI9Vgju1ALcTNl2FS+E1uTN0NegRRN8v3rav9ZfQNZbfftS6tGb1NqlmoOFC+b6bxmaM+caxRC1jVd7WgxU2rYu+4qajqwku+CtrB6WfGO37iB26cPvJaFjkeTinZltOGNLR9jTVwIfFKt/1kdWYXKD8C1CqGOgQ==;5:oypolXTVjssrmybapQg+8eDnvCG5ceeFHym38R7YZinbmMkswNda7IJdmyU52DSXbogFsmkdrlrUh6eT6omS/HycsrxDZJDGV8GReTK0DBb6leBcF1aFkvCY9VfDt1xa15l7BmENRjjD4dR9eWVEvtfEyAvSyEi2ucM3ZkT7B0U=;24:v6JpW039kbCVYLq/eNOqir8sAHdPoatPD2Rgy/V/wi38JOPxaCr1wZ2LxJTG6gfrsGe3BnQ0WTbHpaR6m79oLWyNZR9cTA2C8vsUyK2dDEI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3528;7:WwOXavOw2A8R/Ndq6x+ceSv2dsMfPEDBDGbxtokMymzsG6fk5KI7ONVVmvR8cZXu9YcGqVzHl+kpcqXOKwITfs7wIx5s2fH9JtfsdrRyaSFzpNW6UcECFrzM0AFIjBWf+scmN0wEYfUrXLmX7mtyQz5aPiK7gRphU0MWz53n+TflRkoKPqqMzh7bQzcrZMb68g/OL3yqy2udUbiIuntHsKM+whgDk2sYPMLs6d+XDlTB9KNh1btRQOjXAOv5Pl00
X-MS-Office365-Filtering-Correlation-Id: ff21872c-f3ab-4819-630b-08d5cc781240
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2018 13:10:41.4180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff21872c-f3ab-4819-630b-08d5cc781240
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3528
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD5758 is a single channel DAC with 16-bit precision which uses the SPI
interface that operates at clock rates up to 50MHz.

The output can be configured as voltage or current and is available on a
single terminal.

Datasheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/ad5758.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- removed unnecessary parenthesis in AD5758_REG_WRITE macro.
	- added missing documentation fields of ad5758_state struct.
	- changed the type of pwr_down attribute to bool.
	- changed ad5758_dc_dc_ilimt[] to ad5758_dc_dc_ilim[].
	- ad5758_spi_reg_write() now returns spi_write(st->spi,
	  &st->data[0].d32, sizeof(st->data[0].d32));
	- removed unnecessary new line in ad5758_calib_mem_refresh().
	- changed the type of the mode parameter in
	  ad5758_set_dc_dc_conv_mode() from unsigned int to enum
	  ad5758_dc_dc_mode.
	- removed unnecessary parenthesis in ad5758_slew_rate_config().
	- changed the type of the enable parameter in
	  ad5758_fault_prot_switch_en() from unsigned char to bool.
	- the same as above, but for ad5758_internal_buffers_en().
	- added a missing mutex_unlock() in ad5758_reg_access().
	- moved the mutex_unlock() in ad5758_read_raw() and removed the
	  unreachable return.
	- returned directly where it was possible in ad5758_write_raw().
	- removed the channel, scan_type and scan_index fields.
	- in ad5758_parse_dt(), added missing "\n", and specified what the
	  default mode actually is.
	- returned directly at the end of ad5758_init().
	- in ad5758_probe() used device managed for registering the device
	  and returned directly without the error message.

 MAINTAINERS              |   7 +
 drivers/iio/dac/Kconfig  |  10 +
 drivers/iio/dac/Makefile |   1 +
 drivers/iio/dac/ad5758.c | 805 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 823 insertions(+)
 create mode 100644 drivers/iio/dac/ad5758.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b65225..1993779 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -802,6 +802,13 @@ S:	Supported
 F:	drivers/iio/dac/ad5686*
 F:	drivers/iio/dac/ad5696*
 
+ANALOG DEVICES INC AD5758 DRIVER
+M:	Stefan Popa <stefan.popa@analog.com>
+L:	linux-iio@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/dac/ad5758.c
+
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 06e90de..80beb64 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -167,6 +167,16 @@ config AD5755
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5755.
 
+config AD5758
+	tristate "Analog Devices AD5758 DAC driver"
+	depends on SPI_MASTER
+	help
+	  Say yes here to build support for Analog Devices AD5758 single channel
+	  Digital to Analog Converter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad5758.
+
 config AD5761
 	tristate "Analog Devices AD5761/61R/21/21R DAC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 57aa230..e859f2d 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
 obj-$(CONFIG_AD5592R) += ad5592r.o
 obj-$(CONFIG_AD5593R) += ad5593r.o
 obj-$(CONFIG_AD5755) += ad5755.o
+obj-$(CONFIG_AD5758) += ad5758.o
 obj-$(CONFIG_AD5761) += ad5761.o
 obj-$(CONFIG_AD5764) += ad5764.o
 obj-$(CONFIG_AD5791) += ad5791.o
diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
new file mode 100644
index 0000000..3008a3a
--- /dev/null
+++ b/drivers/iio/dac/ad5758.c
@@ -0,0 +1,805 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AD5758 Digital to analog converters driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ */
+
+#include <linux/fs.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/spi/spi.h>
+#include <linux/delay.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/property.h>
+
+/* AD5758 registers definition */
+#define AD5758_NOP					0x00
+#define AD5758_DAC_INPUT				0x01
+#define AD5758_DAC_OUTPUT				0x02
+#define AD5758_CLEAR_CODE				0x03
+#define AD5758_USER_GAIN				0x04
+#define AD5758_USER_OFFSET				0x05
+#define AD5758_DAC_CONFIG				0x06
+#define AD5758_SW_LDAC					0x07
+#define AD5758_KEY					0x08
+#define AD5758_GP_CONFIG1				0x09
+#define AD5758_GP_CONFIG2				0x0A
+#define AD5758_DCDC_CONFIG1				0x0B
+#define AD5758_DCDC_CONFIG2				0x0C
+#define AD5758_WDT_CONFIG				0x0F
+#define AD5758_DIGITAL_DIAG_CONFIG			0x10
+#define AD5758_ADC_CONFIG				0x11
+#define AD5758_FAULT_PIN_CONFIG				0x12
+#define AD5758_TWO_STAGE_READBACK_SELECT		0x13
+#define AD5758_DIGITAL_DIAG_RESULTS			0x14
+#define AD5758_ANALOG_DIAG_RESULTS			0x15
+#define AD5758_STATUS					0x16
+#define AD5758_CHIP_ID					0x17
+#define AD5758_FREQ_MONITOR				0x18
+#define AD5758_DEVICE_ID_0				0x19
+#define AD5758_DEVICE_ID_1				0x1A
+#define AD5758_DEVICE_ID_2				0x1B
+#define AD5758_DEVICE_ID_3				0x1C
+
+/* AD5758_DAC_CONFIG */
+#define AD5758_DAC_CONFIG_RANGE_MSK			GENMASK(3, 0)
+#define AD5758_DAC_CONFIG_RANGE_MODE(x)			(((x) & 0xF) << 0)
+#define AD5758_DAC_CONFIG_OVRNG_EN_MSK			BIT(4)
+#define AD5758_DAC_CONFIG_OVRNG_EN_MODE(x)		(((x) & 0x1) << 4)
+#define AD5758_DAC_CONFIG_INT_EN_MSK			BIT(5)
+#define AD5758_DAC_CONFIG_INT_EN_MODE(x)		(((x) & 0x1) << 5)
+#define AD5758_DAC_CONFIG_OUT_EN_MSK			BIT(6)
+#define AD5758_DAC_CONFIG_OUT_EN_MODE(x)		(((x) & 0x1) << 6)
+#define AD5758_DAC_CONFIG_RSET_EXT_EN_MSK		BIT(7)
+#define AD5758_DAC_CONFIG_RSET_EXT_EN_MODE(x)		(((x) & 0x1) << 7)
+#define AD5758_DAC_CONFIG_SR_EN_MSK			BIT(8)
+#define AD5758_DAC_CONFIG_SR_EN_MODE(x)			(((x) & 0x1) << 8)
+#define AD5758_DAC_CONFIG_SR_CLOCK_MSK			GENMASK(12, 9)
+#define AD5758_DAC_CONFIG_SR_CLOCK_MODE(x)		(((x) & 0xF) << 9)
+#define AD5758_DAC_CONFIG_SR_STEP_MSK			GENMASK(15, 13)
+#define AD5758_DAC_CONFIG_SR_STEP_MODE(x)		(((x) & 0x7) << 13)
+
+/* AD5758_KEY */
+#define AD5758_KEY_CODE_RESET_1				0x15FA
+#define AD5758_KEY_CODE_RESET_2				0xAF51
+#define AD5758_KEY_CODE_SINGLE_ADC_CONV			0x1ADC
+#define AD5758_KEY_CODE_RESET_WDT			0x0D06
+#define AD5758_KEY_CODE_CALIB_MEM_REFRESH		0xFCBA
+
+/* AD5758_DCDC_CONFIG1 */
+#define AD5758_DCDC_CONFIG1_DCDC_VPROG_MSK		GENMASK(4, 0)
+#define AD5758_DCDC_CONFIG1_DCDC_VPROG_MODE(x)		(((x) & 0x1F) << 0)
+#define AD5758_DCDC_CONFIG1_DCDC_MODE_MSK		GENMASK(6, 5)
+#define AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(x)		(((x) & 0x3) << 5)
+#define AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MSK	BIT(7)
+#define AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MODE(x)	(((x) & 0x1) << 7)
+
+/* AD5758_DCDC_CONFIG2 */
+#define AD5758_DCDC_CONFIG2_ILIMIT_MSK			GENMASK(3, 1)
+#define AD5758_DCDC_CONFIG2_ILIMIT_MODE(x)		(((x) & 0x7) << 1)
+#define AD5758_DCDC_CONFIG2_ADC_CONTROL_DIAG_MSK	GENMASK(5, 4)
+#define AD5758_DCDC_CONFIG2_ADC_CONTROL_DIAG_MODE(x)	(((x) & 0x3) << 4)
+#define AD5758_DCDC_CONFIG2_VIOUT_PULLDOWN_EN_MSK	BIT(6)
+#define AD5758_DCDC_CONFIG2_VIOUT_PULLDOWN_EN_MODE(x)	(((x) & 0x1) << 6)
+#define AD5758_DCDC_CONFIG2_SHORT_DEGLITCH_MSK		BIT(7)
+#define AD5758_DCDC_CONFIG2_SHORT_DEGLITCH_MODE(x)	(((x) & 0x1) << 7)
+#define AD5758_DCDC_CONFIG2_READ_COMP_DIS_MSK		BIT(10)
+#define AD5758_DCDC_CONFIG2_READ_COMP_DIS_MODE(x)	(((x) & 0x1) << 10)
+#define AD5758_DCDC_CONFIG2_INTR_SAT_3WI_MSK		BIT(11)
+#define AD5758_DCDC_CONFIG2_BUSY_3WI_MSK		BIT(12)
+
+/* AD5758_DIGITAL_DIAG_RESULTS */
+#define AD5758_DIG_DIAG_RES_CAL_MEM_UNREFRESHED_MSK	BIT(15)
+
+#define AD5758_REG_WRITE(x)	(0x80 | ((x) & 0x1F))
+
+/* x^8 + x^2 + x^1 + x^0 */
+#define AD5758_CRC8_POLY	0x07
+
+/**
+ * struct ad5758_state - driver instance specific data
+ * @spi:	spi_device
+ * @lock:	mutex lock
+ * @dc_dc_mode:	variable which stores the mode of operation
+ * @dc_dc_ilim:	variable which stores the dc-to-dc converter current limit
+ * @sr_config:	array which stores the slew rate settings
+ * @out_range:	variable which stores the output range
+ * @pwr_down:	variable which contains whether a channel is powered down or not
+ * @data:	spi transfer buffers
+ */
+
+struct ad5758_state {
+	struct spi_device *spi;
+	struct mutex lock;
+	unsigned int dc_dc_mode;
+	unsigned int dc_dc_ilim;
+	unsigned int sr_config[3];
+	unsigned int out_range;
+	bool pwr_down;
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+
+	union {
+		__be32 d32;
+		u8 d8[4];
+	} data[3] ____cacheline_aligned;
+};
+
+enum ad5758_output_range {
+	AD5758_RANGE_0V_5V,
+	AD5758_RANGE_0V_10V,
+	AD5758_RANGE_PLUSMINUS_5V,
+	AD5758_RANGE_PLUSMINUS_10V,
+	AD5758_RANGE_0mA_20mA = 8,
+	AD5758_RANGE_0mA_24mA,
+	AD5758_RANGE_4mA_24mA,
+	AD5758_RANGE_PLUSMINUS_20mA,
+	AD5758_RANGE_PLUSMINUS_24mA,
+	AD5758_RANGE_MINUS_1mA_PLUS_22mA,
+};
+
+enum ad5758_dc_dc_mode {
+	AD5758_DCDC_MODE_POWER_OFF,
+	AD5758_DCDC_MODE_DPC_CURRENT,
+	AD5758_DCDC_MODE_DPC_VOLTAGE,
+	AD5758_DCDC_MODE_PPC_CURRENT,
+};
+
+struct ad5758_range {
+	int reg;
+	int min;
+	int max;
+};
+
+static const struct ad5758_range ad5758_min_max_table[] = {
+	{ AD5758_RANGE_0V_5V, 0, 5000 },
+	{ AD5758_RANGE_0V_10V, 0, 10000 },
+	{ AD5758_RANGE_PLUSMINUS_5V, -5000, 5000 },
+	{ AD5758_RANGE_PLUSMINUS_10V, -10000, 10000 },
+	{ AD5758_RANGE_0mA_20mA, 0, 20},
+	{ AD5758_RANGE_0mA_24mA, 0, 24 },
+	{ AD5758_RANGE_4mA_24mA, 4, 24 },
+	{ AD5758_RANGE_PLUSMINUS_20mA, -20, 20 },
+	{ AD5758_RANGE_PLUSMINUS_24mA, -24, 24 },
+	{ AD5758_RANGE_MINUS_1mA_PLUS_22mA, -1, 22 },
+};
+
+static const int ad5758_slew_rate_clk[16] = {
+	240000, 200000, 150000, 128000, 64000, 32000, 16000, 8000, 4000, 2000,
+	1000, 512, 256, 128, 64, 16
+};
+
+static const int ad5758_slew_rate_step[8] = {
+	4, 12, 64, 120, 256, 500, 1820, 2048
+};
+
+static const int ad5758_dc_dc_ilim[6] = {
+	150, 200, 250, 300, 350, 400
+};
+
+static int ad5758_spi_reg_read(struct ad5758_state *st, unsigned int addr)
+{
+	struct spi_transfer t[] = {
+		{
+			.tx_buf = &st->data[0].d8[0],
+			.len = 4,
+			.cs_change = 1,
+		}, {
+			.tx_buf = &st->data[1].d8[0],
+			.rx_buf = &st->data[2].d8[0],
+			.len = 4,
+		},
+	};
+	int ret;
+
+	st->data[0].d32 = cpu_to_be32(
+		(AD5758_REG_WRITE(AD5758_TWO_STAGE_READBACK_SELECT) << 24) |
+		(addr << 8));
+	st->data[1].d32 = cpu_to_be32(AD5758_REG_WRITE(AD5758_NOP) << 24);
+
+	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
+	if (ret < 0)
+		return ret;
+
+	return (be32_to_cpu(st->data[2].d32) >> 8) & 0xFFFF;
+}
+
+static int ad5758_spi_reg_write(struct ad5758_state *st,
+				unsigned int addr,
+				unsigned int val)
+{
+	st->data[0].d32 = cpu_to_be32((AD5758_REG_WRITE(addr) << 24) |
+				      ((val & 0xFFFF) << 8));
+
+	return spi_write(st->spi, &st->data[0].d32, sizeof(st->data[0].d32));
+}
+
+static int ad5758_spi_write_mask(struct ad5758_state *st,
+				 unsigned int addr,
+				 unsigned long int mask,
+				 unsigned int val)
+{
+	int regval;
+
+	regval = ad5758_spi_reg_read(st, addr);
+	if (regval < 0)
+		return regval;
+
+	regval &= ~mask;
+	regval |= val;
+
+	return ad5758_spi_reg_write(st, addr, regval);
+}
+
+static int ad5758_get_array_index(const int *array, unsigned int size, int val)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		if (val == array[i])
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int ad5758_wait_for_task_complete(struct ad5758_state *st,
+					 unsigned int reg,
+					 unsigned int mask)
+{
+	unsigned int timeout;
+	int ret;
+
+	timeout = 4;
+	do {
+		ret = ad5758_spi_reg_read(st, reg);
+		if (ret < 0)
+			return ret;
+
+		if (!(ret & mask))
+			return 0;
+
+		mdelay(1);
+	} while (--timeout);
+
+	dev_err(&st->spi->dev,
+		"Error reading bit 0x%x in 0x%x register\n", mask, reg);
+
+	return -EIO;
+}
+
+static int ad5758_calib_mem_refresh(struct ad5758_state *st)
+{
+	int ret;
+
+	ret = ad5758_spi_reg_write(st, AD5758_KEY,
+				   AD5758_KEY_CODE_CALIB_MEM_REFRESH);
+	if (ret < 0) {
+		dev_err(&st->spi->dev,
+			"Failed to initiate a calibration memory refresh\n");
+		return ret;
+	}
+
+	/* Wait to allow time for the internal calibrations to complete */
+	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
+				AD5758_DIG_DIAG_RES_CAL_MEM_UNREFRESHED_MSK);
+}
+
+static int ad5758_soft_reset(struct ad5758_state *st)
+{
+	int ret;
+
+	ret = ad5758_spi_reg_write(st, AD5758_KEY, AD5758_KEY_CODE_RESET_1);
+	if (ret < 0)
+		return ret;
+
+	ret = ad5758_spi_reg_write(st, AD5758_KEY, AD5758_KEY_CODE_RESET_2);
+
+	mdelay(1);
+
+	return ret;
+}
+
+static int ad5758_set_dc_dc_conv_mode(struct ad5758_state *st,
+				      enum ad5758_dc_dc_mode mode)
+{
+	int ret;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
+				    AD5758_DCDC_CONFIG1_DCDC_MODE_MSK,
+				    AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(mode));
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
+	 * This allows the 3-wire interface communication to complete.
+	 */
+	ret = ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
+					    AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
+	if (ret < 0)
+		return ret;
+
+	st->dc_dc_mode = mode;
+
+	return ret;
+}
+
+static int ad5758_set_dc_dc_ilim(struct ad5758_state *st, unsigned int ilim)
+{
+	int ret;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG2,
+				    AD5758_DCDC_CONFIG2_ILIMIT_MSK,
+				    AD5758_DCDC_CONFIG2_ILIMIT_MODE(ilim));
+	if (ret < 0)
+		return ret;
+	/*
+	 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
+	 * This allows the 3-wire interface communication to complete.
+	 */
+	return ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
+					     AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
+}
+
+static int ad5758_slew_rate_config(struct ad5758_state *st,
+				   unsigned int enable,
+				   unsigned int sr_clk,
+				   unsigned int sr_step)
+{
+	unsigned int mode;
+	unsigned long int mask;
+	int ret;
+
+	mask = AD5758_DAC_CONFIG_SR_EN_MSK |
+	       AD5758_DAC_CONFIG_SR_CLOCK_MSK |
+	       AD5758_DAC_CONFIG_SR_STEP_MSK;
+
+	mode = AD5758_DAC_CONFIG_SR_EN_MODE(enable) |
+		AD5758_DAC_CONFIG_SR_CLOCK_MODE(sr_clk) |
+		AD5758_DAC_CONFIG_SR_STEP_MODE(sr_step);
+
+	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG, mask, mode);
+	if (ret < 0)
+		return ret;
+
+	/* Wait to allow time for the internal calibrations to complete */
+	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
+				AD5758_DIG_DIAG_RES_CAL_MEM_UNREFRESHED_MSK);
+}
+
+static int ad5758_set_out_range(struct ad5758_state *st, unsigned int range)
+{
+	int ret;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
+				    AD5758_DAC_CONFIG_RANGE_MSK,
+				    AD5758_DAC_CONFIG_RANGE_MODE(
+					    ad5758_min_max_table[range].reg));
+	if (ret < 0)
+		return ret;
+
+	/* Wait to allow time for the internal calibrations to complete */
+	ret =  ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
+				AD5758_DIG_DIAG_RES_CAL_MEM_UNREFRESHED_MSK);
+	if (ret < 0)
+		return ret;
+
+	st->out_range = range;
+
+	return ret;
+}
+
+static int ad5758_fault_prot_switch_en(struct ad5758_state *st, bool enable)
+{
+	int ret;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
+			AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MSK,
+			AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MODE(enable));
+	if (ret < 0)
+		return ret;
+	/*
+	 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
+	 * This allows the 3-wire interface communication to complete.
+	 */
+	return ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
+					     AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
+}
+
+static int ad5758_internal_buffers_en(struct ad5758_state *st, bool enable)
+{
+	int ret;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
+				    AD5758_DAC_CONFIG_INT_EN_MSK,
+				    AD5758_DAC_CONFIG_INT_EN_MODE(enable));
+	if (ret < 0)
+		return ret;
+
+	/* Wait to allow time for the internal calibrations to complete */
+	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
+				AD5758_DIG_DIAG_RES_CAL_MEM_UNREFRESHED_MSK);
+}
+
+static int ad5758_reg_access(struct iio_dev *indio_dev,
+			     unsigned int reg,
+			     unsigned int writeval,
+			     unsigned int *readval)
+{
+	struct ad5758_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+	if (readval == NULL) {
+		ret =  ad5758_spi_reg_write(st, reg, writeval);
+	} else {
+		ret = ad5758_spi_reg_read(st, reg);
+		if (ret < 0) {
+			mutex_unlock(&st->lock);
+			return ret;
+		}
+
+		*readval = ret;
+		ret = 0;
+	}
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int ad5758_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad5758_state *st = iio_priv(indio_dev);
+	int max, min, ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		ret = ad5758_spi_reg_read(st, AD5758_DAC_INPUT);
+		mutex_unlock(&st->lock);
+		if (ret < 0)
+			return ret;
+
+		*val = ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		min = ad5758_min_max_table[st->out_range].min;
+		max = ad5758_min_max_table[st->out_range].max;
+		*val = max - min;
+		*val2 = chan->scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad5758_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long info)
+{
+	struct ad5758_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		ret = ad5758_spi_reg_write(st, AD5758_DAC_INPUT, val);
+		mutex_unlock(&st->lock);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t ad5758_read_powerdown(struct iio_dev *indio_dev,
+				     uintptr_t priv,
+				     const struct iio_chan_spec *chan,
+				     char *buf)
+{
+	struct ad5758_state *st = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", st->pwr_down);
+}
+
+static ssize_t ad5758_write_powerdown(struct iio_dev *indio_dev,
+				      uintptr_t priv,
+				      struct iio_chan_spec const *chan,
+				      const char *buf, size_t len)
+{
+	struct ad5758_state *st = iio_priv(indio_dev);
+	bool pwr_down;
+	unsigned int dcdc_config1_mode, dc_dc_mode, dac_config_mode, val;
+	unsigned long int dcdc_config1_msk, dac_config_msk;
+	int ret;
+
+	ret = strtobool(buf, &pwr_down);
+	if (ret)
+		return ret;
+
+	mutex_lock(&st->lock);
+	if (pwr_down) {
+		dc_dc_mode = AD5758_DCDC_MODE_POWER_OFF;
+		val = 0;
+	} else {
+		dc_dc_mode = st->dc_dc_mode;
+		val = 1;
+	}
+
+	dcdc_config1_mode = (AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(dc_dc_mode) |
+			     AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MODE(val));
+	dcdc_config1_msk = (AD5758_DCDC_CONFIG1_DCDC_MODE_MSK |
+			    AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MSK);
+
+	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
+				    dcdc_config1_msk,
+				    dcdc_config1_mode);
+	if (ret < 0)
+		goto err_unlock;
+
+	dac_config_mode = (AD5758_DAC_CONFIG_OUT_EN_MODE(val) |
+			   AD5758_DAC_CONFIG_INT_EN_MODE(val));
+	dac_config_msk =  (AD5758_DAC_CONFIG_OUT_EN_MSK |
+			   AD5758_DAC_CONFIG_INT_EN_MSK);
+
+	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
+				    dac_config_msk,
+				    dac_config_mode);
+	if (ret < 0)
+		goto err_unlock;
+
+	st->pwr_down = pwr_down;
+
+err_unlock:
+	mutex_unlock(&st->lock);
+
+	return ret ? ret : len;
+}
+
+static const struct iio_info ad5758_info = {
+	.read_raw = ad5758_read_raw,
+	.write_raw = ad5758_write_raw,
+	.debugfs_reg_access = &ad5758_reg_access,
+};
+
+static const struct iio_chan_spec_ext_info ad5758_ext_info[] = {
+	{
+		.name = "powerdown",
+		.read = ad5758_read_powerdown,
+		.write = ad5758_write_powerdown,
+		.shared = IIO_SEPARATE,
+	},
+	{ },
+};
+
+static const struct iio_chan_spec ad5758_channels[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
+		.output = 1,
+		.ext_info = ad5758_ext_info,
+	},
+};
+
+static int ad5758_crc_disable(struct ad5758_state *st)
+{
+	st->data[0].d32 =
+		cpu_to_be32(
+		(AD5758_REG_WRITE(AD5758_DIGITAL_DIAG_CONFIG) << 24) | 0x5C3A);
+
+	return spi_write(st->spi, &st->data[0].d8[0], 4);
+}
+
+static void ad5758_parse_dt(struct ad5758_state *st)
+{
+	unsigned int i, tmp, tmparray[3];
+	int index;
+
+	st->dc_dc_ilim = 150;
+	if (!device_property_read_u32(&st->spi->dev,
+				      "adi,dc-dc-ilim", &tmp)) {
+		index = ad5758_get_array_index(ad5758_dc_dc_ilim,
+					ARRAY_SIZE(ad5758_dc_dc_ilim), tmp);
+		if (index < 0)
+			dev_warn(&st->spi->dev,
+				 "dc-dc-ilim out of range, using 150mA\n");
+		else
+			st->dc_dc_ilim = index;
+	} else {
+		dev_dbg(&st->spi->dev,
+			 "Missing \"dc-dc-ilim\" property, using 150mA\n");
+	}
+
+	st->dc_dc_mode = AD5758_DCDC_MODE_DPC_VOLTAGE;
+	if (device_property_read_u32(&st->spi->dev, "adi,dc-dc-mode",
+				     &st->dc_dc_mode))
+		dev_dbg(&st->spi->dev,
+			"Missing \"dc-dc-mode\" property, using DPC_VOLTAGE\n");
+
+	/* 0 V to 5 V voltage range */
+	st->out_range = 0;
+	if (!device_property_read_u32(&st->spi->dev, "adi,range", &tmp)) {
+		for (i = 0; i < ARRAY_SIZE(ad5758_min_max_table); i++) {
+			if (tmp == ad5758_min_max_table[i].reg) {
+				st->out_range = i;
+				break;
+			}
+		}
+
+		if (i == ARRAY_SIZE(ad5758_min_max_table))
+			dev_warn(&st->spi->dev,
+				 "range invalid, using 0V to 5V\n");
+	} else {
+		dev_dbg(&st->spi->dev,
+			"Missing \"range\" property, using 0V to 5V\n");
+	}
+
+	st->sr_config[0] = 1;
+	st->sr_config[1] = 16000;
+	st->sr_config[2] = 4;
+	if (!device_property_read_u32_array(&st->spi->dev, "adi,slew",
+					    tmparray, 3)) {
+		st->sr_config[0] = tmparray[0];
+
+		index = ad5758_get_array_index(ad5758_slew_rate_clk,
+					       ARRAY_SIZE(ad5758_slew_rate_clk),
+					       tmparray[1]);
+
+		if (index < 0)
+			dev_warn(&st->spi->dev,
+				"slew rate clock out of range, using 16kHz\n");
+		else
+			st->sr_config[1] = index;
+
+		index = ad5758_get_array_index(ad5758_slew_rate_step,
+					ARRAY_SIZE(ad5758_slew_rate_step),
+					tmparray[2]);
+
+		if (index < 0)
+			dev_warn(&st->spi->dev,
+				"slew rate step out of range, using 4 LSB\n");
+		else
+			st->sr_config[2] = index;
+	} else {
+		dev_dbg(&st->spi->dev,
+			 "Missing \"slew\" property, using 16kHz and 4 LSB\n");
+	}
+}
+
+static int ad5758_init(struct ad5758_state *st)
+{
+	int regval, ret;
+
+	ad5758_parse_dt(st);
+
+	/* Disable CRC checks */
+	ret = ad5758_crc_disable(st);
+	if (ret < 0)
+		return ret;
+
+	/* Perform a software reset */
+	ret = ad5758_soft_reset(st);
+	if (ret < 0)
+		return ret;
+
+	/* Disable CRC checks */
+	ret = ad5758_crc_disable(st);
+	if (ret < 0)
+		return ret;
+
+	/* Perform a calibration memory refresh */
+	ret = ad5758_calib_mem_refresh(st);
+	if (ret < 0)
+		return ret;
+
+	regval = ad5758_spi_reg_read(st, AD5758_DIGITAL_DIAG_RESULTS);
+	if (regval < 0)
+		return regval;
+
+	/* Clear all the error flags */
+	ret = ad5758_spi_reg_write(st, AD5758_DIGITAL_DIAG_RESULTS, regval);
+	if (ret < 0)
+		return ret;
+
+	/* Set the dc-to-dc current limit */
+	ret = ad5758_set_dc_dc_ilim(st, st->dc_dc_ilim);
+	if (ret < 0)
+		return ret;
+
+	/* Configure the dc-to-dc controller mode */
+	ret = ad5758_set_dc_dc_conv_mode(st, st->dc_dc_mode);
+	if (ret < 0)
+		return ret;
+
+	/* Configure the output range */
+	ret = ad5758_set_out_range(st, st->out_range);
+	if (ret < 0)
+		return ret;
+
+	/* Enable Slew Rate Control, set the slew rate clock and step */
+	ret = ad5758_slew_rate_config(st, st->sr_config[0],
+				      st->sr_config[1], st->sr_config[2]);
+	if (ret < 0)
+		return ret;
+
+	/* Enable the VIOUT fault protection switch (FPS is closed) */
+	ret = ad5758_fault_prot_switch_en(st, 1);
+	if (ret < 0)
+		return ret;
+
+	/* Power up the DAC and internal (INT) amplifiers */
+	ret = ad5758_internal_buffers_en(st, 1);
+	if (ret < 0)
+		return ret;
+
+	/* Enable VIOUT */
+	return ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
+				     AD5758_DAC_CONFIG_OUT_EN_MSK,
+				     AD5758_DAC_CONFIG_OUT_EN_MODE(1));
+}
+
+static int ad5758_probe(struct spi_device *spi)
+{
+	struct ad5758_state *st;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
+
+	st->spi = spi;
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &ad5758_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad5758_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad5758_channels);
+
+	mutex_init(&st->lock);
+
+	ret = ad5758_init(st);
+	if (ret < 0) {
+		dev_err(&spi->dev, "AD5758 init failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(&st->spi->dev, indio_dev);
+}
+
+static const struct spi_device_id ad5758_id[] = {
+	{ "ad5758", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad5758_id);
+
+static struct spi_driver ad5758_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+	.probe = ad5758_probe,
+	.id_table = ad5758_id,
+};
+
+module_spi_driver(ad5758_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD5758 DAC");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

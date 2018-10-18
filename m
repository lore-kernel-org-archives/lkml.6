Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394EDC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA58921476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="VRcLzOSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA58921476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeJRRN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:13:26 -0400
Received: from mail-by2nam01on0082.outbound.protection.outlook.com ([104.47.34.82]:23836
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727363AbeJRRN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3Kt6cqpJD4C6/e9H0WxCTKA5HGAGtN2jB7uVeIVgkQ=;
 b=VRcLzOSJSbb+rApT4IOc1IC3nSw9OS8zgV+JLDULVG+f3t23F2iZvY13hUJzdFoQGPt/arsmmCy0T2Vl6yUTFCLI47T1adsSZTwaGlpNFvMQcoxZi4KozryW0Vq9zeLOKLl1gRazLjRWgZuBdejTxJEc6ML7PmlJ33xTOuKmEvQ=
Received: from DM6PR03CA0020.namprd03.prod.outlook.com (2603:10b6:5:40::33) by
 BL2PR03MB546.namprd03.prod.outlook.com (2a01:111:e400:c24::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Thu, 18 Oct 2018 09:13:17 +0000
Received: from BY2FFO11FD011.protection.gbl (2a01:111:f400:7c0c::157) by
 DM6PR03CA0020.outlook.office365.com (2603:10b6:5:40::33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.31 via Frontend Transport; Thu, 18 Oct 2018 09:13:17 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BY2FFO11FD011.mail.protection.outlook.com (10.1.14.129) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.12
 via Frontend Transport; Thu, 18 Oct 2018 09:13:16 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w9I9DFxh023164
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 18 Oct 2018 02:13:15 -0700
Received: from linux.analog.com (10.50.1.118) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Thu, 18 Oct 2018
 05:13:15 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH 2/2] dt-bindings: iio: adc: Add docs for AD7606 ADC
Date:   Thu, 18 Oct 2018 12:12:36 +0300
Message-ID: <1539853956-26644-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39850400004)(346002)(2980300002)(438002)(189003)(199004)(5820100001)(107886003)(426003)(44832011)(106002)(54906003)(110136005)(476003)(2616005)(47776003)(2906002)(7636002)(126002)(305945005)(6306002)(336012)(486006)(6346003)(26005)(53416004)(50226002)(77096007)(186003)(106466001)(246002)(8936002)(50466002)(72206003)(6666004)(5660300001)(356004)(36756003)(7416002)(966005)(23676004)(8676002)(7696005)(2870700001)(1720100001)(4326008)(316002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB546;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD011;1:aXo094t10NCKH3KIophO76cz9wCtDEdWn0bC+RCCZVnaEYCKOT90/OVH1Z1zJhZLtyoXpyOgHiFeJQU+Ue7LrZiRAI1ZOUPkEl5VrspQ+V7xo62HSK3f5/WSqoqHtieF
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3cfe2c1-1d1b-48f5-51bf-08d634d9f094
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BL2PR03MB546;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;3:BZoXGEMJ/ksMEXl1Qb4+cgfTp23tL4+1mxCxpTeEzAYqCAEV+S5TQhSuO4rTfg672XNMkMDOlXIP5kxv0zSO9JHlHnRNdsq18qdfBvItxUtO0iq7jLQWbR5RklezCTxbrW/vtqT1i38dbie+oWqiO0P6FkAXtUO0D+Xo0rGjkJ/wwReqn1EzzXI5ole7sKpDyNQejwICrpwQYHas8UiaG3ZbUzL5KHriCaxR0sZ1iGIp/oloYGc0uQ+g8lUuuRxs3nHBNDHyZDMe5+T1wz9wN7Y8txPuoTNphJWnVORcMEn/wip78yWOC6EdCs3EDDwh8gLrG2f2FrIOJJMSbtHlMOZ5fdJv5HVQmiuvhkrcivk=;25:ugCS8cQP1VG19uJoh0DTAAqFE8z8WAHoCXd1xzUk3SATXHKopkjO/MxJUxcW3NlxSwMb7dH/4yfQjwcSlNtsSNZrVWvYkSpuLGjJKfc3DGLKDfCG2GUqMln9fhlcI+WhxPd8vmfNMM3JQxAQEtv1iiaKcPboYmJB0yhkLukZPb/Oh1nhdXsXGU+ZJ0icC0sB+dG8wcVdUsMBRuRKuD2lLOw0FH2sA3ZvmrG1FO//7JWtG1XQlU1+IvE1o116GF2m9MkGs4KgztyrauyJZoQha1SL0ntc0I8ryFNejkigWr9m5fDoC1COZuvkoxB9VUhB0pWdqkQJhQ5E1mU/QQx2dBR8xyrLBtoGgvtSxmbXYUI=
X-MS-TrafficTypeDiagnostic: BL2PR03MB546:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;31:wtb8IRqP7DHqCRRooUaduuGeQRSj6hHjTplFgAAkagJ85N0GUkdHEAQI3L2r5IYbCJkchZ1Xcvx4D27qu9tFcSHn5X0qEtuU6lAm23eXOL2GeiWrqKyEQHgP36ftFgmXhj/C6LLTiy7GKJaTU5VvGcfwTyanwKWFCM4Ez2qkPxFwmw4ZnXuc/WBiLXY3OHxRgf7etAFDmV7eRtlC+PVT8OlS62jMhea3qWvsjrZua18=;20:R80GukLMEAohdhlZ6J69JdaGSkMeEp/k+ZoR6DJllCPFI+Zu/HPL76mOyCW2Td4qZuak+LfTGnDVOoT0332loXvAmA04NTY6+cPKTe32gnUS0WiupPJNEdFNxzi7J/HwSgIU/OCI++B3NkfnpU5GP7AxbuBK7RGE7TFezEn30SD4+iPznLDjcSZhUkOQ/tk6FDiRbwFAc/KKJpSZHJFhGJ2kd/41fextLsacIArKASkcsjw0NcKYfGLiNW43xqAGhG2xy46ZvARYinYKRl60pQM+lG+L8dpN2vHAIQq3JL2TmwYf3qYxN+RqECxCXj6LCzPBv3HXw9T1f67as/Y998bqHq1sOsEIw5vCQNs/7VCGglBCZEw/zINLTfr/0XDJ5oJWtIG69bd3QBNxA5HWJVzfsNQIsAdVHibzO4dGFp20sD4p8lYCv4IE9Hq0crU7oXL35hEczr35HhNTPCl8J5uLqorg5ZVeJJLatGGUnS0cS/fuAWloCFVZd0MNOLIL
X-Microsoft-Antispam-PRVS: <BL2PR03MB5465D6F3FE855162193C3939DF80@BL2PR03MB546.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(9452136761055)(170811661138872)(95692535739014);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(4982022)(52105095)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BL2PR03MB546;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB546;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;4:spmpy6F+e6HQ85/ehHRCcVpYQB8qApZUkRK7YxrDKIk/9SrUW2ck3AD6ddWsuZTQB7DV11YuET8GUy/bWa8rWaYYtC9/QBuhrPvDl5t50XGHK7s/NDvt3Vk3u174aCQ6pKVZ11McanS1XynyJRsm/u7oSaEklwxJ7msmxL51egQ8oxxEsUjgAwpx69iZUkumFo0fjfYiFyvpZXcO+Y1p0yHyzq5klH4fgUnAqmXSVZNSZxQT+PGtH/KmhpdBDs8tzgzP2QhR6ft24mXBR+4hXR/D1e9J2FY5eM9bbRj/cXfeABwiBG3Wja4V+wNMJNV+PxxxKoM9844GDN2uxfMTWwDU+xHIat5x0k9/u33YfAirHbTfzJkgcv8QIDvbj4Y8uxFulpajtgYpBJ/hMgjb4au7XRw/pKs0LDLe+JMbjgc=
X-Forefront-PRVS: 08296C9B35
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDJQUjAzTUI1NDY7MjM6SnR2NmFFUUFlRU4wcTJ3TWRFaWh3OFlZYnJY?=
 =?utf-8?B?M2JBUk9PUDhEeTlPak91WTJuRFNGRmhpbi8vZE9MWFVjZnIxd3JWQlpGbGpS?=
 =?utf-8?B?Wlg5cm1mMTB5MXlMWmF0MzBFS2xic1BhU0pMZFRQcFlZeVVhOFN0WEZ3NWow?=
 =?utf-8?B?RTJXQ21aaitKcW55QmY0VXd1M2lTaFFHeVlyUmU3VFYxVkY4M1REaWFRWHUy?=
 =?utf-8?B?YkRFMlI3eGliSmh6RzE0c0RGNkFiRWN5V3FoZitGL2FtaUVkQm1NRTVyU21O?=
 =?utf-8?B?MFEvalk3aTBqazl1Ti81ZTZTR21ac3FXVWxvWU5PN1hzcGF0TEVOb0FQSWdn?=
 =?utf-8?B?ZUt3bHlIWExGUW9EeW9jWmNsWUVocTNhcDZ2UExmRGIvSDFtS3lYU1diSTMx?=
 =?utf-8?B?d1hUa3kyazF6ZEZCTXE0ZHRTNjdYRGo3WUFISVluMFdxTEczaEUyWUNUTWhG?=
 =?utf-8?B?VDFoY3hRNngrZVkwb3pjMFRYZjkrdDBHZmlud1QvNElMVmgvN3pRU1Vzb0wr?=
 =?utf-8?B?a3Y4SnBJVWVQeUZXU0FrMHZrZU9haTRoTTN0NnV3N1pJOHBmWEo4dFdQcWx5?=
 =?utf-8?B?ek5CbWJzblpHY3NaaG9oSHRaQkZxMG8rWUtqVndVRldML0FqcU50bC9xVk5V?=
 =?utf-8?B?aXBtdDBuZ3dFSmJ0NDc0cEExTVpGMEFvMC9DVzRlMzFDQml3WTNla0E4c1dF?=
 =?utf-8?B?ZDV1cmwwQ1MxVC9VVjRtdkJJRHZYbitZNkhHOWlDME14a3pLTTVkL1ZLcGla?=
 =?utf-8?B?cjN1bU5ieVFpNzRUMjU2OE9qL0FPSzBlUHl2dXcybG5HNTNlMnNJRFF2VnA0?=
 =?utf-8?B?VU5HbGhJellhQm1iWmtiSDFFelV4WG5NOTE2dnJlVFA0aUlDUlVTa2E2NmFG?=
 =?utf-8?B?OG5wWkdQUjVMT0RYMWNFeU1tRlpvUEV5OFVkSGZyTEJER0lRK040UGlhTTVj?=
 =?utf-8?B?RWFuOE16czhrdGorbTFwRjhZdFJRWUJDSnRwNWZPSFZwb2xOa2pjZ2Yva3A0?=
 =?utf-8?B?VkNLNGtVQTZvOUpnRmp6QzhLM2hzRjBwUkFoMy94U2xUYkFoZ1JIUDcrTjFG?=
 =?utf-8?B?YmRqazJDc1R3dVdoQUpwTUlJWW5pY1B2Z1c1aXRVOURaOXhpTjN3ZWh0NzNN?=
 =?utf-8?B?UHFDMGplSzdXOFV1TkZrRDFtaldtQTIwdWlQdy81dCs4T1dsVHhQZStyQ3E1?=
 =?utf-8?B?NXM3czhVcjFBeDh1N0dubnVwTjJEUVhSRmFDZFBRY3lkR2YzeCtlaW41RElx?=
 =?utf-8?B?TzBXK2FDOGo4NVhuTUo0UnhyL1BVYTVaa0dFZFpHcmZuZkJobUpzemRWbEdx?=
 =?utf-8?B?anlDZGZTeDR3Y01tdzczdmtaeVR2T3hQaGM4SUxlNitFU1YxditPT2lsNzc2?=
 =?utf-8?B?RVh3WENDT0tXd21ROUNETGZTZ29BbTlBbEpuVlJFbWRlV3hQNzZkL1Vud2F5?=
 =?utf-8?B?dHZ2K3lXdk5HTlI5ekNmaGZGTXpaV3Y2L1E4MWtpVzFmNTdJMk4xeUtqemJL?=
 =?utf-8?Q?MBFbKIIkO7YV7l2hFLWgk/H0=3D?=
X-Microsoft-Antispam-Message-Info: fx1DCtrMddtoEawbeLYr4bEMM0SXpdwMnG5d0JDW28g1RjK2nzzHXgGqgwgo0EHrBH+mZeynGLlsh+8jUwwfdn+KcT+UFQwX81RRRfW5FIb9mUKRdPIUkx77s1+MdYgK2rej+MMlfWCV2mqVZ+SKpEDqQXWwuEevrKnDFQq/MmUa9ERREYaQnhRMr+FHEK44BVcMnEK9IzAicEAVY3FpIcIOEd4rdcfCGAyNpffqDGuQepZKThbPsq0juLdd6cjeP5KwYjQdKuFC6frwOZbIpOOUOzQGn3A5zjjSJGcQcj2NMfuHeiSMNH5hzBEKlfh5q3auooGcbhPT71RtTfxrOwxO+n1jEhisUeufVsf52fk=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;6:ociIDFuM6hWeeQriHa6e4wqz4obvN7so3DYiFa6le0LB2PFYC+EEi3O3yhcGM+A4MNGludV4AMROIvfz6rFQmangzzwcV5O5Vvjc8gxDnYA++Gh7Kb0KFGsV00WZYjEkU8CW8YovTRhvE/838EUmewiWuDpbVw+CvOj+pySCJeZOyqKhn3uvhWltO02RD9+MyK7bREyJoGjAG3SFTr3VPGmDid8YYSf6LN1LnL+RUOXPqthF+Y8gWFCVV/jCW1YfF8FFIGmrc1drocBdPa2KKiU748BTWbpCICZKRmUW2dJAKxVBlpVFVapRInuK8oImgnYMfFyVtdZalkyPaaBXuH4djE7SA8hDNnIy/fybXKDUvhwzWldIprclXkUBeksEtl53tzgV8PgwNX1M4Q7DyHWIQyypbXuB/blDkQbWn+TfR+gc8I33iADloH1+NYgxdget0dGSCO00FRJJhuHEBw==;5:tBGlqwej2RutWX+VcU1QbieucbRK7J5wTBr1rAPzYcnipSXAiZIZTvPHTW1rAUVgljGU9yQUPHzqYiRi5HI0Tp6J5ZnZ2MAHB6ewUeQw0LHWhdHnhNzgm/Ry9GhzOsYR9/IwO+xylSI/MvEQ9OAgg2iZSCh9IhXhmK2OUTr3d84=;7:FKGHoCDQLHR5vIA516N3WbL4v8I90hgNlwW6L0wyQ4F0ZF0CUJspHLU+rRxQKofJe/ZY8g/vNjWi2cQbmm3YXStjGWphb0iGwQFncTnqDpdz7WZY+h1BIZVnhwqSBLT0GciO12TKG8NT11ukBXoIGTpiuT8ISCKD6pAAIv3YVUlOCDZaoxPAZFmaNSaVOJFGpJ6zku6kf2h+0FeOyL8BrVXwyUMyJXLOvN+eihfoxWJ5GxwZf/NwfoyoL+jaT3yr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2018 09:13:16.5491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cfe2c1-1d1b-48f5-51bf-08d634d9f094
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB546
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document support for AD7606 Analog to Digital Converter.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7606.txt     | 51 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
new file mode 100644
index 0000000..dede581
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
@@ -0,0 +1,51 @@
+Analog Devices AD7606 Simultaneous Sampling ADC
+
+Required properties for the AD7606:
+
+ - compatible: Must be one of "adi,ad7605-4", "adi,ad7606-8", "adi,ad7606-6" or
+ 	       "adi,ad7606-4".
+ - reg: SPI chip select number for the device
+ - spi-max-frequency: Max SPI frequency to use
+ 	see: Documentation/devicetree/bindings/spi/spi-bus.txt
+ - spi-cpha: See Documentation/devicetree/bindings/spi/spi-bus.txt
+ - avcc-supply: phandle to the Avcc power supply
+ - interrupts: IRQ line for the ADC
+ 	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+ - conversion-start-gpio: must be the device tree identifier of the CONVST pin.
+			  This logic input is used to initiate conversions on
+			  the analog input channels.
+
+Optional properties:
+
+ - reset-gpio: must be the device tree identifier of the RESET pin. If specified,
+ 	       it will be asserted during driver probe.
+ - first-data-gpio: must be the device tree identifier of the FRSTDATA pin.
+ 		    The FRSTDATA output indicates when the first channel, V1, is
+		    being read back on either the parallel, byte or serial interface.
+- standby-gpio: must be the device tree identifier of the STBY pin. This pin is used
+		to place the AD7606 into one of two power-down modes, Standby mode or
+		Shutdown mode.
+- range-gpio: must be the device tree identifier of the RANGE pin. The polarity on
+	      this pin determines the input range of the analog input channels. If
+	      this pin is tied to a logic high, the analog input range is ±10V for
+	      allchannels. If this pin is tied to a logic low, the analog input range
+	      is ±5V for all channels.
+
+Example:
+
+	adc@0 {
+		compatible = "adi,ad7606-8";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		spi-cpol;
+
+		avcc-supply = <&adc_vref>;
+
+		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&gpio>;
+
+		conversion-start-gpio = <&gpio 17 0>;
+		reset-gpio = <&gpio 27 0>;
+		first-data-gpio = <&gpio 22 0>;
+		standby-gpio = <&gpio 24 0>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 843545d..6d63db4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -845,6 +845,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/adc/ad7606.c
+F:	Documentation/devicetree/bindings/iio/adc/ad7606.txt
 
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
-- 
2.7.4


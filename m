Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B92C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC99B20821
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jvRQrLrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfBLMoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:44:01 -0500
Received: from mail-eopbgr740072.outbound.protection.outlook.com ([40.107.74.72]:45671
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727150AbfBLMoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHe/LxE/vgHKxDUgwSy6IY9ZhMDHbAn74BdroBCmVeY=;
 b=jvRQrLrYowkMlbqM8cJcsuj0ejAOwL7Fgzc3xvZOjLlI0gBefwLP9ItpK2LtgiPutBgn7hE+R6FS9nh1BBHdyptCbztnE4zoLBCzaVwIgGKOCSBd2yCJ351D0XjSKXHYRQi1gXpx8FaFoeOBVp0eBvsd/eaytsmZubgGEVKfC94=
Received: from BL0PR02CA0020.namprd02.prod.outlook.com (2603:10b6:207:3c::33)
 by MWHPR02MB2653.namprd02.prod.outlook.com (2603:10b6:300:44::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.22; Tue, 12 Feb
 2019 12:43:54 +0000
Received: from CY1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BL0PR02CA0020.outlook.office365.com
 (2603:10b6:207:3c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Tue, 12 Feb 2019 12:43:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT037.mail.protection.outlook.com (10.152.75.77) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Tue, 12 Feb 2019 12:43:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gtXPk-00033Z-6u; Tue, 12 Feb 2019 04:43:52 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gtXPf-00089t-2y; Tue, 12 Feb 2019 04:43:47 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1CChjfv017041;
        Tue, 12 Feb 2019 04:43:45 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gtXPd-000887-HP; Tue, 12 Feb 2019 04:43:45 -0800
Subject: Re: [PATCH v4 0/3] drivers: soc: xilinx: Add support for ZynqMP power
 domain driver
To:     Jolly Shah <jolly.shah@xilinx.com>, <matthias.bgg@gmail.com>,
        <andy.gross@linaro.org>, <shawnguo@kernel.org>,
        <geert+renesas@glider.be>, <bjorn.andersson@linaro.org>,
        <sean.wang@mediatek.com>, <m.szyprowski@samsung.com>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
References: <1549058930-18644-1-git-send-email-jollys@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <260f1225-882f-d49c-8a6b-6d40730081ae@xilinx.com>
Date:   Tue, 12 Feb 2019 13:43:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549058930-18644-1-git-send-email-jollys@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(2980300002)(189003)(199004)(107886003)(76176011)(186003)(31686004)(229853002)(230700001)(2486003)(23676004)(26005)(50466002)(77096007)(6246003)(64126003)(316002)(110136005)(36386004)(106002)(4326008)(54906003)(7416002)(65826007)(58126008)(106466001)(36756003)(2906002)(446003)(126002)(336012)(426003)(11346002)(31696002)(2616005)(9786002)(476003)(2201001)(14444005)(305945005)(8936002)(478600001)(81156014)(486006)(8676002)(44832011)(63266004)(356004)(81166006)(6666004)(65806001)(65956001)(47776003)(107986001)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2653;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT037;1:xMTsDXHkmlkNUr5mBbBR22DC/1rSft13lZOPJWdn6EUh6QhbLhPaRQhOS0we8px2icCnol67CrADHg5zLKa20q/dkAxkQLouPozr2627X0M47COVqYEOxCJZZp5kyVEsV/0hkhpuiHBtMZZcZcnA2g==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c69f522-c338-44f2-be76-08d690e7bedd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:MWHPR02MB2653;
X-MS-TrafficTypeDiagnostic: MWHPR02MB2653:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2653;20:KMfWFjIw7OWWLm0ZQybPbNdr1+Olq34Hpx3lZEfVRYtkq9ZIEwMx9RH6mxgFx3QAPuLsisaO+HjfzgabPAT5s6GQ5CnfGyuFkTfcMY5ULXBYouTKY9r0xDTyS/iOFoMI6kMDte7iUVC5iSRtmYzaGD9NmnGG2MQrYhFnGUqM5+wWBcFmqXAQB0HtldrtFcb/yG8oMbhslIMcuQNeP9CslORq8nGne1QpYb7iR+5s0XOmyNqhFnFOb9BBrz0btwqkXSyoE1mApKmc1Cx+b7YVQkQz4NnnyW51NlqRVecnfFxbUVMZEFEwVNJaajnuF9F7SWZSnFywfD9cMBywTRsFDPjOcXV7HeJwFSErw1ljCD331vN/TFe4Q6yfpLyCEVD0FdPS5iPFefKWrm4F3/CpH5h2FxFD1h4C+EeEELSWQTZ52WBep8FlIhUmJE5gVxeOFyn7pLjt+r+1stfhCEgfL64uza859JUFq88t25yBIb2K53SjRqabPhgTM541+9hE
X-Microsoft-Antispam-PRVS: <MWHPR02MB2653FC22E13AF63BDA27DDABC6650@MWHPR02MB2653.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0946DC87A1
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjAyTUIyNjUzOzIzOmVsbEpQZVJKYTBWeHNpc3QwSFRvY1hEUnR4?=
 =?utf-8?B?b1NVQ1NrN21yL05HTGNHUW9YTXhLQXhzaXpDMHFvenIzNHVieDVTQzZmaXhC?=
 =?utf-8?B?K0Z6V2xnWmNmeGcrbm1UVXJhVW5mQm5EK2M4YURNRGtJdnBZOElpVmNTK1RH?=
 =?utf-8?B?VVc2WmI1cFlOV282Y2tWL3ZlaVRpNnA4UHp6WHdQa2hWbDdzUk43SDFuekdF?=
 =?utf-8?B?UFVtSGJ5M290MEpmaStaODV0VUlKOURYaVdCSVIzOXYrMDYzcFRzT1NhcTNq?=
 =?utf-8?B?dm9ydXllekpDcVRVRDd6d20rUFpMeDgrMFExRHF2VWozR2RFSlRCTmxYYmtH?=
 =?utf-8?B?MUo1bGN3VVoxVURlL1hJVjdsT29IdFB1UFgxTk9OdGQ1WVNFcGJoTlFlZWlj?=
 =?utf-8?B?WlprTUVPWml5SGwrSWU4WXY1cFFFUXNtQmNSQmNvWEJJZEJDSFVXbGJvVW42?=
 =?utf-8?B?R3pXYyszZUJMcjhURzVJMzBzblhHVEU1S1dPNWw0UWNVeXRtY1IwWDlqbHps?=
 =?utf-8?B?TjJoQWl2TXBLU1pERmVJR0JBaXZpbzhmM0lFQ2Vyc082cVJNTjAzRGo2c21M?=
 =?utf-8?B?c1FpM1JFRXpBZksvR0FJWmUvOGY3SEIvK2NmbnFjanFZa3R6ampEMVRiWUtw?=
 =?utf-8?B?TDF6VDlVQ3I5dDRMSEVLYktvMFN6YWxMTHVJUjcxV2Q2OEhKZTlsd1ZrYk1D?=
 =?utf-8?B?dktPRXYxSjRjM1FzTXhYZm5sVDJsT2JlQStRV1AyTkIwZ1ZxaGdDNkxZUjQy?=
 =?utf-8?B?T2FtL3VSNkFvQXdNZ0J4RU5ISy92aG9pODdCanBLVHhmNGdSSnV0bXBoWXF1?=
 =?utf-8?B?bHlKRkJhVlRIeHNiOTdOcDZRV2NIeGNkMW03M29qTmdRSEpsTzRpdUNBbFhS?=
 =?utf-8?B?M3hRN1drUmJ1NDVWb0tYZUsrYXB1OFk4STcraGpTVHY1a1UwZTh4WEtRdGtn?=
 =?utf-8?B?MmMwSmk3bmh0S3c1RHY5eUh0eDkzd0R6Z1lUMGNDNjFJMTJLZnJnMEo5Mk5R?=
 =?utf-8?B?TWp2WmhTaVlNYTZ6Y3B5MnNRU1ZPQmU5TkhQbVMzbWxCQjJNc2Y2MEhYS0s5?=
 =?utf-8?B?RnI2WEFWbnlsTlNMZDRRTjFMdng5ZVk4dnc1NHN6YWFqb0VabmJteGJsRVMy?=
 =?utf-8?B?TDRCS3hua1BJM1VkLzNiOTV0d0xCejUvWlIwN0dIVFY5Q0wraGtZWGFzb1Vi?=
 =?utf-8?B?WEJtakRIVkdpY0REaUdWYitHYm9uT01CbytvZWNrK2lxK3ozbWY3RXFjNmd3?=
 =?utf-8?B?RkNrRUVQWk9XTDNjL3B0WHM2QjlzV0ZIVEVTdWJNcm9VT01Lcm5yS1RnaGUy?=
 =?utf-8?B?TnlQWFY0eC9KQnlTam1BQ2kwc05Rb2ZzcDdsRlUxV0dSNis0MnNBSXQ2U29j?=
 =?utf-8?B?L3Vyd1NRVWhNbWNCeEJwS3Uzc0djR2FUY05FVlZDV0pwa0s5ZmtRclkyU1RT?=
 =?utf-8?B?L2prQXdjZkdsakZzc2x5aGF4a3VkN0ZWOFFDbHBrZUVLcDhycFVUK3JZWEFS?=
 =?utf-8?B?c3ZYMDVVZ3lqQUE1VUIzOUgyWlRoOVZwc1ZqSHplZVl6RFRiUERUNzlob3E4?=
 =?utf-8?B?UnYxbHNnQ1Awci9JY2hHeVFvTXVLNGNsRXNiblNiem5uSy95NitQVW1jdkFM?=
 =?utf-8?B?d0xBelpaK1NUV0lZeGhqQnU3RkZBc09SVFZYTFpsQ3NMYkVkRmNTNUprc00r?=
 =?utf-8?B?c0sxWUZyTW9TT1FHSmFUSi80eGFjRE8vbUxiUExUWUJ5WGNKcjl3R2VFUFhj?=
 =?utf-8?B?M1NjN3h5V3VOcUt2QUxJWGNRTm1JUVZha0wxcDlqbEdCQ0ZRdG12RU91eEhl?=
 =?utf-8?B?STVpR3ozV2NNd0kvaUtXYWUxaEtkOTNVQzIySjllWGYwYXc9PQ==?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: KdFltyvj4d8xz+5wnSOf0Tqse7ppK5tUthqXXSveCflEGFhhcbViQk74V2ivRsCr7wp/ajOslrPE6KOO7Bvq7S+5CoJRRN9it7TKzEnxiBUOmvXO6E+VWtUN+XffDHVczbszoqCPtlGy4i1fBDpeoU2Mfhs+n2X5TDKSIzOSQ8TyazHdQnzkde72nkQ0JHyoKfVpjRSn7FJYsKddx5W8yDjVAPuO2GjSpM7eN7et0iu8KHsiWj3jDYhmiEbZNOlIES8gdjKbcd8UV12DlM+OpS0yMKRrQ2PyLTfxykJ4lv8I3svfWjT0ZrYCoVzyB4TUtSlu4tiMw7+UKC1PKhZLLDPFrWz8qsa6ej39ITgnKsgBQAA3HoricYvkaxYtz8xcH1u4nZBmNAAYq0uH5KvNeX0ZQcn7KQng1uIUtyyvheg=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2019 12:43:52.6807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c69f522-c338-44f2-be76-08d690e7bedd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2653
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01. 02. 19 23:08, Jolly Shah wrote:
> The zynqmp power domain driver communicates the usage requirements
> for logical power domains / devices to the platform FW.
> FW is responsible for choosing appropriate power states,
> taking Linux' usage information into account.
> 
> v4:
>  - Added reviewed tag for dt bindings
>  - Remove local device list for each domain and use list maintained in core genpd structure
>  - Remove hardcoded pd-id to node ID mapping. Instead use argument passed in peripheral node as node ID. 
>    Firmware would validate node ID when APIs requested from genpd ops.
> 
> v3:
>  - Changed binding to have FW node as a power controller as suggested by Rob
>  - Updated FW driver to register it as mfd child devices from firmware probe
>  - Move bindings location as suggested
> 
> v2:
>  - Rebased on top of latest firmware driver patch series
>  - Updated driver name from zynqmp-genpd to zynqmp-power-controller
>  - Updated device tree bindings to move power controller node under firmware node
> 
> Jolly Shah (1):
>   drivers: soc: xilinx: Add ZynqMP power domain driver
> 
> Rajan Vaja (2):
>   dt-bindings: power: Add ZynqMP power domain bindings
>   firmware: xilinx: Add APIs to control node status/power
> 
>  .../bindings/power/xlnx,zynqmp-genpd.txt           |  34 +++
>  drivers/firmware/xilinx/Kconfig                    |   1 +
>  drivers/firmware/xilinx/zynqmp.c                   |  73 +++++
>  drivers/soc/xilinx/Kconfig                         |   9 +
>  drivers/soc/xilinx/Makefile                        |   1 +
>  drivers/soc/xilinx/zynqmp_pm_domains.c             | 321 +++++++++++++++++++++
>  include/dt-bindings/power/xlnx-zynqmp-power.h      |  39 +++
>  include/linux/firmware/xlnx-zynqmp.h               |  26 ++
>  8 files changed, 504 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
>  create mode 100644 drivers/soc/xilinx/zynqmp_pm_domains.c
>  create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h
> 

Applied.

Thanks,
Michal

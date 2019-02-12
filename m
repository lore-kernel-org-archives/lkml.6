Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96847C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD9A20823
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="wi9cXvGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbfBLMo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:44:27 -0500
Received: from mail-eopbgr800050.outbound.protection.outlook.com ([40.107.80.50]:65408
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728085AbfBLMo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:44:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCQPAxBXJFVX9oohkTE3+JsHSMYQgFhh/xeoP9qgQ4k=;
 b=wi9cXvGvpmEPxpm0PMCW3lELVMQbISkcTV4G9jRaxXKPWR+ma/eo9PNdzsBdJxEpISikjKerc3mX3jIqo916pwgvhEJrPZZfT9xX2E3RqJI9XmSsm4/SCnX+wlaQQClPnJNcRtQnA6AzKJ7DH7hDBV90PWqxy5DDwS1bNLS//nE=
Received: from DM6PR02CA0010.namprd02.prod.outlook.com (2603:10b6:5:1c::23) by
 DM6PR02MB5020.namprd02.prod.outlook.com (2603:10b6:5:52::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 12 Feb 2019 12:44:23 +0000
Received: from SN1NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by DM6PR02CA0010.outlook.office365.com
 (2603:10b6:5:1c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16 via Frontend
 Transport; Tue, 12 Feb 2019 12:44:23 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT013.mail.protection.outlook.com (10.152.72.98) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Tue, 12 Feb 2019 12:44:22 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:50647 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gtXQE-0007fa-CI; Tue, 12 Feb 2019 04:44:22 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gtXQ9-0008HY-8P; Tue, 12 Feb 2019 04:44:17 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1CCi7S6032543;
        Tue, 12 Feb 2019 04:44:07 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gtXPz-0008Dq-Cl; Tue, 12 Feb 2019 04:44:07 -0800
Subject: Re: [PATCH v6 0/3] drivers: soc: xilinx: Add support for ZynqMP PM
 driver
To:     Jolly Shah <jolly.shah@xilinx.com>, <matthias.bgg@gmail.com>,
        <andy.gross@linaro.org>, <shawnguo@kernel.org>,
        <geert+renesas@glider.be>, <bjorn.andersson@linaro.org>,
        <sean.wang@mediatek.com>, <m.szyprowski@samsung.com>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
References: <1548794301-30483-1-git-send-email-jollys@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <be838b02-1fc1-ae9b-9a7b-d63e11d7068e@xilinx.com>
Date:   Tue, 12 Feb 2019 13:44:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548794301-30483-1-git-send-email-jollys@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(2980300002)(189003)(199004)(2486003)(186003)(486006)(476003)(44832011)(126002)(76176011)(6666004)(65956001)(426003)(11346002)(26005)(77096007)(446003)(336012)(23676004)(478600001)(65806001)(966005)(2616005)(356004)(7416002)(4326008)(9786002)(64126003)(65826007)(229853002)(81156014)(6246003)(2201001)(63266004)(8676002)(230700001)(305945005)(106002)(107886003)(81166006)(36386004)(8936002)(110136005)(58126008)(31696002)(316002)(54906003)(6306002)(31686004)(47776003)(2906002)(50466002)(36756003)(106466001)(107986001)(921003)(2101003)(5001870100001)(1121003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5020;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT013;1:FMzUTMCOshQ6usJv7c+C5xKcsk/OAcl2ro3bUGEHF0ykkp9jaBaHAEwnbeI/R/Ic1d/6ZlW9n77WjVEHMPfh1ebLZ3Hp3E8jN6OGfjiIdBWK3oKAjV0ruqQgDrZSOZTcNxz/rH7tZbK5QPHcZacJRA==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43eead59-766a-4b29-93a8-08d690e7d0b7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM6PR02MB5020;
X-MS-TrafficTypeDiagnostic: DM6PR02MB5020:
X-MS-Exchange-PUrlCount: 1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5020;20:EIGAx7sieGTZnR2PiNnhKoUzc02kEENNBwtrwlmOa/+3H3n5ZQV+QUxrSJbQOX8SkmJpjjN2wamcCwn+6c9A4uiEfm+wVZ3sRpSABOpVJESHz2JVouLFbbHktw7cxx2sMpP77a9XnCZdYx+Nhr3+stIx2uA9W//rdPCNfxX4KnR4gaSFWh1uRaKrVdfRXGw1oqR9Jwn0Tj+E7C6MBVwiRrnvTa5NLd1pQO9g4qCyFE6yD88rpCqwbK/IWAVWs4+l7A0OCEiHrD9lRP1OwH2qaPEuMHcUELP/onhV/Eeix+IZrWFJq4L9uUw8BLI9IBbWBmeSr2s586W6a6oaGPiqdE5MIRPDGlU8XRzB7GCgAOiOWaj64X8INUNRU3DQ3HrJXuIk4bT0kh8OUbmEk4LIy2TyrwbDY4vNoUw7Z+CGVXzprwGagNoL5EHyqp44cZunWWaC4NiSrRZQBIimqzSGkvN9Hn37qh672BkFRDhIyAXJfhOE4OWCC08Vj1QYa/SS
X-Microsoft-Antispam-PRVS: <DM6PR02MB50202852C77A93EE26055AD0C6650@DM6PR02MB5020.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0946DC87A1
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAyTUI1MDIwOzIzOjNBZlRjanJka3ljSmxOZkwwblFhbUFCOEE5?=
 =?utf-8?B?RXJ1NDFHZEU3eHZEUFM1RlVneXF1KzJpWG1LUEZRZTRTcnNmVmlMMjJJczBW?=
 =?utf-8?B?VGt2NEVZbU5VQlc3MHRpSjBKYzlPZzlMK3BjbjNCOFg1SXBqdSswcnlTREVv?=
 =?utf-8?B?RHBSVEFsQ28vbCtOSXJIZTduZVF3TlRwOW5TREpTb0dPRWFUS0pSdzZjc0Vt?=
 =?utf-8?B?RU1Oc3U4YzM2WTVOV3cybjBkUE02YW1UTFZpMjZOZFUxeWJjSi9qblFxNER3?=
 =?utf-8?B?Wmg2T2drOGJkZ1lSYVk3SFRKb0FkR2EyQ2s5aDdjV1dPc1JXTzVGZzlDMm14?=
 =?utf-8?B?TTJ5N3lkWDBTSkRKTTk4TGRUQm5CTzNXb2IvckloVzJoZGdXa2dlWkJ5eGk2?=
 =?utf-8?B?TktPcnd1ejVyMitmRTE0ZlNYNUtqQ3JRNXB2VlVBRklCNStRd0FqVU9oMlV2?=
 =?utf-8?B?K3F0UXZOYlRnV2kwdXkvZFp2R3Nka2R3bmpKa1VITm45VVYxU0JOUHhuUk5p?=
 =?utf-8?B?NTE5UjlsS0djUFlWYU9NU09kcWZiR0pSL0tCTE5jTHF4dlczcHJQNG9qNnVW?=
 =?utf-8?B?T0ozdHMxd1M1cWRkUkJISjdOdFNOZURZNkxvVUN0TDN0cHZzS3JOTUkzYjJl?=
 =?utf-8?B?QU1WTDNndVoxMmVpY25rQmhUTmp0STVLZ1ViN2hCYVYxeWJzWGp5cnVDWTdQ?=
 =?utf-8?B?WEZRc2lJRFdzazdNVENGK05tbVZ2ajU1dC9qeVpnOXlRWnYvS3o5ZTA4d2dJ?=
 =?utf-8?B?MWpSV212bDBvMWJzQUtUMDc1bXNPRkVLUXR3d0w2cEdhR0NpbTQyZ25hcGRB?=
 =?utf-8?B?SWhyNEtrMFR4d3VZQlhuTVJBWFBzL2w4SXpxZFhBWmdEdWNmSmxsQ1NKaGRP?=
 =?utf-8?B?VTZJbGRDRlRCRlk0WUU4b3V3UFZZVnp0OEdmb3lXcTlvR0Q3elovMlhTc214?=
 =?utf-8?B?MFZQRjQ5Y3VmY0RhZFRUdVpXSks5d3RNMGkyakhuR040d2J3ckFoaElpSWZC?=
 =?utf-8?B?WEovY2hldjhQcGRoNXlaYmJUeTZLN2hjSG4xM0t0b3NwRDF3Y2w3bE1nQ3Bn?=
 =?utf-8?B?SVhWTEV1OTlUcWQyRmlodHBrQVlGdW40cEcwbytHd3M4S1h2TjlVbGt3TWJ1?=
 =?utf-8?B?V09JUCs4VkFpTkFyOXg2Z0NqVE1IK2xFUmQ2T1RBb0RUc0tvZXBleDljU0Rh?=
 =?utf-8?B?ZWNVOExWeTZwbGdqVXJxRitNVnIzUlVPK2tIeExzK2ZGYTZqWkU3eVhyWmJl?=
 =?utf-8?B?ZUxiVTVvKzUzQjBXckpHZkxSS0UwQzhPWnppYmRSWURRMllhRXFwQWE3R2VI?=
 =?utf-8?B?SWl2d3dUY1gvcitsSFVuYnVVWThwcHdQM29Lc3ZYbVBFZzhkemV2UDB2U2VH?=
 =?utf-8?B?b0FTaG1aNlBzUHRBYmpmbGE5Qm92SVR6Y09kNERBTWFvYnVCWWx4S2pGYi9K?=
 =?utf-8?B?cDBvbHhKZURBN1BZbERvKy9keW53eTJNcmV3Tys0ZThQbkVJc2FhV0ZKUjZZ?=
 =?utf-8?B?UkRxWjcyWFA4Z2F3L3A0V1RWcmRjdFZWU1UrdXZndjFPYU5oQ3o5cVZHZzR3?=
 =?utf-8?B?cnlKQkx3WnlzLzhsNzRKck90ekx1T2hsYnplY08zMm5qL2FBcStmcGo3dDhL?=
 =?utf-8?B?RGpqZStkU0svTGorVVJiV0JPQ2JYQ0NQN2gvL21jeGkxV0VCbWp2ckU1TjZH?=
 =?utf-8?B?amt2TnRhYzNOVjVVdG5yQmhTQnBoeTBMWCtzSllTeERQdEg5VlhRREYzNnB0?=
 =?utf-8?B?dEhvYnU5QjN6OFdFQTF5ckxaRXdCZmpZRTJpbW0wSHVOalhKZDZmT2JubUlz?=
 =?utf-8?B?U29TZHZTVjFIaEV5Yld3YXNmT0U2ZWlCMmhDSlRFczdRQUhtRkVmZnc0Q1JX?=
 =?utf-8?B?Qk0rRTJGS29YUGhzUyt6TlEzbURvb3p6ZFQwVTJYMi9BN2NqWmlUSG4xTmNt?=
 =?utf-8?B?RjZqRFlnOW5RPT0=?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 5j2Urmz/x34p/xbYGcQpLPTOYUeInyqC/VJftLsRWdPJnXpciomqMDrN9xjvPyGaZzexoC3VzRUldxDSlrz/jJ7K6CA+UHnlmbFiLh+J+S06JAyuSSpgacNLUsRtrcL0WFFwdKnj8H0AlK2Y7/aZz00JNBpoEyxHeDkUrrh/VS17CLN3HU27tC1YVL2LpocDJCgu+j+ZUyRSus7zSdNyIEKZ5udfhU5dgC49r3iAK09Bzglvb0ZF6QcXYIAy9uuCjI6rDCyI2ireM7XiXmlu8tWNU8hBGBqoFb5rstJ5GCtBcYKXL/VcSY/a4sLI76ngyGqVgbov1DB4oQWmDAWHPqvFieBSpbLn5DtJCVEIQOYuE7gwhLgkvnO8KRldEM+Xamq3/rB4FxQafvDUaPaQ25IRSCEp3mnY08DpJDEFCj4=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2019 12:44:22.8227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43eead59-766a-4b29-93a8-08d690e7d0b7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29. 01. 19 21:38, Jolly Shah wrote:
> Add ZynqMP PM driver. PM driver provides power management
> support for ZynqMP.
> 
> v6:
>  - Rebased on top of 
> 	https://github.com/Xilinx/linux-xlnx/commits/zynqmp/soc
> v5:
>  - Added Reviewed tag for dt bindings
> 
> v4:
>  - Minor fixes to address v3 review comments
>  
> v3:
>  - Updated DT bindings as per v2 review comments
>  
> v2:
>  - Rebased on top of latest firmware driver patch series
>  - Updated driver to use shared interrupt instead of mailbox
> 
> Jolly Shah (1):
>   firmware: xilinx: Implement ZynqMP power management APIs
> 
> Rajan Vaja (2):
>   dt-bindings: soc: Add ZynqMP PM bindings
>   drivers: soc: xilinx: Add ZynqMP PM driver
> 
>  .../bindings/power/reset/xlnx,zynqmp-power.txt     |  25 +++
>  drivers/firmware/xilinx/zynqmp.c                   |  29 ++++
>  drivers/soc/xilinx/Kconfig                         |  11 ++
>  drivers/soc/xilinx/Makefile                        |   1 +
>  drivers/soc/xilinx/zynqmp_power.c                  | 178 +++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h               |  20 +++
>  6 files changed, 264 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
>  create mode 100644 drivers/soc/xilinx/zynqmp_power.c
> 

Applied.

Thanks,
Michal

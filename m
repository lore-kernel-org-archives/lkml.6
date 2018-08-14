Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAC5C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E600221653
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="LbsP74Hk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E600221653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbeHOAeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 20:34:04 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:65096
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727776AbeHOAeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 20:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1z+/VGxWydgSTIEPlWtxiZFvG8F5uopX5ArkMpeiII=;
 b=LbsP74HkPNgOk8QmwyTSpN93fVDgXX0trFyj2yitPPtqmggfJk1hZwSR/eb/WLyIhRGg7EllHH83QVEA6zRBLlZNl+0WaWwOqfZtr7Zo/5bRDxT3EHpKuDziCYG5J02Uwzu4tO2U9VMjghxYyKy+/uqN7YURERTbKkHo6XSwHV0=
Received: from AM5PR06CA0004.eurprd06.prod.outlook.com (2603:10a6:206:2::17)
 by AM5PR0602MB3236.eurprd06.prod.outlook.com (2603:10a6:206:7::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.20; Tue, 14 Aug
 2018 21:44:49 +0000
Received: from HE1EUR02FT012.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::201) by AM5PR06CA0004.outlook.office365.com
 (2603:10a6:206:2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1038.19 via Frontend
 Transport; Tue, 14 Aug 2018 21:44:49 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 HE1EUR02FT012.mail.protection.outlook.com (10.152.10.75) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P256) id
 15.20.1059.14 via Frontend Transport; Tue, 14 Aug 2018 21:44:47 +0000
Received: from cernfe05.cern.ch (188.184.36.45) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 14 Aug
 2018 23:44:43 +0200
Received: from harkonnen.localnet (178.196.40.127) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 14 Aug
 2018 23:44:43 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Alan Tull <atull@kernel.org>
Reply-To: Federico Vaga <federico.vaga@cern.ch>
CC:     Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 0/8] fpga: Add managed create in FPGA API
Date:   Tue, 14 Aug 2018 23:44:44 +0200
Message-ID: <3975392.G1LtsYJEZq@harkonnen>
Organization: CERN
In-Reply-To: <20180814191526.3247-1-atull@kernel.org>
References: <20180814191526.3247-1-atull@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [178.196.40.127]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(2980300002)(438002)(199004)(189003)(966005)(86362001)(33716001)(50466002)(106466001)(478600001)(97756001)(6306002)(356003)(7636002)(7736002)(8676002)(305945005)(246002)(229853002)(9686003)(5660300001)(4326008)(8936002)(6916009)(230700001)(3846002)(9576002)(6246003)(23726003)(36916002)(106002)(14444005)(16526019)(186003)(6116002)(26005)(74482002)(44832011)(2906002)(486006)(53546011)(66066001)(446003)(11346002)(476003)(47776003)(316002)(426003)(336012)(126002)(3450700001)(956004)(33896004)(54906003)(43066004)(786003)(76176011)(46406003)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0602MB3236;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fe354ad-b0ab-4602-aeed-08d6022f2868
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:AM5PR0602MB3236;
X-MS-TrafficTypeDiagnostic: AM5PR0602MB3236:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0602MB3236;20:ehbKyvUZQLAM+cpyyUhlHk5aIOjLl3DHXX8JNtuX9b3nN0Ken+q1QkndbnQHChaNXkk1i2MEMJcYPBg+LuLDXndoUYgEp04Ki/WDAZlX30ytpD4wxvr3y1gWoYUXnamll0RxDd/yhgFY9L3CLTe5wLjGmwVpPuim+jivXO0nmgIKjPrez8eNXw83z2CNxWJ532aeH4Q1nQccXMatLPCCqv+qxSA8IO969mZe9JCxJk9dCSQbLonux3JZ2J8OCjivnW0sMbca2PHi9q5prF480b3oskk3zR8MnrTAcPjZqOv1yXsJcw+1WUKrn+DPCOUdGzzvHHrztzylGguWTjqhUAV9uRftauAf6f5q1R8m8jqC+hSN+LK3Uv7dXs3aYgIupCmOoJVH0b7S8EkgqXMcIN3E53GbNLR0SCBtAfE9elirO7cu/Z6ALA1Q0RwXKHrYPnGD9kz3Lgnob458hn9E48TgQIl0f4m7UrWGbDie+ChOjozZd4TDlwhIcOL0tSdR;4:eHXS6XHLtMS/j+HgAmm22epENIV26p+1//2eEHDV+Nq6XxTddy4BFt1ITijsRtqFap9kOZDA07TuzBT2lZubxZEpsZlEkhUGDCBklNGr3f1rRfyHbz2lv0LYpwXex5Z+VRcYoRwSTZONyf2JhJhC+YULZJD5OpPHGvzUZSiuuIoiC26O8jW20paHaI+9aeHv0PuSuY7ciWoOjI/3m7sOnRwHC8mQveV48kQbevpRnDIwXPobme4m7LF/hoq9xaUJ7xfFINPPPq9L6GK+ekAFZw==
X-Microsoft-Antispam-PRVS: <AM5PR0602MB32363AA09A0B1C145CBD1432EF380@AM5PR0602MB3236.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM5PR0602MB3236;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0602MB3236;
X-Forefront-PRVS: 0764C4A8CD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0602MB3236;23:4VWUKbKwTcDThnAQ2jabhDScZO//UvBq/BsgG46?=
 =?us-ascii?Q?n1UTH+iaSKo2kV1Seteh+1+/FsNA0YU/cfuw4Kmmj7X0M02/OUmyHfVW1FfG?=
 =?us-ascii?Q?0lq0aSw9znnvYAC0eldFtXOv7hFiHnIyJduA3Vnpf+o+9FwaPJDYv1Wti5OB?=
 =?us-ascii?Q?ISw1Ukf42EMYFvgGEEwtDGY+lFVHRbqNJE9ITtLAB2bHehe8L2P+4HjlhwXE?=
 =?us-ascii?Q?uj6rgYBh/jnFWj8v9yWHnbMXrJ2QlPgkER+Qfi8czvbIKc/PcgaBcOli3HWs?=
 =?us-ascii?Q?8SMdIheJwDiVJ3/EPx+L6zPxJ1FgHyCDR6M6oOGWrxsmypNsWLTafmG7X/t2?=
 =?us-ascii?Q?E0VMuc8W88zpUnRnvfoDUiBAPOMZo+unKS9b/NjrGnrE6Q0L9R7KtNjYRTFf?=
 =?us-ascii?Q?Vu6i2DIPOZJ4L2P2EbeiCYnpc7OItlkOdG9Fybsqn7XyWpAvy3Y/dj91jG+O?=
 =?us-ascii?Q?LnhXOaA5wsw2V/9dlN23CNip4bEDBPgYCodPiebEQA9qSbpDkPIvFLDP+akU?=
 =?us-ascii?Q?asPv2E542RH9PUHQoV6CEP9RBl1F9tvUO2VTJ676c0de32gbH0ALu/cZH87N?=
 =?us-ascii?Q?SK1dy/Jj2Pt3LMm5hQ5s3gLsilZv/VJxv03UeoKbId4X3rfpZrF9qjNDc69M?=
 =?us-ascii?Q?bcD9rLuCGcT17WutBzUeJ5ZPWuaFUgcToZKkTtJDkh8tbUHfQObl0fmB6qpX?=
 =?us-ascii?Q?NgKFy6ewkT3pT4DgFQxiGPkHu10ILeeKb07x1TgQ5aD0b7TK2yag/2+MO/iW?=
 =?us-ascii?Q?Kjw2ndAJm/v63Cnm/SOHrjTyAOnMTOtxe7iwNvytWKHsPUO/DuLgV/ZF6WOM?=
 =?us-ascii?Q?wqKQrGq1zkuvWdlz5kPamj2YG9DdRas8maMf40vGRhM36oNy0asCpELDpYGb?=
 =?us-ascii?Q?ZPgWTi1P4e3VaRVPe50M1dd2Q7IQaTvME2mYjVSBWfHx7K6gidPjjp7Mq/yf?=
 =?us-ascii?Q?QB+5TpKYiGOFiYyZOQf3lGU1MIhneg58cdYuAEZL8g1lWu2trA1qSAh5Wg1B?=
 =?us-ascii?Q?PeduKy3OAozjGf+s/tobpcnCYvEVATanN/7aW4CzUIrUcTHX3sqwuQQGTujy?=
 =?us-ascii?Q?HwnWcQayPaWaZEY+PFxWdEop+HHzNJHhvik6a9TsRQynB9O3yHlysiVyLGsq?=
 =?us-ascii?Q?AcAKv9a1+cV5GgJ3dBSK/+Eh915A5nXGmvtRnSzhSUiVBD9oALhljs4QLHLz?=
 =?us-ascii?Q?49WnxdmfJQuzWlGkv2+j9BW4H5LEOlzWiVlx/f0YjrDw9ywJH2/2XmrMehdo?=
 =?us-ascii?Q?umzSt9kqtHUoR78BM8YOrMCNgae6vwmlNWTrwNfzSDpbK3McAKjdjtYvsnRC?=
 =?us-ascii?Q?YkPHK1pYzvSHwSAJt2IIGyqo1wsteodbcafg/W3gG1P3XXN7SD5NrUzo/Zmb?=
 =?us-ascii?Q?Y7SVMFO2768RBadr7t2jb3XoeGCE=3D?=
X-Microsoft-Antispam-Message-Info: h0gvhVBuHZgoKW7PPYB2AwnaJ5IqR1y8Yr/ouUTpHEBp/AJWK1uTJ9Y8ayNJ4PMF2/FHpuLJz09GCXKJHeT7SQ60bYKt3ZU9qH+EiTLcBtHf9EOavGVkmDMl4N/6v07WvmXqucxeqQZmzxbWhetkFA4id2lxiCTwqksmDysNzj33JCAzxYuN96QM+iA/RyEvMm5KzRtyXImADlVkVey89aVnMK22XxJ1t1p4Ud/+BZXkjsdRyuUN2rqzyXi13il2QWs8kf0vBxTDl3T8jlRkmg898ZC2cXP8xjgL+7Sa3ZaGjTmo4kIEhgupAX4R15lNEXnsKXJbuIEE3dtbMGA/odBFlhgy6kiImvjkxVPaxJ0=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0602MB3236;6:nusSyzwCwSkj2fQ8rKUQCuoYuqFdHNbuE0RnjuKe93yln/XDCgMSCmisF0HeG0ng3UKCoO0UN0kaZ+XmIFWk5Fer2PjeXWbsmbsLohEqyQCkO+epWr+KgnPYcn4BO7zOEPI2xJ1JitMT9YXBMhsdeVLzAabRM/Q9PiESFsMQ7ok/xyydxJvqM+YeiV/MKcAZZniuYtJDG7664Ti8lBTKzD+MfW6ON5/xn0SlhJ1hNDBnKcNAVVW4m41keqb0BIGxHw485ds5bS5gwhIBYUYE9NEn+kFHdjk115+/vNZv2yqiF/FLnEAVMNkKV29z5XscN9q3/4T5wdpGXPJxvQexo77Iv2JebqT0FAV3Xal82t3hB957keuw3BcSrq52Wq5m/3M/t8iueLnfCIxNUeC1On8Km7UfOyurpsfVQ9D7Qa/FG+lmgThwz8KO6tOfM9Fv/629rUl6RlDUEyH7nChxFA==;5:JQ+cpaZ1FpBvhjTOM86axDevJhzdzBninSq67GfTkhUXph4sFwNnTIcKhJDRmtB7kGzHkdUuwy5ho0pXWC0wIbAhVV1VmAdw7cbAdEZvD3PGC235kOALZK72gKwLl3MU4ispHCFodZzEV1m0BjJfDkAjLNX50eMzFfB5ZNQ8z0c=;7:U8LK37Pp9SoanqZ4ixUlORxwoKppG1ze6fGfN6gUqIkCPwf9iquLT0Wo3UfHABSOxT/06fo/E/YfckvPiM8pgHbo1nlI5oPEimasV8k5SI+LuhAumJvG+vot2pogdVJT16zuGBSxmCpI0PDfte9SnuS9HCzkgUS5EFjZCQ5JHoPpzsT38UVb9WWhw1kR1gCifT5/UmxxuCLCOhFBUg53WseibkUczPSOGgIk4im/tZ+g7MzI5yOrlZ3ohfEw/rzq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 21:44:47.8546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe354ad-b0ab-4602-aeed-08d6022f2868
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0602MB3236
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

I think you forgot to add:

Suggested-by: Federico Vaga <federico.vaga@cern.ch>

on patches 2,3,4 which were suggested here

https://lkml.org/lkml/2018/7/26/145

and patch 8 here:

https://lkml.org/lkml/2018/7/18/959

On Tuesday, August 14, 2018 9:15:18 PM CEST Alan Tull wrote:
> Fix one functional FPGA bug.
> 
> Implement managed devm_fpga_(mgr|bridge|region)_create() functions.
> 
> More documentation cleanup to make the documentation more helpful
> and to emphasize the use of FPGA regions for FPGA programming.
> 
> Fix a few minor documentation corrections.
> 
> Alan Tull (8):
>   fpga: do not access region struct after fpga_region_unregister
>   fpga: mgr: add devm_fpga_mgr_create
>   fpga: bridge: add devm_fpga_bridge_create
>   fpga: add devm_fpga_region_create
>   dt-bindings: fpga: fix freeze controller compatible in region doc
>   fpga: bridge: fix obvious function documentation error
>   docs: fpga: document fpga manager flags
>   docs: fpga: document programming fpgas using regions
> 
>  .../devicetree/bindings/fpga/fpga-region.txt       |   4 +-
>  Documentation/driver-api/fpga/fpga-bridge.rst      |  37 ++-----
>  Documentation/driver-api/fpga/fpga-mgr.rst         | 121
> +++------------------ Documentation/driver-api/fpga/fpga-programming.rst
> | 103 ++++++++++++++++++ Documentation/driver-api/fpga/fpga-region.rst  
>    |  91 ++++++++-------- Documentation/driver-api/fpga/index.rst       
>     |   2 +
>  drivers/fpga/altera-cvp.c                          |   8 +-
>  drivers/fpga/altera-fpga2sdram.c                   |   8 +-
>  drivers/fpga/altera-freeze-bridge.c                |  13 +--
>  drivers/fpga/altera-hps2fpga.c                     |   7 +-
>  drivers/fpga/altera-pr-ip-core.c                   |   9 +-
>  drivers/fpga/altera-ps-spi.c                       |  11 +-
>  drivers/fpga/dfl-fme-br.c                          |  11 +-
>  drivers/fpga/dfl-fme-mgr.c                         |  11 +-
>  drivers/fpga/dfl-fme-region.c                      |  10 +-
>  drivers/fpga/dfl.c                                 |   6 +-
>  drivers/fpga/fpga-bridge.c                         |  74 +++++++++++--
>  drivers/fpga/fpga-mgr.c                            |  67 ++++++++++--
>  drivers/fpga/fpga-region.c                         |  68 ++++++++++--
>  drivers/fpga/ice40-spi.c                           |  10 +-
>  drivers/fpga/machxo2-spi.c                         |  11 +-
>  drivers/fpga/of-fpga-region.c                      |   9 +-
>  drivers/fpga/socfpga-a10.c                         |   5 +-
>  drivers/fpga/socfpga.c                             |  10 +-
>  drivers/fpga/ts73xx-fpga.c                         |  11 +-
>  drivers/fpga/xilinx-pr-decoupler.c                 |   4 +-
>  drivers/fpga/xilinx-spi.c                          |  12 +-
>  drivers/fpga/zynq-fpga.c                           |   5 +-
>  include/linux/fpga/fpga-bridge.h                   |   4 +
>  include/linux/fpga/fpga-mgr.h                      |  22 +++-
>  include/linux/fpga/fpga-region.h                   |   4 +
>  31 files changed, 437 insertions(+), 331 deletions(-)
>  create mode 100644 Documentation/driver-api/fpga/fpga-programming.rst


-- 
Federico Vaga
[BE-CO-HT]



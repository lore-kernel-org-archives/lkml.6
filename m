Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE82C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66AB52077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Nd93WaaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AB52077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbeHaRf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:35:59 -0400
Received: from mail-eopbgr680064.outbound.protection.outlook.com ([40.107.68.64]:29056
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727398AbeHaRf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMxgXdpaNgAtH53DtPuEZr/rZOAcaWNlw0OvpH0MhTY=;
 b=Nd93WaaTcdStHJ+oOb+Or3nb+wunFy4+/j5enCYULWluhHRJXc+u3dnpC8qH4iPyDNlSYYgJlKUOnIfstzVFgJScGOSi/xseuZ642Gs+ZlQv6FacICeaaVwQyZgycnUU7+Vyp4XplCz4KjIQy/w18koueYdnqRCqgd9OcnjPxgY=
Received: from BN6PR02CA0089.namprd02.prod.outlook.com (2603:10b6:405:60::30)
 by DM5PR02MB2682.namprd02.prod.outlook.com (2603:10b6:3:106::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Fri, 31 Aug
 2018 13:28:24 +0000
Received: from SN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BN6PR02CA0089.outlook.office365.com
 (2603:10b6:405:60::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.13 via Frontend
 Transport; Fri, 31 Aug 2018 13:28:23 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT029.mail.protection.outlook.com (10.152.72.110) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Fri, 31 Aug 2018 13:28:23 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:53314 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fvjTK-000407-R5; Fri, 31 Aug 2018 06:28:22 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fvjTF-0000Ak-NO; Fri, 31 Aug 2018 06:28:17 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7VDS9Kk024492;
        Fri, 31 Aug 2018 06:28:09 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1fvjT7-00008w-0D; Fri, 31 Aug 2018 06:28:09 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 25EE91214F0; Fri, 31 Aug 2018 18:58:08 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <leoyang.li@nxp.com>,
        <amit.kucheria@linaro.org>, <olof@lixom.net>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v5 4/4] arm64: zynqmp: Add DDRC node
Date:   Fri, 31 Aug 2018 18:57:50 +0530
Message-ID: <1535722070-10394-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
References: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(396003)(2980300002)(438002)(199004)(189003)(356003)(7416002)(6666003)(50466002)(478600001)(48376002)(72206003)(36386004)(5660300001)(81166006)(8676002)(81156014)(2906002)(305945005)(106466001)(63266004)(2201001)(36756003)(575784001)(52956003)(54906003)(110136005)(316002)(42186006)(26005)(106002)(16586007)(336012)(76176011)(6346003)(51416003)(47776003)(6266002)(8936002)(50226002)(14444005)(44832011)(446003)(2616005)(126002)(426003)(476003)(486006)(4326008)(11346002)(103686004)(90966002)(186003)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2682;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT029;1:5j7kTCD6U/y0XXwczxmEDNe7KUDd8cc2mf/7N1t3g5h2IOkVOlHWcG+0Pr8JTC/Hjk1is+asd40U2Ign55VQZiWZRWeAexQvhXBsxLTN/Yv9F4zgEEK3cPvwZqSmioIz
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 881881c5-e312-4d62-9e39-08d60f45a05d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR02MB2682;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2682;3:ZkRakUzpHvyUkMBsoZtEW3CjNPvKASI97nJU1tpEd26u76mP1VCRUDTz3DzmjcNXfopRUFiBoUQYspzNf8M80aGbO5PdadVCm7/niP/FN7tyYctMzP9Wm3sh2aH+IGh0QO5ZzKeT0SMWgPzTIVZELIDnQX3aIFT6s17ZV9+4L3srkTtQOMX2QUYjorewa0KuARhy75V2WbzhEZqWgf96795zZ1wXT+WvSva/siMZocSkO33wQfTPyaQZGqhpPcSspvmsZHxJ8yKWdKNSw280RtBnXHxYAD6MWyr8O/fx/zqtL2xRgeujGQlaiKWTI1Eg74B+EF0Z3ZG1WW91nSdYMKcfEc2zU+QmAHJsP4zHDHs=;25:NXdknGL4p2JZ4pQLvwBDakH7iPp4Vrss+lzHlOQvCdxN45xbf0TE9AGgOU47R66HwdRRLs142LLdz8kxlQlzbCa1XkVYH8CVrtrnsGUAjDgfnb/KLWkZqf8PUcpAzuA0V9z2Cg2GN0KIKdRsWyLgDvNN50Dr2DJaL2NbUDwrj0YyDldfFuTGgOP5LEUuUsIn4uPMEporxpnlJiPPZPOs5tfLr8Iap32Bs5QKfzHrv5H4c76jM3fClRhBSOABjvcfGTwXcX3MY4ibPcIus+bEvDcfbS6UgnpzF+pt1or1KVqtpFQ6o2ib+mEvTSc8yEV5F/Cjz2NnQXoOxYpy/Pykpg==
X-MS-TrafficTypeDiagnostic: DM5PR02MB2682:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2682;31:tJeuVAELXpkWBY4mkn5VxcHeqXRz6GCBR4AH7JwDvXd+p7p+Q2abML77XTNAEVAxY8AE0Gq7JxXg3C9RE9/EG9N1uWAtj69HBJKhbfevWHh1kVvLD4wEn03yEgthFMX5rTuZ2audmmKhPQm3v8TykOw+b6lMF2Qzo/M0IgEx+GlpxxgO9xntURCY03+qwPADhLsy+4VrxKkkTnalpIN5lnTS+W+5Tgg9RRgDmZZrCZQ=;20:V7+N/Iox8aZU9b+SNRewT+kyfloB47TRmhXdIo+0CIrxE8EDpKu3uCBqoNLKy6j8SKZyGDeFgqU3zjzQngVCkVQwQ7q5/tenC3iTP689+GHLhZLjy0IlXQ9Y9uJ42+aU72t91YFbqsvnJFfSxFup2tFOELhE8Xy8Ios7ejn3SjktN5KhfmlcX9upyCpR0II1eC5jn+MdFd5tq7wISThCdPuXH6ExFNdFaEMaMe/Pb2XJQK7N1ZjjcvGOUonw7V4D7bchum7Amc2kt81n1deBEPWLpaccrYFw6N0X+OewIQ6Tq5nrSOXqOPGkoc0CBF5X9mJQxZJNJe3PSnuSA0t3IRRe8TEWVgv1dSKiBZg6VT/+QsH9d1Cdhmx9m+d76lT4fY5BEJTL45SkxVcNX0PtIopuPO1l63CBC7oWEHoYJuhKtkaebQhYXv19ctB+UyTx67quN4UznXs0KuKSZeQkNNKvBzfNlpT5cCW8VIZ2lhnAIM1PmJsrvBRbfh6LM1sa
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB2682C76C9C28148EF4F91864C10F0@DM5PR02MB2682.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:DM5PR02MB2682;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB2682;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2682;4:OImku8b30tVm6//PlMorZKA+jQVr6tR+BCEs/DJIVGXASCGdntcZW8NTYHg3QiMWwZJA8s3lKzfcupG/XdspZjG1RkeJzeC220vH+wlS8pLRPSQjIsVGqp6U6iDpE13Qim3ASvDsRBEgnbK0YflUOqMnDJ1Ra7Tl8uuNYHTUama5cLqpyf5j2owAePGYaZlLYJSltL0Q1LNb4T2qPy3CtFfyUWf66l9qXFNd98MZJgMv50CE3xYgONgwCX/Hnkzu93yawFVR8n7u9vS9atapZtvmYRHuYksY1IJDobkOoCNAN+xXyfW4XcA9qDgPndmW
X-Forefront-PRVS: 07817FCC2D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR02MB2682;23:yOU/yVCyxvvlX1Wq/1g28+GYFW/kaovR9uoaglZaP?=
 =?us-ascii?Q?GUMFwLxgH9oxGWFaV/F3YwXzdwcduttC69XTyDpZwvFQjltt+jzN6L6y0WbV?=
 =?us-ascii?Q?PGUzAAo4omzMoDMNGYXCRxWPRJMxS51kqwhqqs3cRmYZEMcAhmZ4iTQqKpac?=
 =?us-ascii?Q?4bsp5hgm5uUknFPTE9hQbM/7PYHMScv8soEG/g9XcknyhdCpBL17g+zpEwCz?=
 =?us-ascii?Q?oOr/MeKOZlASQJNgRVHAJa/MkIdBNfQq+6CJieNpKS7ca79HOuxjIAz/IOa2?=
 =?us-ascii?Q?anXV0BgN/liU5nZh8jM+G6QUv3i6qzVWyq+fSOdjNRo2ozlLlHIAUJCeS0/i?=
 =?us-ascii?Q?TbhOajpqdvvqtMQrWTxFCcSX8FiK32xj0pXj81KGCFWSCAn4zB8CY/tEQFhu?=
 =?us-ascii?Q?IaBNbIh7c45auUwObTBKeSfu99m1WQ3em+Pn/7k6DdvYrEFYcxzsxRY8tCie?=
 =?us-ascii?Q?Y5im8ZxNuhXkjvPnnTw+MpMHWg7BF/u5akqoOz/1r46C+M1CY7DMqoJkrU/n?=
 =?us-ascii?Q?aadBNnN197dvk16BxkW7+DMMBd8GshJ2gCGin5OFcKrZskQGPdZ3kJhoJihT?=
 =?us-ascii?Q?Flds9E6L943o8DmfdtV5MWfLbeQVXKi2a1f7J+9JDXXuuK0g81S5B0lN+lFt?=
 =?us-ascii?Q?RNs69y5ZUUEy/UF9AUFXPt3IFC2tfTmnvtntHSf8/0kXxkyKDdQIG4s/TgYM?=
 =?us-ascii?Q?krU8D+YJG24MSFvRuv+HELTgj0LJ0TDdUu1VTGR6Q5F+WH0i3Axuq7n4M/Z/?=
 =?us-ascii?Q?64soay56+OAJuucTk3QR490eILtZL8SR1qdPPwzDFuSYOwZ1UI97PxIAM4SD?=
 =?us-ascii?Q?kigbxfNPxDipM7c9+de/BtNjPH2OCSZW7UUD8uRson5d6Dg5IrOces6jVCsz?=
 =?us-ascii?Q?e9JKDgP0d2hSWopvseXUZ5VhlWDFVEB00RNUT0h4gjwv0avqyv1cODzpU+18?=
 =?us-ascii?Q?RvPU96zxkZDOLhc+CmMdOpFKecdvCbPFHcPpAQdTdeL2VH9PSy+DT7az7Grw?=
 =?us-ascii?Q?dGvYNJQGjX2vfTlpF3mVxKppAh3+d7xR4egdPTdNjtjhT5bbBhQi7bMdfM2i?=
 =?us-ascii?Q?Xsjm4nE506fS5wWeExXq/M/u7horpsJBIPn1/UqyhDj6aMHAOCRvy7B1JgxH?=
 =?us-ascii?Q?z/MbTAU7r9n4qUB9R1qpfgM8kGziQS1b9+Mgbv4nsOKGzLjZSmQFTLpx0aZz?=
 =?us-ascii?Q?q+hRJ4rs/CT76NBuw3XC1Lazs/MdTdRDaRlqrJsXxmXrfizQgvWm2VA8yqBU?=
 =?us-ascii?Q?or06ahpdybLI52DxFlr8/Tqd+cjsb7v0cEOFPOIJojWNt4+IbUXWXjuNwwXx?=
 =?us-ascii?Q?uFD8XAgPE07lqvwxxv6KRA=3D?=
X-Microsoft-Antispam-Message-Info: p5OXq0YmmHZg/9iQ8JrT/5UpNoKK4XI44Dqpua8LhhqZyGoccQ7yN65x5h9Sj3MNfSxqvZH8vae7O2w84bWx+XjviNu+WGVceXn+LvzS3RijDgR+SelwFQgGW4ViQXLTsbvcMg0/D4kTpsFxKuBkJQ+CHqVGCceD/mWA/F/GBrbjAb1w/B5dN5YbJemyP+pIxuZrO/Nyw1qAhqbb8HVjjgnq7nLE4kJDEvUDX7+MA6Fg/NJ8zuH4Vq6cdbkO/mzWIWYv7aiXFPxC3+ZYx/HS7y2cLzKhJA48f9auCuhGi8K4geVy8OFmIVEhhp16ve/hsjZ2Nc6uMnkC4zswzLQPNR+t85ZuYQrTIbRsur70dH0=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2682;6:cQQIbgaIcSnJQbuc6hU/mZSMREnqy65IEBVlDnZLC7wJv2VvSPStdNiDJ84jwxAKlBTJjeDDX3fsY3By3VA70FPUG7HZ7G59NN5ZFdKnR1a6yPOiZhTbe6qSb/8D6GwK/aDSI13jYROiqXQMQ/a5+JpKodiOlOyoRBFLhtFxMKLf+SQ2HWE40uI8xTtaaHTmRrE4Sr9lQltqo4QFtRuWp+Kt/5CtScaogIb6bfNOjCHNOrPPGAlxkcnYgpQM8OaNiSsTupjLe3Iw2UECIw+qaLYRbLl4Dyw5dS4jDOqdN4qWi1IZBcc2YaFTS6iyAyLP1f/vA22RERBW3A3tWriZ+U6cCleolPD2ehzPYny3tbn99vNLDwBCZYMztd6a87nK1m/js5mBRrmZMuKW6V84WhcIHuF4/F+BzC3SMulDQVQWDkeajokKTBZItAvPR30S0qcQCwZWGCpOTYfE+ZSkTA==;5:uunTN7LzeDITZTQa14vuPlWXMe+qpdR8rbV55m1IJEr4OAEzoUptEOq4YBppiq+I9Z1Dfpp0TiWmRpUk8ZItJwzlUwtNLR4B/6fNSBcjhFojv8PpdAhwn7Km+gB9iZlai00N0w0GbtDX5WFXCk1d0d6WqtYccEpdzVAjlFbroCM=;7:WYHggQ6oz4S62WlcLWLfrxgLkn0sJ/2xIFjNPzmldkv8gveVTZnoRUmFyWB6dytGTsGdEopM7TAiPMO6aMvrmgmwUXNVgzD+5D8iA4JQQFhjL0t3jHI4KxYi4Uv9wBHYpgWsNkFMq6+tsM8mOCdy3HISfQmx79+IoaTqan9HtUkSsXAYTOl5mc0kXZA4gTiazuuXoha60Fr0rwUNxi+o0H7+M5BMyuooEfSfr48ZxM3JlZUMO4fuzXxO9DxwCkfa
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 13:28:23.2778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 881881c5-e312-4d62-9e39-08d60f45a05d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ddrc memory controller node in dts. The size mentioned in dts is
0x30000, because we need to access DDR_QOS INTR registers located at
0xFD090208 from this driver.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 29ce234..a81d3b16 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -355,6 +355,13 @@
 			xlnx,bus-width = <64>;
 		};
 
+		mc: memory-controller@fd070000 {
+			compatible = "xlnx,zynqmp-ddrc-2.40a";
+			reg = <0x0 0xfd070000 0x0 0x30000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 112 4>;
+		};
+
 		gem0: ethernet@ff0b0000 {
 			compatible = "cdns,zynqmp-gem", "cdns,gem";
 			status = "disabled";
-- 
2.1.1


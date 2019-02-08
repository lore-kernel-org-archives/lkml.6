Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A685EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE9520844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="dR9WeNoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfBHQMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:12:40 -0500
Received: from mail-eopbgr140047.outbound.protection.outlook.com ([40.107.14.47]:46563
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726869AbfBHQMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fh6p7sfgKC/dvdyvAr09G5FFa2wqPNo8MJk8baijmMA=;
 b=dR9WeNoq3N7vMYnzteI1j9IYbCm30KWu8ZFUxop8zCfpvLHxD0wvuEDEzSd8ZjYyTyF3amQhzD5xeGVuCkXzCWpE2h3dF1+H0b1IX5IAVQGwGLlq2CzXfo1855IdoH+GLiJv4YaQAhigZFGL5HNie6p0vH1ZsFBwdKsEtgRg8nA=
Received: from AM5PR06CA0019.eurprd06.prod.outlook.com (2603:10a6:206:2::32)
 by AM5PR0601MB2257.eurprd06.prod.outlook.com (2603:10a6:203:6f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.21; Fri, 8 Feb
 2019 16:12:33 +0000
Received: from VE1EUR02FT005.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::203) by AM5PR06CA0019.outlook.office365.com
 (2603:10a6:206:2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.19 via Frontend
 Transport; Fri, 8 Feb 2019 16:12:33 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 VE1EUR02FT005.mail.protection.outlook.com (10.152.12.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Fri, 8 Feb 2019 16:12:33 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 8 Feb
 2019 17:12:22 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 8 Feb
 2019 17:12:23 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v3 4/5] i2c:ocores: add SPDX tag
Date:   Fri, 8 Feb 2019 17:12:00 +0100
Message-ID: <20190208161201.7860-5-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190208161201.7860-1-federico.vaga@cern.ch>
References: <20190208161201.7860-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(136003)(2980300002)(199004)(189003)(2906002)(66066001)(7636002)(7696005)(305945005)(16526019)(6116002)(3846002)(7736002)(486006)(47776003)(126002)(186003)(426003)(86362001)(54906003)(8676002)(106002)(246002)(8936002)(446003)(76176011)(476003)(11346002)(44832011)(2616005)(956004)(36756003)(51416003)(356004)(6666004)(16586007)(110136005)(336012)(74482002)(106466001)(50226002)(4326008)(478600001)(4744005)(316002)(1076003)(786003)(26005)(6306002)(53416004)(107886003)(50466002)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0601MB2257;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 880f0c39-cf6c-40e6-4908-08d68de03be5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:AM5PR0601MB2257;
X-MS-TrafficTypeDiagnostic: AM5PR0601MB2257:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0601MB2257;20:j0bynsLV6nzaMFjxQC/lGOUvFZUvFMIlAg7UP1XuT2hT3od8FhnHkNTsGA7GgKyyG7pnl0IARGBPauD7XpcjZ9Xi7vh5S9HWUkj5T5oFyUma3G3gvn1op2qu+Ep+LXvzW5rOiAbivER+AUbEzrUFSbRnMvMLNvlqzc2g5bi4Nt2UoiapGM8WJvYO8GY7zTXg99BKAPWSYoeY5UsulZxZ26B59Xke7yOByWYr3hGMQlhzIt5PgOHiDu4zk0bXwIUVy1Rjn5cjxOfQXgmTiGllg0QX7L9LHPjw9Xcg/mYO/4jtxy+ZU872dyEdCCa3FH++VCVmr+2UE0SC1A/Bg6/RMcyYHsbCjr3mBXt6jSBKdC8qmrtlZDmFbViuEe+Fl4I3KLjcdEwOXYZT9IsbPFb8s+K6nb4L3RMOpTXibLGeavxmWTh4SEUViAZH7mRkqyUNIyN6qJ269xdyA2+MyRS9i1txMAFo/5bRH9wYTV4AfdRbWLhHotcVFk9kfqH/aT5F;4:KWYAeleW0k/1bITr1DejmzuLAJbbgouuZxHFfIcnaDY7k+mkMrVu3JXCA4ig2OXsjTwynnpJ4eSHwMPCnPm4XqFIEyod0Kp88lxUXyoOXgg8T3kmjxORCn2ERDn8whoE3SkGZgQ1HA0+39L4ZUGqmKh8h6yo91UaWvTISCGiNMowgkc2Z6ndHLshCj4K8wVlB6tqGt+jEDOvXb3z1MPW1zg/zo3i5AwwfDkJbnov2sKb3c9FzJAymeD2D1N4hJQBMZMVTSiWGWzGumpUPm46BYxuwo4uCgi7YfqbNlJ8OCWeoKC0kvpIPq8+wz++4Osv
X-Microsoft-Antispam-PRVS: <AM5PR0601MB22576A47BC550B9A92E3B404EF690@AM5PR0601MB2257.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 094213BFEA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0601MB2257;23:bSHXhv1AV5ZNCiQc+7AU5WahFJ/UI5bExFfEK6E?=
 =?us-ascii?Q?MsG8vBmSFDeXMFhU/X3nAWRpiKt3cc6h1JHBe1r759vxNPV8k1Asi70O/AJm?=
 =?us-ascii?Q?un2sbk/4ZvYgSaDCxtXdAvhYT7QOeocwD+fGSPFuv5SI9a5Ndj0ugoCRkYFv?=
 =?us-ascii?Q?dj1JhXc04fnWFhhIZPqiO96GWZgs91aX1/p1Y4xcumm5BUwLsQgsvNV3Cqpc?=
 =?us-ascii?Q?XNTidTOZmiRMX59ZdTaF0jg1jK0WYBPUQ0MIZPgj0ObbmD/mB4Pwj0/kSqNg?=
 =?us-ascii?Q?fNdbLqS6w8xAGDlM2VoeRdNNpU+RnN/Q/OLxrDNMDE/js2ZW6Wk+bEZ32pdA?=
 =?us-ascii?Q?Nzwnhl/VBtZSsX1YJM4tCwU6Bu1ROtfdbFsoYHz9FfVwXwfyklKFt2pfudfc?=
 =?us-ascii?Q?/6B63BK0ymfjeMVw1HlQnYKVKecf1aES1IZDUKTcSCIQUnORjw4dFzLSPWG7?=
 =?us-ascii?Q?29tFUp+xQRn/cBWvYIpzjP3mtezzxTHO8CRB4J9vR9T2hBRjm0bZkypOcE4H?=
 =?us-ascii?Q?w3l1HqjBOdCUpy2+kN880jRR9UVj0M0hoXXSy/8HS+JdAbf67ZANqiAN6vw5?=
 =?us-ascii?Q?Sase/AOAFiHp/q6/ElS8vHOY24AmYs293o4B6xT40hadIHihcmhHQdsteMmL?=
 =?us-ascii?Q?JP/KlktRLwVTpaMwN+FhL6RIRPsZk8GOcsRiibNsWLMMJcdRy2F4aEmy6ZE9?=
 =?us-ascii?Q?0mCGjdFr790UrL5ZTftb+jwfpsWp7MypEvBTa0JWVymjszxIz4rNzz86xdGv?=
 =?us-ascii?Q?oNF+ao0gt32pue47ejohclaoOGiwfny47LREABqZk82j7li1+0dxZRZH+Bvb?=
 =?us-ascii?Q?dod4v9dbin9HBq6402bhT+qx+m2GWtja457K8xC0xXle7Cpvx03SN2uu2ehG?=
 =?us-ascii?Q?FbYZ4mKL7X83jxnBAZNJeOeUsyUk/hcfd4j1SfbXt4h7kasT0PWGV4/ic/ul?=
 =?us-ascii?Q?XxV/ZJwcEcE2DKRFLBbs3htrYkQzfTUpxehHPeGofcwovkvBry4nFqXtdGwa?=
 =?us-ascii?Q?TENhzAasraWm7WIy6jg3mdwURj1QdxIr05Vs2PAKk1rlicetyDtSBa+m2eok?=
 =?us-ascii?Q?b6l+eOne/bH3dCCKaq3Q5+VB/7iSBoJpl9l+1ZLZkW8GiEzkI1EE0Lkz7gx6?=
 =?us-ascii?Q?mvIsCfswWeMKW6eHpEP07E6M6M+QGaHi5j8S6wj3B8EMMSbxEVSF7x9N1Yld?=
 =?us-ascii?Q?q/g5Pto94urJqpg49EKEoQ8AWd8HYzE+XAp2a7MgyzBYYn/kegtKy6KZSuw?=
 =?us-ascii?Q?=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: AI/bOSBUMnMxBiHhgaXV4FES0AA4LXGv8yWBdiT2hGdwnLDsgDtvR5uz9qGUVZZgadNWRDPMPCS+ivPaWYdyBXntyc7c7QTmx1L32RzDRtiQA/cT0IpqBQmoV6HetGdkg94jpCWm9xyNFzIdtgXnc4ZRmQ18qcXQvaUaDIjWNlcn6ZiNzlugLOLx1n4sq5P3ew6EsRgmKRonpFweEUcYZe6pkeHElWI9sY4PZAgcUZy+dd7JuG6TzXr25hjc8UshujKOeMdJidUijLb5uFEpUX2rrTaNWkQo5aWYovHnmSTDsKwTvBzciPtwbQQayGy9NluVaz2o/X95SmOhjZXeLbCCVKNdnEkY3FoZHp2CApgJZnZwnFMa4N51t2g5TTHzkCMj2kBxiVCEYG4S5I37kqn/1ijsSvKMsVpBOX3nj+8=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0601MB2257;6:LjgawFteH+XCdw1jioUOyACTjj+lZ6IyBIPh9z+eKXRx3n6mohb21ezLzcLOhDhV0kMhLtnzAEU9ORR9lEdSf0XGS5xFsLQmEnN9uUznoUg8Xk6PbyDoiVyt1WKtjm1KkVCCOtOdPrFDCl6NZUZbWphlO6J3tZHuKTIWJI+NyoZd8z7U/OxI8+i8lCdEKiIO0Q8tIHhU+dz1EfQq6P7Sg3npddGq8pWcTKj/YqMXA5j3P2sYIAGMthbXANo2iXnoI8fRympoOk+3coRzgmoDnEUPNjNfTXdJ3YyaDZsmfm0ONdkyOQK0KpMzCpnRijZMJJ9NRju1sSZVnelZ5c06hsmHBQjDZ/3U5cD19BB2I5uDnTzf65/Us33W8e6xvPTXn1Ys73kwNmaEyeGAPSEs5C/h29HWFtyOvbwmW8u0M67nzLfig2IM9iJKg6xrhOqoUpfbZSq+YaBAaasShS96pQ==;5:8opFuwxWwY4MJA/0rXVPVn7TFwsrg2MhRf5U9o3qVDGYFdhtFZu0GgL7a4kgFcUEP8oLObY6pTqvnRSglB5Du+ESpZdHq+NCj+X5p0Xi/WcdfZW83+mpgvLv0+Tcmm5y0Nd3smi0BmGTsO71fkO5ZlZNlzJTEfgFhFYmfaurUMI+JH1DmRPXO7QlFOeahpOd8sx9y4NDnhpo+MhwNsEl+g==;7:qKVed+S2xWQTYVIalMxdZWq4Iz3cyLRijRt70nE4opZ9nquFPwZybNgRtS05+8xKQ+X2dMed346SbUceE63uSfJbmk2WO7awFQdwUT3fb85ZJHZndWmwz3cV/W3KHFdV0FS3WPqx6QXIXTgoIJNwwQ==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2019 16:12:33.3894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 880f0c39-cf6c-40e6-4908-08d68de03be5
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0601MB2257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds the SPDX tag and it removes the old text about the GPLv2.

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index bbe3e96..5b80190 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * i2c-ocores.c: I2C bus driver for OpenCores I2C controller
  * (https://opencores.org/project/i2c/overview)
@@ -7,9 +8,8 @@
  * Support for the GRLIB port of the controller by
  * Andreas Larsson <andreas@gaisler.com>
  *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
+ * This program is licensed "as is" without any warranty of any kind,
+ * whether express or implied.
  */
 
 #include <linux/clk.h>
-- 
2.15.0


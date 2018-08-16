Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BBEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB45D214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IU+ZwKhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB45D214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389142AbeHPKDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:03:30 -0400
Received: from mail-eopbgr690050.outbound.protection.outlook.com ([40.107.69.50]:17152
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389122AbeHPKD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZp7WUNm4zqCk8btYnfKJfdwp1W27f8Whr6aEPBE93I=;
 b=IU+ZwKhi3xXhzybG8IwHU92tLYm7HpiOD1esAqtU6oBFSsGFmhnRm1szIyndqm8HU8zdQxvGleOmw60wbLC0dwHdOggRU89kqc77SFDl6l+fql7QZPVHFNcBrhdNMplcnWkP+xceBQwzxjN6b2GD7Q3mVIIEjGe3uSU/QIJvckg=
Received: from SN6PR02CA0022.namprd02.prod.outlook.com (2603:10b6:805:a2::35)
 by MWHPR0201MB3514.namprd02.prod.outlook.com (2603:10b6:301:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.20; Thu, 16 Aug
 2018 07:07:03 +0000
Received: from CY1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by SN6PR02CA0022.outlook.office365.com
 (2603:10b6:805:a2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.20 via Frontend
 Transport; Thu, 16 Aug 2018 07:07:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT061.mail.protection.outlook.com (10.152.75.30) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Thu, 16 Aug 2018 07:07:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1fqCN3-0007uI-JH; Thu, 16 Aug 2018 00:07:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1fqCMy-0000y9-Dl; Thu, 16 Aug 2018 00:06:56 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7G76lqE028381;
        Thu, 16 Aug 2018 00:06:47 -0700
Received: from [172.19.2.167] (helo=xsjjliang50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jliang@xilinx.com>)
        id 1fqCMp-0000pj-98; Thu, 16 Aug 2018 00:06:47 -0700
From:   Wendy Liang <wendy.liang@xilinx.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <rajan.vaja@xilinx.com>,
        <jollys@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wendy Liang <jliang@xilinx.com>
Subject: [PATCH 5/7] firmware: xlnx-zynqmp: Add shutdown/wakeup request
Date:   Thu, 16 Aug 2018 00:06:28 -0700
Message-ID: <1534403190-28523-6-git-send-email-jliang@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
References: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(356003)(50466002)(4326008)(36756003)(316002)(54906003)(76176011)(305945005)(36386004)(51416003)(110136005)(16586007)(11346002)(44832011)(14444005)(426003)(446003)(2616005)(126002)(186003)(486006)(336012)(48376002)(47776003)(6636002)(26005)(107886003)(6666003)(476003)(77096007)(2201001)(8676002)(81156014)(81166006)(106466001)(2906002)(478600001)(8936002)(50226002)(63266004)(7696005)(9786002)(106002)(5660300001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3514;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT061;1:TlTFj4xdVzoLGzmYsmTfrdMQZKK+uzw+7MVlSkm832bpyk3BPM7NmWTzfQTno9OgiJG3HTMb4DjeRGfYl9RbTMKpMfGC5QGkazakaWpi+jdBcEpEsFwRcDE9wvsZw8uR
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e7c68f0-e0cd-4cd6-dd9c-08d60346dded
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR0201MB3514;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;3:NuOjHiC0bcfM/TTcGmzGcEnK/hhpuisGe2BW6E/WgMKXzRb1XYjJAMUsqT7uzNlmS5e1RbpbxFFMS5LouvlcP3NKuYZkyastzRMfB6r26Ahq7y9Zf0g8ekstkBv3Utns95PJ0RYaeB/nmygMzx/wRaaCyC+wr1GBzfoeDQ0Nc4xgLhIiZFkWnvubR+SJwxBwuQruXRKnL4GTaVpWeouGntTIiQMREw6rLmbHcbnHKyd+cpcK/Z2rw2nGaH2ND2gmbsIQKnCgRzEwI9Yfg33gC/lpvHozQ3wPAIdlQqic8Are3s+hZUirkhTS4/xH/mnAr8UmOAJabI268vhvUGJ4SCRK3KCH6UshSbp8UyLe1xQ=;25:1y5qdGg4h7nWj8lkusE0HxHREg5Wu8incExxc/241K63gLYWVVAV94CzyG0Kn3wg2HN5EEo0CT4SRkMKfmfcFvlvW6JYJK7NgvSk0B7KzSjdL0fRDrCVZcXhjFvMD9zDKjiNzDZTPtoTOyUIZIC00JxwM00DDxPrTAM/HC12x/i2owSZq1c63BLR/gXfQ4Bb3Re44GTQ7Vj8UyQt10dFFOmg49jM+kg0sGQhP7NV6eZLH1CazLTU9Mgb8UVP4MA6udv2nrfoP4LBCZ5j13dBRaumUV+fET784dTDlsraaOW2dVnMcjuupbQ7uQUAttNeZ0QxmCzvD9UKgm1gS/qv3A==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3514:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;31:xFvc3LBhViXbibvt3vLu5btP1hmafSzTKhwAnFSGOjt42qirVAP/fC2tkwKa+08+nukiHx2f5Tis7CiYCT6cojPY7ElpRF2MP+isnJ6J5/TlrOxRoICPqORsDSVGgtYntOeDLh/Ao0Q0VxCFKkKZt0LyGPQHSGhnWzTyliqDFlPTRxKgMN9RrmG40+2bEnBDrBo6VExQ8RBa5jF6cvFrpFy7j7qnc1k8sJ1vPofdc7k=;20:V7UUA1o3x7d4pA8jL9mnRgAmv9RIn8YeMb/KjzySttRPQk3jIt0N+iHsLV2nmBz99AEifzu0v2FoFF9obo2uEKkN0G+0YAk3DV5nGTVHHLK+Y7iM+H+3kukuqcLMfSDsvpzHYGn0Npruy0KIPjL3F26Ky1/VsWqpb72p8bMQhSIEOMpcsuxYSUoWpZViYZRNp7csRi0UUxcO3mu5lh+QhEwt3RhaLfrIe7BhEMKIZ3+CmXnMm7QkGbZXhfr7W63OTWIOe6ingvBNDo2jme+AAJU4lrL1P3KMEcyX9F9uFd8XJKL1tM9KRbghhmpm+oTv19+xB7wd20LWr8LRaLFgCaMw8nxqorx2NGPmKTSlvPwmvnwn7uKbw9u5auPFt0UsrjqttQcJ9v2ddhM93sOM2WtgAL5OOoqE1h7giRLsMMeP1Lv5xZ2Hj0MBRpG9MMORdLstiAlO7l4cbv47dFL8EBh/ZHLPSP9qwYPs6MNDE6sshOmwt5pRYNvXXFk1IRSc
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB351485EE85B5B1D43D6D1CF9B03E0@MWHPR0201MB3514.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:MWHPR0201MB3514;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3514;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;4:Ed4Rb5srQNg4nrhQ7u+e87+3YQAEfVpR2gIUbY//shp07PzxnRBBwRVeEKCP9JlrhO+HPd3pgW5q+sL28WmFsQvwUdp435pVdATK7xG6rFTsekx41F6QxsYXuCYiBGUHbb+Id+84IzRMxtMmSMRtmqx6PqAQyjGaVvGTzqgRHnJz1FSrF0Dof++9bySYB6wWuPqWGTI8z7CrRXDhSukbdqPaqPWxqLVW1QWbIOVcLu4QLgZrikxP7+zy/9k3tAPL1l4ncMDjxlDkLJ7Dh7dMdsGTta28kXSrMX/com5ATtXW+g1Qx4b306dG4db6ZLXa
X-Forefront-PRVS: 07665BE9D1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0201MB3514;23:HLK5UVJqkix76cUWwnJ1E6GjjpxLglBpQWQpMCB?=
 =?us-ascii?Q?tah4N/KXsBDgTDBQKKoKa5Dic7sYbtMf0I1sKf1Lqb8uWAUILdh/w6zaxXNq?=
 =?us-ascii?Q?vU/jCOS/nlhYglxhf687C+oQ2jEMKPjtdJFlqa++8eucYplyvbwJNi+Z2QbJ?=
 =?us-ascii?Q?/BMd6mkKhLfzn2MkU9LiHuwZyQzJ5adi2G0cAQIOcDgmDikQ6w6erhNOv0VL?=
 =?us-ascii?Q?fX8N22Zoz8R3qu5vO6HG3g7ExZZ+OBw07zPaOejnfsGSTjd3MgUH7xOlcHzs?=
 =?us-ascii?Q?kkRtG2hf496SmEBzHZNEQGQ1XL/hQThwJX1VkOlrS830GRa5su/0sAvoknfx?=
 =?us-ascii?Q?qPiRlbpOuCjrHv7csd3ZeZqcvTRwH2HGi3zhq+QkK/gu+qisxRISCLTcnVZg?=
 =?us-ascii?Q?XYOQVQIqnZy67R0PY160J0676mX5w2hY5HkWA8gAOY7b+9QIDotko6LwsghP?=
 =?us-ascii?Q?HuEuDDS0TeFZIF2PJQllc1Y3Y0fxKhG/PqCA5koeOVAyxyDh90Zdg0MVuxMh?=
 =?us-ascii?Q?6CRf7oZ2e6ByFB10jr1XPZPPGq4In3B8hZ3fz/5XBdzJnmwuZ03dueDkK253?=
 =?us-ascii?Q?mZOwijUTvTxDDY2kTHmiX2TZR+VRoFfpvRHq6ESDjGyLmueibfpBlBT1dafe?=
 =?us-ascii?Q?TNfC3+ViPKd1yI4I8LLiCD5XBhBVa4jk6Ay+j8EoPdX3ksSNga1GMuhMr8Z1?=
 =?us-ascii?Q?QA8L4Wcc79VAwrnev9+ooi09O7AqIVSFPblbuOSDBBvBYpYYkUgnLxV8thM2?=
 =?us-ascii?Q?o64sCg3+cgunvnFvErGh4vPfXPAz6voE8m0Mwn2le9nn9sRdfV59p1xnUMhW?=
 =?us-ascii?Q?cHd5GfnQSwbxsK6Lz1GyGxmsMxfbTiK5uGaROP/T3UAapbv8aDQaZcq3igSh?=
 =?us-ascii?Q?Aasmoh5zNM3p3TasjX9jRqrr5G5P+ytDv+jaxATfqXDDOrZ2RiGt2DPnczhv?=
 =?us-ascii?Q?Iqa+00UT+4p/SnurkksFc+RFMl53VXPFkJ5rkTYzYqwJNSxmpzUJdaWwsHzV?=
 =?us-ascii?Q?2xcPALzTcTwfsc6rbmk4zmZSQ05hP/P/ul2TdmFyE1AmVzH6zMKMK1sHyKsW?=
 =?us-ascii?Q?+zgmFYPCH5HVQX1ymN8NSd3RVbe5Ke3YhSclfq9u0YuIz8RzTqLNbWmNLnXQ?=
 =?us-ascii?Q?+RYRmAAnUc7rxyRgV277mjqUcyXiPs8rWnLEprIBouBEGMjLpCg2LjE/Jm6h?=
 =?us-ascii?Q?OEaPNGJjHiM7oc30=3D?=
X-Microsoft-Antispam-Message-Info: 6fWub3eeb8+t1Iq638HxvXHfN+ZojrTjEqda8OUVD/UqzAVF+q0ai+SDfd+9pKUpql627HriEZrIFr93vVL2Qx3QCvc2iz5CqR2Kx3I0Ab52zKdyfiDkQPvTlfYO2BUHpOe8R86Uw/1yynsUMcHMCSI3TqfgR+4IUyqIvEfwE7062MTk6AliZwQ+5YgiTNuj87RxJIIlNK6j02mtAInpxmhCwcQSxKldFmUJlAZbfsaAsM9MTVHjp6pf7DM1zBd4nPDhcqrXOTMcvOsKdwZ47XXk353EjcjE95CJSE8NdwPg4mBXCu7TPws/U0ZyxgeHy2Qct/+8puz/rqzmLEZ78I4j5fraRTJ3Dq8tEx4el0Y=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;6:GuSKmz9UBHcRr74oGpy1egnfllh1EOSLOs77ch16aGn2ApeCCZ65VOPZVZd99ttE7qzTbXtze9VVfX/BJS2FXHA4HG89n9be1D/smS5gKI/7ZSey6i6MXNG42Bg6F0TERf+UGr2yksx8HgM8RA29kRdQNjfkwWW+YlCctXMpbx36cU0lBLH51EpPIxRSFeoFStgjawI/g72rAgPUoGyGrXhtoYneyOQj8TEQRjhhVvXCjwFykGRsuf9BdVgHGuNivAoC5PtzmqVwgCMLGCDXFDBwFCF9N1SCGUeVK+fshAmgR5halQTq57+tkXk46RxeZSTF0CmncuMf8OM5iflwSt2hL+5UyALO+agtjpza8CbR6ofRoiEx7QNn18oL0SMwg/P0pYBhVBplD1sjKnRF06m9NZylNVydB1npCjnb+ugbeGVGzINqzmgaSJjzqFypXlcW7PCnmmlHL+kx+m3kmw==;5:oHYPTuHrFYXkQprPBO34810CHiF9KbvZvkMem/v4tkUxhw8fmixhXdtIX3OPKz/Z1Uvdn/2PlBRu7rWbb0N5y+izlqJHpwzdEjhV5Oq5S/2LbsoNYiGDD0grZZpQFneanbaTzcc5fmo1xzreG4/rGA7ExfTn3plWGiEvyUBgyDU=;7:ycLlEwEW0mMgr45GjTPip0BCkFcPoI9SvA2a8oTnShzZlruCnBlzYL2EiVsWMe+O4w7vZHFWY75OYfW92B+5H9ELl9v41eJcd+iue6iLFYTobDARrgKqT+GQ/oGUheIZWhV28YBf5ZWF/S7C+B4nL9GQRLzMZ18+XtYBNC38wSti6sCBcR/Dlz8xZjvsxJBlN9OtkA+qqURsToOJD1udfdW+h0VDCJrotJ0zf5EqR92RTxKK8Wcmv8y0or/yWfE1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 07:07:02.0295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7c68f0-e0cd-4cd6-dd9c-08d60346dded
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add shutdown/wakeup a resource eemi operations to shutdown
or bringup a resource.

Signed-off-by: Wendy Liang <jliang@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 35 +++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  8 ++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 2e97f60..aa83262 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -475,6 +475,39 @@ static int zynqmp_pm_release_node(const u32 node)
 	return zynqmp_pm_invoke_fn(PM_RELEASE_NODE, node, 0, 0, 0, NULL);
 }
 
+/**
+ * zynqmp_pm_force_powerdown - PM call to request for another PU or subsystem to
+ *				be powered down forcefully
+ * @target:	Node ID of the targeted PU or subsystem
+ * @ack:	Flag to specify whether acknowledge is requested
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_force_powerdown(const u32 target,
+				     const enum zynqmp_pm_request_ack ack)
+{
+	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, target, ack, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_request_wakeup - PM call to wake up selected master or subsystem
+ * @node:	Node ID of the master or subsystem
+ * @set_addr:	Specifies whether the address argument is relevant
+ * @address:	Address from which to resume when woken up
+ * @ack:	Flag to specify whether acknowledge requested
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_request_wakeup(const u32 node,
+				    const bool set_addr,
+				    const u64 address,
+				    const enum zynqmp_pm_request_ack ack)
+{
+	/* set_addr flag is encoded into 1st bit of address */
+	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, node, address | set_addr,
+				   address >> 32, ack, NULL);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
@@ -490,6 +523,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getparent = zynqmp_pm_clock_getparent,
 	.request_node = zynqmp_pm_request_node,
 	.release_node = zynqmp_pm_release_node,
+	.force_powerdown = zynqmp_pm_force_powerdown,
+	.request_wakeup = zynqmp_pm_request_wakeup,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 02067a3..efc73bc 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -54,6 +54,8 @@ enum pm_api_id {
 	PM_CLOCK_GETRATE,
 	PM_CLOCK_SETPARENT,
 	PM_CLOCK_GETPARENT,
+	PM_FORCE_POWERDOWN = 8,
+	PM_REQUEST_WAKEUP = 10,
 	PM_REQUEST_NODE = 13,
 	PM_RELEASE_NODE = 14,
 };
@@ -137,6 +139,12 @@ struct zynqmp_eemi_ops {
 			    const u32 qos,
 			    const enum zynqmp_pm_request_ack ack);
 	int (*release_node)(const u32 node);
+	int (*force_powerdown)(const u32 target,
+			       const enum zynqmp_pm_request_ack ack);
+	int (*request_wakeup)(const u32 node,
+			      const bool set_addr,
+			      const u64 address,
+			      const enum zynqmp_pm_request_ack ack);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4


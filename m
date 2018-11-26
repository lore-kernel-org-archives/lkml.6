Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168BFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7D12086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IMO1JV2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7D12086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeKZSCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:02:08 -0500
Received: from mail-eopbgr710043.outbound.protection.outlook.com ([40.107.71.43]:20078
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbeKZSCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUceEz6fxXejKBo60s8InVrxsAsqk+LnQkFMzTLh0i4=;
 b=IMO1JV2sBTBM1Ek4xa3o6kXxXOwlfoZSVRs2WZmqSY0fEQ2V/QzF5Yjcpc+0f9J+MW87u6UJz0mGADJIjIlpEn3xy9nQSBXRK+onfeHdv34O8Zsmra7cCHPNPi7Gwq2cd7jdl5SpglfP2BEGxvRFSu2gLF/gMG/q/ZK0t1O1wo4=
Received: from MWHPR02CA0007.namprd02.prod.outlook.com (2603:10b6:300:4b::17)
 by DM5PR0201MB3512.namprd02.prod.outlook.com (2603:10b6:4:77::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1361.19; Mon, 26 Nov
 2018 07:08:15 +0000
Received: from BL2NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by MWHPR02CA0007.outlook.office365.com
 (2603:10b6:300:4b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1361.14 via Frontend
 Transport; Mon, 26 Nov 2018 07:08:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT042.mail.protection.outlook.com (10.152.76.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.15
 via Frontend Transport; Mon, 26 Nov 2018 07:08:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gRB09-0005r1-VW; Sun, 25 Nov 2018 23:08:13 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gRB04-0007FU-Sx; Sun, 25 Nov 2018 23:08:08 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wAQ77xB6026220;
        Sun, 25 Nov 2018 23:08:00 -0800
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gRAzv-000758-Bq; Sun, 25 Nov 2018 23:07:59 -0800
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <claudiu.beznea@microchip.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>
Subject: [PATCH v2 0/4] Macb power management support for ZynqMP
Date:   Mon, 26 Nov 2018 12:37:48 +0530
Message-ID: <1543216072-9623-1-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(106466001)(36756003)(51416003)(2201001)(356004)(6666004)(50226002)(8936002)(8676002)(478600001)(7696005)(9786002)(77096007)(186003)(63266004)(81166006)(26005)(14444005)(81156014)(36386004)(2906002)(305945005)(476003)(2616005)(126002)(426003)(47776003)(106002)(44832011)(54906003)(110136005)(16586007)(316002)(5660300001)(107886003)(50466002)(336012)(4326008)(48376002)(486006)(39060400002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3512;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT042;1:vcUlV9CSrvfzDjf9Nl4k5fqdJpgfukhV6OhU9y5m52JqxLO9X9pNgqMSFTuIjrHqFgxhG9ewFES0yK6ymulxjDYKsXjmS3ar863UgT9aN4vopmw0LtP609OWpW8hOelu
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26941a3e-8fea-442b-e813-08d6536def1a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM5PR0201MB3512;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;3:rWaarFSc39xabr1P1Pepv+fIQqRlxAZ0ZHDJj9iRZbFXnHcVE55lpG6dJ8emSHK//D+4UJgwhWH+vq66+4CNX0kcnoj6142w2PZpMzzk4oOi7o/ifDhiHMV1edf6R1OdEJGvUhoAIAUsbVvb7/C6inkZD7NP0Y1BxsdsK9Sg7cKQEmeJqKTgM4M5jLcyIsaQ3cuJqd8WEAscLOCtesVA32jLoSi/WsmXFrFrC5NyAmgXcX5iIO56jReda1R+kFCfhc/qH+leLqRNFGhKImFWR4YZqw4BV5hwOlaSPUGmbcF1WBhdsJFtS8C9xhskiSLx/OGIiV87EM3y/X8xmnnGsTWFO0A3hUUwwEetxL9/xUs=;25:VjlxTVoE/PZ2wzDh5R+Rc0Uisl8yzhp026d9Pf4C8lOsx36zXBrxCsz0ugYJM3I+ij1TIyqyfAQU+Lr0kRkArA/jgNdkS5/xKx7azkO4EGACgCGa+GPIpIZiCKUJCIfXxCsfQTN0HMxwqg2wWU9nMB41rc0B8Xqq7L/6nysntVgbGl31Cp0iMPDKXDW8GIIAPsLmutn4COKmN6C1Nk8mJ92u1oGavkgncItdbR7HdRM0JkdK/2/ZofMLdwKOX3EpVSYsJG8HmBDQpQXsCwGp6uhQFgvaeu8qiqsUEp6jacaATduPt7xUa/puRjj39YC6aRJULPFZmxp48ecXAKwp+g==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3512:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;31:z7sDlEyFpGciFvf2835LllMB4bEsIBQtt8ZyQNvsZuysf+cpThBpu/cSzGpi/eah8zIZH0mg9kX8z153pAsGJJae/Q7Nl3bQbBNUtl6/x3tlxEyWAsJkEkrRbrqeoCMY3fS/5ywSpycjmhhayiahgsMR5iyphUlasWO8FhLhgml3p8g0Qe4bcsa3+/Qj2JEdhSr6pTeRS/7rEQbTmfDLt/Ag6yuPpf7XEXF8+itutq8=;20:qDBFEJVcxnEYMSLogQ0cyIhn1gXj8uLO65bxbyNGvPAPiw6gp21hv4CXBi2UBVGRKPrJJVLl9vKwlA2j8jxB6YSBBvTMMGSAZuPuh/D3jxfIwV+OBKqf+332zqhXumU5tIK2nAik9GQVgjj0I19zdnvB9mH+Bvsp6tDK+B/M66mi9vtHSlCI/c6uCo0HiFvCN4AZFFggs9nwzVM8dvdemfawmtcORscABDVWf2zNL+af+NQEWKS601aVED/PRq2AtVmJrz19W1Hi/eCDXVNCSaNE+SCLAyzw8sGdyhF6XU2bkBM/HvvQQOWX7uwMvFbcEWUW5pXHtEvnYcaQy7H98OAk8YvhQ45f9DBxeGPIDbqk5Zla2/xFmoY+SescFTJ8+pGo2I8BVx5bo4Ob1e4v3YceGV4mmZfTRdwao6kW9+DBv/xloX2kPac/E0FpqpUuoYF4OqPZtkzpskpCfRszmvc5yc7+Oq1vHiq7Rl6x+oGMu1Ly78JnTY0q5xJk+ckq
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB35123073E2BC31BD4E5E0406C9D70@DM5PR0201MB3512.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231443)(944501410)(52105112)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM5PR0201MB3512;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3512;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;4:F+RnnPJsA+aghbR18omO09Z9B0am6zE7psC5icmP6cWWoS5rkhuUJYEgYsMEroxhnUQH29Up/+xOc3gDpNvOopEZ522U3kUmFh2WiVwkuzMaVPBqLMWzZps0M3b7mzELJuU8okKwuM+YMcsIkcVsx+2A968m8ODKzqgU3EEX4u1lh87RqWhv5zUwiK8CwVoQECxlVdzcB5jrBpvTltoyaB6b//amWnG7S60HST4vxv/R6whkIQUqlXgGMzGycEKyybXlyyC4xA9lrW3G9x88zg==
X-Forefront-PRVS: 086831DFB4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3512;23:u+eU/7pZu7iuV/DkSK565c1rPANku8wmg4IaT7A?=
 =?us-ascii?Q?1egh68PJqnr0T0/5EmnpjpfaTZe+fLS8SCzNjQFy+NbYOTmWco0lEhdyctI7?=
 =?us-ascii?Q?nbXel1wRXxzq3OzeSjR0zqoEOjX43ZZldVT9QdAsXRwKCd3v46dAwXKZR5HC?=
 =?us-ascii?Q?ENj2cqTAfURFjIFhKLC9b7W3BT1wv9BWOOl+b/UswxfzZTIzx7bF6Pb+mtvG?=
 =?us-ascii?Q?r+psc63p6ESLswtUGKsRyab3thEDpo7Zz1E7NJHwOA9MXMpTn9sR5zLeqj46?=
 =?us-ascii?Q?tR5YHv31E8OE3zkBzjZAfNDW/dXbnG37u6fH7F3idV7Ee58hDGwl9bYHuh/A?=
 =?us-ascii?Q?dfhc2Cy7j9XlPDLmzBP0seu3lwHZiJZTwkTzvEIg6uDsjUE4r67NwL1CXePy?=
 =?us-ascii?Q?slu+zS+u+b/BB7eZs1va31ilx5M1L36T5RjXAbItyLbb5ULtewh7llNC6P5q?=
 =?us-ascii?Q?+kfLlIVKNiuk1bkKQqObWHazR75L5DyjGZIZFMBttbWKyre2Mf9W8Rv9lQyM?=
 =?us-ascii?Q?Mo/nKv1y9ppBCtsMSYc0WFnkuLZtr56WUvfGB/KAYOCEa5JcD20sPcHezdBX?=
 =?us-ascii?Q?iJBWXUi0mcmAQ6iGhJ9EVJlRAvfNkKjhhtrjjkPCcFPx/p3HkyTx9bJQH0Q9?=
 =?us-ascii?Q?O2BEVHPgKynzI0uk+T7zIABqMgCtKs5dwqHN1yC8dyZM/6eQiZjl4lc3s+qa?=
 =?us-ascii?Q?cAxV/uBE1Ferj2/vnNd0T1N8Da4kPyht6DfTGw8rO/zU9CzaQceZLcdPhEin?=
 =?us-ascii?Q?FH7aH5zn21g3N6pkNVHYcvVGuxBylz9gaZkSYX6hpX+m5QsrMjfTjgTQcPti?=
 =?us-ascii?Q?ayk3tKJkII6+dNb9KEE1RQFpI5Jm8k2PwNH+sV231HE8PAgiHC37wluW7h9f?=
 =?us-ascii?Q?uEXOaRjxJcLaebT1yRX4swT1ek0iRtRZ4yiWxgbY+UAlpxC3KlhRL2l2JMcr?=
 =?us-ascii?Q?VwSTjslSPmHdzP/1dvNknG9vHEGulJ2S+leWPuDWDfqKrFijPKGZ9c8+9zBw?=
 =?us-ascii?Q?y7cIi2tq6hyYMl8cfVdY798nt/UGMWcP/2X7Ahv7sCgOUqT3UIYDdO6nah3Y?=
 =?us-ascii?Q?KfkGRWa8fapN0hBcNoELPgPgI3xs9HpZ3mg/jvl0XR5ONYayvyEqvnCMAQCo?=
 =?us-ascii?Q?gWOeDHRBjTkgGSY4b9aX+YhSa9QFzy1MU?=
X-Microsoft-Antispam-Message-Info: xfD/t4SI5Ez4FMbfvZ4F5xlSArduEgRbZwp/D2ssYGSe+0SysWobNXOwlXH6GLXhzhaE5uGQ3iQWjGZy935tZ6wqFJXowQOrGMcBJj/nU0fVHQDb7EUb6RIBQX00fv3ec06z5thbmkzu9aPZHjPihVU79/VskXNXMZ56D6jHQD+iOSSTA8U/0q5mqWSpLlpLwXhYyfi9OcG2PKHBn5o0oagW4Js7meTZtrZmOoC/qE75BCuXCSHYftf7+7Cpl/b73aHzWYsuZaamgz+dtXet7PGpZA6Kri7GVSXCcVaDIhdY55jzdeBoldkC8JHjpEgiUwE816NWjOEervleFWhLdfs6hsdf7At22+Rz+vulG5M=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;6:4l4MiCpMiI75I4UKDR74MzXKiLko+TC88b4jLwB++TpZJS8Hd5D7q/KZwqDAUVaHgzXrggzwGd7+rsrx0CEkBM84b8w0o33B0sJwsVO5sQDQBlSqRbM9JJuILh7+/EH/tmHHmJJv7+P1QmWXjpAyszbYuSLd286a3X91zeN+prngFHxv3UQ9wIgoK7wGhx9d5DGJGEE8zP2yjYlUiWB7TQj43iHbd1DGmqvmt3gLTtm7w2i9K4E1p2fom3S7rmrICKHw44aEMvmS06R5rn1u/WYNROv5mc6zADSslQ+W3r6ObWLFrDzuKRIuOGjPW+Ch9N9ZertXrvbuLEu24XEBT1kXzJUHxiljOZN8iVpfOKMO6eMv8NLsOvMmW6a7f6cFtb94tImQ/h/xFEUgC/dPU+8/sYEs/+0T3ITujCxs3rs+UbfcBDGc2TRQ3CH6pRd/cWAHxn2QAXPffUwkv00f0Q==;5:QOHx4veTOIXbLyLwVsJRKeldbDnCvK16LsNsfUCmVqTi/2r9PqRU0xL8ExRFPE+sggYJPbB2VadQV46e2VSad3tFbPDX0w/w257EpPoFqv74eUYM3S044P9L4DcPO1r4mGIXq7V8Iqn5XQfIcLqEi1DL5zkEv8nMKetR8KeaRN8=;7:069iIM3qHARBEdo0ayqujKhcBqUf15I+nNaearka0W+yMfwxV/iCnF1gxGdxrltteAiit6yLJVZvenAo2p/L0SGdCmmF6Mz5pvcyRlcjD0yCcIa0ayEB6EFCgY0xNGZdhyfv0BbhWPkfg8nPnPE/VA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2018 07:08:14.5843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26941a3e-8fea-442b-e813-08d6536def1a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for macb suspend/resume with system power down.
In relation to the above, this series also updates mdio_read/write
function for PM and adds tsu clock management.

Harini Katakam (4):
  net: macb: Check MDIO state before read/write and use timeouts
  net: macb: Support clock management for tsu_clk
  net: macb: Add pm runtime support
  net: macb: Add support for suspend/resume with full power down

 drivers/net/ethernet/cadence/macb.h      |   6 +-
 drivers/net/ethernet/cadence/macb_main.c | 210 +++++++++++++++++++++++++++----
 2 files changed, 188 insertions(+), 28 deletions(-)

-- 
2.7.4


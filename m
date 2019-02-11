Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_FUTURE_24_48,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA067C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 16:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C5B214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 16:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="kjPxt7Ll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBJQRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 11:17:32 -0500
Received: from mail-eopbgr790057.outbound.protection.outlook.com ([40.107.79.57]:62240
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbfBJQRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 11:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6j7darQ/2szuXGDuOSOWavsvpUWGtXTqOieLtCRzl8=;
 b=kjPxt7Ll5HFEE0ZATmSMtBuOkZ0VJRkwaKRa+3GQQyaIkmYFCZycp4K9bS55FMBjWHl5yQHzs30dRZum9t94Sotkqg6t6hb9uPXjMNUKnwgbFsWEL1sjSMy37XKs3gvXMVG18hUwGwB0nhOgjmSi62rvUzRShqMx+jvxws4Jsww=
Received: from BYAPR02CA0054.namprd02.prod.outlook.com (2603:10b6:a03:54::31)
 by DM6PR02MB5017.namprd02.prod.outlook.com (2603:10b6:5:52::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.19; Sun, 10 Feb
 2019 16:17:28 +0000
Received: from CY1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BYAPR02CA0054.outlook.office365.com
 (2603:10b6:a03:54::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.17 via Frontend
 Transport; Sun, 10 Feb 2019 16:17:28 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT053.mail.protection.outlook.com (10.152.74.165) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Sun, 10 Feb 2019 16:17:27 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gsrnK-0003eD-Qs; Sun, 10 Feb 2019 08:17:26 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gsrnF-0002b2-N9; Sun, 10 Feb 2019 08:17:21 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1AGHD9A020878;
        Sun, 10 Feb 2019 08:17:13 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gsrn7-0002aA-9x; Sun, 10 Feb 2019 08:17:13 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v3 2/3] dt-bindings: fpga: Add bindings for ZynqMP fpga driver
Date:   Mon, 11 Feb 2019 21:47:36 +0530
Message-ID: <20190211161736.23844-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39850400004)(136003)(346002)(2980300002)(199004)(189003)(106466001)(476003)(336012)(2616005)(36756003)(186003)(486006)(126002)(2201001)(9786002)(426003)(77096007)(26005)(47776003)(63266004)(356004)(6666004)(8936002)(305945005)(81156014)(81166006)(36386004)(8676002)(106002)(2906002)(50466002)(478600001)(16586007)(316002)(7696005)(50226002)(1076003)(110136005)(48376002)(51416003)(107986001)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5017;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT053;1:jgAanaHsP/Vtl3FhYdWaPof0JuIj/u5knDGjfffCMjYTnfLs4C/T+/skS96QHBT4eqy7nPkWnCPFEGw16r6ehHMRjnL6IYwStI2HG+AhNafarlTSfNwP0i8h5v9nGr1WyGAwmii5Ovc6LpyOg0SYIo6HkTtIq+3C/sxR/I3jbhw=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6afa0532-90ca-4696-a9fe-08d68f73400f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM6PR02MB5017;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5017;3:nH31cGUdBPSLLlJPkoijEe0F5sXLHSqfVApAz/JEkG1tTst5YbCKORn70UpkZ29MfuKz0acQQVFfcK2RQxZ6Kw9WfHf+1UdK+CDW1vSKYceC5JOshEVRq6EeaXHJWsAy1Hx/A5NGBPAsVE4Ctvr7eselQovTDAbwSGGMbBtHD52SbyYA3TusXo0twnWztFlLGa2RQPW6FW93QMtZuARALdV0jBHjlpOmBubK6+f/l2P6El+40PG1URBrIDAAUzyWFcEa0UKwmdpasKiaajS3dL8cnGeNd8P8Pb4eQ7EubeK1ck+EeWhLZJaGRcQwng6T3CQzdDMXknBajCQFZaODKU5Kget0xNZlI04wnGYn6AHj9Sq8Jth0Gpvn2ROqMxEz;25:Cfwp3LuOFjw+52eQ+8CrXfaWzlR3lFnxANm+fjjxQYmOfWwp1Bc6KWbLQ5jyP5w++woMzzFaWGCCNW2Rqb1/6AhxSh9rjSCpElGKXCpeBd1wRPQqv15UExJ+/BePeLf7cmpvmFLnklbbTnCKpn4Njl08Uf5zsHRYKIVmg6nlZT2VAnH4mwmdng122+tHxyN40kkGDo+fHFy7k9gmQysXPk7o0kiNAOPh0X4JIugCejW/noimu/lzOPUj7WdSkHdQ6VQH7iZymBLLUpqNa9SUd3JPIGz3MRLcdH7NQ/ydI0fMLHpfYkFVR8rAeyvfixgCTNMdDNOci6mwoqKUEkg7iQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB5017:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5017;31:fLvmcGHzYGEbpxoIT6Y4vNXP1vcoh9ZlmtBP7b/WLFTzBEksmdaD4uTt03M2lnk3AHqEnAFJ73L4ZAE6aZNdJ26XIL8S5oBooQPmYlkffHK97N9b2e0V41RHlLiSqQ2IGCl5I0rLHDSufeH5qineWS7w0fOJtHvnzoVcm0sPZGPdvozJHlr9XJdnCpTJ62k+OeYWgdvxw2QAJHeLoqixVxSrgjc3Ewo0mQTsqMsvLPY=;20:6d/HlT2Ac7l7GQBRzDnlR4qAgG0pUoWU/xfadMjnzkoZhhyBVgfXkv4mnhwSJFfIqcYdBhA2UqLwvE3FnBAHi+T4S6vJeO9rpLQ6Aq7didWgMruHmQtQ3975CO3gaMfn6zU1T88kNxIG4yJTqE35IAgXrQfwE9g2w/YzvIv4X5JsiN1tRp0E25aB2bE/iQUsYPNbUr4slta4/2ifRE5VtGeugICwOiNqhpLEY/KCHWrY5+88/RfoyXIiq10qM18Ngip7r4OWqHawKXkQZoWLUBlNI9y8ZR32/yGmWXNAe/ZeY7wFh+6YzCKFZW/idHuvs8FF44axWF0qNVceZdWC8pvR1CJohN/kzxivKJUBxbsB6DNoMHc/jnFk127oNSsVKzsK4yj5/YBshjMFfd975IuYmNpcNyVsGKs/0oxL/H2d+UMWOGGUjwPcfRbgrV0zXHHX4GeFWyYL1eIZfiip0VMj99b22073ud3Iaj3WwCUEkHjm+XWU5ozm4eQLJzoI
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB50175AF92742FEBC69EFA9CEC26B0@DM6PR02MB5017.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5017;4:5qF2TiDBq37MiRlJOUVv7SUXye35NSS4fpFIW7CaakN0UPpq+bqafwCkKdhL+JMZf/DI/DhbjM+ZjqOkSEjR/pJierGvqUXwWAW85tZoZ/JTECvtMdlrgDPceRLGZDzDNswAL8Ddkp1H6gJaweNP3OjcG+vwR73BoY9zkwAkIy09hqR5nXcbicMRi4PqFzap8Sw2Wi7mehUeuxV7Rl+j4nRv0DYEsYkWMaomZwfIf2gJtkK+2VG1RZysFxuv8sLV4/dMpLq5zfGEgiZE7RaceZxhGw7+Z8lRf/ac87+Ud2Q=
X-Forefront-PRVS: 09443CAA7E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB5017;23:El7tzhCBfX3zRtdoWh7Z8R6HLhpc4duVI0z1asOdo?=
 =?us-ascii?Q?Eh3L9Nnp2kprvtwKEgmTWYPRBsMe7aXTogXWIyAHvSK+IGQb8ftefmI0Uv2l?=
 =?us-ascii?Q?JW7DAYdtkbfbjoIJC7P0GelQlS7oCmhFFrX3y4pIBODz8i7Y/vReTXkAFh3h?=
 =?us-ascii?Q?Kb1SJVZEAD5EtMcqOdxsOXTKrOmPxxUZcgIjm8c+jv7LqtS/72Uga64C5pOT?=
 =?us-ascii?Q?R2uOKDInlLDpEByaOC++W+gTkT+q508/p5+z6WVO2JC37x7UDMj9mazlY26t?=
 =?us-ascii?Q?x9AQu7Vg9Y1boig74DPKFSPUjxY12DnplL7FcG0jOyT+1dNm6KeZDWAucePX?=
 =?us-ascii?Q?L6fcpPtPIfrWMyPldq59csutoQpzVCFSc4508FiRLxAjLK1374TC3kUFJMlR?=
 =?us-ascii?Q?MVPea/oYOmkQgepj1Dlx2T7lJhsr4GR/I2Jvao/rIrdaIpMi6TW4rs4wArdn?=
 =?us-ascii?Q?0MI98KPTZd5vpduHrSAEZjsoTmnU/j0oYd8xykedTvhCf43bY3c6WAoGQhjL?=
 =?us-ascii?Q?/TMo/5bYr5o/i/SRjfT0vwJj49ECxtg7EyI8WmXpMxqMm+Vt8bcE+JUg1TqP?=
 =?us-ascii?Q?8n7xq0YlZh1imjYeBtyk9o78M8TXI2P7SSQy7gWxbFwUn/TMpHGXzFEbO+V1?=
 =?us-ascii?Q?XU+BAXluEB2ckUxR9vTnJCU1l3Hj8Oc6LxZwYftA+xlAvD/C1AslslL0pNsa?=
 =?us-ascii?Q?bBo6BrhitUQ8OGMuycszDcl7yUrTfrT02A7p0Sfo9GIyy+OYzd+5EY44+y0a?=
 =?us-ascii?Q?dpUsMXtk4pQ8SOSRwB8rsA9OP9x5D49gz80pEPuT1pxxZVJ9mz1pHMizI7Ys?=
 =?us-ascii?Q?qnOMJaIH0Kk07WvrtJ9WEsdNkfWNqqzOYhXEUFoWwX6auTxbyQTIYzK+ociy?=
 =?us-ascii?Q?6zLyTIM39zP+fimYLlKrKqGNe2Q1y0tJuYEs9/nEJKTMCknIKvO0A24rxVL7?=
 =?us-ascii?Q?CiW+A55bn25BU2vEqvTKkpw2WX5Y/9xCcweqRPIuWq9GYTnmNnc+21uIk00B?=
 =?us-ascii?Q?4Zz8W7kJ66k6nqZhr7RrCJEitnr/36s/KeADaxrF+uxBS/V5O1LZ1muHEK0V?=
 =?us-ascii?Q?zSAG3Y=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: L65RID8+VLV+CKC60Sj7rgF6taKlvQj6EN9DrANPt5oUBKziiLRgWR1TaivPRzy/AZ9gf2C2B/pAC6NxwHaCvIJu9YxBwTBImMbC2uEkNuz/YiSI8+vVApjjpPeFc7simYMfHMRI/A5d06wLfiPlchGZiL1Xpnlhx00gjw6kh1ZlU93ehdKwM5jsjqMSIzzNxtE3XQR8UYeHBVZZ76Ei3qCRjaMmvfjs6fAdFcGuHmpSxMD4BMxdDnHP7rV1Tijhjwsddx4Bbt3ih8p+obzv8O13e3tKmCBspRypecZhc7NTL6FVQjoRl0nRF7ds9PiwN4PvITIaz6ltmrp1Rtqyqe7g+eleJO3yjgiYSXU8Shut6OkCkCWDANUJwOSzcy5AXN4doND+MvYXl9NRkQqbzBajYruTR29OZ0kDVsXyqsw=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5017;6:AwL8dPd4vfJJ8RBbU1Nd5Jo7DsG12oMnr9NoTPlyWcYYgt8StaSEKFM0kb3WSZaD6/WkyHBwoXFZ3lVIKLHMwkUH+0amGP7JtXLD+RSKJo9vRBKbPWtPO8TTlAK4TVrEdCA6QAn68sD7pOrK1QEmayCSwpK9hOh3T8vR69YxGCj32u6MMPhXcYiDsPptZ0tA5cfmbPMJIbbbZ2UtK8px2NMm/h6v+aAV2BbGK4zvPkBjOWIYmhacABhvXJaawrDVkZz118NMPcoHVYVFW3ty7LxLE55JubKKcBqUbhfigk8vURsC3PxQ+ddAyV2koUruW3FyefwP5oIkji/mUw9p3ZFYX7BuDW9/i7OrCO2SoLHLEOPfQRN8u9m0wce8dTmimtSPErBKfb74etLBhcxB9nCagk6HodxTB6GPg4zJlzJKaRd4X3AtoAlokhTZt9zYoHDMiZs+2qqYKZOG+R0OHQ==;5:sx0aVpXm9Uw27/rbddYWSilnqL3JtVGyJvIsHQ+E724hCXO8mFjXKfov+KAeD+FZgfianzkE3IWPUGGO7nBiz2umwW2GbaBOl6SSiLTlrcWt3K00NGvOtEj49aXi0drGPifLUZcKgKE/+zunpBRfR2t2idKKO1eiJiCLRfdvYzwCrZaRMAi4v0Jh6IvcTfEbWbyVOdK066hsx2+izT0BMg==;7:EgaxupmP2L/F7/CUtbBwoITrU4nnnH0DwaDvpyJqjIc/TiWRH+HSsfUIiaSozR71qTP0tUMpdnh82aPuiFiUNV9wwtz7PsVxJK2cmSOYF32saBc5AJMQGCW/oeCrYNG+U7hESs76dbnoYaKcgpkPPg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2019 16:17:27.3050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afa0532-90ca-4696-a9fe-08d68f73400f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP fpga driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v3:
		-Created patches on top of 5.0-rc5.
                 No functional changes.
Changes for v2:
                -Removed "----" separators.
Changes for v1:
                -Created a Seperate(New) DT binding file as
                 suggested by Rob.

Changes for RFC-V2:
                -Moved pcap node as a child to firwmare
                 node as suggested by Rob.

 .../devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt      | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
new file mode 100644
index 0000000..1f6f588
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
@@ -0,0 +1,13 @@
+Device Tree zynqmp-fpga bindings for the Zynq Ultrascale+ MPSoC controlled
+using ZynqMP SoC firmware interface
+For Bitstream configuration on ZynqMp Soc uses processor configuration
+port(PCAP) to configure the programmable logic(PL) through PS by using
+FW interface.
+
+Required properties:
+- compatible: should contain "xlnx,zynqmp-pcap-fpga"
+
+Example:
+	zynqmp_pcap: pcap {
+		compatible = "xlnx,zynqmp-pcap-fpga";
+	};
-- 
2.7.4


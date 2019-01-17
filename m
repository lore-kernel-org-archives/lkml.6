Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74009C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317AB20859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="J9wT53mc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfAQHCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:02:48 -0500
Received: from mail-eopbgr790089.outbound.protection.outlook.com ([40.107.79.89]:4444
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729594AbfAQHCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nj/5dvRYEK1/x6oe5UBQotrsUdbouHjYlO/MyMpPMOU=;
 b=J9wT53mcv9/my4yrwuZJy2TvZnFvr9zajVZkHZAE3Bx9UyL1ISwEUxrOQsUhmyUUW4g/4rQcZEF7PiphgJf4JhRWeoMQ7M8O4WY2CJJqcnqacGg5PiQqVwcqtOP0PPEHGzM3jxnWWklFHOx9UJ+DIHP/Q4eeLSr8Os3A7NnBDno=
Received: from SN4PR0201CA0029.namprd02.prod.outlook.com
 (2603:10b6:803:2e::15) by BL0PR02MB4451.namprd02.prod.outlook.com
 (2603:10b6:208:45::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1516.19; Thu, 17 Jan
 2019 07:02:42 +0000
Received: from BL2NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by SN4PR0201CA0029.outlook.office365.com
 (2603:10b6:803:2e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.25 via Frontend
 Transport; Thu, 17 Jan 2019 07:02:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT020.mail.protection.outlook.com (10.152.77.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Thu, 17 Jan 2019 07:02:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1gk1hI-0005kD-S5; Wed, 16 Jan 2019 23:02:40 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1gk1hD-0007Rm-Oc; Wed, 16 Jan 2019 23:02:35 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0H72PA1022374;
        Wed, 16 Jan 2019 23:02:25 -0800
Received: from [172.23.155.90] (helo=xhdengvm155090.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <kalyania@xilinx.com>)
        id 1gk1h3-0007ML-4Q; Wed, 16 Jan 2019 23:02:25 -0800
Received: by xhdengvm155090.xilinx.com (Postfix, from userid 23151)
        id 5C07F800D3; Thu, 17 Jan 2019 12:32:24 +0530 (IST)
From:   Kalyani Akula <kalyani.akula@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kalyani Akula <kalyania@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Kalyani Akula <kalyani.akula@xilinx.com>
Subject: [RFC PATCH 1/5] dt-bindings: crypto: Add bindings for ZynqMP AES driver
Date:   Thu, 17 Jan 2019 12:32:17 +0530
Message-ID: <1547708541-23730-2-git-send-email-kalyani.akula@xilinx.com>
X-Mailer: git-send-email 1.9.5
In-Reply-To: <1547708541-23730-1-git-send-email-kalyani.akula@xilinx.com>
References: <1547708541-23730-1-git-send-email-kalyani.akula@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(396003)(2980300002)(189003)(199004)(44832011)(446003)(186003)(478600001)(106466001)(51416003)(76176011)(426003)(52956003)(107886003)(26005)(6266002)(63266004)(356004)(2201001)(217873002)(336012)(6666004)(4326008)(5660300001)(103686004)(305945005)(106002)(42186006)(8676002)(16586007)(90966002)(8936002)(486006)(50226002)(54906003)(110136005)(81156014)(81166006)(316002)(476003)(36756003)(126002)(2906002)(2616005)(11346002)(47776003)(50466002)(48376002)(36386004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4451;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT020;1:4lV0YwY/1NjJJl84RZ1HxYcSGWZ/zkHrDqXVahoee6o7IF4a20ORYRpIMHwC7GE1m5ovMIPhAEjbsx13VieAb+af3iF+3oUUaD6IbtgCmcNrlvR/IWt2neLSxP8QLVYf
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 256f31fe-9cef-4a33-fc72-08d67c49c5fd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BL0PR02MB4451;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4451;3:28IQ1dQFZAITAlCymO3+LoDFO4sR4xLauUnwdZ5uVmkCDPZpNUjZhn+089CIUQ89jBIFwd99dDtRxIqnzDe7ei2JcafV/7jC38O9UyUaMrwxhLolxnDLWSbA+VqBCL3SE8QXxTtXaU6ZRXAD+oKspu16cpXuTlo7MDpqeP/twslCZ8KodeMiHBN4NW0L7TDPBFz+t7v4w+dYUwcbZjsi1HMujJqYxMdYFWCy3gQoS93dl9jvTG/xMUihtZlOYKhVkSyqxZVrxmJCxheiayPVskexrM4gnzCsE7PnSnSJnqJ3DtcSehCGlGLG6dBXOPWZUkMxgKvx8q3alOZMCj2h2w36myyc7xH0sI+NPQQ2+IuHtDv8LSrxqpgp3q8s4isr;25:gKtWu1J35ktVQcE36rXtBIgY3VLGSHBMMEQ54Uig6+96VuVmStIsAZIiWb7zZN9AkTfJunnPYvS+n/fJLkJu31aj+F9D7IvrColmeeH5OO1+5tz5kEqz+AN5sTcGO+GFQLfZZQf9qHea5S6Hy9ECBJkOuWY5MMVjS2P2SPRgnSuPHbmOpK9MOiaLTipYUhX9Ogbdybrve0rALGFTV0+joXXo4yGc7SOVDETMvMHQsXfm0Awqxu7DuCmDEh9cm/QjA/tvnkSj4RxQAANiZhSqCke5Ja7e5Yzv4dzBepPTA2l+fkwdfsrf+1taxCEdWqyy5oDBj8n5VL47qrZgPuNnDA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4451:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4451;31:DgaznS6DuOsV27EPyPr8vmwhYqqwoul+RTKVXSXCodh/Yl9Nc/a6F5J9X4ntSFQmE+uz2c/GON5e41FAPL/sJsXOpJ61q5OdyOyngNimF9tcV8/be9923/TCGb/16vR6jX0wAAvuhl1GT0xTHoeFQ0Ts7NjmMnOJ00cfrHkkU24wweMrtsKHzUhKU0jBr3KaObwbNgTJzo5v+ivVuSubNwMLgijdRtVcEiO6tWtDIyg=;20:M2wgvHObCWyYfiRqCvJ11us2br3mx1J1R7HWJNFd5o7SBc4GWZoUb0eq5UpHx+JA96zfxtUBhmDLkStm8x5x8AU4VWdY5S9gijEtMZJBl0RPvziWk797CnAJEq2VjoaJAqaK6Vsd21cPC/DyFzHjMxQ574SePLE1yTvnkbTsPBL4UA+Sk0bm9StyCQ61llQWy3RtsM2Lh4RNRiuTr7M4/DVFDXXCJeANDMZCiArc3OCE1pae7HkvgwM3lNOtW6V5M/w+/kqyfzz8fDh+M/TPeDUu8+9/nMLu+AJNuUgsm0a2Yl4OkrD3NzTu/S1riF+jdW6yytEohxK2omS35LxTyyl1ZqDbEom4b9l053uC02Qsc5UE2kfEnGdob2HUvqlk2LD7LZFe3/0RN6oCJUwMarrbQ1NxtEkADZEuSxX3ZTtRN8kh4d3GecBIyJccUVEag2UJKmDAwnxIga5XZQ7TPhwQtmP3gumDegJ+91ek9mM28Dap8C/XeoLt9Bmatj68
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB44511665FCF03DFCBDD1650BAF830@BL0PR02MB4451.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4451;4:gVX+/TXqvrn25NI3hHoDM8VGt/kw67S8ptOlTvKvi3pIZm8ciUXQvV9nkQTi45ZGm7gjYBj+w2Nvi2SCnrwLrDrffe+4lCgfs5xaWicAAEb4QwH4FM9ld75znTr9eENBgZR0zuj4BLkUtxco3wTTM/0b2tfWC1/KK1Hcp27Ywu7JwRv7hCReDbrNRB5F4zSbvn7X2Emnf1YULEnbV3gf8SLy7SPdQTY2n3H1l1/AONwx+mdziRzC8MnvcBTdVggX4Ryb4vnw8dGhQyk3fLV0uKOjoGtCnnKHGyRNRekkxDo=
X-Forefront-PRVS: 0920602B08
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4451;23:LGZ7HraUHm5tsYMa28WETn8jJ2byZ7/Wi+rSHP/gh?=
 =?us-ascii?Q?U8HXOTH+peuGy4m+yDXohL0R1OAz6DeZCjz9hZKc0XFMSgvlgKFBGekAcugl?=
 =?us-ascii?Q?7lUkiQIU0uClLz6MpfM4RnOB9ehNLejMWQSwFKddSLaKBn5G+007Opng8yCV?=
 =?us-ascii?Q?z+8yMN8ZRV6cUw0SAOgWXwmOdiEF8b9b3OZyYMrR/bOjOuQVM1vh/ZeFEEe1?=
 =?us-ascii?Q?AwwA2m7JCuy8G6f9cNn/0L99oBd1EMldzWPNfBfCphCkEU8I8HVwepfTJd/Z?=
 =?us-ascii?Q?iYSGTnX/4CxvFeaSa9egI+GskwG97rzvDP4nkXFt+b3i79rMqzrdZi6h4duJ?=
 =?us-ascii?Q?nN0bJqbCI5N5tYWqoaMxGxXAdRVDvxP9exvV0WGtgKnoYjh18fK01mZ6NzhR?=
 =?us-ascii?Q?aEYMXewtFsOimpVmJDX1ljXSuVN55tS9rGxRn2PPEMuD2e82v+TpvRn+iJLD?=
 =?us-ascii?Q?6bwLlYbzRS292i6346WbrFCFo/wxrt17qLRz7uSzurUaj/wg0WsSySP9hNqY?=
 =?us-ascii?Q?nLrewwY1t6oN/Yk5GCFfkOgw8HG/UK+E5iooNxe2NsDRmVjUNqscsEJNOaPn?=
 =?us-ascii?Q?podxibsP81uO5ekFRV+6RIsBbeA7O2Hg8MQBCEsE5bUZfkEjt5v0NETsHLNh?=
 =?us-ascii?Q?SmvOcltsIc5beG5VLsMMLKnja7UWdYj8dD/s8K+WTDhcbQNe8cSkCQC/9WOj?=
 =?us-ascii?Q?ln+n0aAcWo0jlTOnXfF3pvFeoCb7EauZmEwXQBjWJTgK8ajf8O7wLPwatB0A?=
 =?us-ascii?Q?tAAncIlNpH2gq0P8GRA9+zyV+DMImf6RVZl2lR5M9DmAf6tpEVqKw6JWn8r5?=
 =?us-ascii?Q?x8VzkbxPe+ulwQncDFx43/Eov+DCJjvm/PjkZ8yAb3L1MIhgs5AzYEuP3cc4?=
 =?us-ascii?Q?jgzHZ+6UUKAANmc9nQitXEocxnnJbNqhELWZ6ZXnpeRaYGEAFaw9LpNNIcSr?=
 =?us-ascii?Q?pdtaF7T/v/GBTciiHyGsH5RLM2BgYIYmJeFeNmB6h49OVjRA1WKaGqSaMuGI?=
 =?us-ascii?Q?x5EwmwvUleuNuSNbbM3CWT4RDqIYD3S2V6JJpWmc2PeaIoOpunRhSy9GgJYU?=
 =?us-ascii?Q?M3nq1zZTtGhh6qmTpRd33UjX6cOIdQW1QfJdZtaJ75r43taTWrpysucu8+s4?=
 =?us-ascii?Q?aeZTHsoOWs7ZNuF1S2wyPsMPEKsadsXhIVDsN3yguvhn91oXCuN0azu6xcY3?=
 =?us-ascii?Q?GM1kPYo7oiZhOGPo4CUWxBmRk+1v66o87Mo?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ZNM+YKxFi7mnR/Ostm7AU+ToPzxGw4g5t0xNAmGRS2+b4JIMF0QVuiZNKCw9B9l7liWwrMp3zmKiCGflfuXCsmShJtOII9MWnpLsCsZv2WGaFdJdI8eunuEciEcGysIhaUxoLqvNNWp2qo+9VIkoBN7GjAkUev6AT/gi9q6ZUKXusQbyEnbb7XtwEk8YlfYaaJxVNja8cC+ppwUPH9M9XCLDHHPgFVi0Wqau2SwsWmGG2kb1cmUZa+1VQ0PID544CMJ39tLBJMCyGTctjfNpCh19HCMCwiN7bt/ReodZEFmSXOg85bvU7LEm8rZhIdqNqcDDB7UGfQ/NZOpSt3URA0/wgk6r97A2YXaZXfGeIftK09mZxmtBPv1mHjn2B2yry7qcFukB2bVipTVfuYole6mpYOo5HbOqtNL8zHnQIRg=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4451;6:7BKd55JmiO8cloOd1IeGfypXXehLcsc8FDWCQntqqqFnsFF2s38InwpDQ2HgjEUBrM8HVahWWzkn0xvi6NoXBhnBy3G+GjgyGatc4d7+0Y2p9MEUoQd1N9A28M9ocfeT2nVk3Hf7kmOEMeYiCy5BuBr+FBJhG0Gf0cfW9/2bHLXNYA05aVmPr9dw7wUemXyXMzb7yPmZw7GvTVbxJo4kq7Vf4/ixU+ZSqOT7rxz8V++7FuVrEvv1wjSZrC6UsrVmAvN9UXPWpKttPGX/LGd3i+6TQ5GKjjMSlChAI9mt8g4HUkS36yfUPOJuI6dHJI5/55qMp7SGyvRsILRP9gVZcetC+8yOKRqKA4BCDIasKAxXzwtiniip2xskCyMbXxCod9xBHlBMAYP7RsGFZfV6KUoKjB4LTPWIdtRuBvCeww1PVMkx69J8FrTncj/H6Oy9EBYPb3EKIXl2CxPn3KRNkA==;5:j/sLiVtmn+RBxmfH+timGuarD1fLXX4pOeTVcLx8fYSwS+s9kY5wdp5ez1C6ltrQ4TFgmsaere/EygrQXSVy3IvrenNSIA8GtgBU1pZVLtoDNq8Y/ItPygX6TYmwRGFCEnAYbObgouH1SdmuT0C7aFuBQSC/N2VRaAPVV/aSA7wrr/B9WhrC1PNZF463wmcdKw2//aoGLbEZRe61DZbNgw==;7:STY8LI92CiMpQcdhCUsEQfwBXO5MkUt/+Dqyd4reOB913+ErQyegUqr/uGN57rpmHVE4aA54j1gGyorkY7Bejv400Kzs3WO+INP148V/jamHfGtwPNvlLlw0QIwbP7xIxMMVoovgfc0Ch4WXUG9WSg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2019 07:02:41.3998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 256f31fe-9cef-4a33-fc72-08d67c49c5fd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP AES driver
bindings.

Signed-off-by: Kalyani Akula <kalyani.akula@xilinx.com>
---
 Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.txt

diff --git a/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.txt b/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.txt
new file mode 100644
index 0000000..226bfb9
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.txt
@@ -0,0 +1,12 @@
+Xilinx ZynqMP AES hw acceleration support
+
+The ZynqMP PS-AES hw accelerator is used to encrypt/decrypt
+the given user data.
+
+Required properties:
+- compatible: should contain "xlnx,zynqmp-aes"
+
+Example:
+	zynqmp_aes {
+		compatible = "xlnx,zynqmp-aes";
+	};
-- 
1.9.5


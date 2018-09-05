Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841F6C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E13C206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hArFzlwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E13C206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeIDLtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:49:19 -0400
Received: from mail-bn3nam01on0050.outbound.protection.outlook.com ([104.47.33.50]:6848
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbeIDLtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toxJbTuKw/0TZObYKfazKaEuU9cKV12xHhGrAeN7TIU=;
 b=hArFzlwWq7ta894TzVaCDzycKElcZUcRYnxgPA9e4xgg2KRArSizYx0A0vBlgezlIcbDU2TWhb7mkf3rbhxJ4xleP1fTSgNGAxkQDDe8E+Pj9IjEs3wGi3MP9/yVYS7cMjBh1SBKVGwDBjL2O1ZagcJkIjNJJb/KwLrThbyMSbs=
Received: from BYAPR02CA0017.namprd02.prod.outlook.com (2603:10b6:a02:ee::30)
 by BL0PR02MB4929.namprd02.prod.outlook.com (2603:10b6:208:53::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.13; Tue, 4 Sep
 2018 07:25:23 +0000
Received: from BL2NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by BYAPR02CA0017.outlook.office365.com
 (2603:10b6:a02:ee::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.14 via Frontend
 Transport; Tue, 4 Sep 2018 07:25:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT033.mail.protection.outlook.com (10.152.77.163) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Tue, 4 Sep 2018 07:25:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:48085 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx5iD-0001RN-25; Tue, 04 Sep 2018 00:25:21 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx5i7-0008GD-UU; Tue, 04 Sep 2018 00:25:15 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w847P4Te015103;
        Tue, 4 Sep 2018 00:25:04 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx5hv-00086x-UN; Tue, 04 Sep 2018 00:25:04 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <atull@kernel.org>, <mdf@kernel.org>,
        <jollys@xilinx.com>, <sboyd@kernel.org>, <rajanv@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <chinnikishore369@gmail.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [RFC PATCH v2 1/3] firmware: xilinx: Add fpga API's
Date:   Wed, 5 Sep 2018 12:54:46 +0530
Message-ID: <20180905072448.12488-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905072448.12488-1-nava.manne@xilinx.com>
References: <20180905072448.12488-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(396003)(376002)(2980300002)(438002)(199004)(189003)(36386004)(50226002)(48376002)(11346002)(26005)(81166006)(81156014)(7416002)(478600001)(50466002)(4326008)(107886003)(1076002)(77096007)(5660300001)(8676002)(2201001)(186003)(446003)(8936002)(217873002)(36756003)(47776003)(6666003)(7696005)(14444005)(76176011)(51416003)(63266004)(305945005)(486006)(356003)(476003)(106466001)(126002)(336012)(2906002)(9786002)(39060400002)(110136005)(106002)(426003)(16586007)(316002)(2616005)(921003)(107986001)(5001870100001)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4929;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT033;1:qQG6vwMNANe+JhjQf4v1F/34itu5I0mO18E4m+z0DIb9tuYBnrr9KxkTzGUB1HWo9BK8frgNFV3sM5t4xsp0j4VZUGs9rUbBXyU4Ys822rdF02V3r36bdeeqfRFWhxED
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 783158ca-ed87-44f3-0a0f-08d612379305
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4929;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4929;3:/IyxUbaau1w6ln1hFze7b5GMmudnlRb1ek09pXRPfvxTiKNSsVQsV9UH4y3ox15+Tz1BTHE6+qX1odCesRZSmCbefePvTkTMZwsjpdoOscFUpDYWAhqBdaI/9fpwqYVkFVX/gz4TBZLoghWdgBmTU98Fsi+6fJU7pUJvQoh9o0yNk0tPBT216ntw3AfGg1zeaKPu63rqx7RlyWlbDeegJg+sWYNG5Wus1BIaA53XVGBR4DpF6dP4wTf6zhIe76NyJrwSInYk1XS7wIwtscSpaiH2iIczuc6mlVoxVylwxPkxD0kZcSs4CbKLI6az4kF4tfy6BwBMY2tY1VKSqgV4XsfkYGFhkSwQdxquAqVLCH8=;25:E+wnQQ3KgyUINTcdXAdYS1C0Z4vpwGSz0W8SBidqB99jrNZubaffkU2ARvX5jhoj/cc2ziOXFAeq5/PKvUGC+N0wsD+vI0W7xg2eeEx/Qo9ObtDlQQrBqDnJv38BzsqG7Tp7aCrlTqdERTFB63hHdjhkNU0g2u6pQz4TirEcIluzvCnrCewBIvCsNCIAf0ZFWEBsEUzGb7yf5fNzQGYdwZ9dF1zb1qCtp1km+tF/+7zprj4nJsBxmZ7r0g6OHf/J+e8JL+TRmBXp3PoBYASvdM9KRE0RMlJKOiPere7a5xyIVk2LVXOD04bVmHAf0ZSI6nUq8O1O08eUotdxOH7TEw==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4929:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4929;31:DiGiA+MEWorC9+YE0U/buIRMAgqsRxHOUv6WaazX4DB3VeVYdAtyYGlJSoJVEgJHMJ1c3mfiCrQegn6AJ15l22tbSIJsm/wmaRHrKyK0ahBaKAQ/RmnuNuYXFpEWoj0JkS8KObEQ2ccRcr9xSbOE46y46apH1OVaKcmy1titb41IGwgDQ0is/VG7Rp0XLbQSvD2cl8SKoKKE0mzYF6vEagTnFLYn75wOjROsm0maFRo=;20:QR0qccJEpV9Bhc1G1/Tu8AUoFoiGDUYb6LHJWNUWWu7Z47/cauNlpYEOVKf6Yccnfr4+hj4ehkUg7Coe8lD6Mm6uoCeAPbPCRy01Q7jeKloasDjmB8oeHe7KANWXT7KweCZj4sN72u2KeIoNfZp3dajc43EZraz3KrEA+vvdqXdXz5lmwo+b/eZe9kKVk41ZvmaabhN2h6FRfbjPVAygOTEuds9NPdzBC3vhLOqo0DV8BEloIXJEiNLyTuXuz/+Zet1jTrShkhIEwxg12vQ36PLrIsnNYn3DmfGDcjkzONIEt7wpN8ce/B/Z98QoG3BC8fmRUGbRh9BKKpJzMnxIwdGfMuRf1J+V7aU988DtOYjrHqaWNjiO75wEuUWZLz59NAy1rGICoY963Z7aiEIqg+x9ZedP1+1+8fDonFFneeTJ4GJFRWaYnigVVcCdseybgj6+DpzIW0hydOQJQ/IgXWRltOEmm4VlGNfpf+K85uXPYhdRtW/35sb+mG+ABJIl
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4929FFA14DAD6388F3463225C2030@BL0PR02MB4929.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:BL0PR02MB4929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4929;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4929;4:9WpL04jDu5Kyq9en2AJ1yN5eA4Xuvl5nAxnOfh9vkDzd9Yt4qVPDN0Z35PPv+TFCWdoXgc+0mdMEJj3O2yiBU3UQvH+uObj/zGMZMmxPu7dtln+Yd82myUNH8tLK9DSkdUSUhFU7Tp5POPA782xpV3e5/SBMMV63PZ8AJbrhwvyX+zZGvapoD0M6u1St0CTMahua8dkXzfu8Y8qgh/N/DkUBE3bDnKyr8/BOIsaWZi+HWJMRKOSs9J/R1xXRRuzqUNmqD2Hs0uoYQjD1Xqw9KwrVL9F0TOypXDDPsfpn+qf4jPAN3gstE/80XUv74xDT
X-Forefront-PRVS: 0785459C39
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4929;23:U85klemth30H/THEIeIoc8I3KKwQt0eP/WAhWphPy?=
 =?us-ascii?Q?+v7yyMqjeBGdyBSyY/pkpI1cCkQBVzkQCA3g7X9XMP9zdbNUKr58EhxI2/CT?=
 =?us-ascii?Q?kJLgDzbD2FtNjA0u5QyglY6xmjYAf9wBI1GMdsflGB/jFPSEX2BDqAkBb6Qn?=
 =?us-ascii?Q?6Kh4qVT91IJEKbBBIDDwC8sl/taP4XHSVcaMTyP8saAfGx4rReIAdcERBwb/?=
 =?us-ascii?Q?H0k22xWtAuEfmShZ1ndLOreZuaR+8BhgLZw3fOrFQ5QduKa+xKn60ma9Nhpv?=
 =?us-ascii?Q?GGLy4AGZx4/rxaYGcRCnJN4hYbeiTxCot1yM0w4pTpgAYDhIMfsamjL7HF11?=
 =?us-ascii?Q?kVib7UiipliJtYwNCtbiSF5QirKj+w2YMqdcEsYykYvXOWcOSvZE+yrpz1aM?=
 =?us-ascii?Q?ClkJM+JJ6y4M8KcCI55jNfN2RfiqQDUh45OS8n/zQLpTlbTRuvEHKL/UbKT8?=
 =?us-ascii?Q?PhM2P2X4PCte8zIK6qEcLd9pD8vY7q16d19uW9rmR/pYotI9i0kaj1ncbvZw?=
 =?us-ascii?Q?TxMXRL2d4OKVc3ayjoJUZ7YHPpnBazMNY3qOZKm9QIdYfNfn0+x/km6VZF0m?=
 =?us-ascii?Q?h/ieN91xWOeNuPdCK9NyZ0tstb14G78jaKu3XeFUbHtdxyn24Wls3FXg4F59?=
 =?us-ascii?Q?h+RI51QtSuEQLzM0o28Dx3HAF/q/EJJdrENeKr7Z7BjWv51DxQiDOApz2ymB?=
 =?us-ascii?Q?0gvke+mBcRZu0rlOm7zYZ+LGFkmV4Ny08+5wUq74hbAThwTeWexO3GElcZbB?=
 =?us-ascii?Q?aTjV2BblA3U5+x1a5LYngpzpiBvPwaWcoOSmrf9avWoE9O5BKCyCwgLOA5P2?=
 =?us-ascii?Q?d9ztfGMZ+9QWdOZwf9GEOVdrT6+qmno4ZekqezOZYYYLSJLvZMQO+3I/2EvD?=
 =?us-ascii?Q?ELFE9Q4W202xoNwQpyoeBUJBbXU5DA7DE3caHlo/PqIwDRN90IXB59xLOCC8?=
 =?us-ascii?Q?LukGw1lkIchkEAJGCReWvPH48LOlYR6qZ5Nr8IWACDoIS7D5nCT7BLOhE8VI?=
 =?us-ascii?Q?lo+J5Hv3EvZOYuwtPK6DPiQ4bEVSSjW/fOvVs9Ye8MZqEVuyKq0+SpNAXt7h?=
 =?us-ascii?Q?tnms28v1j8luce9mcETQRPIbFFNDD+fTmMV2my2E9OMfs9qApK6rheRjNzSb?=
 =?us-ascii?Q?N+jXuXJr4Si+NXcPCefGuabm+M7hV9oDGki28K3mXz4KS1wiVZ3TqAdpicKg?=
 =?us-ascii?Q?6V56xHdvHhladO33UoilLDNvDUJUnHQ0gcbNjbhkVmMtpJ1kt65G/gzsV4GJ?=
 =?us-ascii?Q?i6F6H+umQhF/wq+0lEHkW1ZSISIrkjLW/Mq999WNsrFetknW4iHaxkuseBgK?=
 =?us-ascii?Q?QeeWgKZGLpdItb5QOoGlDI=3D?=
X-Microsoft-Antispam-Message-Info: eYltKMV6H0pH3P2ZL7ua+LHlbnN45N42GF4zT2wmnyp8UuM+TjsfwegHA8chTSyB80IXZEg0vTXs8MSFOAKLOoEEmmsiFPSllycGFnARGd1+kqiquaASz8P+7GDHw7yWBz8/eWGjnEjrfRR4qhtCVVnuODcVN6hoRkbw+inMljhcIB+aphqcjburbla9h5ydH3fwepNpG56fsHyRSvSPHM/xQSj4hUJknT2EnpFig2p2L1nUlxZ0OyXGLU/3oQN5613G/d6Gedr/oiLH0ND9tV8T5zDl1YOKEcFHa7VqSA1bHl5MCWcMRyqdza/LZ3cS9QR4LK5vImTFH3ijGJ7O2hPrp95eVo3zhMkCOCjZ6+U=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4929;6:UNnaSPd2Cn3Q+tsYBHY6go2bPhgsW7odjuipG1GjeyUhlylAaviHzPkr1CIoTxTtjAwq1FiwUGlik2e/BQLi+YvBN3+W61ZNPSiV3hjsm1dMgom5xtRrTsfktdQ4Fl1T9NcVVAPPcDJw68SgLVm1ejRsuFXca7kZkLM3uTJB3+YkmLJyFtiG7uEPZ5DZBhpXSPp48u99ddQ37Ypwb53xxrmA7KB40dWzX3Cy3iNcmA0ASpJ9WGNFInelVgsT7ebfyaDEJlxU6IZEEEdparJQVrpEPjQHiz6a2TifwwniQR2rKRfFxO46iG/TsM5wOj9zkvFfd0IT/epjqSMpAIeJQJYFMsShPKGssBbejtLTOGK2EpQ95o3wW9k+6lqo9qo95rsfKQwTNKRQNK5cGsnFjN0+gwJgBIt7TyuB6QHqce3DTGFjlIZNb00XEDDQk1GvCtHkHTL9wISUqP6HmyEOiw==;5:D9R/lmwAAQmbbvZ3aBU8AtyxjYpB0dhTGkfu878ZoCPt6eJLADUJm6TBN+TMttBMZEFdhqCkVThi/RVF2FSEDxpjaEw1Xi0YaCrbGHMSuWb8sKi4ASiQXt1EbRco+O71DtOWvP+J5mY5yZgRey27Lj7qqU7tnrjH5hC6UHvR7dw=;7:2f1RWc79/GdA/w29wRhJs89qpVG6XhGVoVTEkEF1FL7NOMeNq80IkHyNSB/2h7d01rPgxy7fB60M+oempPXzxywO9vKSBWxHO3EQgvrUAZ2AWye5TdXg1wn2mTDF7SC88VZ0ODoXmSC8ZSU3DTpYGE4SEm/Idhs7gIknJr6wSd5GvwXbbMtAiLeWzdSa5hPp1EMuMQW9tTGOhOu40jlm5RXr+iS1viiXJ2B8ItF6HCce+OsclWDfLls+tHMjefS9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 07:25:21.6086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 783158ca-ed87-44f3-0a0f-08d612379305
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch Adds fpga API's to support the Bitstream loading
by using firmware interface.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
                -New Patch.

 drivers/firmware/xilinx/zynqmp.c     | 46 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  4 +++
 2 files changed, 50 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7ccedf083926..9b3a59512dd7 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -447,6 +447,50 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	return ret;
 }
 
+/**
+ * zynqmp_pm_fpga_load - Perform the fpga load
+ * @address:	Address to write to
+ * @size:	pl bitstream size
+ * @flags:
+ *	BIT(0) - Bit-stream type.
+ *		 0 - Full Bit-stream.
+ *		 1 - Partial Bit-stream.
+ *
+ * This function provides access to pmufw. To transfer
+ * the required bitstream into PL.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_fpga_load(const u64 address, const u32 size,
+			       const u32 flags)
+{
+	return zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address),
+				   upper_32_bits(address), size, flags, NULL);
+}
+
+/**
+ * zynqmp_pm_fpga_get_status - Read value from PCAP status register
+ * @value: Value to read
+ *
+ * This function provides access to the xilfpga library to get
+ * the PCAP status
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_fpga_get_status(u32 *value)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!value)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_FPGA_GET_STATUS, 0, 0, 0, 0, ret_payload);
+	*value = ret_payload[1];
+
+	return ret;
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
@@ -460,6 +504,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getrate = zynqmp_pm_clock_getrate,
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
+	.fpga_load = zynqmp_pm_fpga_load,
+	.fpga_get_status = zynqmp_pm_fpga_get_status,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 58a74781b51d..5a6bd5e58ea4 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,8 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_FPGA_LOAD = 22,
+	PM_FPGA_GET_STATUS,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
 	PM_CLOCK_ENABLE,
@@ -90,6 +92,8 @@ struct zynqmp_pm_query_data {
 
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
+	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
+	int (*fpga_get_status)(u32 *value);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 	int (*clock_enable)(u32 clock_id);
-- 
2.18.0


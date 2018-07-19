Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E08ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FEF20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="TIxHsyNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9FEF20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbeGSKsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:48:33 -0400
Received: from mail-by2nam01on0045.outbound.protection.outlook.com ([104.47.34.45]:4768
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727335AbeGSKsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9qoUpOg9ZO9st+BmqgvKZw1O9Rbwkwlel6/FXDGjqE=;
 b=TIxHsyNtn1B0xLbDgH9p8jL0kxfzTk7gZdz6DPjpZDBJMi+1q3RtVQihLaPQ+EKHSBSM9pfedypGfse9xmwn6YCzHyhxvPoD07In+PHcDG75vq+3lgtGU4uXCJq6COS2DHCkmHvk6Isg85wH4TJx+y0s5S8pEFxnIfdnODvy4cM=
Received: from BL0PR02CA0026.namprd02.prod.outlook.com (2603:10b6:207:3c::39)
 by BLUPR02MB1620.namprd02.prod.outlook.com (2a01:111:e400:525e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Thu, 19 Jul
 2018 10:06:04 +0000
Received: from CY1NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BL0PR02CA0026.outlook.office365.com
 (2603:10b6:207:3c::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 10:06:03 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT030.mail.protection.outlook.com (10.152.75.163) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Thu, 19 Jul 2018 10:06:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:43909 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fg5ow-00005K-S4; Thu, 19 Jul 2018 03:06:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fg5or-0003wa-Oh; Thu, 19 Jul 2018 03:05:57 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6JA5rV0015635;
        Thu, 19 Jul 2018 03:05:53 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1fg5om-0003vw-VU; Thu, 19 Jul 2018 03:05:53 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 2B20C1215B5; Thu, 19 Jul 2018 15:35:52 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <bp@alien8.de>, <mchehab@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
CC:     <anirudh@xilinx.com>, <sgoud@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 4/4] arm64: zynqmp: Add DDRC node
Date:   Thu, 19 Jul 2018 15:35:47 +0530
Message-ID: <1531994747-15196-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1531994747-15196-1-git-send-email-manish.narani@xilinx.com>
References: <1531994747-15196-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(2980300002)(438002)(199004)(189003)(44832011)(14444005)(42186006)(16586007)(186003)(48376002)(52956003)(446003)(305945005)(11346002)(26005)(6266002)(486006)(2616005)(4326008)(316002)(90966002)(110136005)(50466002)(575784001)(8676002)(2906002)(336012)(76176011)(2201001)(81156014)(54906003)(106002)(51416003)(103686004)(107886003)(426003)(126002)(8936002)(356003)(476003)(81166006)(36386004)(50226002)(63266004)(5660300001)(6666003)(106466001)(36756003)(478600001)(72206003)(47776003)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB1620;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT030;1:guSCVx/in11H55h9v8iT9JyZtsSRXIyNon0sAcNTQKyAqjaHugLSWI6ZudbJINACO330ahCMts0rh7DKz2SWtpiMXfXEl21jywGm4k8W5am+LAXgubkUrd7VyWY4tcUa
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 286446b6-6359-493c-bb46-08d5ed5f3c9c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BLUPR02MB1620;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1620;3:rpqaVfBQg8wu1xjWkzvxb7d3iY/mm5GBdi2zeH6JbfEyqPD9CFwt2eZUL/3h8VgKefTny7E3wvl+e86HSjyCYOsP4/Ly0N8Nr1baGgfv4FRrEMKTL+5dQJOhgKQSL0vifaQlCfQY2/u5uQgpDYhB9gHrvSu8g7ydPHNeu+zOzYwfPaoX5HGUC6BI7oiCsHZtCmJseHA36PWzM/yIT8NnSWI1crpT4QqBihYgPT82FVBEHBlRsDJDZB2T+g9I/gsZR3S1IjGqNJM6B3ezPZRgX9BriUsMKm/MBUew1AiD0BLWrG8t1Rcjh199ICXBS6jgIhtbyXYBIHgIb+2Xm+/YiI6h23wlbgENHD1KruCKHn8=;25:J3NlHpKCLBcc/5Dm2O8NccImDn6GldUQTbeDHBv7va3+U99pt0oBG6o0FKx5VMKGyuTnspTBERcxHoWhVv585W+QgyEpSStt2DiPwfrTnXtyPL4HwrzguSDDTiHH+N/rizLaVeuTMJXvMYG/pEEj/3wkZZlX38h0ayGlgrK7XzaXZOUOC2czZlP9Mk1Ia508kKsdtfci6Z/YqaHixFHwFa5g7v2tarVOe6oWucTG8zMEEbmLUYWjJWQ+miIt6fkmxo0jyDaYiwYJ9z66D7WlzunVSKfUwJQIqWs0Lo67vR2ouGLVYTrIYSr7wWpizoe/TWLSGnH7Ofo4aHuwOgkjnyVRfCJudqDiqSM7zJsyqXE=
X-MS-TrafficTypeDiagnostic: BLUPR02MB1620:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1620;31:gmnI2I5zjaReabWuQq8VZwRcoEXGX+ro3TNLFVFm+6SjOBq1gtWuaf0DK5FHvcBbDumceW1SgeNYKrOZMh7w2DLRngLQTMbIq1U9Vr+Sl2zUmGNC0M+wrGB/WWmll1IOPsn9+bqNWXL+7+88VOA3hNabnZML8Y1LaDGIcd97zw2xtBFCkyWlVqXz3u2Bzh4m3Sov0UgpPcTJVG/qyDIo/BB5OuQa0nBnHDKN6HvpMek=;20:8Y1mWGWXyYIlH3TmEAQi6uUFCfGYhiznaaKjT1QjpyLCtWML/TOb8gtReaGqmYZ3kDNRiarNoDmDkRIhnMXobjXNjDSEPVnEqoFdAyuhDgJSG3YE+NCXZGvTESS/QDAahkCNwYgg3u+3NTroGhAdJo1ngy/v+6NUvifWqFVcwTpgbf50D/Q0NgKNeJ90+7u1kJdDnU37oCP8XwMZR56zW1H98GJXruBsxLarP053BzAt6137OlaA8sLdCJBFY6AzMPiNMFknCldUWBYa2j8+veFPCaeo6waqGkd8W+mI2Hg33o5BHMZI89/XHNpD86w2tLaFWWswR5FAKSEeBXxi5l97RlJ7cJV2vowoJZ0h6y6XyUeT0TZcPkXUNL9BXcACYhZmgFCCFeQBwGf6c4fw/6K5axilD86CZWxHHDvpFFwNb4DaeTG9FUZyVbMQ2r5rT3EC/TU+sd0zfs2gBWgVfpbeNQZw/XBgAR6Bbt87HZXTXX5qLBs6sHwCcn1Wid7d
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB1620185F49BD8DA4D18D8D3DC1520@BLUPR02MB1620.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BLUPR02MB1620;BCL:0;PCL:0;RULEID:;SRVR:BLUPR02MB1620;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1620;4:bdqbPQYoc+dWnDIQDKU0aYC1ZutVRF/45myElceH8vfEgU5gkiXjrLZtW8UOMGrjTCmUl73hNSUv1ZtlE+Z5vSH/rLt9p+i0zgNdakzaJVr47i6kapzaUgflF/OqBK5bPM7KilQ1eI9zBGuW0C9TJsCy2NpumhlUY7PVlhp+VkWuQvzgKhuEh6u6Hm09tK/4oL6L3FYNdG4xTBBcnTq9GlbQr/GEPBk775BQZV7c7zfCHSKSU3p3qzLp7A3+DibntguVnEWDR6ujpXB3/rVYm6yJRHk+AYbqjgAHkwYT110g5OMol3tkMRGe4Y8a1Kva
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR02MB1620;23:FxC/FrtdC2HMZ5zYXZiGQdKOliAPGHzLICcqmDoRC?=
 =?us-ascii?Q?IMA46E4Zm+5LXfIjgdwTZRAy+jMQMr4yCFs2KcsGcIokb0vK50+uOjnXTAy9?=
 =?us-ascii?Q?A/nmK2ilRTXM5wQecT1/RFhut6B0YANz3d53nHfE76wFc3RBDEI5ENG2y++X?=
 =?us-ascii?Q?3nymD+j8D2KbGxrs9JsXlef48YEXEfHQGvr+7Rch2AJcfSI45r442LIR8fkd?=
 =?us-ascii?Q?XV+T70V4NWEHRGaQV4I6KbGx41H7QvODCo2q99rGTLLp8TAuGqkyDeJRSqHU?=
 =?us-ascii?Q?aDC/wGtmupygjphev2JgiDfFb3RrYoxpuux6HBbupG4xDEL+rkssjWbsIk/t?=
 =?us-ascii?Q?4L4PioA6aoSVFdE6fahPLjNF4n7QLlaFF5bez6mTt6e+/Xqa7MnvBXoUTe54?=
 =?us-ascii?Q?eM42SfO4Y03yRE3dNg97JnHT0rez6CmXEnYF3Rp6ifePyHzekAPe37LdIlDK?=
 =?us-ascii?Q?mia/orIqwC45W/L143GpNHR5HSdX8awrPjd3tak9gZqUjDbF4iKlvIf1eXk9?=
 =?us-ascii?Q?//XGHP3S7qgUP1x7Ke2zXzcsMH1v2dn9KjX6Lp1ronBhMUl42gcLfO6qjLCL?=
 =?us-ascii?Q?JxpXgIM5SFQ6icOPhcovo2rV49K0hTFF9DoEfr8syVJFrl6+RAq2QuwNnyv2?=
 =?us-ascii?Q?CD9NmX2bpBSkQz96NnXz69uV2vm+LIunfVJ1OeMODMYqMyV5T47qH9JSSvfr?=
 =?us-ascii?Q?KU1WTcfo7kYsnDicl9ijR8NpoovGyxHeUg5AZYNYuO9oSlug1MLX4+TQ9N6F?=
 =?us-ascii?Q?LGyw+QSr0a+tuttvcUbFtMwuo2NHE/uxz8tnj+cOE5htzJX9xNhwuRogKKOI?=
 =?us-ascii?Q?tcBd4X3T9NAI5fNigEIlSLTM0LdjtvOyOHewNK41UzgnhfHPltB3tfMJkKUn?=
 =?us-ascii?Q?8NoDzycmGgK2CDD1V76xwvObCeSuIlnFdUa2uTD7mjlQP4oGkLX6lnr9HndT?=
 =?us-ascii?Q?t2FRzLF/NvKtMdPih93o22TghAT5JyXbnispVgqY+iRfMAX8B9wi+Uv6VaSE?=
 =?us-ascii?Q?LjMggTbQ2qA1UAHaM1qBeS0Extgp8AP3qD2s48HXBXEdmev51Ntmw/xNihE2?=
 =?us-ascii?Q?kF6q4Y3CgZxjM0y9KFbf9cFA5JX8Ec9/6V2xIfGLy9lPW7Ps8Owr5e2qM2qp?=
 =?us-ascii?Q?AIBqzde7t3PeSEh1DccJnB1lXZg/QMtR3q3Pr5hhFia7n9PHIcLGib8OhghI?=
 =?us-ascii?Q?YuFtFvBojv+R4BgeIfp56XC/ygdsqJ4U4UiJroYWCJ46wvBFIAT4MfjR42yt?=
 =?us-ascii?Q?i4YQl8wADdM25ft7AY7U2rSFojSvDPImosrmKVoVW/n8XKMTOzXnU1MjuQRa?=
 =?us-ascii?Q?vz0KE/OTxflx4AM+HH6YkQ=3D?=
X-Microsoft-Antispam-Message-Info: YYoxeh5Afj7K0SvpngT9DE2cek7PFSmsCtktiBW9iZ7M05szqUm3ekFQ4oapZQoNUQ0+6ZdDteyHLiT/NkHbYMfkFNEegnvqZBQZsVYnYz1TRe6LbtUbU0oI5jEhyVHlK32WHqeg8XIVP76DwdBRO2y5tG0GIA3ythfb1CkqqSIc39AkZA0RBXgFhBeWkYYrrkuHJCjREcG/i2l1jqtO1Zuz9PsRdGTcxfGnPylo54nZGHVYj19fCaOsx1V1mftCKB3gjvXtW3oLFLs3++lDn8NOVwCzGPj7a/Ft0vhBEInsnRDg/I8ni1EovmX0qb7TcAF9pl+WE4Rorfx1CHMzNBaakUZjocvDMAQRM1eg2VY=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1620;6:c+5X/tERjgK+01fodTMCs5v6mdqTAV2NFa6wrUsAZ5Bpn3kCDpt0w84Ihy0SlpuRpOh4LI6hBsVq106uaJy6mmH8hjQdShx/5V8aLQYMO/t1jwXP5//TQrduFzMpvDS6sVNeGn474psD8qezYtPjBIBYkm/wlGS9I/D/YekJoOO7RYjMgp0t4KNk3WJe97JE42mS9sOE457Eu9XdQMQQJn3Hb+FlEp/z839P6gmyFlWALVzc/Ecl0RWyijEoBjF9jR0YF/2N+/qKW4FnfLcOCgZGW4wdqDXLqtpW8nCPkilyLJuQNOEsFRkI4VwdyOSi5XTgVuLDLV1Fzf8ZB/DYV/YBXYB9e0BN1fpMcPQszsRV2Uve4LV5yj6+SQ2YSHUagEjqPzdZ8k2eXPcmi5HDRqIXoDcZgTersewYohslNR1hqrO0f8kc+XfCWMH3sS0P4pt1Q3ERSgpbqA/S9dv58A==;5:P5PbzmDVuBQTe7NliuJjSKs8e0sfSUoreuc2V3icWLo1JQb2J4/3n2nby3HvKzpnFeKm6lc2AX7GlAKuPjNG5ISPdsxUbQ9/DTDKfn/mc1kiJW5FSZXhbyuIXoydonZpUqBbaPt2gS63/47K5/qQmkKltiZgZ069k+09rkhu6RA=;7:fwfzPjvo2qcEHG4uTD95zihVvvmKrLe2JLnRBhYkTd7ya/mCB6mOnZoKnJovPZo+8HA+IMotIYIPQsl4uxzAuYdjtC/+5smg4tUPpDIFYopyqdyvyjP0jQWYDE6SaEvqqDsk5X/4Yub5ji24mToq7Uz3KlRMHNC5fRYTlYiwPJ5wqsYqmypLH9y6yVtdkIJ3Mdqme2OPBHjFaVWxoZzFZh08dbBeiUyI6hzkgw7NBxJdC0LyZKoV2qO80l7WpxXt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 10:06:03.4092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 286446b6-6359-493c-bb46-08d5ed5f3c9c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB1620
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds ddrc memory controller node in dts. The size mentioned
in dts is 0x30000, because we need to access DDR_QOS INTR registers
located at fd090208 from this driver.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index a091e6f..7d6a3cf 100644
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


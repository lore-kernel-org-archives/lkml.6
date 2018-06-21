Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718D4C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108B020883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nW40Z221"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108B020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932802AbeFUGnK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 02:43:10 -0400
Received: from mail-sn1nam02on0076.outbound.protection.outlook.com ([104.47.36.76]:34836
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932564AbeFUGnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 02:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVRFMDaLrQWmko/b8lDIqGONMOpiKooDBze8ts5SFZU=;
 b=nW40Z221Du2U7r9E1EFFNZ3mfC1xQHIyc4Qo8aaCAznfL/dWT3m9EOzy4SeJJMVlSQq5IwRS1soaT7I/dgGzHptPKbPaQBARzD+OEoYN4qN1LNwgW9NiRhXjEGJ5v5HmwZxXZQX2Pr7MSsEEtL+Lps776MXRkw9sNHuELXDuyPc=
Received: from SN6PR02CA0026.namprd02.prod.outlook.com (2603:10b6:805:a2::39)
 by MWHPR02MB2655.namprd02.prod.outlook.com (2603:10b6:300:44::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Thu, 21 Jun
 2018 06:42:59 +0000
Received: from BL2NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by SN6PR02CA0026.outlook.office365.com
 (2603:10b6:805:a2::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.17 via Frontend
 Transport; Thu, 21 Jun 2018 06:42:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT012.mail.protection.outlook.com (10.152.77.27) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.884.17
 via Frontend Transport; Thu, 21 Jun 2018 06:42:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:53662 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fVtJ3-0002Sc-6p; Wed, 20 Jun 2018 23:42:57 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fVtIy-0005wz-3i; Wed, 20 Jun 2018 23:42:52 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fVtIt-0005oY-Vi; Wed, 20 Jun 2018 23:42:48 -0700
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <f.fainelli@gmail.com>,
        <mmayer@broadcom.com>, <rogerq@ti.com>, <ladis@linux-mips.org>,
        <ada@thorsis.com>, <honghui.zhang@mediatek.com>,
        <miquel.raynal@bootlin.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasureshkumarrelli@gmail.com>, <michals@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [[LINUX PATCH v10] 2/4] memory: pl353: Add driver for arm pl353 static memory controller
Date:   Thu, 21 Jun 2018 12:12:29 +0530
Message-ID: <1529563351-2241-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(39380400002)(346002)(396003)(2980300002)(438002)(189003)(199004)(50226002)(47776003)(81156014)(63266004)(36386004)(48376002)(81166006)(50466002)(426003)(446003)(8936002)(486006)(476003)(126002)(2616005)(39060400002)(107886003)(36756003)(8676002)(11346002)(9786002)(106466001)(4326008)(336012)(59450400001)(26005)(51416003)(7696005)(77096007)(76176011)(6666003)(110136005)(2906002)(106002)(7416002)(575784001)(2201001)(54906003)(316002)(5660300001)(305945005)(186003)(16586007)(478600001)(356003)(107986001)(921003)(5001870100001)(217873001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2655;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT012;1:nGmzOG4DYC7ANCev1Oqu8eY7ssxJwBTyYBMUhgRT/cONEmDgalfKXlYX7gPODYiBl+mzRE45Z+FADD6r65yM2Ym1xdyOnPgnF3uGL7ztS7LvJk3PIYpL5eIy/JLBPOA+
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5f083d6-5c91-4852-bffb-08d5d74239e4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR02MB2655;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2655;3:zDo6uRsJPiOnDy3xbHU15Y5OUZ7gMJtkDcTokzZ3jDU1WpcEOhlczR4miEipWZ7phNlksmgE5/fTN2AxLngi8uuLc7h5Yqf9nJYQh1zgHPfQF6XN3is0IEBdgnnWQ7xrxPtERfRxAkN9F+Lv0931fWVrD/TGh8UbtVY/Cg1iotpanDfeNOtKChEjYxjsS4KPmOjA8ZMYiLSYWHM/fZTws0R94vFdcMqtF5A4tZtlfXKn82qnYYunlzVwoXdtWW5CrocD3DMRbCEfZFoJ/wT0M+PfypdZCCaJzuu4czvuTm65oI54BjMRqsEoUHSwEfUus4J3LwufqAM+xqSHZ5qWO/TWEQUH3D8AwXpQRof/0Z0=;25:qCegB245RcWvcwyXalWTXymQeQeh2xaGVyVZWzI6irXqGciCXRqFCDbO4dv2HAUoR6+EQLRmDInaRJiK5Eg/y/Pj0EJM47VHWo/9nnpgEYPNnnswzRx7oQOhB170/9EoGWb7aZGYU3KY/b6MVXpLnY7K8Nk45z01iVVJMK6yay1F9x6U8569PwQA2LkQzLnUutQhzTtaHkyaYU/XQvrtv3OU7j0sNVwXGpp7Gqq3RXv+5HSQgcqlNtmpc2xpdrSMY0B+fu+YmwEqlteFRjsJPqZgkA8cYLEUXXHh6z8VQm9140/wbgIBcthyvPC8/jDCff7KOmKPIs+Cl5AEqCgpHA==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2655:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2655;31:h/vMGRXZ6l4iLqfFMdipIRyWBY5r6xDP9jvoKz/7dxJ0Kqm1mO1m8WB6LUd/Zx7svlurUBxIO0dILpDFfx+4uIR6qUi3jOwGrikz8C8YHYH2b/mlwcXDijiUGE/7nwkGGFAYgMzdN0yEpQ4R84C9sAu35zWvsUiJStS7EAmrZ6tHl3V//EUL9Eu4nY6kuBEdJMdA1Ofa80lmnE/fYMTGhRmY1tKTgK9zgXCtvfBIvPw=;20:CBZbbrDX3GklF+rds8blhukh/iD+ILvJ2CH8IEi4VqfqMbJG0GCFy3uJzTa6K1NTYl9kuEkgYOxsR7D3iKYqgDzoVuWDGRH1V1/NDLdvu31Hg/PTcdEOE2diJlTTzMhKun/Vz9MC1j4kk7LWnAVlTkNQ+yFn37lFXY8zKArRKu8fpzWmjQ9SnxFMt2/k6/WyjO7hQ1XuMJiTu9yKuigegFuEJHawLa1Fb0fC5K93JKKY03oCc/WYKLmGJiuMt32dYi98IObmDIeLJ7BwAwiIi8dv512lNIA+G4MAJpTvhhFcqJdwmT0Ca8KcPde9PRKrGTppRBAVxFypaKsepFfzVM8zriBAKnSTklAohaf7e4+PumglsM0hbOYGXonEhgMRYBk15lz3RPPNyk5zVa2ril0SrBxJKj14zRD4mme+3KZDLhCzqlMBubjw7Fq+YIg0iTRIwZZ5xzz2/Lca4DwK9ZRPxtMxgBwhlXNLzfVXl8V39nz4q9g31emjLwhhuW6z
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB26558E8D670391794BCD0532AF760@MWHPR02MB2655.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2655;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2655;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2655;4:2C4SJxI6rCEMiYRD5htKVqulU8KE0UO8dV9oNV3zAJjujX1c/6PtbnYCsc/EaQ7OgLJ3iOBjsB6WNNyvMREbHpjOFKI+CASehfqIYTIuQpPUX6Va/xhfdd+QolhkdnLRFlrlCJLSmTqUGFcXmFxBPo9fXAcucDO2Jj3t9XngqysTAx9jWriyDosSYw132t+59U9mJxO0xXsw95GMZ4HlsXjxb69D94gQLNkCDxBsWDdKFS9Mh0KLiInsxafTPKgCsiomCDG9dChWby3E7EaSGZ9ZQwgWFJrRvlX36ggPJTVvwz6b+TmHqnQR8XxevyTn
X-Forefront-PRVS: 07106EF9B9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR02MB2655;23:9rTEDzqMKj/rW04CkQI//L8tMY+ibXmEMdLfV4uKk?=
 =?us-ascii?Q?8U9qWsadRG5yWKEuSeDXZBuJI9xW4s7+i1h7GHlriHNwlrBA18ecpkohqu+v?=
 =?us-ascii?Q?LwNDCJuhRs7m+ofMcJ/gLnG3MTlLOH4ZypfYgnHpOzHtCbIwd53AmAjH4flt?=
 =?us-ascii?Q?IzIYFKG59XnLoNMBXyFcnVzYy1evcf6L54d1c2Wh8TmYITjXM0I+kb/ozdcu?=
 =?us-ascii?Q?iOqaE63AptOcpqJNwBYtc1QVKRmjKNFYRxI9C6WhybXnTrFEgMnfZ/FIXQ6D?=
 =?us-ascii?Q?Du0FQE+Osmuow2Rrsa8saMsNwahmST/wUpRYBqIn3yDsBsuLXSa1VrYmtn4b?=
 =?us-ascii?Q?3nzfcjpo73Eo/ieKC8z8L34pB3Gee/vPjxWT4qxsvRYlr0hVwNMvP6RABimH?=
 =?us-ascii?Q?9JZPNmIj5NbmA1CwckmuNZ1mwRngYuuvwm4A8wnH7fCls5o/bipOoKA6FmpY?=
 =?us-ascii?Q?SGutHoz17C5hEty20TEEioKsd4BZSeQ9ldGNnk7qAEZQNFhA4ekzCN8FFwQN?=
 =?us-ascii?Q?zryBi8M9xqxI/feYaiZTq23rahoLW2c4sXFcEFpxx9YDW5YucZyOE+CJ3mve?=
 =?us-ascii?Q?QRSqLQoPXk9PpcZz0B6CkyOLsnIYG5rlqTLvb8y/80Ym5T7vvyh6+6ZTMEse?=
 =?us-ascii?Q?eXaudftgVJqMxXWygAWR/Oy++EJ+y+aUg9Le0QrhGIc9uQMRxFt2Tqe8cdIK?=
 =?us-ascii?Q?SoL08Xp8F+Jwdp4iOA6RJEilQ8YUisurLXNF+fX4vVNy7dIAyP/J1isRJIzw?=
 =?us-ascii?Q?sxGVL/H9ZXXl1GX67yAxKmc0/dYB5Eyp7IqGZEl0OQJWXT212K+LBdv4Zb6Y?=
 =?us-ascii?Q?+TDFhNhjIlrfOs+IsRl++1ORXbGAG8+x+3zSJpZ8RYr4scTmDhne5c5o/SPv?=
 =?us-ascii?Q?RNHMhvAKR+kaTA8Lsif3Kk/rDAxG+XqVNFKso9JMY0ZlcSfpA9UaMX4e+LjY?=
 =?us-ascii?Q?W0BQdBju1iag8a6l9yTw9HkbNfTAGQfT8/sAztlonKRjZ7FFXAZ6WT8Lg1LP?=
 =?us-ascii?Q?vfK1ZpDwHyZp9zzB+5L4JkxBxLFQ+R5elSnlPclJbbmMp4YQT6B75JsR3rRG?=
 =?us-ascii?Q?1BE5vbLx03PmzZwL9Nxa9RkE3GTLnJqLugDAako6wZOyYUqCkzwR934L3KCU?=
 =?us-ascii?Q?2100nklXaYYwSAKaLNVx2ItD6Aj9EmCdWFLh8pOFAXXBCWgbtvnUCl2W48qR?=
 =?us-ascii?Q?CfgdDFqPBJMUzJUYTUiEP2cWce9HNh71Wd5xVLZNPlmyDiuJG+RzLmbrAMwz?=
 =?us-ascii?Q?Wlsg78j+tan26SewqBNjlhKL32hQwF4zr74YgNreddNtL3yGUWOmJTVuciDx?=
 =?us-ascii?Q?cQO4bQcd2sORnbQxaqMmsc=3D?=
X-Microsoft-Antispam-Message-Info: OgO9KWvVIsZi32MVR4HY5Pb90I9Mv97egDVHngUK2FcJcYYZz9HXXRIoVJDSafWotbW+Xr41rdNWh88/aQJ4GKUta00uILR9413yBo2Iw7f5a9vUZWX6SXkhH8KokmkZvZGA0Guv9VAE0AqsriWGs2UvgX9ADQ+YWxPi9v6dLEBfUGReW7ayqvjJZIRyWmAPXUkHrP/FBxfI+IdCinqpZvvM+4QvCtlidUSqcB41szyFNLKOEe+OoVS+c+3eIYLbBAAaxX4ZO3WyC0t+jKlduF17VFNWY2fWX+zpU80FPUQ5NefA6C3t89hPHShDuyYC
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2655;6:ad0tycMyWFBSIrWZwXW3lQp8md7sSb+hapqGiLzh1oNYMjEOogo2hc5OAlX9cNmbUpyueUmenHVwKaHV+sPhjpGV6j9E6JOjTYWAG5zuEKBb5aIFvYFeTlaPZZZdQe8mLQtS9/etRXCbbifE+Lxdj2rai0q9+9qpC20wFlzX29rOdmsMss5f0eeRVXB/eFG/ZO1+ip+U5M0zE3Uy5gbutU2AydDnXFaKD6nTtMn4F2cijuKIhI1gEg07niNfPXmnJVKmf4auxrQGo8cRM6naao/eT1Po+0SL8jo8prMMpasC2NMp8wf/lBimOUq2EvEhG5ifk7Sq+/+ojIxZLV/xrG4Oi90i0vniDYJQDRYkeAqCnvhx0QawE83ewxupEfKHu+v5b9EEVwZZWHszHKg/A84b5qVJD+x78sZChtTpryEYpl8Iy66TOmy9ivvJjufbcPetuQnzsjfEEMYfrD6xwg==;5:wSmCrn1rcyhkgfgm0ioKgOcXbxuAvZEiQEmwAtU46ZDnBJFen5doJ6q4XZjsWRdcKCbq0hOS8TLE5uOcCG+yf2XvjdNi1pJawa1wlGGIYIgUKczZwgQpKxNE/IOdvie/3ndosExfaHuWXt8es2q6xM4rOIO7QodYJw0EJqICLbc=;24:CS6TBuh0AsI1IjziHhxhp6V7dC8nr0OeMCCpSexYV6hOKounfz+YPo3KBJbKqAP5qYqUuYgV7BT61lIo+tx16kgAHcsmosi7ADVxSHQQGl0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2655;7:gpHMLIOE+hFd8XjbNt3+uo3PEw20AfEH+wz4l6kWkjnbo4ljlpWp5rvJTCJifTDEHUy1bJhVvpC0ST9Ui3IaK/BdqTqrGZPiGBiXUFuifClStWxomYsl4sCqZXW8lStNn9pmkw1rmA2n8AOg4Jbe8L/vk65LheCBC5oi/7073GDDI1u6oE3tCLC3TjalCz2QXN2m9mxx+XbwnS6jLwFBEDNFrAZmHESPyWrOSCvrEQhpbGcvNslcEHELNNserpjb
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 06:42:57.8149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f083d6-5c91-4852-bffb-08d5d74239e4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2655
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for arm pl353 static memory controller. This controller is used in
Xilinx Zynq SoC for interfacing the NAND and NOR/SRAM memory devices.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Changes in v10:
 - Corrected typos in commit message like xilinx to Xilinx
 - Added SoC specific compilation check in Kconfig as below
   "depends on ARCH_ZYNQ"
 - Modified return type from int to bool to the function
   pl353_smc_ecc_is_busy
 - Defined Macros for values in pl353_smc_get_ecc_val and modifed
   the logic to read ecc value from all 4 registers
 - Assinged the timeout value in pl353_smc_init_nand_interface()
   after declaration
 - Added compatibles on another line and aligned the data with them
 - Removed pl353-smc.h from platform-data and moved it to include/linux
Changes in v9:
 - Addressed the comments given by Julia Cartwright to the v8 series.
Changes in v8:
- None
Changes in v7:
- Corrected the kconfig to use tristate selection
- Corrected the GPL licence ident
- Added boundary checks for nand timing parameters
Changes in v6:
- Fixed checkpatch.pl reported warnings
Changes in v5:
- Added pl353_smc_get_clkrate function, made pl353_smc_set_cycles as public
  API
- Removed nand timing parameter initialization and moved it to nand driver
Changes in v4:
- Modified driver to support multiple instances
- Used sleep instaed of busywait for delay
Changes in v3:
- None
Changes in v2:
- Since now the timing parameters are in nano seconds, added logic to convert
  them to the cycles
---
 drivers/memory/Kconfig     |   9 +
 drivers/memory/Makefile    |   1 +
 drivers/memory/pl353-smc.c | 466 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pl353-smc.h  |  31 +++
 4 files changed, 507 insertions(+)
 create mode 100644 drivers/memory/pl353-smc.c
 create mode 100644 include/linux/pl353-smc.h

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 19a0e83..19d5725 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -153,6 +153,15 @@ config DA8XX_DDRCTL
 	  Texas Instruments da8xx SoCs. It's used to tweak various memory
 	  controller configuration options.
 
+config PL353_SMC
+	tristate "ARM PL35X Static Memory Controller(SMC) driver"
+	default y
+	depends on ARM
+	depends on ARCH_ZYNQ
+	help
+	  This driver is for the ARM PL351/PL353 Static Memory
+	  Controller(SMC) module.
+
 source "drivers/memory/samsung/Kconfig"
 source "drivers/memory/tegra/Kconfig"
 
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 66f5524..58e794d 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_TEGRA20_MC)	+= tegra20-mc.o
 obj-$(CONFIG_JZ4780_NEMC)	+= jz4780-nemc.o
 obj-$(CONFIG_MTK_SMI)		+= mtk-smi.o
 obj-$(CONFIG_DA8XX_DDRCTL)	+= da8xx-ddrctl.o
+obj-$(CONFIG_PL353_SMC)		+= pl353-smc.o
 
 obj-$(CONFIG_SAMSUNG_MC)	+= samsung/
 obj-$(CONFIG_TEGRA_MC)		+= tegra/
diff --git a/drivers/memory/pl353-smc.c b/drivers/memory/pl353-smc.c
new file mode 100644
index 0000000..81bebd9
--- /dev/null
+++ b/drivers/memory/pl353-smc.c
@@ -0,0 +1,466 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM PL353 SMC driver
+ *
+ * Copyright (C) 2012 Xilinx, Inc
+ * Author: Punnaiah Choudary Kalluri <punnaiah@xilinx.com>
+ * Author: Naga Sureshkumar Relli <nagasure@xilinx.com>
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/pl353-smc.h>
+
+/* Register definitions */
+#define PL353_SMC_MEMC_STATUS_OFFS	0	/* Controller status reg, RO */
+#define PL353_SMC_CFG_CLR_OFFS		0xC	/* Clear config reg, WO */
+#define PL353_SMC_DIRECT_CMD_OFFS	0x10	/* Direct command reg, WO */
+#define PL353_SMC_SET_CYCLES_OFFS	0x14	/* Set cycles register, WO */
+#define PL353_SMC_SET_OPMODE_OFFS	0x18	/* Set opmode register, WO */
+#define PL353_SMC_ECC_STATUS_OFFS	0x400	/* ECC status register */
+#define PL353_SMC_ECC_MEMCFG_OFFS	0x404	/* ECC mem config reg */
+#define PL353_SMC_ECC_MEMCMD1_OFFS	0x408	/* ECC mem cmd1 reg */
+#define PL353_SMC_ECC_MEMCMD2_OFFS	0x40C	/* ECC mem cmd2 reg */
+#define PL353_SMC_ECC_VALUE0_OFFS	0x418	/* ECC value 0 reg */
+
+/* Controller status register specific constants */
+#define PL353_SMC_MEMC_STATUS_RAW_INT_1_SHIFT	6
+
+/* Clear configuration register specific constants */
+#define PL353_SMC_CFG_CLR_INT_CLR_1	0x10
+#define PL353_SMC_CFG_CLR_ECC_INT_DIS_1	0x40
+#define PL353_SMC_CFG_CLR_INT_DIS_1	0x2
+#define PL353_SMC_CFG_CLR_DEFAULT_MASK	(PL353_SMC_CFG_CLR_INT_CLR_1 | \
+					 PL353_SMC_CFG_CLR_ECC_INT_DIS_1 | \
+					 PL353_SMC_CFG_CLR_INT_DIS_1)
+
+/* Set cycles register specific constants */
+#define PL353_SMC_SET_CYCLES_T0_MASK	0xF
+#define PL353_SMC_SET_CYCLES_T0_SHIFT	0
+#define PL353_SMC_SET_CYCLES_T1_MASK	0xF
+#define PL353_SMC_SET_CYCLES_T1_SHIFT	4
+#define PL353_SMC_SET_CYCLES_T2_MASK	0x7
+#define PL353_SMC_SET_CYCLES_T2_SHIFT	8
+#define PL353_SMC_SET_CYCLES_T3_MASK	0x7
+#define PL353_SMC_SET_CYCLES_T3_SHIFT	11
+#define PL353_SMC_SET_CYCLES_T4_MASK	0x7
+#define PL353_SMC_SET_CYCLES_T4_SHIFT	14
+#define PL353_SMC_SET_CYCLES_T5_MASK	0x7
+#define PL353_SMC_SET_CYCLES_T5_SHIFT	17
+#define PL353_SMC_SET_CYCLES_T6_MASK	0xF
+#define PL353_SMC_SET_CYCLES_T6_SHIFT	20
+
+/* ECC status register specific constants */
+#define PL353_SMC_ECC_STATUS_BUSY	BIT(6)
+#define PL353_SMC_ECC_REG_SIZE_OFFS	4
+
+/* ECC memory config register specific constants */
+#define PL353_SMC_ECC_MEMCFG_MODE_MASK	0xC
+#define PL353_SMC_ECC_MEMCFG_MODE_SHIFT	2
+#define PL353_SMC_ECC_MEMCFG_PGSIZE_MASK	0xC
+
+#define PL353_SMC_DC_UPT_NAND_REGS	((4 << 23) |	/* CS: NAND chip */ \
+				 (2 << 21))	/* UpdateRegs operation */
+
+#define PL353_NAND_ECC_CMD1	((0x80)       |	/* Write command */ \
+				 (0 << 8)     |	/* Read command */ \
+				 (0x30 << 16) |	/* Read End command */ \
+				 (1 << 24))	/* Read End command calid */
+
+#define PL353_NAND_ECC_CMD2	((0x85)	      |	/* Write col change cmd */ \
+				 (5 << 8)     |	/* Read col change cmd */ \
+				 (0xE0 << 16) |	/* Read col change end cmd */ \
+				 (1 << 24)) /* Read col change end cmd valid */
+#define PL353_NAND_ECC_BUSY_TIMEOUT	(1 * HZ)
+/**
+ * struct pl353_smc_data - Private smc driver structure
+ * @memclk:		Pointer to the peripheral clock
+ * @aclk:		Pointer to the APER clock
+ */
+struct pl353_smc_data {
+	struct clk		*memclk;
+	struct clk		*aclk;
+};
+
+/* SMC virtual register base */
+static void __iomem *pl353_smc_base;
+
+/**
+ * pl353_smc_set_buswidth - Set memory buswidth
+ * @bw:	Memory buswidth (8 | 16)
+ * Return: 0 on success or negative errno.
+ */
+int pl353_smc_set_buswidth(unsigned int bw)
+{
+	if (bw != PL353_SMC_MEM_WIDTH_8  && bw != PL353_SMC_MEM_WIDTH_16)
+		return -EINVAL;
+
+	writel(bw, pl353_smc_base + PL353_SMC_SET_OPMODE_OFFS);
+	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
+	       PL353_SMC_DIRECT_CMD_OFFS);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pl353_smc_set_buswidth);
+
+/**
+ * pl353_smc_set_cycles - Set memory timing parameters
+ * @t0:	t_rc		read cycle time
+ * @t1:	t_wc		write cycle time
+ * @t2:	t_rea/t_ceoe	output enable assertion delay
+ * @t3:	t_wp		write enable deassertion delay
+ * @t4:	t_clr/t_pc	page cycle time
+ * @t5:	t_ar/t_ta	ID read time/turnaround time
+ * @t6:	t_rr		busy to RE timing
+ *
+ * Sets NAND chip specific timing parameters.
+ */
+void pl353_smc_set_cycles(u32 t0, u32 t1, u32 t2, u32 t3, u32
+			      t4, u32 t5, u32 t6)
+{
+
+	/*
+	 * Set write pulse timing. This one is easy to extract:
+	 *
+	 * NWE_PULSE = tWP
+	 */
+	t0 &= PL353_SMC_SET_CYCLES_T0_MASK;
+	t1 = (t1 & PL353_SMC_SET_CYCLES_T1_MASK) <<
+			PL353_SMC_SET_CYCLES_T1_SHIFT;
+	t2 = (t2 & PL353_SMC_SET_CYCLES_T2_MASK) <<
+			PL353_SMC_SET_CYCLES_T2_SHIFT;
+	t3 = (t3 & PL353_SMC_SET_CYCLES_T3_MASK) <<
+			PL353_SMC_SET_CYCLES_T3_SHIFT;
+	t4 = (t4 & PL353_SMC_SET_CYCLES_T4_MASK) <<
+			PL353_SMC_SET_CYCLES_T4_SHIFT;
+	t5 = (t5 & PL353_SMC_SET_CYCLES_T5_MASK) <<
+			PL353_SMC_SET_CYCLES_T5_SHIFT;
+	t6 = (t6 & PL353_SMC_SET_CYCLES_T6_MASK) <<
+			PL353_SMC_SET_CYCLES_T6_SHIFT;
+
+	t0 |= t1 | t2 | t3 | t4 | t5 | t6;
+
+	writel(t0, pl353_smc_base + PL353_SMC_SET_CYCLES_OFFS);
+	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
+	       PL353_SMC_DIRECT_CMD_OFFS);
+}
+EXPORT_SYMBOL_GPL(pl353_smc_set_cycles);
+
+/**
+ * pl353_smc_ecc_is_busy - Read ecc busy flag
+ * Return: the ecc_status bit from the ecc_status register. 1 = busy, 0 = idle
+ */
+bool pl353_smc_ecc_is_busy(void)
+{
+	return ((readl(pl353_smc_base + PL353_SMC_ECC_STATUS_OFFS) &
+		  PL353_SMC_ECC_STATUS_BUSY) == PL353_SMC_ECC_STATUS_BUSY);
+}
+EXPORT_SYMBOL_GPL(pl353_smc_ecc_is_busy);
+
+/**
+ * pl353_smc_get_ecc_val - Read ecc_valueN registers
+ * @ecc_reg:	Index of the ecc_value reg (0..3)
+ * Return: the content of the requested ecc_value register.
+ *
+ * There are four valid ecc_value registers. The argument is truncated to stay
+ * within this valid boundary.
+ */
+u32 pl353_smc_get_ecc_val(int ecc_reg)
+{
+	u32 addr, reg;
+
+	addr = PL353_SMC_ECC_VALUE0_OFFS +
+		(ecc_reg * PL353_SMC_ECC_REG_SIZE_OFFS);
+	reg = readl(pl353_smc_base + addr);
+
+	return reg;
+}
+EXPORT_SYMBOL_GPL(pl353_smc_get_ecc_val);
+
+/**
+ * pl353_smc_get_nand_int_status_raw - Get NAND interrupt status bit
+ * Return: the raw_int_status1 bit from the memc_status register
+ */
+int pl353_smc_get_nand_int_status_raw(void)
+{
+	u32 reg;
+
+	reg = readl(pl353_smc_base + PL353_SMC_MEMC_STATUS_OFFS);
+	reg >>= PL353_SMC_MEMC_STATUS_RAW_INT_1_SHIFT;
+	reg &= 1;
+
+	return reg;
+}
+EXPORT_SYMBOL_GPL(pl353_smc_get_nand_int_status_raw);
+
+/**
+ * pl353_smc_clr_nand_int - Clear NAND interrupt
+ */
+void pl353_smc_clr_nand_int(void)
+{
+	writel(PL353_SMC_CFG_CLR_INT_CLR_1,
+	       pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
+}
+EXPORT_SYMBOL_GPL(pl353_smc_clr_nand_int);
+
+/**
+ * pl353_smc_set_ecc_mode - Set SMC ECC mode
+ * @mode:	ECC mode (BYPASS, APB, MEM)
+ * Return: 0 on success or negative errno.
+ */
+int pl353_smc_set_ecc_mode(enum pl353_smc_ecc_mode mode)
+{
+	u32 reg;
+	int ret = 0;
+
+	switch (mode) {
+	case PL353_SMC_ECCMODE_BYPASS:
+	case PL353_SMC_ECCMODE_APB:
+	case PL353_SMC_ECCMODE_MEM:
+
+		reg = readl(pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
+		reg &= ~PL353_SMC_ECC_MEMCFG_MODE_MASK;
+		reg |= mode << PL353_SMC_ECC_MEMCFG_MODE_SHIFT;
+		writel(reg, pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
+
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pl353_smc_set_ecc_mode);
+
+/**
+ * pl353_smc_set_ecc_pg_size - Set SMC ECC page size
+ * @pg_sz:	ECC page size
+ * Return: 0 on success or negative errno.
+ */
+int pl353_smc_set_ecc_pg_size(unsigned int pg_sz)
+{
+	u32 reg, sz;
+
+	switch (pg_sz) {
+	case 0:
+		sz = 0;
+		break;
+	case SZ_512:
+		sz = 1;
+		break;
+	case SZ_1K:
+		sz = 2;
+		break;
+	case SZ_2K:
+		sz = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	reg = readl(pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
+	reg &= ~PL353_SMC_ECC_MEMCFG_PGSIZE_MASK;
+	reg |= sz;
+	writel(reg, pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pl353_smc_set_ecc_pg_size);
+
+static int __maybe_unused pl353_smc_suspend(struct device *dev)
+{
+	struct pl353_smc_data *pl353_smc = dev_get_drvdata(dev);
+
+	clk_disable(pl353_smc->memclk);
+	clk_disable(pl353_smc->aclk);
+
+	return 0;
+}
+
+static int __maybe_unused pl353_smc_resume(struct device *dev)
+{
+	int ret;
+	struct pl353_smc_data *pl353_smc = dev_get_drvdata(dev);
+
+	ret = clk_enable(pl353_smc->aclk);
+	if (ret) {
+		dev_err(dev, "Cannot enable axi domain clock.\n");
+		return ret;
+	}
+
+	ret = clk_enable(pl353_smc->memclk);
+	if (ret) {
+		dev_err(dev, "Cannot enable memory clock.\n");
+		clk_disable(pl353_smc->aclk);
+		return ret;
+	}
+
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(pl353_smc_dev_pm_ops, pl353_smc_suspend,
+			 pl353_smc_resume);
+
+/**
+ * pl353_smc_init_nand_interface - Initialize the NAND interface
+ * @pdev:	Pointer to the platform_device struct
+ * @nand_node:	Pointer to the pl353_nand device_node struct
+ */
+void pl353_smc_init_nand_interface(struct platform_device *pdev,
+					struct device_node *nand_node)
+{
+	unsigned long timeout;
+
+	pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_8);
+	writel(PL353_SMC_CFG_CLR_INT_CLR_1,
+	       pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
+	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
+	       PL353_SMC_DIRECT_CMD_OFFS);
+
+	timeout = jiffies + PL353_NAND_ECC_BUSY_TIMEOUT;
+	/* Wait till the ECC operation is complete */
+	do {
+		if (pl353_smc_ecc_is_busy())
+			cpu_relax();
+		else
+			break;
+	} while (!time_after_eq(jiffies, timeout));
+
+	if (time_after_eq(jiffies, timeout))
+		return;
+
+	writel(PL353_NAND_ECC_CMD1,
+	       pl353_smc_base + PL353_SMC_ECC_MEMCMD1_OFFS);
+	writel(PL353_NAND_ECC_CMD2,
+	       pl353_smc_base + PL353_SMC_ECC_MEMCMD2_OFFS);
+}
+
+static const struct of_device_id pl353_smc_supported_children[] = {
+	{
+		.compatible = "cfi-flash"
+	},
+	{
+		.compatible = "arm,pl353-nand-r2p1",
+		.data = pl353_smc_init_nand_interface
+	},
+	{}
+};
+
+static int pl353_smc_probe(struct platform_device *pdev)
+{
+	struct pl353_smc_data *pl353_smc;
+	struct device_node *child;
+	struct resource *res;
+	int err;
+	struct device_node *of_node = pdev->dev.of_node;
+	void (*init)(struct platform_device *pdev,
+		     struct device_node *nand_node);
+	const struct of_device_id *match = NULL;
+
+	pl353_smc = devm_kzalloc(&pdev->dev, sizeof(*pl353_smc), GFP_KERNEL);
+	if (!pl353_smc)
+		return -ENOMEM;
+
+	/* Get the NAND controller virtual address */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pl353_smc_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pl353_smc_base))
+		return PTR_ERR(pl353_smc_base);
+
+	pl353_smc->aclk = devm_clk_get(&pdev->dev, "aclk");
+	if (IS_ERR(pl353_smc->aclk)) {
+		dev_err(&pdev->dev, "aclk clock not found.\n");
+		return PTR_ERR(pl353_smc->aclk);
+	}
+
+	pl353_smc->memclk = devm_clk_get(&pdev->dev, "memclk");
+	if (IS_ERR(pl353_smc->memclk)) {
+		dev_err(&pdev->dev, "memclk clock not found.\n");
+		return PTR_ERR(pl353_smc->memclk);
+	}
+
+	err = clk_prepare_enable(pl353_smc->aclk);
+	if (err) {
+		dev_err(&pdev->dev, "Unable to enable AXI clock.\n");
+		return err;
+	}
+
+	err = clk_prepare_enable(pl353_smc->memclk);
+	if (err) {
+		dev_err(&pdev->dev, "Unable to enable memory clock.\n");
+		goto out_clk_dis_aper;
+	}
+
+	platform_set_drvdata(pdev, pl353_smc);
+
+	/* clear interrupts */
+	writel(PL353_SMC_CFG_CLR_DEFAULT_MASK,
+	       pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
+
+	/* Find compatible children. Only a single child is supported */
+	for_each_available_child_of_node(of_node, child) {
+		match = of_match_node(pl353_smc_supported_children, child);
+		if (!match) {
+			dev_warn(&pdev->dev, "unsupported child node\n");
+			continue;
+		}
+		break;
+	}
+	if (!match) {
+		dev_err(&pdev->dev, "no matching children\n");
+		goto out_clk_disable;
+	}
+
+	init = match->data;
+	if (init)
+		init(pdev, child);
+	of_platform_device_create(child, NULL, &pdev->dev);
+
+	return 0;
+
+out_clk_disable:
+	clk_disable_unprepare(pl353_smc->memclk);
+out_clk_dis_aper:
+	clk_disable_unprepare(pl353_smc->aclk);
+
+	return err;
+}
+
+static int pl353_smc_remove(struct platform_device *pdev)
+{
+	struct pl353_smc_data *pl353_smc = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(pl353_smc->memclk);
+	clk_disable_unprepare(pl353_smc->aclk);
+
+	return 0;
+}
+
+/* Match table for device tree binding */
+static const struct of_device_id pl353_smc_of_match[] = {
+	{ .compatible = "arm,pl353-smc-r2p1" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, pl353_smc_of_match);
+
+static struct platform_driver pl353_smc_driver = {
+	.probe		= pl353_smc_probe,
+	.remove		= pl353_smc_remove,
+	.driver		= {
+		.name	= "pl353-smc",
+		.pm	= &pl353_smc_dev_pm_ops,
+		.of_match_table = pl353_smc_of_match,
+	},
+};
+
+module_platform_driver(pl353_smc_driver);
+
+MODULE_AUTHOR("Xilinx, Inc.");
+MODULE_DESCRIPTION("ARM PL353 SMC Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/pl353-smc.h b/include/linux/pl353-smc.h
new file mode 100644
index 0000000..67b0f8b
--- /dev/null
+++ b/include/linux/pl353-smc.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * ARM PL353 SMC Driver Header
+ *
+ * Copyright (C) 2017 Xilinx, Inc
+ */
+
+#ifndef __LINUX_MEMORY_PL353_SMC_H
+#define __LINUX_MEMORY_PL353_SMC_H
+
+enum pl353_smc_ecc_mode {
+	PL353_SMC_ECCMODE_BYPASS = 0,
+	PL353_SMC_ECCMODE_APB = 1,
+	PL353_SMC_ECCMODE_MEM = 2
+};
+
+enum pl353_smc_mem_width {
+	PL353_SMC_MEM_WIDTH_8 = 0,
+	PL353_SMC_MEM_WIDTH_16 = 1
+};
+
+u32 pl353_smc_get_ecc_val(int ecc_reg);
+bool pl353_smc_ecc_is_busy(void);
+int pl353_smc_get_nand_int_status_raw(void);
+void pl353_smc_clr_nand_int(void);
+int pl353_smc_set_ecc_mode(enum pl353_smc_ecc_mode mode);
+int pl353_smc_set_ecc_pg_size(unsigned int pg_sz);
+int pl353_smc_set_buswidth(unsigned int bw);
+void pl353_smc_set_cycles(u32 t0, u32 t1, u32 t2, u32 t3, u32 t4, u32 t5,
+			  u32 t6);
+#endif
-- 
2.7.4


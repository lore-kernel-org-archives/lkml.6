Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726E9C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13AA32083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fQrM68YB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13AA32083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbeIGRzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:55:37 -0400
Received: from mail-eopbgr720062.outbound.protection.outlook.com ([40.107.72.62]:63312
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728906AbeIGRzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNMZer2qQ5E8Qc9LeUO9yPA5W4FIAWgHotzQ95m1rIc=;
 b=fQrM68YBy4usdoBRnZrzq4tRHqaiXwCPfyphdpYLS54ijrSJdoSfE/FL1vTqJ55cLFRmrpd7/E/UQcatSKjqg3qaQ5iSUZipxXpZEIoGdLbWH102XHABJa+ethCZhJMmPB+YQwnovYzTcZjKYIYAuJs0RHscHYv31lV9gc/0j4A=
Received: from SN6PR02CA0008.namprd02.prod.outlook.com (2603:10b6:805:a2::21)
 by SN6PR02MB4942.namprd02.prod.outlook.com (2603:10b6:805:99::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.15; Fri, 7 Sep
 2018 13:14:24 +0000
Received: from SN1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by SN6PR02CA0008.outlook.office365.com
 (2603:10b6:805:a2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.16 via Frontend
 Transport; Fri, 7 Sep 2018 13:14:24 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT043.mail.protection.outlook.com (10.152.72.184) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Fri, 7 Sep 2018 13:14:24 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyGaZ-0000KV-VD; Fri, 07 Sep 2018 06:14:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyGaU-0005mb-RM; Fri, 07 Sep 2018 06:14:14 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w87DE596019587;
        Fri, 7 Sep 2018 06:14:05 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fyGaL-0005lN-Fx; Fri, 07 Sep 2018 06:14:05 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 928BC60493; Fri,  7 Sep 2018 18:44:04 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v3 2/8] usb: dwc3: update stream id in depcmd
Date:   Fri, 7 Sep 2018 18:43:43 +0530
Message-ID: <1536326029-16327-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536326029-16327-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1536326029-16327-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(106002)(2616005)(52956003)(8676002)(48376002)(486006)(50466002)(36386004)(81156014)(76176011)(81166006)(54906003)(51416003)(356003)(26005)(186003)(478600001)(16586007)(316002)(2906002)(90966002)(446003)(476003)(126002)(42186006)(103686004)(106466001)(15650500001)(63266004)(336012)(110136005)(39060400002)(107886003)(47776003)(6266002)(5660300001)(14444005)(6666003)(305945005)(36756003)(11346002)(4326008)(8936002)(426003)(50226002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4942;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT043;1:/MkEyhfZg3r8+ERobvqnze7CwCNH0e5v6cSkAGGHGvFaVki0sW8ATEL0zlqOxJdNR50cbboyxIR+0fmxzOdrEtdlpUQWNpec3y1w96UdTevDpAKVKzsqwGm1Ufcv547W
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a95280e-d9ea-480b-d87b-08d614c3d514
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4942;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4942;3:z45GBrAh8DR7szXH4lJ82ZtgnIqOirhz50ELSOC4CE8f98VmdUNqqpH/xwFlTnzeNJyBCzuU74ouBds92UqCaZHLTsWEE0E4wjcLTG0xS6y7vn8J9pYYqZXCPBzM/P6gLsOpnLNvpKdE6XG1n/1K9QH5du73quvoSuwvRI6THGs/dAByABZinDJrhJl/rxi2R9Z6LUqSD4Oo7u3Y2gcnky3jF575edDqfVLC6gQocsOyxg0jyt8fsXKDm/VL7RO566ONeSm9tUCi3u+zJJOR/+yfxdpufSlaXjdNHUFmP9siACQ6IDC5zM4W6ZT3+6J9HteZ7DNanYXCDaRTVxvWILeP9MnFdTNhmh0BA5teGtA=;25:MTiKo48mytLRiSXH3BQLpPin26ooyL2gxyOsDiZPZzxS7m0QGV9CNym5Qom3jv92aq44HKhpj3B8FaKxa07HrwNC0L9OSFiYQWvL5T8gEJQuy/0QolYx8UZO0dqJJ9Xtg26Ne3Vn91tlsd/7GenHl+r1eLzJ7quzM74b54FD9KYjrfQbJKW0NQnsBYAdAFo+/hrQSe+2/O9G7OmdG55jayaBO5XR1SuHF2SESwzZrvQLKVptjLo04f0hISLJM2I7Rko9Q27NTI9FisXVoeSNw0RvM0bRXUqySL3qaNn30/Uw1Z/00P5SqqmPH8KD152pSOCgSEwr0IaCskBK8FLfjA==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4942:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4942;31:wOAtiYpPL23fammXs4KKE3zqdBOHJNZvKyyld5Fb5m2wMUdWRrts8ezx5DPYpEN0ey9ifvQDCbN0PEE+hIRBRrTR4CfnSA4DJVBAeJIhLuUBcws/wvBuRHs4uLxEm4WoXX2+E71ilozpnKQ3T9X1fQARH1iJCq89taBh1k6v3ulxATsTL8rc8uaAdl7EUJj/tF7t8E/geieyWtKhIf9pMf43Rn1XcnDXfHdNqPqjoAI=;20:pX+d4txZYDofnDBJQjoYKLx/5AYc3X6z3KzkAlVcRwk5iKGO12QzpTVtvr0mc9qC93aoEHg3ihIBMlaAji0vPcS72KTiLyu6/0RTgeo5fSKx9HxiUGpIZtmt3uuejMDw7AVwsWbAEOXp1Pew17OdH1olFxGAXP3KwLgqC981hQvSXHOJeX79CCdWkq+9m+nQf+5rtgUUDFxS+E7bhP0fYB2s8YwvI5UzU4BP/EmuPVgFk/euHTO7MKlWpFXW61Njx7tgrLFkG2Wlel/hCVNPc8l9XMnLLUSmBBT/yT+xafrOmUQjufikpXIMMLQYKW2pjqyqOngE7wmkGYRghsES1ysJQLZ6bOkocjX3YVO66ja02cjk19Koe1BtWQgOL/psH+d+LjciG7HX2pMJl0eX8AQ5+VGDfO8tp726F7F00Vc9qFskvXBbQAVkl6zr4A7kbtanLczqUngjiJ/xTi9iYv9RuJYwLZq7z+LbsDl6aEadvxiql7UXP6liL6F3e2Iy
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB49428A591872EAA687C0FE3BA7000@SN6PR02MB4942.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:SN6PR02MB4942;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4942;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4942;4:izMRI/BljFd9eXB7eBX7vKBUe50khdA+wEh2CcSkVik5yzk8Miq3u0fY8ATQ47aYyNoGld2YFYKrPJLtiNmxbd8ePg0mNe8yKyYDoFgDbHn2d4CDkjKCf4InuwFWo6Vc2jNHpTkXT/+xmFl11EG5LJrwFDEusac56HNBhG6OH4pb8LD+Cqzdu2gHiXecq3hImVW/5zmqPaT3rN5ISg7fCgp4bEpEF/UCUD7tTYo8f0APEkd1F7yYcwp/ZZNda8OXzyuooLTec2hAVccyv3gE4GtrZCGURxMMW4REFTKVSEi6csveAvf70e6kYWTJz7AO
X-Forefront-PRVS: 07880C4932
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4942;23:YDrjvFzdQF13DTlCkjL2mRjVuZ+MDFAL7HRXbR6XG?=
 =?us-ascii?Q?f2e1dl25SH6almqbIlyOFIk4+pm/qzz9aNTzK9HEQE9vk9+N8C6ni06IH3pa?=
 =?us-ascii?Q?VyfwIiv15dCCNEwmQHUm3CSmKKnbjiyZGaYvk5BgRC5XiEefmyDX6AB3CM+a?=
 =?us-ascii?Q?rQVGeWIDQ/RvC4XXfmQfOgOFy+uHV50wafGzv5hbx5CzEH0mhAHSG1paXotM?=
 =?us-ascii?Q?YyCTbOQVSnalKPlkKarMzZ5z6FWVP6+YAB8TWmtmSbGPAlPa5j9WXE78bcyb?=
 =?us-ascii?Q?/TzBnnVMI5u/rPwMGjSQQYFBIigLnmPcCeSZM+UFWIWZYboQoBEPLTwT7DkY?=
 =?us-ascii?Q?1e7c7sc4fomY+EdIsAps2IPaSpDDHeBsAB0dQFEuDI+GqdM9QplbJcPLEimI?=
 =?us-ascii?Q?XHqKFYHCaO3zSKJxM8xJB90vUdwCcNMyTr2sKDbbj1vqwwB/0Zg10v8m7H1V?=
 =?us-ascii?Q?tetX22i3Zihk2ZdhETbpbZxvGddUTEbjfb9AoPiO6XXQOSuO7cudKSGwgy54?=
 =?us-ascii?Q?IWLUEl4vA+r0P4zH0sqssy1UEyxY17Xw6591frJ+90wt8pyNCScHN3CdJ9mk?=
 =?us-ascii?Q?duO2SNq1MlsxGtV5w0DW277+P4W8VSIzj1GK56vjENSx8K+WkzurKKX3ESRg?=
 =?us-ascii?Q?Uu+p3XI1+vU9rAaQ7XmBHiHRHZsoZwzK9krkWm4r5lplpZ1XOykZ264FuIIm?=
 =?us-ascii?Q?vvNWL+tYo9fOe52eyg0IxLWtRgJl3j2COnjyuZiKBHLUAntPwzizDDjlzZn3?=
 =?us-ascii?Q?0IKGnS4kKU21sZhAYyYT50skvu+EhiZ6s9yBtcTDLI+VYUK1sk1piMr3ZuKP?=
 =?us-ascii?Q?0iujmP01RIcFc0PIpoGYVZkQ6se1CsNlSWJPohhivmD+I8lZj9YA2ftrONFn?=
 =?us-ascii?Q?YVm1HzD0ILNbflxBRmMbbf9A/T4fQNcgf7f726s6G8mOY+Qq0jaSAFZIfArF?=
 =?us-ascii?Q?cC7wn2Od0Jfg3xwQlyTOQ8gpIAll1E4tIvF1fNURfEQ8Pux3yVC5/MEyI4Ri?=
 =?us-ascii?Q?1GwGZV5wRkazvTnEAmhJBVgiAT4wEikFj9iYJxGbAQ9ziHNTad+5oqEatMMt?=
 =?us-ascii?Q?4EyTw1KUbhvmQKNLL1uIMGAF1zrStIriVia4PuHUU1/yxJfz7kJ+HzQ9HBy3?=
 =?us-ascii?Q?Bzc2vAmzB/qpU9TuR6VMankgGoy1tADujPzawDBTi5/9u5j6qLOQqsL++Wi+?=
 =?us-ascii?Q?EFb0PieLeFrxDevJwO3XkKty1VBJIBbdbP9/l8z/htfJUUbDRUbQEKxOg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: igDb4Oh+5oZNpVnBn9xm5EjQVUT1I7V9N+RrdVb/+fmiKZDHuNEKyux2aksMUG4MaXjyk2jDPhyrgL0R2oWWBKY/GPydIAV835oXdCXjjYxIy5bJ5PIYftznhywt1Lm37pXc+74sAxqdidcRTdNb1vtyU8Xd6QmdEkX3wlPpSnGCSBXherhyMXD3n60WAjXPoM0pmkNqa2MSWsxpfqPzCEyrFESHf6GPZHd9jeKsDTCxHEnb02A2e8B6pNYJ2jVY9J2OPnOV0k26ZnsryMLXcEM24q4/FZ/sbWVE7IabTqmaVUctpAvpOPixnp1UWxcEojOm8aWInaj4fJph/H64fi6DRekdMZkAZvujl8VG2rA=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4942;6:93WMDkaObRaiAhDRx3UAe2plYkFSdcA3qGrZUunvOYIgOcHM4hoiLXi6bompTKc1gY05KXOqWOsQ/yTi9k6w4nepvhF/1naFog3nfbdjOMz+xA+5+Mjx+ZokkKS9xYc9d+Wp0KvFA6Jl2ygPxcrsXKCOHCHsrFuR/SMoApzZ9kb+Zg8b4wAZKtk3qOqH12UISf9n+eDs3tuY+YfDMGdlK30fi/+b0RLWZxGxqpGMtuAshn0NdsGNoLgplgcLbeEZ86ZW0bTLBsDrNcCAdhlKFMpl7CVDoPIbX2zm/nz+eAoM+H9Ty2UMeof1T4/RaH85QcDHwoWCM4xk3DWJQbjaS/Q4QtGLppJ3OrLgt+/0SRiU0S17eXqUYMpKL4kUUBex9TRA258dmxZt5N2v2TiyG9YLg2b82mHX8Ot2EL1TY/9M/zXOh1oKsFrz1tMhBwX9YHaEw6HtzrbogE7VqsVmHg==;5:9UtHbEHQ1zC95owkQIaihVmj1/dR0rKj/4+760hD1vPZpxPB7bLnnnlyE+vKo4iKqzlUGcykYYHFDiR1jLuuVvjJNEset1oJt5eGLR4WaRFfBERyG7RoYctMUfVEYymcRdicu6aZxxPFuG9LG+EiG2iYr46oQ23GKhad3NeYZ3o=;7:ld/GtQgY8918MmDoukhZcj1xi7vgwVNV7mT0vCqYa4dvThYSgBk85P5SOaCaccYejzif4UN/2470IfvWcoW9TRpFNrEpIvzJGOb7z/xW8E0nNF0DNXshmZTQjcV9wKr0HdRwo/YEXgtV/3xCiVWFVM8QmFiBsZxQYYCgb8pMMWJI+K9NZPIrWu0kiv3BuWNY2dbTPQ9/JWqJ9BqBZ+Cqu5USsSrxV1U8nkOFyicE8qIprxrS2xgZlekk66r6Vy94
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 13:14:24.2782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a95280e-d9ea-480b-d87b-08d614c3d514
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For stream capable endpoints, stream id related information
needs to be updated into DEPCMD while issuing START TRANSFER.
This patch does the same.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8a1622b..43d63a8 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1224,6 +1224,9 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		params.param1 = lower_32_bits(req->trb_dma);
 		cmd = DWC3_DEPCMD_STARTTRANSFER;
 
+		if (dep->stream_capable)
+			cmd |= DWC3_DEPCMD_PARAM(req->request.stream_id);
+
 		if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
 			cmd |= DWC3_DEPCMD_PARAM(dep->frame_number);
 	} else {
-- 
2.1.1


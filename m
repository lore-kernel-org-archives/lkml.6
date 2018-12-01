Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23810C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B3F20868
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PI2GcbS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B3F20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeLAW0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 17:26:11 -0500
Received: from mail-eopbgr770045.outbound.protection.outlook.com ([40.107.77.45]:19088
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726736AbeLAW0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 17:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rp77tRHbshE6gM70tc1rZJIZpkgzi9aInGfLWErF23A=;
 b=PI2GcbS4jmKyNBeH/kJw5oOt5TlApB/jN4PwN4ltukur4ToXo9E2urMX7LKraYXMlURbHo8P/BpmS5RNkf3NSZAEW8YUlW4v3xzq7WxkI1KGxphxmN/PBIxAZFlEI/+motCNZfpp0FsDAkgbnhO0qfU3BXui4T7bJCPI+qxS8FI=
Received: from CY4PR02CA0005.namprd02.prod.outlook.com (2603:10b6:903:18::15)
 by DM6PR02MB4331.namprd02.prod.outlook.com (2603:10b6:5:2a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1361.21; Sat, 1 Dec
 2018 11:13:45 +0000
Received: from BL2NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by CY4PR02CA0005.outlook.office365.com
 (2603:10b6:903:18::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.18 via Frontend
 Transport; Sat, 1 Dec 2018 11:13:45 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT029.mail.protection.outlook.com (10.152.77.100) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1382.18
 via Frontend Transport; Sat, 1 Dec 2018 11:13:45 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46504 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DU-0005oH-E8; Sat, 01 Dec 2018 03:13:44 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DP-0001kp-Ah; Sat, 01 Dec 2018 03:13:39 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wB1BDZU5003409;
        Sat, 1 Dec 2018 03:13:36 -0800
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gT3DL-0001kG-IV; Sat, 01 Dec 2018 03:13:35 -0800
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id C0B8660504; Sat,  1 Dec 2018 16:43:34 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        <martin.petersen@oracle.com>, Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v.anuragkumar@gmail.com>, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v7 10/10] usb: dwc3: Check MISSED ISOC bit only for ISOC endpoints
Date:   Sat, 1 Dec 2018 16:43:31 +0530
Message-ID: <1543662811-5194-11-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(376002)(136003)(346002)(39860400002)(396003)(2980300002)(199004)(189003)(26005)(336012)(81166006)(186003)(81156014)(14444005)(36386004)(51416003)(76176011)(16586007)(110136005)(42186006)(316002)(356004)(106002)(54906003)(7416002)(478600001)(50466002)(39060400002)(4326008)(2171002)(6266002)(6666004)(48376002)(107886003)(36756003)(50226002)(106466001)(486006)(8936002)(426003)(11346002)(5660300001)(126002)(2616005)(476003)(63266004)(446003)(2906002)(52956003)(103686004)(90966002)(217873002)(47776003)(305945005)(8676002)(107986001)(921003)(2101003)(83996005)(1121003)(5001870100001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4331;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT029;1:Db++AxeXhQcH0cupZqho2HhaYAjR5/d0aghGK4BYxJhQFIHmLSmf0X+0jiE1PO7cLXUpfLI6mIHCP5yx/cW1a0raVzMoSenTdreQOdDXlkXri0RP967MhUfDL6N/fxcJ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4b00f2e-f29f-42c0-a6f3-08d6577e0f32
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM6PR02MB4331;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4331;3:yazhDoI9qJsaGwnQmnYSljAknEfE2hihJ0EVaSEtOfyUDoAr/gMBRHYJyM74CPHbah72HXfUMu2dznwktbg15O/jzN5skkKpPvJ8+LQg+NyMjdaLdYl9YK2yS44rXW1YLGzBnGv+AX0Wp0kYPVoaazpd34+wPrFwTllM2C+34CLca6BBL3Y3SjWUZLLAfCCYsFpdXSCpTiYwh/b7Y4xILw+amw0LN8w8PPUvaWlNlrGF9uylwuwrBN1EpnwQ2byAs/9aNc39Uliiub1UW8C0EFOgeXQD8QutXkInfziF7FS/Bh53Qd7eVYu00OYKR57N+GbdZCIocVYmqTDU13U7RVbvJAdRyoW3GXwmW1qs/Pg=;25:wQvPxBkuWcbWm6AgpU+dH7iKrHEhjRxV2WmpEs6jpe/V3LDkHhKdUN7ZbIftsPvjKc9zTCG0Cv+iIoSrhg93Yz40Im+xEsN1AMVnPXQQZbRwj0lutp8b+oRkLO5nQo8uQKWiRjXZouATKN490ytm91neUucsxZGSw71RSCXFnXVXvzouUzsJgytqAfKFu5mMXXLtvpSXyOIOC/JxrN76pbENNZbIWwxGC4n/ac35mz9NIw1BuMU39whRzQAxitd6pTEYvSClkRWsl2maN+aM1iZUr+KBeNf3reZ96b9GRwGJ4rwQerfUtvkSpxWLld9Mu9UDfuQPQsqZWRe0wRYiWw==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4331:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4331;31:gq6bnHcNuBVMU9XXW+FRw4Rr8S9ZcU3cyFcXtYo4M/XXiYw3WQyO3EwbmClp1U7oMAOopEDadKdarCSL5XPrQHYICrIrUSI2y/QV941l4IAtuEted3cCXA+3376B24i+MUiQP1D1e88bW2nvjJ0r36WTL/fjf7VjQ0OuEQoGZ+gjNdp4rLwU0tD3sJJDdVrBvuJNXG8/12DN3Jg+0utCmyQgDiEgSYCd9N8Y1pyiFBM=;20:xMANiCilit4rAoVQMHNX8wRr9DsQ35oh/uzfucAUkLOWRGHQrZJH4fpqbbu+VSdUQq7Ela0+cWw5XHwevAdbe8/AoUN1GYmmsHEupZPdy66lpSe6fwElSN5KFY6dzNkXiXRs6xeyOotKM5pMBs22OqEYUEgTZN1mbfzEA5SP7pyxEvGnFgKUCuGNosgJZeZqVp8SggweY8Oclt3OlUHl9wPLcyIHIVXFCC+iLZthrUuF0LSE1Yx/MNpOnJYigavoZSlbDyJtYTUR6D8zQJrzz/BUrDBPj/bfRKJr8m1l3yI260jqkc6N5XGHXlV7Ht3Sf1qP6adQr9s75Q8/HTJu7bEx/RAtT4MW/zueHPUYBAY4aRvNdZJSv/wYRpRcu85ddXynnFh0QwTYDQwnnpjK3TAc2DoymzyXdMflqbxXGh5UfPKpBaWz+O75BWGx+zUewyyD7z6/wUmQr28WB3zvdwT4naOIfZ7w81f8yXru6YP4j5zvub0Hvj4fik8RfOpP
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB433184FF0411786CA3850E3AA7AC0@DM6PR02MB4331.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231454)(999002)(944501410)(52105112)(93006095)(93004095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM6PR02MB4331;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4331;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4331;4:+ypRKYPPScr9Gvl5aIBIWKIYkMee5nHikqiFP1q5Uy21gFHN+Yo6KLnjEYDHl8sbEkr0o8fHCM+wi1IkuNEvJE7LPeRLVeRFNXffU728cJV2IyDyF3hFB7v3incMy6iKPX2HRrsfjoHMiuMNprfxBk9hIFwfTHrTUpjQYU9Lx1lETKO+4fyB8p6ZG/epvjEfsC+FLs66Jme+Vf+ZHvv/bdBLuvDG8wttdlP0g5YiWOL00aIoi4PbmqN10Yk8+sEC+3ZGEPsDV5kddp7dflYsjA==
X-Forefront-PRVS: 087396016C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4331;23:WyYcb1DX8xynkqGdyM7wcK1Rtw55LZiObnhMcC3Aj?=
 =?us-ascii?Q?BRd5KiD0NPxrWvGZXbxB7Mktw29GUA9CzueEP8JZ3dPGuf6nH/POmdhsIZSK?=
 =?us-ascii?Q?gH3MibU/i3ynRg/ENoD39yOYPm+4+OBv2ztw3gyeB/+M1D6BIGQdggQFNkY0?=
 =?us-ascii?Q?+Gm3XuObyutVHW76Vf6GVRUUKLUsQi1ZLjZoxLuZw5olI17RN2VubmGfip2E?=
 =?us-ascii?Q?zN2yh9Kh5KvRJtmapwUipSMpp7c6+TxhCyiTgT2gStJAJs8EzG32ork4jqKb?=
 =?us-ascii?Q?tzAJko6z9Y/72u/Ql6pNcuWWLLkol2UKmNa6kukq2YrlB0wsmEB77Jny81Zx?=
 =?us-ascii?Q?l0Ua1CPB8GfgLTS6V/UtjcSxufBttbZNfWpx5RNbY/KyMyZrVcK0+KXvEROV?=
 =?us-ascii?Q?nhlQ+HPveH0MVXcemnydcf1y5OE1MdbWN3Wfwf+AnWdzk79jCj6z9Z708W8i?=
 =?us-ascii?Q?/Co0zHLRMGRHVWnFBbsiDNuIyvfzX8UcOt0jpOx6SNWkJqhrznbLqju0m1Zs?=
 =?us-ascii?Q?jWOkR7GZMCNHb0dBoZydYqMImmAh4qgZ3+iPVRufDSFK1MtuQOVkWajx2OmI?=
 =?us-ascii?Q?nBQHG7FqSDCE+tQ8Cs2RGMY0tbkgkeVqpoI81IwchVc2+OSVyk3IywQf4pnR?=
 =?us-ascii?Q?whl0cb7KHDjb0Y66QW+evaYEg9a6rmD2PZ/ocSwcr5JXXFMdPEdIhkTNMdIn?=
 =?us-ascii?Q?RUTv+UdLBH9id2IbXK6gc14pNr41wjEKawUvQuKQ6VloYewUps4lPNXmJkOJ?=
 =?us-ascii?Q?2LKTojGjbw9M/UrQJGfHcuAwg6K0gu6F4sE1WMNl45Y+jedZGt7aUgx9oNwa?=
 =?us-ascii?Q?czqUbbKI5Xq09Ye7+NYOWCnrvNDIdkvHlsljzjdgkA+tcXlf7HziTUV+t1Bl?=
 =?us-ascii?Q?h1mzHlNtpPdRGnJsQMHjGQWGroyFKsiuV341Z6IJF12mmwMkLmswdu5asaby?=
 =?us-ascii?Q?j9i0dAfJO6/o9hkL2o7S6tY066Z5DbglGMYCK8WOg3D0OQ3e6MjCu1JFmsbA?=
 =?us-ascii?Q?5C8pE43SevuzASSjZ2wlLzMaNgHircJgqZzrPhPfbQe/VDwdX6Mp0QLTWGUW?=
 =?us-ascii?Q?x9Tto0DUBInJym3K52sIvDwzR0DozjD1Hym7LuYl0g79RiS7UswDhFd8sXwR?=
 =?us-ascii?Q?NzR9kwCwzZW9InySSFZmmsq55YW10OeN0hqrIK6xqGOGvjdwv3T+vJ36Axmk?=
 =?us-ascii?Q?BZfmN4MnX8YxuS4ztkNgE53ps0DWLlXaxN+6ybFlUmpmx0SoP9h9+p9yQa52?=
 =?us-ascii?Q?lw1x/yWJ6REVznBPyOtwvYj1ifrTcO9eGJHfdufYcets3CbKtmYXjMOOrDbg?=
 =?us-ascii?Q?ZgFtqz/zpdsz+/FfAEeV8EJ2YHfrug+nmM2E/5nB6g0V4OqCcmSdna5Z1sqa?=
 =?us-ascii?Q?Lr789AKbRY97bAJbUtEHeqJ5+PwbkRxjhG/VY2zl3RBvrKb/fZZfyArsmSkV?=
 =?us-ascii?Q?bYzhOOYiVg9xszyDm7cZ2POgxonaiM=3D?=
X-Microsoft-Antispam-Message-Info: VFJoz7jwXjE6kSZ/I8iWZKpWomblUvFoy59y+CWOdR/zLqJnp+hfs0dKOM+FZG+00EEUFZoIWmv3WRJJWD/7qdcoVUApRHe2lLoIHvuFuB19p+96ZSKdaV2wWJ09pUGeLtKdYutHdYVxUiOc0J3onq3Ur1lgt51ed6N+UgfLOgDwLNaER7kJAMP0I2nX6bm/R+zzH1bH0yth1lrIr8t5rO039OjgOeqqIjahg/fqpzJFXmPioCVktl4MTinQxuMJrFrUTX6bEaYnb1uVZsxxveNk4CaFZEBNg8ucwizD+ebAUbU7TQKH6tK6vjYn+EfOYC3i+KBTDHkTgIPoE751+14IQ0BCIw1fyQmt6fDLsts=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4331;6:JJTbR6+M/iehgG9XQL65Y4WT9moWPEU5Twn8kGH/hS2Bv09xncUCGD8YY734CcUUhcF4VIrj8PGxrjdwo83UiUapHz+mjdmbuuo259oui/SZHBRxCpJbwgvrfWLvyXhdPRearLP5bVUagbLHqfbUHo4yYi2yBPeLzx4agCgcUPJt+WQYRx2a2uYNFyiTQN1LVo41SVznL1D0K58F5speJ9d6Rxe8xhOTs4grIlGKkzAGyfE6eNGbWAiVSFKleGsNkNz/xzR1wA7ebrQCT5MueQJ/iesFg2xcErXdtM1ctk6nGMtniAYxDk3tFWyx6yH7FnPFaVKttsihXFKJj0hQUke+TmmOQ1bd9b8sk117x1Kmb/Hm6+XFpFsn3pE/apPkmt/eMhHiUvoFttvssbgNTNeTeAQX+XurFczr7ut88nZwluWw9GGmM16Ajn3phCw9dQ0RQzHcQgkDNFis3IE0iQ==;5:lD3bBOQYQgFXff1AQch59CcxMhNJ0I9Ygl5z2Zey7FknihZ0LCPJSIK3fo8rNCKBOQWW78IwkjxLL7cLuwVuRTEy9qQuCLHfPyNbogdDrW+A8e8pEoWcEV3J8waN3ZyXgm3y2l2H1gO77lP/xH3/Ek3ZXntjQhKURXCCaFLnQ4Q=;7:Df1OSdnx4a8uFPwvXRtmj8ExuIMqndhG25ZBOB0GZTlC3yscpk8CQahP7wpyhI23QbjO4ACAyhM642bdNDFYYmFgO5oLdenfXxTp9Gn1JOo7KcPylI+aO76jLDIcN+YZvPI1ml8NZEzHPXtZN4mj4w==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2018 11:13:45.0258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b00f2e-f29f-42c0-a6f3-08d6577e0f32
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4331
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When streaming is enabled on BULK endpoints and LST bit is set
observed MISSED ISOC bit set in event->status for BULK ep. Since
this bit is only valid for isocronous endpoints, changed the code
to check for isocrnous endpoints when MISSED ISOC bit is set.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
Tested-by: Tejas Joglekar <tejas.joglekar@synopsys.com>
---
 Changes in v7:
	1. None

 Changes in v6:
	1. None

 Changes in v5:
	1. None

 Changes in v4:
	1. None

 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 216179e..5d5c572 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2409,7 +2409,8 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_BUSERR)
 		status = -ECONNRESET;
 
-	if (event->status & DEPEVT_STATUS_MISSED_ISOC) {
+	if ((event->status & DEPEVT_STATUS_MISSED_ISOC) &&
+	    usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
 		status = -EXDEV;
 
 		if (list_empty(&dep->started_list))
-- 
2.1.1


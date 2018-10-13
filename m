Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF76C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CDB2098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="iCGSzshz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CDB2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeJMUxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 16:53:36 -0400
Received: from mail-eopbgr710063.outbound.protection.outlook.com ([40.107.71.63]:61856
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbeJMUwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 16:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xC3i4tFAZYp5SuHdCA6jdFy7vAxhexr2KMvmNwamw4=;
 b=iCGSzshzxkBJ0+ByDl0B1qze4IDxOWhtuWYdoHM/tzRWQPLQD2mNtSTpmNa3dE0WHSOfLwO22cs0mzFKiv2LVWeH7klKB5j0H+43b6bWqdRK4OrI52chb6nFOOsRoilrmbCH/bbe+9rapYxWWoSirO/UU0d1gLGnO1FFdWop7Sw=
Received: from SN4PR0201CA0037.namprd02.prod.outlook.com
 (2603:10b6:803:2e::23) by DM6PR02MB4332.namprd02.prod.outlook.com
 (2603:10b6:5:2a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.21; Sat, 13 Oct
 2018 13:15:26 +0000
Received: from BL2NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by SN4PR0201CA0037.outlook.office365.com
 (2603:10b6:803:2e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.21 via Frontend
 Transport; Sat, 13 Oct 2018 13:15:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT044.mail.protection.outlook.com (10.152.77.35) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Sat, 13 Oct 2018 13:15:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:58108 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlI-0001Gk-Ar; Sat, 13 Oct 2018 06:15:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlD-0007wb-5I; Sat, 13 Oct 2018 06:15:15 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9DDF7Ec019390;
        Sat, 13 Oct 2018 06:15:08 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gBJl5-0007qa-G3; Sat, 13 Oct 2018 06:15:07 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id AFC9060503; Sat, 13 Oct 2018 18:45:05 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v.anuragkumar@gmail.com>, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH V6 06/10] usb: dwc3: don't issue no-op trb for stream capable endpoints
Date:   Sat, 13 Oct 2018 18:44:53 +0530
Message-ID: <1539436498-24892-7-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(2980300002)(438002)(189003)(199004)(3923003)(90966002)(50466002)(14444005)(36756003)(8936002)(356004)(6666004)(50226002)(426003)(39060400002)(6266002)(47776003)(52956003)(63266004)(26005)(81156014)(81166006)(336012)(2906002)(36386004)(48376002)(478600001)(107886003)(5660300001)(54906003)(8676002)(305945005)(110136005)(51416003)(7416002)(42186006)(16586007)(316002)(486006)(103686004)(4326008)(186003)(76176011)(126002)(476003)(11346002)(2171002)(446003)(106002)(106466001)(2616005)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4332;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT044;1:j2axupm1bNywoDniqKsTxgkppQibJIqaueeF1aTmlDRrDarkK2Fpp2KD8/3iHBqqTsC9gx1Bu/O9k5uTDcY9iQvKgxox5UTiloA3CYlBvDXUvemuZmNVZbtv62WqYTiB
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81db89c1-82d4-45aa-506f-08d6310df04e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4332;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4332;3:7iiykng5WmXSzBE8XrerUKCtNAwg+sg8xtXW3lVAaZ/0C2JbUdswDg7NtwjCNqBTbNQiDeiMSpbsZzawOOXH6aCqWs5/VB6XAYjsSFCSvHwY0OW8RJtetfEn0nHBS867wNekPiOIvFm6s12VjpYbEaZ1Cd1hXxDtE+JMcO9liOnzVfjsDeum1IRg8Ty+uyvXv7ZVM1Ulm7fWhfoNiiJSUob8bqiuEVb2gWD+9yHIDqe23l9pTm1nFpLLo91SeszXTFYOl8HjmqaPg7fGrHEFcR2IIkipaTiFc17UiwyE+qCpCuFwi/9uqMDdAiG2xsK3KFY5UKV/pjTEh+lGat1bwLBpXGsRONS1FyEto5ytmTM=;25:ocXTyje2qjXv81AT8CS3FtdbywD687m/EV8NM+clzwsSD55cmVtD6soAH0VjixGRW8hLiGPRMCSD9oG3ipsZ4rOmNVcHniSQ19KAl1xZp2SRqva7XF+shec/DCICroe3xn8RIQcRxrvBHZfNzH+DTaycp8QVf4eIcu46TALHVnBbZKLqFoK5RR1r2VYCT25GFZt/SMks+85e3jEOzRzlUokfJ2miXodQZ4gNpzr6yVxplffpFAN6RfqQLVrFBB7dT7/sMawRPX2bGR0TSoIUKEQPJ73v2DG19EtxL//S258QHA5MpJS0HfM+zx2IqzQpXHUI/VRpWSzKD3Y2PsnVWg==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4332:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4332;31:ku4Qim1/ZZ1mfF26cHN+3ByZ1k73Gxf9EbI+YYRxlqbfX0uNszzERcllr01xvURiUJtXSZNULxymkmy1xVu7HrN9TJjxM39s/gltzCqpnmDy7jfFFNQ2nmZvCRgnUDRpbJNT/LnNw5g41d+PP3gkPNHQ/gQTgxIGvRr2YU1LAC+t+bYOtZJY/AK89FtckkjK2FzbKrThicVaLsWVzGzerudHx7vc9mtOPGAI0QE5KbU=;20:sRz0pB6gu+eT5frwMwPvFSNddeferEDFx+7Debw2wcyzbhFRGfT6UkpX/h8QT94L4R2ZQE4oQ4pw6hs0MJkOUy89UVm2Yutx4LMvw1jg9eYlOkrNdsRnqPdjlpM2kQUXaBTJORAcv5AWQtvk3B543JFTaw+Gf4kGuMUX6TFQReCKPJF2dcCHAVQKUhbuQuey5GSAp59gTMnXipwOdedZwWACjwR2tNSrjpr8JEpCfvRXG8rjTqrhgEJqLuUfVVZNf65IxaSiQiCtt8bMiPd3TQ13HSlpdyZ/r8n7pFgu3A1OKn+53EHgCsdfLnW2micm90pytpDEXrXO5EqCemyWgM1JurXQXCrTXc2F2otItPXo2jzxtmHGi7q2y9zJZNmBtQqBVzhaQbTZ01syuK6ZflsP0cNkhSOubSzh33WZGLVnxz+LHTIgp//wDh1mRmYvbBnJeNuEceCPh67kFzwnpCUnfrj/Cj3+yDekd0lg6XeeOUrfJfFkzeHbyn18t1Do
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB43320A71CD2FCAC95574F85DA7E30@DM6PR02MB4332.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(93006095)(93004095)(3002001)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);SRVR:DM6PR02MB4332;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4332;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4332;4:FxYQ4O83iBARWhNDBb2dvdfPZHQcZ0m8QIS5nM4JcDfokRlEREFDTdzBCyRyxxP8d4fJjrGN/ajpjQgz5wCYUq5bT95KbVlVyN9/yyLaV/PaSUz8j2iYD5HjNZt+Zil63jxFIBPZkxy9rY77/4EGpVUrolOIKlQMUTuB07+pbKmvgNJHSaYgeV1cIr846zmYyqC9zdywUiKxLSBpqNHu8XpLnF87/vIGBgvUC5zzz3oV02Fnjr8Y/nCbiiLSnLvUSUHQXVOaei0x2HYEXwAL54kdtuHXZBGrhLUaC2M3l90TyvBk2WT+QbMquogQ28tl
X-Forefront-PRVS: 082465FB26
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4332;23:pTjFuRLevoA37AdKSa6HyDgZnSenrHvDbtp0mZFJV?=
 =?us-ascii?Q?JgpWGGkju34CU6iyGxQ/jsrKZGKej1OiicPNJrRBKwGoo63RdIBg3wM/bpWo?=
 =?us-ascii?Q?/XOmq2Auqh29ABjsmnt3ZRwJiqrKl27szcOiEky+oVLYQopWLLLjLNriS+l5?=
 =?us-ascii?Q?r6qcOAIw0lDuST/bcyeCqqkMEa9BefRBBQIvTqAQeGZbN1P96la4fgNNWFi/?=
 =?us-ascii?Q?1D9gEruFJO4dS3VIPwNHh7WFTC3Bo2GIrHAFvSJmC5e0nAz9r6B1Shp/QNYd?=
 =?us-ascii?Q?3g3GdS748DHqW+XLkFceSi4fPJ13s0qsPAKaQAWQ3NYenE2dfRrD+ynWVVbR?=
 =?us-ascii?Q?S+ZwtoaLJPZhTPewEqQ4FRlmUW4tebYkV+gMJtA/nA10Mg/jcdYnTYXRucz6?=
 =?us-ascii?Q?fC0cdAi8w0gKjy1b9jeG0rxk9NDAird5UVqE/fzfsYa9jJQEo1Pw0WI0IKpK?=
 =?us-ascii?Q?+1zdNP+9h337jyKYXbwZAZaB+fQMdU2pXJcDRQViOGoP5laZYq3amOSORr9T?=
 =?us-ascii?Q?J6x0HddHdrXzzkCSBHuWoIvjMnl+pxLvAEeuCA4DVMAo2zIpZO/kqxEMcGx+?=
 =?us-ascii?Q?oXclNTcMia12sqinHeo0vp1v5Kkmp4GroOTiPxgPEspJIOptXi/hkQFHvZ4/?=
 =?us-ascii?Q?maJiJKEzWKC/mTRCSmReUrtk6KUo+LS2gyaYCChYuhytZdWQFfSVyb5KhNQF?=
 =?us-ascii?Q?lirlZ1yrgan9+RKcr9G9KTl+B7awLPJHzQYjw0wcImYrVNUeUAOMUlCa2eHb?=
 =?us-ascii?Q?WQ1TtmiS06pp4Kd/spi4Z1Nh8KlVjn1snMHRJuoZjpWJIc9/wNgjcbVIwwhq?=
 =?us-ascii?Q?ewTZsrENDqpWMXNSJiuK4/AP0fs2HNGjs68PkDExyc11IMwu7XqThcu7nT83?=
 =?us-ascii?Q?h1eSrmFD7Dl82dA8ZTkBea6XVB9NocZHYsTkRbnMC7872nAVvOw+AV0cQT0z?=
 =?us-ascii?Q?c1HFjNP7ez8axLIoba7ZzHBanESp6uqFUDMymZi9vuHmONTSRtwqK6g+iZpb?=
 =?us-ascii?Q?7jl94ZoonjWJQ6e5lzTmyEKO7/AV2Jnpauqf93D1YKSSc0Vj88Wy2IdU+U7+?=
 =?us-ascii?Q?8ovyZfi2Zv+lunO/3+YTDBKDjmCDBrYMZVz5msnCYrWfCqB58DxsM8ZCE9NB?=
 =?us-ascii?Q?ZEfzIXVMZwfqemmmVA9ZGGhoOSIkPqNufC3SAhEuwv3wjQda6fvtbs8DuFbA?=
 =?us-ascii?Q?A1+d39i/bkUJueZsAZATKWXA1ULgmpTECQEdiR9SLy06sgoNO/gsw2NAvKqq?=
 =?us-ascii?Q?0yLbR2Rl+8dFLluj74Dtzk4ptMRpycYp4rHiTGSZxdaXa/6BiVpKJa/pYQrE?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: /z0aGz9KfQwTJrLREaYfVVBZHW8ygzMsnNUuk6tUXt97udcqZpZ8CGuSi8FdRSng+zfQJmQTBsiCtqXUOaqpIFrtxHkmsnqx/vt8tHcOEZwkbYJnkzb/REegrFWYiM4H736P5QkzD+FUXfO57Vksskj1YUj+PEAT9vvJyRfuYK6Q5BKzzbLh4MZtRfdMxykGVNaeXPnR8E4Z6mK1WG68UHLzCiNxtJsLeowW/4SAqK4hpHXj4pccPnnUhuU0TwnVXE1TkEzaKWTnB9J55+o0VJcGLc7FV4+zEWLhggQcumgBZecSLiTShY6qb5mYGw4tUwvP3QRqvTPY6isQQ4ll4K3ArtxFwbZXhUowopi+54w=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4332;6:XsS1FXNQIebIyxrL7YxR4nzEm+gzF1x3OKU5iIpS3zkATnPVJvcJ+sGoCCpK1MnL7vNLgRKHVen3hccO/4tdvhqpEAt55Ha4GHlxflL0xaDyEb1D1qDJMuC5pOOInYF1Y10YbW7ort/J39oZFLUtlpLn28RSPDRG3BjH9wdSHFlpp8zHeRKLlb0BJznCCRLajjkQSB14fi6nlHTxqpR+wNcwiE0q3OEYWFZ5twMFDLl7eocCF2ufLEJ/kUZgjzMbob8I8LKwUYcSru1K1KcCed2LZbpD0ld4FTsWA9kNjWOkFaNLi+dOSckW6Z9cowYh7IgvjJOtuEGvR6L7CvUy7Q4qg02F3NMkQtsXkztHKk0G8fzTGRQ35HftAjJ1tGSp/SC1mWV874fzz+q93bKt0rrQwVRqcULEuTN9dv5V+2o/2tFwU9vbTP0aMgHOGzalzfZqQICxuRNMIdc09QZGyw==;5:HbOd1Z8NxunIAb1VHC95lee7+6BclCwUr/NWcs36XlgYH1pJ7GemZB0pJV024xhzPUhlr0jfALt1lxxqyVfpiX0i8lHzcAAtNZ7B90i819Qv3mNsjyj/On+ceW9O8pVmYg1z50sRos3eq0++8jE7qCDoQUoBPCFi1urGeT65je0=;7:+H7noihPXJOpXlCnjd1FLu84ZaXcWdLyd2GKx7ZBqchG4Dt1EWg+J9MiLyRk2oTfSvpCNB+OnhSplPBQYDyorkWRTLtVD1OpFGEmX+YvS2+UrewzjYr3sI3EETenZhn7NtpWId1FbUhwvjkb0dar5JAIs0z22Uo70CADf+Q4zai1II0vhIXCEky3ehxleOUQtqmO6HXjhzjfKSoO0i13S8yaUqWSHxZMbZs5qkRARBxjariXleqLhzvb8tkNL3N1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2018 13:15:21.0953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81db89c1-82d4-45aa-506f-08d6310df04e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4332
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stream capable endpoints require stream id to be given
when issuing START TRANSFER. While issuing no-op trb the
stream id is not yet known, so don't issue no-op trb's on
stream capable endpoints.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Chnages in v6:
	1. Replaced dep->stream_capable with dep->endpoint.stream_capable

 Changes in v5:
	1. None

 Changes in v4:
	1. None

 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index b58cd69..89df030 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -666,7 +666,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	 * Issue StartTransfer here with no-op TRB so we can always rely on No
 	 * Response Update Transfer command.
 	 */
-	if (usb_endpoint_xfer_bulk(desc) ||
+	if ((usb_endpoint_xfer_bulk(desc) && !dep->endpoint.stream_capable) ||
 			usb_endpoint_xfer_int(desc)) {
 		struct dwc3_gadget_ep_cmd_params params;
 		struct dwc3_trb	*trb;
-- 
2.1.1


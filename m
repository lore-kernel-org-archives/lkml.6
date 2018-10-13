Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175ABC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAA120895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ih4E2PDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAA120895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeJMUwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 16:52:41 -0400
Received: from mail-co1nam03on0079.outbound.protection.outlook.com ([104.47.40.79]:32064
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726665AbeJMUwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 16:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vpe+u00Akh/j9YaOXqfe0G3VGR0+1M5xNzVwZcS7hXg=;
 b=Ih4E2PDR50Yw4D8uSsB6IkuEPn79DZtbzmkOoGSQUrX6mv8ENLJwWaO5rmoeGicfJL7ZRY4YBf2aXmfUXPLre2rmZVXknO9oOM6L0m+9a0O6ujbgkCsf4rYX7IMNy260r3/yvpqSXwh7AWknJmTYO7fVqs+3+lc1m/BNuOCbIzU=
Received: from MWHPR0201CA0015.namprd02.prod.outlook.com
 (2603:10b6:301:74::28) by DM5PR0201MB3512.namprd02.prod.outlook.com
 (2603:10b6:4:77::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.22; Sat, 13 Oct
 2018 13:15:26 +0000
Received: from BL2NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by MWHPR0201CA0015.outlook.office365.com
 (2603:10b6:301:74::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.24 via Frontend
 Transport; Sat, 13 Oct 2018 13:15:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT019.mail.protection.outlook.com (10.152.77.166) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Sat, 13 Oct 2018 13:15:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:58070 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlH-0001Gg-Kg; Sat, 13 Oct 2018 06:15:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlC-0007wb-H8; Sat, 13 Oct 2018 06:15:14 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9DDF6Ds026410;
        Sat, 13 Oct 2018 06:15:06 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gBJl4-0007om-6T; Sat, 13 Oct 2018 06:15:06 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 60037604E9; Sat, 13 Oct 2018 18:45:04 +0530 (IST)
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
Subject: [PATCH V6 03/10] usb: dwc3: gadget: Remove references to dep->stream_capable
Date:   Sat, 13 Oct 2018 18:44:50 +0530
Message-ID: <1539436498-24892-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(396003)(136003)(376002)(346002)(39850400004)(2980300002)(438002)(199004)(189003)(54906003)(305945005)(106466001)(2906002)(52956003)(478600001)(186003)(50226002)(63266004)(50466002)(107886003)(90966002)(48376002)(126002)(51416003)(81166006)(81156014)(110136005)(7416002)(2616005)(446003)(26005)(76176011)(476003)(336012)(106002)(42186006)(36756003)(47776003)(316002)(8676002)(426003)(5660300001)(11346002)(8936002)(486006)(16586007)(4326008)(356004)(14444005)(6266002)(2171002)(39060400002)(36386004)(103686004)(6666004)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3512;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT019;1:CBB209aCcQCB8acWOMyJ2Yjc04t4pe/cq4D3Y0EBXddodoGSYQL+dBh2tKxP9iMj95JZPhG4uJdBMfmGTtxVFNgvKMXBnk9meaAFHwkSqodo+nssrw4TOsQW6j5ujBRy
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 239adc25-523f-4263-96f2-08d6310df00b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR0201MB3512;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;3:ETw44/1YrlBKAGiqlmjrR1KyXpB2AvVb8OlbkwgbYdtlpjQFH8+ibXOPTEm6uoHOq0GjABhgDcde0/RMKLtvhdNijsWKF6aqMYFGnZLNh1bRHJLPP3td28FajCPKaw/t6QPLQZddF6rXeX6pJ8lq2Q965NjuaqSlNjkKkKk23O0R1Lb0p/72gKa51ikiwhcTbpSGJjLSZjWyFoJgFdjsxI+0EJWl9wnhJfASvRLDRNS/LZVBahHHp4e7sJ4sGpiAFZBU8EcvdqP5BY4nrP6oHm4um46SaoQoc2YetFd10Sxe+lFBBUf4danzqI49kmjOAb04gNq21JWcMIAEpzv5a9tV1CQ0MVfRoJcxCT6B+zs=;25:vb4z5x9+3ynfIl1/EAJkUzSHZWRIzFVy7NQkM5HnBSJHlbImxVG2G98Mjak6FNdz7A6OIPvWV5N10U9ixjybXydeHuJIjbC96aianlnV21ZyN5hmw2tnRJgGtXnRYTuv1jDDfWVBBd8LjNmdyN2hsYy7A3DrYKdHQ1X5ZtE7TkdcLqSLUv4gfdYW9XNjCASAe6/ydDpx7OUA+r6wNtcjI4CWuVLF3AOHj7WZj+/rJkB3g9vKFTTNQVub2OwUfrEa4ebFWk02DXrFzU0W7T33g4fym9ODDj8RTE3TWn92tjlBbypBKfK87hFE8AlvH9sXMHMf5R0foD3K14AzAZ5K2g==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3512:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;31:iKLvj02evThjugjaxbEBfkkMZ4ybkEdsGJpetu8r9UShkCFtwtzrWjO3phATAJaeNSwdOlY6km4zIl/yTKNkGrnuMvHMymvFNJqMLOkS+Bye+Jo+eVm/Y2oNLKt6hP5eF5nyGx586wiTV/+W+dU8vmxpk6F1WlxIFm7D32Tz6I6NJ+epxpdHSYx3gcvXLMWwpWg6q0xv4rLJ0du9wSf9SvslIilqThPouYaZVOPF2bo=;20:EdTx0yfDlPekSLUl/ilma/YUS6OnY6AwkUhVpoWLkhK3Bq5rNLIxuvIEhQQqI/N1Edw6OoCvm+N8Jw8vwyta4pOI5VipwnvbtRPg1DsjUi+SwobqcJ5HPDWIRKsHeAe04btGavRGLYX4OGY8Vu6mikrdvmGpE33Gxw6TP5q5jfgxKx2K87pxNMD5EK4lrItfSUNnRTdZ0m8ehYkWZuS7AOxbzyrhkG8+wLHePfen2htZLyXx02Kb2TF/24r7ekR4wfqCMeIGFB2/uX+3OqbYjXMivz3w+s50dTgnSOfdeY6NC8/cGHPhzxjQ0+WK31+4CL/CJ38GNgFfCksJDv5Mlz5AgN2Eejz6BIVnz2S9fOMSW6JjncudlDDriFNjXwf7YnPhYpOAHkcfvnQ6h+f8y6UMwC62enq7Q7Dr9lWvMLcVLxIqH3Bg+P++i2pPqdzf8IA6Vx7r8BWoI4xZCaboR2bjlH/PuHSg3mhoeykxkBPl+P+zuZhHhyT3PqCwn7g9
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB35121144ADA7641F20F67B04A7E30@DM5PR0201MB3512.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);SRVR:DM5PR0201MB3512;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3512;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;4:CoRXvH7e1bsebN0hkkA5ENR91eOLeUjgYsw890DA2uOg96Gn+uiSRiwnrhTtuyq75CacIhdaGjqCziLBB9YcQIbPN6gYxJw124oreDxUhLr9Y127CrhPLlsFgB8Z+P48G7tGO+DSadBlkJfbK5Kg3Krrpy29kH9Syabb2FUZOThdkpXN3F2UbDdc3t+ob1Va2kABhANYocNaxjfoMWCJ5qT0KFRVgzLk5gYkUIuNzsS3alDcBotBgek4EofVriq/B/sgPCpFCp3x8bc90gqO8CHkF77x/RFYK1ar7sEMa6jNEJyxG6F84t95OdtLYi5Sg84FYSxKPMHxLLgUOaGytsXvRrkH1M9rBcW14owjVug=
X-Forefront-PRVS: 082465FB26
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3512;23:Y/dawh1takscQrWGg8hIrAAwiGSvxyNZL+o/bE0?=
 =?us-ascii?Q?VuyrsNUCh5ElynSirR67l/6ZICTGdHjqXq3mFgzd9/8jVDAflF/Pyu2o7QHK?=
 =?us-ascii?Q?y/SL/zmNX93W08UobkPbdpigShK7FkVHMQedL/BcP37CY9X1FbgzVON/ngxv?=
 =?us-ascii?Q?Mk47pXu+9YmBeisVlVUdLUIjNQYW8BKCpxX6LrCveiMKl0E5+zLSc1U1iU3P?=
 =?us-ascii?Q?LUHZtUC/YroQfKGv/w4GUAHt9KZc5reF7GKOTIQQ3SB+KkvpVwPrQiGna+Jy?=
 =?us-ascii?Q?b2vHL2dn+1XGSOgz1Ym5CRH2kFXHfBb/1bUE4CPUqPZeeTc8TB6eDIW/khaZ?=
 =?us-ascii?Q?Zj6opQGNdScrmxa3V5ycYaINt4qGVQUF9CTUJo6VHNy2mpmd9djzqkXUoLcg?=
 =?us-ascii?Q?8PHSUc+36hLv/ZHg+tGcSACAxKZ9fM4iSABi3QPcTVC6r7iW7eTujr8RaD68?=
 =?us-ascii?Q?YpuiM6kWgkUwxYVdV91Ke5x8ffQzaftGCbyXXlgUPYkD2cYNnaUwWbTK3NCe?=
 =?us-ascii?Q?jU0BkuBXVwN+P8xRNZxf9xIQVlve5IePH4ea4+NkoNWGUT+TDlBJm3WCigTd?=
 =?us-ascii?Q?fSPLJZxWvp2eQ3HJBwDe9+9F/1ESO+QegUre6yub7OaMmQuSTokkX3ovDbKl?=
 =?us-ascii?Q?GQtPqRmj0XyUzGaHIQHHcjc3HF6eIAYV/Vi9xwEZF+K9O1OUv/p+NMxx1n+7?=
 =?us-ascii?Q?xAKSDobpx9qmHETaWV/0DFcW9X2894QrKk6WN1eg9ani/pWdl+h8ekDyad1X?=
 =?us-ascii?Q?dhbFATY8tFY8gpXgCpx5n0UfdB5xF1PKdzABO2kXElRSQKwDGsV0K0Kwu1yz?=
 =?us-ascii?Q?Lu8Jk4DTaaPDfmdUZjdNhu5aZtXMFPhhX32FCvtmnyeBWTUHgY9o73BL/jAF?=
 =?us-ascii?Q?4+lOBv9+qiLBcx5/Eo2Hsa3VZ5CXFIO8dHDvSpr+NrRRlcTGUEbSu53k55yy?=
 =?us-ascii?Q?LS3l1Jj6zn6HhjgFUjx49NKjij4Ojok6VQoa0mEJV+gJYUKtzFWI6B5I+0t2?=
 =?us-ascii?Q?2rsLGwijnge+ZzzEF1B9oJrA53WmNGgH+hzvLZG/bCjC7tNoQ1kTJxrf9OaJ?=
 =?us-ascii?Q?L+0sshVLHfEbtd2mCUvxWxmdWSmzDC1Rsk8ngUnP91KOnpM0dRcxLusAnX2+?=
 =?us-ascii?Q?MgfNyXfdo20dmXREUYwYizwRMxPPaEDp54pYLQoubexh3sdknwa3t/eKQoAx?=
 =?us-ascii?Q?mwfhHrzmnLGI7Onw/wEmTJOA91p9sPcjAZAEi/GE/7MXQQgHWP2WTuieq6RA?=
 =?us-ascii?Q?9RcKXryrGg99E90a4tYZ+mOpzvgn17JWS7SMWYs7hALz51Kv1+vkscyqhB4p?=
 =?us-ascii?Q?n9w=3D=3D?=
X-Microsoft-Antispam-Message-Info: vNiccXT+oW5NnwF/YRXs4SwmT9BUv4gjQ+6TeXTn4yI3roq0nSczh+CKTR9mIC+Tr16XurMoUXmf8keR28k74qbbEV1GVyGPaaMzymg0KA95uNRSh0MpAcfulizjqvksEIlIFSJEBWEDUvX33TN5Kmd/tfrIlmmHKXYRH/tDH63uVk9JlAS8tqHXAGquzcAM5x8exPbdsbxFS020R3Fv2523z0reXWhuNB7UKxYx8WoD6eidaxOa9mf7JNsXu6d9wuJU8gL9U8qF2eDylHJHyeHrJpqbDPECcw3zg2mcdMuJUnvvBrFWOaWbb5W1Yfl0uLVhupKEhbpjp5wvmbeGBnoGKL2sPkZlBugHJ5pZzNY=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;6:u2R+EIMT7fR6YngbZJ0PL3YuxKhiKn3GqYoratF3ijdUcJenpq4yBrWc2mbXMoMhAm+YQYIdhmMMkIOo0vMwiUpddlZIMgjPpDZx8Y5cHFZSFADvRaWLut2tbMn3rbnT43gG/YBQxIxCn5OK/O0o5VJW7ZGV6mk90hLRzKkaAcMpvCsoO1oT+RK2knfJZRUDQQ8EGiHpTeXk0jk+otknWO2B142RtL+3YTdtRyOJmOj96/qSbzuTUs5IFWMyzJKSG6GP+82qtAyFeNaqQwZLspIYA3ObLnV3+42c2+DNZPOGmOanzBWuOx7EZaqvpdrT3XZ4rSSkU8ZPMKGi6Ws8rMp/CFbuYC70E6FzAUgVU+QqVvTv3A8R5ZhTKg1Ea7OSEvItp4+cCakY0EZNn7sD/Q5yFAFt1uXfjzHkBchi4kuW/VIj12+EvaTteVlQ49H5M2S+ayBhspm7WZprescOEA==;5:dSmcz6GRJGPCwJ+FcgrBmCQ8xLCtS9/sKKWLk+ll37SgbAzoA9K5IIj2dOdWeYySjPluNkZiLM2zqlbF2x9P/X9KGW6v6QQF6LTJx8oEIeLrdCoN4YS1FoHbu9ApaFhVafHs8eFq8YZYmYX8fPjMbQ8iyiPGPFiXu9teCt498/Y=;7:/9WfjkwpjKd2NoE7EtaoTH7jm0M3JW5pC3zlOxw9ZrpJOIr7DkFgMj9SukSltaSU5a8EeViktQ3ir0v7T5nWxuf8U99jKdie+6jLZakeT6HVlC/x+NMPzHxt6a69/zXXWeD3ra7Qq0xCBNH2AAfiQUnxpcwE1Rt+bFjHDPD9BEp3Fh7EGsYc+KdzdC6grai8rlYHDa59AhjQ/lVY8c9ZnFO8iYjsvH7adAWnMUhv4KDA4JsGqVgKa616Ak40KPhS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2018 13:15:20.5973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 239adc25-523f-4263-96f2-08d6310df00b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a part of adding stream timeout timer for stream capable endpoints
stream_capable flag is added into struct usb_ep. Replace the usage of
dep->stream_capable in with usb_ep->stream_capable.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v6:
	1. This patch is newly added in this series
---
 drivers/usb/dwc3/core.h   | 2 --
 drivers/usb/dwc3/gadget.c | 6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5bfb625..89a2ee6 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -655,7 +655,6 @@ struct dwc3_event_buffer {
  * @interval: the interval on which the ISOC transfer is started
  * @name: a human readable name e.g. ep1out-bulk
  * @direction: true for TX, false for RX
- * @stream_capable: true when streams are enabled
  */
 struct dwc3_ep {
 	struct usb_ep		endpoint;
@@ -704,7 +703,6 @@ struct dwc3_ep {
 	char			name[20];
 
 	unsigned		direction:1;
-	unsigned		stream_capable:1;
 };
 
 enum dwc3_phy {
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index aab2970..ac752d4 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -572,7 +572,6 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 	if (usb_ss_max_streams(comp_desc) && usb_endpoint_xfer_bulk(desc)) {
 		params.param1 |= DWC3_DEPCFG_STREAM_CAPABLE
 			| DWC3_DEPCFG_STREAM_EVENT_EN;
-		dep->stream_capable = true;
 		dep->endpoint.stream_capable = true;
 	}
 
@@ -740,7 +739,7 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	reg &= ~DWC3_DALEPENA_EP(dep->number);
 	dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
 
-	dep->stream_capable = false;
+	dep->endpoint.stream_capable = false;
 	dep->type = 0;
 	dep->flags &= DWC3_EP_END_TRANSFER_PENDING;
 
@@ -998,7 +997,8 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	if (chain)
 		trb->ctrl |= DWC3_TRB_CTRL_CHN;
 
-	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable)
+	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) &&
+	    dep->endpoint.stream_capable)
 		trb->ctrl |= DWC3_TRB_CTRL_SID_SOFN(stream_id);
 
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
-- 
2.1.1


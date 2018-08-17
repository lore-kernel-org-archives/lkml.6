Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C6BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B392146E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PITN4PNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B392146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeHQP23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:28:29 -0400
Received: from mail-eopbgr730078.outbound.protection.outlook.com ([40.107.73.78]:1584
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726795AbeHQP22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdx9OIFGBN8hg2SN0GaRDQsgf+nUyqA+bZSU7irLA0A=;
 b=PITN4PNItWuaZGWuxCb3vmAECZnc5FHtDYnKy9Q7asfN7cyWLsMmstb48zbR/CzDNtrVObRUUDoRX3Hwuq7XpBMsCC+pYUDlWWpEtvr2qMGvzWCbjJN2URuoPzp/2s7L3mwRyVpxYFhh8kMSuPcxT2qgo7Bm5B1VXHHfEfozJv8=
Received: from BN7PR02CA0016.namprd02.prod.outlook.com (2603:10b6:408:20::29)
 by DM6PR02MB4460.namprd02.prod.outlook.com (2603:10b6:5:29::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.20; Fri, 17 Aug
 2018 12:25:06 +0000
Received: from BL2NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BN7PR02CA0016.outlook.office365.com
 (2603:10b6:408:20::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.21 via Frontend
 Transport; Fri, 17 Aug 2018 12:25:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT054.mail.protection.outlook.com (10.152.77.107) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Fri, 17 Aug 2018 12:25:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:42351 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fqdoP-0008VN-CX; Fri, 17 Aug 2018 05:25:05 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fqdoK-0000U3-Bq; Fri, 17 Aug 2018 05:25:00 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7HCOwnZ019095;
        Fri, 17 Aug 2018 05:24:58 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fqdoH-0000TW-Vs; Fri, 17 Aug 2018 05:24:58 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 1A1226050B; Fri, 17 Aug 2018 17:54:57 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v2 4/8] usb: dwc3: implement stream transfer timeout
Date:   Fri, 17 Aug 2018 17:54:51 +0530
Message-ID: <1534508695-12642-5-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39850400004)(2980300002)(438002)(199004)(189003)(52956003)(8936002)(36386004)(47776003)(2616005)(126002)(486006)(14444005)(336012)(26005)(476003)(81156014)(6266002)(81166006)(36756003)(575784001)(63266004)(186003)(6666003)(8676002)(51416003)(356003)(107886003)(5660300001)(305945005)(110136005)(39060400002)(54906003)(106002)(426003)(2906002)(42186006)(90966002)(103686004)(16586007)(106466001)(50226002)(11346002)(478600001)(446003)(50466002)(316002)(4326008)(76176011)(48376002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4460;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT054;1:hQa38XuJNznv814CAq+RqmSqDnRIdUzv20S2/kb6N03NNoaaeFqGW8YQdbTO01HqXz+jybgNL66aSKyoERbdQ7r+zWaJD4GXyWb1TKY9Ej+ACf5prZVzcSdc6+pjSXVN
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e6dc72b-dd1e-4017-28f5-08d6043c7719
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4460;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4460;3:2DOE4OkZln0LIp+UNF9aRuWF1oU1C08MXYSUICSjgAh3aK4EzuHojFs+wdgPS4UT9fpRc9W/Zg6NhJNR8kMCCKHlcywLn3YjmVWddeIFDPVIYwxsC9z9rqOIM8xxbJOPtnVxE0ngKu5I/+F4jikb2kHOW3n6nHyQ8AprgBw05FFLbwxu4CFb43RX67bozUHorArNilDQ3oQAgy9XZmpPGrE1llp2fx5a3uWkNxyVo4/sAsAAub7PoK8Oef7Yn04+fkZBPw3Od0DPQT9thQuEU06ATzTMOsntxdFx8xB3YDFYjjGBvGcHB4Xtf6MmXBCe+C74Zn/tN3BJC6s3+4qRo7LgSl4kYzIEsEsjTALwb2w=;25:0iCiSil3QvNndn/c6yJNF7nex+Qdq3vzObAFoOyFB7LqNBcpQozcSF9oi3gBqWyW2iCdJJuNRJ+OihbDCGjPpb2QdQt6roGpusVlTzrnTq+Ca6hv63D09LWIAeaoa1h8WxNTvAfYGdJmZsm9LIIfb4IBRxA+ZCaebee8cgbF2tMFAZBzPOmolp1Ga2v14aAx9FSXfjJ2QixUHnjTbHNsZwOn5cLD83jg2/+BACvMiPja9msDVKBym94ted2B6w44a6GLSFdEFnttjBv4tsnspSgk/jD7tjMt7JCAaxd0MyAeWzVH0OyQ3FT9TL0tA0D+qcsKMPCTb4lKfa/KQ53sZA==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4460:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4460;31:T+NBtEdwAbKo1DOISTF5SgluawWi/nR+I/VcUdvYcH/uMYGEOrK9B/PaAgRrMEC9wQwqaOEofoI1aw2IvMc80tOQC4QGh2li4EtLGapfZcqe3khqn07SCRBvWtf2kUj8QeY+PaZhhdoXvVez36nteMjI4WLbRwbDdD5mSOC7urOQ7qy2A+pvSZgAo5p3yX4aq8Uc0ZWlAmoiIXXDO/YyMtqUsd57QKZevkck4xzW7b8=;20:PvQzLDtDO8GvMy+a7BfqH/nmTcioCMBs9nP4XZI5KqA0Nq91HJLaOYVT40SSaW2D3kblWDvz8Q9ZcHGX40OBT3vBLOtWSS9jJnXZzYr8+wHkJqmklQ/1/lBZ/me5ovySB6z+tyf1PIk6Q3r20K2NUViihQXlkanAf7JOVaWLVIz8wCCA5jpzvaahQx7HSETETEo2VClmrGgU051qyvY4x95q37VcBOTj5rmEM6cOCrTmGt9ZmE3i4VQLGsjhO3XUwvxJuVRdAzD3XQMQ4uilzpofpC0cGAZs0z4OhzMYX7SrFJQjBOpiUq8u//BhmI9H5DUFUbTrR4vzx5vCgpWH85B9N8lZZ7CwwRATgz4jMQpKy0dfuyfjFU0RK2Tid+ab+t3YpAt2JFc3oC/FZxM5B8SFWhRKwz4aEpr38Ltop5KD3O45ocI0XBpq7JTIwC3vaZT8Iz0V6zyxt6LCTLmaiOHJolisrQacXXjccvZVUtSybrMwJ2TDOsH00i2aTrne
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4460D43FD566F0DDE30AD4B0A73D0@DM6PR02MB4460.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699016);SRVR:DM6PR02MB4460;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4460;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4460;4:C5IfWaYyxqQGrdd2Hl7v7z3hVxDWPdJCIklD1JhHs1bnp+LB6eh7F5wZhkD3v1p+Y63NyXzY0dX3rfBf0oyG4mNXmS4XkOp8IwGvMw4xODlZw953C0lIppE5Xk2DyKIk+E3tAOPlyMTfAAJjGPBY1T+Di0NCq5zKl7V5QDIDBcd304KBN5/YEL0rpn1bPuwQYLyJ76VlU82jZIgHdW9qHViczP+2lKcvd/59tnQIbWIORAgvln8BCtaq8e2dT2koF36t3ERYAgKNB/MDUOJzZblkFFJzVQtNxEdRnEtCQ6EiCtJsVPVNkwdM2UG5d/84
X-Forefront-PRVS: 076777155F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4460;23:v7JMbswzyVJ1rQBJil5FXSWSYRfbU5zHG2jak8krJ?=
 =?us-ascii?Q?3CqToKh2f61BU59znw5bP8vAHw6yQv+xMselA5hvbyygz08njKpi+whwChdn?=
 =?us-ascii?Q?x/mGT3pKlBI2oxLmOxV2DH9zGG708eQDppSzFLZ7XJnOQTkzkZTDED/ei3wB?=
 =?us-ascii?Q?+HHEeA3s3WXIUL9eoXpkWJyu5FmApBVqnDuRAQG6MLGyrpwTqyGVsfleEcc5?=
 =?us-ascii?Q?arTY6EC4ikECbgCN7LboI07inJV1LwOR9z6KKkmfg/kYvKw71dB/1IQNPtOl?=
 =?us-ascii?Q?eipvFc/OaE4TOEAxwq4spwGqhAK5ZTlB8ROfE0CXqfdQaPAx4qhUWy7HGx1b?=
 =?us-ascii?Q?j0A6wLoXj0Wq9gAjgd2naiW1K2UswpCAtZUW/zdST07cYOLDb9iwkjjWLj/y?=
 =?us-ascii?Q?2BklujDxDPd5dys0xyJFTB3AnuOhwOrPWnJ/e2qd+R9hu495DsLh9x87uxwe?=
 =?us-ascii?Q?LuIRv+qsf88hFaJWHSZFOfi4vh7IGk/RP1IO7+xbm1CpW4IgbrvEzsyqgZQt?=
 =?us-ascii?Q?aHm9IBKMWHMmrZ7wLi+Z2ZyaZsExLazrJ6U1Ep7ga1AnbW19CglKULmEwUzU?=
 =?us-ascii?Q?UQ0FxASdhDFJQSVgTOr3SRuTt7K+CB+9p2IA6CXjjDdeJs5ByDL4LiYXp37u?=
 =?us-ascii?Q?rg1CdLMyDMZw3yR65pkRi45FSJ8eI/FZLYD0n10+Zg+qWY2WlU+jc2ZNAdYS?=
 =?us-ascii?Q?j8m4tQ+mOewjeaWyA05KcAENXV+gC5hkc6TDgLTwIzIyX5IVDQpf7lzpKceg?=
 =?us-ascii?Q?xZYveWzphZD+OEvAltE+eeOW121ltUvDsIxxfAIWDIgQevMS9TCdRXjljgrf?=
 =?us-ascii?Q?yw3PIhkVxxuOSVZsjK337GdxkP4ciMwT0BtXSQHwmQ8XqrezVjtAw+qNaFZk?=
 =?us-ascii?Q?U67Z+u9Xt+QlyORCOrxz5QHN/vZVJ40Nqlj3Y5BhsbbRnQ14dcBUlG3Ady0R?=
 =?us-ascii?Q?0DSngOyD33iGRke3rAij9GLP3N5GxgJeQcdOCH7BgSJ5jcnsS+0PbQucRrPh?=
 =?us-ascii?Q?6T9OkjU/e1QWlMFdoMPqBrP5w0iok3aHmeKvHa9G5Zu1k84kSNcmGYuC6TMF?=
 =?us-ascii?Q?7JT/IpTLLqyLu0I6sQIEX361z48SSWzft9Nyzuopv1JMDfc3hULbl47ElWAG?=
 =?us-ascii?Q?jbFIRHTpn+NChCnGF8B3KL8q7gbzezi2wgLMf5lIadc//acbJ/BUhtccBNGO?=
 =?us-ascii?Q?DG+RfKGwhSMC3+Qs7yOdiGijcPwHwi9tBtGK502y/ky/fgEay+TBr+yalSL/?=
 =?us-ascii?Q?0jbt4VHX6T2HhQBZwY=3D?=
X-Microsoft-Antispam-Message-Info: +KF1V8Kbh1vtnkG3L3wvaOxMiAnsSA59qNh71PVKIEEEv96EgaU3WAASDEP4vegybkIbfyOOqEaucYD0faM18jhKUv05M2mq+2phbAInz9A5DRVW3DWGpCLdZJ+cLW9nJ9htT4OyoJ5HvRIeugS+BQ2cIMckqVWoUvhQIBHzci1Gy+QQ//+QYdNWJCgRSU6k0xAkwDFwBrVv+YSKwcuCY6aksmZ/p2gwwiOeO1AObYYLngM34E20UUnW3X8KJMVSoE9XZFzs2XKwDoiz7SoSkrM9ZtOalY+8jA3GWgfHaTB15hPOZjjMZYYUdQkxHfvoDt1I8DzNAean6zg+GJUcB8T83/dda4ZCwyWK1Xzw9a8=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4460;6:Y0OW5bxFlOmZKsYaKCigo6m7dzs5XUYKbycmDSPFGwexbNRXl9H7SDZO+GXGuM2Av4hP5pdMPGMsDvSrrMXi7bMPhcl80eLXyScpwXZajzV6PAEYw9Ja6AvjnO+DLU+hzzTaeAg9+fnaQShiyEBNDFrZ66dUAyNc+gF3xQEhZiFiK2ImXAWlisRDbabX7iw2DMkuDJW4esxZbAc5PlhecuvWDGGEpNb6VNZcX6n4MzzYbTjG5ZADkN7R1H0KkA7wXS9IemX9PqG+MNWN8wYDhi2CEDy5kHPMuyyTXRwvIKDU59qXDE3J3eGsRNUyR1f1yTcrHOKtFX8yAC/cj3wG7GZrNkS0aBrBJl8BniQZDanoaeS1BPA1ARpnSlPQcTcGeqh2Ay+EvYHbgPKoPr1HcGVNf+EhB5jhIVazh03K1poSQke+4Pyz91s5anavgDp2sfEEzr/NzO6WXXtUmjNNeA==;5:Yk9o3UW5pe6Sqwxl27aPHGAsXAbaZhrYXeq0n2qnbU8HMUG3IqqQpDCxhg8xPbHuKcHjGrNX0fVINrej+3dnivg6QEVOKIPybvtOrhiOnK0UpFV8J7JZJ9CfyxHpQkUj0vmgBwrC+0DVLQuPa/s2+P5FQoOEorJ/vrploJFbuQM=;7:zNrPE5Mbgqd5eBbnxaOm637/55m4w7NyNHcGG8SFGt4a7cjz8znx7ch8fWW5bh5jPcIhm32ukqvebe7gtfybTHC2IlwI3DJJxVnrvwRhz3ZsMDW2BjjXB7lzTzX27VHKjs7XaiZaVe3glYmoeMECrJkTGhfWa+nOpF4Pn6dJwouxPT0TKa954OoxhNUG26iXySNmLh2LPSEMdXhXb0q+6+I2QzlnYhT82qX3ngfX0TraptHobjeCmBcEAW6ftOaF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 12:25:05.9534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6dc72b-dd1e-4017-28f5-08d6043c7719
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to dwc3 databook when streams are used, it may be possible
for the host and device become out of sync, where device may wait for
host to issue prime transcation and host may wait for device to issue
erdy. To avoid such deadlock, timeout needs to be implemented. After
timeout occurs, device will first stop transfer and restart the transfer
again. This patch does the same.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v2:
	1. Changed STREAM_TIMEOUT to STREAM_TIMEOUT_MS as suggested by
	   Andy Shevchenko
---
 drivers/usb/dwc3/core.h   |  7 +++++++
 drivers/usb/dwc3/gadget.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 285ce0e..f58640f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -619,6 +619,11 @@ struct dwc3_event_buffer {
 
 #define DWC3_TRB_NUM		256
 
+/*
+ * Timeout value in msecs used by stream_timeout_timer when streams are enabled
+ */
+#define STREAM_TIMEOUT_MS	50
+
 /**
  * struct dwc3_ep - device side endpoint representation
  * @endpoint: usb endpoint
@@ -642,6 +647,7 @@ struct dwc3_event_buffer {
  * @name: a human readable name e.g. ep1out-bulk
  * @direction: true for TX, false for RX
  * @stream_capable: true when streams are enabled
+ * @stream_timeout_timer: timer used to aviod deadlock when streams are used
  */
 struct dwc3_ep {
 	struct usb_ep		endpoint;
@@ -691,6 +697,7 @@ struct dwc3_ep {
 
 	unsigned		direction:1;
 	unsigned		stream_capable:1;
+	struct timer_list	stream_timeout_timer;
 };
 
 enum dwc3_phy {
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index b3e9e7f..8cef488 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -254,6 +254,7 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param)
 }
 
 static int __dwc3_gadget_wakeup(struct dwc3 *dwc);
+static void stream_timeout_function(struct timer_list *arg);
 
 /**
  * dwc3_send_gadget_ep_cmd - issue an endpoint command
@@ -574,6 +575,8 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 			| DWC3_DEPCFG_STREAM_EVENT_EN
 			| DWC3_DEPCFG_XFER_COMPLETE_EN;
 		dep->stream_capable = true;
+		timer_setup(&dep->stream_timeout_timer,
+			    stream_timeout_function, 0);
 	}
 
 	if (!usb_endpoint_xfer_control(desc))
@@ -730,6 +733,9 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 
 	trace_dwc3_gadget_ep_disable(dep);
 
+	if (dep->stream_capable)
+		del_timer(&dep->stream_timeout_timer);
+
 	dwc3_remove_requests(dwc, dep);
 
 	/* make sure HW endpoint isn't stalled */
@@ -1257,6 +1263,12 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		return ret;
 	}
 
+	if (starting && dep->stream_capable) {
+		dep->stream_timeout_timer.expires = jiffies +
+					msecs_to_jiffies(STREAM_TIMEOUT_MS);
+		add_timer(&dep->stream_timeout_timer);
+	}
+
 	return 0;
 }
 
@@ -2403,6 +2415,13 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 			stop = true;
 	}
 
+	/*
+	 * Delete the timer that was started in __dwc3_gadget_kick_transfer()
+	 * for stream capable endpoints.
+	 */
+	if (dep->stream_capable)
+		del_timer(&dep->stream_timeout_timer);
+
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
 	if (stop) {
@@ -2486,6 +2505,14 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		}
 		break;
 	case DWC3_DEPEVT_STREAMEVT:
+		switch (event->status) {
+		case DEPEVT_STREAMEVT_FOUND:
+			del_timer(&dep->stream_timeout_timer);
+			break;
+		case DEPEVT_STREAMEVT_NOTFOUND:
+		default:
+			dev_err(dwc->dev, "unable to find suitable stream");
+		}
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 		break;
 	}
@@ -2587,6 +2614,18 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force)
 	}
 }
 
+static void stream_timeout_function(struct timer_list *arg)
+{
+	struct dwc3_ep *dep = from_timer(dep, arg, stream_timeout_timer);
+	struct dwc3		*dwc = dep->dwc;
+	unsigned long		flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc3_stop_active_transfer(dep, true);
+	__dwc3_gadget_kick_transfer(dep);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+}
+
 static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
 {
 	u32 epnum;
-- 
2.1.1


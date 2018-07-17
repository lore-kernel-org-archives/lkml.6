Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69DEECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A5A2064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SQM3yzBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A5A2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbeGQUd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:33:56 -0400
Received: from mail-cys01nam02on0047.outbound.protection.outlook.com ([104.47.37.47]:34528
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729838AbeGQUdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iY9q6XzlDsriWHdrcuaPTnv10bXo5ZNfFWWu1fIDmys=;
 b=SQM3yzBIoh8qYP7cqhp6lPRcipCr/djr5IdA1R4BF4s8HsbNUcUAt6AC+EpuvJX/Wiyayp+1GZuF+TJgYKtxUo0wkMHF8rh3vNKG2T4WTGeWAVdw+WAVM7tfME8D+uCYre6HW7gr7h52tWupVIPOASrCW58zELm5OtVNybm7ipk=
Received: from BYAPR02CA0021.namprd02.prod.outlook.com (2603:10b6:a02:ee::34)
 by CY1PR0201MB1915.namprd02.prod.outlook.com (2a01:111:e400:527e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Tue, 17 Jul
 2018 19:59:34 +0000
Received: from SN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by BYAPR02CA0021.outlook.office365.com
 (2603:10b6:a02:ee::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.18 via Frontend
 Transport; Tue, 17 Jul 2018 19:59:33 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT020.mail.protection.outlook.com (10.152.72.139) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Tue, 17 Jul 2018 19:59:33 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:59432 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ffW8C-0003Us-O2; Tue, 17 Jul 2018 12:59:32 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ffW87-0004zI-LC; Tue, 17 Jul 2018 12:59:27 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1ffW85-0004y7-9S; Tue, 17 Jul 2018 12:59:25 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v10 03/10] firmware: xilinx: Add zynqmp IOCTL API for device control
Date:   Tue, 17 Jul 2018 12:59:00 -0700
Message-ID: <1531857547-16652-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
References: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(2980300002)(438002)(189003)(199004)(16586007)(50466002)(478600001)(9786002)(4326008)(39060400002)(2906002)(47776003)(48376002)(54906003)(2201001)(5660300001)(110136005)(77096007)(356003)(305945005)(36386004)(107886003)(186003)(7416002)(26005)(81156014)(6666003)(72206003)(8676002)(336012)(106002)(8936002)(63266004)(51416003)(76176011)(50226002)(486006)(36756003)(446003)(81166006)(426003)(476003)(11346002)(44832011)(2616005)(217873002)(316002)(7696005)(106466001)(126002)(107986001)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB1915;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT020;1:qKgH8tBy0M3Q1l1ENcuEjjyXifOjtPfOohTJEOjoZZZyniH4zbPwGbioqxU41fKsyXUmdbY7pYoQMh2B3+DCRgOkvt+/fEqVxutfigkrvQtU9yqPbc4997y5jdNZXIXL
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2c36276-5ecc-425b-8af6-08d5ec1fd0f3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR0201MB1915;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1915;3:9+3zKUhWqbEmpWGjdsa7oh2EW0wTuJ2uNjY8sXxJcIjSwmeCK1sDiT2Hs29YC/XNJsUZQa+S/lhJrNll13L36SB6F3u0q0S4ol4fIjkTATZ/sQvbdaPgMjJrDfeuZkSyweOKYZUki6mHcm5R79roFLsxLbGpZItcIv6XatrUYt4Dk+YAZwQPf5myUTVzHd+g2uFAqV94DxWq+XKLxWr8llxxlX2OjTVoUGQ3Fts4/JGiJMTvXvLvujFgwWkjdwBJvlj4ZY6CP4En0GggysRdB47uXM3M/OsA7JSCKg1k5IFLmNmsdqTqoFLKGhcoFzd/3eoum+Jon1Xx0EZqjjTJD0ZSI7JeRAAefYwmIHj341U=;25:TgUByRiLOddIhuWtnl9I19DCo8N3eiIgZ4LJhpmXQqr5zCx3W/Aog/iH7NurOJIrXxGsdbZi6dRQuoL4e16Rs2zCU6MwGfwQBTPPMkFOM5wlQZn5g/JpAjOQCXlmscMk3oD5nNGM8dVu2lBpqvfSaWnfAfuteIXglBsjZGCYiIBZI5gzioYvQWlff9+B/rSsoQ9jr1p6qriOFIHQaPgzPBLNmIhRDS+Wn97WzbexX1j7j5bFbRTWNVIDK9LEHMcK3BNIC5BwnD40akM5belxci91vivjVD4KuS3nqDlo5q0752km1BuKdc8Jf8PLJft4Q79A6Hzim3yKJig4VGMBbw==
X-MS-TrafficTypeDiagnostic: CY1PR0201MB1915:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1915;31:WiTYrENk0dduyDrWEkJZbd1S1w9crUKtFO78ZXRodzy2q8tnspnOYG6h6oXuerWB0RhFlXfNgKwciWVktzkarzd2DycYaS1FJmHSol7TeuRGUM1ujqV5VbGNpqPPOC993H7d//iI9CBUpZUKS3MEPi9BIZkihYm6ZQYYtUX1OJs8BmJHEXdRxq7vEBEQ4Bs05qYEq/GjkdkrwcBS1LaSP/PFivvfw/to8oTaC03vfF4=;20:7fSZvPQJTUFNU4Uq5U7kTJmYxAnIykoREgxoU37IXHkwM4HIGLYqTYzUm1Ac+01SZZ01uyF6YMnkKt7pSCvldRRerGMExzTMLPIwWwC81WCYb41LtxMuBFDH0EIf73h//2O4S/ubhQ4l5NkL1vr00SKw1v+zd6YzFWlTKFrw3AZYOSe8w/EcfxZvn7RXK4x3h0T9AKUOUiWo8QvY/N0Bd5sYRhOSDD9J/bt3HGB57JHytrXpfkJJ6CMmmRa9BA8yiu+UK5qyC+q8aQApqB7UqCpyZ3Sf672Ynl1Gq/nAXu4l0LySnmWigFQEl8eZdSJP0Gt02YmDYbrAFYbQJ9RSZcX4oxCe7HoeMZYhU4+Y1rcSWPOg1+13K++Gn79EXOXfBwGoLfjyHYRncyCGULV9H4u8vk4/yQEKFPQbM5jqbnQpbNSt5lNGFwYpWEXK1kSZ4N16wF/+FmRC1SVx30XsT+P0fjFKmuFQRFFY7uq3k1cwvDwdMnMFga0qbQZ2fnxB
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR0201MB1915E4147D1D200DD29DFB71B85C0@CY1PR0201MB1915.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR0201MB1915;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB1915;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1915;4:8ZDKEiCyi7j7LO2KCQO9HmtlZMQZxKjtuCfVvJhdd0h8VAshljc8S2Nh0EfgvNmInkGaD6rCx0uZ3/UclYLH3D2wZQYSDKyc1u6lsf6wiMuuGry7M338+9mJJZpZ+jW3FDqAOJjR4Fw+47aAsZKHxAD1R/i1iK28E76HwxgcGiXcSViWeZEFU14HzJhiTONCFq5Phdp3tOtz9LHoS2VCUXNDs7xTqnNsn0T4glw0jh1ffz4UAsfdO/CaVUPfQutWlfSsh1bsFf7SZ3WowvEX3mTmaC4X80JlY13WYYmAPQ8MLovQKNJKhBeDyqOYQ6ND
X-Forefront-PRVS: 073631BD3D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0201MB1915;23:GXgUAFl147QoaNMK7bI8vuwW7itMV6FvzGzsUGf?=
 =?us-ascii?Q?SzNxCnGuP8E8nvTe001jesPwOmHSGYGFx3d8ka3X/0EzxCzi9d/92DFJlk3b?=
 =?us-ascii?Q?gbhx/YZHlwwnA5VXf3qRj4nTpkMlRmyi+OBKOdpYPkvD2FL4r2x6NBlC9u9A?=
 =?us-ascii?Q?3tYZ3tV4A11yTMAZ5luB4xVG2qfj0bVAT1AovpX2+2jjCfVDlj7PHRF76VCf?=
 =?us-ascii?Q?0t7BDTcFIEtiCYMHJHcpWahEBbEjzQFuGO/H5hupUNE0sq39Jeh+7Le41byy?=
 =?us-ascii?Q?j84KffEUgk7pcSLvFLXXqKUT4ZGlIwxJdqJ6Kac3YqOxkt1LQInQpbjA0QRt?=
 =?us-ascii?Q?jnfaJHwLZ8Jtik6uUUMMU7qhXghCUfMX7G3nv1KDRY6ZdZZ1DKpKtnQlR7WL?=
 =?us-ascii?Q?ceV+bfK4MfiYUUj4yIeZoOl2wkbO9Dj92fEYsXWlpPW6W/N5illJ9dCZ8gwt?=
 =?us-ascii?Q?/ZAAO4pOJeHTm9/up/fqed+NI5DfHubqg5ZldDh9HI+jvEzLOeie1Fvwxgqy?=
 =?us-ascii?Q?vPNiCxUwxSAnxObtBlP6NE9taXEm6fEl7EMO0GzWg48NbFSCC6ecFoMndj+f?=
 =?us-ascii?Q?5SqM5WekIY7bf3ly4bw+ZoBs/Z1gtiOCLV3EKaFZ6OSafEjXgR5YDZh4qQA7?=
 =?us-ascii?Q?w0RnCsaBgQ9O3emYchVzT6BtTNENxm4/mXWJsdI/HQTbTzJ/sy0UauXhrlev?=
 =?us-ascii?Q?fD7Gz3tmQ6dQuPYzwu51ZUe4ZHBuWdXPpowjRyF3T50p8jynqlTTcCespO98?=
 =?us-ascii?Q?CkMBdVEntupkDakbdkBVCfBsq80/XwHp+G7U43PnFPDix0K+aICn9i6OVCG6?=
 =?us-ascii?Q?t/M+9W8EAQDLDHlgwgzvKD708Zotw2p/q52c2vqKdMkABMJ/QRC/ZEIisTzB?=
 =?us-ascii?Q?SnkUkHZTzb0YqmExrycQsWe8KFZwGJGsaMpFp0Td3qxbs5LziVnnwgGzPt1E?=
 =?us-ascii?Q?iJda61/kqkRDUkfs4jpjuloD4iJbuC7D0VaaVEgN25b1aRfaNQLxNTmMcJC4?=
 =?us-ascii?Q?MS4W9KR4cv0vgcTC3HeAET+sdsVxPvTNI4/9f8xmOF+zimLhrj/QyHbMnLpw?=
 =?us-ascii?Q?oiUntDeCxMDTmImwrM8ae4E0niPghpugbXJEHs220Jvay47lVUzKiOIW/RLO?=
 =?us-ascii?Q?7jTLfQcC3UKlh93/vYiFdYrSMctEcPJKZULK5SMVKiAuPoJTPqfz/4wAWdz+?=
 =?us-ascii?Q?xTonSAtOvRsEl7/OCV3dyhzGuJeemx1Rpw4SZ9xa22Tt5ty2TO51+rCgG5PK?=
 =?us-ascii?Q?l6GxoyoA4KHYGCDr+zWWWx3xyBzGs6c9xyS/TiF76oC5+pW4A+hBnow/PfoG?=
 =?us-ascii?Q?r5Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: GUbc2fzdk83NE8o0bZ6HS6adTpErVf+I2RP8VmkeEwbvqNvSp9YZil1Hz8wJPXuKlde4L7+u4gxij1R695dpybuo7uwyj1XWl5WNXjoc8Irrshg5+W0Uu0SEFPjtJnCGQLLiGVXio8negBQKlDNYsUIgxE8//73boxLDs0dHwGH8N2X96q33b2MF5QQ5HP9fEmaq1o0+MEuJeR/SpFxXNa2yAgALVjG+biNhMMu5jQ6NdnsdreM55JBkHfCaY7pisk2L/CACYH95QarWxesYJ8akz/eQJMFj9JqcT98b6U3R9hKYWmF5QHTu4+/tzytSo8wkKJtooMMbaqB1CqjOidFB13YtEycTgliTgnldQ7c=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1915;6:+3JX92AsjMthybluLsUh4eb3yX6sRXOLDjCBAbnltR3DV2c6XXFOX7GicUkOQxVHLOSxRbZMeam8Ju2hwYhGk3zdlM/c+NGIx6FdfH/BzCEa0KktM/9hzxF4QlmiIxqGToW02zgZCfNWo2zaqeFiC91EPkWYCoVHETwJBntqoIaI17/MTQEaJJqPbmdbGAjFjc5B/IaHSoBrJdgA56Q5OQseEryIdsWbizN2dNQvKdglgbESV/pF5tcmXVGgmMv2Wk7pJ3lR15MdztZsu2bkmGOptGGLiF6axvW4Hjie7ULehXK27q/sfVENgMzIRAhkCClSCChnSBcAGKxyR6a0DMDBHrESHg+PeK413oEBclx8NdTLd76Qu/qZjxu0BDWJ1GDIFRikpHWPdBlWrecnqGZ7J03ttMARo4b8nG/nzWVNkCbavu9l2SJvcsx5WeiXP49uvOYu8K+wo2+A0M/iZw==;5:lOWTupBGeSjemCCNTPIlxYpLlozd4dilsJmrhRvyWM8g6k3UP6Smnm8cn7o4j0nHH1aPciQ0VkeVcA9G/EI7asPhMZBolGaVgjHWlTYmwHmtasEHYVD6DxVQjKqs2soLrfpa9wKMEFP1J0RigcJWK00oaKzYSNp4JUvAHhYucWQ=;24:jpRJCZ71gq6hvVjas93YImdnJRklhcQB1lg0pD9hBIOYkJD9flsls1560/Fkxt1reBjSuB/0txBIb6jPTD8JeiEP0U0bnrFo3JInQcjI3qg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1915;7:+90j9WvNtKvvLypJoHYdeIE09PqCzUmEIwFkTZ6nkt4ulJ6/LKlaQTTmtFOhG58oTZ1vg120sYdEJg6hMBkGet8PtUw6mp4FLxfI7X0iLusCAI9pv+r+8SJgBK9fllU4TVxCM6I+fNV/YmHQfrFf66LvtWBWe8FDSn43sDcWtuW5cfFPxeFJts1JLpkaaRGuZh7+sA53IBQL/7yBWbz3x2K0M9aa6MJTEPLdlcvZSSvDkYBnilkLAh2tm+fW8nvt
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 19:59:33.0931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c36276-5ecc-425b-8af6-08d5ec1fd0f3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB1915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add ZynqMP firmware IOCTL API to control and configure
devices like PLLs, SD, Gem, etc.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 20 ++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index edbb84e..24cfd9e 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -241,8 +241,28 @@ static int get_set_conduit_method(struct device_node *np)
 	return 0;
 }
 
+/**
+ * zynqmp_pm_ioctl() - PM IOCTL API for device control and configs
+ * @node_id:	Node ID of the device
+ * @ioctl_id:	ID of the requested IOCTL
+ * @arg1:	Argument 1 to requested IOCTL call
+ * @arg2:	Argument 2 to requested IOCTL call
+ * @out:	Returned output value
+ *
+ * This function calls IOCTL to firmware for device control and configuration.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
+			   u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, ioctl_id,
+				   arg1, arg2, out);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
+	.ioctl = zynqmp_pm_ioctl,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index cb63bed..2eec6e7 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,7 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_IOCTL = 34,
 };
 
 /* PMU-FW return status codes */
@@ -49,6 +50,7 @@ enum pm_ret_status {
 
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
+	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4


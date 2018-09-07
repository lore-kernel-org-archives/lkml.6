Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B407C43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9DE20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="HEAYgCYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF9DE20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbeIGR4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:56:10 -0400
Received: from mail-eopbgr720060.outbound.protection.outlook.com ([40.107.72.60]:52718
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728940AbeIGRzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13WXSV5LKrEa24mZuJGWiqdLNayhKK9pvhY8M8UxAf0=;
 b=HEAYgCYD9Lpm+nvUQ57fL1llVVZQiN24LF1obyv9k4QAqKVre3Knc/jphvP4d7mUnnA5DPr0rTXNaFVHl5ocJmMyZGcq4XbCHthRNNhVjFGByZawO3DujgW5VgvUTvyT5NXnM8ahkXI0ZpgqjsDDeTSIIai8zqBpAKiSm4MlcqU=
Received: from MWHPR0201CA0050.namprd02.prod.outlook.com
 (2603:10b6:301:73::27) by MWHPR02MB2688.namprd02.prod.outlook.com
 (2603:10b6:300:106::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.16; Fri, 7 Sep
 2018 13:14:20 +0000
Received: from CY1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by MWHPR0201CA0050.outlook.office365.com
 (2603:10b6:301:73::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.15 via Frontend
 Transport; Fri, 7 Sep 2018 13:14:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT018.mail.protection.outlook.com (10.152.75.183) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Fri, 7 Sep 2018 13:14:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46036 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyGaZ-0000Wg-LR; Fri, 07 Sep 2018 06:14:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyGaU-0005mb-HQ; Fri, 07 Sep 2018 06:14:14 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w87DE5uK019320;
        Fri, 7 Sep 2018 06:14:05 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fyGaK-0005lA-Rh; Fri, 07 Sep 2018 06:14:05 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 01A4E604DB; Fri,  7 Sep 2018 18:44:04 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v3 1/8] usb: dwc3: Correct the logic for checking TRB full in __dwc3_prepare_one_trb()
Date:   Fri, 7 Sep 2018 18:43:42 +0530
Message-ID: <1536326029-16327-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536326029-16327-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1536326029-16327-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(2980300002)(438002)(199004)(189003)(36386004)(4326008)(103686004)(81156014)(81166006)(8936002)(50226002)(5660300001)(106466001)(6666003)(107886003)(63266004)(6266002)(48376002)(36756003)(50466002)(47776003)(39060400002)(52956003)(15760500003)(110136005)(42186006)(316002)(76176011)(2616005)(476003)(478600001)(16586007)(54906003)(486006)(51416003)(126002)(305945005)(356003)(8676002)(26005)(336012)(186003)(11346002)(106002)(2906002)(446003)(90966002)(426003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2688;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT018;1:TtLWgrDz4Ly96pEnQ3mnQ6VaWQuefBsLUmYn1dDUecIBJrFM63cjOJzmWyQmicwPYa6zzIdeXAs60E/rRTwujmMl+G/GGX8QsdSumVhSkamfO1GeSJ/tZKFd9LBiVpv3
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cecfd47e-0fa2-4989-4d5c-08d614c3d2a5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR02MB2688;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2688;3:mti6ajZXtMBAV8Qc0Ul1GFZOb0N3O68oQWWC4tHIn+nNEbceh7wTvjVML2TjjOUQzs0qVxqmNkgVSjdLDj+FIFcmG3NPbecxsI4rj1SpkcrBDEjpAjwKR4ZWvJjvuvaWcGknK+5fjSIrg+BdfiD3E5jHKB8RAIpkTcEIOwvO2HG8hFGTqZtCxCawBzoh8NAirqEYoNV8c5oBXUJrlDdiX//dCYdB/R6R5wwcL2cDLWPKRo+/2LdNqa1MmnSgMinup3uVrjkOCNvAYCc3cAwWC4KyFMEoAwQg97WkZr+qiM9aIep5lio1nMdiMZLhXjzH8W2VBm6iTsTsGJQc0UauBusEsek8I8s27e9QskjHN5o=;25:iQ6MOUyDbhGyAMPc8NArXMNCl7UTZKXbvtgDZsxEFB90Tp+g5Fwj1YMpcL6iAStywzEgOlD7BhpnNoLyoog7L50z2VkKTpca3eMU2kNa+fl/9HEOvJN3SSkhXYjFicjNA+DouthsDbKKldwYZ/TttwYeSwmqfKMyqDnx80y6nZtIETMX2j1jOMK788B2TdWHA4iu+vrWDiIIOyhLrtZDPBbCMzX9jdKvXNu3i7FZrmmFptVR3daiVaL8I15uqZf2ujOFjR8YL2jH1BAl1yiAQhS0duGnYrwbqIOWf9kkEzLz7/dYuFS6iLc62OAxXUgtFM/ZNSpDYAQmB43tDzmNgQ==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2688:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2688;31:/zhLJmGPo2LhTiVstjQiycqLmhdNRKF3f/ekr94Zd9zXB8w6lGaubTJeRmrxPbcgKs/XAgMrRZDw3riG4MIgzQwOKUB/Dqe6934Tn9c8UEXjbXJZg+BNdW9+WUFQ6M76ZQd2O3t4OB80Mljj1Iw7fiWiwOUwHIPISXfBss2Ywyw0ck4/2Q0up9o26IlZsimk2smAQo3qon2DlONNbDd6WFYzY4LhdIZp/iPpaXFnyko=;20:OXE+62xMgBMiqy6CL4xfEHp4QD7ZjOXrnr8GfBpcCJ6mJB9GXFeN6ZBRuZlD4sF2VwXva22ybo0jExhLnkej6ETdiJeiBZbxUvO2v1NAtJWjquFw3VkzGs0q8dgMT4QwK/JwHPDKx2h7ue2Z57z7ePKmUYiZjlDb6qelXfp17ZLdR8JNYUzXBz2n3w3jTWTLtlulJ3PREQS34ptWxKDm8uNvnOTpI+QXAaNRegbEnvTegib3p+JppCp4t0R7cAbJQaLD/kOV/ZZr937+bD1PZPOrR3ch+WMRW4fclkFqFtkJV1AommSJcXhSx0gvUjKA+Yl4OkVDuFVuQ9oX3hVV7YtrrNPJPex2eF7p9Iz3wV9xq2U2115m2OA+bQNwrhW/7yYVvzdmV/aZOtnMXbjHg2rsGWhi6H2gBv8dBcGezW6M/6/DgaZ495tj2Nkdi5weNx3EnSFRcATyImO9LN/5cf1UlRywbQCYmgBjXNaym3wudVgnCAfmBcl6NQpui2JD
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB26883DA51B29F3B212426718A7000@MWHPR02MB2688.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699050);SRVR:MWHPR02MB2688;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2688;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2688;4:a+ih6hYXQn9OPF9Ilnx4eyZbRarYnwTE3tHny6GrlNmeFG/glrl5m8xtnzbWiSqh4lRM8BFWOOm6DK1/8pCJrvL6GCuCVwXKgeywJM3wQBRFDUUHjWk9F0MnRPP/C4jGGoXEvd0jcS51GdDpIFMMPuEaa1TonY5cKbmgSl+mdI4+YJz3zExR8ceEVe3iQ897WU4dRcGChMvPGDngzMpLLcGnpURGZ/wYkvnjy9rPCFIy0XmfPB1li1EpHfXDBvwEnnkLbLYvtnZhntq0hth4CIBBrayha4oaHSllbsVcrZEZpKWHbX2vFsJb7b4GCFZ/
X-Forefront-PRVS: 07880C4932
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR02MB2688;23:6+HjbUxEmEQ7tmZndTww+KhdJPc1dfAgXfw5s14wG?=
 =?us-ascii?Q?KpHLEIC4rAfbkZmJIdiq1B4p69WVkMcBIO+QBRAl9ltNx5FkapY+ufQMawo8?=
 =?us-ascii?Q?6S2LLKTujU/LnV8xkwZLuK/6nZe8hPZnof1H2k3j50xwRdaNbyrNXo9A/neU?=
 =?us-ascii?Q?uzhOSX30oIsr3SrOap4Yq+22qJCJIPdW3A1pD3fan9EZNNQVIwyiEq070NTA?=
 =?us-ascii?Q?g06CI04XP+6hFVDTay2M2EZ424lDuZu2VSfLiBd84rlbkR7XQ0uFRbMLvVXZ?=
 =?us-ascii?Q?ttEmlrFBYQ2Ztdb8dAuDS3lMbE+X+uWTtPyrnu0K6l7UcMxE8mrPZiKvRMhw?=
 =?us-ascii?Q?6N8TLYe6fj9MVcgEKLuTsiFFxDeLzsR0EIQTouP0xau3p/r9RrUJ5adIc1v/?=
 =?us-ascii?Q?cXCWVach4PEK28q1eKCzSi/s/vroO+Lb8/G6ncvyrZDZNBwcK0WwgHccJDjJ?=
 =?us-ascii?Q?dQPGIEBepPxKPr8hznfo7lcLz2OY73RogTOh4EGcUyLzcQ9v79GsvRovVYm+?=
 =?us-ascii?Q?ZopE2o++x0L/guDs3TWkES3FFcL1JDbl21w1p1dDgSoEOSXTvy+zTJN+L6K7?=
 =?us-ascii?Q?9okQdW3a8bt4CgGxM7J7Uh58EgB1BVz0CH6DYbzOIENRIxW2e9j7GgA8IZ3b?=
 =?us-ascii?Q?Nql1NvUkSaN4t6ez918AZTiD4vDz3mU6WogRlJ3a2laL89O3GCmsli0L6IQ8?=
 =?us-ascii?Q?QQuMVkg5TGHOHSAaPL1ewPhrnlSPb6YUE6d24Jeg8dOmTQeH9gHOZwB+lxuA?=
 =?us-ascii?Q?1N6c2TUhVXL8Z8a/sAr/iAGpPPVEKr4mA9Ph+pATgl2W4h/r6qrmBfcx8CK0?=
 =?us-ascii?Q?yIKujUoOi9fGH3iA0N3fnGAI/6BTHqGVj58yaJyCFFCp/q+7asXngEHa3oSW?=
 =?us-ascii?Q?bhlfibigpaKd6Qqds0FP6DAkt5v8/wQC9pOWgLcVhB9GydvqbDKM3lDdUtJY?=
 =?us-ascii?Q?tPLQ+ZCOr4KzUrjnsLEvBRB4hVSzNiarv39rRs9ubWLiwtjhxyazX37cqxU2?=
 =?us-ascii?Q?i+f2OjBoPBwMpPZfN190MLRWkm3CGZTT6yd+Pz+qiSM1ZmTLikldBEpaClw/?=
 =?us-ascii?Q?Br8iiMkefiqbIsskSM6iV48g1wToQnxRJ6IbQcoc5Str+U+XT8bpW9HuKBQm?=
 =?us-ascii?Q?ypTjTFGBr2rSTP9WULQJukPds9uWtv8ayB0neWPb9MiPzVAI9mfcszL1xqI3?=
 =?us-ascii?Q?m0E9cUMIRZAGkjUyMusaO1foV5OkCL7P7AfSi7hOUecTCunpNmj/j0j8g=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: R/D+bPc7PcoVWJ/bgR618bBGJupPScPXv/mD4j6AIlW7zrrtTlqeBCVJibmMocdxx0Ti3zQ9qNud+/UIEAnTEw4jWZ5eWca/1gcMrF/8L9Stwq9czd1ERveq98CYtJIvYpGRM3qcqeMwJuP3K20/Wcz+15CgQRjV53nLTn0QAB/DgmmZJ6FBWqMqoE++UbHHHC0BhnHFYMCvzdsF1VcD5QisbniQ6uR1EPu+JFdEBYznQX3MHG5Yg8E+thBjLxBrYT40+mk3RodsEBwxTmySJX4e6SKABsq4uX6/KQT5pltixu8nemOD9gu7mMY/yUQosXOLQOL/jfau/C1wu7IME+FU5biB3/0IAWvWk/ePNCo=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2688;6:HchSjxOHih2wKC66lZ4yco33+RI2KtujNuAev72aDwpFHUgC4GAZLOEunxgCrIFLaiFH5OOlfSHHelpPyUULwyQ4/RNIkXv+z/GIUcf6BC6Q/G9T8A4TMcZXN9lBCNQ0pSP6x97/sA9W3XnVuNfiht5jMeYo3SD2fR2mm25AYo1FxuYpUVln+O43va4qMTkfQ84zxTweIBgw9btUOSsQbvTi7hz/pr51ql89iB3zp5a0bTJnou+kjCuBziu196TLhrePWL9kt+DdGTigdjCkUNmukZc5qmQidc16THO5dQ8dmwd6ezLOrkiGsYNUufvUayHHg4xeZXtbgaIIHCiPlG5evKcI+PnsWMRxIBuMg5ney2DbWjMI5NfOSfn8e+PR0sRAMilmQHLi4AvenmxJKKTmZmhC4SMET24W6CM7c9pjxtooOF69KVKBVUSde8NWvfOi83dRf8u1/fzAphPNNw==;5:5uvcyClpvsWsHfkr/WD8wf7ydsGkpDBFZEi6Dw+LNOiSwDlTat32pEpjFDSutPQVKlbgKW5BdvQZwMb/ve6zwMQdRro2JIYGD4JLbxccLw0HOMP53FMvy8P8ptC7pr7KpLLBqaWCocHakZiDTTLKmx1vSYr8SHmRoFehfafI/Rk=;7:9BRGnJ9D1t9R+mBNadl7a9WMYU66wIssH4oaC97u3KCxV7gtRuKeNnXGhs7U3iSpviRmQwzUKc7FnbaNzLA92PgQVqiYovsJkzzmRF1MaxRyrY82f7mGLXBwy0gRk4k/2cmJtwdx895FpsTfPsdAwDRosZJIzUlPM9I2+baVpUUaKyMnizH8K5o3y9msXV7Lhup4WgWIKvfJJWL2RAXbH8XcqSgJamvXPwC89eols01N31oRw41x7XfnyThjln1e
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 13:14:20.0980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cecfd47e-0fa2-4989-4d5c-08d614c3d2a5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Availability of TRB's are calculated using dwc3_calc_trbs_left(), which
determines available TRB's based on the HWO bit set in a TRB.

__dwc3_prepare_one_trb() is called with a TRB which needs to be prepared
for transfer. This __dwc3_prepare_one_trb() calls dwc3_calc_trbs_left()
to determine total available TRBs and set IOC bit if the total available
TRBs are zero. Since the present working TRB(which is passed as an
argument to __dwc3_prepare_one_trb() )  doesn't have HWO bit already set,
there are chances where dwc3_calc_trbs_left() wrongly calculates this
present working TRB as free(since the HWO bit is not yet set). This could
be a problem. This patch correct this issue by setting HWO bit before
calling dwc3_calc_trbs_left()

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Changes in v3:
	1. Corrected the logic for setting HWO bit as suggested by "Thinh Nguyen"

 Changes in v2:
	1. Changed the commit message
---
 drivers/usb/dwc3/gadget.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 032ea7d..8a1622b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -911,8 +911,6 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	struct usb_gadget	*gadget = &dwc->gadget;
 	enum usb_device_speed	speed = gadget->speed;
 
-	dwc3_ep_inc_enq(dep);
-
 	trb->size = DWC3_TRB_SIZE_LENGTH(length);
 	trb->bpl = lower_32_bits(dma);
 	trb->bph = upper_32_bits(dma);
@@ -991,7 +989,7 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	}
 
 	if ((!no_interrupt && !chain) ||
-			(dwc3_calc_trbs_left(dep) == 0))
+			(dwc3_calc_trbs_left(dep) == 1))
 		trb->ctrl |= DWC3_TRB_CTRL_IOC;
 
 	if (chain)
@@ -1002,6 +1000,8 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
+	dwc3_ep_inc_enq(dep);
+
 	trace_dwc3_prepare_trb(dep, trb);
 }
 
-- 
2.1.1


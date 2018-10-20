Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63078ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137ED21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ls6JwmBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137ED21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeJSQm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:42:57 -0400
Received: from mail-by2nam03on0061.outbound.protection.outlook.com ([104.47.42.61]:48059
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbeJSQm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNZBZsub4aT4q07le/ZCZv6brE8YdNyZQfMlfCbfMdc=;
 b=ls6JwmBSeth5aWkgsGy6NBb2womyZosQu+wSumxMFIB+DJWJfQ/0uqmu9gAdXDQwj3KCe5O0yp/rMPE+soMOZoVrPpnertMt6T0Fhn9xgssQ2Td3nF4kbdgcXKdZ8+JxL+AhrikE7Xwwqe/5Q+COfGFj/txcmT3VzYT60b0/tic=
Received: from MWHPR02CA0033.namprd02.prod.outlook.com (2603:10b6:301:60::22)
 by SN6PR02MB4463.namprd02.prod.outlook.com (2603:10b6:805:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.25; Fri, 19 Oct
 2018 08:37:32 +0000
Received: from CY1NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by MWHPR02CA0033.outlook.office365.com
 (2603:10b6:301:60::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1250.20 via Frontend
 Transport; Fri, 19 Oct 2018 08:37:32 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT045.mail.protection.outlook.com (10.152.75.111) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Fri, 19 Oct 2018 08:37:31 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQHj-0003NT-A6; Fri, 19 Oct 2018 01:37:31 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQHe-0000sK-66; Fri, 19 Oct 2018 01:37:26 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9J8bLRb000594;
        Fri, 19 Oct 2018 01:37:21 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQHZ-0000r8-2O; Fri, 19 Oct 2018 01:37:21 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <jollys@xilinx.com>, <rajanv@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Add nvmem driver support for ZynqMP
Date:   Sat, 20 Oct 2018 14:06:00 +0530
Message-ID: <20181020083603.27602-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39850400004)(346002)(136003)(396003)(2980300002)(438002)(199004)(189003)(8676002)(81156014)(5660300001)(81166006)(305945005)(476003)(77096007)(26005)(186003)(47776003)(106002)(48376002)(36756003)(63266004)(110136005)(50466002)(16586007)(478600001)(106466001)(36386004)(2616005)(8936002)(50226002)(9786002)(486006)(2201001)(336012)(51416003)(316002)(1076002)(2906002)(356004)(6666004)(426003)(126002)(7696005)(107986001)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4463;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT045;1:EoS8mHGGxEZqTjF5Bu71MPMO+gb3BkAyBYJoNmnDqelRV3QmJOGm9WKrBAISEO1MmpETmjNHE61b3Fhgu3usTQ20tJui8K0iF5Ep2mcJJ/CXBpED1lt2XXEyxEypi+oX
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7975e8e2-6093-44c3-2324-08d6359e1c90
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4463;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4463;3:A68HsH//3+NRxrgkhRPhlr4s7Ly3n5jV4JfC1jWC7ak6P4y7In1GXEYlN9dWK7BiMhiBecyBGmVyBzL+/eu6GItRn5E6lzMTkiwNaC0Zjbx97GM75ZbTntT+4xw/ox6ej4RfKwBZIFrfB6NOsYqOZeRZdEF8Mg+zBKm81191BGd914LGfjLzzYCHbXd+hGbw3RldJHUX5gIFoeI056xKhd+7A/FxvUBjy4X+XZYUs18ccTqk52LAucTz6E4Xx/Ix6yCUkPmh3IaHN6bag4MNR3BFh8n3xn/XnYfqJlxBRSnvoN2LDNJ4qzeYp9jeXRNdbizySHTI8NfrtBTAvpC9JX3s0Yy/mXdtzMV4iSvLV/c=;25:gWZoM2flC7YUx5TaQvP28DBnc2vUuTMk5RMN+pMrltEB0XbgbriMLcuQvQVL33nlGrRP94bzKw1U0yEYtCk7pupNWmXGu9wk4ku9EBmCWIrZfM5fF4so/8fGhNqQVHSF2IPxggqbjNx0B9vjt0Yoc9hoEWB2V2SVPe4CRfnxFKVh1dyEMJLMNzz0CRyFJR3mdFGma/q3XZxXV8B+86Eqw9ElE3yqi+8lWtCUuTpDZnIvNYPT9K8KV/RZ+I9oAkz+5uUpOEoYQA090rWuzqkQO4MQ8He/okcgZJmD2+USUnB08yBgTlf2VJkU0i3dlXVVYiE6sHwkCmbRlkrm1zAORw==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4463:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4463;31:XTkI7Pq+mH8OqVgeWTMRvxBqKYML6OpI9inZVcKIwQAX0Q6CAxHUUPPYqOm41E/rq1+hQjaQMPZ2dRMvZGniOLz3rEPSymmpa4f0X+HagH9KHlMXTO0P0e+AQGMTXNHYl+yrqJ3pZL4BRxRYluaJIFwB1d/ISxLYbf0+f31Gz5/w5BiLN2KMgcwKnsc81U3Momyex1uQZFt6UUjR0Mq/U3E29ZfcJrWsRyugx38X5rs=;20:8/bh65pXjN0Kzqid3ux2kxFIqV0Wtif4VDzUO+JkoL/1p5eMyEDXPpq/6nX5VIAT5H4O8DNtEj5hVFhyXhN4PhxMA1Ic0Tv5n5datmDdMaBbTyF8nDUModP9q2g+NExBsqsS+La7nKuO+Nc7SAwFQmpBafD7cXgLS4VY89sBlrCum0XmFcgU4wQ91u6oTXcaTmjnugBPqGfUV5IGjFw968RU0bOfEqiRl8i7+R003/BwV1ucDmmlFCERnpcHSWfQbKlchGYDCeMm6OkS/A+8rMaFHRnYDzWlLSTNdLF5hyvSkkbgrIqlk8HeQFPU6AKhySIpDn8IS0inwMg+GdcpaiuEj5p2Brxa/z6fkldg0YEra+9OIEcVhVKxSGiOfjyzRqELdEQVzuwYruGh5s9xhnu01iM4yKHN796MrefV+IKpI5yhIYZFcandd4inWm7BH43tAiaMKEr1CgyQVZ/PsTWq8enzsy8vvUxUQce2IK96xmgi2Do0Re9IFb8kCpPb
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4463E54C769C8FBE2C9C58CDC2F90@SN6PR02MB4463.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN6PR02MB4463;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4463;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4463;4:eMaL6/WCAdKd4vwsjIEOiMR0knXJdF33w/rWzVfUYAdlSvHyAFbP3C3Nn+zjgpOFkRzULOlqvzoGUc2ydNdqlKe7aUOVVhnvCWjOd3+i30hIJY3XcPPyb+yrrh11SFPHc65n0cRwXrxrxUUG/RBEqFwROBeFOi4LMa0UbLw0UWZBDXglsrTQB9yydA2aMTl4Xvbim4j9ke3qGi1qFDsO0tTFfw9BGVSK1Lvzc8r8A7iU7zexHke+i7FjYtcIpHZApOdsoBxVok4dET6AZgADAhyeZHqx2SdpVWyIf+ATPXOsmp5iI1oQeHGTSrHhE03w
X-Forefront-PRVS: 0830866D19
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4463;23:hLlRMTFSETQlXdgrFHfdpcPwle7mCPWCdaW43rLFq?=
 =?us-ascii?Q?h20daOEbz/0UYja79uWhsBICGm4GHOMZIdS0KET8GiV8J76gaThH2+BM2TkA?=
 =?us-ascii?Q?FU+vHDUqDIEHdfkvIAHccxyyxA0ZNRDcSirQXdqkF03BN1Po3LgoM5jnXuM2?=
 =?us-ascii?Q?ZoDYphX7zISZhGbnKMISKc5t+5VKfP7WkZ+v25bzICcmFRIisL6G/zs8s16b?=
 =?us-ascii?Q?J67TsnfA3wHJsk+jB2Kh4EbiwzNIDDnIIjY1M9enXGwl5zVE/Kgxx20ZeQq1?=
 =?us-ascii?Q?XU16b+Wr8LzmuRkAImqCqSZzTF8LurCtPW8s0yoQxWex7KbfkkGrs6mTLmFz?=
 =?us-ascii?Q?uvBQerv4gSE+TVT/erLSKiFifteDiSw2aniNQh0YE4LQRUA77/DgZ4qtkyOb?=
 =?us-ascii?Q?qOc+oCjJVHXw2gxJqqeTZ9A1H+7/80s2/8UoAPCDA5WtcxBnUmCOJzLaMvvS?=
 =?us-ascii?Q?QhFLpU6rvt5Ktx674+ypJ6Hte/WkrnO3IUGUKKo7Bgu6ABjiOdSQr9x6yXS/?=
 =?us-ascii?Q?ptXU75vDCcvwpMa1OO1PfLq1x1c4JEwx8+KSDoY2xWt6g6tlW7PSa+DVkn50?=
 =?us-ascii?Q?PbepJZ+hbL8f427U+mj8JJT3Rs5oRVx96fLugVx2wEcOxkzwWU9JCm9NSkEM?=
 =?us-ascii?Q?dFCgzU50Qn8BRFIPnxYjZXnqfUhqtpEpDTQyjbcEd6UVYhLpqeST8/w4+ReX?=
 =?us-ascii?Q?Asd0K1PI2KC1oAyG0bTmXmSPCy2zKuBr+rhbAP1UnuqbXMzAdzpB3H6RJHYD?=
 =?us-ascii?Q?kl20wnNtJfcXBvujcBL5YkbkXXHUp4CZXKb0b3cjGmaXXhUtYZMnIk8im0H0?=
 =?us-ascii?Q?9Kq8Oq0fvcgqL7ytpIIMFEDrrOCqmo0/nvmqdHMzqvLP+TlRkHph3JYGQhOm?=
 =?us-ascii?Q?RPGE54YGgFgk7HLmnhbU8VJaAG3MoN1NRzTaC6QfPKaKqItZSaDeYr3Z1DjI?=
 =?us-ascii?Q?cwru3ajEJ5JZ/yATFIC3A8eDxDZeDqeoEUVIy4SwDszXPibss0CYbz74MJLh?=
 =?us-ascii?Q?/dp+qKstN+Nv/OiTCj/NIOQysjwwXxOdMDiithdS/fhJRSKIGgtKdRSbNYxn?=
 =?us-ascii?Q?wKrBnNsyoJIjAQ9cl1ckbkzeq8oHAaRa/vXAWvwO28GXmvVcw=3D=3D?=
X-Microsoft-Antispam-Message-Info: NcjzsDaAdxWVVdW3nk4VYkkYJKyAQOkuLXz3qKfUSbDw5rjhg1jfezvPyZdzVvjaSpPfu6mDe9MPUnHFsBMFmu6mymUiQL/NQRBIhGJa9yZXsQ75mS1PvWy0CeVotR+KoV91z5MIooakMmQm/PNbDlC9FysxXUm5uGd78af3838TMKmk3qSeL40Oq2db9EkPJ8dLAuvxqFITtWgxsdpoR831tSjWgalY14PR58ExPBE4/NLHKAov9LZS/hHLrvt0th8jtmLBQ1cD4mPsisJ6UfC/GzyBB5Rbu29VTOUPL+5HWTtRxx2US4zd2e+4UgfSfEILVVAvTDGgRegMvDWH5aysqhQ5lqZv/NHTcgcAul8=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4463;6:bCXW1OG3emdSDT0pLp3D3Hp5DdUVYV51WnVFGlD56YwecuWxQVea1AMEHC0fJr++FwW8Ktgyo/3HUqdaC6tcH8sYf0reEOnY0Ub6QvayXGsnqgv4cAelBEFNd6wylqZ4YHZDTe1xcyQfwlOqi6I0hapdmp15kXBEQFxlJwvS+nQWbqRBdksBeJhXO8rW2RdSD8cBoZtPOw4qlgXY8uuOMCu4sKIhq7DerydmDg7aiFPCMs0Kt84eO+WZqzJl9jQk7+1dSIKtV291KyTdKELg/83Fz0SJEgDQXhI5tzYJn4l46/PP/djTSFLeK/heO6j1c7Nxw3nCMhitY4puUcTHcM1T06NYoYyoZ/FUO5+Ce2lqY/ugAz+tUPBqPuqxDNExM/pnOvlNmr7ESlC/0cB7XApJ+hnNQB15M29FYaLGEiSqWbIxMSbwM6nHpdS72iBK+wrOsnk3HbLZvfc579dvoA==;5:tJ8KysMYe/i55OrHMiWvW5dKsL1ALyTtq8gsmlll0/W+RGqH73PBME7bH5B6/qUI7JPqiH5o9OCnMTKfQg9CRDcQHYC5fFLLhlDwBJNB++myqvaPrV5VE8pKNQney7Jkn3HYIlxvi2UpPlF3/an41jxw9VXsy9jBSKB2RwLRZwE=;7:vRPFcM6L1RrcqZ3qbJP79Gat7N2WMHKQimWqy+gB2iOpSXzgWAkHnXkwetJ0k9ZTEO1GOCNc3qZ65xftaN5GAvbrNRhYKAlbQr/ma5DRtqdPXXLWquY+lsU8LNXL+gzXNKnXZ6oVW+K2/1X+s2bMhTTtDTgTSGIISFCgOVWQWfaUOg2HE+fYcU6qyfy2p43Xsj6raICm32l/4I80ZXj4notv3pdSoqMi9mcVyLutNZdpQ0X2tgn5lZLI8MXCxcKS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2018 08:37:31.5910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7975e8e2-6093-44c3-2324-08d6359e1c90
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4463
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches are created On top of the
below repo 
//git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
BRANCH: next/drivers

Nava kishore Manne (3):
  firmware: xilinx: Add zynqmp_pm_get_chipid() API
  dt-bindings: nvmem: Add bindings for ZynqMP nvmem driver
  nvmem: zynqmp: Added zynqmp nvmem firmware driver

 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt           | 37 ++++++++++
 drivers/firmware/xilinx/zynqmp.c                   | 24 ++++++
 drivers/nvmem/Kconfig                              | 15 ++--
 drivers/nvmem/Makefile                             |  5 +-
 drivers/nvmem/zynqmp_nvmem.c                       | 86 ++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |  2 +
 6 files changed, 159 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
 create mode 100644 drivers/nvmem/zynqmp_nvmem.c

-- 
2.7.4


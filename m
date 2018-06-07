Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rJg3AychGVt3OQAAmS7hNA
	; Thu, 07 Jun 2018 12:12:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DF7D8608BA; Thu,  7 Jun 2018 12:12:22 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="iDzLePBx"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 49A1B607DC;
	Thu,  7 Jun 2018 12:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49A1B607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932330AbeFGMMV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:12:21 -0400
Received: from mail-bl2nam02on0042.outbound.protection.outlook.com ([104.47.38.42]:39616
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753289AbeFGMMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxzuzR77sc3lbLozUgnxJOcCLzLT8+phZHwnP8Q+7bo=;
 b=iDzLePBxQyXefPNwdKfSapJlI4Hv+NVn2YeTynkzvF4wn2kg7CYIqyPoybWtbInXbAxS4tarXN6CoK5XHAb3aqQ79qE7p6mmWhrvKqangL2mUcCuZcBW1NXolG8gMcdORbuxnjN8qCo/QDtww3Gl7XDl2OT00WyK/RlKmg5++wA=
Received: from DM6PR02CA0004.namprd02.prod.outlook.com (2603:10b6:5:1c::17) by
 BY1PR0201MB0871.namprd02.prod.outlook.com (2a01:111:e400:4817::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.820.13; Thu, 7 Jun
 2018 12:12:08 +0000
Received: from SN1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by DM6PR02CA0004.outlook.office365.com
 (2603:10b6:5:1c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.841.13 via Frontend
 Transport; Thu, 7 Jun 2018 12:12:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT055.mail.protection.outlook.com (10.152.72.174) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.841.10
 via Frontend Transport; Thu, 7 Jun 2018 12:12:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fQtlv-0006Li-H0; Thu, 07 Jun 2018 05:12:07 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fQtlq-0001FQ-DU; Thu, 07 Jun 2018 05:12:02 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w57CBx2N001684;
        Thu, 7 Jun 2018 05:11:59 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1fQtlm-0001Ev-Tb; Thu, 07 Jun 2018 05:11:59 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 1E4F21214C7; Thu,  7 Jun 2018 17:41:58 +0530 (IST)
From: Manish Narani <manish.narani@xilinx.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>, <mdf@kernel.org>,
        <stefan.krsmanovic@aggios.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <adrian.hunter@intel.com>,
        <michal.simek@xilinx.com>, <ulf.hansson@linaro.org>
CC: Manish Narani <manish.narani@xilinx.com>
Subject: [RFC PATCH 2/3] dt: bindings: Add SD tap value properties details
Date: Thu, 7 Jun 2018 17:41:39 +0530
Message-ID: <1528373500-24663-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1528373500-24663-1-git-send-email-manish.narani@xilinx.com>
References: <1528373500-24663-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(39380400002)(2980300002)(438002)(199004)(189003)(2201001)(76176011)(126002)(336012)(106002)(50226002)(90966002)(486006)(6666003)(476003)(103686004)(52956003)(36756003)(446003)(7416002)(47776003)(50466002)(426003)(2906002)(11346002)(48376002)(26005)(2616005)(478600001)(36386004)(316002)(356003)(59450400001)(5660300001)(42186006)(305945005)(4326008)(81156014)(8936002)(51416003)(8676002)(6266002)(81166006)(44832011)(8746002)(5890100001)(186003)(72206003)(63266004)(107886003)(110136005)(106466001)(107986001)(921003)(83996005)(1121003)(2101003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0201MB0871;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT055;1:4PRV4EMMOzNgwr9anNTxOqRBdPMN5KQGk8hnCZRFa06qfbdnzQKTUot72HGmbSaZpeErVSZLjlBBkZVREJ1l5L0/VvfhQE1vo0ZwqXhx3eO6GkfM/G688MGi5L8F5jkV
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY1PR0201MB0871;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0201MB0871;3:QAaLi6dfkkCrYp7U7XG46cT3c67pWPrKEIx8UsBcFdaZlGQPXzJKwqWoMWg3AW8ijKIlj3ok014r6uL215cXIuP4QmndVyUN5p18C2T2nrOhflOz1VYMj+1VWEpFU5kCP2QU0EIr/e3oFiTezJ0PZtOeC0s/SlLvC9UkcA/yOcYjN3/DnYv5crzJ2/JcYs3sN415Xwf2mQ930QbxpqmmBjGY86DmuMHZbTGuekzFANVFQJmpaaz8fX/jrrCVniiBh0pgcUmVGzORimKMogSYik1Sl7BDObbufPvlLFoFzxHsnAE3jkloXDpJOsNk/z2d7bxGF4HJfdlWpMEiY7E5F/9zNGp3sRWcWcJlXuD1DqU=;25:fAdMltsyCCscVGi9gIsY84jek7/ZafUGXaORCGHTZQLPUXXvZ2mALdMbweKw5UpE5xNfrioqsAcuFrpvErJnHyMfQ6L2Z+TVW4zUMGyr9HQuZlWSVngjUAz18+U9r+P6zYl5bsAymtseIzFb6ORj+snETOIG5JdFaM5sR8nAEEtF1GHutkdVDwE5HBvCfeCN/gd3aaNrSuYGX+ZdsmZhcYR+kwUhYtVvhUJ8c5poz5/SfkKm4UYoPpsDlDSaM1y0dbmPShyHp58PvYn5UpGvZP8qvRXetSWskjvVe87rk5OAymjD8PM4MIDSTT1xp8XQJgEWN3UvroSTCJCkAnkzCA==
X-MS-TrafficTypeDiagnostic: BY1PR0201MB0871:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0201MB0871;31:xNZgpRwSeRE3O4ACN4xng9w89nKjnful9agw+a7I02dSDSS36NVy7Z/Ukt1EdIjVQJ6gilgmf+azD7sHygCNSSLGNff0jmlgHiV5AVc0Q99OwiEZbDfuDQYQFaEYimE3iek7sXT0FevRHoMnzfTdQOiSdPAjbSOP0NFrzzBcjzgY26uJBguoNnsjoEGhUq4NZz5v3bfDRKuCnMeBTRkJxkZV66SEPP5ac2gKL/VIwHI=;20:ihjBhsy7qKaGE0BaCySQv/0ZURwzEVYVlYJ9CEiq3vqIZvnx6jxMqt0vJMDCCwbZtRpO832+2SChFtnUgTJo1V7yfYYV3wPMs3NJz/21Pi3KvJRV2vY03s5wl9VFmbfy7FU1D9y1aLGFPcUyFGfGmOgqK23blLY/umD6mPRwLRPNKCHgsImu58aUJoRPaY+m4Twid/6c6gVCdrzHd85A3gLX77U9C+ZVqYFMSQ18tBcInINR/uYOcR7J4RVOg1DDo0hknFnGADPv2i3b9zSmDzRMdksgTBD2urOEqeh2sgPogueL1fVLxITvjOlKVq+U5GiCD/ri5vK3RD/xemdnlRG49LZr06fJhQYLH4cyBqpdQ/TeWvxPurEOm6ovRtqyjybyKeU6FLLSNGgK2VHx6lEExy9wSDw6z+YvZN9LyIhbU22QkHVRPCyqh9NbxltJqf5nB3gr2wTogsuHVSSSCJQyCivNyg/G4zjYmA0GDHbByZ9ZAloEnRDdPOrQqY3R
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY1PR0201MB08717AAF06274F212CE097A6C1640@BY1PR0201MB0871.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY1PR0201MB0871;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0201MB0871;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0201MB0871;4:bXGZldOpdRu7G34wFnPiCXPM52xJcHtltTti+RUJlkbMr1MFVzrOWvBsVKEJUUtbFKoG+1e6nFTNFmOzHt3Rfp2Jnp8Ggr9xNJzGkH1L6qRSpcC408Tltg3aAOduZKuLZBaT0bZh6mbXs4Z5QTKGVW5EM/5dVwiqYfyYz24eDhu2sDe1u4kQsBsydU2536qNdgnVIN7yPrW0ArxrRNjnNV6X+D1Tpf3LzDFNm6bXXzUvriMPontWH7TF8aQnf4cfzRlYMboq57L9hx+0lh6ezTw6cufeqkQlDtAaMrG6f4SqAu0DZdh25vF/h5beqLjn
X-Forefront-PRVS: 06968FD8C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR0201MB0871;23:q7nudJwsTV4CSv3VYfnq5FmGEL1z/sU+uy0Hrzo?=
 =?us-ascii?Q?iHEMCbPh1Q/UctjRsX1clAhV5iHMm7umB7tkpxkNrf0lRrhPiJTcMXEAw0Gz?=
 =?us-ascii?Q?9KtL9oEWqWyBZ606wCpwaAP5F49d8fey/t1x8DiHbbaHjXFFd0XCCVoFE2Ug?=
 =?us-ascii?Q?K25aBWdH1IaXFe0Qumek0uIAUGxyScbH96fzoQGNWo6U0kHa8rZut4Q1f0oD?=
 =?us-ascii?Q?khAKkW+g4CcRCwe2YfK6B/1rW89ZEoXi6xX1ta+A6rFX2YciuwlPOwKYkfUV?=
 =?us-ascii?Q?ldfppOtLnQPWdIQuewIzrvwI3AcjRTe1XpHIhH/MTpb8oWbKhDdoXgdm/j6b?=
 =?us-ascii?Q?R8Xe2Hf73lkyijHTHBrCiw61bHnMSYRY1mJS1S7R9/pef/mn3/YGOdOZN28o?=
 =?us-ascii?Q?bzOioWTtgzisRMH+zIXogzKYTDKv4DA4QgmzmcpIMgOeV/3Nw4d6RxjEW/m7?=
 =?us-ascii?Q?582RZPXr2trdpcgmvGcstSI/sPDWShvsQY7juLRxI9irw+SvJ1HMAwC9aXDa?=
 =?us-ascii?Q?vYftncFYCEBZmlkTdlZNrJb1WjsbTkunVSJcIiWdF3oaEm8ef0aEGW3sX+jW?=
 =?us-ascii?Q?sY3T7O1AfnTNGRWP594qhAywmceNhaLAx1Vc6J4K5CDxFhyfMIVoFE5HumS+?=
 =?us-ascii?Q?rCE898reEAbaX0ZRXpu1Ud8YLR+XZ5ZtS96S3S7ii6TEDv1hf8TcuJIYAwl3?=
 =?us-ascii?Q?au4/nMz4YrdLO0jUx9DJUNnZQOA5EEGqdy8CKbI7k0K0AW2at6O00cei4HRQ?=
 =?us-ascii?Q?pYc52ZMy0GVz1lxmOukGRM0WD2yqKIrHEBc4KIn9SciESgZIkbGqyNi3fmLU?=
 =?us-ascii?Q?AFcgSBwRumk5iOHJVrb1w04vX/xF/C4GfygDU4x7cKtaPtC2D4+sCmw3C6zk?=
 =?us-ascii?Q?HG8iZKNo3j0WMKRjo+SHitkCB7bunFtp+W7RyQJoWG1S0wBpSRJj/972GIrt?=
 =?us-ascii?Q?rPapR4XJsIGufA4MnyS7M9Vr4N9GbKvrmH5wipQkbnN1k3id/9F7KbFxaPZk?=
 =?us-ascii?Q?+utNnWd51ZCDpMISL38RkNg4e4+nm0pt7i4GJ+RP9hL0+ywPAC5Pr4oLOtOc?=
 =?us-ascii?Q?XCSueeHJ7Fj4/bQ+ZvlUU3lFL0KYI2eMWF5pQLoZSu0CZEle7kfLoueAZvHb?=
 =?us-ascii?Q?4XgbXVS6N8m8uqV+WbD3PetvNql5DO/njk77LzVPTP9dcKFwy81+OvQje99x?=
 =?us-ascii?Q?s24tjEbQfUtECLP+WaZobkotl4Coz6iCWtJY87ZT26TNeiczoGZORP7EbcQK?=
 =?us-ascii?Q?W/kCOSCRgr/tc/+agXR+YFg1jfweJmcR/VEfHzxDS3eeNRg4/OA4JKB9Z/58?=
 =?us-ascii?Q?HQ9jwPGUkrsaN5vSMpP5F8NwJcjEsjKqQyC9TVm90cQ1XFAWHRT2DrdiEQ/3?=
 =?us-ascii?Q?bSfDNrtpTn18J2K+ZwZXI75cSNx0=3D?=
X-Microsoft-Antispam-Message-Info: XJgDYvJbLi8ngT4X1LXyCZqqNezxDFH61lv4CyESpB44TQ9wTkRS+dANf77PMtfnu9GfDtJLmZcWCBsnODLSz+Qr2GpcpfGxkkHSR4FrMJOFghp5QokApEkU/c2h4k0HxQQssPw/ZmLmZqq2m4VrQ0fhQ65XgWcxRuvW/rznTABizEzHWnnmL5BBjczjqWwh
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0201MB0871;6:IhiAlRybZJ5tnQEFxdIqGsBbWHiL2TCHY/4x1j1QRZOSmUPM+gII5qtSqQprsXU5wVRfSLRXHHWfkU81Qr7bLgRtm18LLCQUpadUbYJ6tTQ3XSZDGipjx79+TlPIhETF9z9ScITqrXe1H2+L1HnvgEjuo4cJ4cQ6ycxI5oSYls85SaIjywNv5wIDAXd41JZrFWlZiQeeVmYygZE6uZMQKfmzg5Yg+3US4rHRPfDZA39Ad1TStISQZQEHZbp6Co8LLOB7Tw2zh1RYwa6h+nbCCtNW4N/Et8AjLv90AN07eG472VdS8qUqbyEavOh4GJvFR6ZMdNoOyFo+snPCcWnu1NpWw10fWnzRm7tTIKnkO/qbmCwwxZs+4Fuc76dF8BxHg/01/c7zY1o0KRHjxbPkcEhFlp8OXm9LfodayDF3TFRZPQbEawA9H3xlhJDNDh0bnMd+uXcUnk98GO3t0KaNKw==;5:I/aH6gY1s2BCftNSTRwKPslCAol00DM9DhqWn4GfQXAlTYUvMQ42uBx1q1eD4y2SaU2EnZfp0mQFpi57B9YIA8XU2sYyb3XguLqDjglcB0/q5pnL3QUBV4U5LxUwfYsSVor6sSsu1neV3Af2FYaNnPVp8GJ5KxfvB4pg/uTbTgs=;24:aj9WS8E2tQcUiNvbg9emB2SMEAJUmSKAxgY+tEwYSECkZztQ5nrlWzNnHpZESRhMgJ2ibeZcZzTHmO0sGZXeApJwCxk2H60k3ShM4wuvzX4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0201MB0871;7:DC1CG6rWk+KyonsMegeliPAhqtLxl2CV3DG1W2MuqzntF0wQgANEZWRaTh4W7y2xANT3wrj+WxuQiHDCi81BjdkpGVQM7rzwgcTIX01rNAgUnKlwOC1NEbEat/IkgnE3jImLX5NuVufesRi0mvi7X6Dnz3kJRiw9NFTOraiB85mtVEzculioeOyXHEcsjB9HslxKuOcx1csii1ATEPrnZZ02aNvzlqHlhH3Pj+HjMqGVt7FCR8nwkeauaogMZtOu
X-MS-Office365-Filtering-Correlation-Id: e7f2b8b4-fc39-41c0-c153-08d5cc6fe427
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2018 12:12:07.9196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f2b8b4-fc39-41c0-c153-08d5cc6fe427
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0201MB0871
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds details of SD tap value properties in device tree.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../devicetree/bindings/mmc/arasan,sdhci.txt       | 26 ++++++++++++++++++=
++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Docum=
entation/devicetree/bindings/mmc/arasan,sdhci.txt
index 60481bf..0e08877 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -15,6 +15,8 @@ Required Properties:
     - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
     - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
       For this device it is strongly suggested to include arasan,soc-ctl-s=
yscon.
+    - "xlnx,zynqmp-8.9a": Xilinx ZynqMP Arasan SDHCI 8.9a PHY
+      For this device it is strongly suggested to include arasan,soc-ctl-s=
yscon.
   - reg: From mmc bindings: Register location and length.
   - clocks: From clock bindings: Handles to clock inputs.
   - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_a=
hb"
@@ -26,6 +28,30 @@ Required Properties for "arasan,sdhci-5.1":
   - phys: From PHY bindings: Phandle for the Generic PHY for arasan.
   - phy-names:  MUST be "phy_arasan".

+Required Properties for "xlnx,zynqmp-8.9a":
+  - xlnx,mio_bank: The value will be 0/1/2 depending on MIO bank selection=
.
+  - xlnx,device_id: Unique Id of the device, value will be 0/1.
+  - xlnx,itap_delay_sd_hsd: Input Tap Delay for SD HS.
+  - xlnx,itap_delay_sdr25: Input Tap Delay for SDR25.
+  - xlnx,itap_delay_sdr50: Input Tap Delay for SDR50.
+  - xlnx,itap_delay_sdr104_b0: Input Tap Delay for SDR104.
+  - xlnx,itap_delay_sdr104_b2: Input Tap Delay for SDR104.
+  - xlnx,itap_delay_sd_ddr50: Input Tap Delay for SD DDR50.
+  - xlnx,itap_delay_mmc_hsd: Input Tap Delay for MMC HS.
+  - xlnx,itap_delay_mmc_ddr50: Input Tap Delay for MMC DDR50.
+  - xlnx,itap_delay_mmc_hs200_b0: Input Tap Delay for MMC HS200.
+  - xlnx,itap_delay_mmc_hs200_b2: Input Tap Delay for MMC HS200.
+  - xlnx,otap_delay_sd_hsd: Output Tap Delay for SD HS.
+  - xlnx,otap_delay_sdr25: Output Tap Delay for SDR25.
+  - xlnx,otap_delay_sdr50: Output Tap Delay for SDR50.
+  - xlnx,otap_delay_sdr104_b0: Output Tap Delay for SDR104.
+  - xlnx,otap_delay_sdr104_b2: Output Tap Delay for SDR104.
+  - xlnx,otap_delay_sd_ddr50: Output Tap Delay for DDR50.
+  - xlnx,otap_delay_mmc_hsd: Output Tap Delay for MMC HS.
+  - xlnx,otap_delay_mmc_ddr50: Output Tap Delay for MMC DDR50.
+  - xlnx,otap_delay_mmc_hs200_b0: Output Tap Delay for MMC HS200.
+  - xlnx,otap_delay_mmc_hs200_b2: Output Tap Delay for MMC HS200.
+
 Optional Properties:
   - arasan,soc-ctl-syscon: A phandle to a syscon device (see ../mfd/syscon=
.txt)
     used to access core corecfg registers.  Offsets of registers in this
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.

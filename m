Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49679C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B3220645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3ZBrdjZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B3220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbeIGRzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:55:21 -0400
Received: from mail-eopbgr720060.outbound.protection.outlook.com ([40.107.72.60]:52718
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726591AbeIGRzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxoM+j/QHkbOejOL/iePc1KEanbhZFqTUMpNXdJCgd0=;
 b=3ZBrdjZBu0MBDDRSXeHhx7e7sRcO/1LSh1AV7or5bijd7X3105CQD68KERBuaVKvJ6fwteUItdr4z9yvoMj7x+ukBe+lpDGQ0Fie7Ts8PEB3DgJsTsLWHyvOBysTCgtqVX9LHlV1KBEgBzg24wcxLva/Kn2TFUi9+bfu85n3LJ8=
Received: from CY4PR02CA0008.namprd02.prod.outlook.com (2603:10b6:903:18::18)
 by MWHPR02MB2688.namprd02.prod.outlook.com (2603:10b6:300:106::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.16; Fri, 7 Sep
 2018 13:14:21 +0000
Received: from SN1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by CY4PR02CA0008.outlook.office365.com
 (2603:10b6:903:18::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15 via Frontend
 Transport; Fri, 7 Sep 2018 13:14:21 +0000
Authentication-Results: spf=temperror (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=temperror action=none
 header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT014.mail.protection.outlook.com (10.152.72.106) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Fri, 7 Sep 2018 13:14:19 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46024 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyGaZ-0000We-Gl; Fri, 07 Sep 2018 06:14:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyGaU-0005mb-Ch; Fri, 07 Sep 2018 06:14:14 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w87DE6UZ019593;
        Fri, 7 Sep 2018 06:14:06 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fyGaM-0005lV-1p; Fri, 07 Sep 2018 06:14:06 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 3DC5760508; Fri,  7 Sep 2018 18:44:05 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v3 3/8] usb: dwc3: make controller clear transfer resources after complete
Date:   Fri, 7 Sep 2018 18:43:44 +0530
Message-ID: <1536326029-16327-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536326029-16327-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1536326029-16327-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(2970300002)(199004)(189003)(36386004)(4326008)(103686004)(81156014)(81166006)(8936002)(50226002)(5660300001)(106466001)(6666003)(107886003)(63266004)(6266002)(48376002)(36756003)(50466002)(47776003)(39060400002)(52956003)(110136005)(42186006)(316002)(76176011)(2616005)(476003)(478600001)(16586007)(54906003)(486006)(51416003)(126002)(305945005)(356003)(8676002)(26005)(336012)(186003)(11346002)(63350400001)(63370400001)(106002)(2906002)(446003)(90966002)(426003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2688;H:xsj-pvapsmtpgw02;FPR:;SPF:TempError;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:3;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT014;1:z8PC5XV+Uyzysp+q49uZHDpfs/ZK5TKkQCJl0F6yXYRC7/JfQQA7QZwrxc9SRaDde8PqQVjxLICFimHp8vgwNUI1rPEOqkTXBcinhsD3K+T0AUbAQrhWvRqQOqjOEBi6
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da0fac17-fc43-4bd3-ec59-08d614c3d27f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060);SRVR:MWHPR02MB2688;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2688;3:3G8teQmkyfTn0zWcOw5yXtCaYU0ywkxfO2kVKPZ61mVtBir28mErTOYoWZi1nx2bKvzUXKbNzVN8AhKLgclZj6RFlxgfSI4zI5RFdHjkZXCuWfh3e2ftRwT7XCK29lZC6PCgF6nH7aVZBNsEXwmVIx/CJ9wtIGqMCXzn8TS7IklksJbVz1ZWPZRzyhY8HL1tPyFVOZfchcxknQGPB99lrPb5g0GkP3nczq1kiy8o1+CoiYqRnA9f8y9oQZAjPHxCxio21P4HC9epcyy5tzQdFvg9LS6GsTWtAxIhMtbMLA3eNG2bUVut3BoQJNzzxzMStL1QwBD23U0Bo1vRAdZyAF5uKq7BVKWKXtTsU8A/m5o=;25:ge4C1svBlRO1wlI5URcGmYbrHce3goLXH/AR+tI4veLcPjtEnP4HgyewlE/s4ozlDYxsL65IarSaGQAjuhC2jqkz6QOezALhyf1W6sLJkTzLQcXoLIy8nzMMxkbvPlLYb43WtOiFT5f2Nim0z03tLF6FHSi4Qgaq2WRjo5oaYn8eJjxSml+ONBbJnXJ//cl0L50QjIzDS8lBq+w1fivgBj73MUeNgYSkQUI+oIO4sM/qkwiphKqMBQwQNiMtnZvenohXug1NgYxHsLXagSZzZX+FRkqs8hIZ87zvCOPwVm3DylbuJlCxmqFC1dBFB4f4Z8/uW6graWAh8xbpGHINPw==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2688:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2688;31:xHqqIN/oWQhZQLS/mQJpcSpKH80M6NODQKCk1Wz9EHN6dtL7yqi/q0xMjNUGMYgwgsIfCGhrbSl46AWb5AfHlsf3MqKaVFlUfIy7tBkdLLh2hsUuRwUZUZBRfFHYVJqsSmLEss5cmgnk1TZkZbjzmRagmTud02FtfqbXpJ0FeiEambJGynxnKnahqhTNT1S0/Gh9mVCRSjIC7x2XiRHYOnlPkPdV2JvCZhlmCgDmRrM=;20:5ihPjKbdaI2aisLkwKEznQju9dpVH2eOskW8nKXOfvEkL2kxQpI4CAr58mIEEjLbb0QrzAXYakMiGQog1FQnplw/Y9MzWr0PdVEPLI0OnHq4OvIXTy8YczEuRdyZPvrs72ktlDSuTKBoUZCVkkErCsp8lTje4AfJArRzIPx1AiO6Vsbb0AhK2u9iSCiGGkzcV8/nSzoH52Ibc22G5B99xPSCFORQqUcHO63aUlf/yb+l9NUrXlYW+B7jmBUa9edRpVbn3JsrBlsFMn6BXdUbRtq5cfh64zHDnsowP2LWG8WZ7jazM9mti2n6KzmezZXRWeleCPvffI7Hdmcg+oSH69RPf1t+jxvqoM8ehM7hu4dBa+mdM0XHQObfpOwgipcrirTgGmME62Blfq7CksxGjBWHxix9dpSWKTJ+hT4Rn2Q7hKbnRhmXzg3vYxCwu6KPYmOogj8fRrrgh87ZLABvocmIEn57gshSkFyZWg/1XGTUWFG3ysm/QvW9G3z4IgQF
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB2688A32E052136BBA4440A75A7000@MWHPR02MB2688.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699050);SRVR:MWHPR02MB2688;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2688;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2688;4:uyD58j51Ge4k/waedYHthbrBZ3vpcNuIQoiVZxYCmKLboTi90FFzIUWdEliIWGsDySFktnfNXmFzyL7Vm9OPnJBbFu+ibu3d1vKWqVARK9slQfAvum1/Ny77rcG0f8smez4H2JcpeyJ8HrHje13WEdrWBEy+htZdd+iODuGDFBuY40eCBcl4JZYHKgOHNsBxIa02hjblE3dO46uPSBael82uanA7Cqbduow+1tyEP7GTbXnBDCze1be2XDQhCEOkd7/k7I5BpIHEHDJrQxHJI+1AWDkzKQwryVolamk4IuCfY4lWn9W1aUFT+BqA4W5N
X-Forefront-PRVS: 07880C4932
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR02MB2688;23:2fn94L3puHr58H5tDQTUvUB0ko0Dzbiz0zQlPU3aN?=
 =?us-ascii?Q?haGx50y2nTOp3y0flfWEZZwByneP+lV711rsMlouSCZ1VmK7x9tc2TSHzs/G?=
 =?us-ascii?Q?KGWEckyGikAYnAJu1YsDQ0BOff7C6aaXOKdkTPkak49usA8Vg1NafmZ5yjIW?=
 =?us-ascii?Q?1Nfy2VZYw/Ln15rFnOHPd8tfrDEnee2NJZF2YE0NSU8+prSgkoE85lmilyQU?=
 =?us-ascii?Q?iHSLhUgWKmFUWOQ/75Q3D7MBOob4fBXEKpX+OIxGLHtDQBcZvZzJ52NSnwnr?=
 =?us-ascii?Q?+bwDtOcswA0vWgHlZcMkN5By4hqN1rlPPftSWCHDQYzqRp6EiK817ksS8ol3?=
 =?us-ascii?Q?p/KeFWFnWMGA419GAHThCquYOXR3msGlEjOyElHpoJK71pjE6aFddEezG4tu?=
 =?us-ascii?Q?aCNptTtB69Z+/1xldj9endqu39ophZuvcORbneWip09bSdYQYTbGHVZKZV6p?=
 =?us-ascii?Q?zzCmW4UaKYivhOAQge2aRECBYB2rALNiq2IIsvuAEYn1jr+rLkCVN1aC4ebJ?=
 =?us-ascii?Q?AhyT6jdfUQ2t2rSq4aSf80CwmE03OcxK86AHzwPD7AEym+5rIG0QvM8gdMXA?=
 =?us-ascii?Q?PqA3tuEEXUKGa6f3EzZxpH/EXJqF93eZ+I2zQeN2HDxGHFELMIwEsBqsxy7d?=
 =?us-ascii?Q?i53OXjsdMI/5oCLhg4NN4x+lvcJsrEhlUmqliWxjckwP3WVk/dVi8V1ZJwO4?=
 =?us-ascii?Q?2YMKneskKSDf2K8VmrHLWw+/urf5BNRWkSYb8mBU0nOQQj9sBfbWKtfmCob2?=
 =?us-ascii?Q?WqJJ/I2fqkS6YtGwHeaxwLTfsWM2C8Y0rkGqhDijftSZPEqne95D9x2gPMov?=
 =?us-ascii?Q?oKnbjlYBz5ot8XRpKm5/j/XQgJOwt8GiTotn5pCnYfBbj3xwfgP/VfQNnh+Q?=
 =?us-ascii?Q?3UBFwyNgjc99sXsKIXNpdSd4CD/2+X2MQLUTWdgUvB9h1XChHwb59O0HInsc?=
 =?us-ascii?Q?a2vYiGXg1a2zxs2u+971aCvZcOZybZGieANO+EovciV9g80nv3GfbQikL1cg?=
 =?us-ascii?Q?ud7LV0axiC+N9D9v4fKepRe8uPSB2hijOc1WgvKRnuK04nYydoGhz5hdv5Vw?=
 =?us-ascii?Q?lgZP05KlNnKqCPQiqFtCiD3jgne2D0XTbdyoo8/aeqw8Z1ISOK8li1Bn7G/m?=
 =?us-ascii?Q?hU1QKZ4DQdVodO5Blnpn7c2jmvgYheYg/9cmd2ezE3WR/3q7tHOuzE7lMtZP?=
 =?us-ascii?Q?mY+AkZ04+TTZjrZD72oqDwVKXDDGF84Pd9q4cY3SK4pyjUF3djH8gsS1lsxe?=
 =?us-ascii?Q?6f0/7qizvwErqw+oVw=3D?=
X-Microsoft-Antispam-Message-Info: Q/bAd23OnIPRnZtBonrm6LISxwJ8dkYfZtm5PsvWbCAoabrsvCPCwX9k0z9Nfxo5EpdNITcBIGiZ2MWyugIhzu1Hf+GS+4tfDmTED+2XcF9HCr4xal14fJnDpIPlwcF4phUx4ugp6NREiE+Luzsbyns6EHqhqzFOa8KGrK8Ob3R7gAIPfrlVJbkzy5NQ7cr1QlY5czbysvFg1vFBHP6TCWasx5Ml4jM6FT1PRonYg4oWyK/v8t2byn5yU2qQ7tYnyJxcerEi5C/nSXBIW5NckyRevuYemJFOpmAa798q+gf03NF7t24+mXmwNgbHtb3lB/dYgObjoHPplzCTkeVuBM8p5EVNcvLW/r33GYKn7M0=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2688;6:2Uaol6bYfEl8+PeMDvx12XsgEq5osWd4bE62/8+I9+CYBgM5fQI6EGAFnBzLaHGQZSd76GkmI+elJC95EqfLT7kXAI/C7m0ButDO0F8VESCCgmPk1ABlYs/u3brMwHGnYNPlB2tO5IhKPGLbLrtXMdL1krBqQiIyX4yCRBazX70STdHB79DO6ec2w5eHUUoHkehLA/ysxh62L4W+lCid6kvGj0OMAfNeY3YQrp5tNi2JzGviXj8XpAn35QZ6dwzMTGdjrT8ioPIB3C9yOz5HDNKK/1QGyxdr6Z+eofGHu+PS5cdSBQh8ok5vEu0HBOUQPbxSOLvUsQeO3nxB7sL5CZnDAZYqnV+LooeLH5Ut8lJVoiYnBhalpm6LMsowsIftxkPJgzitSWTm+1VVyYvhwwGm+JmrlkshF1xUD++vYeVnUjjPaEnSFPOjVnCDDxmWof7+O7yZzsNrHre+jLerIQ==;5:/AwXFnv+808b7hvGwLVYYYlWHeZo286qWlrqpaq8EmPV/X51+g+KqZDL0vumo+QecJS0p/gWs9Azp37raJ/ZDOhcDRz1W/dEBe0WvtVStM+JdpLRShByDeL/1IflxMMQ1EhBfKIcXYv+bAZqavU9MEgwpcA/kJPivO5cYMj8AvA=;7:5JWnEdGvl5fEuGc2r2jMLkVNFKMlg5oJpcR6aXRwu5bWX289NUX7MRUSMWLNMJcjMdV1R3i6y7XiitJrILfYzvtrmj3d7bwCLypsieaGnqnxvSfWrQfRNuv2h6pIP6OU0K3BrXnRyDjFvCTCgrvL8K9wDaXPWpgtjXE0iEt04Uu7Yqs22wyEpC0EU24VsoAJG/RLuCSriLgfuoIipjPcG5KJbhqlb2uvpNm7eAXDWxhP+kvKMJgbCgS1kDIQyKwU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 13:14:19.8999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da0fac17-fc43-4bd3-ec59-08d614c3d27f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To start transfer with another stream id, controller needs to free
previously allocated transfer resource. This will be automatically
done by the controller at the time of XferComplete Event. This
patch updates the code to issue XferComplete event once all transfers
are done by setting LST bit in the ctrl field of the last TRB.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Changes in v3:
	1. Added the changes suggested by "Thinh Nguyen"

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 43d63a8..13ea282 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -571,7 +571,8 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 
 	if (usb_ss_max_streams(comp_desc) && usb_endpoint_xfer_bulk(desc)) {
 		params.param1 |= DWC3_DEPCFG_STREAM_CAPABLE
-			| DWC3_DEPCFG_STREAM_EVENT_EN;
+			| DWC3_DEPCFG_STREAM_EVENT_EN
+			| DWC3_DEPCFG_XFER_COMPLETE_EN;
 		dep->stream_capable = true;
 	}
 
@@ -995,6 +996,15 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	if (chain)
 		trb->ctrl |= DWC3_TRB_CTRL_CHN;
 
+	/*
+	 * To issue start transfer on another stream, controller need to free
+	 * previously acquired transfer resource. Setting the LST bit in
+	 * last TRB makes the controller clear transfer resource for that
+	 * endpoint, allowing to start another stream on that endpoint.
+	 */
+	else if (dep->stream_capable)
+		trb->ctrl |= DWC3_TRB_CTRL_LST;
+
 	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable)
 		trb->ctrl |= DWC3_TRB_CTRL_SID_SOFN(stream_id);
 
@@ -2268,7 +2278,7 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
-	if (event->status & DEPEVT_STATUS_IOC)
+	if (event->status & (DEPEVT_STATUS_IOC | DEPEVT_STATUS_LST))
 		return 1;
 
 	return 0;
@@ -2457,6 +2467,11 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 	}
 
 	switch (event->endpoint_event) {
+	case DWC3_DEPEVT_XFERCOMPLETE:
+		if (!dep->stream_capable)
+			break;
+		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+		/* Fall Through */
 	case DWC3_DEPEVT_XFERINPROGRESS:
 		dwc3_gadget_endpoint_transfer_in_progress(dep, event);
 		break;
@@ -2472,7 +2487,6 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		}
 		break;
 	case DWC3_DEPEVT_STREAMEVT:
-	case DWC3_DEPEVT_XFERCOMPLETE:
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 		break;
 	}
-- 
2.1.1


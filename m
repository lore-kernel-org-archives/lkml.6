Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A34C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98062086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NW3TJeGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98062086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeIHTtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:49:32 -0400
Received: from mail-eopbgr680040.outbound.protection.outlook.com ([40.107.68.40]:56639
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727599AbeIHTtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehUakPjGEzhtb3OROXkCp27oDnLCpIxZ9iciZof64zY=;
 b=NW3TJeGk4BVCXvzQiqKpsaB3nftkubLOou3Tz73XFTMdPk5PnLs/JvjtDiZ1qvm9MQ1rDNedTagOyZwXugw5guPXl59JPzczqfouP2pcm39C3GBv1Zx6fm54SuCnrXfOKHyOCvWvxj+l+M317eqyBw4YzS4ibNwEsog7kbfki1Y=
Received: from BN6PR02CA0105.namprd02.prod.outlook.com (2603:10b6:405:60::46)
 by DM2PR02MB511.namprd02.prod.outlook.com (2a01:111:e400:2422::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15; Sat, 8 Sep
 2018 15:03:22 +0000
Received: from SN1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by BN6PR02CA0105.outlook.office365.com
 (2603:10b6:405:60::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.16 via Frontend
 Transport; Sat, 8 Sep 2018 15:03:21 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT041.mail.protection.outlook.com (10.152.72.217) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Sat, 8 Sep 2018 15:03:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:54098 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyelc-00020z-PR; Sat, 08 Sep 2018 08:03:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyelX-0004pQ-Lp; Sat, 08 Sep 2018 08:03:15 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w88F398U031604;
        Sat, 8 Sep 2018 08:03:09 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fyelQ-0004oW-HS; Sat, 08 Sep 2018 08:03:08 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id B299E604DB; Sat,  8 Sep 2018 20:33:07 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v4 4/8] usb: dwc3: implement stream transfer timeout
Date:   Sat, 8 Sep 2018 20:33:02 +0530
Message-ID: <1536418986-16609-5-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536418986-16609-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1536418986-16609-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(2980300002)(438002)(199004)(189003)(8936002)(90966002)(26005)(52956003)(11346002)(486006)(103686004)(336012)(106466001)(426003)(2616005)(2906002)(54906003)(126002)(8676002)(356003)(476003)(186003)(81156014)(81166006)(446003)(63266004)(305945005)(5660300001)(76176011)(50226002)(50466002)(16586007)(106002)(478600001)(47776003)(14444005)(51416003)(36386004)(6666003)(107886003)(6266002)(48376002)(42186006)(6346003)(39060400002)(316002)(110136005)(36756003)(4326008)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR02MB511;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT041;1:V5sLVrmcEMYHNZZcNzcQMJRPrbJc3G1bHkuuQtIFt4txcuIIvnK6/9RQQ3DUTcMzMIOzQtqHsjR3Nex8pV12STcrI0DrP/L+M3/xRt6zB8LlvUZoJLKTXoNLOhp9rS8G
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 121d9736-2438-47f6-74df-08d6159c37da
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM2PR02MB511;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB511;3:jpOYIhtQdx56nb+NQhrlsN9J5G9IXJ1/RZoVHTxPbOpOvb9X55HUC0KTDaeWId9ehaEp8jbIp2vNXUNj6J1a5a9+67TUvUAHYSyv/IJzwyUMek/Cy1ma5t8GsTL4E9xwxMdOQvitWM2JI+2RE82C2teLYoTCz5rg6binaKa2mbg+kd/Gf9V+SV7Hs1koJtlL66q4EdCVBT8YbCWjOiOrmoh212/chdIRTODuEcsqbSK41SeinTkiY7LhzygB2KoipbElhpFeL3alJtd1jvJvLlgghZFtwyFzxB4mgYAs51JdIkVSeVJtlonrjKzOZ0ofwNm5agOczpew0XCEkt10jVy7ZZV2LEtjMgelvUrBLFQ=;25:pgOlP7GM3rs5RLnwbyBSibLwNUCpop7BX+y3YKm94OpZucb+Jh2OpaBohOYWeZb6sTPZBkowhkbG3iP3px/T42YeHZxaWu/FOQ+mYLPIo6hqxd5PgQFdGvTmg0KUrJJA5vUzkhSxVOZ2Bpdx+yeIBpxgnsoQ//LnpXcSHFNs+2uvjMURu1X0h5E30hfyMFOlRomtHK+uv+OnYdgyvBBmV170w2TxRDc+7ZU0FtSbDAaAdZNvelKUVYaGdPwvIIrh+ozOyGs/HfkuDwHxpIdlHhTRBdADzCFGwBgr5WQbZw3WLlpwXBYuWdxT3KO2tCdHp01HomWrx8Kxm8TXWbTcjA==
X-MS-TrafficTypeDiagnostic: DM2PR02MB511:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB511;31:7iATQHBNcn8BnPXROtdMW/A96ysx8eaLPpMasJthJqvXdstaeUBvuYU8YeirpEqzv2tlO7AuDsNfF9+3SOe23dQo4UzLtZ6w4FSUDJjzU3IUFoh+g21hMHP49gbb4eodSVGSIe57FLWE1nrfrsSVDZ4yettFeeA36or/E6jjpuI0Jsg/elSNbMKWXIzsPeGwGzhyyugbAj6nsadvbDUaW6JxXmANnO2KGUc3/Nap+bs=;20:8mN3cOjLAJOXRmx9DRE3MskPnxnaxCCC8tyWEQ8czD6pl4/O/6FIiPH95pQTymjMyslsAvH+NOs/TlQJwmXrNgxjgyom6EK+lBUqgp8MYnZIwQ60xTGFJZS1rPiUmAL+uYSmJyJcl3vYrk0P9E/J69GX2SvyIrrydwLsciHFsOYeplg9FSPU4kU8wnPjdI6R84ql8gKV5D84j7b5ieMW/Kg4NmWwMEQa/k7CFilYYI7b5E3pyakdZ2LDMoTnenFAzoVNgFyJjguEFpLHQGeGVEtZ2vzP06o9R5M+5Fl6pXSOP6is69qTgio7xGwd4d8Og2qLJsgYT/2ORSnSsN1M3J301X9AECXrhYHXkhqsONObPjHgTQ/zDUReTtsoil6Q/3XicXZoA25N2IXLExPEjia2u6lOv0Uss7kgHG50QrGJgShItjV8WRAn+wxWy1LfWsTnUA2ux2q6mdg+GK+1EncDDN+roN5l2XQkACFhXRq/gkO5WeKOvLkN1tV4rUxm
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM2PR02MB511A0C437D5B0F4913FA192A7070@DM2PR02MB511.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231344)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:DM2PR02MB511;BCL:0;PCL:0;RULEID:;SRVR:DM2PR02MB511;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB511;4:QQTgXadYlJAGEZNOaHv6k6wZksuEu/k15XYsTE4jAs0mp/5zjJ20n5oViWDrJagPo4RuiXJuFoV0pcmk3HhIQy9HKzRq3b7UGst9sg02mCCvW+KBGJVAq5VAeTcenJ8tZmAHBs0WZ6SsWoi6QNw7b53lR8DS9Ycn/Q9DSBSWdIEI8jMpk1VcRFmVqHtn/dNktxj3fitr14egLL75oxQ/wSVwj4rV/Rbf8qbxSFR0R6O/VrbbpvR6sYCmizU/JH+4mj4sl1bZkEqjDT/cJxfOJJGxI/RV19269rp32iGeaqIWbDgGfEtDqXt9mDCu1hg4
X-Forefront-PRVS: 07891BF289
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR02MB511;23:Q+E7x7n5XcuMuNikYXj0wuHFWKoYaOvkMcEYU5unSm?=
 =?us-ascii?Q?LjpV8lFbsksTitT8hHdZIo5sHzrnSUAZUzeLDajQtxqcrWnkEfaEKJhYBE9t?=
 =?us-ascii?Q?3WthAYp/mBxgifufH5iMs9mR4751PJNdjj514K5Jae8Q40CW/LZg4FzwVU0k?=
 =?us-ascii?Q?hzK9t6ThWGCPzl1jHCr/vI/p1WdfYaVZ6Ryi8HeUlZoipoi9b3AyONDbWNMt?=
 =?us-ascii?Q?vO0rxkJhyTYclQl5LZrrQExbOnir7CFBITAiO+g4DhmH9QdCz9sQyufErHGi?=
 =?us-ascii?Q?zxNc9zvdkT32Y0XGLR04Cq3NExGF4AyjlII7PISVsqF4KpKzwFhB390Pi6Wn?=
 =?us-ascii?Q?IA/V2pMtAuWVXulAaPj2pZiZ63QA1lq+a73HP1k71MZJt1T/wEkWGGVm2Hj3?=
 =?us-ascii?Q?5kD0M7jmP5zLGSY6+yr72Ysgx4Sl8zq4uXZs/PGPmkW5F4LxoFxsBMtM4njw?=
 =?us-ascii?Q?QIFYJLxBuZvtn46zFXcPY39Z1tUUEmZzZfUyqqpzE7boOYkb9WXCV3L3/aN2?=
 =?us-ascii?Q?FqFLpmm9jMLJjzV0yd+BYbBvi+Gt8WdFi11HOGtuAm2KyaN0kaJOzPjnlnS4?=
 =?us-ascii?Q?AV0PY9IFNuHnHWPSiX9xpGN1MCDCxIJF6dPKWIijGZClb388ZBPmKbD5cGVu?=
 =?us-ascii?Q?KgKbEq9q8WFYSnoZO8Oy4GK+Y9wG+2ZtsElR2oq/U7BfTz64cMWt4ZyvJtuJ?=
 =?us-ascii?Q?16DZnEDNwpmryD8zCqQJTdxVaYvE51sL4mfxH7Ay0UH5aM5s9l3ioAtVvZli?=
 =?us-ascii?Q?vlhr7kAZoGuf9KcN2oE4PGDZCvilGhBHwYn3FwtyIhxMPOL/bRAMy8EUcS43?=
 =?us-ascii?Q?VTIv2oqvm7GjhNS3I5mBhkw3HDgDvufmL7gJOqBDBZ2boV1O/Mk4rnSe7GmR?=
 =?us-ascii?Q?J/7gE5XE2l9v8o8Du58np+KYV4GsTBgdBDLR/8jrtXRKwOIsGeYK1KesJE4o?=
 =?us-ascii?Q?rcaxAKKX+nF4vjLSz0ngUQGK8SSKrODLldVdsIW9qlXdEiQBjnvFbDPIzfRS?=
 =?us-ascii?Q?/QgTMFV6DoY5GHUIFkPGcAx01SXaflo952MT0fxa9WXlU13nfymt8pxyIK+K?=
 =?us-ascii?Q?NY/+ApgtudgmpqJQjD74lg9OTKTij9I3XWmS9w8VB8EtaSNyz8mpVHWZRffI?=
 =?us-ascii?Q?LPjc8arXkq8c+j/kcVPCdKo5oUqLiathO2t8LP9EcEnzbUWJPVb8jAraF+6L?=
 =?us-ascii?Q?iy2spXsTk5PmFlBGvNgOcv68fYKXYXrltaTH4k+QQoQ9iVddp1uYXezcMtSI?=
 =?us-ascii?Q?eapFJuOPDhFPfoCLE=3D?=
X-Microsoft-Antispam-Message-Info: PnYXGe0K8y4FEPmwBqcZyqAbwMrRdn4AFnzy0jjpvn+ZdvY187Ht7qhh2xq0qra9q6w0TN59upBfFefeeiTXPw4kpKif5opYrW9dqjzRgvBGIUK6bT2xITBmU3QYqc1c1iE4fG/IsmV13bvQWLGegbuUqLljs04EN05Tleg5YsGU15wfrnhYt0JSkgfMH8ErfRMixkjRtZ7+LNgqnbpeSire9kXO6BYqsVmGDofpUQI5PG5CZ8VYXFkwcu9Jxu54QMtKvDE5zT+0raXMMAeECbltJj3CP2Oy9eE1yxrxWs1HLu6IVrq6WnAnZ8Kj/Sh4h2yxd+LEl2wobQ0UlvltVTqh7VGyEeven8TU6MXa5ns=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB511;6:L8viGWoVoSRyBt71e94bkZc5243gx6awOI3wS16BzELNi75wi8oZkKW22YKCaHgE7/0syTejmBbc4Vxc5p7jgwWj9wfO5+eWnxNmD1pPBFVxKVcFK79vQ0pfBbGOOAohJiBg3U3wLsmmXs/+3MrZ/DgeeCBXEptFEsKTeFRhHXeMOrAsXqKZFVVCKNDte1h+k3BhH7wc+TVUB6tOcDTXlR+iknEg088ZBb62sd/nvq0piEhQ3jMV8tzXYZVwGGjEW16RWzCbPlIj8/41GJ2D9fIPkLmRoWzlSNcDYMgWXMkVr++UF4EXgRYyZgtD0tpk5s8T1YiXx9WJsMoFQBcxQRzbXx1kYnAUEp3ilTnqg0Ir2aG28pLs+Hzc3LJ5XSq03r1T29zpYXQJMMKoe2ONVzhMDmviyD1LuyH8sX6YG1bKcEO3qO8o/xI1ViSVxfOKtQjXZ74AIfL+cj6IHnuBsw==;5:ah6CLzaMHlkLHgdmLDgmygygGAy5dyia5C7gvdLMg5gakvIsySDPnGYmif0eIWZnr/18AEturI0G8wHzbhEslFfJEYw99xiH50njvlD7b6VsL0MmCIp++fDuktlR9aPMj0VDl/DdZ/tKWmbPYZ4YYaZdAT6p5yQqNuYETlzTsZA=;7:+OgYiC8y647UeGhnwM09CqRJI/YyvkddzSniTbKN3nNgu93LlWmrXCNB4n9CA6dchwAihi4uAtKRosNEklyvadAP6kRRofFstdezx+I3mmrAy2aWRjxp11RNcTGDN7Y8VrHWjqEMuw7g844Voeb82647Qj90WyrrlJO37NLPBymD2H53kq4waP1bFDRffMAPp3Yrhmq5px8Cux2jDefCWeVFMOys4mh/c4xnDnMEMPv7pXxJ9UIqTyaSvyFsizDk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2018 15:03:21.1586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 121d9736-2438-47f6-74df-08d6159c37da
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR02MB511
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
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Chnages in v4:
	1. Added description for stream timeout timer as suggested by
	   "Thinh Nguyen"

 Changes in v3:
	1. Added the changes suggested by "Thinh Nguyen"

 Changes in v2:
	1. Changed STREAM_TIMEOUT to STREAM_TIMEOUT_MS as suggested by
	   "Andy Shevchenko"
---
 drivers/usb/dwc3/core.h   |  7 +++++++
 drivers/usb/dwc3/gadget.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5bfb625..f62e8c4 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -633,6 +633,11 @@ struct dwc3_event_buffer {
 
 #define DWC3_TRB_NUM		256
 
+/*
+ * Timeout value in msecs used by stream_timeout_timer when streams are enabled
+ */
+#define STREAM_TIMEOUT_MS	50
+
 /**
  * struct dwc3_ep - device side endpoint representation
  * @endpoint: usb endpoint
@@ -656,6 +661,7 @@ struct dwc3_event_buffer {
  * @name: a human readable name e.g. ep1out-bulk
  * @direction: true for TX, false for RX
  * @stream_capable: true when streams are enabled
+ * @stream_timeout_timer: timeout timer used by bulk streams
  */
 struct dwc3_ep {
 	struct usb_ep		endpoint;
@@ -705,6 +711,7 @@ struct dwc3_ep {
 
 	unsigned		direction:1;
 	unsigned		stream_capable:1;
+	struct timer_list	stream_timeout_timer;
 };
 
 enum dwc3_phy {
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 13ea282..306d4c5 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -254,6 +254,7 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param)
 }
 
 static int __dwc3_gadget_wakeup(struct dwc3 *dwc);
+static void stream_timeout_function(struct timer_list *arg);
 
 /**
  * dwc3_send_gadget_ep_cmd - issue an endpoint command
@@ -574,6 +575,17 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 			| DWC3_DEPCFG_STREAM_EVENT_EN
 			| DWC3_DEPCFG_XFER_COMPLETE_EN;
 		dep->stream_capable = true;
+
+		/*
+		 * When BULK streams are enabled it may be possible for the host
+		 * and device become out of sync, where device may wait for host
+		 * to issue prime transcation and host may wait for device to
+		 * issue ERDY. To avoid such deadlock, timeout needs to be
+		 * implemented. After timeout occurs, device will first stop
+		 * transfer and restart the transfer again.
+		 */
+		timer_setup(&dep->stream_timeout_timer,
+			    stream_timeout_function, 0);
 	}
 
 	if (!usb_endpoint_xfer_control(desc))
@@ -730,6 +742,9 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 
 	trace_dwc3_gadget_ep_disable(dep);
 
+	if (dep->stream_capable)
+		del_timer(&dep->stream_timeout_timer);
+
 	dwc3_remove_requests(dwc, dep);
 
 	/* make sure HW endpoint isn't stalled */
@@ -1257,6 +1272,12 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
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
 
@@ -2403,6 +2424,13 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
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
@@ -2487,6 +2515,11 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		}
 		break;
 	case DWC3_DEPEVT_STREAMEVT:
+		if (event->status == DEPEVT_STREAMEVT_FOUND)
+			del_timer(&dep->stream_timeout_timer);
+		else
+			dev_dbg(dwc->dev, "unable to find suitable stream");
+		break;
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 		break;
 	}
@@ -2588,6 +2621,18 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force)
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


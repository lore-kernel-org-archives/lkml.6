Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FD6C46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB98F20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="X4YspJAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB98F20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403965AbeHATAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:00:46 -0400
Received: from mail-cys01nam02on0047.outbound.protection.outlook.com ([104.47.37.47]:18784
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390055AbeHATAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WX9pQxq75+rYVmtssBthd6R/Om2gjjtW0Sv4/7M2H0A=;
 b=X4YspJApH1tS1y3zRmPNy3H216B0IPgkZuGu8BrG86Mp2dPIeyY58rupELERgSiIpq1OV1nr/riHgXcpuzDn5SJvm4AGjSPTnMbcblmZUGuaZ0bfogFS+1Dc9tP3Lml7aDg7MePmmanvkKY9lo1+5JuMer5mNg6YL03JfJitotU=
Received: from SN4PR0201CA0021.namprd02.prod.outlook.com
 (2603:10b6:803:2b::31) by MWHPR0201MB3515.namprd02.prod.outlook.com
 (2603:10b6:301:77::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Wed, 1 Aug
 2018 16:49:54 +0000
Received: from BL2NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by SN4PR0201CA0021.outlook.office365.com
 (2603:10b6:803:2b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.995.17 via Frontend
 Transport; Wed, 1 Aug 2018 16:49:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT060.mail.protection.outlook.com (10.152.76.124) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Wed, 1 Aug 2018 16:49:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fkuJr-0002L8-Ok; Wed, 01 Aug 2018 09:49:51 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fkuJm-0004te-LH; Wed, 01 Aug 2018 09:49:46 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w71GncKF009084;
        Wed, 1 Aug 2018 09:49:38 -0700
Received: from [172.23.37.224] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fkuJe-0004rx-2f; Wed, 01 Aug 2018 09:49:38 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 2/3] PCI: Use dedicated Xilinx controller irq number for AER
Date:   Wed, 1 Aug 2018 22:14:48 +0530
Message-ID: <1533141889-19962-3-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(2980300002)(438002)(189003)(199004)(2906002)(36386004)(81156014)(81166006)(4326008)(8676002)(336012)(8936002)(107886003)(126002)(51416003)(76176011)(486006)(106466001)(476003)(2616005)(11346002)(446003)(7696005)(63266004)(5660300001)(6666003)(186003)(9786002)(77096007)(26005)(106002)(110136005)(305945005)(54906003)(356003)(478600001)(50226002)(36756003)(316002)(47776003)(48376002)(50466002)(426003)(16586007)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3515;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT060;1:97kWJoh12+2ikg6BwDou28hkyhUaauhMLD5Ie2xAtKcHuWLZ2KI+MYjjbWDxNGqLiiSl0+yivuSBAix9fTUNEWnR9AUDDjziXfwHX7r8IUjZeKwWQwg7CsNMxFvQw0r2
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 745967a1-0a2e-41f4-03f5-08d5f7cece4c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR0201MB3515;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3515;3:s/6Jz5hMK3ozP8l7xmkzAP+Epu5J1CIMizzSFltL9q99UKeiVGvI8nWbIPQzM/ErEfOgby2JL2JZYRbrpVl/VIUNMcd5i2nbHVV13iJ5t8bhsjZqq6OfZf1HXRGMhPXv4y1OD0z9SBVxYnvS5fa3SvnKGjmX21CbNG+oc0yw4qbMIx4/Ucz0YKPbio7yvgtQyLWn6c7h8gfzrJp3RM9Ow3Z6MRL4pvXkp2gA+ChFowfE4ozJ0lRylfDri0rC4SOQAi9RGg7nIyVHQDC6zDY6M8+mvfODy+8AW5FmLalt779S9MVm5Y87h6FAujeTUIsaOiVWcE6qlgv5vo4hw91eC+jngHlYY+UXLn6kCDH6Q7s=;25:YaQi0wUmE+3Y3dzKNp9bX4r/FGPFVK/neGAgjo7kw13rDWiQHpNIxTkYE2euX0SLBtwaX7Y124H3AuGhobQk26S+4n9U9oeREjxZ7G7udBBj6ej71Sz9dySmbhSDHFOp6r5oKQH6EUIVWO428ifMnFAnM3jOaScafjQxXPgS3Yt2b/uU/xnWXqy2VD2M7d59qYJ8K0fktbGLlBT0wWsquS+2GqE6xmHMI8Bv+4zfLmq/NKe5UlZoqeELSlxqb1DpRoHTLwdgxUwuFvtDuHVnp1PkM2kw4fG1BqlnJQSpKZ8aJHuey9OkrT6GYY1T3+5EFgYNadAfScKIykpgM280KQ==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3515:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3515;31:Ovx5KaEDS3gwVcLyaCrtUN2EciEYZ7jLfsmksM1GAxm/QxLe74oJTwAZa5WzWd1Xk/r1uXYZIZ+MqRita+8CUop82cl3mo3mCiV+U8d2+iHJI86OCRPgH6055uexMW3WyJgMvx2toQNztFgBtz+4DDAEmlAHWYuvGvYF8QiArUlDlHydBVy49PS1Pm/eSD0l0eRQAPbJqEuqM8xBdwXyBdDTc/A9ypitoe98Av1gPjM=;20:3snA8SoEYMoONtIP7en/0GCfu1Y3Nt/iEpJUw9ViRTkdtdSVLS16TDguk0/byvkVGNvNfY09Ku2y+gYA3uvixn5fpNRDyXiKUW0BSkCcIomTJS2zA/v/wcv+a0/OanKNS7B4UduSdMMshQdJtBRfldB6NaGtmv1NKm0bDVTFoELgrHZecg6v0H3ftq3iuRbtZhxdAa/PHQ4rrHCWkxQRKnEePY9VkMs98KjObhMMT4d5jEnEitpwi9OZk3pPNz3qYkPJamr6JCaj7s2ejywP84LZ1sDZjOfWt9lh0FX719WaBpAg2Nus2/How1QLVALVwaxoT8219NrsRlPOjiXt/b8OvCTvJK/NUEHfL8mbrD6y9V+aCh+uYdhNK0YFCR/Y+Q9Czsg4I7nIaac/mmgZDJj0ivJlIbeoYv2yLurVUrAEUMGaepaUHOGVO/VSZszu2BqlvO5L/BtBeDSvHQjtQe5af6Db748JNhKqa70oafBCNqq1UUekTVZRsB7EV/Zm
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB35152AD56A32A93147BE0D3BA52D0@MWHPR0201MB3515.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR0201MB3515;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3515;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3515;4:fixu/MJeoD1W/6atAM4ONiuJ7roJStjC4s2KnKgfWzXVNossa9WpeG42LucztwLFD0BkHMZF6S9A8dttiRHuVzk0n/YMclzbWYj+6/D9MSRu1q6pJqdjFqEXstu5zbd/3/KQJa7L2P2gpdvh+iF90P4K/EGKXCSRQLWTdNDwav2Sgq9iCQz+EYjL83vltelBA/WkUdizfeq6saj6+QPxSnCKenZCKE5LBmj+kvqNrDRcSwS36V1MCNm4hAsjsgkc+IJAbZbKUMaVljxO3GCd9dS7UfUkmd1/BW3Vyvrx1i1ZGUf2TCOIf8Oz2ekPC2jAKM76X22QQfcrt8XR36U9epo628Mv3gJqd0Pl6vBHiS0=
X-Forefront-PRVS: 0751474A44
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0201MB3515;23:hZKO14MXuqXa95bkhrYogjNELnu17eHX7LftVHy?=
 =?us-ascii?Q?gUwOda/g6qu9eEslI+Sx3KJHJpDc3CiqfOM2Ih1s76xw6fTxoTIqCL9mqFIy?=
 =?us-ascii?Q?+91fGk+4HORjOSMWdgDe/EhFOcQqbk0Cugne/4dAo/ktgWaA4ljC3/PNjPnZ?=
 =?us-ascii?Q?dGS9g3xIkEeugrdTG67FKkshm1BwJdOXbZb+WJc39pxXcVBYsp6HR9MSZrw+?=
 =?us-ascii?Q?CVue18tFBdwMIsftF2r8tQk2L4hZyxbVDvjkicAb8tVifPlz6+XmJ7dUVMOM?=
 =?us-ascii?Q?VJg8J702thAGLaeHwYjAfINtG7q2b9+kcZdHmuEHN78uCEFJ0mNfgeGVktB7?=
 =?us-ascii?Q?XWe1CNYt4Oj0y9s4KEGEta9CnAo8wVl+9Lltxokyczw3HBbEGtO0XCiMBkOs?=
 =?us-ascii?Q?7yAWvcZLxPi67UNyGYEmOlxLzffUghP2Pgra8gGqLNwlbx64ro7ljySmaAvi?=
 =?us-ascii?Q?WCPK/evgI7kJMhWrRGnlMUiXCPJ2Ui0PgvMiCTHkFjYI/zJHQGgEbdC3kd2d?=
 =?us-ascii?Q?zdnNxCOs/ycFGqbFVM0hlQl4ZlqRt4PhVsmhPPAY+U7pUlnU4eaxEXoCqDZB?=
 =?us-ascii?Q?NSFt0GYMxgqD5JLHIsXEnxvCDfCpVes4ApVKaTgc+LUfstSseZ8/z4t2RulB?=
 =?us-ascii?Q?0iUrEXNkOjRvEn5p1sVjMKkwfbaQRmHzjdI+6dYHr6JiQwUUOpz0145Rr5Za?=
 =?us-ascii?Q?alf/YIA2GEvUQCJtLhYG0gaCIHQkVFuHhEbbYwrmRH6S70VeRzPtM84KFEfF?=
 =?us-ascii?Q?C1ScelP61PaY5TJrASoYfj3LKPqBlQCwFjTJ2XFO/mZSpUSmFym5KeQ7EXId?=
 =?us-ascii?Q?wfqLR+Kj0/PTcf2oPHtGbi8KdfIK/lSJzoZjT6gn9C3oSl0GH9TiZARfJsJU?=
 =?us-ascii?Q?SIKG2uz/oYpJi4IiqacUunI5s2v0Pm8CPd9olJyKPJt8HDvL7akiMp1JK/JW?=
 =?us-ascii?Q?N1gaPFvNNtNCBTac3eH0ZKgp6SBObHO0BDdpzhSSqJE3CO2MXiLx3ve/t8rU?=
 =?us-ascii?Q?PfGEN3fgh8TiZWqsjTZmby0BHx7+6SuMaQugI558gY7ZX3H5sCrKC+lawLAv?=
 =?us-ascii?Q?FTB6nZTYXGXlHuYnV2WV5JZt5nd2/uHRkkft+pbXZmq/1mx9vkA=3D=3D?=
X-Microsoft-Antispam-Message-Info: /DHtYlZ0KEM1Zv/XGTSk9+a6WzfqO3KcSwOH/wXnNEngzI7CMV878uVwmGpstNHe25vDYNa+/V/LHk5d7FsWHpercj8dOZn9ZaSkSvoU6YRSCCScmvCUcnCFZsmNWYjPKFCwWXMcIwaQIVIrLamKLb0cTmx6nb6l1Hx/JTFgjJNw6eVvd/6QtD9hRw9J1t5uE7ptxXdsaYp6Zssuzlaq4usmaMs3uqG4K41v6/30xNGa3JzMF38e8DRAxMlfzYboZt0XAKCpTawAVGb9kAGGKWML5gTgZOxfB9uYzp0+1RcJ7hLULHAAk/iFovdMHO8luYR4dXpbGA9oEgZuKQVGU4/wqN7wo7SDiYzxmSCc798=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3515;6:HN6oqLUviaGGopcUsQ0y1NLLf1x5+r5ByoahCQGqWH8PIoRSNM656/XaeuJwuyGozK1vosk12MB5Wl641AJ0Iafx1BEvxU7gko6dl3YIuw4m8xGNYG82gUjtG8nPzKgMZQMIAdzXlApHrXsUHfTsN5ih/diBrX553VFMbMjm/0p+nA7VY2mIpXBJ3fCfLZyAlUjEFdB/msJ96kusr1ddfWNaEOstUcR55N51o2elq6dM4HMPJqBz9nPsflD4ibtY/z5dDOD4bH7RILIUmIYeuEcXRt5ndS7E2/E58XTenOlDozX3nHwfUdaAGaqIHiwtY04biJqv/A5Urqwez2FMJOKj3/Co5WCTqMX2VT7pBM+9Uts81zGmfRrNxu25woUSWWFyRUvD0yHMY5v+ab3HREvyzzE3peKa7aQVFGv+BQem0kprvpVddhmtJenZV1JlJq+CXGmls6HfKckiYXyC2A==;5:VSOkDuQai9vjpvJxviQtz6vlVI52ISGCQTxBNZ04VsBTJOJSmaKdZwKRrAPCjj3n5jmuzZ9AnDgA1pM9zFFXjZxCyjGsFjjniXUb+jwCrdlZvH2V4XYjlS5rC+X30mXbYboSG1lCQQv0r9/dkS2T8XWgMFRmDg3QrnVkLJn4yuU=;7:HYjCR/ccnxFpBqPZXVK4oFpzJiEIHPW+OsyrK9oVP8mED+fEtJPB7kGDWbf2j95/b3Md78VlGCf23xeOIZuEFyjG4BNvjdD77V//mcMT7QU2bC6sPYvDpiXL4/BW0RqeXd1qVnE6Ik3I3lrw8VyBINLFcvxXE0SY9n+tr1X3PwNwLy77RhJQrk6WQp3DKE5YNwdeGiApNPfkR5gRZT1FCrncaOdGKKYE5oOTwrDqdF4WBH5W8hz6iCMW7l2JCV9j
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 16:49:52.7017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 745967a1-0a2e-41f4-03f5-08d5f7cece4c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3515
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx ZynqMP PS PCIe does not report AER interrupts using Advanced
Error Interrupt Message Number. The controller has dedicated interrupt line
for reporting PCIe errors along with AER.

Using pci_dev->sysdata of root port to save controller irq number, which
will be used for registering AER irq handler.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/quirks.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f439de8..e666373 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4753,3 +4753,32 @@ static void quirk_gpu_hda(struct pci_dev *hda)
 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
+
+#if defined(CONFIG_ARCH_ZYNQMP) && defined(CONFIG_PCIE_XILINX_NWL) && \
+	defined(CONFIG_PCIEAER)
+/*
+ * Xilinx ZynqMP PS PCIe does not report AER interrupts using Advanced
+ * Error Interrupt Message Number. The controller has dedicated interrupt line
+ * for reporting PCIe errors along with AER.
+ */
+#include <linux/of.h>
+#include <linux/of_irq.h>
+
+static void quirk_xilinx_aer_irq(struct pci_dev *dev)
+{
+	struct device_node *dev_node;
+
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
+	    pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR)) {
+		dev_node = of_find_compatible_node(NULL, NULL,
+						   "xlnx,nwl-pcie-2.11");
+		if (!dev_node) {
+			dev_err(&dev->dev, "Error could not find ZynqMP PS PCIe node\n");
+			return;
+		}
+
+		dev->sysdata = dev_node->data;
+	}
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_XILINX, PCI_ANY_ID, quirk_xilinx_aer_irq);
+#endif
-- 
1.7.1


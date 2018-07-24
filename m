Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE45AECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634C320874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cTGRPTfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634C320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388571AbeGXP2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:28:46 -0400
Received: from mail-he1eur01on0046.outbound.protection.outlook.com ([104.47.0.46]:13408
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388540AbeGXP2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDZKIHyR2034iUyRWQVawtltx+astMShveJjBdzqC+Y=;
 b=cTGRPTfRQ6mSo/2gkmsLl3TD9kTr+7/ueifkB8U/6RrRJLhnltpHagvBAVZ161XNiYKsZ3MSY4NWJrvQwSuIp4Jo9zX3lRPLr2peQHk1eGnI5tJmdYa1EEKwzpcxyaI84XuDmKb0eKAJYWCn1Iduzy2XGCr3P20Uz5scCcWpmao=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 DB7PR04MB4490.eurprd04.prod.outlook.com (2603:10a6:5:35::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 14:21:52 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, leoyang.li@nxp.com
Cc:     laurentiu.tudor@nxp.com, ruxandra.radulescu@nxp.com,
        horia.geanta@nxp.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, robin.murphy@arm.com
Subject: [PATCH v3 1/4] staging: fsl-dpaa2/eth: move generic FD defines to DPIO
Date:   Tue, 24 Jul 2018 09:21:28 -0500
Message-Id: <20180724142131.28970-2-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180724142131.28970-1-roy.pledge@nxp.com>
References: <20180724142131.28970-1-roy.pledge@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-to: roy.pledge@nxp.com
Content-Transfer-Encoding: 8bit
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN6PR0102CA0006.prod.exchangelabs.com (2603:10b6:805:1::19)
 To DB7PR04MB4490.eurprd04.prod.outlook.com (2603:10a6:5:35::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 923dfc80-95bd-4e4f-58d1-08d5f170ce90
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4490;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4490;3:YnRX93i5/6Mr5fRZgJi3IWR8GKTP54QER+kI0YsiS0NUGpTFZ+tpe7ZdxIcP57H4Wur6JMDC9b+J8euyDF8X2eSIKdVs05oMnRr6ScnmKTOuUADnAM2FWECOxG4tirVspiAo4wE8Zjn28Ua+q6EpeexvTzfg5DNrFV/chXmlVz0ixK+Z9o6dPsKAFnfwC4weOFIEr4OqzwTqW1m0jFYZdNY5wRrjx2zr7mJyRnQWnLh4W0wZfsZ2mdmabt5YmUnE;25:l7BtaZ6cfrPbFzkJQTJDf5mXUCXNjY1LWOTwfg0a27+nOAhvI0rRzWroyN/ANdEFmS1I9DTwjgMZUmsS7H+aJ/pCpSl9bJ9t0G1MVgfEz7K8FZW6Vntlvx7RbdzX2TMxlf1tdj3wif/pgueV/lfAvnTFthNmmWn3ntuhzj3FEpbVGFXoRR/HiUqVmxgJD8VAt5F9daPp/ybK5ZSByKQAS20tIUqvQqkY1ijqu0ugeqieHKD7zlzNJyuDpcy9lXEPw5B9jKw+cpIGiM5beYcWXzb8/d09TaUh3HbgNMla2xUJ/0cKB0hS5Ai5OB5avb3f5L5LHZxRiqvQQ0MKWSHxoA==;31:KlUjOwcskFF6Gnmci+kR0F4CwUMyVB0eA6VorjvDaqwi6hXCqC5vCZ+X5kL1kVvwmBbreI0pDIbTHtPCg5N/b4XfSfdLo+c7kTJn/Uey1trpL+HE5j6ta9TVI2ViLljtvb0qS7Bey9h9imCwYVPR0CksijTc+lSrmGYkvtaEgWaGpKgr2k2sTuCLblfWc5/+ZePQAKzt7cbL2KJGS4Vrrt5tRAs1iZ7bMA38wQRzcEo=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4490:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4490;20:16KGIfbFo71eVoKmBLFkVioyMN5d/q4isOYzNjgko2fHBbKRzCVGAHRv2tHhsWyI9KCAVUxOBK3m9oLPdmjJ8/h5ZvXgfPPIlkdDBiQhuY+7O/0yusOxUmy58EEtThjxZoqbNY9ZpAENn5KwH08TkUsGw6IX+x3qK9mNPB3J4mwJDeun345XJVdgTu9SQfQE+Gtb4p7rbXPQwkemfqgEn00R6EcgNthgif8BXjYrdIqI5YURWltIt1Os0QXA+4uhH7QoWhwXVwovdXXQWVFcsXSTxcGgPgrWZuAytt0anmdx6BFzzChfDy3TJWuNbUw4tkAVEJsVGojHvSB2iG8F7H+W8E05ul/t7IRT8327znDJuVNtYyv1TKeB5TQ4Uc7k4OSFPe9EoYtb3vUSHf7PpQAugMB9furlk/eyyBiZHSvcIvKkaPMoal6b/47sIruWXJsT5+oNkexnbj6YjGrJg8PDyujZy5V8JLkvT0ojpHn/g//MmSoD3TA34MLb+SYR;4:Cy9KWHeuvAmqyKFTCxG9HVcn2h5MMNvD0jYEd8C0znFnqG7EgAneMuv7SEtXbRmZcUuU46AIYSq0NBoqvUBirDHGE5S9zPcZXYvbC40FNjGm1caBhJprHBzdlHe9Uzs2qMT4ogYQcmwwp1D3oh2KM27RTye7/ugkAF55X3x4+c+JL1xjLFqB/3s2GwrGELp4dR/SICzDgR9rwXyXytEtAL5lwK+/z9rB3zrmAqXZ2AH/I2QTT7AOd0qYQzdIo6hYpiu8/ggbCe5jKlqKjXVoMKZQatwRybO5J5ksP/cuCJXGUxotllX33ByImGHMYqYp
X-Microsoft-Antispam-PRVS: <DB7PR04MB4490844B91A991D4D75DCA0C86550@DB7PR04MB4490.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4490;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4490;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(366004)(199004)(189003)(1076002)(2616005)(105586002)(44832011)(66066001)(446003)(11346002)(486006)(2906002)(3450700001)(47776003)(2870700001)(478600001)(6486002)(36756003)(53936002)(106356001)(956004)(575784001)(86362001)(6512007)(476003)(386003)(81156014)(5660300001)(6506007)(16526019)(68736007)(6636002)(97736004)(8936002)(6666003)(305945005)(23676004)(76176011)(52116002)(186003)(50226002)(26005)(81166006)(7736002)(316002)(14444005)(3846002)(6116002)(25786009)(4326008)(43066004)(8676002)(50466002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4490;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA0TUI0NDkwOzIzOjQwdW43QnlhTnV2bkkwZWZpNUd1cGpzUDFz?=
 =?utf-8?B?RDFjRXNlVkpuM25EMUFNQ3lFejI0RHhPc09ZRXRMSERqbkdsVGNvS0ZqUnBm?=
 =?utf-8?B?RDZ2VFZ6S0xnNHE3UlloYmx3MVVoekxmNWdVYUxLajB6bXdOM2FYUVY1MFhR?=
 =?utf-8?B?bDlFUTZEaWNZT2xHdDVwMkYrNUtnS1FoUWJXeXlEcndNUWhHVjFrY2V6UFJw?=
 =?utf-8?B?Ym81dVZsdVZnN1gva2hOSzhaZU1aUGhwMytPZGpBeUtrNm4xSUlCN25IWXZ0?=
 =?utf-8?B?aGV3VHd4Si9ybDNkay8xUURrR2EwZm92MU5RRlVkVExpcjdFZnEvcnA3QlBt?=
 =?utf-8?B?b3Z5NS9yRERyeUNES0xjTmN1TTNKcmtGUVQxemtXWlNDSG1DaHhsRUdOUU4r?=
 =?utf-8?B?ZUZEK0N0Rm4xN1pMeFovblhnOUI4NVhiMTRzaWN4alRpU2pDYlNkRXdYVWdz?=
 =?utf-8?B?R1phZWtVZUQwam9jUG91OU4wcTNDTUU1YzBscU9MSkhPZXREdCtmcVozT2h5?=
 =?utf-8?B?c1pRLy9FS2NzN2FQSUZlR2FkT0FCc3NQN3dyUmJicWFkQldHTXRlUk5LZDkz?=
 =?utf-8?B?Uk56U0Z6bUo0K3JkekZ0YnBRVFUxVGJaWWpUYXMzZTd2OGhQODdYSlhUOElB?=
 =?utf-8?B?c3VMcjNzYnRDYk8zbjh6MnF3MjE3cFRUWnJhM25GSG9SdjI2RElWbWJGZFI2?=
 =?utf-8?B?dVhDdGhQbmFyNXk4VkxpSHl5RTduSXJDNzVNMGFPTVRMQzVhUk91N1BjamJo?=
 =?utf-8?B?Mm9yNkp0dlB5OVRRYUJHR1htS05NSUpCQkFtdzEvNW05dDYwWXpnZjErazln?=
 =?utf-8?B?U0F3OXk2Y1ZHWDRXQ2ZvMXBNOFFmMWV5bkFXQm5JalRQVk1EOWJuUFkrTnFr?=
 =?utf-8?B?WE1KN29oYWNHcGcyK1RCMjAxd0p1Z2J4K1BCMWgwL2hjbkJkck0wWUZtQnpN?=
 =?utf-8?B?dHhndnRJWnFVVHY2cXlpTHRxNEJhYnJWQlNCa0tYcUtGbllvQVRBUXhqQ1R5?=
 =?utf-8?B?TURHUHpRRmZBZkF6TmY2Z1J0Q0J5TUUyamsrdm0vZmxNV2grQ1liSWIzMFVz?=
 =?utf-8?B?NTY0aWI3djcveXByKzloOFFBdlIxNXFwbXFHbnZPRzRSWFBvMnV2NCt4c1FO?=
 =?utf-8?B?QVFsTkZuN2EzS1g0bUQ3RjF1L2tZV3pjU0hUNStUOXJKTFlBbEFXMlR3dk5S?=
 =?utf-8?B?TG53bXhBUEQzaDFvRGgzKzZETFR1Q3o2dzZhcDB4MFpvVzdBU1dJSS94cVh3?=
 =?utf-8?B?bTVQSjZINHpHeUpjdUlhVHFyYUpVQkowVCs2RVpLaWJiLzZYMHdGZ2orZVZy?=
 =?utf-8?B?Tlh4Zkg3SDU4WTV4dHpibitTcVlrOXF4WmV1M3BEZ1J5ODU0amhLdVpSZ0RJ?=
 =?utf-8?B?Z0ZCdHBTMVlncFNaWHpzb1I1V3l2S2xLLzlzWUtWVS82S1NPcXY1UnMvamlF?=
 =?utf-8?B?d0preXA1eXlyVm1ubE5FQVZiVnBKOTcyQzJVbkJrZ2RiYzNCa1A0QmtyamlY?=
 =?utf-8?B?TDAxU21kbzkyenZqQnNVWk5ZSHRDeFIwSkoycU1JaFdrTlU3TnhKSEh5VTB5?=
 =?utf-8?B?bHMxeWlFY2Z3MHh3cWlQRTFCcDNRTFhabXRhVDlrWFk0NnF6d1lCc3hXY2l0?=
 =?utf-8?B?UXg3VFlQN2wvckdZM3R1SnFvQUhSZWpJWDQyQVFJd0NxTUVrM0I0SHJhSkhl?=
 =?utf-8?B?TjhORW9jQVp1N2VKN3BFYnNERWRVRkVRY1g5cXBOZCs0Mi9heEF1NjcyblYv?=
 =?utf-8?B?WjdWY1NZa3dXa0FpcVErUT09?=
X-Microsoft-Antispam-Message-Info: b4WfgBjh8zOj0iT31oyAHthLvIQwS6tDh3ud5aip8Tdebt7lQm7W+KedREx3PcadnEu4eR11/+h/3kBYE5UwqtJRMkzNfpXHoZgtc1p1drTf7wx1XgS++rq/or4kc6lynoI6rKcZ2C9gj+Kr4XK3ZwSx15MhUaYwmwyNirZVrQeX2sldOC3jLithYP3PIoxc6EVd3gqgyXDKa7yRnEc9VR52m7LyM/gNubyCTptJJb4++opoynTeYSdV75VJt/fr5WcDumQCOSZPe2YwoWE4kxBrt0vQot0risQwZyAxh1rhLk/HbBpdAlnUlEXJKmM1sBHvdAFZJPGCXZPo501KNwFHwiUiknFHufKudxDX/HY=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4490;6:sYvU8vm5PUcnpR3rXLf51+llpnqXVVVDoPIP0V4KJ3msYcJckOiq6xlnWyzfD3OsZRNV+EU7/fU6X+t8nUXQb8jmDImfQ3ehOVD2PUQaquHSm45BTPP/fib51xlU42zpHVziy3uxlmxmd1xiHtKwQ+aWtVaBiGXqnGsye7CqWFztYR7kMI6bWHADSyclxseDRX0dMK7WqyoZ3psJfAuzmT6Z0Vj855OFuNc89rftdnTipmKfBxigU3FU04LJqUSa1swj9iUrne319/hxpfvV8YrNR53S9WycfTIXB1+YZeWFKbDKjsd2c9Y/uiXKObzOuNdtUZyyAtztrM4BVKA+8VWoamQCqNQ5hGvo0YeIEhEU4S4RHlzwrPlLZ418/hBAbUaUSE7Ri8GgdA1dMd19JcLjYutPDypAQ0pJkOmyjRI3HnB6PmQRapwXNLrCQwFniRQ8Hu4VADDVTBvLFEJSSg==;5:8U0QQxkkE4tLi5BQiqWnKrkIJctYQpi5Mu2UdC50rSlLEWqnGKxP77INfYwJ1CA7MCzvMC7Y5F7C/WwMhXX5BfUjXZ/aFDThRVHZ8pLEpqDivkO/iAUcpy5/d6qH2O4n/wF4dNN9hI0kXaUh/fHFSXUEBn4eJdFR/N9wGDgnwwM=;7:arVdy/dOoYaLkEJndrGUy5ErsHiL7DPpmk1HjzqTd1vNZ9cAP6SoqvUCRPjDmtcEG2gCccv1kBVlory4fuqS+XdL7DZYQ9E2ixXRSPZKYQSvqVcX/RLPoSZb/zzusS5rkm7I0XggKpgQS7Xvo6mdwhrCvhsJsEt6yxe4eh4vQIJ40gcIWkU4eOykHVATAjZz8KBlC525EpxuUFNZ25IcPq6pz0k5Q8OCS+VWdCoa+AIWo/yxCBCINErj5kDnIcrW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 14:21:52.9078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 923dfc80-95bd-4e4f-58d1-08d5f170ce90
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4490
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horia Geantă <horia.geanta@nxp.com>

Previous commits:
commit 6e2387e8f19e ("staging: fsl-dpaa2/eth: Add Freescale DPAA2
Ethernet driver")
commit 39163c0ce0f4 ("staging: fsl-dpaa2/eth: Errors checking update")

have added bits that are not specific to the WRIOP accelerator.

Move these where they belong (in DPIO) such that other accelerators
can make use of them.

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Acked-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c |  4 ++--
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h | 18 +++++-------------
 drivers/staging/fsl-mc/include/dpaa2-fd.h      | 12 ++++++++++++
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 3963717..d5f0ac5 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -455,7 +455,7 @@ static int build_sg_fd(struct dpaa2_eth_priv *priv,
 	dpaa2_fd_set_format(fd, dpaa2_fd_sg);
 	dpaa2_fd_set_addr(fd, addr);
 	dpaa2_fd_set_len(fd, skb->len);
-	dpaa2_fd_set_ctrl(fd, DPAA2_FD_CTRL_PTA | DPAA2_FD_CTRL_PTV1);
+	dpaa2_fd_set_ctrl(fd, FD_CTRL_PTA | FD_CTRL_PTV1);
 
 	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
 		enable_tx_tstamp(fd, sgt_buf);
@@ -508,7 +508,7 @@ static int build_single_fd(struct dpaa2_eth_priv *priv,
 	dpaa2_fd_set_offset(fd, (u16)(skb->data - buffer_start));
 	dpaa2_fd_set_len(fd, skb->len);
 	dpaa2_fd_set_format(fd, dpaa2_fd_single);
-	dpaa2_fd_set_ctrl(fd, DPAA2_FD_CTRL_PTA | DPAA2_FD_CTRL_PTV1);
+	dpaa2_fd_set_ctrl(fd, FD_CTRL_PTA | FD_CTRL_PTV1);
 
 	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
 		enable_tx_tstamp(fd, buffer_start);
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index 905a4e6..9269cb0 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -124,21 +124,13 @@ struct dpaa2_eth_swa {
 #define DPAA2_FD_FRC_FAICFDV		0x0400
 
 /* Error bits in FD CTRL */
-#define DPAA2_FD_CTRL_UFD		0x00000004
-#define DPAA2_FD_CTRL_SBE		0x00000008
-#define DPAA2_FD_CTRL_FSE		0x00000020
-#define DPAA2_FD_CTRL_FAERR		0x00000040
-
-#define DPAA2_FD_RX_ERR_MASK		(DPAA2_FD_CTRL_SBE	| \
-					 DPAA2_FD_CTRL_FAERR)
-#define DPAA2_FD_TX_ERR_MASK		(DPAA2_FD_CTRL_UFD	| \
-					 DPAA2_FD_CTRL_SBE	| \
-					 DPAA2_FD_CTRL_FSE	| \
-					 DPAA2_FD_CTRL_FAERR)
+#define DPAA2_FD_RX_ERR_MASK		(FD_CTRL_SBE | FD_CTRL_FAERR)
+#define DPAA2_FD_TX_ERR_MASK		(FD_CTRL_UFD	| \
+					 FD_CTRL_SBE	| \
+					 FD_CTRL_FSE	| \
+					 FD_CTRL_FAERR)
 
 /* Annotation bits in FD CTRL */
-#define DPAA2_FD_CTRL_PTA		0x00800000
-#define DPAA2_FD_CTRL_PTV1		0x00400000
 #define DPAA2_FD_CTRL_ASAL		0x00020000	/* ASAL = 128B */
 
 /* Frame annotation status */
diff --git a/drivers/staging/fsl-mc/include/dpaa2-fd.h b/drivers/staging/fsl-mc/include/dpaa2-fd.h
index b55b89b..2576aba 100644
--- a/drivers/staging/fsl-mc/include/dpaa2-fd.h
+++ b/drivers/staging/fsl-mc/include/dpaa2-fd.h
@@ -67,6 +67,18 @@ struct dpaa2_fd {
 #define SG_FINAL_FLAG_MASK	0x1
 #define SG_FINAL_FLAG_SHIFT	15
 
+/* Error bits in FD CTRL */
+#define FD_CTRL_ERR_MASK	0x000000FF
+#define FD_CTRL_UFD		0x00000004
+#define FD_CTRL_SBE		0x00000008
+#define FD_CTRL_FLC		0x00000010
+#define FD_CTRL_FSE		0x00000020
+#define FD_CTRL_FAERR		0x00000040
+
+/* Annotation bits in FD CTRL */
+#define FD_CTRL_PTA		0x00800000
+#define FD_CTRL_PTV1		0x00400000
+
 enum dpaa2_fd_format {
 	dpaa2_fd_single = 0,
 	dpaa2_fd_list,
-- 
2.7.4


Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB07C67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 03:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF4720846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 03:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="oOR3drp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF4720846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeGZEUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 00:20:02 -0400
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:14720
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbeGZEUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 00:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MU7FKbcQfbcdg38aprfplgqRk3ym3qS3zfnHU1bT9EE=;
 b=oOR3drp5HPsBLWu+XL5hDJ32of4PJja5c9S6PmwQMAy5ML6oJgBpYPhzBRxzNZBsZLsMhRdQfoZXpSm/h1CQZAScCApYZz4KwqE1InHL4HIrg62UIIVrUH1hVYw5ega48dsPDY87rxm5zwBJYjpRf4NLw/a2W0ZCXqZsbW0BfQ8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM0PR05MB4450.eurprd05.prod.outlook.com (2603:10a6:208:5a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Thu, 26 Jul 2018 03:05:17 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fiWaN-0005Qa-N1; Wed, 25 Jul 2018 21:05:03 -0600
Date:   Wed, 25 Jul 2018 21:05:03 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: linux-next: build warning after merge of the rdma tree
Message-ID: <20180726030503.GA18170@mellanox.com>
References: <20180726105553.00a36e3c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726105553.00a36e3c@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: YTXPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::15) To AM0PR05MB4450.eurprd05.prod.outlook.com
 (2603:10a6:208:5a::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 978a5d8c-b1fd-4c55-6d41-08d5f2a49dbc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4450;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;3:g/2KdTM6yTNS3Y6qSAxOnqaZodhWzvLamMt1zTZneuZOVXcDios8mjDRZr8cQFCZDy7UHQjWwaUOeXGPaYxyns/jOKxnRGz9KrW4JBEhPC7YL7XzL5ggDBB9WMiduo0rir+S29SQA6vXCqZQNC878xu20wcjKJUQ00L2zMshcQW98Q1LeNb7ggQq+iSpPsQdNN2vhAbgXfjR+OjrOxBvAG0Za9l1qXo2AlCC3JcoI89+b5qcduSV79Lq0/ZyOEME;25:hfBM4muAhDUiG68pADtxj8kva89n3crhNIuTgn6iCJy4xrdHI5cXATpZsL0dSsx5H0vCNtC9DRwFhYj6G4hvJQ75P3BesfujvcGoMzuSAVbC/XnESvCPyCshIE/+DPdIVXKFRZYMPbOwPnF6ITtRVrr2Wu555nvJA+jb0JdnNZciQs7XtfQgBBoiSM1BchpDOxTmSQGgI2dmxMFi/TlNzsiiOgDfgcJb+djKwMXN2BcZ4oZmPnC8aEyhrcW3kPNWon2oQvPbrjkffc/xpFIFi4tf6VaUjMxdH+M/54+Igfv/Zq1jnhI7uklNTE13W60sew40VGZkfuSBQB/VnsZCaA==;31:B28eAH11teky+eNhRyPRuLQGawCkv90c+U8cfb54O2/eLFHA6cRsScTEXVk+hMumDmT9QT3+X/K87d2CwX4iBywNtDaJXxrjtv4R6WTNzNYuNG3KLVUwHGeyLzp2Bz0pY4uIJQRItYCPaxuZw9cxS0EA8RXN88DECcwNJxnYgAi38nuvvRoeM0Dy7k06dBvrI0pZa51cB1a1npL8F0d7nYiRnHnFAyK7b+lbZmV6KDc=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4450:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;20:eajkrDNh+dilq40DZA4MM8btPLaqqoeo8o2elIr+r60wo1A0yUn9Jg1LA6DUrfMYcwlqUzMWH7AX9KGD6S1Yi0WzAX2Ku8ErfqqNH10abNLnP76KqeXaYFuUGx6C0xcDJ0zy31LarovHYfa0pIowN0bWBHK89163bZ4v2bkHy0OUsLn/RgyjwAndURxAycb2PyhH4DoCM/GkZ58wu13qylcA/8VBLE4Pd30bYaldwj6XLSIx8O1bD9oCVMY2gQUGzl9Ses789XN8V86ZkIVBRXOrqFiscg/ksLKdEDl+wni+fmkh9Aib+JRr8L4O4DjGDT1pK4hwicshHo/knPJg/osTZtb0EC1pwuvvCb9nafOVmA3bXfFwFZlUOvKmap8shUSBpFFp7W5BH0XKX4OY+RgKBl3Tu0mlXh5FIkaLrokZBD9b7tOyXvRApMrpj3TZ3JLhI7245cq8XWw84u+/hT7CPNjm85IoSbyVHNFKR+SYLRkTQ7sOe60BL5oAq9gK;4:ZguckkD3QDH+H0fhCZnLlcGvQJYn6qFykHUXgYrnDreQB82B1GuAkK/NyfSsYAsxDUEENeRbuHa0Vf72vt38+MBOTrR4V6mzitrrFdF7nIeIbnAWPQIgIgTkEHDGML1sgjHsdzGtzefh+bcw56HYaBCZH2PQRTXRN3JzJHMCpsqEMUW/twsveJkIBJqf/8E+qGnXO+7JRxrFJyHL8MJLA8ZIL2ru2AXvKKs/ik0CoNUymXcKspuT0HS1+CbfBmEfqIFoHuEzIHy3PYiuYADH/A==
X-Microsoft-Antispam-PRVS: <AM0PR05MB44500C748B14303972F9B504CF2B0@AM0PR05MB4450.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR05MB4450;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4450;
X-Forefront-PRVS: 07459438AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(376002)(346002)(396003)(53754006)(199004)(189003)(68736007)(58126008)(16586007)(69596002)(14444005)(36756003)(66066001)(46656002)(122856001)(7736002)(316002)(47776003)(305945005)(6916009)(26005)(76176011)(9746002)(52116002)(9786002)(54906003)(5660300001)(476003)(386003)(446003)(2616005)(186003)(11346002)(486006)(4326008)(6246003)(53936002)(478600001)(57986006)(3846002)(81166006)(8676002)(83796002)(105586002)(8936002)(81156014)(86362001)(106356001)(229853002)(2906002)(50466002)(97736004)(6116002)(23726003)(1076002)(33656002)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4450;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4450;23:3vbi2/j/kp/3UO7q0RbBUm+tgYCjEg3AW3myJhTnp?=
 =?us-ascii?Q?c35zOOJgTI2UFuN84GK55q3iVDb+bzwlSFr2pesi3STFgfyNflPKcPVbHTdD?=
 =?us-ascii?Q?L1LbVINk/kQNn3vhw8q5TILFrBWAsO6TMWMLGTHc99S996e7kjunPdC8oNRX?=
 =?us-ascii?Q?TKm0wXfHswPOUdq9zH2fQOzsvDR+szoX8tOTCEEdmpATvkOEdAZYXUGKo6qh?=
 =?us-ascii?Q?hW1/ygRf4W8UvaTBKtP6AaL3BFACN9NDPFbK2PHIDnS7ukRLNjFoobSJLZ1M?=
 =?us-ascii?Q?jsg53Qoz68xd2LF52Gd8FGlg70+JdvuMn4mh21iwbSE357KvnrSdaJtMEndU?=
 =?us-ascii?Q?Tan93BQtrE+wBeKXUjiEEDCXN46nORdcG+AoGf9L8zbtRWW3lZhzXitpUIPw?=
 =?us-ascii?Q?i8vWfW7Qc9Un9MSTnYJy8otP9EYXh0Gy1KP0ii9KbnW63At/HMmMETsvPtcS?=
 =?us-ascii?Q?ljp6GNBaPIgPpyT6zFQASEactPPp0nZL2MZVFQC9Nm2rE0qKz3taMYdtVM+l?=
 =?us-ascii?Q?mHsMULMD+rkOdFf1JHGM9aasA9MVeqDz+Qkj0RMxLPpA2Rr6hu3B6QLEB7ec?=
 =?us-ascii?Q?tWBQrznM0iE+hnqPvq1dp6WgbiXWyke2lXEttutVOQJTLpDh7M3HiuySA7UX?=
 =?us-ascii?Q?KZwLtqbDoPI/pmyXsA1woAaFEcNgNsYQvjXbVHdHqOfLPJ6ZW7ZqsIrGf8Pa?=
 =?us-ascii?Q?r7FA0hOLfONQLodxPaeEAhHiO4AUqIqZUWt3NzNWAKvDR5KiX1BHvhEofstK?=
 =?us-ascii?Q?+OdAV9SSnHtVTVzPpKSbxKYGLit26nFv178xYZWn8SCK+aOs+NCWdX3EkjpX?=
 =?us-ascii?Q?RdgSNOZ7850M45mjdfE1QtGwOZLWaSZEneNhwTBQdX4dtsKyYcIlnc5WAGpn?=
 =?us-ascii?Q?hl6JZJAC3ZL/fyl5iqPs4pLvbBh+ZwHE111V64h7sLCpH4m5nojIEvtcPiDT?=
 =?us-ascii?Q?GOje0875IvcAf4+vcuK1ZoP+mCz3eR37j3i5GGR5ZdAeWSzS6mP5QXt+fSUP?=
 =?us-ascii?Q?nLRXa6wcLWpcUn0BJc1pVvODjz1BOVFCKnMtT7eU4GDKQiOHqpSkcG+d6BYZ?=
 =?us-ascii?Q?0sQKH0Y7Aay1dbD1jfjGkb5l0UifEr3jYhNexs3/reOxELDuXm3Rsn6IG+G1?=
 =?us-ascii?Q?mxHTc4BlSDOwpzob2aLKr0O/nmTU5mhosRCZx2VeUMD0Cp+snUJA+7ktTGib?=
 =?us-ascii?Q?nrcVpPaTCxWGYMEEdkhyMj75UFL+5z9pP3kAuZTmpgmZ+TCSS98pi4RtM9ZM?=
 =?us-ascii?Q?WUlI2pLwXzDcOiEYRylF4PG8P0jrgxg7F4zc86NSvYNoFmWg5brBPmxbCyGo?=
 =?us-ascii?Q?7tytoXWuJZ8UUbvyOlak8nfD2tgVA/uydZLGZQW4lFbMPFaYJ/Qt/RDFcCqi?=
 =?us-ascii?Q?hRhTX3l0RSrKK143U1EUj7tSO4=3D?=
X-Microsoft-Antispam-Message-Info: g3lzLeAPooYb2oJ1TB5Jjksk0UyPUteQ3FPtw0aNb0e1rsbbXfyxY9SVt2eKB5wz8CrwYycT++Zgqp8mQY9EpjCXEzRgPna6sblu1g1Z5larSOG+mh//V9OHAUIzw+oVqhMfY6Ddfie1ic7WWR98VQWMgVuc9VHp6VVmSSqCGUGoL0gr/KyyfZ5AbdAdnTLs+IWEK0UCKYnN6pRKj+rBXijwdaAWipysrxTzt3iUpnWlRE+my0FR/JnD4kLWLr2bKOWV9qj+ux8Aa7OqkoC40KLfGFLAeujhPRyX5S7eV93F1J8vGJrEWmhKYrIkFD9XuEQbeBaoN3ZieynCckX28jUx8ttzl8SkqjeDfh5bTic=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;6:cqqBAOR9/TzqjZLrVFg2bm2iR5Zf22oMDXPKlBeC3HAAbyfvV9MlwRda+pYcWj8isNUjTbnSFSZb9Diw7C+1Beou6X137N2HuN3FmIeJQt7+r8oh7/nND26T/BOtZEVT70Qvh2fhsRdlmCywClSyxVVQgsZWMzzP07gxf/zssB2lOUN91T/8MqsufI213S3WkrauMD4JSU+jbTFp4pIAX8QP+dc3Ywl+nLst5Qo3BNdwK6duq2tHCPC9ykyAAyEdeyTe+rv4jY3OHJV5k3jLhY2AWyfJ6pr4fd0Q87APGArmWh0tEs2XQ+X55qxOg+ejc01CeYbztnprMflT+VqV+yDnMPPSwCaPHJ+mZigO5b1Io/Kzd18K70ECLLBFMsa0EwmDlad/HdZWQGRe8e6Ciyk+UEgAbVKke878wqL3stpi05bsKtmWY/+AgYwn/PsJVNR9tZqnqUpflb505Rw/ow==;5:Pa/R+JOmbuQOoqG+35K2bgbqs6Ywanbu6CbyLptAjnv9/4Y6Z52SXROa3FLohIZoyCRyDfviRRKs5WXIYRckGghuuEdFtUefi2LPLN5iCx93/ULwI35qzigjMf0OILL1xjofSH61Tyv9t0k3ZaU8Nau/h9fmSfmqvs53XM8pSVo=;7:Mgb3cgF4l1Jq2slq2o2H2bCH0G8rt5OpPFbOuEzoEC5qimhveuRo9QHe8xlVtdRasl/ECK9qLlr8avO8ArRAtLcuct7sNtMFmB4bJqVm7p+1yPlyWPzgQMr0624WaYa0t5vWlyM8GMpcY9nLcNrZKEoO1pg+yXjBWQElCKYBxCAPY2mqFNjYPEE8ORdanVCHciA9VCdaGC/R2P0/oGzZH0pmIHQOrBkPsS4jdfXiOsFpEzsOtetPuCMir3OZJ2RB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 03:05:17.5981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 978a5d8c-b1fd-4c55-6d41-08d5f2a49dbc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4450
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 10:55:53AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the rdma tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
> 
> net/sunrpc/xprtrdma/svc_rdma_rw.c: In function 'svc_rdma_post_chunk_ctxt':
> net/sunrpc/xprtrdma/svc_rdma_rw.c:350:5: warning: 'bad_wr' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   if (bad_wr != first_wr)
>      ^

Huh. I'm quite surprised 0-day build service didn't warn on this.

> Introduced by commit
> 
>   ed288d74a9e5 ("net/xprtrdma: Simplify ib_post_(send|recv|srq_recv)() calls")
> 
> This is an actual problem.

Yes, for sure. Bart?

Thanks,
Jason

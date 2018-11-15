Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9403C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A610121582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bmRr6JMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A610121582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbeKPCzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:55:08 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54384 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387833AbeKPCzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:55:08 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAFGhZuh081079;
        Thu, 15 Nov 2018 16:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=/vKA5+v/9nBTNdNrsTx8771Q4RyEWMGuv2TG8jfaGt8=;
 b=bmRr6JMpNa6Rab31lq7gcSdy3QNKdez2rmyM9/WMsAlSFQf3fixHJpA/5iRFmeI9KUYW
 HnyzTkxpEFHN8Lt5PhLIkLWwGO+dUu35i0xCPDxi2fwMYfCMlNhj6FWDGiiq+ljLg2I+
 GgaQ+TlqOZeIh5dFQCpFxGCjAYadxnjossDckBs217t37kHA/XQx8JiPYzmxaHPzdmnY
 7IKPNaxsNrrkSUk7HML0di2I+dopqsK2AnPKrGlnN6bwNwl4/LnMdNHWxxK09RjyWy8v
 hEz2/nsulaIK20TizuuE78s2FpIeDCiFAZXpP+8Q/QAh/zMBhz/Sp2odZnP4TZMBeurN Rw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2nr7csanv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Nov 2018 16:45:58 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAFGjvoq024271
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Nov 2018 16:45:58 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAFGjtxg014514;
        Thu, 15 Nov 2018 16:45:56 GMT
Received: from unbuntlaptop (/64.114.255.114)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Nov 2018 08:45:55 -0800
Date:   Thu, 15 Nov 2018 19:45:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     kbuild-all@01.org, boris.brezillon@bootlin.com,
        miquel.raynal@bootlin.com, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        michals@xilinx.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, nagasuresh12@gmail.com,
        robh@kernel.org,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: Re: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Message-ID: <20181115164552.GB14069@unbuntlaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541739641-17789-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9078 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811150147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Naga-Sureshkumar-Relli/dt-bindings-mtd-arasan-Add-device-tree-binding-documentation/20181110-034106
base:   git://git.infradead.org/linux-mtd.git nand/next

smatch warnings:
drivers/mtd/nand/raw/arasan_nand.c:353 anfc_rw_dma_op() warn: right shifting more than type allows 32 vs 32
drivers/mtd/nand/raw/arasan_nand.c:1032 anfc_setup_data_interface() warn: unsigned 'sdr->mode' is never less than zero.

# https://github.com/0day-ci/linux/commit/8db68ae6047a392d3e4092cbd6d3051eec1edd47
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 8db68ae6047a392d3e4092cbd6d3051eec1edd47
vim +353 drivers/mtd/nand/raw/arasan_nand.c

8db68ae6 Naga Sureshkumar Relli 2018-11-09  325  
8db68ae6 Naga Sureshkumar Relli 2018-11-09  326  static void anfc_rw_dma_op(struct mtd_info *mtd, u8 *buf, int len,
8db68ae6 Naga Sureshkumar Relli 2018-11-09  327  			   bool do_read, u32 prog, int pktcount, int pktsize)
8db68ae6 Naga Sureshkumar Relli 2018-11-09  328  {
8db68ae6 Naga Sureshkumar Relli 2018-11-09  329  	dma_addr_t paddr;
8db68ae6 Naga Sureshkumar Relli 2018-11-09  330  	struct nand_chip *chip = mtd_to_nand(mtd);
8db68ae6 Naga Sureshkumar Relli 2018-11-09  331  	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
8db68ae6 Naga Sureshkumar Relli 2018-11-09  332  	struct anfc_nand_chip *achip = to_anfc_nand(chip);
8db68ae6 Naga Sureshkumar Relli 2018-11-09  333  	u32 eccintr = 0, dir;
8db68ae6 Naga Sureshkumar Relli 2018-11-09  334  
8db68ae6 Naga Sureshkumar Relli 2018-11-09  335  	if (pktsize == 0)
8db68ae6 Naga Sureshkumar Relli 2018-11-09  336  		pktsize = len;
8db68ae6 Naga Sureshkumar Relli 2018-11-09  337  
8db68ae6 Naga Sureshkumar Relli 2018-11-09  338  	anfc_setpktszcnt(nfc, pktsize, pktcount);
8db68ae6 Naga Sureshkumar Relli 2018-11-09  339  
8db68ae6 Naga Sureshkumar Relli 2018-11-09  340  	if (!achip->strength)
8db68ae6 Naga Sureshkumar Relli 2018-11-09  341  		eccintr = MBIT_ERROR;
8db68ae6 Naga Sureshkumar Relli 2018-11-09  342  
8db68ae6 Naga Sureshkumar Relli 2018-11-09  343  	if (do_read)
8db68ae6 Naga Sureshkumar Relli 2018-11-09  344  		dir = DMA_FROM_DEVICE;
8db68ae6 Naga Sureshkumar Relli 2018-11-09  345  	else
8db68ae6 Naga Sureshkumar Relli 2018-11-09  346  		dir = DMA_TO_DEVICE;
8db68ae6 Naga Sureshkumar Relli 2018-11-09  347  	paddr = dma_map_single(nfc->dev, buf, len, dir);
8db68ae6 Naga Sureshkumar Relli 2018-11-09  348  	if (dma_mapping_error(nfc->dev, paddr)) {
8db68ae6 Naga Sureshkumar Relli 2018-11-09  349  		dev_err(nfc->dev, "Read buffer mapping error");
8db68ae6 Naga Sureshkumar Relli 2018-11-09  350  		return;
8db68ae6 Naga Sureshkumar Relli 2018-11-09  351  	}
8db68ae6 Naga Sureshkumar Relli 2018-11-09  352  	writel(paddr, nfc->base + DMA_ADDR0_OFST);
8db68ae6 Naga Sureshkumar Relli 2018-11-09 @353  	writel((paddr >> 32), nfc->base + DMA_ADDR1_OFST);
                                                               ^^^^^^^^^^^^^
This is zero.  Which is probably intended and fine...  I was hoping it
would have the other line 1032 warning in the email...

8db68ae6 Naga Sureshkumar Relli 2018-11-09  354  	anfc_enable_intrs(nfc, (XFER_COMPLETE | eccintr));
8db68ae6 Naga Sureshkumar Relli 2018-11-09  355  	writel(prog, nfc->base + PROG_OFST);
8db68ae6 Naga Sureshkumar Relli 2018-11-09  356  	anfc_wait_for_event(nfc);
8db68ae6 Naga Sureshkumar Relli 2018-11-09  357  	dma_unmap_single(nfc->dev, paddr, len, dir);
8db68ae6 Naga Sureshkumar Relli 2018-11-09  358  }
8db68ae6 Naga Sureshkumar Relli 2018-11-09  359  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

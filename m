Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9FCC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA11F20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wmb8pV0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA11F20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389118AbeHANvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 09:51:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41426 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389076AbeHANvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 09:51:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w71C3QvF015888;
        Wed, 1 Aug 2018 12:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=3TAUidmNFy1cHdWg/dKHkCv8a+/7oVcznM0BcNRE97o=;
 b=Wmb8pV0X4VenWRV035hU52AuctXyE59eyk9Fh3CVLCpIvwWFosso3/UVbE+LQtzMwIKa
 u88zdGCz5G7I5oNDJ9+qg/SpgzsVrBRDTjU1eZLBgAYDRHqYLJHsKyHdbjUUwZ/kELtZ
 alTAYhDaYDYcPGwY3lb5A+N9b+/iRScGe8AWZ3Wd/J07kEwVHQi69T1lqnUNQt6nxdiS
 SrRWsvtK7hLs0suJE/TZzmEstW7sirqRh07AIm6B1M/KNOVyYAnQFG2/V+3mQBJqJDq+
 0oykIo9RtidgOqZmXwwdU+2nLiJgOzNhrZ2ADEI/zs+3mtGGzfHZZWQqQIvI9GjD5i/K OA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2kgfwt5chw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Aug 2018 12:06:03 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w71C61H2020043
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Aug 2018 12:06:01 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w71C60oi010285;
        Wed, 1 Aug 2018 12:06:00 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Aug 2018 05:05:59 -0700
Date:   Wed, 1 Aug 2018 15:05:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jheng-Jhong Wu <goodwater.wu@gmail.com>,
        Palle Christensen <palle.christensen@microsemi.com>
Cc:     devel@driverdev.osuosl.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Palle Christensen <palle.christensen@microsemi.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arun Nagendran <arunrasppi@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] staging:mt29f_spinand: MT29F2G failing as only 16-bit
 arguments and variables used for addressing.
Message-ID: <20180801120551.ju6zhxhoef6w5zim@mwanda>
References: <1533093861-9761-1-git-send-email-goodwater.wu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533093861-9761-1-git-send-email-goodwater.wu@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8971 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1808010128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 11:24:19AM +0800, Jheng-Jhong Wu wrote:
> For NAND flash chips with more than 1Gbit (e.g. MT29F2G) more than 16 bits
> are necessary to address the correct page. The driver sets the address for
> more than 16 bits, but it uses 16-bit arguments and variables (these are
> page_id, block_id, row) to do address operations. Obviously, these
> arguments and variables cannot deal with more than 16-bit address.
> 
> Signed-off-by: Jheng-Jhong Wu <goodwater.wu@gmail.com>

This seems reasonable...  It would be needed to make commit 6efb21d6d0e7
("staging:mt29f_spinand: MT29F2G failing as only 16 bits used for
addressing.") work.  It also fixes a static checker warning.

My only concern is that the mtd/nand code seems to use -1 as a magical
page_id.  For example:


  2069  /**
  2070   * nand_exit_status_op - Exit a STATUS operation
  2071   * @chip: The NAND chip
  2072   *
  2073   * This function sends a READ0 command to cancel the effect of the STATUS
  2074   * command to avoid reading only the status until a new read command is sent.
  2075   *
  2076   * This function does not select/unselect the CS line.
  2077   *
  2078   * Returns 0 on success, a negative error code otherwise.
  2079   */
  2080  int nand_exit_status_op(struct nand_chip *chip)
  2081  {
  2082          struct mtd_info *mtd = nand_to_mtd(chip);
  2083  
  2084          if (chip->exec_op) {
  2085                  struct nand_op_instr instrs[] = {
  2086                          NAND_OP_CMD(NAND_CMD_READ0, 0),
  2087                  };
  2088                  struct nand_operation op = NAND_OPERATION(instrs);
  2089  
  2090                  return nand_exec_op(chip, &op);
  2091          }
  2092  
  2093          chip->cmdfunc(mtd, NAND_CMD_READ0, -1, -1);
                                   ^^^^^^^^^^^^^^      ^^
  2094  
  2095          return 0;
  2096  }
  2097  EXPORT_SYMBOL_GPL(nand_exit_status_op);

I'm not sure if this affect spinand_read_page() etc.

regards,
dan carpenter


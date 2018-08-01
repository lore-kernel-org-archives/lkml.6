Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E88C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F33920841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JKokspkk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F33920841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387508AbeHAJEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:04:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48220 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733169AbeHAJEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:04:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w717EHJ3182104;
        Wed, 1 Aug 2018 07:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=C06iPA911Ew5D70MstpVbAnnLJKzMcg2rbMroCwO1/0=;
 b=JKokspkkLC6fpKvetlxPh51JopE4OCQ394I6G49Iej+Y6qwQnMR2hgj4f4ezvmD+KOiC
 uiXqiCizS0Nh4jxNflDh2Rx7Av3lRuQ6VzHMBfkd9+CAXJp+EiAQY3+XI4z6SQNm5CTm
 IOTnSYuiYNO797i9UZiN6x+fDJ0zVuCf9kdK0L8awTXsFF9s/hQ7DycIp64UEPi4TEZy
 p1KAQkgZU0wzut5nyBInYgikEVVvUNYcEVhS2RFdrLC3ePzvi7Vhty1m48IUuwQ8X4s4
 V54T88xq3hyz5chSAh8s4kGV+1CBEB8jBPjXPPPizIS0Fpmz5AV5HPESZOiki5hZ2QmS 7A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2kgfwt48m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Aug 2018 07:20:07 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w717K3sD032197
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Aug 2018 07:20:03 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w717K13P006237;
        Wed, 1 Aug 2018 07:20:01 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Aug 2018 00:20:01 -0700
Subject: Re: [next-20180727][qla2xxx][BUG] WARNING: CPU: 12 PID: 511 at
 drivers/scsi/scsi_lib.c:691 scsi_end_request+0x250/0x280
To:     Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Madhani, Himanshu" <himanshu.madhani@cavium.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        jejb@linux.vnet.ibm.com, Jens Axboe <axboe@kernel.dk>,
        dgilbert@interlog.com, "bart.vanassche" <bart.vanassche@wdc.com>,
        rosattig@br.ibm.com, kyle.mahlkuch@ibm.com
References: <1533105183.23332.15.camel@abdul>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <ea4ba28e-0b03-e0d0-a1f2-4e8cf06326b8@oracle.com>
Date:   Wed, 1 Aug 2018 15:19:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533105183.23332.15.camel@abdul>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8971 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1808010080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abdul

On 08/01/2018 02:33 PM, Abdul Haleem wrote:
> # mkfs -t ext4 /dev/mapper/mpatha
> mke2fs 1.43.1 (08-Jun-2016)
> Found a dos partition table in /dev/mapper/mpatha
> Proceed anyway? (y,n) y
> Discarding device blocks: 
> qla2xxx [0106:a0:00.1]-801c:2: Abort command issued nexus=2:1:0 --  1 2002.
> qla2xxx [0106:a0:00.0]-801c:0: Abort command issued nexus=0:1:0 --  1 2002.
> qla2xxx [0106:a0:00.1]-801c:2: Abort command issued nexus=2:1:0 --  1 2002.
> qla2xxx [0106:a0:00.0]-801c:0: Abort command issued nexus=0:1:0 --  1 2002.
> WARNING: CPU: 12 PID: 511 at drivers/scsi/scsi_lib.c:691 scsi_end_request+0x250/0x280
...
> NIP [c000000000690080] scsi_end_request+0x250/0x280
> LR [c00000000068fe80] scsi_end_request+0x50/0x280
> Call Trace:
> [c00000027d39b600] [c00000000068fe80] scsi_end_request+0x50/0x280 (unreliable)
> [c00000027d39b660] [c0000000006904ac] scsi_io_completion+0x29c/0x7d0
> [c00000027d39b710] [c0000000006848e4] scsi_finish_command+0x104/0x1c0
> [c00000027d39b790] [c00000000068f148] scsi_softirq_done+0x198/0x1f0
> [c00000027d39b820] [c0000000004f2b80] blk_mq_complete_request+0x130/0x1d0
> [c00000027d39b860] [c00000000068d27c] scsi_mq_done+0x2c/0xe0
> [c00000027d39b890] [d000000004291080] qla2xxx_qpair_sp_compl+0xa8/0x140 [qla2xxx]
> [c00000027d39b900] [d0000000042cc9d0] qla2x00_process_completed_request+0x68/0x140 [qla2xxx]
> ------------[ cut here ]------------
> kernel BUG at block/blk-core.c:3196!

blk_finish_request

BUG_ON(blk_queued_rq(req))

We are also suffering a similar issue on qla2xxx,
the BUG_ON in blk_finish_request is triggered while there are lots of command aborted.
The root cause should be qla2xxx driver still invoke scsi_done for an aborted command
and cause race between requeue path and normal complete path.

Add Himanshu Madhani from qlogic team.
It seems that they are working on this.

Thanks
Jianchao


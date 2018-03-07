Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754141AbeCGCRF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 21:17:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45600 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753940AbeCGCRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 21:17:02 -0500
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        Bart.VanAssche@wdc.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4] scsi: core: use blk_mq_requeue_request in __scsi_queue_insert
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1520042049-8874-1-git-send-email-jianchao.w.wang@oracle.com>
Date: Tue, 06 Mar 2018 21:16:51 -0500
In-Reply-To: <1520042049-8874-1-git-send-email-jianchao.w.wang@oracle.com>
        (Jianchao Wang's message of "Sat, 3 Mar 2018 09:54:09 +0800")
Message-ID: <yq1fu5cpr3g.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8824 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803070021
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jianchao,

> In scsi core, __scsi_queue_insert should just put request back on
> the queue and retry using the same command as before. However, for
> blk-mq, scsi_mq_requeue_cmd is employed here which will unprepare
> the request. To align with the semantics of __scsi_queue_insert,
> use blk_mq_requeue_request with kick_requeue_list == true and put
> the reference of scsi_device.

Applied to 4.17/scsi-queue, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering

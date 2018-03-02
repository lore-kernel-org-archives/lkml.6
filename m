Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164263AbeCBCST (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 21:18:19 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52202 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163939AbeCBCSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 21:18:17 -0500
Subject: Re: [PATCH V2] scsi: core: use blk_mq_requeue_request in
 __scsi_queue_insert
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: jejb@linux.vnet.ibm.com, Bart.VanAssche@wdc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <1519808113-2863-1-git-send-email-jianchao.w.wang@oracle.com>
 <yq1371jz1xx.fsf@oracle.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <f7e93d3c-f7ee-0142-73b7-60ff868fcb34@oracle.com>
Date: Fri, 2 Mar 2018 10:18:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <yq1371jz1xx.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803020021
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi martin

On 03/02/2018 09:44 AM, Martin K. Petersen wrote:
>> In scsi core, __scsi_queue_insert should just put request back on the
>> queue and retry using the same command as before. However, for blk-mq,
>> scsi_mq_requeue_cmd is employed here which will unprepare the
>> request. To align with the semantics of __scsi_queue_insert, use
>> blk_mq_requeue_request with kick_requeue_list == true and put the
>> reference of scsi_device.
>>
>> V1 -> V2:
>>  - add put_device on scsi_device->sdev_gendev
> Also, please put changelog after the --- delimiter.
> 

Yes, I will modify this next version.

Thanks 
Jianchao

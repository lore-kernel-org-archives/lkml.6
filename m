Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754086AbeEHFeT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 01:34:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54698 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbeEHFeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 01:34:17 -0400
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] scsi: 3w-9xxx: fix a missing-check bug
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1525740413-23443-1-git-send-email-wang6495@umn.edu>
Date: Tue, 08 May 2018 01:34:10 -0400
In-Reply-To: <1525740413-23443-1-git-send-email-wang6495@umn.edu> (Wenwen
        Wang's message of "Mon, 7 May 2018 19:46:43 -0500")
Message-ID: <yq1muxaww19.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8886 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=752
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805080054
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wenwen,

> In twa_chrdev_ioctl(), the ioctl driver command is firstly copied from the
> userspace pointer 'argp' and saved to the kernel object 'driver_command'.
> Then a security check is performed on the data buffer size indicated by
> 'driver_command', which is 'driver_command.buffer_length'. If the security
> check is passed, the entire ioctl command is copied again from the 'argp'
> pointer and saved to the kernel object 'tw_ioctl'. Then, various operations
> are performed on 'tw_ioctl' according to the 'cmd'. Given that the 'argp'
> pointer resides in userspace, a malicious userspace process can race to
> change the buffer size between the two copies. This way, the user can
> bypass the security check and inject invalid data buffer size. This can
> cause potential security issues in the following execution.
>
> This patch checks for capable(CAP_SYS_ADMIN) in twa_chrdev_open()t o avoid
> the above issues.

Applied patch 1 + 2 to 4.18/scsi-queue. Thank you.

-- 
Martin K. Petersen	Oracle Linux Engineering

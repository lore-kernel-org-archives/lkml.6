Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeDTXPy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 19:15:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42394 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbeDTXPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 19:15:52 -0400
To: Martin Wilck <mwilck@suse.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        Xose Vazquez Perez <xose.vazquez@gmail.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH v3 0/6] scsi: handle special return codes for ABORTED COMMAND
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180417233511.6573-1-mwilck@suse.com>
Date: Fri, 20 Apr 2018 19:15:38 -0400
In-Reply-To: <20180417233511.6573-1-mwilck@suse.com> (Martin Wilck's message
        of "Wed, 18 Apr 2018 01:35:05 +0200")
Message-ID: <yq1efj9h3l1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8869 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=752
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804200232
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Martin,

> Here is another attempt to handle the special return codes for ABORTED
> COMMAND for certain SCSI devices. Following MKP's recommendation, I've
> created two new BLIST flags, simplifying the code in scsi_error.c
> compared to the previous versions. Rather than using "free" bits, I
> increased the length of blist_flag_t to 64 bit, and used previously
> unused bits. I also added checking for obsolete and unused bits.
>
> For the blist_flag_t size increase, I used sparse to try and avoid
> regressions; that necessitated fixing sparse's errors for the current
> code first.

Much better, thanks for reworking this. Applied to 4.18/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering

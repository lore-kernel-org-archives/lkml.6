Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeDTXeh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 19:34:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52432 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752047AbeDTXef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 19:34:35 -0400
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bradley Grove <linuxdrivers@attotech.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Tomas Henzl <thenzl@redhat.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND 2] scsi: esas2r: use ktime_get_real_seconds()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180420160219.3560091-1-arnd@arndb.de>
Date: Fri, 20 Apr 2018 19:34:04 -0400
In-Reply-To: <20180420160219.3560091-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Fri, 20 Apr 2018 18:02:09 +0200")
Message-ID: <yq11sf9h2qb.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8869 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=373
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804200234
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> do_gettimeofday() is deprecated because of the y2038 overflow.  Here,
> we use the result to pass into a 32-bit field in the firmware, which
> still risks an overflow, but if the firmware is written to expect
> unsigned values, it can at least last until y2106, and there is not
> much we can do about it.
>
> This changes do_gettimeofday() to ktime_get_real_seconds(), which at
> least simplifies the code a bit, and avoids the deprecated
> interface. I'm adding a comment about the overflow to document what
> happens.

Applied to 4.18/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

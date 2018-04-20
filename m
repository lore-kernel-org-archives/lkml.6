Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeDTXiY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 19:38:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52340 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbeDTXiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 19:38:23 -0400
To: Arnd Bergmann <arnd@arndb.de>
Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] scsi: ips: fix firmware timestamps for 32-bit
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180420160459.3621883-1-arnd@arndb.de>
Date: Fri, 20 Apr 2018 19:38:11 -0400
In-Reply-To: <20180420160459.3621883-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Fri, 20 Apr 2018 18:04:40 +0200")
Message-ID: <yq1wox1fnz0.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8869 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=573
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804200235
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> do_gettimeofday() is deprecated since it will stop working in 2038 on
> 32-bit platforms, leading to incorrect times passed to the firmware.
> On 64-bit platforms the current code appears to be fine, as the
> calculation passes an 8-bit century number into the firmware that can
> represent times long in the future (possibly until 25599).
>
> Using ktime_get_real_seconds() to get a 64-bit seconds value and
> time64_to_tm() to convert it into the firmware format greatly
> simplifies the ips timekeeping code, makes 32-bit and 64-bit behave
> the same way here, and gets us closer to removing the deprecated
> interfaces.

Applied to 4.18/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

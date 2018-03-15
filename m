Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbeCOEL5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 00:11:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53196 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbeCOEL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 00:11:56 -0400
To: lduncan@suse.com, cleech@redhat.com
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: iscsi_tcp: set BDI_CAP_STABLE_WRITES when data digest enabled
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1520425743-1923-1-git-send-email-jianchao.w.wang@oracle.com>
Date: Thu, 15 Mar 2018 00:11:45 -0400
In-Reply-To: <1520425743-1923-1-git-send-email-jianchao.w.wang@oracle.com>
        (Jianchao Wang's message of "Wed, 7 Mar 2018 20:29:03 +0800")
Message-ID: <yq137129dvi.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803150047
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> iscsi tcp will first send out data, then calculate and send data
> digest. If we don't have BDI_CAP_STABLE_WRITES, the page cache will
> be written in spite of the on going writeback. Consequently, wrong
> digest will be got and sent to target.
>
> To fix this, set BDI_CAP_STABLE_WRITES when data digest is enabled
> in iscsi_tcp .slave_configure callback.

Lee, Chris: Please review!

-- 
Martin K. Petersen	Oracle Linux Engineering

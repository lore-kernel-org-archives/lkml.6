Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbeCOELR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 00:11:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46866 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbeCOELP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 00:11:15 -0400
To: lduncan@suse.com, cleech@redhat.com
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: scsi_transport_iscsi: use put_device() instead of kfree()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <a77739e256b044c2e125e106165efc751ce4a0f6.1520422535.git.arvind.yadav.cs@gmail.com>
Date: Thu, 15 Mar 2018 00:11:02 -0400
In-Reply-To: <a77739e256b044c2e125e106165efc751ce4a0f6.1520422535.git.arvind.yadav.cs@gmail.com>
        (Arvind Yadav's message of "Wed, 7 Mar 2018 17:07:33 +0530")
Message-ID: <yq17eqe9dwp.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=579
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803150046
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Never directly free @dev after calling device_register(), even
> if it returned an error! Always use put_device() to give up the
> reference initialized.

Lee, Chris: Please review!

-- 
Martin K. Petersen	Oracle Linux Engineering

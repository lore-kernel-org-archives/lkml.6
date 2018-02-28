Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbeB1PTv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:19:51 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33918 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbeB1PTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:19:49 -0500
Subject: Re: [Xen-devel] [PATCH] xen-netfront: Fix hang on device removal
To: Jason Andryuk <jandryuk@gmail.com>, xen-devel@lists.xenproject.org,
        netdev@vger.kernel.org
Cc: Eduardo Otubo <otubo@redhat.com>, Juergen Gross <jgross@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180228122323.3914-1-jandryuk@gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <79cf073e-6b72-f139-46d3-79322d16209f@oracle.com>
Date: Wed, 28 Feb 2018 10:21:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228122323.3914-1-jandryuk@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8817 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280186
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/2018 07:23 AM, Jason Andryuk wrote:
> A toolstack may delete the vif frontend and backend xenstore entries
> while xen-netfront is in the removal code path.  In that case, the
> checks for xenbus_read_driver_state would return XenbusStateUnknown, and
> xennet_remove would hang indefinitely.  This hang prevents system
> shutdown.
>
> xennet_remove must be able to handle XenbusStateUnknown, and
> netback_changed must also wake up the wake_queue for that state as well.
>
> Fixes: 5b5971df3bc2 ("xen-netfront: remove warning when unloading module")
>
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> Cc: Eduardo Otubo <otubo@redhat.com>

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

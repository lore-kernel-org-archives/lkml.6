Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164555AbeCBDTQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 22:19:16 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55936 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163203AbeCBDTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 22:19:15 -0500
Subject: Re: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <fed4d1b1-6d55-b131-f0e1-ccb8262dea18@oracle.com>
Date: Fri, 2 Mar 2018 11:18:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228164726.GB16536@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=937
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803020034
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

Thanks for your kindly response and directive

On 03/01/2018 12:47 AM, Christoph Hellwig wrote:
> Note that we originally allocates irqs this way, and Keith changed
> it a while ago for good reasons.  So I'd really like to see good
> reasons for moving away from this, and some heuristics to figure
> out which way to use.  E.g. if the device supports more irqs than
> I/O queues your scheme might always be fine.

maybe we could add a logic that when get enough irq vectors, assign
separate irq vector to adminq, otherwise sharing.

Sincerely
Jianchao

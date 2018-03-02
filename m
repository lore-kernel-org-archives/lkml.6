Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164544AbeCBDLt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 22:11:49 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50492 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163412AbeCBDLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 22:11:47 -0500
Subject: Re: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
To: Keith Busch <keith.busch@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        axboe@fb.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de>
 <ddfc2ab4-1a51-c488-25e8-bc434edf8aba@grimberg.me>
 <66e4ad3e-4019-13ec-94c0-e168cc1d95b4@oracle.com>
 <20180301151544.GA17676@localhost.localdomain>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <b2ec4cb3-5125-3fce-4b6d-f483b75d0b2e@oracle.com>
Date: Fri, 2 Mar 2018 11:11:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301151544.GA17676@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=982
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803020032
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith

Thanks for your kindly directive and precious time for this.

On 03/01/2018 11:15 PM, Keith Busch wrote:
> On Thu, Mar 01, 2018 at 06:05:53PM +0800, jianchao.wang wrote:
>> When the adminq is free, ioq0 irq completion path has to invoke nvme_irq twice, one for itself,
>> one for adminq completion irq action.
> 
> Let's be a little more careful on the terminology when referring to spec
> defined features: there is no such thing as "ioq0". The IO queues start
> at 1. The admin queue is the '0' index queue.

Yes, indeed, sorry for my bad description.

>> We are trying to save every cpu cycle across the nvme host path, why we waste nvme_irq cycles here.
>> If we have enough vectors, we could allocate another irq vector for adminq to avoid this.
> 
> Please understand the _overwhelming_ majority of time spent for IRQ
> handling is the context switches. There's a reason you're not able to
> measure a perf difference between IOQ1 and IOQ2: the number of CPU cycles
> to chain a second action is negligible.
> 

Yes, indeed

Sincerely
Jianchao

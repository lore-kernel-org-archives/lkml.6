Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753412AbeDROZB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:25:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57822 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752659AbeDROZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:25:00 -0400
Subject: Re: PATCH V4 0/5 nvme-pci: fixes on nvme_timeout and nvme_dev_disable
To: Ming Lei <ming.lei@redhat.com>
Cc: axboe@fb.com, sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com, hch@lst.de
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180417151700.GC16286@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <a6e1de6d-6086-d467-d9ce-641bcd07b983@oracle.com>
Date: Wed, 18 Apr 2018 22:24:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417151700.GC16286@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8866 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=929
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804180131
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

On 04/17/2018 11:17 PM, Ming Lei wrote:
> Looks blktest(block/011) can trigger IO hang easily on NVMe PCI device,
> and all are related with nvme_dev_disable():
> 
> 1) admin queue may be disabled by nvme_dev_disable() from timeout path
> during resetting, then reset can't move on
> 
> 2) the nvme_dev_disable() called from nvme_reset_work() may cause double
> completion on timed-out request 
> 
> So could you share us what your plan is about this patchset?

Regarding to this patchset, it is mainly to fix the dependency between
nvme_timeout and nvme_dev_disable, as your can see:
nvme_timeout will invoke nvme_dev_disable, and nvme_dev_disable have to
depend on nvme_timeout when controller no response. Till now, some parts
of the patchset looks bad and seem to have a lot of work need to be done.
:)

Thanks
Jianchao

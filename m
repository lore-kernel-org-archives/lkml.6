Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933304AbeBMBvo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 20:51:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34968 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933102AbeBMBvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 20:51:43 -0500
Subject: Re: [PATCH] nvme-pci: drain the entered requests after ctrl is
 shutdown
To: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: axboe@fb.com, linux-nvme@lists.infradead.org, hch@lst.de,
        linux-kernel@vger.kernel.org
References: <1518440222-652-1-git-send-email-jianchao.w.wang@oracle.com>
 <b466996e-b00a-e848-25a0-e6ba768a573f@grimberg.me>
 <20180212191519.GD16255@localhost.localdomain>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <23035bb1-3548-34ba-4d38-3977b0bbbb8b@oracle.com>
Date: Tue, 13 Feb 2018 09:51:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180212191519.GD16255@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8803 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=989
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802130019
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith andn Sagi

Thanks for your kindly response and comment on this.

On 02/13/2018 03:15 AM, Keith Busch wrote:
> On Mon, Feb 12, 2018 at 08:43:58PM +0200, Sagi Grimberg wrote:
>>
>>> Currently, we will unquiesce the queues after the controller is
>>> shutdown to avoid residual requests to be stuck. In fact, we can
>>> do it more cleanly, just wait freeze and drain the queue in
>>> nvme_dev_disable and finally leave the queues quiesced.
>>
>> Does this fix a bug? What is the benefit of leaving the queues
>> quiesced in shutdown?
> 
> This doesn't appear to fix anything. The things this patch does do are
> either unnecessary (quiece), or already done elsewhere (wait freeze).
> 

Yes, this patch doesn't fix any bug. Since we will let the request to be drained
for shutdown case to avoid to be stuck, why not do it in nvme_dev_disable and 
then quiesce the queue again. In nvme_dev_disable, we unquiesce the queues finally,
it looks really something odd. And always give me a feeling that something is still
ongoing and not completed....It looks like something is leaking.... ;)

Why not we complete it in nvme_dev_disable ?

Thanks
Jianchao

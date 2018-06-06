Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D80E6086D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932560AbeFFJc1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:32:27 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40072 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932395AbeFFJcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:32:25 -0400
X-Google-Smtp-Source: ADUXVKJmQ6HMDLktpYsPGPsNZHaSwznj/BzfbPhwkQa/mIk/ps9yMdGuTTacg3kE4tDxo7T0udXLWg==
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
To: Christoph Hellwig <hch@lst.de>,
        Roland Dreier <roland@purestorage.com>
Cc: Mike Snitzer <snitzer@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>,
        Ewan Milne <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
 <CAL1RGDV0eT4juuMwHWkjqc2oTsk-CHRJ0A90veXxLsVZYa5esQ@mail.gmail.com>
 <20180605044222.GA29384@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4203e888-df87-efd6-f61a-24b43fb710e2@grimberg.me>
Date: Wed, 6 Jun 2018 12:32:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180605044222.GA29384@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> We plan to implement all the fancy NVMe standards like ANA, but it
>> seems that there is still a requirement to let the host side choose
>> policies about how to use paths (round-robin vs least queue depth for
>> example).  Even in the modern SCSI world with VPD pages and ALUA,
>> there are still knobs that are needed.  Maybe NVMe will be different
>> and we can find defaults that work in all cases but I have to admit
>> I'm skeptical...
> 
> The sensible thing to do in nvme is to use different paths for
> different queues.

Huh? different paths == different controllers so this sentence can't
be right... you mean that a path selector will select a controller
based on the home node of the local rdma device connecting to it and
the running cpu right?

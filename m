Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754286AbeEaJ1B (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:27:01 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36492 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754103AbeEaJ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:27:00 -0400
X-Google-Smtp-Source: ADUXVKKA9PR5z5s6TalDQV0gUDoSaV3skazC5TfX4Um9xQZr6WU4qzE50YjeF3aM4jzDwEM34yiDog==
Subject: Re: [PATCH 3/5] nvme: call nvmf_create_ctrl before checking for
 duplicate assignment
To: Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
References: <20180515074043.22843-1-jthumshirn@suse.de>
 <20180515074043.22843-4-jthumshirn@suse.de> <20180515075055.GB23659@lst.de>
 <20180515075221.4ppaxdvbosy36ltk@linux-x5ow.site>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1b2cdac6-4dbd-261b-0ae9-b9768f972f0d@grimberg.me>
Date: Thu, 31 May 2018 12:26:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515075221.4ppaxdvbosy36ltk@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> In general it seems like fc loop needs to offload any I/O to a workqueue
>> just like nvme-loop does, but even then I can't see how that is going to
>> cause an issue in this area.
> 
> Hmm I'll be looking into it.

FWIW, I agree it should do that as well.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbeFCLAn (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 07:00:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54010 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeFCLAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 07:00:41 -0400
X-Google-Smtp-Source: ADUXVKIX7GzpeExvL1TUuszIjU5hRsXnHCLTiRT8XjwP8OujgweOO2n0OV4/xHoMDnVCoqrWyFPVPQ==
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
To: Mike Snitzer <snitzer@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>, Ewan Milne <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>, axboe@kernel.dk
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
 <20180530220206.GA7037@redhat.com> <20180531163311.GA30954@lst.de>
 <20180531181757.GB11848@redhat.com> <yq17enjut3q.fsf@oracle.com>
 <20180601042441.GB14244@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0a0d4ff8-fe06-5869-cd18-a8c99b5e86f6@grimberg.me>
Date: Sun, 3 Jun 2018 14:00:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180601042441.GB14244@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm aware that most everything in multipath.conf is SCSI/FC specific.
> That isn't the point.  dm-multipath and multipathd are an existing
> framework for managing multipath storage.
> 
> It could be made to work with NVMe.  But yes it would not be easy.
> Especially not with the native NVMe multipath crew being so damn
> hostile.

The resistance is not a hostile act. Please try and keep the
discussion technical.

>> But I don't think the burden of allowing multipathd/DM to inject
>> themselves into the path transition state machine has any benefit
>> whatsoever to the user. It's only complicating things and therefore we'd
>> be doing people a disservice rather than a favor.
> 
> This notion that only native NVMe multipath can be successful is utter
> bullshit.  And the mere fact that I've gotten such a reaction from a
> select few speaks to some serious control issues.
> 
> Imagine if XFS developers just one day imposed that it is the _only_
> filesystem that can be used on persistent memory.
> 
> Just please dial it back.. seriously tiresome.

Mike, you make a fair point on multipath tools being more mature
compared to NVMe multipathing. But this is not the discussion at all (at
least not from my perspective). There was not a single use-case that
gave a clear-cut justification for a per-subsystem personality switch
(other than some far fetched imaginary scenarios). This is not unusual
for the kernel community not to accept things with little to no use,
especially when it involves exposing a userspace ABI.

As for now, all I see is a disclaimer saying that it'd need to be
nurtured over time as the NVMe spec evolves.

Can you (or others) please try and articulate why a "fine grained"
multipathing is an absolute must? At the moment, I just don't
understand.

Also, I get your point that exposing state/stats information to
userspace is needed. That's a fair comment.

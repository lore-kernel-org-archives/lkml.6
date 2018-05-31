Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbeEaIvl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 04:51:41 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52583 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754040AbeEaIvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 04:51:35 -0400
X-Google-Smtp-Source: ADUXVKJGdEMCYbV/evru1an+g+7mfWUiZ58kl+mtOtvt92IyGVpX/OLwYG0jugA/EajFTN2bC62pRQ==
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
To: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>, Ewan Milne <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
 <20180530224402.GA7303@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cab4ef4a-df7a-60c8-1f40-7a130aa3b15a@grimberg.me>
Date: Thu, 31 May 2018 11:51:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180530224402.GA7303@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Moreover, I also wanted to point out that fabrics array vendors are
>> building products that rely on standard nvme multipathing (and probably
>> multipathing over dispersed namespaces as well), and keeping a knob that
>> will keep nvme users with dm-multipath will probably not help them
>> educate their customers as well... So there is another angle to this.
> 
> Noticed I didn't respond directly to this aspect.  As I explained in
> various replies to this thread: The users/admins would be the ones who
> would decide to use dm-multipath.  It wouldn't be something that'd be
> imposed by default.  If anything, the all-or-nothing
> nvme_core.multipath=N would pose a much more serious concern for these
> array vendors that do have designs to specifically leverage native NVMe
> multipath.  Because if users were to get into the habit of setting that
> on the kernel commandline they'd literally _never_ be able to leverage
> native NVMe multipathing.
> 
> We can also add multipath.conf docs (man page, etc) that caution admins
> to consult their array vendors about whether using dm-multipath is to be
> avoided, etc.
> 
> Again, this is opt-in, so on a upstream Linux kernel level the default
> of enabling native NVMe multipath stands (provided CONFIG_NVME_MULTIPATH
> is configured).  Not seeing why there is so much angst and concern about
> offering this flexibility via opt-in but I'm also glad we're having this
> discussion to have our eyes wide open.

I think that the concern is valid and should not be dismissed. And
at times flexibility is a real source of pain, both to users and
developers.

The choice is there, no one is forbidden to use multipath. I'm just
still not sure exactly why the subsystem granularity is an absolute
must other than a volume exposed as a nvmf namespace and scsi lun (how
would dm-multipath detect this is the same device btw?)

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932179AbeE3TFv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:05:51 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44052 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753653AbeE3TFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:05:49 -0400
X-Google-Smtp-Source: ADUXVKKu06Tke0dAahx36T4OxaRz/Kc9x4L3V6T3bDY9NbGLCmINXazHTPPQ2IpcsXe8NS8Ievnk+A==
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
To: Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Laurence Oberman <loberman@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>, Ewan Milne <emilne@redhat.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>, dm-devel@redhat.com
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
 <20180525141211.GA25971@lst.de> <20180525145056.GD9591@redhat.com>
 <yq1muwj45sg.fsf@oracle.com> <20180529030236.GA28895@redhat.com>
 <20180529072240.np5c62akbr7jqelr@linux-x5ow.site>
 <20180529080952.GA1369@lst.de> <20180529232718.GA1730@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f4951571-d37d-73cd-1d6c-0ca84647d5ac@kernel.dk>
Date: Wed, 30 May 2018 13:05:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180529232718.GA1730@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/18 5:27 PM, Mike Snitzer wrote:
> On Tue, May 29 2018 at  4:09am -0400,
> Christoph Hellwig <hch@lst.de> wrote:
> 
>> On Tue, May 29, 2018 at 09:22:40AM +0200, Johannes Thumshirn wrote:
>>> For a "Plan B" we can still use the global knob that's already in
>>> place (even if this reminds me so much about scsi-mq which at least we
>>> haven't turned on in fear of performance regressions).
>>>
>>> Let's drop the discussion here, I don't think it leads to something
>>> else than flamewars.
>>
>> If our plan A doesn't work we can go back to these patches.  For now
>> I'd rather have everyone spend their time on making Plan A work then
>> preparing for contingencies.  Nothing prevents anyone from using these
>> patches already out there if they really want to, but I'd recommend
>> people are very careful about doing so as you'll lock yourself into
>> a long-term maintainance burden.
> 
> Restating (for others): this patchset really isn't about contingencies.
> It is about choice.
> 
> Since we're at an impasse, in the hopes of soliciting definitive
> feedback from Jens and Linus, I'm going to attempt to reset the
> discussion for their entry.
> 
> In summary, we have a classic example of a maintainer stalemate here:
> 1) Christoph, as NVMe co-maintainer, doesn't want to allow native NVMe
>    multipath to actively coexist with dm-multipath's NVMe support on the
>    same host.
> 2) I, as DM maintainer, would like to offer this flexibility to users --
>    by giving them opt-in choice to continue using existing dm-multipath
>    with NVMe. (also, both Red Hat and SUSE would like to offer this).
> 
> There is no technical reason why they cannot coexist.  Hence this simple
> patchset that was originally offered by Johannes Thumshirn with
> contributions from myself.

Here's what I think - flag days tend to suck. They may be more convenient
for developers, but they inflict pain on users. Sometimes they prevent
them from moving forward, since updates are now gated on external
dependencies. Moving forward with a new architecture is great, but
proper care has to be given to existing users of multipath, regardless
of how few they may be.

This patchset seems pretty clean and minimalist. Realistically, I'm
guessing that SUSE and RH will ship it regardless of upstream status.

-- 
Jens Axboe

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeFBIHh convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 04:07:37 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:58195 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeFBIHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 04:07:30 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Bart.VanAssche@wdc.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        jthumshirn@suse.de, alan.christopher.jenkins@gmail.com,
        syzbot+c4f9cebf9d651f6e54de@syzkaller.appspotmail.com,
        martin.petersen@oracle.com, dan.j.williams@intel.com, hch@lst.de,
        oleksandr@natalenko.name, hare@suse.com,
        syzkaller-bugs@googlegroups.com, ross.zwisler@linux.intel.com,
        keith.busch@intel.com, linux-ext4@vger.kernel.org
Subject: Re: INFO: task hung in blk_queue_enter
Date: Sat, 02 Jun 2018 10:07:26 +0200
Message-ID: <6992049.xPdnW5VfcJ@merkaba>
In-Reply-To: <20180602045353.GA20257@ming.t460p>
References: <CACT4Y+ZJwvROpBmKWF08fTd2AH=dO-a5+dzCzZua_vVFjiCRBw@mail.gmail.com> <f43465cf-e2f1-807f-d283-89033c056b5b@kernel.dk> <20180602045353.GA20257@ming.t460p>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ming Lei - 02.06.18, 06:54:
> On Fri, Jun 01, 2018 at 10:31:13PM -0600, Jens Axboe wrote:
> > On 6/1/18 8:36 PM, Ming Lei wrote:
> > >> clear the bit when we need to, potentially even adding a debug
> > >> check to blk_queue_enter_live() that complains if the ref was
> > >> not already elevated. Though that would be expensive, compared
> > >> to the percpu inc now. Not saying the bit is necessarily the
> > >> best way forward, but I do like it a LOT more than adding an
> > >> argument to generic_make_request.> > 
> > > We may introduce generic_make_request_with_ref() for
> > > blk_queue_split(), what do you think of the following patch?
> > 
> > Functionally it'll work as well.
> 
> If you are fine with this one, I'm glad to prepare for a normal one,
> so that we can save one precious bio flag, and the total number is
> just 13.
[…]

I am completely lost about what you are talking about.

That is fine with me, but in case there is anything to test… let me 
know. I do not promise quick responses tough, as I have been quite a bit 
overwhelmed with stuff lately.

Currently I run 4.17-rc7 without any blk-mq related patches and it 
appears to be free of hangs or stalls related to blk-mq.

Thanks,
-- 
Martin

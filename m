Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbeFDLqx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:46:53 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:36516 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752706AbeFDLqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:46:51 -0400
X-Google-Smtp-Source: ADUXVKIeczZtxqzqiSAEL+bBNbL06tcfit5e4RZHxxTvQ3KD8s77Zw9RfnJq04m5DUUOdt8jqTS0Gg==
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
To: Mike Snitzer <snitzer@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
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
 <0a0d4ff8-fe06-5869-cd18-a8c99b5e86f6@grimberg.me>
 <20180603160626.GA4361@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <29bfbc6c-861d-0348-2f8b-e803acad43ea@grimberg.me>
Date: Mon, 4 Jun 2018 14:46:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180603160626.GA4361@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[so much for putting out flames... :/]

> This projecting onto me that I've not been keeping the conversation
> technical is in itself hostile.  Sure I get frustrated and lash out (as
> I'm _sure_ you'll feel in this reply)

You're right, I do feel this is lashing out. And I don't appreciate it.
Please stop it. We're not going to make progress otherwise.

>> Can you (or others) please try and articulate why a "fine grained"
>> multipathing is an absolute must? At the moment, I just don't
>> understand.
> 
> Already made the point multiple times in this thread [3][4][5][1].
> Hint: it is about the users who have long-standing expertise and
> automation built around dm-multipath and multipath-tools.  BUT those
> same users may need/want to simultaneously use native NVMe multipath on
> the same host.  Dismissing this point or acting like I haven't
> articulated it just illustrates to me continuing this conversation is
> not going to be fruitful.

The vast majority of the points are about the fact that people still
need to be able to use multipath-tools, which they still can today.
Personally, I question the existence of this user base you are referring
to which would want to maintain both dm-multipath and nvme personalities 
at the same time on the same host. But I do want us to make progress, so
I will have take this need as a given.

I agree with Christoph that changing personality on the fly is going to
be painful. This opt-in will need to be one-host at connect time. For
that, we will probably need to also expose an argument in nvme-cli too.
Changing the mpath personality will need to involve disconnecting the
controller and connecting again with the argument toggled. I think this
is the only sane way to do this.

Another path we can make progress in is user visibility. We have
topology in place and you mentioned primary path (which we could
probably add). What else do you need for multipath-tools to support
nvme?

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754179AbeD3NtU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 09:49:20 -0400
Received: from sandeen.net ([63.231.237.45]:57564 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753119AbeD3NtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 09:49:16 -0400
Subject: Re: WARNING: bad unlock balance in xfs_iunlock
To: Dmitry Vyukov <dvyukov@google.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        syzbot <syzbot+84a67953651a971809ba@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-xfs@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>
References: <f403043cbe8414177d0568e81405@google.com>
 <20180403043854.GL1150@dastard>
 <CACT4Y+ZadV0xTqhiGTAHmadAnYaSfPKhUy_TFXMza2o_n8+o9w@mail.gmail.com>
 <20180405213844.GE23861@dastard> <20180406161053.GF7500@magnolia>
 <CACT4Y+aaEOffkFA-B-hMzwzSiQwVpkPrc2udC087a55OTnkS4g@mail.gmail.com>
 <95c1400b-94f2-1af4-2d5d-c61c274c28ff@sandeen.net>
 <CACT4Y+aiwgRg5pk+N7bq9HYpgumTFyqG6-y3EZ8pWkq9-uB1aA@mail.gmail.com>
From: Eric Sandeen <sandeen@sandeen.net>
Openpgp: preference=signencrypt
Autocrypt: addr=sandeen@sandeen.net; prefer-encrypt=mutual; keydata=
 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 pA==
Message-ID: <9f8d657c-7f42-7bd9-4477-6c3addf16dee@sandeen.net>
Date: Mon, 30 Apr 2018 08:49:15 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aiwgRg5pk+N7bq9HYpgumTFyqG6-y3EZ8pWkq9-uB1aA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/18 8:23 AM, Dmitry Vyukov wrote:
> On Mon, Apr 16, 2018 at 9:22 PM, Eric Sandeen <sandeen@sandeen.net> wrote:

...

>> It sure /seems/ to have a notion of images: what else is syz_mount_image()?
>>
>> i.e. you are mounting an image to reproduce the problem, correct?
>> And the system is "smart" enough to fire off an email to a filesystem list;
>> if it does so, add a link to the image itself, as you already have already done
>> for the C reproducer.
>>
>> Filesystem images are common parlance for filesystem engineers.  When
>> you engage with them you'll have better results if you  provide them with
>> inputs they can use directly instead of requiring them to reverse-engineer
>> your custom test harness.
> 
> 
> Well, yes and no.
> syz_mount_image() is the only part of a large system that knows about
> images. For the rest of the system it's just a syscall like any other
> syscall. And the part that sends emails is far away from
> syz_mount_image().
> syzbot does not know per se that it sends an email to filesystems
> list.

I am asking it to learn this trick as an enhancement.  The MAINTAINERS
file contains big clues about which subsystems are filesystems, for example:

$ grep FILESYSTEM$ MAINTAINERS 
AFS FILESYSTEM
CRAMFS FILESYSTEM
EFI VARIABLE FILESYSTEM
EFS FILESYSTEM
FREEVXFS FILESYSTEM
...

> It just extracted kernel source file name that looked relevant
> to this crash and run get_maintainers.pl on it.
> Also the image can contain dynamically generated data, which makes it
> impossible to have as a file at all.

I guess I'm not sure what this means, can you explain?

> Thinking of this, what should be reasonably easy to do and may be a
> compromise for near future is the following. We could insert code into
> syz_mount_image() which dump the image if you build a program with a
> special define (e.g. -DSYZ_DUMP_IMAGE). Will this work for you?

If this is possible, I guess I still don't understand why you can't dump the
image and provide link.  You have fast, efficient robots.  We have slow,
busy humans.

>>> Please elaborate re commits. It's a basic rule of any good bug report
>>> -- communicate exact state of source code when the bug was hit, i.e.
>>> provide the commit hash.
>>
>> Further best practice is to provide the /correct/ commit hash.

....

>> I can't imagine these are right...
> 
> 
> As I said, bisection is on our plate:
> https://github.com/google/syzkaller/issues/501
> Though, we will see how well it works, because it's not trivial (see
> the issue for details).

Oh I see. I had misunderstood; so:

> syzbot hit the following crash on upstream commit
> 86bbbebac1933e6e95e8234c4f7d220c5ddd38bc (Mon Apr 2 18:47:07 2018 +0000)
> Merge branch 'ras-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

doesn't mean you bisected to that commit, or that this was the first bad commit,
it just means you happened to have a tree at this commit when you hit the problem.

That was not at all clear to me.  I thought when syzkaller was telling us
"on upstream commit XYZ," it meant that it had identified commit XYZ as bad.
I'm not sure if anyone else made that mistake, but  perhaps you could also clarify
the bug report text in this regard?

...

>> I think that in this case, what we are asking for is a fine tuning of the
>> testing and reporting so that we can more efficiently address these issues.
>> Off the top of my head, and there may be more items:
>>
>> 1) Add a human contact to the emails, start an IRC channel, etc, for better
>>    two-way communication.  (it wasn't clear that syzkaller@ reached humans,
>>    tbh.)
> 
> There is a human contact at syzkaller@googlegroups.com. Report footer
> will be improved to make it more clear:
> https://github.com/google/syzkaller/issues/565#issuecomment-380793620
> 
>> 2) _Properly_ identify the regressing commit, if any.  If it doesn't look like
>>    a recent regression, you can state that too.
> 
> Bisection is on our plate.
> 
>> 3) If you're reporting a filesystem bug that arose from using a filesystem
>>    image, provide a URL to that filesystem image directly in the report.
> 
> See above. It may not be necessary representable as a static file at all.

Can you explain this?  Do you mean that the mounted image is changing while the
tool runs, while the filesystem is mounted?
 
>> 4) Create a filesystem image that can be more easily debugged by the experts,
>>    i.e. one with > 1 allocation group, so standard repair & analysis tools can
>>    be used with it.
> 
> What is "> 1 allocation group"?

Maybe I should back up; how are the xfs images created?  I had assumed that
surely you start with a base image of some sort, and start fuzzing it from there.
Is this correct?

If so, allocation groups are a fundamental geometry of the filesystem; from
man mkfs.xfs.8:

                   agcount=value
                          This is used to specify  the  number  of  allocation
                          groups.  The  data  section  of  the  filesystem  is
                          divided into allocation groups to improve  the  per‐
                          formance  of  XFS. More allocation groups imply that
                          more parallelism can  be  achieved  when  allocating
                          blocks and inodes. The minimum allocation group size
                          is 16 MiB; the maximum size is  just  under  1  TiB.
                          The  data  section of the filesystem is divided into
                          value allocation groups  (default  value  is  scaled
                          automatically based on the underlying device size).

If the base image only has one allocation group, it makes it more difficult for
some tools to work with the image, because there is no redundancy.  1 AG is
not a supported or recommended geometry for any real-life use of xfs.

If I am correct that you start with a base image w/ a certain geometry or
set of mkfs options, starting with >= 2 AGs would improve the usefulness of the
filesystem image.

Thanks,
-Eric

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753409AbeDPTWI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 15:22:08 -0400
Received: from sandeen.net ([63.231.237.45]:45752 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753233AbeDPTWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 15:22:05 -0400
Subject: Re: WARNING: bad unlock balance in xfs_iunlock
To: Dmitry Vyukov <dvyukov@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>,
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
From: Eric Sandeen <sandeen@sandeen.net>
Openpgp: preference=signencrypt
Autocrypt: addr=sandeen@sandeen.net; prefer-encrypt=mutual; keydata=
 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 pA==
Message-ID: <95c1400b-94f2-1af4-2d5d-c61c274c28ff@sandeen.net>
Date: Mon, 16 Apr 2018 14:22:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aaEOffkFA-B-hMzwzSiQwVpkPrc2udC087a55OTnkS4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/18 5:03 AM, Dmitry Vyukov wrote:
> On Fri, Apr 6, 2018 at 6:10 PM, Darrick J. Wong <darrick.wong@oracle.com> wrote:
>> On Fri, Apr 06, 2018 at 07:38:44AM +1000, Dave Chinner wrote:
>>> On Thu, Apr 05, 2018 at 08:54:50PM +0200, Dmitry Vyukov wrote:
>>>> On Tue, Apr 3, 2018 at 6:38 AM, Dave Chinner <david@fromorbit.com> wrote:
>>>>> On Mon, Apr 02, 2018 at 07:01:02PM -0700, syzbot wrote:
>>>>>> Hello,
>>>>>>
>>>>>> syzbot hit the following crash on upstream commit
>>>>>> 86bbbebac1933e6e95e8234c4f7d220c5ddd38bc (Mon Apr 2 18:47:07 2018 +0000)
>>>>>> Merge branch 'ras-core-for-linus' of
>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>>>> syzbot dashboard link:
>>>>>> https://syzkaller.appspot.com/bug?extid=84a67953651a971809ba
>>>>>>
>>>>>> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5719304272084992
>>>>>> syzkaller reproducer:
>>>>>> https://syzkaller.appspot.com/x/repro.syz?id=5767783983874048
>>>>>
>>>>> What a mess. A hand built, hopelessly broken filesystem image made
>>>>> up of hex dumps, written into a mmap()d region of memory, then
>>>>> copied into a tmpfs file and mounted with the loop device.
>>>>>
>>>>> Engineers that can debug broken filesystems don't grow on trees.  If
>>>>> we are to have any hope of understanding what the hell this test is
>>>>> doing, the bot needs to supply us with a copy of the built
>>>>> filesystem image the test uses. We need to be able to point forensic
>>>>> tools at the image to decode all the structures into human readable
>>>>> format - if we are forced to do that by hand or jump through hoops
>>>>> to create our own filesystem image than I'm certainly not going to
>>>>> waste time looking at these reports...
>>>>
>>>> Hi Dave,
>>>>
>>>> Here is the image:
>>>> https://drive.google.com/file/d/1jzhGGe5SBJcqfsjxCLHoh4Kazke1oTfC/view
>>>> (took me about a minute to extract from test by replacing memfd_create
>>>> with open and running the program).
>>>
>>> Says the expert who knows exactly how it's all put together. It took
>>> me a couple of hours just to understand WTF the syzbot reproducer
>>> was actually doing....

*nod* more on this below.

>>>> Then do the following to trigger the bug:
>>>> losetup /dev/loop0 xfs.repro
>>>> mkdir xfs
>>>> mount -t xfs -o nouuid,prjquota,noikeep,quota /dev/loop0 xfs
>>>>
>>>> To answer your more general question: syzbot is not a system to test
>>>> solely file systems, it finds bugs in hundreds of kernel subsystems.
>>>> Generating image for file systems, media files for sound and
>>>> FaceDancer programs that crash host when  FaceDancer device is plugged
>>>> into USB is not feasible. And in the end it's not even clear what
>>>
>>> I don't care how syzbot generates the filesystem image it uses.
>>>
>>>> kernel subsystem is at fault and even if it somehow figures out that
>>>> it's a filesystem, it's unclear that it's exactly an image that
>>>> provokes the bug. syzbot provides C reproducers which is a reasonable
>>>
>>> It doesn't matter *what subsystem breaks*. If syzbot is generating a
>>> filesystem image and then mounting it, it needs to provide that
>>> filesystem image to to people who end up having to debug the
>>> problem. It's a basic "corrupt filesystem" bug triage step.

*nod*

>>>> Some bugs are so involved that only an
>>>> expert in a particular subsystem can figure out what happens there.
>>>
>>> And that's clearly the case here, whether you like it or not.
>>>
>>> You want us to do things that make syzbot more useful as a tool but
>>> you don't want to do things that make syzbot a useful tool for us.
>>> It's a two way street....
> 
> Hi Dave, Darrick,
> 
> It's not that we don't want to make the system more useful, it's just
> that we don't see what reasonably can be done here. The system does
> not have notion of images, sound files, USB devices. It feeds data
> into system calls, and that's what it provides as reproducers. Also
> see the last paragraph.

It sure /seems/ to have a notion of images: what else is syz_mount_image()?

i.e. you are mounting an image to reproduce the problem, correct?
And the system is "smart" enough to fire off an email to a filesystem list;
if it does so, add a link to the image itself, as you already have already done
for the C reproducer.

Filesystem images are common parlance for filesystem engineers.  When
you engage with them you'll have better results if you  provide them with
inputs they can use directly instead of requiring them to reverse-engineer
your custom test harness.

>> ...here's my take on this whole situation:
>>
>> So far as I can tell, this syzbot daemon grew the ability to fuzz
>> filesystems and started emitting bug report after bug report, with
>> misleading commit ids that have nothing to do with the complaint.
> 
> Please elaborate re commits. It's a basic rule of any good bug report
> -- communicate exact state of source code when the bug was hit, i.e.
> provide the commit hash.

Further best practice is to provide the /correct/ commit hash.

syzbot has identified commits which seem almost certainly incorrect.

For example,

KASAN: use-after-free Read in radix_tree_next_chunk

identified:

9dd2326890d89a5179967c947dab2bab34d7ddee (Fri Mar 30 17:29:47 2018 +0000)
Merge tag 'ceph-for-4.16-rc8' of git://github.com/ceph/ceph-client

and:

WARNING: bad unlock balance in xfs_iunlock

identified:

86bbbebac1933e6e95e8234c4f7d220c5ddd38bc (Mon Apr 2 18:47:07 2018 +0000)
Merge branch 'ras-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

I can't imagine these are right...

>>  Your
>> maintainers (Dave, Eric, and me) have spent a few hours trying to figure
>> out what's going on, to some frustration.  The bug reports themselves
>> miss the public engagement detail of saying something like "Hey XFS
>> engineers, if you'd like to talk to the syzbot engineers they can be
>> reached at <googlegroup address>."  Instead it merely says "direct
>> questions to <addr>" like this is some press release and the only thing
>> on the other end of the line will be some disinterested bureaucracy.
>> Or some robot.
> 
> This is quite subjective and we hear opinions all possible ways. I
> don't think there is one size fits all. E.g. +Ted argued in exactly
> the opposite direction: make reports more laconic, formal,
> table-formatted with dry information. There is also a tradeoff between
> describing each detail in proper, friendly English and being more
> laconic. If we increase everything 4x and post a wall of text with
> each report, lots of people won't read anything of it just because
> it's a wall of text. I am also not a native English speaker, so
> providing simple formal text is a safer option than writing something
> potentially clumsy.

What Darrick is asking for, I think, is a human on the other end to talk
to if there are any issues or concerns about the reports.  (For example,
"hey that commit looks wrong, are you sure?)  We are not asking for a
long narrative with each report.  We're asking for a dialogue about this
framework and the reporting, so it can improve.

> Having said that, I am collecting proposals for report format
> improvements. Here is fortunately slightly better wording for footer
> based on your idea:
> https://github.com/google/syzkaller/issues/565#issuecomment-380793620

...

> Well, I guess nobody has infinite engineering resources. If we would
> have them we would also fix all these bug ourselves and don't bother
> you at all. Just as any other company could invest in writing bug
> detection tools, fuzzers, deploy them and report bugs, which would
> relief us from this.
> We have limited resources and do what's possible within these
> resources. Unfortunately providing individual handling of each of the
> thousands of bugs is not possible within these resources. I know that
> what we are doing is useful for kernel overall because lots of
> hundreds of bugs get fixed due to this effort. If you, as xfs
> maintainers, think that these reports are net negative for xfs and xfs
> should not be tested, say so and we will figure out how to make it
> happen.

We've been inundated lately with results of scripts which generate bug reports
quickly but do not provide enough information to quickly triage, reproduce, and
fix those reports.

(For example, another fuzzer is using the same "poc.c" to exercise a fuzzed
image; it might be the 1st operation or the 50th that causes the issue, but
the harness doesn't bother to find out or report it, it just sends all 50
potential operations to us, and assumes we'll take the time to figure it out.
It's laziness on the script/reporting side, resulting in extra work on the
human/debugging side.)

I think that in this case, what we are asking for is a fine tuning of the
testing and reporting so that we can more efficiently address these issues.
Off the top of my head, and there may be more items:

1) Add a human contact to the emails, start an IRC channel, etc, for better
   two-way communication.  (it wasn't clear that syzkaller@ reached humans,
   tbh.)
2) _Properly_ identify the regressing commit, if any.  If it doesn't look like
   a recent regression, you can state that too.
3) If you're reporting a filesystem bug that arose from using a filesystem
   image, provide a URL to that filesystem image directly in the report.
4) Create a filesystem image that can be more easily debugged by the experts,
   i.e. one with > 1 allocation group, so standard repair & analysis tools can
   be used with it.

Hopefully this sort of feedback will result in better bug reports from you,
and faster (and more) bugfixes from us.

Personally, I'm certainly not asking you to stop sending reports of bugs you
find, but I /am/ asking that they be as refined, specific, and useful as possible.

Thanks,
-Eric

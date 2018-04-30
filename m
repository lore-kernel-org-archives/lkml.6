Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754559AbeD3POb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:14:31 -0400
Received: from sandeen.net ([63.231.237.45]:34686 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754363AbeD3PO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:14:29 -0400
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
 <9f8d657c-7f42-7bd9-4477-6c3addf16dee@sandeen.net>
 <CACT4Y+bUx4jw83Ux7w9URL9bCy1ERLaVGTTwvA9Fe_UtLFeqCw@mail.gmail.com>
From: Eric Sandeen <sandeen@sandeen.net>
Openpgp: preference=signencrypt
Autocrypt: addr=sandeen@sandeen.net; prefer-encrypt=mutual; keydata=
 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 pA==
Message-ID: <d7c8e0eb-61ed-1aad-6faa-82a0ef8c25b8@sandeen.net>
Date: Mon, 30 Apr 2018 10:14:28 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bUx4jw83Ux7w9URL9bCy1ERLaVGTTwvA9Fe_UtLFeqCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/18 9:02 AM, Dmitry Vyukov wrote:
> On Mon, Apr 30, 2018 at 3:49 PM, Eric Sandeen <sandeen@sandeen.net> wrote:

...

>>> It just extracted kernel source file name that looked relevant
>>> to this crash and run get_maintainers.pl on it.
>>> Also the image can contain dynamically generated data, which makes it
>>> impossible to have as a file at all.
>>
>> I guess I'm not sure what this means, can you explain?
> 
> Say, a value that we generally pass to close system call is not static
> and can't be dumped to a static file. It's whatever a previous open
> system call has returned. Inside of the program we memorize the return
> value of open in a variable and then pass it to close. This generally
> stands for all system calls. Say, an image can contain an uid, and
> that uid can be obtained from a system call too.

Ok, but that's the syscall side.  You are operating on a static xfs image,
correct?  We're only asking for the actual filesystem you're operating
against.

(When I say "image" I am talking only about the filesystem itself, not any
other syzkaller state)
 
...

>> That was not at all clear to me.  I thought when syzkaller was telling us
>> "on upstream commit XYZ," it meant that it had identified commit XYZ as bad.
>> I'm not sure if anyone else made that mistake, but  perhaps you could also clarify
>> the bug report text in this regard?
> 
> Suggestions are welcome. Currently it says "syzbot hit the following
> crash on upstream commit SHA1", which was supposed to mean just the
> state of the source tree when the crash happened. But I am not a
> native speaker, so perhaps I am saying not what I intend to say.
> 
> There are also suggestions on report format improvement from +Ted
> currently in works:
> https://github.com/google/syzkaller/issues/565#issuecomment-380792942
> Not sure if they make this distinction 100% clear, though.

Maybe I was the only one who misunderstood, but something like

git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
HEAD:		f5c754d63d06 mm/swap_state.c: make bool enable_vma_readahead and swap_vma_readahead()
 
to make it clear that it has not identified that commit as the culprit, it's
just the head of the tree you were testing?  (I think I have the correct git
nomenclature ...)

...

>> If the base image only has one allocation group, it makes it more difficult for
>> some tools to work with the image, because there is no redundancy.  1 AG is
>> not a supported or recommended geometry for any real-life use of xfs.
>>
>> If I am correct that you start with a base image w/ a certain geometry or
>> set of mkfs options, starting with >= 2 AGs would improve the usefulness of the
>> filesystem image.
> 
> syzkaller can generate/mutate images based on structured format
> templates, but for now we don't have any templates and these are just
> opaque blobs.

Ok, backing up more: When you are testing against an xfs filesystem image, where
does that image come from?  How is it generated?  A quick look at the syzkaller
tree didn't make that clear to me.

the xfs.repro file you provided at
https://drive.google.com/file/d/1jzhGGe5SBJcqfsjxCLHoh4Kazke1oTfC/view

is strange, it doesn't even contain AGF blocks; they aren't fuzzed or corrupted,
they are completely zeroed out.  I don't know if that's part of the fuzzing,
or what - what steps led to that image?

Or put another way, how did you arrive at the fs image values in the reproducer,
i.e.:

oid loop()
{
  memcpy((void*)0x20000000, "xfs", 4);
  memcpy((void*)0x20000100, "./file0", 8);
  *(uint64_t*)0x20000200 = 0x20010000;
  memcpy((void*)0x20010000,
         "\x58\x46\x53\x42\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x10\x00\x00"
         "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9f\x98"
         "\x99\xff\xcb\xa1\x4e\xe6\xad\x52\x08\x20\x67\x09\xed\x75\x00\x00\x00"
         "\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x35\xe0\x00\x00\x00\x00"
         "\x00\x00\x35\xe1\x00\x00\x00\x00\x00\x00\x35\xe2\x00\x00\x00\x01\x00"
         "\x00\x10\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x03\x55\xb4\xa4"
         "\x02\x00\x01\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
         "\x00\x0c\x09\x08\x04\x0c\x00\x00\x19\x00\x00\x00\x00\x00\x00\x00\x40"
         "\x00\x00\x00\x00\x00\x00\x00\x3d\x00\x00\x00\x00\x00\x00\x0c\xa3\x00"
         "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
         "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00"
         "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x02\x02",
         204);

... 

The in-memory xfs filesystem it constructs is damaged, is that an intentional
part of the fuzzing during the test?

-Eric

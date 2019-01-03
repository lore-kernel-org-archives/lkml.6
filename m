Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B954BC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FEF20833
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfACB7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 20:59:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:46764 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726071AbfACB7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 20:59:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BEE51AF4D;
        Thu,  3 Jan 2019 01:59:43 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        syzbot <syzbot+239d99847eb49ecb3899@syzkaller.appspotmail.com>,
        bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Date:   Thu, 03 Jan 2019 12:59:34 +1100
Subject: Re: KASAN: use-after-free Read in posix_lock_inode
In-Reply-To: <8d7fe24b342147349b820742bbcd3ab07864a2d7.camel@kernel.org>
References: <000000000000a415f5057e772463@google.com> <1baebb04848c3f7f429235f1f1608f61c3e2438e.camel@kernel.org> <87pnteli87.fsf@notabene.neil.brown.name> <8d7fe24b342147349b820742bbcd3ab07864a2d7.camel@kernel.org>
Message-ID: <87muoilcvt.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02 2019, Jeff Layton wrote:

> On Thu, 2019-01-03 at 11:04 +1100, NeilBrown wrote:
>> On Wed, Jan 02 2019, Jeff Layton wrote:
>>=20
>> > On Wed, 2019-01-02 at 02:31 -0800, syzbot wrote:
>> > > Hello,
>> > >=20
>> > > syzbot found the following crash on:
>> > >=20
>> > > HEAD commit:    e1ef035d272e Merge tag 'armsoc-defconfig' of git://g=
it.ker..
>> > > git tree:       upstream
>> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D16bb4c4b=
400000
>> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9c6a26e2=
2579190b
>> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D239d99847e=
b49ecb3899
>> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D128aa3=
77400000
>> > >=20
>> > > IMPORTANT: if you fix the bug, please add the following tag to the c=
ommit:
>> > > Reported-by: syzbot+239d99847eb49ecb3899@syzkaller.appspotmail.com
>> > >=20
>> > > IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
>> > > IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
>> > > 8021q: adding VLAN 0 to HW filter on device batadv0
>> > > 8021q: adding VLAN 0 to HW filter on device batadv0
>> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > > BUG: KASAN: use-after-free in what_owner_is_waiting_for fs/locks.c:1=
000=20=20
>> > > [inline]
>> > > BUG: KASAN: use-after-free in posix_locks_deadlock fs/locks.c:1023 [=
inline]
>> > > BUG: KASAN: use-after-free in posix_lock_inode+0x1f9e/0x2750 fs/lock=
s.c:1163
>> > > Read of size 8 at addr ffff88808791b000 by task syz-executor2/10100
>> > >=20
>> > > CPU: 1 PID: 10100 Comm: syz-executor2 Not tainted 4.20.0+ #3
>> > > Hardware name: Google Google Compute Engine/Google Compute Engine, B=
IOS=20=20
>> > > Google 01/01/2011
>> > > Call Trace:
>> > >   __dump_stack lib/dump_stack.c:77 [inline]
>> > >   dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
>> > >   print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
>> > >   kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
>> > >   __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
>> > >   what_owner_is_waiting_for fs/locks.c:1000 [inline]
>> > >   posix_locks_deadlock fs/locks.c:1023 [inline]
>> > >   posix_lock_inode+0x1f9e/0x2750 fs/locks.c:1163
>> > >   posix_lock_file fs/locks.c:1346 [inline]
>> > >   vfs_lock_file fs/locks.c:2314 [inline]
>> > >   vfs_lock_file+0xc7/0xf0 fs/locks.c:2309
>> > >   do_lock_file_wait.part.0+0xe5/0x260 fs/locks.c:2328
>> > >   do_lock_file_wait fs/locks.c:2324 [inline]
>> > >   fcntl_setlk+0x2f1/0xfe0 fs/locks.c:2413
>> > >   do_fcntl+0x843/0x12b0 fs/fcntl.c:370
>> > >   __do_sys_fcntl fs/fcntl.c:463 [inline]
>> > >   __se_sys_fcntl fs/fcntl.c:448 [inline]
>> > >   __x64_sys_fcntl+0x16d/0x1e0 fs/fcntl.c:448
>> > >   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
>> > >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> > > RIP: 0033:0x457ec9
>> > > Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48=
 89 f7=20=20
>> > > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 =
f0 ff=20=20
>> > > ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>> > > RSP: 002b:00007f58bbb50c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000=
48
>> > > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
>> > > RDX: 0000000020000140 RSI: 0000000000000007 RDI: 0000000000000003
>> > > RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
>> > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f58bbb516d4
>> > > R13: 00000000004be5f0 R14: 00000000004ceab0 R15: 00000000ffffffff
>> > >=20
>> > > Allocated by task 10100:
>> > >   save_stack+0x45/0xd0 mm/kasan/common.c:73
>> > >   set_track mm/kasan/common.c:85 [inline]
>> > >   kasan_kmalloc mm/kasan/common.c:482 [inline]
>> > >   kasan_kmalloc+0xcf/0xe0 mm/kasan/common.c:455
>> > >   kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:397
>> > >   kmem_cache_alloc+0x12d/0x710 mm/slab.c:3541
>> > >   kmem_cache_zalloc include/linux/slab.h:730 [inline]
>> > >   locks_alloc_lock+0x8e/0x2f0 fs/locks.c:344
>> > >   fcntl_setlk+0xa9/0xfe0 fs/locks.c:2362
>> > >   do_fcntl+0x843/0x12b0 fs/fcntl.c:370
>> > >   __do_sys_fcntl fs/fcntl.c:463 [inline]
>> > >   __se_sys_fcntl fs/fcntl.c:448 [inline]
>> > >   __x64_sys_fcntl+0x16d/0x1e0 fs/fcntl.c:448
>> > >   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
>> > >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> > >=20
>> > > Freed by task 10100:
>> > >   save_stack+0x45/0xd0 mm/kasan/common.c:73
>> > >   set_track mm/kasan/common.c:85 [inline]
>> > >   __kasan_slab_free+0x102/0x150 mm/kasan/common.c:444
>> > >   kasan_slab_free+0xe/0x10 mm/kasan/common.c:452
>> > >   __cache_free mm/slab.c:3485 [inline]
>> > >   kmem_cache_free+0x86/0x260 mm/slab.c:3747
>> > >   locks_free_lock+0x27a/0x3f0 fs/locks.c:381
>> > >   fcntl_setlk+0x7b5/0xfe0 fs/locks.c:2439
>> > >   do_fcntl+0x843/0x12b0 fs/fcntl.c:370
>> > >   __do_sys_fcntl fs/fcntl.c:463 [inline]
>> > >   __se_sys_fcntl fs/fcntl.c:448 [inline]
>> > >   __x64_sys_fcntl+0x16d/0x1e0 fs/fcntl.c:448
>> > >   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
>> > >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> > >=20
>> > > The buggy address belongs to the object at ffff88808791b000
>> > >   which belongs to the cache file_lock_cache of size 264
>> > > The buggy address is located 0 bytes inside of
>> > >   264-byte region [ffff88808791b000, ffff88808791b108)
>> > > The buggy address belongs to the page:
>> > > page:ffffea00021e46c0 count:1 mapcount:0 mapping:ffff8880aa16a1c0 in=
dex:0x0
>> > > flags: 0x1fffc0000000200(slab)
>> > > raw: 01fffc0000000200 ffffea0002333508 ffffea00021d76c8 ffff8880aa16=
a1c0
>> > > raw: 0000000000000000 ffff88808791b000 000000010000000c 000000000000=
0000
>> > > page dumped because: kasan: bad access detected
>> > >=20
>> > > Memory state around the buggy address:
>> > >   ffff88808791af00: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
>> > >   ffff88808791af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> > > > ffff88808791b000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> > >                     ^
>> > >   ffff88808791b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> > >   ffff88808791b100: fb fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb
>> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > >=20
>> > >=20
>> > >=20
>> >=20
>> > The interesting bit is that the crash, alloc and free all seem to have
>> > occurred in the same kernel task (PID 10100).
>> >=20
>> > Here's the loop in what_owner_is_waiting_for():
>> >=20
>> > ----------------8<------------------
>> >         hash_for_each_possible(blocked_hash, fl, fl_link, posix_owner_=
key(block_fl)) {
>> >                 if (posix_same_owner(fl, block_fl)) {=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>> >                         while (fl->fl_blocker)            <<<<<< CRASH=
 HERE=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20
>> >                                 fl =3D fl->fl_blocker;=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>> >                         return fl;=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20
>> >                 }=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>> >         }=20=20=20=20=20=20=20=20
>> > ----------------8<------------------
>> >=20
>> > So fl got freed while we were walking down the chain of blocked locks.
>> > At a quick glance, I'm now wondering whether the lockless optimization
>> > to avoid the blocked_lock_lock in locks_delete_block is actually ok.
>> >=20
>> > Neil, any thoughts?
>>=20
>> The repro didn't trigger for me, but code inspection suggested I should
>> invest in brown paper bags.
>>=20
>> Note that while this patch clearly fixes a bug, and I suspect it is
>> the cause of this report, I cannot confirm with testing as I cannot
>> trigger the bug.  I enabled KASAN and ran "qemu -smp 4" to no avail.
>>=20
>> Thanks,
>> NeilBrown
>>=20
>> From: NeilBrown <neilb@suse.com>
>> Date: Thu, 3 Jan 2019 10:59:50 +1100
>> Subject: [PATCH] locks: fix error in locks_move_blocks()
>>=20
>> After moving all requests from
>>    fl->fl_blocked_requests
>> to
>>    new->fl_blocked_requests
>>=20
>> it is nonsensical to do anything to all the remaining elements, there
>> aren't any.
>> This should do something to all the requests that have been
>> moved - for simplicity, it does it to all requests in the target
>> list.
>> Setting "f->fl_blocker =3D new" to all members of
>> new->fl_blocked_requests is "obviously correct" as it preserves
>> the invariant of the linkage among requests.
>>=20
>> Reported-by: syzbot+239d99847eb49ecb3899@syzkaller.appspotmail.com
>> Fixes: 5946c4319ebb ("fs/locks: allow a lock request to block other requ=
ests.")
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>>  fs/locks.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/fs/locks.c b/fs/locks.c
>> index f0b24d98f36b..ff6af2c32601 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -453,7 +453,7 @@ static void locks_move_blocks(struct file_lock *new,=
 struct file_lock *fl)
>>  		return;
>>  	spin_lock(&blocked_lock_lock);
>>  	list_splice_init(&fl->fl_blocked_requests, &new->fl_blocked_requests);
>> -	list_for_each_entry(f, &fl->fl_blocked_requests, fl_blocked_member)
>> +	list_for_each_entry(f, &new->fl_blocked_requests, fl_blocked_member)
>>  		f->fl_blocker =3D new;
>>  	spin_unlock(&blocked_lock_lock);
>>  }
>
> Thanks Neil,
>
> The VM I was using seemed to reproduce this pretty readily, and the
> patch does seem to fix it. I've gone ahead and added it to -next for
> now, and will plan to pass it on to Linus in the next few days after
> I've tested it a bit more.

Thanks,  that's encouraging.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlwtbIYACgkQOeye3VZi
gblKwQ//ZfA7rB7M4o/Iy8SR28GEUUbQuS5zD6ue6oRY20E+7AnyIR/4c7CdzxQt
rQ7EtbL1qlifcBMHJ9Vhl05GuOZEVQgVzlSU8czA9DX7DcS9Ji1hLoPel4ZviL0T
v8yhmNrKsGJ4iQNywBb+cHxEzdNCNzQq/0zZZhQfuJZJT4a+aORXH4jFGFjXdbfh
gmj1sw0YAmjCptwKmSGSDIMZ8b1OgdNn5byHduWXXUwlbR5ATwev1cOQwCIhlK7S
DW93r2UfFCi4wpIvcR8yT/bT48AbvjvEUg2N0tEzRAtbgN9vtjkbsx9miLiUQymU
95gQFjJSFqefJ9n4mKHXP/yI8vYMzJOS9EufWBGgnSRj563W4A8JHjxHF81X0hJh
OMWjpguslBJU1ZerZ4aajBJxNrHxQ57vAT8/NO5FYFA5yJshyGlQofaTW+DRB0Z2
6pIPogSSYWB3ahYXTzg5um02RQZG4oRN7PMG0YirqOKJo6KRpNrlLTMe6vbJTfIY
aQn8Su1+4Ml625KdkOtcDR5/THI+HifjfhNSEbfIT4KojwUHdQGCQjxg/qzqEoWR
yJfAfLqONesCjUyqlsFvbBbFoFw7TptERrR4YLoq3rZUHL9X05ifZa6dggDrnbvU
1XODoNJuS1XyzfCdjTCieEiMH13oowkQ2fBg6QJrQDrhfL89eW0=
=yRoy
-----END PGP SIGNATURE-----
--=-=-=--

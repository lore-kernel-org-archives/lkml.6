Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72B4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823182089D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823182089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeKPJvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:51:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:40310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbeKPJvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 04:51:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 672DBAEF1;
        Thu, 15 Nov 2018 23:41:42 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Jeff Layton <jlayton@kernel.org>
Date:   Fri, 16 Nov 2018 10:41:33 +1100
Cc:     syzbot <syzbot+a4a3d526b4157113ec6a@syzkaller.appspotmail.com>,
        Bruce Fields <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: KASAN: use-after-free Read in locks_delete_block
In-Reply-To: <CACT4Y+Z3zM0z9PScAKjyjspu35B-6OgTT_qEwc+AB_MFzJkL0A@mail.gmail.com>
References: <000000000000222b58057a7d9f39@google.com> <9d9ad7f2781bf15af4bd6ccc9feee35c7cd17979.camel@kernel.org> <87bm6svhhl.fsf@notabene.neil.brown.name> <b49e02d54460c79c4e5472983f6b9390005881b8.camel@kernel.org> <CACT4Y+Z3zM0z9PScAKjyjspu35B-6OgTT_qEwc+AB_MFzJkL0A@mail.gmail.com>
Message-ID: <87bm6pewnm.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Thu, Nov 15 2018, Dmitry Vyukov wrote:

> On Wed, Nov 14, 2018 at 2:36 AM, Jeff Layton <jlayton@kernel.org> wrote:
>> On Wed, 2018-11-14 at 07:40 +1100, NeilBrown wrote:
>>> On Tue, Nov 13 2018, Jeff Layton wrote:
>>>
>>> > On Mon, 2018-11-12 at 12:34 -0800, syzbot wrote:
>>> > > Hello,
>>> > >
>>> > > syzbot found the following crash on:
>>> > >
>>> > > HEAD commit:    442b8cea2477 Add linux-next specific files for 20181109
>>> > > git tree:       linux-next
>>> > > console output: https://syzkaller.appspot.com/x/log.txt?x=115dbad5400000
>>> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=2f72bdb11df9fbe8
>>> > > dashboard link: https://syzkaller.appspot.com/bug?extid=a4a3d526b4157113ec6a
>>> > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>> > >
>>> > > Unfortunately, I don't have any reproducer for this crash yet.
>>> > >
>>> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> > > Reported-by: syzbot+a4a3d526b4157113ec6a@syzkaller.appspotmail.com
>
> /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
>
> Hi Neil,
>
> Please include the Reported-by tag next time.

I did, as you can see below.

When the fix is merged into the patch that introduced the bug, do you
still want the Reported-by there, even though the bug and the fix are no
longer visible?  What if I were to completely rewrite the patch - do I
still need the Reported-by??

I'm certainly happy to give credit where due, but keeping a complete
history of past bugs in a single commit seems excessive.
Please help me to understand your needs.

>
> I see the linux-next patch is already update,
> so let's tell syzbot that this is fixed here:
>
> #syz fix: fs/locks: always delete_block after waiting.
>
> If the bug is still open on syzbot dashboard:
> https://syzkaller.appspot.com#upstream
> syzbot will not report new bugs in these functions in future.
>
> Thanks
>
>>> > > device loop0 blocksize: 4096
>>> > > __find_get_block_slow() failed. block=1, b_blocknr=8
>>> > > b_state=0x00000029, b_size=512
>>> > > device loop0 blocksize: 4096
>>> > > ==================================================================
>>> > > BUG: KASAN: use-after-free in __list_del_entry_valid+0xf1/0x100
>>> > > lib/list_debug.c:51
>>> > > Read of size 8 at addr ffff88017eb47b70 by task syz-executor3/13461
>>> > >
>>> > > CPU: 0 PID: 13461 Comm: syz-executor3 Not tainted 4.20.0-rc1-next-20181109+
>>> > > #110
>>> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>>> > > Google 01/01/2011
>>> > > Call Trace:
>>> > >   __dump_stack lib/dump_stack.c:77 [inline]
>>> > >   dump_stack+0x244/0x39d lib/dump_stack.c:113
>>> > >   print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
>>> > >   kasan_report_error mm/kasan/report.c:354 [inline]
>>> > >   kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
>>> > >   __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>>> > >   __list_del_entry_valid+0xf1/0x100 lib/list_debug.c:51
>>> > >   __list_del_entry include/linux/list.h:117 [inline]
>>> > >   list_del_init include/linux/list.h:159 [inline]
>>> > >   __locks_delete_block fs/locks.c:683 [inline]
>>> > >   locks_delete_block+0xce/0x3d0 fs/locks.c:716
>>> > >   locks_mandatory_area+0x48b/0x6a0 fs/locks.c:1398
>>> > >   rw_verify_area+0x2f2/0x360 fs/read_write.c:386
>>> > >   vfs_write+0x149/0x560 fs/read_write.c:544
>>> > >   ksys_write+0x101/0x260 fs/read_write.c:598
>>> > >   __do_sys_write fs/read_write.c:610 [inline]
>>> > >   __se_sys_write fs/read_write.c:607 [inline]
>>> > >   __x64_sys_write+0x73/0xb0 fs/read_write.c:607
>>> > >   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>> > >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>> > > RIP: 0033:0x457569
>>> > > Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
>>> > > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
>>> > > ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>>> > > RSP: 002b:00007ff2e8194c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>>> > > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
>>> > > RDX: 0000000000000010 RSI: 0000000020000180 RDI: 0000000000000006
>>> > > RBP: 000000000072c0e0 R08: 0000000000000000 R09: 0000000000000000
>>> > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff2e81956d4
>>> > > R13: 00000000004c571f R14: 00000000004d9360 R15: 00000000ffffffff
>>> > >
>>> > > The buggy address belongs to the page:
>>> > > page:ffffea0005fad1c0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
>>> > > flags: 0x2fffc0000000000()
>>> > > raw: 02fffc0000000000 0000000000000000 ffffea0005fad1c8 0000000000000000
>>> > > raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>>> > > page dumped because: kasan: bad access detected
>>> > >
>>> > > Memory state around the buggy address:
>>> > >   ffff88017eb47a00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>> > >   ffff88017eb47a80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>> > > > ffff88017eb47b00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>> > >
>>> > >                                                               ^
>>> > >   ffff88017eb47b80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>> > >   ffff88017eb47c00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>> > > ==================================================================
>>> > >
>>> >
>>> > Ouch, crash down in the mandatory locking code. This is with Neil's set
>>> > from last week. I haven't merged the series he sent the other day yet,
>>> > but they don't seem to be different in this regard.
>>> >
>>> > Looks like the fl_blocked list might have had an entry on it that was
>>> > freed without being removed? locks_mandatory_area declares a file_lock
>>> > on the stack, but it seems to be initialized properly.
>>> >
>>> > The one weird thing is that locks_mandatory_area sets FL_ACCESS and
>>> > FL_SLEEP, but I don't see anything wrong with that right offhand.
>>> >
>>> > Neil, any thoughts?
>>>
>>> I'm not certain, but probably this:
>>>
>>> From: NeilBrown <neilb@suse.com>
>>> Date: Wed, 14 Nov 2018 07:38:05 +1100
>>> Subject: [PATCH] fs/locks: always delete_block after waiting - mandatory locks
>>>
>>> The patch
>>>       fs/locks: always delete_block after waiting.
>>> should have moved the locks_delete_block() call in
>>> locks_mandatory_area() too.
>>>
>>> This might fix the bug:
>>> Reported-by: syzbot+a4a3d526b4157113ec6a@syzkaller.appspotmail.com

Here you see the Reported-by line that I included.

NeilBrown

>>>
>>> Signed-off-by: NeilBrown <neilb@suse.com>
>>> ---
>>>  fs/locks.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/locks.c b/fs/locks.c
>>> index f456cd3d9d50..eb0c0b33fb7b 100644
>>> --- a/fs/locks.c
>>> +++ b/fs/locks.c
>>> @@ -1436,9 +1436,9 @@ int locks_mandatory_area(struct inode *inode, struct file *filp, loff_t start,
>>>                               continue;
>>>               }
>>>
>>> -             locks_delete_block(&fl);
>>>               break;
>>>       }
>>> +     locks_delete_block(&fl);
>>>
>>>       return error;
>>>  }
>>
>> That makes sense. I went ahead and squashed this patch into the earlier
>> one and pushed the result to my locks-next branch. linux-next should
>> pick it up soon.
>>
>> Thanks!
>> --
>> Jeff Layton <jlayton@kernel.org>
>>
>> --
>> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/b49e02d54460c79c4e5472983f6b9390005881b8.camel%40kernel.org.
>> For more options, visit https://groups.google.com/d/optout.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvuBC4ACgkQOeye3VZi
gbmrdRAAlQgA4LAR5NcLFQqRWb8ToSBp8al+zste6sxtHmWZHtNTydyao8PHMmgK
rAmRO5DmIkJKQHqVanHBJoEp80x2SonQ3fVKAX+BEJoe/rAk52R5p4cz+hRZu0eM
uZsGsCAKu7CdS89rI3ipqA5Sgb/9kVCn35X+WZBtnF6rJ0dl1z6agnqZ3G3CcDBo
4jmyL/dI1eLvSCoDY+fA1BkuAdkAVmxfqtQ7ZCGV/KzjXAiJlbCfmwWB/z9HpaBP
l2gAERRY9JIaGpKQORQtiOtHSHxky/GIivRe7HfWqCXJXn1xZuLDYy/XccLt0oop
X4nu49apyWQW1i4uk3uktE1JoVpZ/230r8rJihTzkC58U24IwtumnMQR1i77ym1K
nTImgKs9+/5crwm5GZ0eX96iCPG2OXxK7qws7MRQNSX6MPWdRub41RnA9e0SlNRg
S1FDgT5xliL/bjTPNdChziVej7+/8wbmXLFEIXA0qLm6FQG1w7rKmcSSm/w2Uohu
cCjJ7b1ZqmcArakC9p6VVQc2EtMZClb+xxiCbf3vkFphBhMYR+L/nGYkM/z6BdMs
uwmbcR4fJDCQWDKciOjsSJLxkWiaTDM4wTKnvdV7LJg9JOA2NpH+tfQ8e0P9J/AS
NquH52ZcoAKRAbzC1giHIG7grdkNKd9sdBcvhbrNnAo5eFFk0nE=
=xGtP
-----END PGP SIGNATURE-----
--=-=-=--

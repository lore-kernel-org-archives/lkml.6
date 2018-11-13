Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5F2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5848224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5848224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbeKNGkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 01:40:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:54940 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725750AbeKNGkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 01:40:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1496DAFF6;
        Tue, 13 Nov 2018 20:40:38 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        syzbot <syzbot+a4a3d526b4157113ec6a@syzkaller.appspotmail.com>,
        bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Date:   Wed, 14 Nov 2018 07:40:22 +1100
Cc:     Neil Brown <neilb@suse.de>
Subject: Re: KASAN: use-after-free Read in locks_delete_block
In-Reply-To: <9d9ad7f2781bf15af4bd6ccc9feee35c7cd17979.camel@kernel.org>
References: <000000000000222b58057a7d9f39@google.com> <9d9ad7f2781bf15af4bd6ccc9feee35c7cd17979.camel@kernel.org>
Message-ID: <87bm6svhhl.fsf@notabene.neil.brown.name>
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

On Tue, Nov 13 2018, Jeff Layton wrote:

> On Mon, 2018-11-12 at 12:34 -0800, syzbot wrote:
>> Hello,
>>=20
>> syzbot found the following crash on:
>>=20
>> HEAD commit:    442b8cea2477 Add linux-next specific files for 20181109
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D115dbad54000=
00
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2f72bdb11df9=
fbe8
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3Da4a3d526b41571=
13ec6a
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>=20
>> Unfortunately, I don't have any reproducer for this crash yet.
>>=20
>> IMPORTANT: if you fix the bug, please add the following tag to the commi=
t:
>> Reported-by: syzbot+a4a3d526b4157113ec6a@syzkaller.appspotmail.com
>>=20
>> device loop0 blocksize: 4096
>> __find_get_block_slow() failed. block=3D1, b_blocknr=3D8
>> b_state=3D0x00000029, b_size=3D512
>> device loop0 blocksize: 4096
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> BUG: KASAN: use-after-free in __list_del_entry_valid+0xf1/0x100=20=20
>> lib/list_debug.c:51
>> Read of size 8 at addr ffff88017eb47b70 by task syz-executor3/13461
>>=20
>> CPU: 0 PID: 13461 Comm: syz-executor3 Not tainted 4.20.0-rc1-next-201811=
09+=20=20
>> #110
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
=20=20
>> Google 01/01/2011
>> Call Trace:
>>   __dump_stack lib/dump_stack.c:77 [inline]
>>   dump_stack+0x244/0x39d lib/dump_stack.c:113
>>   print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
>>   kasan_report_error mm/kasan/report.c:354 [inline]
>>   kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
>>   __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>>   __list_del_entry_valid+0xf1/0x100 lib/list_debug.c:51
>>   __list_del_entry include/linux/list.h:117 [inline]
>>   list_del_init include/linux/list.h:159 [inline]
>>   __locks_delete_block fs/locks.c:683 [inline]
>>   locks_delete_block+0xce/0x3d0 fs/locks.c:716
>>   locks_mandatory_area+0x48b/0x6a0 fs/locks.c:1398
>>   rw_verify_area+0x2f2/0x360 fs/read_write.c:386
>>   vfs_write+0x149/0x560 fs/read_write.c:544
>>   ksys_write+0x101/0x260 fs/read_write.c:598
>>   __do_sys_write fs/read_write.c:610 [inline]
>>   __se_sys_write fs/read_write.c:607 [inline]
>>   __x64_sys_write+0x73/0xb0 fs/read_write.c:607
>>   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x457569
>> Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 =
f7=20=20
>> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 f=
f=20=20
>> ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007ff2e8194c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
>> RDX: 0000000000000010 RSI: 0000000020000180 RDI: 0000000000000006
>> RBP: 000000000072c0e0 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff2e81956d4
>> R13: 00000000004c571f R14: 00000000004d9360 R15: 00000000ffffffff
>>=20
>> The buggy address belongs to the page:
>> page:ffffea0005fad1c0 count:0 mapcount:0 mapping:0000000000000000 index:=
0x0
>> flags: 0x2fffc0000000000()
>> raw: 02fffc0000000000 0000000000000000 ffffea0005fad1c8 0000000000000000
>> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>> page dumped because: kasan: bad access detected
>>=20
>> Memory state around the buggy address:
>>   ffff88017eb47a00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>   ffff88017eb47a80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> > ffff88017eb47b00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>=20
>>                                                               ^
>>   ffff88017eb47b80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>   ffff88017eb47c00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>
> Ouch, crash down in the mandatory locking code. This is with Neil's set
> from last week. I haven't merged the series he sent the other day yet,
> but they don't seem to be different in this regard.
>
> Looks like the fl_blocked list might have had an entry on it that was
> freed without being removed? locks_mandatory_area declares a file_lock
> on the stack, but it seems to be initialized properly.
>
> The one weird thing is that locks_mandatory_area sets FL_ACCESS and
> FL_SLEEP, but I don't see anything wrong with that right offhand.
>
> Neil, any thoughts?

I'm not certain, but probably this:

From: NeilBrown <neilb@suse.com>
Date: Wed, 14 Nov 2018 07:38:05 +1100
Subject: [PATCH] fs/locks: always delete_block after waiting - mandatory lo=
cks

The patch
      fs/locks: always delete_block after waiting.
should have moved the locks_delete_block() call in
locks_mandatory_area() too.

This might fix the bug:
Reported-by: syzbot+a4a3d526b4157113ec6a@syzkaller.appspotmail.com

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 fs/locks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index f456cd3d9d50..eb0c0b33fb7b 100644
=2D-- a/fs/locks.c
+++ b/fs/locks.c
@@ -1436,9 +1436,9 @@ int locks_mandatory_area(struct inode *inode, struct =
file *filp, loff_t start,
 				continue;
 		}
=20
=2D		locks_delete_block(&fl);
 		break;
 	}
+	locks_delete_block(&fl);
=20
 	return error;
 }
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvrNrcACgkQOeye3VZi
gbkLUw/9Ft7k7AaNK9bCbGy0hPy30Y6lmaLxlgVr58SGAYH1Xc0/KbIJFY5WbJVa
IXOsew5VsEqwMWNjqH0XkOvQ8NWgjEC9f16h3gblsVpmcz7uj4AKw10JJXXKVk9m
qgogMTpeKv9+SivG0kfgOs4+OkvrnFq1v6T5BUPXKr5ki7HIcjjxc0fL/hktDtwH
GP6J8Wj7ONXSA4la/xiNt5FrWmlKTqv2UDGqIpWjtV3pZcDbGcrtZvx4XSy9ZHit
yi6BZrcY6RcLyJz8ru4DJs6NmJfags9ZIGm9aAMGgaYs9hWCfTuCOBIR5Rc4fNPC
jU7zkmfXf27Mu/O+GWGRR0JIM9pa9qIuasp0ktSosBH1Gz+ebMug6weuYWW1Z1SN
wDHCEK9riI3Q6CQ9SEV1s2hVAdeinVXh0BkhJzy91a7okoodCEg5R8Y0Te4Yg4Oc
CJ2IInHmoGDIVy+9EqinqPipZ1N0radiBa16OuIdWrYKAX/fcxmEAERnDjVoNc7Y
6/+owTkt7La89h0Yny4c11VgXWRxYQwN/eJhDBFzDA4GklXlzjYD4kTGCUesMKo3
bmuuLQJJsAGQOyJPvngtpc7KzX+Q8GhIeMrI0Dv6JZL58i6+UugI8cNImh9HKU+z
XTwBALIl23iWXS5d4JVPPfcxsLlTtkiCo6kZ3bZwEXxDbWoyLdk=
=Y0bO
-----END PGP SIGNATURE-----
--=-=-=--

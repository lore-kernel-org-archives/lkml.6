Return-Path: <swhiteho@redhat.com>
X-Google-Smtp-Source: AIpwx4/hXU/BKPw6iGnXjpK5CGxNRtT5tnu2xEhl/N9Y104OK+jia1Z+lEsi5JHjZJyqIWQxfqvD
ARC-Seal: i=1; a=rsa-sha256; t=1522917384; cv=none;
        d=google.com; s=arc-20160816;
        b=jBSEBmWi7t3/CnYIpooMvbhxAWrjeZ4g7LJWYLrwfDpCGxE8MrojLaLtpuk5tqRjiP
         rdCeudWP8EOa0ttyd3yb8vtteDrBsy2CKF8wSMZGVKjvMqstws6gXGXW5tp+3QzDS8gE
         OIXo5iFmKrtliKkcO0XqP6QSRpv+jI7TR4Q0nmwckh3AA6DNc9c4rNyL4JlIbQPPXbUe
         c45SuMvvtJeh4Ms3pHCiDAdoQIBHY7aACXLxpsBgMUXe3XTmc8+8LUtz4rKscoV5hxeD
         2pHY38iPqDrYbRrmP4cIL8tbECWHuuSzcvehKV0KXXbMEuEeZrGCM6PQThuGnD5r66u1
         d1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=mXt11FOn6yTYoIkVd/sJcKLJ/TgHAS+IVXcueeMnXJg=;
        b=UkDbLWuXZYbn8b62ZvoEp0arRuzeYTwVjSG5CNcTM5KJjQujNF1Hz6/VAUc0qFTS50
         f6kj1KarKnTpq5xjFzs8/OI26rXOe66EAS9fJQ8L8k/JlpUMVkaj/Xbsavstg5MXa7W2
         avbjQ26GOFRpkj8xh0SEjiyxgzyJmPDR12jt20Zlhz3PQr4wFYwdOcffyfL9M83w+oGC
         Jt8wXVMs/NfbaROzUERpHx86GVa+tDDksImqQhuBdYvP5WVURPXwB3p0QbuUQqkzJ3l1
         GWe/uuzwEj8338G+aBdNRuZ8F9xfG4vAVitYcXzoKu9UGmVO2ira7RlmApksmApeKD7L
         P0cg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of swhiteho@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=swhiteho@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of swhiteho@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=swhiteho@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: WARNING: kobject bug in sysfs_warn_dup
To: Dmitry Vyukov <dvyukov@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 rpeterso@redhat.com, cluster-devel@redhat.com
Cc: syzbot <syzbot+ff87a28e665c163aa7f5@syzkaller.appspotmail.com>,
 LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com
References: <f4f5e80803d0503e760569105376@google.com>
 <20180405063444.GA5877@kroah.com>
 <CACT4Y+Yi1QoM_NAWp8e6MvyCOBhFedL30-uKzuM6h8pG=ftu0w@mail.gmail.com>
From: Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <26e497b0-1e10-d9c6-73eb-e0feed9a60ea@redhat.com>
Date: Thu, 5 Apr 2018 09:36:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Yi1QoM_NAWp8e6MvyCOBhFedL30-uKzuM6h8pG=ftu0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596869807528039825?=
X-GMAIL-MSGID: =?utf-8?q?1596894618881165627?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,


On 05/04/18 09:19, Dmitry Vyukov wrote:
> On Thu, Apr 5, 2018 at 8:34 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> On Wed, Apr 04, 2018 at 07:02:01PM -0700, syzbot wrote:
>>> Hello,
>>>
>>> syzbot hit the following crash on upstream commit
>>> 3e968c9f1401088abc9a19ae6ff571644d37a355 (Wed Apr 4 21:19:24 2018 +0000)
>>> Merge tag 'ext4_for_linus' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
>>> syzbot dashboard link:
>>> https://syzkaller.appspot.com/bug?extid=ff87a28e665c163aa7f5
>>>
>>> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5104666266304512
>>> syzkaller reproducer:
>>> https://syzkaller.appspot.com/x/repro.syz?id=5683447737614336
>>> Raw console output:
>>> https://syzkaller.appspot.com/x/log.txt?id=5104818200772608
>>> Kernel config:
>>> https://syzkaller.appspot.com/x/.config?id=9118669095563550941
>>> compiler: gcc (GCC) 7.1.1 20170620
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+ff87a28e665c163aa7f5@syzkaller.appspotmail.com
>>> It will help syzbot understand when the bug is fixed. See footer for
>>> details.
>>> If you forward the report, please keep this part and the footer.
>>>
>>> R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000003
>>> R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
>>> ------------[ cut here ]------------
>>> kobject_add_internal failed for nodev( with -EEXIST, don't try to register
>>> things with the same name in the same directory.
>>> sysfs: cannot create duplicate filename '/fs/gfs2/nodev('
>>> WARNING: CPU: 1 PID: 4473 at lib/kobject.c:238
>>> kobject_add_internal+0x8d4/0xbc0 lib/kobject.c:235
>>> CPU: 0 PID: 4474 Comm: syzkaller533472 Not tainted 4.16.0+ #15
>>> Kernel panic - not syncing: panic_on_warn set ...
>>>
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>>> Google 01/01/2011
>>> Call Trace:
>>>   __dump_stack lib/dump_stack.c:17 [inline]
>>>   dump_stack+0x1a7/0x27d lib/dump_stack.c:53
>>>   sysfs_warn_dup+0x83/0xa0 fs/sysfs/dir.c:30
>>>   sysfs_create_dir_ns+0x178/0x1d0 fs/sysfs/dir.c:58
>>>   create_dir lib/kobject.c:69 [inline]
>>>   kobject_add_internal+0x335/0xbc0 lib/kobject.c:227
>>>   kobject_add_varg lib/kobject.c:364 [inline]
>>>   kobject_init_and_add+0xf9/0x150 lib/kobject.c:436
>>>   gfs2_sys_fs_add+0x1ff/0x580 fs/gfs2/sys.c:652
>>>   fill_super+0x86f/0x1d70 fs/gfs2/ops_fstype.c:1118
>>>   gfs2_mount+0x587/0x6e0 fs/gfs2/ops_fstype.c:1321
>> gfs2 bug, not a sysfs bug, we are correctly warning about an incorrect
>> usage of the api.
> Then +gfs2 maintainers.
>
>> Now if we should turn this into a non-WARN message, that's a different
>> thing, I'll gladly take a patch for that.
> If it's API usage bug in higher level code, then I think WARN is a
> proper thing. We already had similar ones and they were fixed.

I'm trying to figure out what the test is doing, but it is not very 
clear. At a guess I'd say that perhaps it is trying to mount multiple 
filesystems with the same label? If that is the case then it is not 
allowed, and it should be caught be the sysfs code and result in a 
refusal to mount, which is what I think I see here. Knowing which sysfs 
directory is involved would allow us to confirm, but I suspect that the 
test needs altering to give each gfs2 mount a different label at an 
initial guess,

Steve.

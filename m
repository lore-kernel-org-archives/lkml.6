Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCB2ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D78204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FGJVZihv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D78204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbeGQNSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:18:40 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45569 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731538AbeGQNSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:18:40 -0400
Received: by mail-oi0-f66.google.com with SMTP id q11-v6so1697390oic.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 05:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/YNGtiLOrNgDJhJG7ECSwj3yCPMs9gQpx8/SEdMmmIs=;
        b=FGJVZihvoeIhxEV9SspksfvVfU/0StuLi1KTyXQYekny5liWzzgT9ENmkbjzXw3AIJ
         IIni+8fOpJZbKZUeATBRt4m+LzbLcVcSvqxKa5LbUlPa6llBNAYEExxXwryqomoCrG9u
         G+viMW/oSkFyzGZrWoSbN5J+nzTepAT3Y9kGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/YNGtiLOrNgDJhJG7ECSwj3yCPMs9gQpx8/SEdMmmIs=;
        b=DJB2iZiNLWiCRvPEO0B3rQI6s+B90oapWMna2VMne2rLlcVOlIsKl4giizgF3BR3yN
         Bu9DgwAHGQyEHc/PT+Dqc03IUYo2CjzPhhZrEfVZx+9bl9ohKB4orFxBhrFWZN07aNzK
         qzjV+1SpEwqTsuu5r1ps+NLTdmrWAD2KQeIOmnuwsogoDbbMmexRNQ5BqRRhdYeVNezU
         4aZx5zyH5X5JjzFW1WVkNGR9xFZwIamZQQQo8O+0KKpa+hFIvSYTo5CbHNFCyoNPDUs9
         xjUDfVlxsLWkb+0oY/8W4Tynz75Lke9hwoNi+OSNJgMb8XHXwzRFJu8V+5vthOcYWM9n
         DXgA==
X-Gm-Message-State: AOUpUlFcsF5fRYEZFnPSRfAkrxxDcmOK9MzaEqjUZnD6go5YBl+JOpo1
        GF/X1jZi9BhhTtoOd4bZYDhLiuDG+VbfcXVaHDgGhg==
X-Google-Smtp-Source: AAOMgpeDt7rqDcgcRjgcQPKwAO/FuCo9jUh8mr7QMhWbNSyc/1bUyZQ11TLM6r75WKTyUNBratgazvZidxYrJogMZJk=
X-Received: by 2002:aca:2ec9:: with SMTP id u192-v6mr1386111oiu.17.1531831569697;
 Tue, 17 Jul 2018 05:46:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 05:46:08
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <CACT4Y+Y=NZZDXPGvgTZzoG0G=a0TG+=vUXHUJPZMBvcufz872A@mail.gmail.com>
References: <0000000000006a10de0570cf4d66@google.com> <CAJfpeguHRhT4xwDNu-xEfA+YOrB7Wo7eM8sU19RGLaBpEN0g_A@mail.gmail.com>
 <CACT4Y+Y=NZZDXPGvgTZzoG0G=a0TG+=vUXHUJPZMBvcufz872A@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Jul 2018 14:46:08 +0200
Message-ID: <CAJfpegu20a7CCJQYTgrmuKPuAJkRgdv_5rmt6T-3kWKH5BpWnQ@mail.gmail.com>
Subject: Re: WARNING: lock held when returning to user space in fuse_lock_inode
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+3f7b29af1baa9d0a55be@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        astrachan@google.com
Content-Type: multipart/mixed; boundary="00000000000091881205713154fc"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000091881205713154fc
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 17, 2018 at 1:36 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Tue, Jul 17, 2018 at 1:14 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>> On Thu, Jul 12, 2018 at 5:49 PM, syzbot
>> <syzbot+3f7b29af1baa9d0a55be@syzkaller.appspotmail.com> wrote:
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    c25c74b7476e Merge tag 'trace-v4.18-rc3-2' of git://git.ke..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=177bcec2400000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3f7b29af1baa9d0a55be
>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=13aa7678400000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17492678400000
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+3f7b29af1baa9d0a55be@syzkaller.appspotmail.com
>>>
>>> random: sshd: uninitialized urandom read (32 bytes read)
>>> random: sshd: uninitialized urandom read (32 bytes read)
>>> random: sshd: uninitialized urandom read (32 bytes read)
>>>
>>> ================================================
>>> WARNING: lock held when returning to user space!
>>> 4.18.0-rc4+ #143 Not tainted
>>> ------------------------------------------------
>>> syz-executor012/4539 is leaving the kernel with locks still held!
>>> 1 lock held by syz-executor012/4539:
>>>  #0: (____ptrval____) (&fi->mutex){+.+.}, at: fuse_lock_inode+0xaf/0xe0
>>> fs/fuse/inode.c:363
>>
>> False positive.
>>
>> fi->mutex is definitely not held by the acquiring task when returning
>> to userspace.  Maybe syzkaller is confused by the fact that there are
>> several interdependent tasks involved with fuse:  the one calling into
>> fuse by doing something (looking up ./file0/file0) and the one that
>> reads the fuse device (returning with the LOOKUP request for "file0").
>> The second one will return with that lock held, but it's not the one
>> that acquired it, so there's no bug at all here.
>
> Hi Miklos,
>
> syzkaller is unrelated here. That's what kernel self-detects and
> prints. So either way there is something to fix in kernel here: either
> fuse or lockdep.
>
> +Alistair did some analysis offline, hope you don't mind if I repost
> your description:
> ===
> Just from reading the code, I think I can see how this happens. Fuse
> is wrapping its inode mutex with a check for "parallel_dirops", which
> is set up in process_init_reply(). The FUSE_PARALLEL_DIROPS appears to
> always be set, in fuse_send_init(), but its initial state is to be
> disabled. So if the mutex gets taken, and it'll never be unlocked if
> the initial command is flushed by fuse_readdir()'s use of
> fuse_lock_inode().
> ===

Ah, indeed.  Fix attached.

Thanks,
Miklos

--00000000000091881205713154fc
Content-Type: text/x-patch; charset="US-ASCII"; name="fuse-fix-initial-parallel-dirops.patch"
Content-Disposition: attachment; 
	filename="fuse-fix-initial-parallel-dirops.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jjpoy1yy0

RnJvbTogTWlrbG9zIFN6ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5jb20+ClN1YmplY3Q6IGZ1c2U6
IGZpeCBpbml0YWwgcGFyYWxsZWwgZGlyb3BzCgpJZiBwYXJhbGxlbCBkaXJvcHMgYXJlIGVuYWJs
ZWQgaW4gRlVTRV9JTklUIHJlcGx5LCB0aGVuIGZpcnN0IG9wZXJhdGlvbiBtYXkKbGVhdmUgZmkt
Pm11dGV4IGhlbGQuCgpSZXBvcnRlZC1ieTogc3l6Ym90KzNmN2IyOWFmMWJhYTlkMGE1NWJlQHN5
emthbGxlci5hcHBzcG90bWFpbC5jb20KU2lnbmVkLW9mZi1ieTogTWlrbG9zIFN6ZXJlZGkgPG1z
emVyZWRpQHJlZGhhdC5jb20+Ci0tLQogZnMvZnVzZS9kaXIuYyAgICB8ICAgMTAgKysrKysrLS0t
LQogZnMvZnVzZS9mdXNlX2kuaCB8ICAgIDQgKystLQogZnMvZnVzZS9pbm9kZS5jICB8ICAgMTQg
KysrKysrKysrKy0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTAgZGVs
ZXRpb25zKC0pCgotLS0gYS9mcy9mdXNlL2Rpci5jCisrKyBiL2ZzL2Z1c2UvZGlyLmMKQEAgLTM1
NSwxMSArMzU1LDEyIEBAIHN0YXRpYyBzdHJ1Y3QgZGVudHJ5ICpmdXNlX2xvb2t1cChzdHJ1Y3QK
IAlzdHJ1Y3QgaW5vZGUgKmlub2RlOwogCXN0cnVjdCBkZW50cnkgKm5ld2VudDsKIAlib29sIG91
dGFyZ192YWxpZCA9IHRydWU7CisJYm9vbCBsb2NrZWQ7CiAKLQlmdXNlX2xvY2tfaW5vZGUoZGly
KTsKKwlsb2NrZWQgPSBmdXNlX2xvY2tfaW5vZGUoZGlyKTsKIAllcnIgPSBmdXNlX2xvb2t1cF9u
YW1lKGRpci0+aV9zYiwgZ2V0X25vZGVfaWQoZGlyKSwgJmVudHJ5LT5kX25hbWUsCiAJCQkgICAg
ICAgJm91dGFyZywgJmlub2RlKTsKLQlmdXNlX3VubG9ja19pbm9kZShkaXIpOworCWZ1c2VfdW5s
b2NrX2lub2RlKGRpciwgbG9ja2VkKTsKIAlpZiAoZXJyID09IC1FTk9FTlQpIHsKIAkJb3V0YXJn
X3ZhbGlkID0gZmFsc2U7CiAJCWVyciA9IDA7CkBAIC0xMzQwLDYgKzEzNDEsNyBAQCBzdGF0aWMg
aW50IGZ1c2VfcmVhZGRpcihzdHJ1Y3QgZmlsZSAqZmlsCiAJc3RydWN0IGZ1c2VfY29ubiAqZmMg
PSBnZXRfZnVzZV9jb25uKGlub2RlKTsKIAlzdHJ1Y3QgZnVzZV9yZXEgKnJlcTsKIAl1NjQgYXR0
cl92ZXJzaW9uID0gMDsKKwlib29sIGxvY2tlZDsKIAogCWlmIChpc19iYWRfaW5vZGUoaW5vZGUp
KQogCQlyZXR1cm4gLUVJTzsKQEAgLTEzNjcsOSArMTM2OSw5IEBAIHN0YXRpYyBpbnQgZnVzZV9y
ZWFkZGlyKHN0cnVjdCBmaWxlICpmaWwKIAkJZnVzZV9yZWFkX2ZpbGwocmVxLCBmaWxlLCBjdHgt
PnBvcywgUEFHRV9TSVpFLAogCQkJICAgICAgIEZVU0VfUkVBRERJUik7CiAJfQotCWZ1c2VfbG9j
a19pbm9kZShpbm9kZSk7CisJbG9ja2VkID0gZnVzZV9sb2NrX2lub2RlKGlub2RlKTsKIAlmdXNl
X3JlcXVlc3Rfc2VuZChmYywgcmVxKTsKLQlmdXNlX3VubG9ja19pbm9kZShpbm9kZSk7CisJZnVz
ZV91bmxvY2tfaW5vZGUoaW5vZGUsIGxvY2tlZCk7CiAJbmJ5dGVzID0gcmVxLT5vdXQuYXJnc1sw
XS5zaXplOwogCWVyciA9IHJlcS0+b3V0LmguZXJyb3I7CiAJZnVzZV9wdXRfcmVxdWVzdChmYywg
cmVxKTsKLS0tIGEvZnMvZnVzZS9mdXNlX2kuaAorKysgYi9mcy9mdXNlL2Z1c2VfaS5oCkBAIC05
NzQsOCArOTc0LDggQEAgaW50IGZ1c2VfZG9fc2V0YXR0cihzdHJ1Y3QgZGVudHJ5ICpkZW50cgog
CiB2b2lkIGZ1c2Vfc2V0X2luaXRpYWxpemVkKHN0cnVjdCBmdXNlX2Nvbm4gKmZjKTsKIAotdm9p
ZCBmdXNlX3VubG9ja19pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlKTsKLXZvaWQgZnVzZV9sb2Nr
X2lub2RlKHN0cnVjdCBpbm9kZSAqaW5vZGUpOwordm9pZCBmdXNlX3VubG9ja19pbm9kZShzdHJ1
Y3QgaW5vZGUgKmlub2RlLCBib29sIGxvY2tlZCk7Citib29sIGZ1c2VfbG9ja19pbm9kZShzdHJ1
Y3QgaW5vZGUgKmlub2RlKTsKIAogaW50IGZ1c2Vfc2V0eGF0dHIoc3RydWN0IGlub2RlICppbm9k
ZSwgY29uc3QgY2hhciAqbmFtZSwgY29uc3Qgdm9pZCAqdmFsdWUsCiAJCSAgc2l6ZV90IHNpemUs
IGludCBmbGFncyk7Ci0tLSBhL2ZzL2Z1c2UvaW5vZGUuYworKysgYi9mcy9mdXNlL2lub2RlLmMK
QEAgLTM1NywxNSArMzU3LDIxIEBAIGludCBmdXNlX3JldmVyc2VfaW52YWxfaW5vZGUoc3RydWN0
IHN1cGUKIAlyZXR1cm4gMDsKIH0KIAotdm9pZCBmdXNlX2xvY2tfaW5vZGUoc3RydWN0IGlub2Rl
ICppbm9kZSkKK2Jvb2wgZnVzZV9sb2NrX2lub2RlKHN0cnVjdCBpbm9kZSAqaW5vZGUpCiB7Ci0J
aWYgKCFnZXRfZnVzZV9jb25uKGlub2RlKS0+cGFyYWxsZWxfZGlyb3BzKQorCWJvb2wgbG9ja2Vk
ID0gZmFsc2U7CisKKwlpZiAoIWdldF9mdXNlX2Nvbm4oaW5vZGUpLT5wYXJhbGxlbF9kaXJvcHMp
IHsKIAkJbXV0ZXhfbG9jaygmZ2V0X2Z1c2VfaW5vZGUoaW5vZGUpLT5tdXRleCk7CisJCWxvY2tl
ZCA9IHRydWU7CisJfQorCisJcmV0dXJuIGxvY2tlZDsKIH0KIAotdm9pZCBmdXNlX3VubG9ja19p
bm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlKQordm9pZCBmdXNlX3VubG9ja19pbm9kZShzdHJ1Y3Qg
aW5vZGUgKmlub2RlLCBib29sIGxvY2tlZCkKIHsKLQlpZiAoIWdldF9mdXNlX2Nvbm4oaW5vZGUp
LT5wYXJhbGxlbF9kaXJvcHMpCisJaWYgKGxvY2tlZCkKIAkJbXV0ZXhfdW5sb2NrKCZnZXRfZnVz
ZV9pbm9kZShpbm9kZSktPm11dGV4KTsKIH0KIAo=
--00000000000091881205713154fc--

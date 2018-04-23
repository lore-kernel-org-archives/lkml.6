Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1236102-1524491216-2-8946197951696705462
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524491215; b=W4F9mkT+gNt2NgV+dONwjvQSAPIcW3/++pzUVXQAUp190E8sGg
    pxJ3Qoz+kjGyNQ4Z/nZ9iecAVYsezlupgJfQ5NxLvsnLtOAYWOlSLU1xbfT+mjLj
    cF1F8LGLdfTj3GzD11M68MIlgG2h9pjDxIr1Fcz2TVC6wkBnx004GTLxw8jMDV1/
    1PDgeBa666ELR0aa+vjkmKR7ZVlDY2emR8WAIeTUVNk4a8+gKcuX/8oCo7V9rM4i
    70kxdyakGDSdxRyVMtY9FVR5ew/63dCZVgOi86L3mAB30g1pyp8wL+sKu2uY5wVb
    BTtHQQ8i+w2zkKzgZBe4PhCge5WaqyHTnJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524491215; bh=TSjYs
    jgarrPZa53UQyk/vmucVdkA1dYywqtKqaQRTaY=; b=Oc8cRJcYD5XZq3XZ4YsXs
    QcyGEfyXpQfCfnbfoSJWRRLOk0FVjohcFqYxZ9J5ux7/9p7/30L0QffgIqXHTw7P
    GOdtveeWbchAF4bCgKCmwCQPkudkSpl0IiO0ZoZbsZHs6uvsXjd1W17wKxDVqRZN
    Wnoghfyvhm0+8Dsm5xV/xbtScBv+8Mo909uC2Vz2gGB5djtYYB3h9qwWh270yfy7
    Bv6n1foY8LixMMAaKonNJ6OuvxUJ+/y/edAK4UkeyGvMFVQc2l7s5C427rG05ihH
    InnKc3nN1XIpgYzsD6f58TbT+RoQYoK8HET91GFGakQT5KhGIYkGzjPkpWwiVkNM
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=urKqcuH+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=j6FmgdmL;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-51 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=urKqcuH+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=j6FmgdmL;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOC+JAOJGLbsKrFsTy+uVB08aCVnb/fgYDBmmBcBDd+IqUnh6Szq2CQ3/BE4gPaLcr7E6Ixv5P6pvsbeQOFVPUenwPzcXusE/S808TNnwGmY3tIc3r6X
    mil4DPisUOg5H0php5K6KeUVsEjRAGRPIyTe5WwI0+Hyv+6R5Rcmge9olljOwBjE/e00xnBDXN7KpSKi3O2Psb5PMt/ufVMFmL3Y7GXChButLJP986aUUDIh
    dFBDF5IOOzB7NaRb+t4Ypw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=n8i27M1mAAAA:8 a=1XWaLZrsAAAA:8
    a=edf1wS77AAAA:8 a=DDOyTI_5AAAA:8 a=YGKRyrmwlPhcdtmiDnoA:9 a=CjuIK1q_8ugA:10
    a=DcSpbTIhAlouE1Uv7lRv:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx49phSALHtB2z4cy2XiD9nYEStNA6ZlpEbwnWdTO8PHcc2psM0/4FiQ5x/Lavgeg8yoXBXUv1oSxkMt1PUa82wc=
MIME-Version: 1.0
In-Reply-To: <CAB0TPYGQz1Dz4=bQy9KOXZbp+Z+t6S_2Fkv2SOnvYLexMnRefw@mail.gmail.com>
References: <001a113f8f14113e790568fd0c02@google.com>
 <20180419213517.GA13221@gmail.com>
 <CAB0TPYGC_e9FZfDzVRQEJbjB7HfRvHZ+TUGAySzhOT3AHUUq8w@mail.gmail.com>
 <CACT4Y+YcODNPLzx5Zjjswz4mCcoootVQQGgwfsta+f8Vxn0RUA@mail.gmail.com>
 <CAB0TPYHLxjfmisvmVLOw+6XjV+mt=buZPJFCpg44JZpGimjLjw@mail.gmail.com>
 <CACT4Y+Y6cOgF4+TnFuU6NO8-ycpmo5=Ma-Dg+nAp71iTK64-Lw@mail.gmail.com>
 <CAB0TPYGxrDF+egw9GUXhWaDnj6wkH8gKd=htyujUH4jzwSE8zA@mail.gmail.com>
 <CACT4Y+YBGFBuMFUXYgOPCStfvAMNqxHmK_51zYev6GS-PmkcCw@mail.gmail.com>
 <CAB0TPYGQz1Dz4=bQy9KOXZbp+Z+t6S_2Fkv2SOnvYLexMnRefw@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 23 Apr 2018 15:46:25 +0200
Message-ID: <CACT4Y+ZbkZaLfYtz6v+9FvB-3G6=6eAGHE1HGvXtGdOh2zYZdQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in binder_release_work
To: Martijn Coenen <maco@android.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
 Todd Kjos <tkjos@android.com>, Greg KH <gregkh@linuxfoundation.org>,
 Eric Biggers <ebiggers3@gmail.com>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
 syzbot <syzbot+0cf1f1aa154f56ff2e8d@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 3:28 PM, Martijn Coenen <maco@android.com> wrote:
> On Mon, Apr 23, 2018 at 12:17 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> syzbot does not extract this info from patch emails.
>
> Ok so IIUC, Reported-By tags will only be considered when they are
> actually part of commits in one of the tested trees - makes sense. So
> does sending "#syz fix: xyz" cause syzbot to look inside all the trees
> it analyzes for xyz and mark it as closed if found? Does it look
> immediately or on some schedule, and does it retry? In this case, I
> think my patch wasn't in any tree yet when you sent "#syz fix", only
> in Greg's queue (Greg actually pushed it half an hour after your
> message). Just want to make sure I do the right thing next time.

When syzbot web app receives "syz fix" it notes the association. You
can now see it here:
https://syzkaller.appspot.com/bug?id=952e31f49f15c6de449295b8920dcc4ed935ebbf

Commits: ANDROID: binder: prevent transactions into own process.

Then, when test machines pull/build kernel, they send to the web app
which of the pending commits they see in own tree.
On the dashboard you can now see this line:

Patched on: [], missing on: [ci-upstream-bpf-next-kasan-gce
ci-upstream-kasan-gce ci-upstream-kasan-gce-386
ci-upstream-kasan-gce-root ci-upstream-kmsan-gce
ci-upstream-net-kasan-gce]

which means that no tested kernel yet have this commit.
Later the "Patched on" list will be populates as the commit reaches
the trees and test machines rebuild kernels. When all trees are
patched, the bug will be closed.


>> First of all, it's not possible to discover them all.
>> Second, a mailed patch does not mean committed patch. v2 can be resent
>> and potentially change title too.
>>
>> syzbot takes this info from commits in the tree it tests. It probably
>> could extract some emails from the commit. But they can come months
>> later, so their value will be questionable. Also consider that 2
>> commits in different trees mention the same bug. syzbot generally
>> overwrites old info with new info, because that's the only way to fix
>> up things. Now this can lead to infinite stream of emails saying that
>> this commit fixes this bug, no that commit fixes this bug, no this
>> commit fixes this bug, etc.
>> Also consider that a bug is first marked as fixed with some commit,
>> bug later is marked as dup of another or re-marked as fixed with
>> another commit. You won't get a notification, because the whole
>> sequence looks reasonable.
>> This can also lead to problems when commits backported to
>> android/chromeos trees that syzbot also tests. There these fix tags
>> look plain bogus because they reference upstream bug, not
>> android/chromeos bugs.
>>
>> By default we try to keep syzbot silent and non-spammy. And we do not
>> seem to have lots of such cases where things are somewhat messed. And
>> in all cases it should come to eventual consistency. If something is
>> marked as fixed prematurely, syzbot will open another bug. If
>> something is not marked as fixed (or marked as fixed with a
>> non-existent commit), then these bugs still hang on the dashboard and
>> visible.
>>
>>
>>>>> Thanks,
>>>>> Martijn
>>>>>
>>>>>> Now syzbot already skips list_del frame and takes the next one, so it
>>>>>> should become slightly better.
>>>>>>
>>>>>> Let's close this one with the binder fix (since that one was closed
>>>>>> with an rdma fix):
>>>>>>
>>>>>> #syz fix: ANDROID: binder: prevent transactions into own process.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

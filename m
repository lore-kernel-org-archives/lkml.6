Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1194855-1524490133-2-9819986466836717619
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524490132; b=aHqNzMR4sGAVpK0JiYZYBTUfcr4OiG596szM1xereLzK/hfM14
    0OW1UdMHc3ve0vXBYPMAuVbkdNFiKUPGn5bZvNsGA4lC761YKP1U0vL1VcQricic
    l6AydS9eS8roylHC7h/r7mDsZNMXIUIMiUgBXB+aLxXx5z/3EqNp4CRYL/HK0Mhj
    +/7P8dxgmgVE5mCkjjCCm+iVK7p13Zw+DN3kfRDo6ML3hPgWS3sv/1UKdWbKk+qG
    SW6jsxbLsvMv6ejEBHOQBjVTz8PvPjLCGFgmCUcOXUVUGpaJH3KHSsZojwDqr6tg
    Z143LUFmqn9vBaeOQLbglXsR7YnZZTyFlr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524490132; bh=uW4iV
    u2HKXu1HmZ5Fz8t7RCWjFhBYuCzz6bACL+A0iQ=; b=qC22kzW6NtQU+1gYdv8o3
    i7pp9R7jOdqTaQiRsj7i8QYVT1MbdRp/s7FfcvOGxcuNobSCOxBgroBQX5Y4Iupp
    Vl2xBPqpaBhRPLwjIOTzc/TcNqd5XrvCJbvb9WkVdYd12xLIikHzv9olfYdW99JG
    1Dc7NJlprPm3/kz29U0Z422KZqVnvCl/sgp1oGHuqNjXnj1GySYhXcQROx7QBH1O
    v/BCxWXrVg853iU39D8N+8ceosiE7ior2Mii1tYBH/i/sOYy0i5MoraSkjiNkIUZ
    hOUY4IRpBYtxQ/nbHpKAzArYsRnIqFBAjQaJAnvOEXHHwNhQPwKRqAYHl5JEs9Ki
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=BJ/rmIbK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=V+nTnIqA;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=android.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=BJ/rmIbK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=V+nTnIqA;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=android.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK5F9sJcANguPeIdTvRYgNWtDdl3eLRiIoX0nHvAXirCRcfQuT372RCr7yDtk6PuGXb6G0nU+N2b/gnNohcO6jqzf5NdlmkAg32s5t99XcXto3RJXXYl
    ARf5pgV2SRE51qe4CoKqABtdf+zFCjA8aF2FAiaYA2U0mM+ulzp9GNlIy8HY0gJR+LMvNqvOMlhLoDRYh4IKrA3zkqN8TfV5Qgq+CR8Sv/tHXKww6YygqEsH
    68YFwTXXb5VE2b88dwfrpw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=1XWaLZrsAAAA:8 a=DDOyTI_5AAAA:8
    a=fpqpq2FpH9ywAy5BFSwA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZoIo9pGSEQkF7ALRiYHuvfwe6lpGbXEh55keppfD32Ymes7J/ZrPtbKn9GtWoeRO7xgcvBWcq2zKiiJAS/OhEc=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YBGFBuMFUXYgOPCStfvAMNqxHmK_51zYev6GS-PmkcCw@mail.gmail.com>
References: <001a113f8f14113e790568fd0c02@google.com>
 <20180419213517.GA13221@gmail.com>
 <CAB0TPYGC_e9FZfDzVRQEJbjB7HfRvHZ+TUGAySzhOT3AHUUq8w@mail.gmail.com>
 <CACT4Y+YcODNPLzx5Zjjswz4mCcoootVQQGgwfsta+f8Vxn0RUA@mail.gmail.com>
 <CAB0TPYHLxjfmisvmVLOw+6XjV+mt=buZPJFCpg44JZpGimjLjw@mail.gmail.com>
 <CACT4Y+Y6cOgF4+TnFuU6NO8-ycpmo5=Ma-Dg+nAp71iTK64-Lw@mail.gmail.com>
 <CAB0TPYGxrDF+egw9GUXhWaDnj6wkH8gKd=htyujUH4jzwSE8zA@mail.gmail.com>
 <CACT4Y+YBGFBuMFUXYgOPCStfvAMNqxHmK_51zYev6GS-PmkcCw@mail.gmail.com>
From: Martijn Coenen <maco@android.com>
Date: Mon, 23 Apr 2018 15:28:42 +0200
Message-ID: <CAB0TPYGQz1Dz4=bQy9KOXZbp+Z+t6S_2Fkv2SOnvYLexMnRefw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in binder_release_work
To: Dmitry Vyukov <dvyukov@google.com>
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

On Mon, Apr 23, 2018 at 12:17 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> syzbot does not extract this info from patch emails.

Ok so IIUC, Reported-By tags will only be considered when they are
actually part of commits in one of the tested trees - makes sense. So
does sending "#syz fix: xyz" cause syzbot to look inside all the trees
it analyzes for xyz and mark it as closed if found? Does it look
immediately or on some schedule, and does it retry? In this case, I
think my patch wasn't in any tree yet when you sent "#syz fix", only
in Greg's queue (Greg actually pushed it half an hour after your
message). Just want to make sure I do the right thing next time.

Thanks,
Martijn


> First of all, it's not possible to discover them all.
> Second, a mailed patch does not mean committed patch. v2 can be resent
> and potentially change title too.
>
> syzbot takes this info from commits in the tree it tests. It probably
> could extract some emails from the commit. But they can come months
> later, so their value will be questionable. Also consider that 2
> commits in different trees mention the same bug. syzbot generally
> overwrites old info with new info, because that's the only way to fix
> up things. Now this can lead to infinite stream of emails saying that
> this commit fixes this bug, no that commit fixes this bug, no this
> commit fixes this bug, etc.
> Also consider that a bug is first marked as fixed with some commit,
> bug later is marked as dup of another or re-marked as fixed with
> another commit. You won't get a notification, because the whole
> sequence looks reasonable.
> This can also lead to problems when commits backported to
> android/chromeos trees that syzbot also tests. There these fix tags
> look plain bogus because they reference upstream bug, not
> android/chromeos bugs.
>
> By default we try to keep syzbot silent and non-spammy. And we do not
> seem to have lots of such cases where things are somewhat messed. And
> in all cases it should come to eventual consistency. If something is
> marked as fixed prematurely, syzbot will open another bug. If
> something is not marked as fixed (or marked as fixed with a
> non-existent commit), then these bugs still hang on the dashboard and
> visible.
>
>
>>>> Thanks,
>>>> Martijn
>>>>
>>>>> Now syzbot already skips list_del frame and takes the next one, so it
>>>>> should become slightly better.
>>>>>
>>>>> Let's close this one with the binder fix (since that one was closed
>>>>> with an rdma fix):
>>>>>
>>>>> #syz fix: ANDROID: binder: prevent transactions into own process.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

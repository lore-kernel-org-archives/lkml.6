Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-906599-1524477018-2-4159396122294566848
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
    1524477017; b=WBPISYXQJAGuGklrZgHdTHHvPJqTdhp4ar8ER0htV79RQL7X0y
    KUx/R3Ps/+gA7Ie3b2/uAPmEz16stFcuaF2DjL5xwgUJl/8K+FsRDufRuVtynhC/
    009eNHvhnIbdyFV6PDGIpiIPf5OqBqSX5NxQqQERul/L5TRoB7MsUvkG8/ca1vH9
    yi6YTWS+160ar09BrMdTJQuQAQeGbOOurEjVl+FNcH85eMnltm7x2JjBPamr2aj4
    yjXyNpS2p/hRKDb1yzOf06pnXDDWtYEzOfmuKGvlYW/HhyuwAVdhiiBpf0FyQSs7
    DywSHz3Fm4w9f0UdV8/FenAFKjZvd4oO/cvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524477017; bh=iE0Yl
    GL2nzQ+fk8R1UhnVIw4IKMeDd+phtPL+XwFsiw=; b=NkgQ56DVpKELZ2cpCsbXQ
    KstoybbvZY0Z/+qp4or+b9f3U48oCcAVpKNDvnx2tgcE9owoCF/cGRF5yfxMaBUH
    WKaI2/Pxm++Pu9IC1iNt3twwit6A/ynkACqulNrCCIAf1hZRi0WdFVlQOI+M94eF
    BFMb1dj6tGVmqtsR09YWGGDKTu3oAVMQDpQwsra1CUxqitiSnJOmjYPo32rR4deb
    BCQAOs1bdsg4jWkjVP8vBHp+p4KwuiHWaQ+necfMR8ju2Llo/UQwWyn0aBzV8+Tc
    Q9wOLr6woikb2OLLzt7vrsMPoB8R6MBWiE7lvN2QX9tgYFzzO44ZcoSlvXuzwlg7
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=Dp+qcZba x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pcJeQxfT;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-51 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=Dp+qcZba x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pcJeQxfT;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJysZRd6/t7kgWtCYHo0qXnSDoY+ifjNXmpKWq7ejbfyBMTE9yS3h4JngDfGlMUHoZepGc3TwdFbG3YRj2akIXj7eDzMbPT1nlqb5TpAdaZ3WhYciap0
    mzwSJzHF4POMcFTUHSRE8u+VvNJKO2H/PwGjQzH/dX10aoxVCg1U/M1GHH+J6GrigC63IO/y5xflFXcgRkoY5lN8ByLi4ZRCpMM/RC/ImMNX95VBB3gSftaR
    +k57Pd63IAv3iShsDg8vcA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=n8i27M1mAAAA:8 a=1XWaLZrsAAAA:8
    a=edf1wS77AAAA:8 a=DDOyTI_5AAAA:8 a=YeVlOlqBlQrkwOXfYDYA:9 a=CjuIK1q_8ugA:10
    a=DcSpbTIhAlouE1Uv7lRv:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx49kQULK0WaMpCpyFUEm7/kQXxDDaWfDkM77JFBLFwvKdMhOjZX+UHbrAsgB4Pwp2Xaf3vn4ePH9bjW+JYRyjp8=
MIME-Version: 1.0
In-Reply-To: <CAB0TPYHLxjfmisvmVLOw+6XjV+mt=buZPJFCpg44JZpGimjLjw@mail.gmail.com>
References: <001a113f8f14113e790568fd0c02@google.com>
 <20180419213517.GA13221@gmail.com>
 <CAB0TPYGC_e9FZfDzVRQEJbjB7HfRvHZ+TUGAySzhOT3AHUUq8w@mail.gmail.com>
 <CACT4Y+YcODNPLzx5Zjjswz4mCcoootVQQGgwfsta+f8Vxn0RUA@mail.gmail.com>
 <CAB0TPYHLxjfmisvmVLOw+6XjV+mt=buZPJFCpg44JZpGimjLjw@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 23 Apr 2018 11:49:48 +0200
Message-ID: <CACT4Y+Y6cOgF4+TnFuU6NO8-ycpmo5=Ma-Dg+nAp71iTK64-Lw@mail.gmail.com>
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

On Mon, Apr 23, 2018 at 11:41 AM, Martijn Coenen <maco@android.com> wrote:
> On Mon, Apr 23, 2018 at 11:28 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> https://syzkaller.appspot.com/bug?extid=09e05aba06723a94d43d
>> and that happened in binder. But then syzkaller found a reproducer for
>> it, but it turned out to be in rdma subsystem. It's generally not
>> possible to properly distinguish different bugs that look similar, and
>> if syzbot does more sensitive bug classification, then it will also
>> inevitably report more duplicates. So that bug was closed as an rdma
>> bug.
>
> Thanks for the clarification! It looks like I sent the patch with the
> original reported-by tag after it was closed as an rdma issue; would
> it help if syzbot sent a reply saying this bug was already marked as
> closed with a different commit, or are there other complications with
> that?


Since it's already in Greg's queue, it's not worth bothering. We can
fix up things here with these "#syz fix" tags in emails, which
associate fixes with bugs.


> Thanks,
> Martijn
>
>> Now syzbot already skips list_del frame and takes the next one, so it
>> should become slightly better.
>>
>> Let's close this one with the binder fix (since that one was closed
>> with an rdma fix):
>>
>> #syz fix: ANDROID: binder: prevent transactions into own process.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

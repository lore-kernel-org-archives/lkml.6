Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-906599-1524477224-2-15547094624454047648
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524477223; b=PDO9fivTVtfgctTbg1+HnTGX41ZwnK7t7NMFJtApy9isD4OE/7
    yKQIOBnuIJjh/uTFuZ1bBtXVCMNY+pzcZVTxG3Xtv53Y6ozFbNFZ4k056nIyiJys
    4fPrV4P+8X0AOA4nIz8AF0rm60C9Lg62qFWgf66PwFDLIoC8u/Aol8en2AmRcGH3
    BvarU1Jlw4QxFCJ4wmNv63h/WYdTfWS+CVdYNob5IgwmyoNn138Tsow2ZPhV2Jso
    kyNHuiBYOY6BbvdnfUJY0MiYqAv8sceGJCV1t6N8LAuvOEt5mAaq48TklbxHz1fN
    LNxMq+OTc9rp/Mlj3XmkVqWEEnsOFy+Lv19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524477223; bh=+Z/6y
    Gyxe6uo/0Y/BooK8UGlPn3pEzyCtFH6E1995qo=; b=qNg2K8fjbiYn42Rma89lq
    62XkHuv1eCuGwUO+K2zmTjSwdyCM7ja8xdvuxIOOt9xg8t8v937zf+7jvtc1wm6m
    IwDMl9JupPLjjp1idZbuLppz4JcCRR7SKIR/cyv/XlXxNR/pUk9sYKknK3ktwROs
    zT9CmMXUr0Wjp9qlNdxbtYaNXn9H2u21CPDfprYscnnTtTQ5cZDgG670rSMU80Gr
    Aeduc/4hvg4wQa0sqKq8kCTMOhFKrDD6hwjvoo3W44/G72pdTadJcJT8/StuGRtB
    sevEOMItVibWO1MSmrUnHfwy2U3ycBLRzmqZ7jflgSpWZ3Xx1d9sIIT8tEil4960
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=uPLDicD+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RrgrP0gH;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-51 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=uPLDicD+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RrgrP0gH;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDBvioyi0Icg+8PEKvkZTAF0c3npugf/80P2urH9WQvryoH2Aa5HIzBPCtD4rYhqqKTjSjs4I65D6+i439fIspw85VWRMPcU9yUrdXAPiJcCTw2FUHD3
    9DmMzwaWtOkE6/mtxBlHBp6UKNlqHCtgEFFm7Ird2ETfFTTfhnP6SgRMJc8pf0Z8zsq2LP/CCMn29AEM027w05g378+PnfagcIn5h3xpJZ7gmYKfj0t6dulz
    80hnxVE+k67402Icsl4rUg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=n8i27M1mAAAA:8 a=pGLkceISAAAA:8
    a=VwQbUJbxAAAA:8 a=edf1wS77AAAA:8 a=DDOyTI_5AAAA:8 a=McXQqNo9DkWpZnTR23cA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=DcSpbTIhAlouE1Uv7lRv:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+BX81fWW9ol61OwkIx1NGX7WVvtwGqXDBHWd4juXE9nr43LNtgPEb3cLlWSk7c0A29dz+R7eVjr43ybfTV5Yk=
MIME-Version: 1.0
In-Reply-To: <CAB0TPYGC_e9FZfDzVRQEJbjB7HfRvHZ+TUGAySzhOT3AHUUq8w@mail.gmail.com>
References: <001a113f8f14113e790568fd0c02@google.com>
 <20180419213517.GA13221@gmail.com>
 <CAB0TPYGC_e9FZfDzVRQEJbjB7HfRvHZ+TUGAySzhOT3AHUUq8w@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 23 Apr 2018 11:28:27 +0200
Message-ID: <CACT4Y+YcODNPLzx5Zjjswz4mCcoootVQQGgwfsta+f8Vxn0RUA@mail.gmail.com>
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

On Mon, Apr 23, 2018 at 11:18 AM, Martijn Coenen <maco@android.com> wrote:
> On Thu, Apr 19, 2018 at 11:35 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
>> Martijn, this is going to be fixed by
>> https://patchwork.kernel.org/patch/10312345/
>> ("ANDROID: binder: prevent transactions into own process"), right?
>> The syzbot bug ID in that patch is for a bug that is already closed,
>> so if it's not too late you should use this one.
>
> Yeah that should fix it. Why was it closed? I think the syzbot bug ID
> I used in that patch was from the original report to LKML. Greg
> mentioned the patch was already in his queue.

Hi Martijn,

In short: too many bugs in kernel + long turnaround time for fixes.
Originally it was detected as "KASAN: use-after-free Read in
__list_del_entry_valid (3)":
https://syzkaller.appspot.com/bug?extid=09e05aba06723a94d43d
and that happened in binder. But then syzkaller found a reproducer for
it, but it turned out to be in rdma subsystem. It's generally not
possible to properly distinguish different bugs that look similar, and
if syzbot does more sensitive bug classification, then it will also
inevitably report more duplicates. So that bug was closed as an rdma
bug.
Now syzbot already skips list_del frame and takes the next one, so it
should become slightly better.

Let's close this one with the binder fix (since that one was closed
with an rdma fix):

#syz fix: ANDROID: binder: prevent transactions into own process.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

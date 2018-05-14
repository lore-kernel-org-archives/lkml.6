Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1405515-1526330235-2-16304293191190533949
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
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
    1526330234; b=kAX6PM7uTzObCjJuQQS4p6/COO5EabbJsNBrctNp6TN6eT7zIN
    Ve9UJQbGxXiSrdV/haOvWq3ya/Xo9Sc3kT+dUwuWWScYrGRKg021ZT2B1+91ohcj
    T+QK73l812XlRMIVz9e7GWKpGZCCYy0mxlhrmtWA/XVxhQ5797s9hr4hS54syaR/
    l6yg4DAmkShvjFHgOagkRu+YewnRnsb7gzGDQAL+KbfLT4JE3KWf4bsq9HuhYwjN
    seSxETli+NtLEXrXT1ZShr8WYYZDZVVdtZ7DSmRWCeW4cpe18/gS8k1PPNPzxMwh
    0tGS4rppMEWaoh1rG+Hud6VKN4C0qY57KWug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1526330234; bh=rRJlslS+Z7rSev0sktmLcMBQISXWvfjLxAi7RttaBv0=; b=b
    WXjEWEU55zLq3dYtrVthoti5t4Sgf9YTggn21f1uUSvZJhqllxTPDc8V5cQqYVX5
    2ish9Ka+EqsamkK72aIUHdBzoGUT435B40fG2MJ6qmbQswMlamndQzLaHXJJIh8P
    vKiuP51wHdfoIV7asFHuimN3CY8i/KnlIH+/U+wYdDTOgiZoLC9BMJXOvtlkncxt
    5V25hsasNU37Al65l8TsHxsdm9jnaqj5czJv16vsO+vcAWqAFJHuJW3eqxnB67tI
    O4ucBOi8+j4A4jKkGXDXpMYAsPQsTIj9wavBSMbSzItExIRBmEG6syAfrcgVoGNC
    G9ypPCkSNBWRj01C9XW/Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=YChgpNv3;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=redhat.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-51 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=YChgpNv3;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=redhat.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP6VGIlL/apicsgjYEVFEXres6iNZgZdaVOiQfRX/Wk/LmUG1ENOHj9v2bk498SmvDksRv6D/jCwYAlE2O9cEHQ7UeadpFPbX5pMFMIUO0G3VfOUJrEz
    qOr5TwuLiYzLJrC7wTDn45+Dk21eN7wKHnr2V85Ps9meRlyvOu1cnpD7ZSIiI9aSpW851nGlHpk3Q444Rg6fyrEXSVmOCB4PpmTVliTVoFcqRjmOe8tUobel
    iDtLVyusylFy6cKi9czwKw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=4_-BN3WEXhEA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=aD1W39H_AAAA:20 a=hSkVLCK3AAAA:8
    a=DDOyTI_5AAAA:8 a=qAwoOFCS0FheIpX7DygA:9 a=CjuIK1q_8ugA:10 a=W7bAngp8pZcA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=cQPPKAXgyycSBL8etih5:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZrI2os3sHjbJfsJbYev++0MygMWwdUxG9Lov8TdhCMcOtg6I/Pch4ft/b4vW8FkoWayHdQkTQ==
Subject: Re: WARNING in ion_buffer_destroy
To: Dmitry Vyukov <dvyukov@google.com>
References: <001a1144928eca24f605625fd8f9@google.com>
 <ee1d01fc-a6a4-9480-9755-b6f25304d08b@redhat.com>
 <CACT4Y+b2Q86dQxsd9_9casAsE9jE8ef87E9WEdKFCYxLkT0Z8A@mail.gmail.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <70de9c10-d7ce-a95b-1bf1-724f9dacaa8c@redhat.com>
Date: Mon, 14 May 2018 13:37:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+b2Q86dQxsd9_9casAsE9jE8ef87E9WEdKFCYxLkT0Z8A@mail.gmail.com>
Content-Language: en-US
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
 Todd Kjos <tkjos@android.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
 syzbot <syzbot+cd8bcd40cb049efa2770@syzkaller.appspotmail.com>,
 Martijn Coenen <maco@android.com>, Sumit Semwal <sumit.semwal@linaro.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/09/2018 11:59 PM, Dmitry Vyukov wrote:
> On Wed, Jan 10, 2018 at 7:14 PM, Laura Abbott <labbott@redhat.com> wrote:
>> On 01/09/2018 02:58 PM, syzbot wrote:
>>>
>>> Hello,
>>>
>>> syzkaller hit the following crash on
>>> 06d41862286aa7bc634a1dd9e6e7e96f925ef30a
>>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
>>> compiler: gcc (GCC) 7.1.1 20170620
>>> .config is attached
>>> Raw console output is attached.
>>> C reproducer is attached
>>> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
>>> for information about syzkaller reproducers
>>>
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+cd8bcd40cb049efa2770@syzkaller.appspotmail.com
>>> It will help syzbot understand when the bug is fixed. See footer for
>>> details.
>>> If you forward the report, please keep this part and the footer.
>>>
>>> audit: type=1400 audit(1515538424.230:7): avc:  denied  { map } for
>>> pid=3499 comm="syzkaller239906" path="/root/syzkaller239906633" dev="sda1"
>>> ino=16481 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
>>> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
>>> WARNING: CPU: 0 PID: 1467 at drivers/staging/android/ion/ion.c:122
>>> ion_buffer_destroy+0xd4/0x190 drivers/staging/android/ion/ion.c:122
>>> Kernel panic - not syncing: panic_on_warn set ...
>>>
>>> CPU: 0 PID: 1467 Comm: ion_system_heap Not tainted
>>> 4.15.0-rc7-next-20180109+ #92
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>>> Google 01/01/2011
>>> Call Trace:
>>>    __dump_stack lib/dump_stack.c:17 [inline]
>>>    dump_stack+0x194/0x257 lib/dump_stack.c:53
>>>    panic+0x1e4/0x41c kernel/panic.c:183
>>>    __warn+0x1dc/0x200 kernel/panic.c:547
>>>    report_bug+0x211/0x2d0 lib/bug.c:184
>>>    fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>>>    fixup_bug arch/x86/kernel/traps.c:247 [inline]
>>>    do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>>>    do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>>>    invalid_op+0x22/0x40 arch/x86/entry/entry_64.S:1079
>>> RIP: 0010:ion_buffer_destroy+0xd4/0x190
>>> drivers/staging/android/ion/ion.c:122
>>> RSP: 0018:ffff8801d3a9fd28 EFLAGS: 00010293
>>> RAX: ffff8801d39ee700 RBX: ffff8801c00e57c0 RCX: ffffffff8415d2a4
>>> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8801d5ada5b8
>>> RBP: ffff8801d3a9fd50 R08: 0000000000000000 R09: 1ffff1003a753f8a
>>> R10: ffff8801d3a9fc18 R11: 0000000000000000 R12: ffffffff86e4c980
>>> R13: ffff8801d5ada580 R14: ffff8801c00e57e0 R15: 0000000000000001
>>>    ion_heap_deferred_free+0x290/0x650
>>> drivers/staging/android/ion/ion_heap.c:236
>>>    kthread+0x33c/0x400 kernel/kthread.c:238
>>>    ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:524
>>> Dumping ftrace buffer:
>>>      (ftrace buffer empty)
>>> Kernel Offset: disabled
>>> Rebooting in 86400 seconds..
>>
>>
>> This is catching that a buffer was freed with an existing kernel
>> map still present. The problem is this can easily be triggered from
>> userspace by calling DMA_BUF_SYNC_START without calling
>> DMA_BUF_SYNC_END. It's clearly not appropriate for userspace to
>> be able to trigger a warning so I'll see about switching this to
>> a pr_warn_once.
> 
> Hi Laura,
> 
> Any updates on this?
> 

I thought I had sent a fix for this but I guess not. I'll see about
getting one out.

Thanks,
Laura
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

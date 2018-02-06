Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeBFO25 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:28:57 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:39745 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeBFO2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:28:49 -0500
X-Google-Smtp-Source: AH8x224ZshxTZpGGTJRJ+sheSTSd85dZKLSwAb91E8C1IoBHrlEnjnKXhvmWA3k+0DeApu+y6CdSeXTi8MXaB+jOFIA=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z4iABWdprJ=WbCM_XqgXo=1=Hm_gwaF64nD-oRuezAjg@mail.gmail.com>
References: <94eb2c0555129c9b0e05647acdba@google.com> <20180205194101.GB7593@avx2>
 <CACT4Y+Z4iABWdprJ=WbCM_XqgXo=1=Hm_gwaF64nD-oRuezAjg@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 6 Feb 2018 15:28:28 +0100
Message-ID: <CACT4Y+bWzPydvGf264jnqg7jqPzsL5+by+hYVR1nMR=ffweWEg@mail.gmail.com>
Subject: Re: WARNING in proc_register
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: syzbot <syzbot+75334212ef69a07c3209@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Howells <dhowells@redhat.com>, geliangtang@gmail.com,
        hkallweit1@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Takashi Iwai <tiwai@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 2:53 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, Feb 5, 2018 at 8:41 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>> On Mon, Feb 05, 2018 at 09:58:01AM -0800, syzbot wrote:
>>> proc_dir_entry 'ipt_CLUSTERIP/172.20.0.170' already registered
>>> WARNING: CPU: 1 PID: 4074 at fs/proc/generic.c:330
>>
>>>   proc_create_data+0xf8/0x180 fs/proc/generic.c:494
>>>   clusterip_config_init net/ipv4/netfilter/ipt_CLUSTERIP.c:250 [inline]
>>
>> Dima, this warning is never about /proc but always about some other code
>> registering duplicate /proc entry.
>>
>> I don't know how easily scriptable is mail sender but you want to look at
>> the second line in the backtrace.
>
> Hi Alexey,
>
> This is now fixed with:
> https://github.com/google/syzkaller/commit/645ce5da79c9654c314f0d12f4c11f2a94ec156b
> In particular tests for this report:
> https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/181
> https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/guilty/30
>
> Thanks for the suggestion.

As the result this now reappeared as "WARNING: proc registration bug
in clusterip_tg_check":
https://groups.google.com/forum/#!topic/syzkaller-bugs/gkFWUsDo0gw

#syz dup: WARNING: proc registration bug in clusterip_tg_check

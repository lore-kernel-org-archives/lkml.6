Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeBFNyW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 08:54:22 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34307 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbeBFNyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 08:54:12 -0500
X-Google-Smtp-Source: AH8x224HzFTSniz6IX0p2yntHqs92jKSNMOsxHXzBRZZnIf1n2FJehz25OswHRK1B9QOIfvCdNuikfGFQImr95c1wAo=
MIME-Version: 1.0
In-Reply-To: <20180205194101.GB7593@avx2>
References: <94eb2c0555129c9b0e05647acdba@google.com> <20180205194101.GB7593@avx2>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 6 Feb 2018 14:53:50 +0100
Message-ID: <CACT4Y+Z4iABWdprJ=WbCM_XqgXo=1=Hm_gwaF64nD-oRuezAjg@mail.gmail.com>
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

On Mon, Feb 5, 2018 at 8:41 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Mon, Feb 05, 2018 at 09:58:01AM -0800, syzbot wrote:
>> proc_dir_entry 'ipt_CLUSTERIP/172.20.0.170' already registered
>> WARNING: CPU: 1 PID: 4074 at fs/proc/generic.c:330
>
>>   proc_create_data+0xf8/0x180 fs/proc/generic.c:494
>>   clusterip_config_init net/ipv4/netfilter/ipt_CLUSTERIP.c:250 [inline]
>
> Dima, this warning is never about /proc but always about some other code
> registering duplicate /proc entry.
>
> I don't know how easily scriptable is mail sender but you want to look at
> the second line in the backtrace.

Hi Alexey,

This is now fixed with:
https://github.com/google/syzkaller/commit/645ce5da79c9654c314f0d12f4c11f2a94ec156b
In particular tests for this report:
https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/181
https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/guilty/30

Thanks for the suggestion.

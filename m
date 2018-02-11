Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753682AbeBKTS5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 14:18:57 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:44340 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753099AbeBKTSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 14:18:55 -0500
X-Google-Smtp-Source: AH8x226fnJAwapYgSIty7GY6I1/45oa61qt8cxZAyYE4JcIpJVZIKRrHRLQvwwF6BLkOt+m6niIY0V7DwC5VuWU7X1s=
MIME-Version: 1.0
In-Reply-To: <CAADnVQJnobUCg4ZEkHUgAAMXiw5w1K1DLqo09005mPPgOuLD+g@mail.gmail.com>
References: <CA+7wUsyxpHnq_POujjwEVXhJjE5GRLN9GypV+63g1OFmfq=_ZA@mail.gmail.com>
 <CAADnVQJnobUCg4ZEkHUgAAMXiw5w1K1DLqo09005mPPgOuLD+g@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Sun, 11 Feb 2018 20:18:34 +0100
X-Google-Sender-Auth: 3H1_aPHpCiWQ2v6A5TlT_GM8rFM
Message-ID: <CA+7wUswo-XwiMEcSTnB3HQE6qo2YUJxeSNije3KtFoy6CqzQoQ@mail.gmail.com>
Subject: Re: [kmemleak] unreferenced object 0xcd9c1a80 (size 192):
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 11, 2018 at 5:54 PM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Sun, Feb 11, 2018 at 7:24 AM, Mathieu Malaterre <malat@debian.org> wrote:
>> Alexei,
>>
>> Could you please comment on why I am seeing those memleaks being
>> reported on my ppc32 system ? Should they be marked as false positive
>> ?
>>
>> System is Mac Mini G4, git/master (4.15.0+), ppc.
>>
>> Thanks for your time
>>
>> $ dmesg
>> ...
>> [ 1281.504173] kmemleak: 36 new suspected memory leaks (see
>> /sys/kernel/debug/kmemleak)
>>
>> Where:
>>
>> # cat /sys/kernel/debug/kmemleak
>> unreferenced object 0xdee25000 (size 192):
>>   comm "systemd", pid 1, jiffies 4294894348 (age 1438.580s)
>>   hex dump (first 32 bytes):
>>     c0 56 2f 88 00 00 00 00 00 00 00 0b 00 00 00 0c  .V/.............
>>     00 00 00 08 00 00 00 01 00 00 00 01 00 00 00 01  ................
>>   backtrace:
>>     [<6c69baf5>] trie_alloc+0xb0/0x150
>>     [<fa093284>] SyS_bpf+0x288/0x1458
>>     [<82182f53>] ret_from_syscall+0x0/0x38
>> unreferenced object 0xdee25900 (size 192):
>>   comm "systemd", pid 1, jiffies 4294894540 (age 1437.812s)
>>   hex dump (first 32 bytes):
>>     c0 56 2f 88 00 00 00 00 00 00 00 0b 00 00 00 08  .V/.............
>>     00 00 00 08 00 00 00 01 00 00 00 01 00 00 00 01  ................
>>   backtrace:
>>     [<6c69baf5>] trie_alloc+0xb0/0x150
>>     [<fa093284>] SyS_bpf+0x288/0x1458
>>     [<82182f53>] ret_from_syscall+0x0/0x38
>
> hmm. looks real. Is there a reproducer?
> Yonghong, lpm map not cleaning after itself?

Not really. I simply boot up my machine and wait for the first kmemleak scan.

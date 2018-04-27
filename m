Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758707AbeD0QG6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:06:58 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:37638 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758694AbeD0QGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:06:53 -0400
X-Google-Smtp-Source: AB8JxZqbmZKFJUEW4gjQZ/p0AqYdr7/Zl38b460z2YWWh0/4QC5TSpr79ojHuSb/AxpZKe7aA521lWXxxmJhq9ggo5g=
MIME-Version: 1.0
In-Reply-To: <20180427154115.GF15229@pd.tnic>
References: <CACT4Y+Ys9bKFNaBm7YuCvk04jcZ2SnLiDSxgCojZMwtb2PKVBg@mail.gmail.com>
 <20180427154115.GF15229@pd.tnic>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 27 Apr 2018 18:06:32 +0200
Message-ID: <CACT4Y+bptixoADW1cLtJzbJcHfmEAuLyBSnK9txb6u69fZ3n6w@mail.gmail.com>
Subject: Re: stack out-of-bounds write in mce-inject.c
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-edac@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 5:41 PM, Borislav Petkov <bp@alien8.de> wrote:
> On Fri, Apr 27, 2018 at 05:24:24PM +0200, Dmitry Vyukov wrote:
>> Hi,
>>
>> Opening /sys/kernel/debug/mce-inject/flags overwrites stack:
>>
>> ==================================================================
>> BUG: KASAN: stack-out-of-bounds in vsnprintf+0x1b23/0x1b40 lib/vsprintf.c:2365
>> Write of size 1 at addr ffff8800627b7abb by task egrep/4309
>
> How do you trigger this exactly?
>
> You grep it for something apparently...


find /sys -exec grep "64" {} \; -print

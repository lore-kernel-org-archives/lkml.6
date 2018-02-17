Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751032AbeBQBj7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 20:39:59 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:46496 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeBQBj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 20:39:57 -0500
X-Google-Smtp-Source: AH8x224mt/3gVp4SYvzo7DnPTDgp/vGlAHs1nFVIALKisDofhLEpf8pFWdsXV/EXo16MlV8uBDcUgBUwkRw3+AmS6+M=
MIME-Version: 1.0
In-Reply-To: <20180216130229.f3de3aced0c87fe31ad92000@linux-foundation.org>
References: <1518752264-47238-1-git-send-email-keescook@chromium.org>
 <1518752264-47238-4-git-send-email-keescook@chromium.org> <20180216130229.f3de3aced0c87fe31ad92000@linux-foundation.org>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 16 Feb 2018 17:39:55 -0800
X-Google-Sender-Auth: OrB6QFr27veLl5zY3Rez93n4AQ4
Message-ID: <CAGXu5j+-6RUATczWB=Sb7pPw0kimv48bDZhgvL3kWwyggQ1fbA@mail.gmail.com>
Subject: Re: [PATCH 3/3] taint: Add taint for randstruct
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 1:02 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Thu, 15 Feb 2018 19:37:44 -0800 Kees Cook <keescook@chromium.org> wrote:
>
>> --- a/Documentation/sysctl/kernel.txt
>> +++ b/Documentation/sysctl/kernel.txt
>> @@ -991,6 +991,7 @@ ORed together. The letters are seen in "Tainted" line of Oops reports.
>>   16384 (L): A soft lockup has previously occurred on the system.
>>   32768 (K): The kernel has been live patched.
>>   65536 (X): Auxiliary taint, defined and used by for distros.
>> +131072 (T): The kernel was built with the struct randomization plugin.
>
> Uncle.
>
>
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: Documentation/sysctl/kernel.txt: show taint codes in hex
>
> The decimal representation is getting a bit hard to follow.

The rationale, AIUI, is that /proc/sys/kernel/tainted prints the
values in decimal. If we change the docs to be hex and leave the
output decimal, that makes it even harder to examine.

If we change the proc output, will we break userspace? And if we
change it, maybe avoid numbers at all, and proc should bring the same
thing that Oops does (the letter codes)? (But then the sysctl would
need to parse the letters...)

-Kees

-- 
Kees Cook
Pixel Security

Return-Path: <luto@kernel.org>
X-Google-Smtp-Source: AG47ELtb9dDHEEa6jZcAb5UcapIkwZAzjdml1sDhTyFSuwkHE+u0Brwem1jMHRw6pHqy3fgxIY8C
ARC-Seal: i=1; a=rsa-sha256; t=1520734665; cv=none;
        d=google.com; s=arc-20160816;
        b=Av/ldhS6c7ldhiqbZEFQOp5mqieSt58UO/roQBKQopL6rUWSK63diSTjU+fVhYOq2O
         tc+t/nnHKbZXeSEqmafqNQ7HWjIFlz+aIoCaSxl4pPqKyUWo1NZEKA2Xb+oayyyb75uJ
         ZA0DOa5DDRMLvzRYNXQJYmgO7SKflg4ERVnxcKZ7NBCohOenEpiD2CseBeSA3vsmf14f
         6EmNmSU7xTIENC0wkQyQeDO91JFPkyLFUGo0yopZojr+P7ajVfGhhKX9IDmHPQqzPV2J
         /vWmBhrNvyD5OLpLc1ptJHtE5/46LFBNQr6KTb/V0sNuLfH9K4j9wUITiAwXKm4tpbCn
         Eijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=i8o73ohjaDkc5pwABSW19x1B7j90Qe1sXOXnCmqFsgQ=;
        b=maA+pWHz2+LxzP4LnHCVpWreYGd7YLsLSmYf5GZQu12YKTSP3R6IolQSJAN/PshafK
         Q96FLEhgLhmw1SotW3Olq/z2rJLUVDZ2GYYlB+iGYez1cc2t42u9BfXxAh24NqL9hKbh
         D6ozg3ioFNOYVk826xfQEo8kx42dR9evQLydhK6WRiyrXVYlEQl7qOudUZaxjGTbGzcW
         rQ03AMSMD3k2avwPpOJT1ickF5zfLE8miYRs3U10M4UE7+iZ2HO5l6tuafXEVT2DS2xr
         U6quclzIaRB5asXAA+4kHhZxAPqObEWr1zRpqJIX6C7boNLJMjGRQXX293Eu6m0ahlFy
         RXBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6058620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
MIME-Version: 1.0
In-Reply-To: <64a80f5e-25db-5413-ab50-fb122bc22d8c@fb.com>
References: <20180309181527.GA15803@kroah.com> <E622B120-3C3A-4A15-8E1B-6F7649038623@amacapital.net>
 <74e26cc0-9e72-f03b-5396-f3480921f234@fb.com> <20180309.135550.385837861865623769.davem@davemloft.net>
 <CALCETrWYDfByh7=xiO9T7_fFGMwMvZxUu40bkMdO9HE3E6=1VQ@mail.gmail.com> <64a80f5e-25db-5413-ab50-fb122bc22d8c@fb.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Sun, 11 Mar 2018 02:17:24 +0000
X-Gmail-Original-Message-ID: <CALCETrX3AQXNqxXLN3aoEaiUHi6bN39qNJ-A3i_tN=WS_w6N6w@mail.gmail.com>
Message-ID: <CALCETrX3AQXNqxXLN3aoEaiUHi6bN39qNJ-A3i_tN=WS_w6N6w@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: Alexei Starovoitov <ast@fb.com>
Cc: Andy Lutomirski <luto@kernel.org>, David Miller <davem@davemloft.net>,
	Greg KH <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>, Alexei Starovoitov <ast@kernel.org>,
	Djalal Harouni <tixxdz@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Daniel Borkmann <daniel@iogearbox.net>, "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	kernel-team <kernel-team@fb.com>, Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594150201283124044?=
X-GMAIL-MSGID: =?utf-8?q?1594605873047086220?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 1:43 AM, Alexei Starovoitov <ast@fb.com> wrote:
> On 3/9/18 11:37 AM, Andy Lutomirski wrote:
>>
>> On Fri, Mar 9, 2018 at 6:55 PM, David Miller <davem@davemloft.net> wrote:
>>>
>>> From: Alexei Starovoitov <ast@fb.com>
>>> Date: Fri, 9 Mar 2018 10:50:49 -0800
>>>
>>>> On 3/9/18 10:23 AM, Andy Lutomirski wrote:
>>>>>
>>>>> It might not be totally crazy to back it by tmpfs.
>>>>
>>>>
>>>> interesting. how do you propose to do it?
>>>> Something like:
>>>> - create /umh_module_tempxxx dir
>>>> - mount tmpfs there
>>>> - copy elf into it and exec it?
>>>
>>>
>>> I think the idea is that it's an internal tmpfs mount that only
>>> the kernel has access too.
>>
>>
>> That's what I was imagining.  There's precedent.  For example, there's
>> a very short piece of code that does it in
>> drivers/gpu/drm/i915/i915_gemfs.c.
>
>
> I can do "monkey see monkey do" approach which will look like:
> type = get_fs_type("tmpfs");
> fs = kern_mount(type);
>
> /* for each request_umh("foo") */
> file = shmem_file_setup_with_mnt(fs, "umh_foo");
> do {
>   pagecache_write_begin(file,...);
>   memcpy()
>   pagecache_write_end();
> } while (umh_elf_size);
> do_execve_file(file);
> fput(file);
>
> while keeping fs mounted forever?
> is there better way?
>

Nice!  I'm definitely not a pagecache expert, but it looks generally
sane.  Once the thing is actually functional, we can bang on it, and
I'm sure that linux-mm will have some suggestions to tidy it up.

As for the actual lifetime of the filesystem, I think it should be
mounted once and never unmounted.  Whenever it gains a second user,
the whole thing can be moved to mm/ or lib/ and all the users can
share the same mount.

Minor caveat: I would arrange the code a bit differently, like this:

static (or extern) unsigned char __initdata the_blob[];
static struct file *umh_blob_file;

static int __init my_module_init_function(void)
{
 /* for each request_umh("foo") */
 umh_blob_file = shmem_file_setup_with_mnt(fs, "umh_foo");
 do {
   pagecache_write_begin(umh_file,...);
   memcpy()
   pagecache_write_end();
 } while (umh_elf_size);

 /* the_blob is implicitly freed after this returns */
}

and then actually use the struct file later on.  If and when you're
sure you're not going to spawn another copy, you can fput() it.  This
way the memory becomes swappable immediately on load.

As for request_module() vs request_module_umh(), my advice would be to
write the code and then see what interface makes sense.  I wouldn't be
surprised if it ends up making more sense to keep all of this entirely
independent from the module system.

P.S. I suspect that, before this hits a release, someone's going to
have to fiddle with the LSM hooks in do_execve() a bit to make sure
that LSM unconditionally approves this type of umh program.  Otherwise
there might be pointless failures on some more locked down
configurations.  But that can wait until it's more final and the
security folks review the code.

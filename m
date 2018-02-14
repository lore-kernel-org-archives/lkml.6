Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518574714; cv=none;
        d=google.com; s=arc-20160816;
        b=bnwt9kixL0B5mKZrS/RZBY3IDbFj3BscZlkvOlucmQvItf/9MPYOeI5bvv3/WvhT9+
         Dscy4kFLAJrHOftXKRGnwDebmKOcKHYuFNALNJrZYAcXB9DF3L05gimadKs7NT2Sa3FP
         aKaogkLBuN3CGY91AwCFIwduST+zja6WrM38lS7/YtMwMZFA9SjSrI6yQ/Z3LOPk3zbX
         fjSpaiUgC8JCMig4lL0OjL7ui4hqNVN51wB+zui+vt4tKWGgBdRAelg3QvIVSHoOTW97
         Sb3JuI7OGuctqVGjNXe5T1KqEOHf/jnctwKJGOdge5pb9yeELwMNR6U9jJQLDnOLgzc8
         c3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:sender
         :dkim-signature:arc-authentication-results;
        bh=zlUxYOYtkptEZQZQRr9c4KqMzb/Ji3mmHtdOjFIT6sA=;
        b=LGgDdvuksgKEGO75sYhz+XZz7X8rSGgJIHDhD+/sqnVPiuU9mDhfk5ItuSAnLFsYnZ
         xGlcD3rXTVArC9sICHxIFQF9q4JJUv/n1Y9ZxsXhcD3V9CtALf1uWbHj5SuLUOkYyFUE
         gG/c+0fGSEvN7M1Z/H89XMicL7aC6NKAoWbH6h5SZlQzAKW9Np5TAKCTlxvJ9OPy1d/X
         ugfkjB0b9xMPuRHHdVygLqWSzZDbnub59FJpAOZ77H68WEPlZWghOyJLmer2ipMwFznI
         TtDly5EOjxQbyq49PQ01TgaQVTuR20659kPRe52Ug/XCqOB5uvkzMsoq4Rjc9AINzxXN
         lxzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tOQ+fbJw;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tOQ+fbJw;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AH8x227RVV/2vNmlyO9D4Hr/KFK8WJkDuWu3vO/zXvOWCj0MuaLaFofSS/uH1dMtpIUIhJ40z0fvVg==
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2] x86/retpoline: Add clang support
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 gnomes@lxorguk.ukuu.org.uk, Rik van Riel <riel@redhat.com>,
 Andi Kleen <ak@linux.intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 thomas.lendacky@amd.com, Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jiri Kosina <jikos@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
 Dave Hansen <dave.hansen@intel.com>, Kees Cook <keescook@google.com>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linux-foundation.org>,
 Paul Turner <pjt@google.com>
References: <1518040338-9476-1-git-send-email-linux@roeck-us.net>
 <1518042518.3677.153.camel@infradead.org>
 <20180207233211.GA13991@roeck-us.net> <20180213234122.GA10961@roeck-us.net>
 <1518567057.12890.99.camel@infradead.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <97abdb69-9ef5-a0f8-5055-3e9295024c42@roeck-us.net>
Date: Tue, 13 Feb 2018 18:18:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518567057.12890.99.camel@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591780669011927496?=
X-GMAIL-MSGID: =?utf-8?q?1592340999635744184?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/13/2018 04:10 PM, David Woodhouse wrote:
> 
> 
> On Tue, 2018-02-13 at 15:41 -0800, Guenter Roeck wrote:
>> Hi David,
>>
>> On Wed, Feb 07, 2018 at 03:32:11PM -0800, Guenter Roeck wrote:
>> [ ... ]
>>>>   
>>>> See
>>>> http://git.infradead.org/users/dwmw2/linux-retpoline.git/commitdiff/82a1f41600
>>
>> Any chance to see a patch with this change anytime soon ?
> 
> We were waiting for a fix for
> https://bugs.llvm.org/show_bug.cgi?id=36329
> 
> I tested the candidate fix tonight and reported success; the
> corresponding patch is at the top of my tree. Since I think we now have
> a consensus on what the clang build will look like, I'll post that in
> the morning along with the other bits I have ready to send upstream.
> 
Excellent, thanks a lot! That the retpoline.S changes for clang are
no longer required is excellent news.

> We're going to need the percpu.h fix too, and I'd also like to see the
> status of the i915 build failure you mentioned. Is there a bug filed
> for that already, and is it on the blocker list for 6.0? If not, why
> not?
> 
For my part I completely forgot about it :-(. Did you expect me to file a bug ?
If so, I'll need to retest and try to figure out how to do that. Let me know;
I should be able to get that done tomorrow.

Thanks,
Guenter

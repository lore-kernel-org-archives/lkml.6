Return-Path: <arjan@linux.intel.com>
X-Google-Smtp-Source: AH8x224UBYxmzfd43cyxVA3b0wAnIhG5pLwFzsnipMQKaLyuwdsqe+oFfQISXPeuhDTLc+LVLrIE
ARC-Seal: i=1; a=rsa-sha256; t=1518810449; cv=none;
        d=google.com; s=arc-20160816;
        b=QFfxeGrJFZItLdnYus3PG5D/GVVUj43lq0WH/yFRdLIFE5JuA6jKbFuvLY0UmK4ufd
         1ZqRR1Pi6bTe5tXRgvzhS/1WA1hOTukVhCszNrKTkBQLNIgGJwlznsw/UQANpzW25sii
         2Xwe9f1LJdFsvYvQ8iwb0E0mjRHalR6Uxy8v7pZjiclvEzzpoJhrqFfcwsGxG9Y35aNK
         MPMasmcwUjfGRauwB0yb8ERdrr6aoCAReZqy8x9ltScEYIpoyUM34v9EiN1Y8EPOK0EU
         J5PU6Yg7XTAL2q0aDPP8M02CUFnt2VafyCHWI4nwPtC9t6d2Xdz1F8OKvKwU/oNZHxBL
         P+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=rdwh/m07IPZHRS91jU42oWhhqdviohtiHozSq/i2Xro=;
        b=SDIMkjyb4XH+vopwdfT4cKie/zsvLtvnTDHJ7KUCf/JL3aeaCMPWvuYzwqRKeYDpaj
         /gVd9gs+vIFStrbgvGqCfScUbXaxuqcYkjmW4E80OGCfzuIMYW3XXodg2h4ADQzTgpQy
         q1TtuIFCUtObQtjJr1voLV6ZnvQlkbpLiwqWA8BidJZh4PMMpEFNyYCO9rDL2L6eX5KE
         NrJXBF1/a4jNPRo6LzlhzyalE6MBSrRwY6M0YhRP+RSXTK3JvEX3URxW4w7kxff+Bhqo
         RVCaJhmttnMkExVlrcAnbA6TUI6QJjiNs883FVKoEM1YgwxoTZBgmOL/1zvYgeJuoKTi
         Pm3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of arjan@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=arjan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of arjan@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=arjan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="20762629"
Subject: Re: [RFC][PATCH] x86: proposed new ARCH_CAPABILITIES MSR bit for
 RSB-underflow
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
 Rik van Riel <riel@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Peter Zijlstra
 <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Kees Cook <keescook@google.com>,
 Greg Kroah-Hartman <gregkh@linux-foundation.org>,
 Paul Turner <pjt@google.com>, David Woodhouse <dwmw@amazon.co.uk>,
 the arch/x86 maintainers <x86@kernel.org>, Andi Kleen <ak@linux.intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 "Mallick, Asit K" <asit.k.mallick@intel.com>
References: <20180216191755.6F62DDEA@viggo.jf.intel.com>
 <CA+55aFwgxWj95pUxpWL0N0uzHBmyEL7NFveC70ZtJ4ONFX45=Q@mail.gmail.com>
 <CA+55aFyg-uS_hE6f2t5gOrwaCMXErPvGA7tjfhmXZmZOPzi8Ww@mail.gmail.com>
From: Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <768f3a56-28b0-91a1-f555-94e64a146abc@linux.intel.com>
Date: Fri, 16 Feb 2018 11:47:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFyg-uS_hE6f2t5gOrwaCMXErPvGA7tjfhmXZmZOPzi8Ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592586608850569551?=
X-GMAIL-MSGID: =?utf-8?q?1592588185731160718?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/16/2018 11:43 AM, Linus Torvalds wrote:
> On Fri, Feb 16, 2018 at 11:38 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Of course, your patch still doesn't allow for "we claim to be skylake
>> for various other independent reasons, but the RSB issue is fixed".
> 
> .. maybe nobody ever has a reason to do that, though?

yeah I would be extremely surprised
> 
> Who knows, virtualization people may simply want the user to specify
> the model, but then make the Spectre decisions be based on actual
> hardware capabilities (whether those are "current" or "some minimum
> base").

once you fake to be skylake when you're not, you do that for a reason; normallyt
that reason is that you COULD migrate to a skylake.
(and migration is not supposed to be visble to the guest OS)

and at that point you are a skylake for all intents and purposes.

(and the virtualization people also really hate it when the hardware
burst the bubble of this fakeing hardware to be not what it is)

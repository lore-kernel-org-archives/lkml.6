Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525991246; cv=none;
        d=google.com; s=arc-20160816;
        b=wDaI62x/DbN1gEqTBR+uZQuPJ6c+GdRR2UEn2biqQoDDuuZSfhFIdQMYCQcojs1Ckf
         Vx9r+WsusbXoGK8Tf3JV7VdrqR+aob/dfCyMedglc//IoMBNGehppRRczy0bTCwkh8SM
         dKCwq7aeiB6JHJj2N3u4BHcaKt2qBg6UdIOAmxHPi2zvyl4BiHRi1cM3SyUsvLlpI6vB
         UUpzrK+cxO+6B1wwchwB9XrhiI+MeIuX03+BpyYFKJ+yZuWPoJNOPN65O6h3PDAPfI0a
         ejYsuUbuaYVqs3/vnffQXj9wGNkU0JFput3Ubvqu0MW9qpDqTTqNHLG6RdUtbnuc6XyE
         3r0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=G6rMnX+tvSLRYJix03irRAgnekDrzV6HjhD9YB4yyH8=;
        b=lbrSlNBsnW0jp6CRsyfVdO0mW9BVDf7uhkZCaiErOjMVaSm/L2dJ7NWeUPONjURIdN
         FIReHdv8whUmyk6IF6CuuHOj0yP4MDusBRpA8XwMsXLwbhAwnfW4FD5UTdKwuT8vk2cy
         P9JSFhUcEuKZc07CSujSHzzhXP3zMEc+i5GolyG1OsMvQoXriebGJe3Ty54UTzHt3e9m
         DvKZLE+wM5gTKI/BoVuEicS3zOtoSlU2rmP+p0zlQhGyuejEnopAKBu5Il9nWRmgNoP3
         z+eTyr8FwbqqCTKbX63fyEtELCPTNGGaK4hTUDdr7SvTGA6p27uj7x5ymAo9ni4ZfLLn
         mdTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=rtmY7fWX;
       dkim=pass header.i=@chromium.org header.s=google header.b=SIEs7REN;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=rtmY7fWX;
       dkim=pass header.i=@chromium.org header.s=google header.b=SIEs7REN;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZqXSyEFCXGDWgbmJItuTNicHvxL4QI6ad80HPPrjPsbXA6DV/I/DFyWKXf4KEFE8JOc/NgnbxdlOlFK6LFCFxk=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180504195642.GB12838@wotan.suse.de>
References: <20180503043604.1604587-1-ast@kernel.org> <20180503043604.1604587-2-ast@kernel.org>
 <20180504195642.GB12838@wotan.suse.de>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 10 May 2018 15:27:24 -0700
X-Google-Sender-Auth: 6h_gqkXFsy_tnH80Du1A8LUMF30
Message-ID: <CAGXu5j+1p5ccFBjcKa3FDR4cQnbQn3cokbbhrwizoUyAAqFSTQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/4] umh: introduce fork_usermode_blob() helper
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Daniel Borkmann <daniel@iogearbox.net>, Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>, Andy Lutomirski <luto@amacapital.net>,
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	kernel-team <kernel-team@fb.com>, Al Viro <viro@zeniv.linux.org.uk>,
	David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>, Dominik Brodowski <linux@dominikbrodowski.net>,
	Hugh Dickins <hughd@google.com>, Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@linux.ie>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, Peter Jones <pjones@redhat.com>,
	Matthew Garrett <mjg59@google.com>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	linux-integrity <linux-integrity@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599416216881891368?=
X-GMAIL-MSGID: =?utf-8?q?1600117797383898530?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 4, 2018 at 12:56 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> What a mighty short list of reviewers. Adding some more. My review below.
> I'd appreciate a Cc on future versions of these patches.

Me too, please. And likely linux-security-module@ and Jessica too.

> On Wed, May 02, 2018 at 09:36:01PM -0700, Alexei Starovoitov wrote:
>> Introduce helper:
>> int fork_usermode_blob(void *data, size_t len, struct umh_info *info);
>> struct umh_info {
>>        struct file *pipe_to_umh;
>>        struct file *pipe_from_umh;
>>        pid_t pid;
>> };
>>
>> that GPLed kernel modules (signed or unsigned) can use it to execute part
>> of its own data as swappable user mode process.
>>
>> The kernel will do:
>> - mount "tmpfs"
>> - allocate a unique file in tmpfs
>> - populate that file with [data, data + len] bytes
>> - user-mode-helper code will do_execve that file and, before the process
>>   starts, the kernel will create two unix pipes for bidirectional
>>   communication between kernel module and umh
>> - close tmpfs file, effectively deleting it
>> - the fork_usermode_blob will return zero on success and populate
>>   'struct umh_info' with two unix pipes and the pid of the user process

I'm trying to think how LSMs can successfully reason about the
resulting exec(). In the past, we've replaced "blob" style interfaces
with file-based interfaces (e.g. init_module() -> finit_module(),
kexec_load() -> kexec_file_load()) to better let the kernel understand
the origin of executable content. Here the intent is fine: we're
getting the exec from an already-loaded module, etc, etc. I'm trying
to think specifically about the interface.

How can the ultimate exec get tied back to the kernel module in a way
that the LSM can query? Right now the hooks hit during exec are:
kernel_read_file() and kernel_post_read_file() of tmpfs file,
bprm_set_creds(), bprm_check(), bprm_commiting_creds(),
bprm_commited_creds(). It seems silly to me for an LSM to perform
these checks at all since I would expect the _meaningful_ check to be
finit_module() of the module itself. Having a way for an LSM to know
the exec is tied to a kernel module would let them skip the nonsense
checks.

Since the process for doing the usermode_blob is defined by the kernel
module build/link/objcopy process, could we tighten the
fork_usermode_blob() interface to point to the kernel module itself,
rather than leaving it an open-ended "blob" interface? Given our
history of needing to replace blob interfaces with file interfaces,
I'm cautious to add a new blob interface. Maybe just pull all the
blob-finding/loading into the interface, and just make it something
like fork_usermode_kmod(struct module *mod, struct umh_info *info) ?

-Kees

-- 
Kees Cook
Pixel Security

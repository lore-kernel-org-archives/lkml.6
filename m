Return-Path: <kernel-hardening-return-12054-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvzyb7+RBYL/WvtWyfGD3wav/xmTv3GW+VMB7p84ogLFZXvA9JP2s/9y0xEXIhCfNkrcMeL
ARC-Seal: i=1; a=rsa-sha256; t=1519851779; cv=none;
        d=google.com; s=arc-20160816;
        b=nhBGHTzlzMu0Zas6mCxfGJQgZnl5UGaq8d7FuC/xsgloS8g8ken+cWxpyobL449ibU
         jslel491iDcO7LMX6aLGg2U+ATtzrZ6CgtCiCk3/YhIqUztkIcRnM9V8NpXNClfHoRyN
         HBTZE8m8gWhm59YPc7icn17CchZFscPQZMraLRuBuqDeZ97mF3r+hd5vDNeXN06hrEs4
         TyboHzz7BnMf5IU3mPRFfM9M60Q0Xlsq70773kzRW8Wd/QjuWNU25qqaIqz0qqz+c3lW
         yT0OoFH0gdvwQqmrURenEqTRV4f6vKD1tVlkH8U7KIty7N/Qw31HZ2OVMAxHk0zlFT/E
         elrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=/+BbvcQKPWdX7RD8uRA6lSaBOziDfR36ZlCoTXGgKRE=;
        b=hgmUWjke1PXcCFaqvPAUuRVuqxxHt9aiqhyq3CK6+sNBnUduejEZz5EEr/DmFmZaNK
         vBA9lo4P44PF93R5yFCQ10SYKXtC68bShcnXnUsFQZYfpSkBLMvaagmIV48RAr1kiBmc
         PPiubRFhNwUl5oYCk7RXUzoBJW0ghG6ZAbm796Bw9XrPpqyvoQfOXV+Q5v2o79B8uHdR
         AfayLbtF/6BE1hi39H87Euo17QDZsZtu1zcgDLLawUnJuJrybj+pyf8VFW/72a7udaMg
         sKmJ3kaiJXKhoikAzUs7W4S/BOuN4YAbgJKhUrkUUXExQOJSrvsl3zutE2xFGAz3vIoO
         UnQg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cW1o4dDa;
       spf=pass (google.com: domain of kernel-hardening-return-12054-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12054-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cW1o4dDa;
       spf=pass (google.com: domain of kernel-hardening-return-12054-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12054-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180228183349.GA16336@bombadil.infradead.org>
References: <20180227131338.3699-1-blackzert@gmail.com> <CAGXu5jKF7ysJqj57ZktrcVL4G2NWOFHCud8dtXFHLs=tvVLXnQ@mail.gmail.com>
 <55C92196-5398-4C19-B7A7-6C122CD78F32@gmail.com> <20180228183349.GA16336@bombadil.infradead.org>
From: Daniel Micay <danielmicay@gmail.com>
Date: Wed, 28 Feb 2018 16:02:40 -0500
Message-ID: <CA+DvKQKoo1U7T_iOOLhfEf9c+K1pzD068au+kGtx0RokFFNKHw@mail.gmail.com>
Subject: Re: [RFC PATCH] Randomization of address chosen by mmap.
To: Matthew Wilcox <willy@infradead.org>
Cc: Ilya Smith <blackzert@gmail.com>, Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@suse.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jan Kara <jack@suse.cz>, Jerome Glisse <jglisse@redhat.com>, Hugh Dickins <hughd@google.com>,
	Helge Deller <deller@gmx.de>, Andrea Arcangeli <aarcange@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
	Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593560218941631465?=
X-GMAIL-MSGID: =?utf-8?q?1593680099741439211?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The option to add at least one guard page would be useful whether or
not it's tied to randomization. It's not feasible to do that in
userspace for mmap as a whole, only specific users of mmap like malloc
and it adds significant overhead vs. a kernel implementation. It could
optionally let you choose a minimum and maximum guard region size with
it picking random sizes if they're not equal. It's important for it to
be an enforced gap rather than something that can be filled in by
another allocation. It will obviously help a lot more when it's being
used with a hardened allocator designed to take advantage of this
rather than glibc malloc or jemalloc.

I don't think it makes sense for the kernel to attempt mitigations to
hide libraries. The best way to do that is in userspace, by having the
linker reserve a large PROT_NONE region for mapping libraries (both at
initialization and for dlopen) including a random gap to act as a
separate ASLR base. If an attacker has library addresses, it's hard to
see much point in hiding the other libraries from them. It does make
sense to keep them from knowing the location of any executable code if
they leak non-library addresses. An isolated library region + gap is a
feature we implemented in CopperheadOS and it works well, although we
haven't ported it to Android 7.x or 8.x. I don't think the kernel can
bring much / anything to the table for it. It's inherently the
responsibility of libc to randomize the lower bits for secondary
stacks too.

Fine-grained randomized mmap isn't going to be used if it causes
unpredictable levels of fragmentation or has a high / unpredictable
performance cost. I don't think it makes sense to approach it
aggressively in a way that people can't use. The OpenBSD randomized
mmap is a fairly conservative implementation to avoid causing
excessive fragmentation. I think they do a bit more than adding random
gaps by switching between different 'pivots' but that isn't very high
benefit. The main benefit is having random bits of unmapped space all
over the heap when combined with their hardened allocator which
heavily uses small mmap mappings and has a fair bit of malloc-level
randomization (it's a bitmap / hash table based slab allocator using
4k regions with a page span cache and we use a port of it to Android
with added hardening features but we're missing the fine-grained mmap
rand it's meant to have underneath what it does itself).

The default vm.max_map_count = 65530 is also a major problem for doing
fine-grained mmap randomization of any kind and there's the 32-bit
reference count overflow issue on high memory machines with
max_map_count * pid_max which isn't resolved yet.

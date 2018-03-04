Return-Path: <kernel-hardening-return-12098-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvXDXvWHjpv73LzxCnBqWSJRWNfU3XygYIZoXr3MXJ+QKb9ipBPsGi9JjOIrMK4WLglGqHX
ARC-Seal: i=1; a=rsa-sha256; t=1520197019; cv=none;
        d=google.com; s=arc-20160816;
        b=I/arU7E39A35nhFrI0PgugiRpwvuk+Bk8x/WXiHtSUwjA0Be692cDQ5xg5OUOM6ejP
         X456BpgswsCefaoNj6PqLzsNwT5oxDMdaOzC/UF9cH8+0l+PEFETU5oqqhD+MqrNkSv5
         8PfxPgaoNsjVtECKjo91WaDvBDjBBTZZUFCyP7fIZ3dxNUWh3uTGSU1c8w3WVp2ii9DM
         acbFTYSczIyAriIV3EwckpWhBV39H0DHQHuxzrkRdeonnqHQsz9AV046SFUBNUeuCSwI
         3RVbdqPK6E/g6l20TkbZYcHecmOQWwQNqOVcatIDuJuIc0QVRw10TYWI9ATJrMfXQWDq
         /UfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=kQvtH875Vpy8kX6Rv45uj3TgcKa/rEfy8jfk85cqD7I=;
        b=zCDBTQGm26fvGkqTo4cv0mPDPvDZzpXrCJLuIJUONyxgp/J/gzO+opRz8Mi9MjWvHT
         IE2MUlZpcBQMRc2oD2gH3eGDst1lDx6982m0g+7isiHxnssMvJB1JH8d9T/CLwV9ayuu
         SCFirunsImfkKp7703XVRCh6AXDJnn1VlKbFCFJEUNu+loIsfkhrI3xwhKuEARu40Svs
         iT4ov+UrtOjoF0FwmgCmtTwMJzAY9TDN4PlVH79Gu4x/Jl7nTKBVMERUhXm8u7e+50va
         Xmoepox46+gBkscrrlV3x6z6pWePL8thjNNRBFoYmLE3ulR5aGkdILldM5lZVuaTPv94
         yvdg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=RKlupeSS;
       spf=pass (google.com: domain of kernel-hardening-return-12098-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12098-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=RKlupeSS;
       spf=pass (google.com: domain of kernel-hardening-return-12098-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12098-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sun, 4 Mar 2018 12:56:14 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Daniel Micay <danielmicay@gmail.com>
Cc: Ilya Smith <blackzert@gmail.com>, Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jan Kara <jack@suse.cz>, Jerome Glisse <jglisse@redhat.com>,
	Hugh Dickins <hughd@google.com>, Helge Deller <deller@gmx.de>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>, Linux-MM <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [RFC PATCH] Randomization of address chosen by mmap.
Message-ID: <20180304205614.GC23816@bombadil.infradead.org>
References: <20180227131338.3699-1-blackzert@gmail.com>
 <CAGXu5jKF7ysJqj57ZktrcVL4G2NWOFHCud8dtXFHLs=tvVLXnQ@mail.gmail.com>
 <55C92196-5398-4C19-B7A7-6C122CD78F32@gmail.com>
 <20180228183349.GA16336@bombadil.infradead.org>
 <CA+DvKQKoo1U7T_iOOLhfEf9c+K1pzD068au+kGtx0RokFFNKHw@mail.gmail.com>
 <2CF957C6-53F2-4B00-920F-245BEF3CA1F6@gmail.com>
 <CA+DvKQ+mrnm4WX+3cBPuoSLFHmx2Zwz8=FsEx51fH-7yQMAd9w@mail.gmail.com>
 <20180304034704.GB20725@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180304034704.GB20725@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593560218941631465?=
X-GMAIL-MSGID: =?utf-8?q?1594042109553700244?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 03, 2018 at 07:47:04PM -0800, Matthew Wilcox wrote:
> On Sat, Mar 03, 2018 at 04:00:45PM -0500, Daniel Micay wrote:
> > The main thing I'd like to see is just the option to get a guarantee
> > of enforced gaps around mappings, without necessarily even having
> > randomization of the gap size. It's possible to add guard pages in
> > userspace but it adds overhead by doubling the number of system calls
> > to map memory (mmap PROT_NONE region, mprotect the inner portion to
> > PROT_READ|PROT_WRITE) and *everything* using mmap would need to
> > cooperate which is unrealistic.
> 
> So something like this?
> 
> To use it, OR in PROT_GUARD(n) to the PROT flags of mmap, and it should
> pad the map by n pages.  I haven't tested it, so I'm sure it's buggy,
> but it seems like a fairly cheap way to give us padding after every
> mapping.
> 
> Running it on an old kernel will result in no padding, so to see if it
> worked or not, try mapping something immediately after it.

Thinking about this more ...

 - When you call munmap, if you pass in the same (addr, length) that were
   used for mmap, then it should unmap the guard pages as well (that
   wasn't part of the patch, so it would have to be added)
 - If 'addr' is higher than the mapped address, and length at least
   reaches the end of the mapping, then I would expect the guard pages to
   "move down" and be after the end of the newly-shortened mapping.
 - If 'addr' is higher than the mapped address, and the length doesn't
   reach the end of the old mapping, we split the old mapping into two.
   I would expect the guard pages to apply to both mappings, insofar as
   they'll fit.  For an example, suppose we have a five-page mapping with
   two guard pages (MMMMMGG), and then we unmap the fourth page.  Now we
   have a three-page mapping with one guard page followed immediately
   by a one-page mapping with two guard pages (MMMGMGG).

I would say that mremap cannot change the number of guard pages.
Although I'm a little tempted to add an mremap flag to permit the mapping
to expand into the guard pages.  That would give us a nice way to reserve
address space for a mapping we think is going to expand.

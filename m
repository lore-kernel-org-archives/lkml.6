Return-Path: <kernel-hardening-return-11663-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225fGOL8Qt3uirC1+clDGV9eOpZjhJQGTKYY+13A2XadXjg4UowH54CErrC952HNqkUJAWRx
ARC-Seal: i=1; a=rsa-sha256; t=1518121280; cv=none;
        d=google.com; s=arc-20160816;
        b=rywTcnSJztB7BrXClXK6UcUY3g38DdsFcTFw5NBWmFae3oclaWpgaMn+sLSavWoaLR
         am3B2B2dP725HGUoFkDEPz9O0wX0RQSC1C5g3HwRzYXEi9BP4zMW4H0ZBSx8PeiiyScT
         wSgLDsbjL0/D1lJ23EsKEiGogx3pEc5VjG2yXc+MaXhHNaNm+ZD0peOUZRYWTpPpDoXE
         TPgo7d57G5cWAdzQByjVrPoeSl1zl4B3SfdRe5tV3E0rjQQFZZQZ+M3QhwVsK4YbONgz
         HbcHpiaaErDl4LaHv0uROjfI6e7tvB2UZ0hrqkOH67LczDKYC0OBHQwGU0lz/HXrfsZ3
         RScw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=bweFLzcMqzMpY0xszSwGYT3pq+51QYYxSnfev6xSBp4=;
        b=h5jQ+8l9cGqWgYmu9YF8zYJti17UjEDciDeFugeRmeLtyaCbhYwaXLXqaYWcxF2nZ4
         hqbSwuy7yW+yrCx23zR9qolwHFYkrvSYvxhW03jYrDC0FsSd6bFb0/YPP0qviPQQNTEu
         ZkTqP5W7B3+4KNz2VXEhtadl356zsRmejU5Mjw/VHxt3pOzPOBYn2Dc/TEBHUFgksNJV
         mH8ajRTuVY6tirt4dnVFnOzMU2byYsgdXBQgiwlVIgR9MJVoQYDHJDxly2Beft1po2d6
         fPNox7081DZAqqCbDDvE7Hvnu4rsGQC26BORQ+gcy/qSTP9gjqa/KF0tabCTCzCpGtMz
         ugNw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=pPe0SWS6;
       spf=pass (google.com: domain of kernel-hardening-return-11663-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11663-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=pPe0SWS6;
       spf=pass (google.com: domain of kernel-hardening-return-11663-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11663-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Feb 2018 12:21:00 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Daniel Micay <danielmicay@gmail.com>
Cc: Jann Horn <jannh@google.com>, linux-mm@kvack.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	kernel list <linux-kernel@vger.kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC] Warn the user when they could overflow mapcount
Message-ID: <20180208202100.GB3424@bombadil.infradead.org>
References: <20180208021112.GB14918@bombadil.infradead.org>
 <CAG48ez2-MTJ2YrS5fPZi19RY6P_6NWuK1U5CcQpJ25=xrGSy_A@mail.gmail.com>
 <CA+DvKQLHDR0s=6r4uiHL8kw2_PnfJcwYfPxgQOmuLbc=5k39+g@mail.gmail.com>
 <20180208185648.GB9524@bombadil.infradead.org>
 <CA+DvKQLHcFc3+kW_SnD6hs53yyD5Zi+uAeSgDMm1tRzxqy-Opg@mail.gmail.com>
 <20180208194235.GA3424@bombadil.infradead.org>
 <CA+DvKQKba0iU+tydbmGkAJsxCxazORDnuoe32sy-2nggyagUxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+DvKQKba0iU+tydbmGkAJsxCxazORDnuoe32sy-2nggyagUxQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591796976786547518?=
X-GMAIL-MSGID: =?utf-8?q?1591865539390872945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 08, 2018 at 02:48:52PM -0500, Daniel Micay wrote:
> I guess it could saturate and then switch to tracking the count via an
> object pointer -> count mapping with a global lock? Whatever the
> solution is should probably be a generic one since it's a recurring
> issue.

I was thinking of saturating _mapcount at 2 billion (allowing _refcount
the extra space to go into the 2-3 billion range).  Once saturated,
disallow all attempts at mapping it until _mapcount has gone below 2
billion again.  We can walk the page->mapping->i_mmap tree and find
tasks with more than, say, 10 mappings each, and kill them.

Now that I think about it, though, perhaps the simplest solution is not
to worry about checking whether _mapcount has saturated, and instead when
adding a new mmap, check whether this task already has it mapped 10 times.
If so, refuse the mapping.

Now we can argue that since pid_max is smaller than 400 million that
_mapcount will never overflow, and so we don't need to check it.
Convincing argument?

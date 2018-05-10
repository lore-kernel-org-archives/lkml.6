Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZpEqxN6K598aUtbOatjuiy0K448kG2aUBe7DgLSV8Htvg1IOUJk5SRq2+wbqyuH8R0RkxC9
ARC-Seal: i=1; a=rsa-sha256; t=1525972475; cv=none;
        d=google.com; s=arc-20160816;
        b=EAcgY1tUe+aVGZijm9qJQf4PqLRRenKFcGaONKaqZH2luvjWbtKXx1ULHRQW1pqcqS
         pQMl3H15NyFWPThxFP5Z0ZaiVigl/snO2F1xwKbQfhdkgH+Fhot+ohkNw2mo/P0JH2Qp
         aCQwAJg5jPE9oswqfZgCNXFCc2P6sznkq1wDlpAVBW16yWjT4Q6DlBpeVCfFPHdc1k2m
         D62JtnJVB1Jlh+2OPgWMGNuKAJj5AxcYE1oVHuB31nQiscYBCEftRmVpvNppmJB+A24Z
         OYwcY5trmoKFPuN14v6GrlWPAIzEvzM8dCON1MgeGNxC281HylUt0boAtar38TWQ17K7
         73Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=6Xcj5W8RKh+lV/F5zwnITUDFNL1EyYbc0yz54yqwA14=;
        b=uMuDRewPA66ZjBMNiWRZk8iBEpg+l71XVAOWVx9P35NLMMEKZzy/1Py2TeuULnN0p8
         qhaYfQJWHFmvxVX3Nt+rdx5YTgKIV34yBHUweiKVn7az7/Z/6kUgy4okHI1V9u0Ampll
         PWb37e0uevh0xOddPum0/7ivrfEyNV5ekWYh1MmsixCjkPqrQ0BS4BYF3Hl/hd88ToSj
         3tGAgz52ct3LwlEKnLuu74+4n40AqVtaW+0WxqmW353yaFdeJx/ZCbdatbNLXdiahf3b
         /n5oOk3NC/9kV8LiwlU8I0LgcI4C6G64CCi5XJxDkF0+3jNNnjeBlxXy4TgAw4Ia22aH
         RdEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 10 May 2018 17:14:32 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	Linux MM <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] mm: provide a fallback for PAGE_KERNEL_EXEC for
 architectures
Message-ID: <20180510171432.GC27853@wotan.suse.de>
References: <20180510014447.15989-1-mcgrof@kernel.org>
 <20180510014447.15989-3-mcgrof@kernel.org>
 <CAMuHMdUJTKqqWzFi594_y_F1HdONr3+FOSTzg-n0ogoroFUqpA@mail.gmail.com>
 <20180510153355.GB27853@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510153355.GB27853@wotan.suse.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600039619823069048?=
X-GMAIL-MSGID: =?utf-8?q?1600098114277905192?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 03:33:55PM +0000, Luis R. Rodriguez wrote:
> On Thu, May 10, 2018 at 09:45:56AM +0200, Geert Uytterhoeven wrote:
> > Hi Luis,
> > 
> > On Thu, May 10, 2018 at 3:44 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > > Some architectures just don't have PAGE_KERNEL_EXEC. The mm/nommu.c
> > > and mm/vmalloc.c code have been using PAGE_KERNEL as a fallback for years.
> > > Move this fallback to asm-generic.
> > >
> > > Architectures which do not define PAGE_KERNEL_EXEC yet:
> > >
> > >   o alpha
> > >   o mips
> > >   o openrisc
> > >   o sparc64
> > 
> > The above list seems to be far from complete?
> 
> I'll look again. If you know of others lemme know.

You know, better just ignore documenting these. I'll respin without that.

  Luis

Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZoJ7NE2MZ/HKGDxYEG80qCPYMJ7Z3HTFNcrrO4n9ddqwQxrPdUt8H4ruPhnbAOIZKMI5S5p
ARC-Seal: i=1; a=rsa-sha256; t=1525966437; cv=none;
        d=google.com; s=arc-20160816;
        b=KcFASpsOC9x9pZ+g0auhfwBXIYfWz8q2tdgWO4EpnnT2O8ILyj78zG1rlmBkMYBtz4
         Y89Km3gWhr617EXFP5Y1aHrqc+J7p+O8bkahqJPIpyY9PgNv78CkVQMzahBDlO5i9XlG
         Th4ivoJ+gJJmAOpBx7mok+WivCKHjIzAEs0E3a0vouzNK20SBj4kECa4Lik1KBYV6a3W
         me15En8O+yyY8F6gouXaC/6SKx9+7KC66a92porrk1QQ7E/Ljsl+Ft+v/o3JAcmcBhaJ
         pPtpgfIzoe7q3KRNITyUeEze2xOBgUlxFIZ/wT195+qXeyRjk726pnHScHuKyTzTL4OR
         P1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=TELYaoGkM8+uaL92qx2yJKKmwNCtvmDnsI5bIp7c2jQ=;
        b=m7LAwWPTaC+VqIPUYou6axL2Ihiw4kknYVC8Gcp5Hr89q1smg7SdWsUSW4VS3ShC6s
         RuRdYGYghJEy2splcb7cHSSNgSr5Qt6z6vCTGuckcvwSEjNpqgveOw7uBZp0Qn4DIKzI
         zhxzG8rAdjL4vDzxFSr+cI/fXafRy+gwv+w/gDhHUW62S1dGPhncRnTcnSbIzj0a6JjY
         /YaUYnnY539Fvmc88BEatn6V7aEAskHH+7inhJZ3F9cBwsGBAu7HRKZfFHDTW+TVF0JM
         S8M3EDPyGFjifwTuRLSUY0XjJmrI5cFsKZf6rNlSzb4fFPoTfOR3ArXBukwxOfKnGxq2
         Irfw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 10 May 2018 15:33:55 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	Linux MM <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] mm: provide a fallback for PAGE_KERNEL_EXEC for
 architectures
Message-ID: <20180510153355.GB27853@wotan.suse.de>
References: <20180510014447.15989-1-mcgrof@kernel.org>
 <20180510014447.15989-3-mcgrof@kernel.org>
 <CAMuHMdUJTKqqWzFi594_y_F1HdONr3+FOSTzg-n0ogoroFUqpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUJTKqqWzFi594_y_F1HdONr3+FOSTzg-n0ogoroFUqpA@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600039619823069048?=
X-GMAIL-MSGID: =?utf-8?q?1600091782944484904?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 09:45:56AM +0200, Geert Uytterhoeven wrote:
> Hi Luis,
> 
> On Thu, May 10, 2018 at 3:44 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > Some architectures just don't have PAGE_KERNEL_EXEC. The mm/nommu.c
> > and mm/vmalloc.c code have been using PAGE_KERNEL as a fallback for years.
> > Move this fallback to asm-generic.
> >
> > Architectures which do not define PAGE_KERNEL_EXEC yet:
> >
> >   o alpha
> >   o mips
> >   o openrisc
> >   o sparc64
> 
> The above list seems to be far from complete?

I'll look again. If you know of others lemme know.

  Luis

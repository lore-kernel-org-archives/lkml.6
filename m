Return-Path: <catalin.marinas@arm.com>
X-Google-Smtp-Source: AB8JxZrzIMxiY0aAwa8BMg77pv61GXL4P4zoQMDO8Hm6Wg0G2jX7gO0Gwn3pkdLqyaOgPgUG3THJ
ARC-Seal: i=1; a=rsa-sha256; t=1525792306; cv=none;
        d=google.com; s=arc-20160816;
        b=HCgQcxWImCDZ7yn7jo1CFVVYeX+tqCase6PYdgRU4uQwP4Tntme6OKNKjG/uKHfNfX
         QKMVPtIS9DpQ0LX63ygS5mQ3jfe0leUKV8LpOYcF2dwhjqBHbOjXnKpV9pcZkUzkQ27N
         x82jrphYer/uefmFlTku5dHiEr6i4Bzt1DiKd+fRIHaZAMNAmkHTuO5sBcaUFXuoTBO0
         eovictizQyMZdHJ/UDumhjw821XtMFWm0lcNZmNdnEVDrl1CiQSDd7UuLAzZJeVdO0hF
         z8RwDDaB1CWEeU3/crfntixBESFMPUUvByJmBWtyoajXSVjeaojbrjtt4BAz8rFxKHL0
         JaIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=DCt1DcJP3Fd8Wf1Hpucu4zY81sSrheJ78y+rzhDR4PQ=;
        b=g8zBekZSHg9q/ITKRSK6AFk8fCvzy5QITgS8rlzjnlyMw9GKPXkzmZcx4VHBEgE9s/
         UDAdFm/hWbKyTmacI0iSkj6oMMLonOhvLTHAyFRhqYa3IZtbUAcMv0AO1cB9KK2+EDUK
         DbCGkRCclofsxMhGkcGZLKlBnMxYAqOiiDQkhm2Q43bxlG/kKdTdwhAZREzMJ7twbAkx
         6V8EJvU5kfiXU5NgKEtCjm1FAgoFFfBEhaJ/ZRfF5PTRdZjq6zIZovRTYy5/ZGldkUZu
         Vn3kYLwKauWkmKnF6Ux1SJq6IkMuEfe3tUikfucFJlD2RoWeVNqtl3WgZ7m3UMJmVNrF
         cHQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of catalin.marinas@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=catalin.marinas@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of catalin.marinas@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=catalin.marinas@arm.com
Date: Tue, 8 May 2018 16:11:38 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Andrey Konovalov <andreyknvl@google.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-doc@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Evgeniy Stepanov <eugenis@google.com>,
	Kees Cook <keescook@chromium.org>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
	Lee Smith <Lee.Smith@arm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Kostya Serebryany <kcc@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	James Morse <james.morse@arm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <zi.yan@cs.rutgers.edu>
Subject: Re: [PATCH 4/6] mm, arm64: untag user addresses in mm/gup.c
Message-ID: <20180508151137.zguepljs3pa7xv5g@armageddon.cambridge.arm.com>
References: <cover.1524077494.git.andreyknvl@google.com>
 <0db34d04fa16be162336106e3b4a94f3dacc0af4.1524077494.git.andreyknvl@google.com>
 <20180426174714.4jtb72q56w3xonsa@armageddon.cambridge.arm.com>
 <CAAeHK+zY8p9E4FZa7mbdgR=wR0u-RDS552dn=h9fKRC-ArYLdw@mail.gmail.com>
 <20180502153645.fui4ju3scsze3zkq@black.fi.intel.com>
 <CAAeHK+yTbmZfkeNbqbo+J90zsjsM99rwnYBGfQBxphHMMfgD7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+yTbmZfkeNbqbo+J90zsjsM99rwnYBGfQBxphHMMfgD7A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598111199483906995?=
X-GMAIL-MSGID: =?utf-8?q?1599909193666249108?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 07:25:17PM +0200, Andrey Konovalov wrote:
> On Wed, May 2, 2018 at 5:36 PM, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> > On Wed, May 02, 2018 at 02:38:42PM +0000, Andrey Konovalov wrote:
> >> > Does having a tagged address here makes any difference? I couldn't hit a
> >> > failure with my simple tests (LD_PRELOAD a library that randomly adds
> >> > tags to pointers returned by malloc).
> >>
> >> I think you're right, follow_page_mask is only called from
> >> __get_user_pages, which already untagged the address. I'll remove
> >> untagging here.
> >
> > It also called from follow_page(). Have you covered all its callers?
> 
> Oh, missed that, will take a look.
> 
> Thinking about that, would it make sense to add untagging to find_vma
> (and others) instead of trying to cover all find_vma callers?

I don't think adding the untagging to find_vma() is sufficient. In many
cases the caller does a subsequent check like 'start < vma->vm_start'
(see sys_msync() as an example, there are a few others as well). What I
did in my tests was a WARN_ON_ONCE() in find_vma() if the address is
tagged.

-- 
Catalin
